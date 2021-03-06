#include "parser.h"
#include <fstream>
#include <sstream>
#include <iostream>
#include <vector>
#include <map>

using namespace std;

int removeLatch(const char* file)
{
	ifstream fin(file);
	string line, word, net;
	vector<string> nstateNet, outline;
	map<string, string> outNet;
	int nstateCount = 0;

	while(getline(fin, line))
	{
		istringstream token(line);
		token >> word;
		if(word.find(".latch") != string::npos)
		{
			token >> net;
			token >> word;
			if(word.find("nstate") != string::npos)
			{
				nstateNet.push_back(net);
				string newline = "#";
				newline.append(line);
				outline.push_back(newline);
				continue;
			}
			if(word.find("out") != string::npos)
			{
				outNet.insert(pair<string, string>(word, net));
			}
		}
		if(word.find(".names") != string::npos)
		{
			if(line.find("rst") != string::npos && line.find("nstate") != string::npos)
			{
				line.replace(line.find("rst") + 4, line.find("]") - line.find("nstate") + 1, nstateNet[nstateCount]);
				nstateCount++;
				outline.push_back(line);
				getline(fin, line);
				line.replace(0, 1, "-");
			}

			if(line.find("last") != string::npos && line.find("out") != string::npos)
			{
				// line.replace(line.find("out"), line.find("]", line.find("out") + 1) - line.find("out") + 1, outNet.find(line.substr(line.find("out"), line.find("]", line.find("out") + 1) - line.find("out") + 1))->second);
			}

			if(line.find("out") != string::npos)
			{
				// line.replace(line.find("out"), line.find("]", line.find("out") + 1) - line.find("out") + 1, outNet.find(line.substr(line.find("out"), line.find("]", line.find("out") + 1) - line.find("out") + 1))->second);
			}       
		}
		outline.push_back(line);
	}
	fin.close();

	ofstream fout(file);
	for(vector<string>::iterator it = outline.begin(); it != outline.end(); it++)
	{
		fout << (*it) << endl;
	}
	fout.close();
}

bool parse(const char* file, string &fsm, string &declarations, vector<assertions*> &vassertions)
{
	ifstream fin(file);
	if(!fin.is_open()) {
		// if(argc == 1) cout << "No input file.\n";
		cout << "Cannot open the file \"" << file << "\".\n";
		cout << "Usage: ./main –i fsm.v –o input_sequence" << endl;
		return false;
	}
	int flop = 0;
	string line, word, lineWithDef;
	int asserCount = 1;
	string s0;
	int count = 0;

	while(getline(fin, line))
	{
		istringstream token(line);
		token >> word;
		if(word.find("assertion") != string::npos)
		{
			assertions *tmp = new assertions;
			tmp->id = asserCount;
			getline(fin, line);
			token.clear();
			token.str(line);
			token >> word;
			token >> word;
			token >> word;

			if(word.substr(0, 5) == "$rose") tmp->trigger = 1;
			else tmp->trigger = 0;

			tmp->triSignal = word.substr(word.find("(") + 1, word.find(")") - word.find("(") - 1);
			tmp->triSignal_text = word.substr(word.find("(") + 1, word.find("[") - word.find("(") - 1);
			tmp->triSignal_text.append(word.substr(word.find("[") + 1, 1));

			int first = 0, second = 0;
			stringstream ss1, ss2;
			ss1 << word.substr(word.find("#") + 3, word.find(":") - word.find("#") - 3);
			ss1 >> first;
			ss2 << word.substr(word.find(":") + 1, word.find("]", word.find(":")) - word.find(":") - 1);
			ss2 >> second;
			tmp -> delayFirst = first;
			tmp -> delaySecond = second;

			token >> word;
			if(word.substr(0, 5) == "$rose") tmp->response = 1;
			else tmp->response = 0;

			tmp->resSignal = word.substr(word.find("(") + 1, word.find(")") - word.find("(") - 1);
			tmp->resSignal_text = word.substr(word.find("(") + 1, word.find("[") - word.find("(") - 1);
			tmp->resSignal_text.append(word.substr(word.find("[") + 1, 1));
			
			vassertions.push_back(tmp);
			asserCount++;
			getline(fin, line);
		}
		else
		{
			if(flop == 1 && line.size() == 0) continue;
			if(line.find("always @(in or pstate) begin") != string::npos) 
			{
				line = "always @(posedge clk) begin\n";    
				fsm.append(line);
				line = "if (rst) begin\n  pstate=S0;\n";
				fsm.append(line);
			}
			/*-----------------------Default path-----------------------*/
			/*-----------------------(Duble default: uncomment line:134-153)-----------------------*/
			/*-----------------------(Single default: uncomment line:134-146 & line:154)-----------------------*/
			if(line.find("casex") != string::npos)
			{
				string s1;
				fsm.append(line);
				fsm.append("\n");
				getline(fin, line);
				if(count == 0) s0.append("  casex(in)\n");
				while(line.find("endcase") == string::npos)
				{
					istringstream token2(line);
					string tmpword;
					while(token2 >> tmpword && tmpword != "end") continue;
					line.replace(line.find("nstate"), 1, "p");
					lineWithDef = line;
					// line.insert(line.find("end"), "def = 0; ");
					// lineWithDef.insert(lineWithDef.find("end"), "def = 1; ");
					fsm.append(line);
					fsm.append("\n");
					s1.append("    ");
					s1.append(lineWithDef);
					s1.append("\n");
					if(count == 0)
					{
						if(line.find("pstate") != string::npos)
						{
							line.replace(0, 2, "    ");
							line.replace(line.find("pstate"), (line.find("out") - line.find("pstate")), "");
						}
						s0.append(line);
						s0.append("\n");
					}
					getline(fin, line);					
				}
				if(count == 0) s0.append("    default: begin def=1; end\n  endcase\n");
				if(count == 0) s0.append("end\n");
				s1.replace(0, 4, "");
				fsm.append("  default: begin");
				// fsm.append("    if(~def) casex(in2)\n    ");
				// fsm.append(s1);
				// // fsm.append("      default: begin def = 1; end\n");
				// fsm.append("    endcase\n");
				// fsm.append("    else begin pstate = pstate; out = out; def = 1; end\n");
				fsm.append(" def=1;");
				fsm.append(" end\n");
				count++;
				// fsm.append("  default: begin nstate = pstate; end\n");
			}

			/*-----------------------remove reset multiple define-----------------------*/
			if(line.find("always @(posedge clk or posedge rst) begin") != string::npos) continue;
			if(line.find("(rst)") != string::npos) continue;
			if(line.find("else pstate <= nstate;") != string::npos)
			{
				getline(fin, line);
				continue;
			}

			/*-----------------------Change output immediately whenever facing reset-----------------------*/
			/*-----------------------(Use [if else] block -> uncomment line:177 & line:265)-----------------------*/
			/*-----------------------(Put [if] at the bottom of always block -> uncomment line:266 and DON'T uncomment line:177)-----------------------*/
			if(line.find("case (pstate)") != string::npos) 
			{
			 // line = "case (pstate)\n";
			 // fsm.append(line);
			 // getline(fin, line);
			 // while(line.find("endcase") == string::npos)
			 // {
				 // fsm.append(line);
				 // fsm.append("\n");
				 // s0.append(line);
				 // s0.append("\n");
				 // getline(fin, line);
			 // }
			 // s0.append(line);
			 // s0.append("\n");
			 ///////////////////////////////////////////////////
			 line = "else case (pstate)";
			 // s0.replace(0, 3, "if(rst) casex(in)\n");
			}

			if(word != "endmodule" && word != "input" && word != "output" && word != "module" && word != "reg" && word != "parameter")
			{
				fsm.append(line);
				fsm.append("\n");
			}
			if(line.size() == 0) flop = 1;
			else flop = 0;
		}
		if(word == "input")
		{
			if(line.find("in;") != string::npos) 
			{			
				declarations.append(line);
				declarations.append("\n");
				line.replace(0, 5, "reg");
				line.replace(line.find("in;"), 2, "in2");
			}
			token >> word;
			if(word != "clk,")
			{
				int start = 0, end = 0;
				stringstream ss1, ss2;
				ss1 << word.substr(word.find("[") + 1, word.find(":") - word.find("[") - 1);
				ss1 >> start;
				ss2 << word.substr(word.find(":") + 1, word.find("]") - word.find(":") - 1);
				ss2 >> end;
			}
			declarations.append(line);
			declarations.append("\n");
		}
		if(word == "output")
		{
			token >> word;
			int start = 0, end = 0;
			stringstream ss1, ss2;
			ss1 << word.substr(word.find("[") + 1, word.find(":") - word.find("[") - 1);
			ss1 >> start;
			ss2 << word.substr(word.find(":") + 1, word.find("]") - word.find(":") - 1);
			ss2 >> end;
		}
		if(word == "parameter")
		{
			declarations.append(line);
			declarations.append("\n");
			while(token >> word);
			while(word.find(";") == string::npos)
			{
				getline(fin, line);
				declarations.append(line);
				declarations.append("\n");
				token.clear();
				token.str(line);
				while(token >> word);
			}
		}
		if(word == "module")
		{

			line = "module fsm(clk, rst, in);";
			declarations.append(line);
			declarations.append("\n");
		}
		if(word == "reg")
		{
			declarations.append(line);
			declarations.append("\n");
		}
	}

	declarations.append("reg def;\n");

	string always = "always @(posedge clk) begin\n    in2 <= in;\nend\n\n";
	fsm.insert(fsm.find("always @(posedge clk) begin"), always);
	
	fsm.insert(fsm.find("else case (pstate)"), s0);
	// fsm.insert(fsm.find("end", fsm.rfind("endcase")+1), s0);

}
