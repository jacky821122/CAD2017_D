#include "detectorgenerator.h"
#include <sstream>

using namespace std;

extern string toBinary(int n, int digit);

string detectorGenerator(assertions asser, string &dec)
{
	string detector, id;
	stringstream ssid;
	ssid << asser.id;
	ssid >> id;
	string sResSig;
	sResSig.append("res_");
	sResSig.append(id);

	dec.insert(dec.find("parameter"), "reg last_");
	dec.insert(dec.find("parameter"), sResSig);
	dec.insert(dec.find("parameter"), ", detect");
	dec.insert(dec.find("parameter"), id);
	// dec.insert(dec.find("parameter"), ", detect_n");
	// dec.insert(dec.find("parameter"), id);
	dec.insert(dec.find("parameter"), ", clk_start");
	dec.insert(dec.find("parameter"), id);
	// dec.insert(dec.find("parameter"), ", clk_start_n");
	// dec.insert(dec.find("parameter"), id);
	dec.insert(dec.find("parameter"), ", co");
	dec.insert(dec.find("parameter"), id);
	dec.insert(dec.find("parameter"), ";\n");
	dec.insert(dec.find("parameter"), "wire detect_n");
	dec.insert(dec.find("parameter"), id);
	dec.insert(dec.find("parameter"), ", clk_start_n");
	dec.insert(dec.find("parameter"), id);
	dec.insert(dec.find("parameter"), "; //Generated by [ DETECTOR ]\n");

	string resSignal = asser.resSignal;
	if(resSignal.find("in") != string::npos)  resSignal.insert(resSignal.find("["), "2");

	detector.append("always @(posedge clk) begin\n");
	detector.append("    last_"); detector.append(sResSig); detector.append(" <= "); detector.append(resSignal); detector.append(";\n");
	detector.append("    if(co"); detector.append(id); detector.append(" & en"); detector.append(id); detector.append(") detect"); detector.append(id); detector.append(" <= detect_n"); detector.append(id); detector.append(";\n");
	detector.append("    else detect"); detector.append(id); detector.append(" <= detect"); detector.append(id); detector.append(";\n");
	detector.append("    clk_start"); detector.append(id); detector.append(" <= clk_start_n"); detector.append(id); detector.append(";\n");
	detector.append("end\n\n");

	// detector.append("always @(posedge clk or posedge rst) begin\n");
	// detector.append("    if(rst) begin last_");detector.append(sResSig);detector.append(" <= 0; detect");detector.append(id);detector.append(" <= 0; clk_start");detector.append(id);detector.append(" <= 0; end\n");
	// detector.append("    else\n");
	// detector.append("    begin\n");
	// detector.append("        last_"); detector.append(sResSig); detector.append(" <= "); detector.append(resSignal); detector.append(";\n");
	// detector.append("        if(co"); detector.append(id); detector.append(" & en_n"); detector.append(id); detector.append(") detect"); detector.append(id); detector.append(" <= detect_n"); detector.append(id); detector.append(";\n");
	// detector.append("        else detect"); detector.append(id); detector.append(" <= detect"); detector.append(id); detector.append(";\n");
	// detector.append("        clk_start"); detector.append(id); detector.append(" <= clk_start_n"); detector.append(id); detector.append(";\n");
	// detector.append("    end\n");
	// detector.append("end\n\n");

	if(asser.response) {detector.append("assign detect_n"); detector.append(id); detector.append(" = detect"); detector.append(id); detector.append(" | (~last_"); detector.append(sResSig); detector.append(" & "); detector.append(resSignal); detector.append(");\n"); }
	else {detector.append("assign detect_n"); detector.append(id); detector.append(" = detect"); detector.append(id); detector.append(" | (last_"); detector.append(sResSig); detector.append(" & ~"); detector.append(resSignal); detector.append(");\n"); }
	detector.append("assign clk_start_n"); detector.append(id); detector.append(" = clk_start"); detector.append(id); detector.append(" | (co"); detector.append(id); detector.append(" & en"); detector.append(id); detector.append(");\n");
	detector.append("assign z"); detector.append(id); detector.append(" = ~def & (~detect_n"); detector.append(id); detector.append(" & (clk_start_n"); detector.append(id); detector.append(" & ~co"); detector.append(id); detector.append("));\n");

	return detector;
}
