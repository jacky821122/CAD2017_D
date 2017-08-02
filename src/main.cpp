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

int main(int argc, char* argv[])
{
	system("rm -f verilogs/*");
	system("rm -f blifs/*");
	system("rm -f logs/*");
	system("rm -f outputs/*");
	system("rm -f scripts/*");
	vector<assertions*> vassertions;
	string declarations_, fsm_;
	parse(argv[1], fsm_, declarations_, vassertions);
	
	for(vector<assertions*>::iterator a = vassertions.begin(); a != vassertions.end(); a++)
	{
		cout << endl << "Start dealing with assertion " << (*a)->id << endl;
		vector<assertions*> vassertions_;
		string declarations, fsm, trigger, counter, detector;
		parse(argv[1], fsm, declarations, vassertions_);
		string Id;
		stringstream ss;
		ss << (*a)->id;
		ss >> Id;

		string temp = "verilogs/cadb160_asser";
		temp.append(Id);
		temp.append(".v");
		char verilogFileName[1024];
		strncpy(verilogFileName, temp.c_str(), sizeof(verilogFileName));
		verilogFileName[sizeof(verilogFileName) - 1] = 0;

		string temp1 = "logs/cadb160_asser";
		temp1.append(Id);
		temp1.append(".log");
		char logFileName[1024];
		strncpy(logFileName, temp1.c_str(), sizeof(logFileName));
		logFileName[sizeof(logFileName) - 1] = 0;

		string temp2 = "blifs/cadb160_asser";
		temp2.append(Id);
		temp2.append(".blif");
		char blifFileName[1024];
		strncpy(blifFileName, temp2.c_str(), sizeof(blifFileName));
		blifFileName[sizeof(blifFileName) - 1] = 0;

		string temp3 = "outputs/cadb160_asser";
		temp3.append(Id);
		temp3.append(".out");
		char outFileName[1024];
		strncpy(outFileName, temp3.c_str(), sizeof(outFileName));
		outFileName[sizeof(outFileName) - 1] = 0;

		trigger = triggerGenerator((**a), declarations);
		counter = counterGenerator((**a), declarations);
		detector = detectorGenerator((**a), declarations);

		cerr << "Creating .v file......";
		ofstream fout(verilogFileName);  //Generate verilog files
		fout << declarations;
		fout << fsm;
		fout << trigger;
		fout << counter;
		fout << detector;
		fout << "endmodule\n";
		fout.close();
		cout << "done." << endl;

		fout.open("scripts/yosys.sh");
		fout << "read_verilog verilogs/cadb160_asser" << Id << ".v" << endl;
		fout << "hierarchy; proc; fsm; techmap;" << endl;
		fout << "write_blif blifs/cadb160_asser" << Id << ".blif" << endl;
		fout.close();

		fout.open("scripts/abcPdr.sh");
		fout << "read blifs/cadb160_asser" << Id << ".blif" << endl;
		fout << "strash" << endl;
		fout << "pdr -L logs/cadb160_asser" << Id << ".log" << endl;
		fout.close();

		fout.open("scripts/abcInt.sh");
		fout << "read blifs/cadb160_asser" << Id << ".blif" << endl;
		fout << "strash" << endl;
		fout << "int -L logs/cadb160_asser" << Id << ".log" << endl;
		fout.close();

		vector<vector<bool> > inputSeq, inputSeq_;
		
		cerr << "Creating .blif file (yosys)......";
		system("./yosys -q -s scripts/yosys.sh");
		cout << "done." << endl;

		cerr << "Running \"pdr\" cmd (abc)......";
		system("./abc -f scripts/abcPdr.sh > /dev/null");
		cout << "done." << endl;
		
		if(readLog(blifFileName, logFileName, inputSeq_))
		{
			cerr << "Running \"int\" cmd (abc)......";
			system("./abc -f scripts/abcInt.sh > /dev/null");
			cout << "done." << endl;
		}
		else cout << "assertion" << (*a)->id << " is unsat." << endl;
		
		// cout << "log file: " << logFileName << endl;
		fout.open(outFileName);
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
		fout.close();

		/*inputSeq.clear();
		out.open("input_sequence");
		if(readLog("cadb160_asser100.blif", "cadb160_asser100.log", inputSeq))
		{
			for(int i = 0; i < inputSeq.size(); i++)
			{
				for(int j = 0; j < inputSeq[i].size(); j++)
				{
					fout << inputSeq[i][j];
				}
				fout << endl;
			}
		}
		fout.close();*/

	}


	for (vector<assertions*>::iterator i = vassertions.begin(); i != vassertions.end(); ++i)
		delete *i;
	
	return 0;
}
