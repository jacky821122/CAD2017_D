#include "countergenerator.h"
#include <cmath>
#include <sstream>

using namespace std;

string toBinary(int n, int digit)
{
	string r;
	while(n!=0) {r=(n%2==0 ?"0":"1")+r; n/=2;}
	string s;
	int delta = digit - r.size();
	while(delta > 0) {s.append("0"); delta--;}
	return s.append(r);
}

string counterGenerator(assertions asser, string &dec)
{
	string counter, id;
	stringstream ssid;
	ssid << asser.id;
	ssid >> id;
	string bit, first, regBit, second;
	int k = 0;
	while((int)pow(2, k) <= asser.delaySecond + 1) k++;
	stringstream ss, ss1, ss2, ss3;
	ss << k;
	ss >> bit;
	ss1 << k - 1;
	ss1 >> regBit;
	ss2 << asser.delaySecond - 1;
	ss2 >> second;
	ss3 << asser.delayFirst;
	ss3 >> first;
	dec.insert(dec.find("parameter"), "reg [");
	dec.insert(dec.find("parameter"), regBit);
	dec.insert(dec.find("parameter"), ":0] count");
	dec.insert(dec.find("parameter"), id);
	dec.insert(dec.find("parameter"), "; //Generated by [ COUNTER ]\n");

	counter.append("always @(posedge clk) begin\n");
	counter.append("    if(en_n");counter.append(id);counter.append(") begin\n");
	counter.append("        if(count");counter.append(id);counter.append("==");
	counter.append(bit);
	counter.append("'b");
	counter.append(toBinary((int)pow(2, k) - 1, k));
	counter.append(") begin\n");
	counter.append("            count");counter.append(id);counter.append("<=count");counter.append(id);counter.append(";\n");
	counter.append("        end\n");
	counter.append("        else\n");
	counter.append("            count");counter.append(id);counter.append("<=count");counter.append(id);counter.append("+1;\n");
	counter.append("    end\n");
	counter.append("    else begin\n");
	counter.append("        count");counter.append(id);counter.append("<=0;\n");
	counter.append("    end\n");
	counter.append("end\n");
	counter.append("\n");

	counter.append("always @(posedge clk) begin\n");
	counter.append("    if(count");counter.append(id);counter.append(">=");
	counter.append(bit);
	counter.append("'b");
	// counter.append(toBinary(asser.delayFirst - 1, k));
	counter.append(toBinary(asser.delayFirst - 1, k));
	counter.append(") begin //delayFirst: ");
	counter.append(first);
	counter.append("\n");
	counter.append("        if(count");counter.append(id);counter.append("<=");
	counter.append(bit);
	counter.append("'b");
	// counter.append(toBinary(asser.delaySecond, k));
	counter.append(toBinary(asser.delaySecond - 1, k));
	// counter.append(")\n");
	counter.append(") //delaySecond: ");
	counter.append(second);
	counter.append("     bit: ");
	counter.append(bit);
	counter.append("\n");

	counter.append("            co");counter.append(id);counter.append("=1;\n");
	counter.append("        else begin\n");
	counter.append("            co");counter.append(id);counter.append("=0;\n");
	counter.append("        end\n");
	counter.append("    end\n");
	counter.append("    else\n");
	counter.append("        co");counter.append(id);counter.append("=0;\n");
	counter.append("end\n");
	counter.append("\n");

	return counter;
}
