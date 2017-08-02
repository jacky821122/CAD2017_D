#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <stack>
#include "readlog.h"

using namespace std;

bool readLog(char* cblifFile, char* clogFile, vector<vector<bool> > &inputSeq)
{
	string line, word;
	ifstream blifFile(cblifFile);
	getline(blifFile, line);
	getline(blifFile, line);
	getline(blifFile, line);
	getline(blifFile, line);
	istringstream token1(line);
	vector<bool> careBits;
	while(token1 >> word)
	{
		if(word == ".inputs") continue;
		if(word.find("in[") == string::npos) careBits.push_back(false);
		else careBits.push_back(true);
	}

	ifstream logFile(clogFile);
	int iFrame = 0;
	stringstream ss;
	getline(logFile, line);
	istringstream token(line);
	token >> word;
	if(word == "snl_UNSAT")	return false;
	token >> word;
	token >> word;
	token >> word;
	token >> word;
	ss << word;
	ss >> iFrame;
	getline(logFile, line);
	getline(logFile, line);
	/*int total = line.size();
	int inBit = total / (iFrame + 1);*/
	int inBit = line.size();
	vector<bool> vtmp;
	for(int i = 0; i < inBit - 3 + 1 /* -clk -rst -PPI +rst */; i++) vtmp.push_back(0);
	inputSeq.push_back(vtmp);
	for(int i = 0; i < iFrame; i++)
	{
		vector<bool> inputOne;
		stack<bool> tempInput;
		for(int j = 0; j < inBit; j++)
		{
			if(careBits[j] == true)
			{
				bool tmp;
				stringstream ss1;
				ss1 << line.substr(/*i * inBit + */j, 1);
				ss1 >> tmp;
				tempInput.push(tmp);
			}
		}
		
		if(i == 0) inputOne.push_back(1);
		else inputOne.push_back(0);
		while(!tempInput.empty())
		{
			inputOne.push_back(tempInput.top());
			tempInput.pop();
		}
		inputSeq.push_back(inputOne);
		getline(logFile, line);
		// for(int k = 0; k < inputOne.size(); k++)
		// {
		// 	cout << inputOne[k];
		// }
		// cout << "    ";
		// inputOne.clear();
		// cout << line.substr(i * inBit, inBit) << endl;
	}

	// cout << "Terminate at frame: " << iFrame << endl;
	// cout << "Input bit : " << inBit - 3 + 1 << endl;
	// for(int i = 0; i < inputSeq.size(); i++)
	// {
	// 	for(int j = 0; j < inputSeq[i].size(); j++)
	// 	{
	// 		cout << inputSeq[i][j];
	// 	}
	// 	cout << endl;
	// } cout << endl;
	return true;
}
