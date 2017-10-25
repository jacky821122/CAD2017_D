module fsm(clk, rst, in, out);
input clk, rst;
input [6:0] in;
output [18:0] out;
reg [18:0] out;
reg [7:0] pstate, nstate;
parameter S0=8'd0, S1=8'd1, S2=8'd2, S3=8'd3, S4=8'd4,
S5=8'd5, S6=8'd6, S7=8'd7, S8=8'd8, S9=8'd9,
S10=8'd10, S11=8'd11, S12=8'd12, S13=8'd13, S14=8'd14,
S15=8'd15, S16=8'd16, S17=8'd17, S18=8'd18, S19=8'd19,
S20=8'd20, S21=8'd21, S22=8'd22, S23=8'd23, S24=8'd24,
S25=8'd25, S26=8'd26, S27=8'd27, S28=8'd28, S29=8'd29,
S30=8'd30, S31=8'd31, S32=8'd32, S33=8'd33, S34=8'd34,
S35=8'd35, S36=8'd36, S37=8'd37, S38=8'd38, S39=8'd39,
S40=8'd40, S41=8'd41, S42=8'd42, S43=8'd43, S44=8'd44,
S45=8'd45, S46=8'd46, S47=8'd47, S48=8'd48, S49=8'd49,
S50=8'd50, S51=8'd51, S52=8'd52, S53=8'd53, S54=8'd54,
S55=8'd55, S56=8'd56, S57=8'd57, S58=8'd58, S59=8'd59,
S60=8'd60, S61=8'd61, S62=8'd62, S63=8'd63, S64=8'd64,
S65=8'd65, S66=8'd66, S67=8'd67, S68=8'd68, S69=8'd69,
S70=8'd70, S71=8'd71, S72=8'd72, S73=8'd73, S74=8'd74,
S75=8'd75, S76=8'd76, S77=8'd77, S78=8'd78, S79=8'd79,
S80=8'd80, S81=8'd81, S82=8'd82, S83=8'd83, S84=8'd84,
S85=8'd85, S86=8'd86, S87=8'd87, S88=8'd88, S89=8'd89,
S90=8'd90, S91=8'd91, S92=8'd92, S93=8'd93, S94=8'd94,
S95=8'd95;

always @(posedge clk or posedge rst) begin
 if (rst) pstate <= S0; 
 else pstate <= nstate;
end

always @(in or pstate) begin
case (pstate)
S0: casex(in)
  7'bxxxxxxx: begin nstate=S1; out =19'b0000000000101000000; end
  endcase
S1: casex(in)
  7'bxxxx01x: begin nstate=S1; out =19'b0000000000100000000; end
  7'bxxxx10x: begin nstate=S1; out =19'b0000000000100000000; end
  7'bxxxx00x: begin nstate=S1; out =19'b0000000000100000000; end
  7'bxxxx11x: begin nstate=S2; out =19'b0000000000100000000; end
  endcase
S2: casex(in)
  7'bxxxxxx0: begin nstate=S3; out =19'b0000000000000000000; end
  7'bxxx0xxx: begin nstate=S3; out =19'b0000000000000000000; end
  7'bxxx1xx1: begin nstate=S0; out =19'b0000100000000000000; end
  endcase
S3: casex(in)
  7'b11xxxxx: begin nstate=S4; out =19'b0000000000000000000; end
  7'b10xxxxx: begin nstate=S4; out =19'b0000000000000000000; end
  7'b0x0x01x: begin nstate=S4; out =19'b0000000000000000000; end
  7'b0x0x10x: begin nstate=S4; out =19'b0000100000000000000; end
  7'b0x0x11x: begin nstate=S42; out =19'b0000000000000000000; end
  7'b0x0x00x: begin nstate=S4; out =19'b0000000000000000000; end
  7'b0x1x01x: begin nstate=S4; out =19'b0000000000000000000; end
  7'b0x1x10x: begin nstate=S4; out =19'b0000000000000000000; end
  7'b0x1x11x: begin nstate=S42; out =19'b0001000000000000000; end
  7'b0x1x00x: begin nstate=S4; out =19'b0000000000000000000; end
  endcase
S4: casex(in)
  7'bxxxxxxx: begin nstate=S5; out =19'b0000000000000000000; end
  endcase
S5: casex(in)
  7'bxx0xxxx: begin nstate=S6; out =19'b0000100000000000000; end
  7'bxx1xxxx: begin nstate=S6; out =19'b0000000000000000000; end
  endcase
S6: casex(in)
  7'bx1xxxx0: begin nstate=S7; out =19'b0000000000000000000; end
  7'bx110xx1: begin nstate=S7; out =19'b0000000000000000000; end
  7'bx10xxx1: begin nstate=S41; out =19'b0000000000000000000; end
  7'bx111xx1: begin nstate=S38; out =19'b0001000000000000000; end
  7'bx0xxxxx: begin nstate=S7; out =19'b0000000000000000000; end
  endcase
S7: casex(in)
  7'bxx1xxxx: begin nstate=S8; out =19'b0000000000000000000; end
  7'bxx0xxxx: begin nstate=S8; out =19'b0000100000000000000; end
  endcase
S8: casex(in)
  7'bxx0xxxx: begin nstate=S10; out =19'b0000000000000000000; end
  7'bxx1xxxx: begin nstate=S9; out =19'b0000100000000000000; end
  endcase
S9: casex(in)
  7'bx11xxxx: begin nstate=S11; out =19'b0001000000000000000; end
  7'bx01xxxx: begin nstate=S11; out =19'b0000000000000000000; end
  7'bx10xxxx: begin nstate=S11; out =19'b0000000000000000000; end
  7'bx00xxxx: begin nstate=S11; out =19'b0000000000000000000; end
  endcase
S10: casex(in)
  7'bxx1xxxx: begin nstate=S12; out =19'b0010000000000000000; end
  7'bxx0xxxx: begin nstate=S12; out =19'b0000000000000000000; end
  endcase
S11: casex(in)
  7'bxxxxxxx: begin nstate=S13; out =19'b0000000000000000000; end
  endcase
S12: casex(in)
  7'bxxxxxxx: begin nstate=S14; out =19'b0000000000000000000; end
  endcase
S13: casex(in)
  7'bx11xxxx: begin nstate=S15; out =19'b0000000000000000000; end
  7'bx10xxxx: begin nstate=S15; out =19'b0000000000000000000; end
  7'bx01xxxx: begin nstate=S15; out =19'b0000000000000000000; end
  7'bx00xxxx: begin nstate=S15; out =19'b0000000000000000000; end
  endcase
S14: casex(in)
  7'bxx1xxxx: begin nstate=S15; out =19'b0000000000000000000; end
  7'bxx0xxxx: begin nstate=S15; out =19'b0010000000000000000; end
  endcase
S15: casex(in)
  7'bxxxxxxx: begin nstate=S16; out =19'b0000000000000000000; end
  endcase
S16: casex(in)
  7'bxx1xxxx: begin nstate=S17; out =19'b0000000000000000000; end
  7'bxx0xxxx: begin nstate=S17; out =19'b0000000000000000000; end
  endcase
S17: casex(in)
  7'bxxx0xxx: begin nstate=S18; out =19'b0000000000000000000; end
  7'b01x1xxx: begin nstate=S19; out =19'b0010000000000000000; end
  7'b00x1xx0: begin nstate=S19; out =19'b0010000000000000000; end
  7'b00x1xx1: begin nstate=S46; out =19'b0010000000000000000; end
  7'b11x1xxx: begin nstate=S24; out =19'b0000000000000000000; end
  7'b10x1xx0: begin nstate=S24; out =19'b0000000000000000000; end
  7'b10x1xx1: begin nstate=S18; out =19'b0010000000000000000; end
  endcase
S18: casex(in)
  7'bxx1xxxx: begin nstate=S83; out =19'b0010000000000000000; end
  7'b0x0xxxx: begin nstate=S2; out =19'b0001000000000000000; end
  7'b1x0xxxx: begin nstate=S2; out =19'b0001000000000000000; end
  endcase
S19: casex(in)
  7'bx10xxxx: begin nstate=S20; out =19'b0010000000000000000; end
  7'bx00xxxx: begin nstate=S20; out =19'b0010000000000000000; end
  7'bxx1xxxx: begin nstate=S25; out =19'b0010000000000000000; end
  endcase
S20: casex(in)
  7'bx10xxxx: begin nstate=S19; out =19'b0000000000000000000; end
  7'bx11xxxx: begin nstate=S21; out =19'b0010000000000000000; end
  7'bx01xxxx: begin nstate=S19; out =19'b0000000000000000000; end
  7'bx00xxxx: begin nstate=S21; out =19'b0010000000000000000; end
  endcase
S21: casex(in)
  7'bx10xxxx: begin nstate=S22; out =19'b0010000000000000000; end
  7'bx11xxxx: begin nstate=S23; out =19'b0010000000000000000; end
  7'bx00xxxx: begin nstate=S22; out =19'b0010000000000000000; end
  7'bx01xxxx: begin nstate=S23; out =19'b0000000000000000000; end
  endcase
S22: casex(in)
  7'bxxxxxxx: begin nstate=S19; out =19'b0010000000000000000; end
  endcase
S23: casex(in)
  7'bxxxxxxx: begin nstate=S24; out =19'b0010000000000000000; end
  endcase
S24: casex(in)
  7'bxxxxxxx: begin nstate=S25; out =19'b0010000000000000000; end
  endcase
S25: casex(in)
  7'bxxx0xx0: begin nstate=S26; out =19'b0000000000000000000; end
  7'bxxx1xx0: begin nstate=S28; out =19'b0010000000000000000; end
  7'bxxxxxx1: begin nstate=S30; out =19'b0010000000000000000; end
  endcase
S26: casex(in)
  7'bxx0x01x: begin nstate=S27; out =19'b0000000000000000000; end
  7'bxx0x10x: begin nstate=S27; out =19'b0000000000000000000; end
  7'bxx0x00x: begin nstate=S27; out =19'b0010000000000000000; end
  7'bxx0x11x: begin nstate=S42; out =19'b0000000000000000000; end
  7'bxx1xxxx: begin nstate=S25; out =19'b0010000000000000000; end
  endcase
S27: casex(in)
  7'bxxxxxxx: begin nstate=S26; out =19'b0010000000000000000; end
  endcase
S28: casex(in)
  7'bxxxxxxx: begin nstate=S29; out =19'b0010000000000000000; end
  endcase
S29: casex(in)
  7'bxxx1xxx: begin nstate=S26; out =19'b0010000000000000000; end
  7'bxx10xxx: begin nstate=S3; out =19'b0000000000000000000; end
  7'bxx00xxx: begin nstate=S3; out =19'b0001000000000000000; end
  endcase
S30: casex(in)
  7'bxxxxxxx: begin nstate=S31; out =19'b0000000000000000000; end
  endcase
S31: casex(in)
  7'bxxx0xxx: begin nstate=S26; out =19'b0010000000000000000; end
  7'bxxx1xxx: begin nstate=S32; out =19'b0000000000000000000; end
  endcase
S32: casex(in)
  7'bxx0xxxx: begin nstate=S33; out =19'b0000000000000000000; end
  7'bxx1xxxx: begin nstate=S35; out =19'b0000000000000000000; end
  endcase
S33: casex(in)
  7'bxx10xxx: begin nstate=S34; out =19'b0010000000000000000; end
  7'bxx0xxxx: begin nstate=S34; out =19'b0010000000000000000; end
  7'bxxx1xxx: begin nstate=S34; out =19'b0010000000000000000; end
  endcase
S34: casex(in)
  7'bxx1xxxx: begin nstate=S35; out =19'b0010000000000000000; end
  7'bxx0xxxx: begin nstate=S35; out =19'b0010000000000000000; end
  endcase
S35: casex(in)
  7'bxxxxxxx: begin nstate=S36; out =19'b0010000000000000000; end
  endcase
S36: casex(in)
  7'bxx0xxxx: begin nstate=S37; out =19'b0010000000000000000; end
  7'bxx1xxxx: begin nstate=S37; out =19'b0010000000000000000; end
  endcase
S37: casex(in)
  7'bxxxxxxx: begin nstate=S9; out =19'b0000000000000000000; end
  endcase
S38: casex(in)
  7'bxx0x01x: begin nstate=S39; out =19'b0010000000001000000; end
  7'bxx0x10x: begin nstate=S39; out =19'b0000000000000000000; end
  7'bxx0x11x: begin nstate=S42; out =19'b0000000000000000000; end
  7'bxx0x00x: begin nstate=S39; out =19'b0000000000000000000; end
  7'bxx1xxxx: begin nstate=S40; out =19'b0010000000000000000; end
  endcase
S39: casex(in)
  7'bxxxxxxx: begin nstate=S38; out =19'b0010000000000000000; end
  endcase
S40: casex(in)
  7'bxxxxxxx: begin nstate=S41; out =19'b0010000000001000000; end
  endcase
S41: casex(in)
  7'bxxxxxxx: begin nstate=S42; out =19'b0010000000000000000; end
  endcase
S42: casex(in)
  7'bxxxxxxx: begin nstate=S43; out =19'b0010000000001000000; end
  endcase
S43: casex(in)
  7'bxx0xxxx: begin nstate=S44; out =19'b0000000000000000000; end
  7'bxx1xxxx: begin nstate=S44; out =19'b0010000000000000000; end
  endcase
S44: casex(in)
  7'bxxxxxxx: begin nstate=S45; out =19'b0010000000000000000; end
  endcase
S45: casex(in)
  7'bxx0xxxx: begin nstate=S83; out =19'b0010000000000000000; end
  7'bxx1xxxx: begin nstate=S6; out =19'b0000000000000000000; end
  endcase
S46: casex(in)
  7'bxx0xxxx: begin nstate=S47; out =19'b0000000000000000000; end
  7'bxx1xxxx: begin nstate=S0; out =19'b0000000000000000000; end
  endcase
S47: casex(in)
  7'bxxxxxxx: begin nstate=S46; out =19'b0010000000000000000; end
  endcase
S48: casex(in)
  7'bxxx0000: begin nstate=S49; out =19'b0010000000101001111; end
  7'bxxx0100: begin nstate=S50; out =19'b0010000000101000110; end
  7'bxxx0010: begin nstate=S50; out =19'b0000000000101000110; end
  7'bxxx0001: begin nstate=S50; out =19'b0010000000101000110; end
  7'bxxx1100: begin nstate=S51; out =19'b0010000000101001110; end
  7'bxxx1000: begin nstate=S51; out =19'b0000000000101000100; end
  7'bxxx011x: begin nstate=S48; out =19'b0000000000101000110; end
  7'bxxx01x1: begin nstate=S48; out =19'b0000000000101001110; end
  7'bxxx101x: begin nstate=S48; out =19'b0000000000101000110; end
  7'bxxx10x1: begin nstate=S48; out =19'b0000000000101000110; end
  7'bxxx111x: begin nstate=S48; out =19'b0000000000101000110; end
  7'bxxx11x1: begin nstate=S48; out =19'b0010000000101001110; end
  7'bxxxxx11: begin nstate=S48; out =19'b0010000000101000110; end
  endcase
S49: casex(in)
  7'b0000000: begin nstate=S52; out =19'b0010000000000000010; end
  7'b1000000: begin nstate=S53; out =19'b0010000000000001100; end
  7'b0100000: begin nstate=S53; out =19'b0010000000000000100; end
  7'b0010000: begin nstate=S53; out =19'b0010000000000000100; end
  7'b0001000: begin nstate=S53; out =19'b0010000000000000100; end
  7'b0000100: begin nstate=S53; out =19'b0000000000000000100; end
  7'b0000010: begin nstate=S53; out =19'b0000000000000001000; end
  7'b0000001: begin nstate=S53; out =19'b0000000000000000100; end
  7'b11xxxxx: begin nstate=S48; out =19'b0000000000000000000; end
  7'b1x1xxxx: begin nstate=S48; out =19'b0000000000000000000; end
  7'b1xx1xxx: begin nstate=S48; out =19'b0010000000000000000; end
  7'b1xxx1xx: begin nstate=S48; out =19'b0010000000000000000; end
  7'b1xxxx1x: begin nstate=S48; out =19'b0000000000000000000; end
  7'b1xxxxx1: begin nstate=S48; out =19'b0000000000000000000; end
  7'bx11xxxx: begin nstate=S48; out =19'b0000000000000001000; end
  7'bx1x1xxx: begin nstate=S48; out =19'b0010000000000001010; end
  7'bx1xx1xx: begin nstate=S48; out =19'b0010000000000000000; end
  7'bx1xxx1x: begin nstate=S48; out =19'b0000000000000000000; end
  7'bx1xxxx1: begin nstate=S48; out =19'b0010000000000000010; end
  7'bxx11xxx: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxx1x1xx: begin nstate=S48; out =19'b0010000000000000000; end
  7'bxx1xx1x: begin nstate=S48; out =19'b0000000000000000010; end
  7'bxx1xxx1: begin nstate=S48; out =19'b0000000000000000010; end
  7'bxxx11xx: begin nstate=S48; out =19'b0000000000000001000; end
  7'bxxx1x1x: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxxx1xx1: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxxxx11x: begin nstate=S48; out =19'b0010000000000000000; end
  7'bxxxx1x1: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxxxxx11: begin nstate=S48; out =19'b0010000000000000000; end
  endcase
S50: casex(in)
  7'b0000000: begin nstate=S53; out =19'b0000000000000000000; end
  7'b1xxxxxx: begin nstate=S48; out =19'b0000000000000001000; end
  7'bx1xxxxx: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxx1xxxx: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxxx1xxx: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxxxx1xx: begin nstate=S48; out =19'b0010000000000000000; end
  7'bxxxxx1x: begin nstate=S48; out =19'b0010000000000000000; end
  7'bxxxxxx1: begin nstate=S48; out =19'b0010000000000001000; end
  endcase
S51: casex(in)
  7'b0000000: begin nstate=S54; out =19'b0010000000000000010; end
  7'b0011000: begin nstate=S53; out =19'b0000000000000000010; end
  7'b0000100: begin nstate=S53; out =19'b0000000000000000010; end
  7'b0000010: begin nstate=S53; out =19'b0000000000000000010; end
  7'b0000001: begin nstate=S53; out =19'b0010000000000001010; end
  7'b1xxxxxx: begin nstate=S48; out =19'b0010000000000000010; end
  7'bx1xxxxx: begin nstate=S48; out =19'b0010000000000000010; end
  7'bxx01xxx: begin nstate=S48; out =19'b0010000000000000010; end
  7'bxx10xxx: begin nstate=S48; out =19'b0000000000000000010; end
  7'bxx111xx: begin nstate=S48; out =19'b0000000000000001010; end
  7'bxx11x1x: begin nstate=S48; out =19'b0000000000000000010; end
  7'bxx11xx1: begin nstate=S48; out =19'b0000000000000000010; end
  7'bxxxx11x: begin nstate=S48; out =19'b0000000000000000010; end
  7'bxxxx1x1: begin nstate=S48; out =19'b0010000000000000010; end
  7'bxxxxx11: begin nstate=S48; out =19'b0000000000000000010; end
  endcase
S52: casex(in)
  7'bx000000: begin nstate=S55; out =19'b0000000000000000000; end
  7'bx100000: begin nstate=S56; out =19'b0000000000000000000; end
  7'bx010000: begin nstate=S56; out =19'b0000000000000001000; end
  7'bx001000: begin nstate=S56; out =19'b0000000000000000000; end
  7'bx000100: begin nstate=S56; out =19'b0000000000000000000; end
  7'bx000010: begin nstate=S56; out =19'b0000000000000000000; end
  7'bx000001: begin nstate=S56; out =19'b0000000000000000000; end
  7'bx11xxxx: begin nstate=S48; out =19'b0000000000000000000; end
  7'bx1x1xxx: begin nstate=S48; out =19'b0010000000000001000; end
  7'bx1xx1xx: begin nstate=S48; out =19'b0000000000000000000; end
  7'bx1xxx1x: begin nstate=S48; out =19'b0000000000000000000; end
  7'bx1xxxx1: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxx11xxx: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxx1x1xx: begin nstate=S48; out =19'b0000000000000001000; end
  7'bxx1xx1x: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxx1xxx1: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxxx11xx: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxxx1x1x: begin nstate=S48; out =19'b0000000000000001000; end
  7'bxxx1xx1: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxxxx11x: begin nstate=S48; out =19'b0010000000000000000; end
  7'bxxxx1x1: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxxxxx11: begin nstate=S48; out =19'b0000000000000000000; end
  endcase
S53: casex(in)
  7'bx000000: begin nstate=S56; out =19'b0000000000000001000; end
  7'bx1xxxxx: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxx1xxxx: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxxx1xxx: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxxxx1xx: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxxxxx1x: begin nstate=S48; out =19'b0000000000000001000; end
  7'bxxxxxx1: begin nstate=S48; out =19'b0000000000000000000; end
  endcase
S54: casex(in)
  7'bx011000: begin nstate=S56; out =19'b0010000000000000000; end
  7'bx000100: begin nstate=S56; out =19'b0000000000000000000; end
  7'bx000010: begin nstate=S56; out =19'b0000000000000000000; end
  7'bx000001: begin nstate=S56; out =19'b0000000000000001000; end
  7'bx000000: begin nstate=S57; out =19'b0000000000000000000; end
  7'bx1xxxxx: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxx01xxx: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxx10xxx: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxx111xx: begin nstate=S48; out =19'b0000000000000001000; end
  7'bxx11x1x: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxx11xx1: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxxxx11x: begin nstate=S48; out =19'b0010000000000001000; end
  7'bxxxx1x1: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxxxxx11: begin nstate=S48; out =19'b0000000000000000000; end
  endcase
S55: casex(in)
  7'bxx00000: begin nstate=S58; out =19'b0000000000000000000; end
  7'bxx10000: begin nstate=S59; out =19'b0000000000000001100; end
  7'bxx01000: begin nstate=S59; out =19'b0000000000000000100; end
  7'bxx00100: begin nstate=S59; out =19'b0000000000000000100; end
  7'bxx00010: begin nstate=S59; out =19'b0000000000000000100; end
  7'bxx00001: begin nstate=S59; out =19'b0010000000000000100; end
  7'bxx11xxx: begin nstate=S48; out =19'b0000000000000000100; end
  7'bxx1x1xx: begin nstate=S48; out =19'b0000000000000001100; end
  7'bxx1xx1x: begin nstate=S48; out =19'b0000000000000000100; end
  7'bxx1xxx1: begin nstate=S48; out =19'b0000000000000000100; end
  7'bxxx11xx: begin nstate=S48; out =19'b0000000000000001100; end
  7'bxxx1x1x: begin nstate=S48; out =19'b0000000000000000100; end
  7'bxxx1xx1: begin nstate=S48; out =19'b0010000000000000100; end
  7'bxxxx11x: begin nstate=S48; out =19'b0000000000000000100; end
  7'bxxxx1x1: begin nstate=S48; out =19'b0000000000000001100; end
  7'bxxxxx11: begin nstate=S48; out =19'b0000000000000000100; end
  endcase
S56: casex(in)
  7'bxx00000: begin nstate=S59; out =19'b0000000000000000110; end
  7'bxx1xxxx: begin nstate=S48; out =19'b0000000000000001010; end
  7'bxxx1xxx: begin nstate=S48; out =19'b0000000000000000010; end
  7'bxxxx1xx: begin nstate=S48; out =19'b0000000000000001010; end
  7'bxxxxx1x: begin nstate=S48; out =19'b0010000000000001010; end
  7'bxxxxxx1: begin nstate=S48; out =19'b0000000000000000010; end
  endcase
S57: casex(in)
  7'bxx00000: begin nstate=S60; out =19'b0000000000000000000; end
  7'bxx11000: begin nstate=S59; out =19'b0000000000000000000; end
  7'bxx00100: begin nstate=S59; out =19'b0000000000000000000; end
  7'bxx00010: begin nstate=S59; out =19'b0000000000000000000; end
  7'bxx00001: begin nstate=S59; out =19'b0000000000000001000; end
  7'bxx01xxx: begin nstate=S48; out =19'b0010000000000001000; end
  7'bxx10xxx: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxx111xx: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxx11x1x: begin nstate=S48; out =19'b0000000000000001000; end
  7'bxx11xx1: begin nstate=S48; out =19'b0000000000000001000; end
  7'bxxxx11x: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxxxx1x1: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxxxxx11: begin nstate=S48; out =19'b0000000000000001000; end
  endcase
S58: casex(in)
  7'bxxxx000: begin nstate=S61; out =19'b0000000000000001100; end
  7'bxxxx100: begin nstate=S62; out =19'b0000000000000000000; end
  7'bxxxx010: begin nstate=S62; out =19'b0010000000000000000; end
  7'bxxxx001: begin nstate=S62; out =19'b0000000000000001000; end
  7'bxxxx11x: begin nstate=S48; out =19'b0000000000000000100; end
  7'bxxxx1x1: begin nstate=S48; out =19'b0000000000000000100; end
  7'bxxxxx11: begin nstate=S48; out =19'b0000000000000001100; end
  endcase
S59: casex(in)
  7'bxxxx000: begin nstate=S62; out =19'b0000000000000000000; end
  7'bxxxx1xx: begin nstate=S48; out =19'b0000000000000001000; end
  7'bxxxxx1x: begin nstate=S48; out =19'b0000000000000000000; end
  7'bxxxxxx1: begin nstate=S48; out =19'b0000000000000000000; end
  endcase
S60: casex(in)
  7'bxxxxx00: begin nstate=S62; out =19'b0000000000000001000; end
  7'bxxxxx1x: begin nstate=S48; out =19'b0000000000000001000; end
  7'bxxxxxx1: begin nstate=S48; out =19'b0000000000000000000; end
  endcase
S61: casex(in)
  7'bxxxxx00: begin nstate=S63; out =19'b0000000000000000000; end
  7'bxxxxx10: begin nstate=S64; out =19'b0000000000000000000; end
  7'bxxxxx01: begin nstate=S64; out =19'b0000000000000001000; end
  7'bxxxxx11: begin nstate=S48; out =19'b0000000000000001000; end
  endcase
S62: casex(in)
  7'bxxxxx00: begin nstate=S64; out =19'b0010000000000000100; end
  7'bxxxxx1x: begin nstate=S48; out =19'b0000000000000000100; end
  7'bxxxxxx1: begin nstate=S48; out =19'b0000000000000001000; end
  endcase
S63: casex(in)
  7'bxxxxxx0: begin nstate=S65; out =19'b0000000000000000000; end
  7'bxxxxxx1: begin nstate=S66; out =19'b1000000000000000000; end
  endcase
S64: casex(in)
  7'bxxxxxx0: begin nstate=S66; out =19'b0000000000000001000; end
  7'bxxxxxx1: begin nstate=S48; out =19'b0000000000000000000; end
  endcase
S65: casex(in)
  7'bxxxxxxx: begin nstate=S48; out =19'b0000000000000000000; end
  endcase
S66: casex(in)
  7'bxxxxxxx: begin nstate=S48; out =19'b0110000000000001000; end
  endcase
S67: casex(in)
  7'b1x000xx: begin nstate=S67; out =19'b0000000000000000000; end
  7'b1x11xxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'b1x1x1xx: begin nstate=S67; out =19'b0000000000000000000; end
  7'b10010xx: begin nstate=S68; out =19'b0000000000000000000; end
  7'b10011xx: begin nstate=S76; out =19'b0000000000000000000; end
  7'b10001xx: begin nstate=S73; out =19'b0000000000000000000; end
  7'b10100xx: begin nstate=S75; out =19'b0000000000000000000; end
  7'b0xxxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'bx1xxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  endcase
S68: casex(in)
  7'b101xxxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'b10010xx: begin nstate=S68; out =19'b0000000000000000000; end
  7'b1000xxx: begin nstate=S69; out =19'b0000000010000000000; end
  7'b0xxxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'bx1xxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  endcase
S69: casex(in)
  7'b10010xx: begin nstate=S68; out =19'b0000000000000000000; end
  7'b10011xx: begin nstate=S72; out =19'b0000000000000000000; end
  7'b10000xx: begin nstate=S69; out =19'b0000000000000000000; end
  7'b10001xx: begin nstate=S70; out =19'b0000000100000000000; end
  7'b101xxxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'b0xxxxx0: begin nstate=S67; out =19'b0000000000000000000; end
  7'b0xxxxx1: begin nstate=S67; out =19'b0000000000000000000; end
  7'bx1xxxx0: begin nstate=S67; out =19'b0000000000000000000; end
  7'bx1xxxx1: begin nstate=S67; out =19'b0000000000000000000; end
  endcase
S70: casex(in)
  7'b10001xx: begin nstate=S70; out =19'b0000000000000000000; end
  7'b100x0xx: begin nstate=S71; out =19'b0000000000000000000; end
  7'b101xxxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'b0xxxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'bx1xxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  endcase
S71: casex(in)
  7'b101xxxx: begin nstate=S67; out =19'b0000001000000000000; end
  7'b10010xx: begin nstate=S68; out =19'b0000000000000000000; end
  7'b1000xxx: begin nstate=S71; out =19'b0000000000000000000; end
  7'b10011xx: begin nstate=S72; out =19'b0000000000000000000; end
  7'b0xxxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'bx1xxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  endcase
S72: casex(in)
  7'b10x1xxx: begin nstate=S72; out =19'b0000000000000000000; end
  7'b10x0xxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'b0xxxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'bx1xxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  endcase
S73: casex(in)
  7'b10xx1xx: begin nstate=S73; out =19'b0000000000000000000; end
  7'b101xxxx: begin nstate=S73; out =19'b0000000000000000000; end
  7'b100x0xx: begin nstate=S74; out =19'b0000000000000000000; end
  7'b0xxxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'bx1xxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  endcase
S74: casex(in)
  7'b100xx0x: begin nstate=S74; out =19'b0000000000000000000; end
  7'b101xx0x: begin nstate=S73; out =19'b0000000000000000000; end
  7'b10xxx1x: begin nstate=S67; out =19'b0000000000000000000; end
  7'b0xxxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'bx1xxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  endcase
S75: casex(in)
  7'b10x00xx: begin nstate=S75; out =19'b0000000000000000000; end
  7'b10010xx: begin nstate=S76; out =19'b0000000000000000000; end
  7'b10x01xx: begin nstate=S77; out =19'b0000000000000000000; end
  7'b0xxxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'bx1xxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'b10x11xx: begin nstate=S67; out =19'b0000000000000000000; end
  endcase
S76: casex(in)
  7'b10x1xxx: begin nstate=S76; out =19'b0000000000000000000; end
  7'b10x0xxx: begin nstate=S74; out =19'b0000000000000000000; end
  7'b0xxxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'bx1xxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  endcase
S77: casex(in)
  7'b10x0xxx: begin nstate=S77; out =19'b0000000000000000000; end
  7'b10x10xx: begin nstate=S78; out =19'b0000000000000000000; end
  7'b0xxxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'bx1xxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'b10x11xx: begin nstate=S67; out =19'b0000000000000000000; end
  endcase
S78: casex(in)
  7'b10x10xx: begin nstate=S78; out =19'b0000000000000000000; end
  7'b10x0xxx: begin nstate=S79; out =19'b0000000000000000000; end
  7'b0xxxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'bx1xxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'b10x11xx: begin nstate=S67; out =19'b0000000000000000000; end
  endcase
S79: casex(in)
  7'b10x0xxx: begin nstate=S79; out =19'b0000000000000000000; end
  7'b10x10xx: begin nstate=S80; out =19'b0000000000000000000; end
  7'b0xxxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'bx1xxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'b10x11xx: begin nstate=S67; out =19'b0000000000000000000; end
  endcase
S80: casex(in)
  7'b10x10xx: begin nstate=S80; out =19'b0000000000000000000; end
  7'b10x01xx: begin nstate=S80; out =19'b0000000000000000000; end
  7'b10100xx: begin nstate=S81; out =19'b0000000000000000000; end
  7'b10000xx: begin nstate=S82; out =19'b0000000000000000000; end
  7'b0xxxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'bx1xxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  endcase
S81: casex(in)
  7'bxx111xx: begin nstate=S81; out =19'b0000000000000000000; end
  7'bxx100xx: begin nstate=S81; out =19'b0000000000000000000; end
  7'bxx110xx: begin nstate=S80; out =19'b0000000000000000000; end
  7'bxx101xx: begin nstate=S80; out =19'b0000000000000000000; end
  7'bxx0xxxx: begin nstate=S67; out =19'b0000000000000000000; end
  endcase
S82: casex(in)
  7'b10000xx: begin nstate=S82; out =19'b0000000000000000000; end
  7'b10010xx: begin nstate=S80; out =19'b0000000000000000000; end
  7'b10001xx: begin nstate=S80; out =19'b0000000000000000000; end
  7'b101xxxx: begin nstate=S75; out =19'b0000000000000000000; end
  7'b0xxxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'bx1xxxxx: begin nstate=S67; out =19'b0000000000000000000; end
  7'b10011xx: begin nstate=S67; out =19'b0000000000000000000; end
  endcase
S83: casex(in)
  7'bxxxx11x: begin nstate=S84; out =19'b0000000000101000000; end
  7'bxxxx100: begin nstate=S84; out =19'b0000000000101000000; end
  7'bxx1x101: begin nstate=S87; out =19'b0000000000101000000; end
  7'bxx0x101: begin nstate=S94; out =19'b0000000000111000000; end
  7'bxxxx0x0: begin nstate=S84; out =19'b0000000000101000000; end
  7'bxxxx011: begin nstate=S84; out =19'b0000000000101000000; end
  7'bxxxx001: begin nstate=S83; out =19'b0000000000101000000; end
  endcase
S84: casex(in)
  7'bx1xxx00: begin nstate=S85; out =19'b0000000000000000000; end
  7'bx0xxx00: begin nstate=S84; out =19'b0000000000000000000; end
  7'bxxxxx01: begin nstate=S83; out =19'b0000000000000000000; end
  7'bx0xxx10: begin nstate=S84; out =19'b0000000000000000000; end
  7'bx1xxx10: begin nstate=S85; out =19'b0000000000000000000; end
  7'bx0xxx11: begin nstate=S84; out =19'b0000000000000000000; end
  7'bx1xxx11: begin nstate=S86; out =19'b0000000000000000000; end
  endcase
S85: casex(in)
  7'bxxxxx00: begin nstate=S85; out =19'b0000000000000000000; end
  7'b0xxxx01: begin nstate=S83; out =19'b0000000000000000000; end
  7'b1xxxx01: begin nstate=S83; out =19'b0000000000000000000; end
  7'b0xxxx11: begin nstate=S84; out =19'b0000000000000000000; end
  7'b1xxxx11: begin nstate=S84; out =19'b0000000000000000000; end
  7'bxxxxx10: begin nstate=S85; out =19'b0000000000000000000; end
  endcase
S86: casex(in)
  7'bxxxxx00: begin nstate=S84; out =19'b0000000000000000000; end
  7'bxxxxx10: begin nstate=S84; out =19'b0000000000000000000; end
  7'bxxxxx11: begin nstate=S86; out =19'b0000000000000000000; end
  7'bxxxxx01: begin nstate=S83; out =19'b0000000000000000000; end
  endcase
S87: casex(in)
  7'bxxxxxx0: begin nstate=S84; out =19'b0000000000000000000; end
  7'bxxxxx11: begin nstate=S84; out =19'b0000000000000000000; end
  7'bxxxxx01: begin nstate=S88; out =19'b0000000000000000000; end
  endcase
S88: casex(in)
  7'bxx01x01: begin nstate=S87; out =19'b0000000000000000000; end
  7'bxx00x01: begin nstate=S89; out =19'b0000000000000000000; end
  7'bxx1xx01: begin nstate=S87; out =19'b0000000000000000000; end
  7'bxxxxx11: begin nstate=S84; out =19'b0000000000000000000; end
  7'bxxxxxx0: begin nstate=S84; out =19'b0000000000000000000; end
  endcase
S89: casex(in)
  7'bxxxxx1x: begin nstate=S84; out =19'b0000000000000000000; end
  7'bx1xxx01: begin nstate=S90; out =19'b0000000000000000000; end
  7'bx0xxx01: begin nstate=S89; out =19'b0000000000000000000; end
  7'bxxxxx00: begin nstate=S84; out =19'b0000000000000000000; end
  endcase
S90: casex(in)
  7'bxxxxx1x: begin nstate=S84; out =19'b0000000000000000000; end
  7'bxxxxx01: begin nstate=S91; out =19'b0000000000000000000; end
  7'bxxxxx00: begin nstate=S84; out =19'b0000000000000000000; end
  endcase
S91: casex(in)
  7'bx1xxx01: begin nstate=S92; out =19'b0000000000000000000; end
  7'bx0xxx01: begin nstate=S91; out =19'b0000000000000000000; end
  7'bxxxxx11: begin nstate=S84; out =19'b0000000000000000000; end
  7'bxxxxxx0: begin nstate=S84; out =19'b0000000000000000000; end
  endcase
S92: casex(in)
  7'bxxxxxx0: begin nstate=S84; out =19'b0000000000000000000; end
  7'bxxxxx11: begin nstate=S84; out =19'b0000000000000000000; end
  7'bxxxxx01: begin nstate=S93; out =19'b0000000000000000000; end
  endcase
S93: casex(in)
  7'bxxxxx1x: begin nstate=S84; out =19'b0000000000000000000; end
  7'bxx10x00: begin nstate=S84; out =19'b0000000000000000000; end
  7'bxx00x00: begin nstate=S84; out =19'b0000000000000000000; end
  7'bxxx1x00: begin nstate=S84; out =19'b0000000000000000000; end
  7'bxxx1101: begin nstate=S92; out =19'b0000000000000100000; end
  7'bxx10101: begin nstate=S83; out =19'b0000000000000000000; end
  7'bxx00101: begin nstate=S89; out =19'b0000000000000000000; end
  7'bxx10001: begin nstate=S83; out =19'b0000000000000000000; end
  7'bxx11001: begin nstate=S93; out =19'b0000000000000000000; end
  7'bxx00001: begin nstate=S89; out =19'b0000000000000000000; end
  7'bxx01001: begin nstate=S93; out =19'b0000000000000000000; end
  endcase
S94: casex(in)
  7'bxxxxxx0: begin nstate=S84; out =19'b0000000000000000000; end
  7'bxxxxx01: begin nstate=S95; out =19'b0000000000000000000; end
  7'bxxxxx11: begin nstate=S48; out =19'b0000000000000000000; end
  endcase
S95: casex(in)
  7'bxxxxx1x: begin nstate=S84; out =19'b0000000000000000000; end
  7'bxxxxx00: begin nstate=S84; out =19'b0000000000000000000; end
  7'bxx1xx01: begin nstate=S87; out =19'b0000000000000000000; end
  7'bxx0xx01: begin nstate=S94; out =19'b0000000000000000000; end
  endcase
endcase
end

assertion_rule1: assert property
        (@(posedge clk) $rose(out[10])|->##[12:13] $rose(out[11]))
         else $display("assertion rule 1 failed");

assertion_rule2: assert property
        (@(posedge clk) $rose(out[11])|->##[10:11] $rose(out[11]))
         else $display("assertion rule 2 failed");

assertion_rule3: assert property
        (@(posedge clk) $fell(out[12])|->##[4:13] $fell(out[10]))
         else $display("assertion rule 3 failed");

assertion_rule4: assert property
        (@(posedge clk) $fell(out[13])|->##[3:6] $rose(out[13]))
         else $display("assertion rule 4 failed");

assertion_rule5: assert property
        (@(posedge clk) $rose(out[14])|->##[1:5] $rose(out[14]))
         else $display("assertion rule 5 failed");

assertion_rule6: assert property
        (@(posedge clk) $rose(in[6])|->##[15:19] $rose(out[13]))
         else $display("assertion rule 6 failed");

assertion_rule7: assert property
        (@(posedge clk) $rose(out[0])|->##[1:4] $rose(out[1]))
         else $display("assertion rule 7 failed");

assertion_rule8: assert property
        (@(posedge clk) $rose(out[0])|->##[1:10] $rose(out[1]))
         else $display("assertion rule 8 failed");

assertion_rule9: assert property
        (@(posedge clk) $fell(out[0])|->##[1:4] $rose(out[1]))
         else $display("assertion rule 9 failed");

assertion_rule10: assert property
        (@(posedge clk) $rose(out[0])|->##[1:5] $rose(out[2]))
         else $display("assertion rule 10 failed");

assertion_rule11: assert property
        (@(posedge clk) $fell(out[0])|->##[40:45] $fell(out[3]))
         else $display("assertion rule 11 failed");

assertion_rule12: assert property
        (@(posedge clk) $fell(out[0])|->##[1:50] $rose(out[3]))
         else $display("assertion rule 12 failed");

assertion_rule13: assert property
        (@(posedge clk) $fell(out[0])|->##[20:50] $rose(out[4]))
         else $display("assertion rule 13 failed");

assertion_rule14: assert property
        (@(posedge clk) $fell(in[3])|->##[31:32] $fell(out[3]))
         else $display("assertion rule 14 failed");

assertion_rule15: assert property
        (@(posedge clk) $rose(in[4])|->##[5:10] $fell(out[4]))
         else $display("assertion rule 15 failed");

assertion_rule16: assert property
        (@(posedge clk) $fell(out[5])|->##[2:30] $rose(out[6]))
         else $display("assertion rule 16 failed");

assertion_rule17: assert property
        (@(posedge clk) $rose(out[7])|->##[1:100] $rose(out[8]))
         else $display("assertion rule 17 failed");


assertion_rule18: assert property
        (@(posedge clk) $rose(out[18])|->##[1:30] $rose(out[17]))
         else $display("assertion rule 18 failed");


assertion_rule19: assert property
        (@(posedge clk) $fell(in[3])|->##[25:25] $rose(out[16]))
         else $display("assertion rule 19 failed");

assertion_rule20: assert property
        (@(posedge clk) $rose(out[16])|->##[5:53] $fell(out[16]))
         else $display("assertion rule 20 failed");

endmodule
