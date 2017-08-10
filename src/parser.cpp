#include "parser.h"
#include <fstream>
#include <sstream>

using namespace std;

void parse(char* file, string &fsm, string &declarations, vector<assertions*> &vassertions)
{
	ifstream fin(file);
	if(!fin.is_open()) {
		// if(argc == 1) cout << "No input file.\n";
		// else cout << "Cannot open the file \"" << argv[1] << "\".\n";
		return void();
	}
	int flop = 0;
	string line, word;
	int asserCount = 1;

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
			vassertions.push_back(tmp);
			asserCount++;
			getline(fin, line);
		}
		else
		{
			if(flop == 1 && line.size() == 0) continue;
			// if(line.find("input clk, rst") != string::npos) line = "input clk;"; 
			if(line.find("always @(posedge clk or posedge rst) begin") != string::npos) line = "always @(posedge clk) begin";
			if(line.find("(rst)") != string::npos) line.replace(line.find("(rst)"), 5, "(r)");
			if(line.find("else pstate <= nstate;") != string::npos)
			{
				fsm.append(line);
				fsm.append("\n rp <= rn;\n");
				continue;
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
			// stringstream ss;
			// ss << word.substr(word.find("S") + 1, word.find("=") - word.find("S") - 1);
			// ss >> numState;
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

}
