#include <iostream>
#include <fstream>
#include <sstream>
#include <cstring>
#include <cstdlib>
#include <vector>
#include "assertions.h"
#include "parser.h"
#include "triggergenerator.h"
#include "countergenerator.h"
#include "detectorgenerator.h"
#include "readlog.h"

using namespace std;

#define PAUSE printf("Press Enter key to continue..."); fgetc(stdin);

typedef struct assertions assertions;
int createScript(string Id, string script);

int main(int argc, char* argv[])
{
	// vector<vector<bool> > inputSeqq;
	// 	readLog(argv[1], argv[2], inputSeqq);
	// 	return 0;
	system("rm -f verilogs/*");
	system("rm -f blifs/*");
	system("rm -f logs/*");
	system("rm -f outputs/*");
	system("rm -f scripts/*");
	vector<assertions*> vassertions;
	vector<string> vTriggers, vCounters, vDetectors; //Adding circuit
	string declarations, fsm, assign = "assign", decx = "wire", input = "input";
	parse(argv[1], fsm, declarations, vassertions);
	int nMonitors = 0;
	
	for(vector<assertions*>::iterator a = vassertions.begin(); a != vassertions.end(); a++)
	{
		cout << endl << "Start dealing with assertion " << (*a)->id << endl;  //First, use "pdr" to check whether this assertion can fail
		vector<assertions*> vassertions_ = vassertions;
		string declarations_, fsm_, trigger, counter, detector; //Adding circuit
		parse(argv[1], fsm_, declarations_, vassertions_);
		string Id;
		stringstream ss;
		ss << (*a)->id;
		ss >> Id;
		declarations_.insert(declarations_.find(")"), ", PPI");
		declarations_.insert(declarations_.find(")"), Id);
		declarations_.insert(declarations_.find(")"), ", z");
		declarations_.insert(declarations_.find(")"), Id);

		/*------------------Generate .v file name------------------*/
		string temp = "verilogs/cadb160_asser";
		temp.append(Id);
		temp.append(".v");
		char verilogFileName[1024];
		strncpy(verilogFileName, temp.c_str(), sizeof(verilogFileName));
		verilogFileName[sizeof(verilogFileName) - 1] = 0;

		/*------------------Generate .log file name------------------*/
		string temp1 = "logs/cadb160_asser";
		temp1.append(Id);
		temp1.append(".log");
		char logFileName[1024];
		strncpy(logFileName, temp1.c_str(), sizeof(logFileName));
		logFileName[sizeof(logFileName) - 1] = 0;

		/*------------------Generate .blif file name------------------*/
		string temp2 = "blifs/cadb160_asser";
		temp2.append(Id);
		temp2.append(".blif");
		char blifFileName[1024];
		strncpy(blifFileName, temp2.c_str(), sizeof(blifFileName));
		blifFileName[sizeof(blifFileName) - 1] = 0;

		/*------------------Generate .out file name------------------*/
		/*string temp3 = "outputs/cadb160_asser";
		temp3.append(Id);
		temp3.append(".out");
		char outFileName[1024];
		strncpy(outFileName, temp3.c_str(), sizeof(outFileName));
		outFileName[sizeof(outFileName) - 1] = 0;*/

		/*------------------Generate the Monitor of this assertion(should be stored in a vector)------------------*/
		declarations_.insert(declarations_.find("parameter"), "input PPI");
		declarations_.insert(declarations_.find("parameter"), Id);
		declarations_.insert(declarations_.find("parameter"), ";\n");
		trigger = triggerGenerator((**a), declarations_);
		counter = counterGenerator((**a), declarations_);
		detector = detectorGenerator((**a), declarations_);
		declarations_.insert(declarations_.find("parameter"), "output z");
		declarations_.insert(declarations_.find("parameter"), Id);
		declarations_.insert(declarations_.find("parameter"), ";\n");

		cerr << "Creating .v file......";
		ofstream fout(verilogFileName);
		fout << declarations_;
		fout << fsm_;
		fout << trigger;
		fout << counter;
		fout << detector;
		fout << "endmodule\n";
		fout.close();
		cout << "done." << endl;

		/*------------------Generate script files------------------*/
		createScript(Id, "yosys");
		createScript(Id, "abcToBlif");
		createScript(Id, "abcPdr");
		
		/*fout.open("scripts/abcInt.sh");
		fout << "read blifs/cadb160_asser" << Id << ".blif" << endl;
		fout << "strash" << endl;
		fout << "int -L logs/cadb160_asser" << Id << ".log" << endl;
		fout.close();*/

		vector<vector<bool> > inputSeq, inputSeq_;
		
		/*------------------Yosys synthesis------------------*/
		cerr << "Creating .blif file (yosys)......";
		system("./yosys -q -s scripts/yosys.sh");
		cout << "done." << endl;

		/*------------------Abc to blif------------------*/
		cerr << "Rewriting .blif files (abc)......";
		system("./abc -f scripts/abcToBlif.sh > /dev/null");
		cout << "done." << endl;

		/*------------------Removing redundant latches------------------*/
		removeLatch(blifFileName);

		/*------------------Abc pdr cmd------------------*/
		cerr << "Running \"pdr\" cmd (abc)......";
		system("./abc -f scripts/abcPdr.sh > /dev/null");
		cout << "done." << endl;
		
		if(readLog(blifFileName, logFileName, inputSeq_)) //if this assertion can fail --> take the monitor circuit
		{
			// if((*a)->id == 4 || (*a)->id == 7 || (*a)->id == 10 || (*a)->id == 15 || (*a)->id == 17 || (*a)->id == 18) continue;
			//Count the number of monitors
			nMonitors++;
			//Store this monitor
			vTriggers.push_back(trigger);
			vCounters.push_back(counter);
			vDetectors.push_back(detector);
			size_t found1 = declarations_.find("reg la"), found2 = declarations_.find("output");
			declarations.insert(declarations.find("parameter"), declarations_.substr(found1, found2 - found1));
			declarations.insert(declarations.find("in);"), "PPI");
			declarations.insert(declarations.find("in);"), Id);
			declarations.insert(declarations.find("in);"), ", ");
			input.append(", PPI");
			input.append(Id);
			assign.append(" & ");
			assign.append("z");
			assign.append(Id);
			decx.append(", z");
			decx.append(Id);

			/*cerr << "Running \"int\" cmd (abc)......";
			system("./abc -f scripts/abcInt.sh > /dev/null");
			cout << "done." << endl;*/
		}
		else cout << "assertion" << (*a)->id << " is unsat." << endl;
		
		/*fout.open(outFileName);
		if(readLog(blifFileName, logFileName, inputSeq))
		{
			for(int i = 0; i < inputSeq.size(); i++)
			{
				for(int j = 0; j < inputSeq[i].size(); j++)
				{
					fout << inputSeq[i][j];
				}
				fout << endl;
			}
			fout << endl;
		} else fout << outFileName << " is UNSAT." << endl;
		fout.close();*/

	}

	/*------------------Write a big .v file with all monitors and fsm circuits------------------*/
	string Id = "-1";
	cout << endl << "Start dealing with all assertions " << endl;
	assign.replace(assign.find("&"), 1, " Z =");
	input.replace(input.find(","), 2, " ");
	decx.replace(decx.find(","), 2, " ");
	assign.append(";\n");
	input.append(";\n");
	decx.append(";\n");
	declarations.insert(declarations.find("in);"), "Z, ");
	declarations.insert(declarations.find("parameter"), input);
	declarations.insert(declarations.find("parameter"), decx);
	declarations.insert(declarations.find("parameter"), assign);
	declarations.insert(declarations.find(assign), "output Z;\n");
	cerr << "Creating .v file......";
	ofstream fout("verilogs/cadb160.v");
	fout << declarations;
	fout << fsm;
	for(int i = 0; i < nMonitors; i++)
	{
		fout << vTriggers[i];
		fout << vCounters[i];
		fout << vDetectors[i];
		fout << endl;
	}
	fout << "endmodule\n";
	fout.close();
	cout << "done." << endl;

	/*------------------Generate script files------------------*/
	createScript(Id, "yosys");
	createScript(Id, "abcToBlif");
	createScript(Id, "abcInt");

	/*------------------(.v) Yosys synthesis (.blif)------------------*/
	cerr << "Creating .blif file (yosys)......";
	system("./yosys -q -s scripts/yosys.sh");
	cout << "done." << endl;

	/*------------------(.blif) Abc to blif (.blif)------------------*/
	cerr << "Rewriting .blif files (abc)......";
	system("./abc -f scripts/abcToBlif.sh > /dev/null");
	cout << "done." << endl;

	/*------------------Removing redundant latches------------------*/
	removeLatch("blifs/cadb160.blif");

	/*------------------(.blif) Abc int cmd (.log)------------------*/
	cerr << "Running \"int\" cmd (abc)......";
	system("./abc -f scripts/abcInt.sh > /dev/null");
	cout << "done." << endl;

	/*------------------(.log) Write the input sequence (input_sequence)------------------*/
	vector<vector<bool> > inputSeq;
	fout.open("outputs/input_sequence");
	if(readLog("blifs/cadb160.blif", "logs/cadb160.log", inputSeq))
	{
		for(int i = 0; i < inputSeq.size(); i++)
		{
			for(int j = 0; j < inputSeq[i].size(); j++)
			{
				fout << inputSeq[i][j];
			}
			fout << endl;
		}
		fout << endl;
	} else fout << "outputs/input_sequence" << " is UNSAT." << endl;
	fout.close();

	for (vector<assertions*>::iterator i = vassertions.begin(); i != vassertions.end(); ++i)
		delete *i;
	
	return 0;
}

int createScript(string Id, string script)
{
	ofstream fout;

	if(script == "yosys")
	{
		fout.open("scripts/yosys.sh");
		if(Id != "-1") fout << "read_verilog verilogs/cadb160_asser" << Id << ".v" << endl;	
		else fout << "read_verilog verilogs/cadb160.v" << endl;
		fout << "proc; opt; techmap -map techlibs/adff2dff.v; techmap -map techlibs/techmap.v;" << endl;
		if(Id != "-1") fout << "write_blif blifs/cadb160_asser" << Id << ".blif" << endl;
		else fout << "write_blif blifs/cadb160.blif" << endl;		
	}

	else if(script == "abcToBlif")
	{
		fout.open("scripts/abcToBlif.sh");
		if(Id != "-1") fout << "read blifs/cadb160_asser" << Id << ".blif" << endl;
		else fout << "read blifs/cadb160.blif" << endl;
		fout << "strash" << endl;
		if(Id != "-1") fout << "write blifs/cadb160_asser" << Id << ".blif" << endl;
		else fout << "write blifs/cadb160.blif" << endl;
	}

	else if(script == "abcPdr")
	{
		fout.open("scripts/abcPdr.sh");
		if(Id != "-1") fout << "read blifs/cadb160_asser" << Id << ".blif" << endl;
		else fout << "read blifs/cadb160.blif" << endl;
		fout << "strash" << endl;
		if(Id != "-1") fout << "pdr -L logs/cadb160_asser" << Id << ".log" << endl;
		else fout << "pdr -L logs/cadb160_asser" << Id << ".log" << endl;
	}

	else if(script == "abcInt")
	{
		fout.open("scripts/abcInt.sh");
		if(Id != "-1") fout << "read blifs/cadb160_asser" << Id << ".blif" << endl;
		else fout << "read blifs/cadb160.blif" << endl;
		fout << "strash" << endl;
		if(Id != "-1") fout << "int -L logs/cadb160_asser" << Id << ".log" << endl;
		else fout << "int -L logs/cadb160.log" << endl;
	}

	fout.close();

	return 0;
}
