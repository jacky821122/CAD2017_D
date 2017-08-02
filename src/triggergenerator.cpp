#include "triggergenerator.h"

using namespace std;

string triggerGenerator(assertions asser, string &dec)
{
	string trigger;
	dec.insert(dec.find("parameter"), "reg [1:0] p,n; //Generated by us\n");
	dec.insert(dec.find("parameter"), "reg en; //Generated by us\n");
	trigger.append("always @(posedge clk) begin\n");
	trigger.append("    p<=n;\n");
	trigger.append("    tp<=tn;\n");
	trigger.append("end\n");
	trigger.append("\n");

	if(asser.trigger) //positive
	{
		// trigger.append("always @(");
		// trigger.append(asser.triSignal);
		// trigger.append(" or p) begin\n");
		trigger.append("always @(in or p) begin\n");
		trigger.append("    case (p)\n");
		trigger.append("    2'b00: casex(");
		trigger.append(asser.triSignal);
		trigger.append(")\n");
		trigger.append("        1'b0: begin n=2'b01; en=1'b0; end\n");
		trigger.append("        1'b1: begin n=2'b00; en=1'b0; end\n");
		trigger.append("        endcase\n");
		trigger.append("    2'b01: casex(");
		trigger.append(asser.triSignal);
		trigger.append(")\n");
		trigger.append("        1'b0: begin n=2'b01; en=1'b0; end\n");
		trigger.append("        1'b1: case(PPI)\n");
		trigger.append("            1'b0: begin n=2'b10; en=1'b0; end\n");
		trigger.append("            1'b1: begin n=2'b11; en=1'b1; end\n");
		trigger.append("            endcase\n");
		trigger.append("        endcase\n");
		trigger.append("    2'b10: casex(");
		trigger.append(asser.triSignal);
		trigger.append(")\n");
		trigger.append("        1'b0: begin n=2'b01; en=1'b0; end\n");
		trigger.append("        1'b1: begin n=2'b10; en=1'b0; end\n");
		trigger.append("        endcase\n");
		trigger.append("    2'b11: begin n=2'b11; en=1'b1; end\n");
		trigger.append("    endcase\n");
		trigger.append("end\n");
		trigger.append("\n");
	}

	else //nagative
	{
		// trigger.append("always @(");
		// trigger.append(asser.triSignal);
		// trigger.append(" or p) begin\n");
		trigger.append("always @(in or p) begin\n");
		trigger.append("    case (p)\n");
		trigger.append("    2'b00: casex(");
		trigger.append(asser.triSignal);
		trigger.append(")\n");
		trigger.append("        1'b1: begin n=2'b01; en=1'b0; end\n");
		trigger.append("        1'b0: begin n=2'b00; en=1'b0; end\n");
		trigger.append("        endcase\n");
		trigger.append("    2'b01: casex(");
		trigger.append(asser.triSignal);
		trigger.append(")\n");
		trigger.append("        1'b1: begin n=2'b01; en=1'b0; end\n");
		trigger.append("        1'b0: case(PPI)\n");
		trigger.append("            1'b0: begin n=2'b10; en=1'b0; end\n");
		trigger.append("            1'b1: begin n=2'b11; en=1'b1; end\n");
		trigger.append("            endcase\n");
		trigger.append("        endcase\n");
		trigger.append("    2'b10: casex(");
		trigger.append(asser.triSignal);
		trigger.append(")\n");
		trigger.append("        1'b1: begin n=2'b01; en=1'b0; end\n");
		trigger.append("        1'b0: begin n=2'b10; en=1'b0; end\n");
		trigger.append("        endcase\n");
		trigger.append("    2'b11: begin n=2'b11; en=1'b1; end\n");
		trigger.append("    endcase\n");
		trigger.append("end\n");
		trigger.append("\n");
	}

	return trigger;
}