#include "triggergenerator.h"
#include <sstream>

using namespace std;

string triggerGenerator(assertions asser, string &dec)
{
	stringstream ssid;
	string id;
	ssid << asser.id;
	ssid >> id;
	string trigger;
	string p = "p", n = "n";
	p.append(id);
	n.append(id);
	dec.insert(dec.find("parameter"), "reg [1:0] p");
	dec.insert(dec.find("parameter"), id);
	dec.insert(dec.find("parameter"), ", n");
	dec.insert(dec.find("parameter"), id);
	dec.insert(dec.find("parameter"), "; //Generated by us\n");
	dec.insert(dec.find("parameter"), "reg en");
	dec.insert(dec.find("parameter"), id);
	dec.insert(dec.find("parameter"), "; //Generated by us\n");
	trigger.append("always @(posedge clk) begin\n");
	trigger.append("    p");trigger.append(id);trigger.append("<=n");trigger.append(id);trigger.append(";\n");
	trigger.append("    tp");trigger.append(id);trigger.append("<=tn");trigger.append(id);trigger.append(";\n");
	trigger.append("end\n");
	trigger.append("\n");

	if(asser.trigger) //positive
	{
		// trigger.append("always @(");
		// trigger.append(asser.triSignal);
		// trigger.append(" or p) begin\n");
		trigger.append("always @(in or "); trigger.append(p); trigger.append(") begin\n");
		trigger.append("    case ("); trigger.append(p); trigger.append(")\n");
		trigger.append("    2'b00: casex(");
		trigger.append(asser.triSignal);
		trigger.append(")\n");
		trigger.append("        1'b0: begin n");trigger.append(id);trigger.append("=2'b01; en");trigger.append(id);trigger.append("=1'b0; end\n");
		trigger.append("        1'b1: begin n");trigger.append(id);trigger.append("=2'b00; en");trigger.append(id);trigger.append("=1'b0; end\n");
		trigger.append("        endcase\n");
		trigger.append("    2'b01: casex(");
		trigger.append(asser.triSignal);
		trigger.append(")\n");
		trigger.append("        1'b0: begin n");trigger.append(id);trigger.append("=2'b01; en");trigger.append(id);trigger.append("=1'b0; end\n");
		trigger.append("        1'b1: case(PPI");trigger.append(id);trigger.append(")\n");
		trigger.append("            1'b0: begin n");trigger.append(id);trigger.append("=2'b10; en");trigger.append(id);trigger.append("=1'b0; end\n");
		trigger.append("            1'b1: begin n");trigger.append(id);trigger.append("=2'b11; en");trigger.append(id);trigger.append("=1'b1; end\n");
		trigger.append("            endcase\n");
		trigger.append("        endcase\n");
		trigger.append("    2'b10: casex(");
		trigger.append(asser.triSignal);
		trigger.append(")\n");
		trigger.append("        1'b0: begin n");trigger.append(id);trigger.append("=2'b01; en");trigger.append(id);trigger.append("=1'b0; end\n");
		trigger.append("        1'b1: begin n");trigger.append(id);trigger.append("=2'b10; en");trigger.append(id);trigger.append("=1'b0; end\n");
		trigger.append("        endcase\n");
		trigger.append("    2'b11: begin n");trigger.append(id);trigger.append("=2'b11; en");trigger.append(id);trigger.append("=1'b1; end\n");
		trigger.append("    endcase\n");
		trigger.append("end\n");
		trigger.append("\n");
	}

	else //nagative
	{
		// trigger.append("always @(");
		// trigger.append(asser.triSignal);
		// trigger.append(" or p) begin\n");
		trigger.append("always @(in or "); trigger.append(p); trigger.append(") begin\n");
		trigger.append("    case ("); trigger.append(p); trigger.append(")\n");
		trigger.append("    2'b00: casex(");
		trigger.append(asser.triSignal);
		trigger.append(")\n");
		trigger.append("        1'b1: begin n");trigger.append(id);trigger.append("=2'b01; en");trigger.append(id);trigger.append("=1'b0; end\n");
		trigger.append("        1'b0: begin n");trigger.append(id);trigger.append("=2'b00; en");trigger.append(id);trigger.append("=1'b0; end\n");
		trigger.append("        endcase\n");
		trigger.append("    2'b01: casex(");
		trigger.append(asser.triSignal);
		trigger.append(")\n");
		trigger.append("        1'b1: begin n");trigger.append(id);trigger.append("=2'b01; en");trigger.append(id);trigger.append("=1'b0; end\n");
		trigger.append("        1'b0: case(PPI");trigger.append(id);trigger.append(")\n");
		trigger.append("            1'b0: begin n");trigger.append(id);trigger.append("=2'b10; en");trigger.append(id);trigger.append("=1'b0; end\n");
		trigger.append("            1'b1: begin n");trigger.append(id);trigger.append("=2'b11; en");trigger.append(id);trigger.append("=1'b1; end\n");
		trigger.append("            endcase\n");
		trigger.append("        endcase\n");
		trigger.append("    2'b10: casex(");
		trigger.append(asser.triSignal);
		trigger.append(")\n");
		trigger.append("        1'b1: begin n");trigger.append(id);trigger.append("=2'b01; en");trigger.append(id);trigger.append("=1'b0; end\n");
		trigger.append("        1'b0: begin n");trigger.append(id);trigger.append("=2'b10; en");trigger.append(id);trigger.append("=1'b0; end\n");
		trigger.append("        endcase\n");
		trigger.append("    2'b11: begin n");trigger.append(id);trigger.append("=2'b11; en");trigger.append(id);trigger.append("=1'b1; end\n");
		trigger.append("    endcase\n");
		trigger.append("end\n");
		trigger.append("\n");
	}

	return trigger;
}