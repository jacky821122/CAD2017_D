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
bool verbose = false;

typedef struct assertions assertions;
int createScript(string Id, string script);
string createFileName(string id, string name);

int main(int argc, char* argv[])
{
	int bound = -1, single = -1, fsmFileArg = 1;
	vector<assertions*> vassertions;
	vector<string> vTriggers, vCounters, vDetectors; //Adding circuit
	string declarations, fsm, assign = "assign", decx = "wire", input = "input";
	string fsmFile;
	bool readFromArg = true;
	if(string(argv[1]) == "-version") 
	{
		cout << "Final version." << endl;
		return 0;
	}
	if(string(argv[1]) == "-p")
	{
		parse(argv[2], fsm, declarations, vassertions);
		return 0;
	}
	else if(string(argv[1]) == "-r")
	{
		ofstream fout;
		vector<vector<bool> > inputSeq;
		string outFileName = createFileName(string(argv[2]), "output");
		string blifFileName = createFileName(string(argv[2]), "blif");
		string logFileName = createFileName(string(argv[2]), "log");
		fout.open(outFileName.c_str());

		if(readLog(blifFileName.c_str(), logFileName.c_str(), inputSeq))
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
		} else fout << argv[2] << " is UNSAT." << endl;
		fout.close();
		return 0; 
	}
	else if(string(argv[1]) == "-c")
	{
		stringstream ss;
		ss << string(argv[2]);
		ss >> bound;
		fsmFile = createFileName(string(argv[3]), "fsm");
		readFromArg = false;
	}
	else if(string(argv[1]) == "-n")
	{
		stringstream ss;
		ss << string(argv[2]);
		ss >> single;
		fsmFile = createFileName(string(argv[3]), "fsm");
		readFromArg = false;
	}
	else if(string(argv[1]) == "-i")
	{
		if(argc != 5)
		{
			cout << "Usage: ./main –i fsm.v –o input_sequence" << endl;
			return 1;
		}
		string temp = string(argv[2]);
		vector<char> vfsmFile = vector<char>(temp.begin(), temp.end());
		vfsmFile.push_back('\0');
		fsmFile = &vfsmFile[0];
		readFromArg = false;
	}
	else
	{
		ifstream test(argv[1]);
		if(!test.is_open())
		{
			cout << "Usage: ./main –i fsm.v –o input_sequence" << endl;
			return 1;
		}
	}
	string fsmFileName = (readFromArg)? argv[1] : fsmFile;

	system("rm -f verilogs/*");
	system("rm -f blifs/*");
	system("rm -f logs/*");
	//system("rm -f outputs/*");
	system("rm -f scripts/*");
	if(!parse(fsmFileName.c_str(), fsm, declarations, vassertions)) return 1;
	int nMonitors = 0;
	
	for(vector<assertions*>::iterator a = vassertions.begin(); a != vassertions.end(); a++)
	{
		if(bound != -1)
		{
			if((*a)->id > bound)
				continue;
		}

		if(single != -1)
		{
			if((*a)->id != single)
				continue;
		}

		if(verbose) cout << endl << "Start dealing with assertion " << (*a)->id << endl;  //First, use "pdr" to check whether this assertion can fail
		vector<assertions*> vassertions_ = vassertions;
		string declarations_, fsm_, trigger, counter, detector; //Adding circuit
		if(!parse(fsmFileName.c_str(), fsm_, declarations_, vassertions_)) return 1;
		string Id;
		stringstream ss;
		ss << (*a)->id;
		ss >> Id;
		declarations_.insert(declarations_.find(")"), ", PPI");
		declarations_.insert(declarations_.find(")"), Id);
		declarations_.insert(declarations_.find(")"), ", z");
		declarations_.insert(declarations_.find(")"), Id);

		/*------------------Generate file names------------------*/
		string verilogFileName = createFileName(Id, "verilog");
		string logFileName = createFileName(Id, "log");
		string blifFileName = createFileName(Id, "blif");

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
		size_t found = fsm_.find("default:");
		while(found != string::npos)
		{
			found = fsm_.find("default:", found + 1);
		}

		if(verbose) cerr << "Creating .v file......";
		ofstream fout(verilogFileName.c_str());
		fout << declarations_;
		fout << fsm_;
		fout << trigger;
		fout << counter;
		fout << detector;
		fout << "endmodule\n";
		fout.close();
		if(verbose) cout << "done." << endl;

		/*------------------Generate script files------------------*/
		createScript(Id, "yosys");
		createScript(Id, "abcToBlif");
		createScript(Id, "abcPdr");

		// createScript(Id, "abcInt");
		/*fout.open("scripts/abcInt.sh");
		fout << "read blifs/cadb160_asser" << Id << ".blif" << endl;
		fout << "strash" << endl;
		fout << "int -L logs/cadb160_asser" << Id << ".log" << endl;
		fout.close();*/

		vector<vector<bool> > inputSeq, inputSeq_;
		
		/*------------------Yosys synthesis------------------*/
		if(verbose) cerr << "Creating .blif file (yosys)......";
		system("./yosys -q -s scripts/yosys.sh");
		if(verbose) cout << "done." << endl;

		/*------------------Abc to blif------------------*/
		if(verbose) cerr << "Rewriting .blif files (abc)......";
		system("./abc -f scripts/abcToBlif.sh > /dev/null");
		if(verbose) cout << "done." << endl;

		/*------------------Abc pdr cmd------------------*/
		if(verbose) cerr << "Running \"pdr\" cmd (abc)......";
		if(verbose) system("./abc -f scripts/abcPdr.sh");
		else system("./abc -f scripts/abcPdr.sh > /dev/null");
		if(verbose) cout << "done." << endl;
		
		ifstream blifFile(blifFileName.c_str()), logFile(logFileName.c_str());
		if(!blifFile.is_open() || !logFile.is_open()) continue;

		if(readLog(blifFileName.c_str(), logFileName.c_str(), inputSeq_)) //if this assertion can fail --> take the monitor circuit
		{
			//if((*a)->id == 9) continue;
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

			// cerr << "Running \"int\" cmd (abc)......";
			// system("./abc -f scripts/abcInt.sh > /dev/null");
			// cout << "done." << endl;
		}
		
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

	if(bound != -1 || single != -1) return 0;

	/*------------------Write a big .v file with all monitors and fsm circuits------------------*/
	string Id = "-1";
	if(verbose) cout << endl << "Start dealing with all assertions " << endl;
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
	if(verbose) cerr << "Creating .v file......";
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
	if(verbose) cout << "done." << endl;

	/*------------------Generate script files------------------*/
	createScript(Id, "yosys");
	createScript(Id, "abcToBlif");
	// createScript(Id, "abcInt");
	createScript("0", "dc2");

	/*------------------(.v) Yosys synthesis (.blif)------------------*/
	if(verbose) cerr << "Creating .blif file (yosys)......";
	system("./yosys -q -s scripts/yosys.sh");
	if(verbose) cout << "done." << endl;

	/*------------------(.blif) Abc to blif (.blif)------------------*/
	if(verbose) cerr << "Rewriting .blif files (abc)......";
	system("./abc -f scripts/abcToBlif.sh > /dev/null");
	if(verbose) cout << "done." << endl;

	/*------------------Removing redundant latches------------------*/
	// removeLatch("blifs/cadb160.blif");

	/*------------------(.blif) Abc int cmd (.log)------------------*/
	if(verbose) cerr << "Running \"int\" cmd (abc)......";
	if(!verbose) system("./abc -f scripts/dc2.sh > /dev/null");
	else system("./abc -f scripts/dc2.sh");
	if(verbose) cout << "done." << endl;

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
	 //fout << endl;
	}
	fout.close();

	for (vector<assertions*>::iterator i = vassertions.begin(); i != vassertions.end(); ++i)
		delete *i;
	
	/*system("rm -f verilogs/*");
	system("rm -f blifs/*");
	system("rm -f logs/*");
	system("rm -f outputs/*");
	system("rm -f scripts/*");*/

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
		fout << "proc; opt; techmap -map techlibs/techmap.v;" << endl;
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
		if(Id != "-1" && !verbose) fout << "int -L logs/cadb160_asser" << Id << ".log" << endl;
		else if(Id != "-1" && verbose) fout << "int -vL logs/cadb160_asser" << Id << ".log" << endl;
		else if(Id == "-1" && !verbose) fout << "int -L logs/cadb160.log" << endl;
		else  fout << "int -vL logs/cadb160.log" << endl;
	}

	else if (script == "dc2")
	{
		fout.open("scripts/dc2.sh");
		fout << "read blifs/cadb160.blif" << endl;
		fout << "strash" << endl;
		for(int j = 0; j < 8; j++)
		{
			for(int i = 0; i < 10; i++)
			{
				fout << "dc2" << endl;
			}
			fout << "ifraig" << endl;
		}
		// if(!verbose) fout << "int -L logs/cadb160.log" << endl;
		// else fout << "int -vL logs/cadb160.log" << endl;
		if(!verbose) fout << "bmc3 -L logs/cadb160.log" << endl;
		else fout << "bmc3 -vL logs/cadb160.log" << endl;
	}

	fout.close();
	return 0;
}

string createFileName(string id, string type)
{
	string temp;
	if(type == "verilog")
	{
		if(id == "0") temp = "verilogs/cadb160.v";
		else
		{
			temp = "verilogs/cadb160_asser";
			temp.append(id);
			temp.append(".v");
		}
	}
	else if(type == "blif")
	{
		if(id == "0") temp = "blifs/cadb160.blif";
		else
		{
			temp = "blifs/cadb160_asser";
			temp.append(id);
			temp.append(".blif");
		}
	}
	else if(type == "log")
	{
		if(id == "0") temp = "logs/cadb160.log";
		else
		{
			temp = "logs/cadb160_asser";
			temp.append(id);
			temp.append(".log");
		}
	}
	else if(type == "output")
	{
		if(id == "0") temp = "outputs/input_sequence";
		else
		{
			temp = "outputs/input_sequence";
			temp.append(id);
		}
	}
	else
	{
		temp = "ProblemD.1/tb";
		temp.append(id);
		temp.append("/fsm.v");
	}

	return temp;
}
