module fsm(clk, rst, in, PPI3, z3);
input clk, rst;
input [6:0] in;
reg [6:0] in2;
reg [6:0] out;
reg [6:0] pstate, nstate;
input PPI3;
reg last_tri_3, en3, en_n3; //Generated by [ TRIGGER ]
reg [5:0] count3; //Generated by [ COUNTER ]
reg last_res_3, detect3, detect_n3, clk_start3, clk_start_n3, co3; //Generated by [ DETECTOR ]
output z3;
parameter S0=7'd0, S1=7'd1, S2=7'd2, S3=7'd3, S4=7'd4,
S5=7'd5, S6=7'd6, S7=7'd7, S8=7'd8, S9=7'd9,
S10=7'd10, S11=7'd11, S12=7'd12, S13=7'd13, S14=7'd14,
S15=7'd15, S16=7'd16, S17=7'd17, S18=7'd18, S19=7'd19,
S20=7'd20, S21=7'd21, S22=7'd22, S23=7'd23, S24=7'd24,
S25=7'd25, S26=7'd26, S27=7'd27, S28=7'd28, S29=7'd29,
S30=7'd30, S31=7'd31, S32=7'd32, S33=7'd33, S34=7'd34,
S35=7'd35;

always @(posedge clk or posedge rst) begin
 if (rst) pstate <= S0; 
 else pstate <= nstate;
end

always @(posedge clk) begin
    in2 <= in;
end

always @(posedge clk) begin
case (pstate)
S0: casex(in)
  7'b0xxxxxx: begin nstate=S0; out =7'b0000000; end
  7'b10xxxx0: begin nstate=S1; out =7'b0011000; end
  7'b10xxxx1: begin nstate=S1; out =7'b0001000; end
  7'b11xxxx0: begin nstate=S11; out =7'b0011010; end
  7'b11xxxx1: begin nstate=S11; out =7'b0001010; end
  endcase
S1: casex(in)
  7'b100xxxx: begin nstate=S1; out =7'b0000000; end
  7'b101x1xx: begin nstate=S4; out =7'b1000000; end
  7'b101x0xx: begin nstate=S2; out =7'b1000000; end
  7'b0xxxxxx: begin nstate=S11; out =7'b0000010; end
  7'b11xxxxx: begin nstate=S11; out =7'b0000010; end
  endcase
S2: casex(in)
  7'b10xxxxx: begin nstate=S3; out =7'b0010000; end
  7'b0xxxxxx: begin nstate=S11; out =7'b0010010; end
  7'b11xxxxx: begin nstate=S11; out =7'b0010010; end
  endcase
S3: casex(in)
  7'b10xx0xx: begin nstate=S2; out =7'b1000000; end
  7'b10xx1xx: begin nstate=S4; out =7'b1000000; end
  7'b0xxxxxx: begin nstate=S11; out =7'b0000010; end
  7'b11xxxxx: begin nstate=S11; out =7'b0000010; end
  endcase
S4: casex(in)
  7'b10xxxxx: begin nstate=S5; out =7'b0010000; end
  7'b0xxxxxx: begin nstate=S11; out =7'b0010010; end
  7'b11xxxxx: begin nstate=S11; out =7'b0010010; end
  endcase
S5: casex(in)
  7'b10x1xxx: begin nstate=S4; out =7'b1010000; end
  7'b10xx1xx: begin nstate=S4; out =7'b1010000; end
  7'b10x00xx: begin nstate=S6; out =7'b0110010; end
  7'b0xxxxxx: begin nstate=S11; out =7'b0010010; end
  7'b11xxxxx: begin nstate=S11; out =7'b0010010; end
  endcase
S6: casex(in)
  7'b10xxx0x: begin nstate=S6; out =7'b0110000; end
  7'b10xxx1x: begin nstate=S7; out =7'b0110000; end
  7'b0xxxxxx: begin nstate=S11; out =7'b0010010; end
  7'b11xxxxx: begin nstate=S11; out =7'b0010010; end
  endcase
S7: casex(in)
  7'b10xxxxx: begin nstate=S8; out =7'b0000010; end
  7'b0xxxxxx: begin nstate=S11; out =7'b0000010; end
  7'b11xxxxx: begin nstate=S11; out =7'b0000010; end
  endcase
S8: casex(in)
  7'b10xxx0x: begin nstate=S8; out =7'b0000000; end
  7'b10xxx1x: begin nstate=S9; out =7'b1000000; end
  7'b0xxxxxx: begin nstate=S11; out =7'b0000010; end
  7'b11xxxxx: begin nstate=S11; out =7'b0000010; end
  endcase
S9: casex(in)
  7'b10xxxxx: begin nstate=S10; out =7'b0000000; end
  7'b0xxxxxx: begin nstate=S11; out =7'b0000010; end
  7'b11xxxxx: begin nstate=S11; out =7'b0000010; end
  endcase
S10: casex(in)
  7'b1001xxx: begin nstate=S10; out =7'b0000000; end
  7'b10x01xx: begin nstate=S1; out =7'b0001000; end
  7'b10x00xx: begin nstate=S6; out =7'b0100010; end
  7'b1011xxx: begin nstate=S9; out =7'b1000000; end
  7'b0xxxxxx: begin nstate=S11; out =7'b0000010; end
  7'b11xxxxx: begin nstate=S11; out =7'b0000010; end
  endcase
S11: casex(in)
  7'b0xxxx0x: begin nstate=S11; out =7'b0010000; end
  7'b11xxx0x: begin nstate=S11; out =7'b0010000; end
  7'b0xxxx1x: begin nstate=S0; out =7'b0010000; end
  7'b10xxxxx: begin nstate=S1; out =7'b0010000; end
  7'b11xxx1x: begin nstate=S12; out =7'b0010100; end
  endcase
S12: casex(in)
  7'b11xxxxx: begin nstate=S12; out =7'b0010100; end
  7'b10xxxxx: begin nstate=S1; out =7'b0010000; end
  7'b0xxxxxx: begin nstate=S16; out =7'b0010010; end
  endcase
S13: casex(in)
  7'b0xxxxxx: begin nstate=S11; out =7'b0000010; end
  endcase
S14: casex(in)
  7'b0xxxxxx: begin nstate=S11; out =7'b0000010; end
  endcase
S15: casex(in)
  7'b0xxxxxx: begin nstate=S11; out =7'b0000010; end
  endcase
S16: casex(in)
  7'b11110xx: begin nstate=S17; out =7'b0000000; end
  7'b101x1xx: begin nstate=S26; out =7'b0000000; end
  endcase
S17: casex(in)
  7'b1110xxx: begin nstate=S19; out =7'b1000000; end
  7'b100xxxx: begin nstate=S25; out =7'b1000000; end
  7'b101xx1x: begin nstate=S25; out =7'b1000000; end
  endcase
S19: casex(in)
  7'b111xxxx: begin nstate=S20; out =7'b1100000; end
  7'b100xxxx: begin nstate=S25; out =7'b1100000; end
  7'b101xx1x: begin nstate=S25; out =7'b1100000; end
  endcase
S20: casex(in)
  7'b111xxxx: begin nstate=S21; out =7'b0010000; end
  7'b100xxxx: begin nstate=S25; out =7'b0010000; end
  7'b101xx1x: begin nstate=S25; out =7'b0010000; end
  endcase
S21: casex(in)
  7'b111x0xx: begin nstate=S22; out =7'b1010000; end
  7'b100xxxx: begin nstate=S25; out =7'b1010000; end
  7'b101x1xx: begin nstate=S25; out =7'b1010000; end
  endcase
S22: casex(in)
  7'b101x0xx: begin nstate=S23; out =7'b0110000; end
  7'b101x1xx: begin nstate=S24; out =7'b0110000; end
  7'b100xxxx: begin nstate=S25; out =7'b0110000; end
  endcase
S23: casex(in)
  7'b10xxxxx: begin nstate=S35; out =7'b1110000; end
  endcase
S24: casex(in)
  7'b10xxxxx: begin nstate=S35; out =7'b0001000; end
  endcase
S25: casex(in)
  7'b101x0xx: begin nstate=S18; out =7'b1001000; end
  7'b100xxxx: begin nstate=S18; out =7'b1001000; end
  endcase
S18: casex(in)
  7'b10xxxxx: begin nstate=S24; out =7'b0101000; end
  endcase
S26: casex(in)
  7'b101x1xx: begin nstate=S27; out =7'b1000100; end
  7'b100xxxx: begin nstate=S34; out =7'b1000100; end
  7'b101x0xx: begin nstate=S35; out =7'b1000100; end
  endcase
S27: casex(in)
  7'b101x1xx: begin nstate=S28; out =7'b0100100; end
  7'b100xxxx: begin nstate=S34; out =7'b0100100; end
  7'b101x0xx: begin nstate=S35; out =7'b0100100; end
  endcase
S28: casex(in)
  7'b101x1xx: begin nstate=S29; out =7'b1100100; end
  7'b101x0x0: begin nstate=S31; out =7'b1100101; end
  7'b101x0x1: begin nstate=S33; out =7'b1100100; end
  7'b100xxxx: begin nstate=S30; out =7'b1100100; end
  endcase
S29: casex(in)
  7'b101x0x0: begin nstate=S31; out =7'b0010100; end
  7'b101x0x1: begin nstate=S33; out =7'b0010100; end
  7'b100xxxx: begin nstate=S30; out =7'b0010100; end
  endcase
S31: casex(in)
  7'b101x0xx: begin nstate=S32; out =7'b0110100; end
  7'b101x1xx: begin nstate=S30; out =7'b0110100; end
  7'b100xxxx: begin nstate=S30; out =7'b0110100; end
  endcase
S32: casex(in)
  7'b10xxxxx: begin nstate=S35; out =7'b1110100; end
  endcase
S33: casex(in)
  7'b10xxxxx: begin nstate=S30; out =7'b0001100; end
  endcase
S30: casex(in)
  7'b101xxxx: begin nstate=S35; out =7'b1010100; end
  7'b100xxxx: begin nstate=S34; out =7'b1000100; end
  endcase
S35: casex(in)
  7'bxxxxxxx: begin nstate=S16; out =7'b0000010; end
  endcase
S34: casex(in)
  7'b111x0xx: begin nstate=S16; out =7'b0111110; end
  endcase
endcase
end

always @(posedge clk) begin
    en3 <= en_n3;
    last_tri_3 <= out[0];
end

assign en_n3 = en3 | ((last_tri_3 & ~out[0]) & PPI3);

always @(posedge clk) begin
    if(en_n3) begin
        if(count3==6'b111111) begin
            count3<=count3;
        end
        else
            count3<=count3+1;
    end
    else begin
        count3<=0;
    end
end

always @(posedge clk) begin
    if(count3>=6'b011101) begin //delayFirst: 29
        if(count3<=6'b011110) //delaySecond: 30     bit: 6
            co3=1;
        else begin
            co3=0;
        end
    end
    else
        co3=0;
end

always @(posedge clk) begin
    last_res_3 <= out[5];
    if(co3 & en_n3) detect3 <= detect_n3;
    else detect3 <= detect3;
    clk_start3 <= clk_start_n3;
end

assign detect_n3 = detect3 | (~last_res_3 & out[5]);
assign clk_start_n3 = clk_start3 | co3 & en_n3;
assign z3 = (~detect_n3 & (clk_start_n3 & ~co3));
endmodule
