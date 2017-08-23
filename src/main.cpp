#include <iostream>
#include <fstream>
#include <sstream>
#include <cstring>
#include <cstdlib>
#include <vector>
#include "assertions.h"
#include "parser.h"
#include "resetgenerator.h"
#include "triggergenerator.h"
#include "countergenerator.h"
#include "detectorgenerator.h"
#include "readlog.h"

using namespace std;

#define PAUSE printf("Press Enter key to continue..."); fgetc(stdin);

typedef struct assertions assertions;

int main(int argc, char* argv[])
{
	char *inFilter = argv[1];
	char *outFilter = argv[3];
	if(argc != 5 || (inFilter[0] != '-' && inFilter[1] != 'i') || (outFilter[0] != '-' && outFilter[1] != 'o'))
	{
		cout << "usage: ./main -i fsm.v -o input_sequence" << endl;
		system("rm -rf verilogs");
		system("rm -rf blifs");
		system("rm -rf logs");
		system("rm -rf scripts");
		return 1;
	}
	vector<assertions*> vassertions;
	vector<string> vTriggers, vCounters, vDetectors; //Adding circuit
	string declarations, fsm, assign = "assign", always = "always @(*) begin\n", decx = "reg", reset;
	if(!parse(argv[2], fsm, declarations, vassertions))
	{
		cout << "cannot read input file \"" << argv[2] << "\": No such file" << endl;
		system("rm -rf verilogs");
		system("rm -rf blifs");
		system("rm -rf logs");
		system("rm -rf scripts");
		return 1;
	}
	system("mkdir verilogs");
	system("mkdir blifs");
	system("mkdir logs");
	system("mkdir scripts");
	int nMonitors = 0;
	reset = resetGenerator(declarations);
	
	for(vector<assertions*>::iterator a = vassertions.begin(); a != vassertions.end(); a++)
	{
		cout << endl << "Start dealing with assertion " << (*a)->id << endl;  //First, use "pdr" to check whether this assertion can fail
		vector<assertions*> vassertions_ = vassertions;
		string declarations_, fsm_, trigger, counter, detector, reset, reset_; //Adding circuit
		parse(argv[2], fsm_, declarations_, vassertions_);
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
		trigger = triggerGenerator((**a), declarations_);
		counter = counterGenerator((**a), declarations_);
		detector = detectorGenerator((**a), declarations_);
		reset_ = resetGenerator(declarations_);

		cerr << "Creating .v file......";
		ofstream fout(verilogFileName);
		fout << declarations_;
		fout << fsm_;
		fout << reset_;
		fout << trigger;
		fout << counter;
		fout << detector;
		fout << "endmodule\n";
		fout.close();
		cout << "done." << endl;

		/*------------------Generate yosys script to synthesis all .v files------------------*/
		fout.open("scripts/yosys.sh");
		fout << "read_verilog verilogs/cadb160_asser" << Id << ".v" << endl;
		fout << "hierarchy; proc; fsm; techmap;" << endl;
		fout << "write_blif blifs/cadb160_asser" << Id << ".blif" << endl;
		fout.close();

		/*------------------Generate abc script to solve all .blif files------------------*/
		fout.open("scripts/abcPdr.sh");
		fout << "read blifs/cadb160_asser" << Id << ".blif" << endl;
		fout << "strash" << endl;
		fout << "pdr -L logs/cadb160_asser" << Id << ".log" << endl;
		fout.close();

		vector<vector<bool> > inputSeq, inputSeq_;
		
		/*------------------Yosys synthesis------------------*/
		cerr << "Creating .blif file (yosys)......";
		system("./yosys -q -s scripts/yosys.sh");
		cout << "done." << endl;

		/*------------------Abc pdr cmd------------------*/
		cerr << "Running \"pdr\" cmd (abc)......";
		system("./abc -f scripts/abcPdr.sh > /dev/null");
		cout << "done." << endl;
		
		if(readLog(blifFileName, logFileName, inputSeq_)) //if this assertion can fail --> take the monitor circuit
		{
			// if((*a)->id == 4 || (*a)->id == 7 || (*a)->id == 10 || (*a)->id == 15 || (*a)->id == 17 || (*a)->id == 18) continue;
			/*------------------Count the number of monitors------------------*/
			nMonitors++;
			/*------------------Store this monitor------------------*/
			vTriggers.push_back(trigger);
			vCounters.push_back(counter);
			vDetectors.push_back(detector);
			size_t found = declarations_.find("output reg");
			while(found != string::npos)
			{
				declarations_.replace(found, 8, "r");
				found = declarations_.find("output reg", found + 1);
			}
			size_t found1 = declarations_.find("reg [1:0]"), found2 = declarations_.find("parameter");
			declarations.insert(declarations.find("parameter"), declarations_.substr(found1, found2 - found1));
			declarations.insert(declarations.find("in);"), "PPI");
			declarations.insert(declarations.find("in);"), Id);
			declarations.insert(declarations.find("in);"), ", ");
			assign.append("&");
			assign.append("x");
			assign.append(Id);
			always.append("    if(z");
			always.append(Id);
			always.append("==1) x");
			always.append(Id);
			always.append("=1;\n");
			always.append("    else x");
			always.append(Id);
			always.append("=0;\n");
			decx.append(", x");
			decx.append(Id);
		}
		else cout << "assertion" << (*a)->id << " is unsat." << endl;
		
	}

	/*------------------Write a big .v file with all monitors and fsm circuits------------------*/
	cout << endl << "Start dealing with all assertions " << endl;
	assign.replace(assign.find("&"), 1, " X = ");
	decx.replace(decx.find(","), 2, " ");
	assign.append(";\n");
	decx.append(";\n");
	always.append("end\n");
	declarations.insert(declarations.find("in);"), "X, ");
	declarations.insert(declarations.find("parameter"), decx);
	declarations.insert(declarations.find("parameter"), assign);
	declarations.insert(declarations.find("parameter"), always);
	declarations.insert(declarations.find(assign), "output X;\n");
	cerr << "Creating .v file......";
	ofstream fout("verilogs/cadb160.v");
	fout << declarations;
	fout << fsm;
	fout << reset;
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

	/*------------------Generate yosys script to synthesis all .v files------------------*/
	fout.open("scripts/yosys.sh");
	fout << "read_verilog verilogs/cadb160.v" << endl;
	fout << "hierarchy; proc; fsm; techmap;" << endl;
	fout << "write_blif blifs/cadb160.blif" << endl;
	fout.close();

	/*------------------Generate abc script to solve all .blif files------------------*/
	fout.open("scripts/abcInt.sh");
	fout << "read blifs/cadb160.blif" << endl;
	fout << "strash" << endl;
	fout << "int -L logs/cadb160.log" << endl;
	fout.close();

	/*------------------(.v) Yosys synthesis (.blif)------------------*/
	cerr << "Creating .blif file (yosys)......";
	system("./yosys -q -s scripts/yosys.sh");
	cout << "done." << endl;

	/*------------------(.blif) Abc int cmd (.log)------------------*/
	cerr << "Running \"int\" cmd (abc)......";
	system("./abc -f scripts/abcInt.sh > /dev/null");
	cout << "done." << endl;

	/*------------------(.log) Write the input sequence (input_sequence)------------------*/
	vector<vector<bool> > inputSeq;
	fout.open(argv[4]);
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
	} else fout << "input_sequence" << " is UNSAT." << endl;
	fout.close();

	system("rm -rf verilogs");
	system("rm -rf blifs");
	system("rm -rf logs");
	system("rm -rf scripts");

	for (vector<assertions*>::iterator i = vassertions.begin(); i != vassertions.end(); ++i)
		delete *i;
	
	return 0;
}
