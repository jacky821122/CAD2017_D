module fsm(clk, rst, in, PPI4, z4);
input clk, rst;
input [6:0] in;
reg [6:0] out;
reg [6:0] pstate, nstate;
reg [1:0] p4, n4; //Generated by [ TRIGGER ]
reg en4; //Generated by [ TRIGGER ]
reg [5:0] count4; //Generated by [ COUNTER ]
input PPI4; //Generated by [ COUNTER ]
reg [1:0] tp4,tn4; //Generated by [ DETECTOR ]
output reg z4; //Generated by [ DETECTOR ]
reg co4; //Generated by [ DETECTOR ]
parameter S0=7'd0, S1=7'd1, S2=7'd2, S3=7'd3, S4=7'd4,
S5=7'd5, S6=7'd6, S7=7'd7, S8=7'd8, S9=7'd9,
S10=7'd10, S11=7'd11, S12=7'd12, S13=7'd13, S14=7'd14,
S15=7'd15, S16=7'd16, S17=7'd17, S18=7'd18, S19=7'd19,
S20=7'd20, S21=7'd21, S22=7'd22, S23=7'd23, S24=7'd24,
S25=7'd25, S26=7'd26, S27=7'd27, S28=7'd28, S29=7'd29,
S30=7'd30, S31=7'd31, S32=7'd32, S33=7'd33, S34=7'd34,
S35=7'd35;

always @(posedge clk) begin
  
 pstate <= nstate;
end
always@(clk) begin
  $display("Time:",$time);
  $display("Input: %b  R: %b  Output: %b  pstate: %b  nstate: %b",in,rst,out,pstate,nstate);
end

always @(in or pstate) begin
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

initial begin
    p4=2'b00;
    n4=2'b00;
    tp4=2'b00;
    tn4=2'b00;
    pstate<=S0;
end
always @(posedge clk) begin
    p4<=n4;
    tp4<=tn4;
end
always @(clk) begin
    $display("p4: %b  en4: %b  count4: %b  tp4: %b  co4: %b  x4: %b",p4,en4,count4,tp4,co4,x4);
end

always @(out[0] or p4) begin
    case (p4)
    2'b00: casex(out[0])
        1'b1: begin n4=2'b01; en4=1'b0; end
        1'b0: begin n4=2'b00; en4=1'b0; end
        endcase
    2'b01: casex(out[0])
        1'b1: begin n4=2'b01; en4=1'b0; end
        1'b0: case(PPI4)
            1'b0: begin n4=2'b10; en4=1'b0; end
            1'b1: begin n4=2'b11; en4=1'b1; end
            endcase
        endcase
    2'b10: casex(out[0])
        1'b1: begin n4=2'b01; en4=1'b0; end
        1'b0: begin n4=2'b10; en4=1'b0; end
        endcase
    2'b11: begin n4=2'b11; en4=1'b1; end
    endcase
end

always @(posedge clk) begin
    if(en4) begin
        if(count4==6'b111111) begin
            count4<=count4;
        end
        else
            count4<=count4+1;
    end
    else begin
        count4<=0;
    end
end

always @(count4) begin
    if(count4>=6'b011101) begin
        if(count4<=6'b011111) //delaySecond: 32     bit: 6
            co4=1;
        else begin
            co4=0;
        end
    end
    else
        co4=0;
end

always @(out[5] or tp4 or co4) begin
    case (tp4)
    2'b00: casex(co4&en4)
        1'b0: begin tn4=2'b00; z4=0;end
        1'b1: begin tn4=2'b01; z4=0;end
        endcase
    2'b01: if(~co4) begin tn4=2'b01; z4=1;end
        else casex(out[5])
        1'b0: begin tn4=2'b10; z4=~co4;end
        1'b1: begin tn4=2'b01; z4=~co4;end
        endcase
    2'b10: if(~co4) begin tn4=2'b01; z4=1;end
        else casex(out[5])
        1'b0: begin tn4=2'b10; z4=~co4;end
        1'b1: begin tn4=2'b11; z4=0;end
        endcase
    2'b11: casex(out[5])
        1'b0: begin tn4=2'b11; z4=0;end
        1'b1: begin tn4=2'b11; z4=0;end
        endcase
    endcase
end
endmodule
