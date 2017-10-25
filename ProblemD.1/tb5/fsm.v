module fsm(clk, rst, in, out);
input clk, rst;
input [7:0] in;
output [18:0] out;
reg [18:0] out;
reg [8:0] pstate, nstate;
parameter S0=9'd0, S1=9'd1, S2=9'd2, S3=9'd3, S4=9'd4,
S5=9'd5, S6=9'd6, S7=9'd7, S8=9'd8, S9=9'd9,
S10=9'd10, S11=9'd11, S12=9'd12, S13=9'd13, S14=9'd14,
S15=9'd15, S16=9'd16, S17=9'd17, S18=9'd18, S19=9'd19,
S20=9'd20, S21=9'd21, S22=9'd22, S23=9'd23, S24=9'd24,
S25=9'd25, S26=9'd26, S27=9'd27, S28=9'd28, S29=9'd29,
S30=9'd30, S31=9'd31, S32=9'd32, S33=9'd33, S34=9'd34,
S35=9'd35, S36=9'd36, S37=9'd37, S38=9'd38, S39=9'd39,
S40=9'd40, S41=9'd41, S42=9'd42, S43=9'd43, S44=9'd44,
S45=9'd45, S46=9'd46, S47=9'd47, S48=9'd48, S49=9'd49,
S50=9'd50, S51=9'd51, S52=9'd52, S53=9'd53, S54=9'd54,
S55=9'd55, S56=9'd56, S57=9'd57, S58=9'd58, S59=9'd59,
S60=9'd60, S61=9'd61, S62=9'd62, S63=9'd63, S64=9'd64,
S65=9'd65, S66=9'd66, S67=9'd67, S68=9'd68, S69=9'd69,
S70=9'd70, S71=9'd71, S72=9'd72, S73=9'd73, S74=9'd74,
S75=9'd75, S76=9'd76, S77=9'd77, S78=9'd78, S79=9'd79,
S80=9'd80, S81=9'd81, S82=9'd82, S83=9'd83, S84=9'd84,
S85=9'd85, S86=9'd86, S87=9'd87, S88=9'd88, S89=9'd89,
S90=9'd90, S91=9'd91, S92=9'd92, S93=9'd93, S94=9'd94,
S95=9'd95, S96=9'd96, S97=9'd97, S98=9'd98, S99=9'd99,
S100=9'd100, S101=9'd101, S102=9'd102, S103=9'd103, S104=9'd104,
S105=9'd105, S106=9'd106, S107=9'd107, S108=9'd108, S109=9'd109,
S110=9'd110, S111=9'd111, S112=9'd112, S113=9'd113, S114=9'd114,
S115=9'd115, S116=9'd116, S117=9'd117, S118=9'd118, S119=9'd119,
S120=9'd120, S121=9'd121, S122=9'd122, S123=9'd123, S124=9'd124,
S125=9'd125, S126=9'd126, S127=9'd127, S128=9'd128, S129=9'd129,
S130=9'd130, S131=9'd131, S132=9'd132, S133=9'd133, S134=9'd134,
S135=9'd135, S136=9'd136, S137=9'd137, S138=9'd138, S139=9'd139,
S140=9'd140, S141=9'd141, S142=9'd142, S143=9'd143, S144=9'd144,
S145=9'd145;

always @(posedge clk or posedge rst) begin
 if (rst) pstate <= S0; 
 else pstate <= nstate;
end

always @(in or pstate) begin
case (pstate)
S0: casex(in)
  8'bx1x00xxx: begin nstate=S0; out =19'b1000010000000000000; end
  8'b00xx0xxx: begin nstate=S0; out =19'b1000010000000000000; end
  8'bx0xx1xxx: begin nstate=S1; out =19'b1000110000000000000; end
  8'bx1x01xxx: begin nstate=S1; out =19'b1000110000000000000; end
  8'b01x10xxx: begin nstate=S2; out =19'b1010010000000000000; end
  8'b11x10xxx: begin nstate=S5; out =19'b1110010000000000000; end
  8'bx1x11xxx: begin nstate=S3; out =19'b1010110000000000000; end
  8'b10xx0xxx: begin nstate=S4; out =19'b1100010000000000000; end
  endcase
S1: casex(in)
  8'bx0xxxxxx: begin nstate=S6; out =19'b0001010000000000000; end
  8'bx1x0xxxx: begin nstate=S6; out =19'b0001010000000000000; end
  8'bx1x1xxxx: begin nstate=S7; out =19'b0011010000000000000; end
  endcase
S2: casex(in)
  8'b0xxx0xxx: begin nstate=S2; out =19'b0010010000000000000; end
  8'bxxxx1xxx: begin nstate=S3; out =19'b0010110000000000000; end
  8'b1xxx0xxx: begin nstate=S5; out =19'b0110010000000000000; end
  endcase
S3: casex(in)
  8'bxxxxxxxx: begin nstate=S7; out =19'b0011010000000000000; end
  endcase
S4: casex(in)
  8'bxx0xxxxx: begin nstate=S12; out =19'b1000010000000000000; end
  8'bxx1xxxxx: begin nstate=S13; out =19'b1010010000000000000; end
  endcase
S5: casex(in)
  8'bxxxxxxxx: begin nstate=S13; out =19'b1010010000000000000; end
  endcase
S6: casex(in)
  8'bx0xx1xxx: begin nstate=S6; out =19'b0001010000000000000; end
  8'bx1x01xxx: begin nstate=S6; out =19'b0001010000000000000; end
  8'bx1x11xxx: begin nstate=S7; out =19'b0011010000000000000; end
  8'b00xx0xxx: begin nstate=S8; out =19'b0000000000000000000; end
  8'bx1x00xxx: begin nstate=S8; out =19'b0000000000000000000; end
  8'b11x10xxx: begin nstate=S11; out =19'b0110000000000000010; end
  8'b10xx0xxx: begin nstate=S15; out =19'b0100000000000000000; end
  8'b01x10xxx: begin nstate=S9; out =19'b0010000000000000000; end
  endcase
S7: casex(in)
  8'bxxxx1xxx: begin nstate=S7; out =19'b0011010000000000000; end
  8'b0xxx0xxx: begin nstate=S9; out =19'b0010000000000000000; end
  8'b1xxx0xxx: begin nstate=S11; out =19'b0110000000000000000; end
  endcase
S8: casex(in)
  8'b00xx00xx: begin nstate=S8; out =19'b0000000000000000000; end
  8'b00xxx1x0: begin nstate=S8; out =19'b0000000000000000000; end
  8'bx1x000xx: begin nstate=S8; out =19'b0000000000000000000; end
  8'bx1x0x1x0: begin nstate=S8; out =19'b0000000000000000000; end
  8'b00xx01x1: begin nstate=S0; out =19'b0000010000000000000; end
  8'bx1x001x1: begin nstate=S0; out =19'b0000010000000000000; end
  8'bx0xx11x1: begin nstate=S1; out =19'b0000110000000000000; end
  8'bx1x011x1: begin nstate=S1; out =19'b0000110000000000000; end
  8'b10xx01x1: begin nstate=S4; out =19'b0100010000000000000; end
  8'b01x100xx: begin nstate=S9; out =19'b0010000000000000000; end
  8'b01x1x1xx: begin nstate=S9; out =19'b0010000000000000000; end
  8'b01x110xx: begin nstate=S10; out =19'b0010100000000000000; end
  8'b11x1xxxx: begin nstate=S11; out =19'b0110000000000000000; end
  8'b100x10xx: begin nstate=S14; out =19'b0000100000000000000; end
  8'bx1x010xx: begin nstate=S14; out =19'b0000100000000000000; end
  8'b101x101x: begin nstate=S14; out =19'b0000100000000000000; end
  8'b00xx10xx: begin nstate=S14; out =19'b0000100000000000000; end
  8'b10xx00xx: begin nstate=S15; out =19'b0100000000000000000; end
  8'b10xxx1x0: begin nstate=S15; out =19'b0100000000000000000; end
  8'b101x100x: begin nstate=S15; out =19'b0100000000000000000; end
  endcase
S9: casex(in)
  8'b0xxx00xx: begin nstate=S9; out =19'b0010000000000000000; end
  8'b0xxxx1x0: begin nstate=S9; out =19'b0010000000000000000; end
  8'b0xxx01x1: begin nstate=S2; out =19'b0010010000000000000; end
  8'b0xxx10xx: begin nstate=S10; out =19'b0010100000000000000; end
  8'b0xxx11x1: begin nstate=S3; out =19'b0010110000000000000; end
  8'b1xxxx0xx: begin nstate=S11; out =19'b0110000000000000000; end
  8'b1xxxx1x0: begin nstate=S11; out =19'b0110000000000000000; end
  8'b1xxxx1x1: begin nstate=S5; out =19'b0110010000000000000; end
  endcase
S10: casex(in)
  8'bxxxxxx0x: begin nstate=S16; out =19'b0011000000000000000; end
  8'bxxxxxx1x: begin nstate=S7; out =19'b0011010000000000000; end
  endcase
S11: casex(in)
  8'bxxxxx1x1: begin nstate=S13; out =19'b1010010000000000000; end
  8'bxxxxx0xx: begin nstate=S17; out =19'b0010000000000000000; end
  8'bxxxxx1x0: begin nstate=S17; out =19'b0010000000000000000; end
  endcase
S12: casex(in)
  8'b1x0xxxxx: begin nstate=S12; out =19'b1000010000000000000; end
  8'b1x1xxxxx: begin nstate=S13; out =19'b1010010000000000000; end
  8'b0xxx1xxx: begin nstate=S1; out =19'b0000110000000000000; end
  8'b0xxx0xxx: begin nstate=S0; out =19'b0000010000000000000; end
  endcase
S13: casex(in)
  8'b1xxxxxxx: begin nstate=S13; out =19'b1010010000000000000; end
  8'b0xxx0xxx: begin nstate=S0; out =19'b1000010000000000000; end
  8'b0xxx1xxx: begin nstate=S1; out =19'b1000110000000000000; end
  endcase
S14: casex(in)
  8'bxxx0xx1x: begin nstate=S6; out =19'b1001010000000000000; end
  8'bxxx0xx0x: begin nstate=S18; out =19'b1001000000000000000; end
  8'bx0x1xxxx: begin nstate=S18; out =19'b1001000000000000000; end
  8'bx1x1xxxx: begin nstate=S16; out =19'b1011000000000000000; end
  endcase
S15: casex(in)
  8'bxx0xx0xx: begin nstate=S19; out =19'b1000000000000000000; end
  8'bxx0xx1x0: begin nstate=S19; out =19'b1000000000000000000; end
  8'bxx0xx1x1: begin nstate=S12; out =19'b1000010000000000000; end
  8'bxx1xxxxx: begin nstate=S17; out =19'b1010000000000000000; end
  endcase
S16: casex(in)
  8'bxxxx1x0x: begin nstate=S16; out =19'b0011000000000000000; end
  8'bxxxx1x1x: begin nstate=S7; out =19'b0011010000000000000; end
  8'b1xxx0xxx: begin nstate=S11; out =19'b0110000000000000000; end
  8'b0xxx0xxx: begin nstate=S9; out =19'b0010000000000000000; end
  endcase
S17: casex(in)
  8'b1xxxx0xx: begin nstate=S17; out =19'b1010000000000000000; end
  8'b1xxxx1x0: begin nstate=S17; out =19'b1010000000000000000; end
  8'b0xxx00xx: begin nstate=S8; out =19'b1000000000000000000; end
  8'b0xxxx1x0: begin nstate=S8; out =19'b1000000000000000000; end
  8'b0xxx01x1: begin nstate=S0; out =19'b0000010000000000000; end
  8'b0xxx11x1: begin nstate=S1; out =19'b0000110000000000000; end
  8'b1xxxx1x1: begin nstate=S13; out =19'b1010010000000000000; end
  8'b0xxx10xx: begin nstate=S14; out =19'b0000100000000000000; end
  endcase
S18: casex(in)
  8'bxxxx1x1x: begin nstate=S6; out =19'b0001010000000000000; end
  8'b00xx0xxx: begin nstate=S8; out =19'b0000000000000000000; end
  8'bx1x00xxx: begin nstate=S8; out =19'b0000000000000000000; end
  8'b01x10xxx: begin nstate=S9; out =19'b0010000000000000000; end
  8'b11x10xxx: begin nstate=S11; out =19'b0110000000000000000; end
  8'b10xx0xxx: begin nstate=S15; out =19'b0100000000000000000; end
  8'bx1x11x0x: begin nstate=S16; out =19'b0011000000000000000; end
  8'bx0xx1x0x: begin nstate=S18; out =19'b0001000000000000000; end
  8'bx1x01x0x: begin nstate=S18; out =19'b0001000000000000000; end
  endcase
S19: casex(in)
  8'b1x0xx0xx: begin nstate=S20; out =19'b1000000000000000000; end
  8'b1x0xx1x0: begin nstate=S19; out =19'b1000000000000000000; end
  8'b0xxx00xx: begin nstate=S8; out =19'b0000000000000000000; end
  8'b0xxxx1x0: begin nstate=S8; out =19'b0000000000000000000; end
  8'b0xxx01x1: begin nstate=S0; out =19'b0000010000000000000; end
  8'b0xxx10xx: begin nstate=S14; out =19'b0000100000000000000; end
  8'b0xxx11x1: begin nstate=S1; out =19'b0000110000000000000; end
  8'b1x0xx1x1: begin nstate=S12; out =19'b1000010000000000000; end
  8'b1x1xxxxx: begin nstate=S17; out =19'b1010000000000000000; end
  endcase
S20: casex(in)
  8'b0x11xxxx: begin nstate=S20; out =19'b1100011010010010111; end
  8'b0x01xxxx: begin nstate=S20; out =19'b1000000011000100000; end
  8'b1x11xxxx: begin nstate=S21; out =19'b0100011010010010111; end
  8'b1x01xxxx: begin nstate=S20; out =19'b1000000011000100000; end
  8'bxx00xxxx: begin nstate=S20; out =19'b1000000010000110000; end
  8'bxx10xxxx: begin nstate=S20; out =19'b1000000000000000000; end
  endcase
S21: casex(in)
  8'b00xxxxxx: begin nstate=S20; out =19'b0000001010001010000; end
  8'b01xx1xxx: begin nstate=S20; out =19'b0010100010001110000; end
  8'b01xx0xxx: begin nstate=S20; out =19'b0000001010001010000; end
  8'b1xxx0xxx: begin nstate=S22; out =19'b0000001010001010000; end
  8'b10xx1xxx: begin nstate=S22; out =19'b0000001010001010000; end
  8'b11xx1xxx: begin nstate=S67; out =19'b0010100010001110000; end
  endcase
S22: casex(in)
  8'b0x10x010: begin nstate=S20; out =19'b1000010000000000000; end
  8'b0x10x000: begin nstate=S20; out =19'b1000010000000000001; end
  8'b0x10x100: begin nstate=S20; out =19'b1000010000000000101; end
  8'b0x10x110: begin nstate=S20; out =19'b1000010000000000100; end
  8'b0x11x1x0: begin nstate=S20; out =19'b1000011000011011101; end
  8'b0x11x0x0: begin nstate=S20; out =19'b1000011000011011001; end
  8'b0x00x100: begin nstate=S20; out =19'b1000000000001111101; end
  8'b0x00x110: begin nstate=S20; out =19'b1000000000001111100; end
  8'b0x00x000: begin nstate=S20; out =19'b1000000000001111001; end
  8'b0x00x010: begin nstate=S20; out =19'b1000000000001111000; end
  8'b0x01x100: begin nstate=S20; out =19'b1000010001001101101; end
  8'b0x01x110: begin nstate=S20; out =19'b1000010001001101100; end
  8'b0x01x010: begin nstate=S20; out =19'b1000010001001101000; end
  8'b0x01x000: begin nstate=S20; out =19'b1000010001001101001; end
  8'b0xxxxx01: begin nstate=S20; out =19'b1000001100111010001; end
  8'b0xxxxx11: begin nstate=S20; out =19'b1000001100111010000; end
  8'b1xxxxx11: begin nstate=S23; out =19'b1000001100111010000; end
  8'b1xxxxx01: begin nstate=S23; out =19'b1000001100111010001; end
  8'b1x01x100: begin nstate=S23; out =19'b1000010001001101101; end
  8'b1x01x110: begin nstate=S23; out =19'b1000010001001101100; end
  8'b1x01x000: begin nstate=S23; out =19'b1000010001001101001; end
  8'b1x01x010: begin nstate=S23; out =19'b1000010001001101000; end
  8'b1x11x1x0: begin nstate=S26; out =19'b1000011000011011101; end
  8'b1x11x0x0: begin nstate=S26; out =19'b1000011000011011001; end
  8'b1x00x100: begin nstate=S23; out =19'b1000000000001111101; end
  8'b1x00x110: begin nstate=S23; out =19'b1000000000001111100; end
  8'b1x00x000: begin nstate=S23; out =19'b1000000000001111001; end
  8'b1x00x010: begin nstate=S23; out =19'b1000000000001111000; end
  8'b1x10x000: begin nstate=S23; out =19'b1000010000000000001; end
  8'b1x10x010: begin nstate=S23; out =19'b1000010000000000000; end
  8'b1x10x110: begin nstate=S23; out =19'b1000010000000000100; end
  8'b1x10x100: begin nstate=S23; out =19'b1000010000000000101; end
  endcase
S23: casex(in)
  8'b0xxxxxxx: begin nstate=S20; out =19'b0000001010001010000; end
  8'b1xxxxxxx: begin nstate=S24; out =19'b0000001010001010000; end
  endcase
S24: casex(in)
  8'b1xxxx0xx: begin nstate=S25; out =19'b0000001010000110001; end
  8'b1xxxx1xx: begin nstate=S25; out =19'b0000001010000110101; end
  8'b0xxxx0xx: begin nstate=S20; out =19'b0000001010000110001; end
  8'b0xxxx1xx: begin nstate=S20; out =19'b0000001010000110101; end
  endcase
S25: casex(in)
  8'b11xxx01x: begin nstate=S26; out =19'b0000001010001010000; end
  8'b01xxx01x: begin nstate=S20; out =19'b0000001010001010000; end
  8'b11xx111x: begin nstate=S31; out =19'b0000001010001010000; end
  8'b11xx011x: begin nstate=S34; out =19'b0000001010001010000; end
  8'b01xxx11x: begin nstate=S20; out =19'b0000001010001010000; end
  8'b10xxxx1x: begin nstate=S34; out =19'b0000001010001010000; end
  8'b00xxxx1x: begin nstate=S20; out =19'b0000001010001010000; end
  8'b0xxxxx0x: begin nstate=S20; out =19'b0000001010001010000; end
  8'b1xxxxx0x: begin nstate=S34; out =19'b0000001010001010000; end
  endcase
S26: casex(in)
  8'b0xxxxxxx: begin nstate=S20; out =19'b0000001000011011001; end
  8'b1xxxxxxx: begin nstate=S26; out =19'b0000001000011011001; end
  8'b0xxxxxxx: begin nstate=S20; out =19'b0000001010001010000; end
  8'b1xxxxxxx: begin nstate=S27; out =19'b0000001010001010000; end
  endcase
S27: casex(in)
  8'b0xxxx0xx: begin nstate=S20; out =19'b0000001000011011010; end
  8'b0xxxx1xx: begin nstate=S20; out =19'b0000001000011011110; end
  8'b1xxxx1xx: begin nstate=S28; out =19'b0000001000011011110; end
  8'b1xxxx0xx: begin nstate=S28; out =19'b0000001000011011010; end
  endcase
S28: casex(in)
  8'b1xxxxxxx: begin nstate=S30; out =19'b0000001010001010000; end
  8'b0xxxxxxx: begin nstate=S20; out =19'b0000001010001010000; end
  endcase
S30: casex(in)
  8'b1xxxx0xx: begin nstate=S25; out =19'b0001000000101011001; end
  8'b1xxxx1xx: begin nstate=S25; out =19'b0001000000101011101; end
  8'b0xxxx1xx: begin nstate=S20; out =19'b0001000000101011101; end
  8'b0xxxx0xx: begin nstate=S20; out =19'b0001000000101011001; end
  endcase
S31: casex(in)
  8'b1xxxx1xx: begin nstate=S32; out =19'b0100001010010010101; end
  8'b1x11x0xx: begin nstate=S26; out =19'b0000011000011011001; end
  8'b1x01x0xx: begin nstate=S33; out =19'b0000010001001101000; end
  8'b1x00x0xx: begin nstate=S33; out =19'b0000000000001111000; end
  8'b1x10x0xx: begin nstate=S33; out =19'b0000010000000000000; end
  8'b0xxxx1xx: begin nstate=S20; out =19'b0100001010010010101; end
  8'b0x10x0xx: begin nstate=S20; out =19'b0000010000000000000; end
  8'b0x11x0xx: begin nstate=S20; out =19'b0000011000011011001; end
  8'b0x00x0xx: begin nstate=S20; out =19'b0000000000001111000; end
  8'b0x01x0xx: begin nstate=S20; out =19'b0000010001001101000; end
  endcase
S32: casex(in)
  8'b0xxxxxxx: begin nstate=S20; out =19'b0000001110001010000; end
  8'b1xxxxxxx: begin nstate=S26; out =19'b0000001110001010000; end
  endcase
S33: casex(in)
  8'b1xxxxxxx: begin nstate=S31; out =19'b0000001010001010000; end
  8'b0xxxxxxx: begin nstate=S20; out =19'b0000001010001010000; end
  endcase
S34: casex(in)
  8'b1xxxx0xx: begin nstate=S35; out =19'b0000000000110010000; end
  8'b1xxxx1xx: begin nstate=S35; out =19'b0000000000110010100; end
  8'b0xxxx0xx: begin nstate=S20; out =19'b0000000000110010000; end
  8'b0xxxx1xx: begin nstate=S20; out =19'b0000000000110010100; end
  endcase
S35: casex(in)
  8'b1xxxx0xx: begin nstate=S36; out =19'b0000001010001010000; end
  8'b1xxxx1xx: begin nstate=S55; out =19'b0000001010001010000; end
  8'b0xxxxxxx: begin nstate=S20; out =19'b0000001010001010000; end
  endcase
S36: casex(in)
  8'b0xxxx0xx: begin nstate=S20; out =19'b0000001000011110001; end
  8'b0xxxx1xx: begin nstate=S20; out =19'b0000001000011110101; end
  8'b1xxxx1xx: begin nstate=S37; out =19'b0000001000011110101; end
  8'b1xxxx0xx: begin nstate=S37; out =19'b0000001000011110001; end
  endcase
S37: casex(in)
  8'b1xxxxxxx: begin nstate=S38; out =19'b0000001010001010000; end
  8'b0xxxxxxx: begin nstate=S20; out =19'b0000001010001010000; end
  endcase
S38: casex(in)
  8'b0xxxx11x: begin nstate=S20; out =19'b0000000000110111101; end
  8'b0xxxx10x: begin nstate=S20; out =19'b0000000000110111100; end
  8'b0xxxx00x: begin nstate=S20; out =19'b0000000000110111000; end
  8'b0xxxx01x: begin nstate=S20; out =19'b0000000000110111001; end
  8'b1xxxx00x: begin nstate=S39; out =19'b0000000000110111000; end
  8'b1xxxx01x: begin nstate=S39; out =19'b0000000000110111001; end
  8'b1xxxx10x: begin nstate=S39; out =19'b0000000000110111100; end
  8'b1xxxx11x: begin nstate=S39; out =19'b0000000000110111101; end
  endcase
S39: casex(in)
  8'b1xxxxxxx: begin nstate=S40; out =19'b0000001010001010000; end
  8'b0xxxxxxx: begin nstate=S20; out =19'b0000001010001010000; end
  endcase
S40: casex(in)
  8'b1xxxx1xx: begin nstate=S41; out =19'b0000001000001111101; end
  8'b1xxxx0xx: begin nstate=S41; out =19'b0000001000001111001; end
  8'b0xxxx0xx: begin nstate=S20; out =19'b0000001000001111001; end
  8'b0xxxx1xx: begin nstate=S20; out =19'b0000001000001111101; end
  endcase
S41: casex(in)
  8'b00xx1x0x: begin nstate=S20; out =19'b1000001010001010000; end
  8'b01xx1x0x: begin nstate=S20; out =19'b0000001010001010000; end
  8'b0xxx0x0x: begin nstate=S20; out =19'b0000001010001010000; end
  8'b0xxx0x1x: begin nstate=S20; out =19'b0000001010001010000; end
  8'b0xxx1x1x: begin nstate=S20; out =19'b1000001010001010000; end
  8'b10xx0xxx: begin nstate=S42; out =19'b0000001010001010000; end
  8'b10xx1xx1: begin nstate=S43; out =19'b1000001010001010000; end
  8'b10xx1xx0: begin nstate=S60; out =19'b1000001010001010000; end
  8'b11xx1x11: begin nstate=S43; out =19'b1000001010001010000; end
  8'b11xx0x11: begin nstate=S42; out =19'b0000001010001010000; end
  8'b11xx1x10: begin nstate=S60; out =19'b1000001010001010000; end
  8'b11xx0x10: begin nstate=S42; out =19'b0000001010001010000; end
  8'b11xx1x00: begin nstate=S65; out =19'b0000001010001010000; end
  8'b11xx1x01: begin nstate=S42; out =19'b0000001010001010000; end
  8'b11xx0x0x: begin nstate=S42; out =19'b0000001010001010000; end
  endcase
S42: casex(in)
  8'b1xxxx0x1: begin nstate=S21; out =19'b0000001010010010001; end
  8'b1xxxx0x0: begin nstate=S21; out =19'b0000001010010110001; end
  8'b1xxxx1xx: begin nstate=S21; out =19'b0000001010010010101; end
  8'b0xxxx0x1: begin nstate=S20; out =19'b0000001010010010001; end
  8'b0xxxx1x1: begin nstate=S20; out =19'b0000001010010010101; end
  8'b0xxxx0x0: begin nstate=S20; out =19'b0000001010010110001; end
  8'b0xxxx1x0: begin nstate=S20; out =19'b0000001010010010101; end
  endcase
S43: casex(in)
  8'b1xxxxxxx: begin nstate=S44; out =19'b0000001010010010001; end
  8'b0xxxxxxx: begin nstate=S20; out =19'b0000001010010010001; end
  endcase
S44: casex(in)
  8'b00xx1xxx: begin nstate=S20; out =19'b0000101010001010000; end
  8'b01xx1xxx: begin nstate=S20; out =19'b0000001110001010000; end
  8'b11xx1xxx: begin nstate=S45; out =19'b0000001110001010000; end
  8'b10xx1xxx: begin nstate=S58; out =19'b0000101010001010000; end
  8'b11xx0xxx: begin nstate=S45; out =19'b0000001110001010000; end
  8'b01xx0xxx: begin nstate=S20; out =19'b0000001110001010000; end
  8'b00xx0xxx: begin nstate=S20; out =19'b0000001010001010000; end
  8'b10xx0xxx: begin nstate=S47; out =19'b0000001010001010000; end
  endcase
S45: casex(in)
  8'b0xxxxxxx: begin nstate=S20; out =19'b0000001010000110001; end
  8'b1xxxxxxx: begin nstate=S46; out =19'b0000001010000110001; end
  endcase
S46: casex(in)
  8'b1xxx0xxx: begin nstate=S47; out =19'b0000001010001010000; end
  8'b0xxx0xxx: begin nstate=S20; out =19'b0000001010001010000; end
  8'b0xxx1xxx: begin nstate=S20; out =19'b0000001010001010000; end
  8'b1xxx1xxx: begin nstate=S49; out =19'b0000001010001010000; end
  endcase
S47: casex(in)
  8'b0x00x00x: begin nstate=S20; out =19'b0000000000001111000; end
  8'b0x00x01x: begin nstate=S20; out =19'b0000000000001111001; end
  8'b0x10x01x: begin nstate=S20; out =19'b0000010000000000001; end
  8'b0x10x00x: begin nstate=S20; out =19'b0000010000000000000; end
  8'b0xx0x1xx: begin nstate=S20; out =19'b0000001010010010101; end
  8'b0xx1x1xx: begin nstate=S20; out =19'b0000001010010010101; end
  8'b0x11x0xx: begin nstate=S20; out =19'b0000011000011011001; end
  8'b0x01x00x: begin nstate=S20; out =19'b0000010001001101000; end
  8'b0x01x01x: begin nstate=S20; out =19'b0000010001001101001; end
  8'b1x0xx1xx: begin nstate=S44; out =19'b0000001010010010101; end
  8'b1x00x00x: begin nstate=S48; out =19'b0000000000001111000; end
  8'b1x00x01x: begin nstate=S48; out =19'b0000000000001111001; end
  8'b1x01x01x: begin nstate=S48; out =19'b0000010001001101001; end
  8'b1x01x00x: begin nstate=S48; out =19'b0000010001001101000; end
  8'b1x10x1xx: begin nstate=S44; out =19'b0000001010010010101; end
  8'b1x10x01x: begin nstate=S48; out =19'b0000010000000000001; end
  8'b1x10x00x: begin nstate=S48; out =19'b0000010000000000000; end
  8'b1x11x1xx: begin nstate=S44; out =19'b0000001010010010101; end
  8'b1x11x0xx: begin nstate=S26; out =19'b0000011000011011001; end
  endcase
S48: casex(in)
  8'b1xxxx0xx: begin nstate=S47; out =19'b0001001010001010000; end
  8'b1xxxx1xx: begin nstate=S47; out =19'b0000001010001010000; end
  8'b0xxxx1xx: begin nstate=S20; out =19'b0000001010001010000; end
  8'b0xxxx0xx: begin nstate=S20; out =19'b0001001010001010000; end
  endcase
S49: casex(in)
  8'b0xxxx0xx: begin nstate=S20; out =19'b0000001010100010001; end
  8'b0xxxx1xx: begin nstate=S20; out =19'b0000001000011011101; end
  8'b1xxxx0xx: begin nstate=S50; out =19'b0000001010100010001; end
  8'b1xxxx1xx: begin nstate=S52; out =19'b0000001000011011101; end
  endcase
S50: casex(in)
  8'b0xxxxxxx: begin nstate=S20; out =19'b0000001010001010010; end
  8'b1xxx01xx: begin nstate=S49; out =19'b0000001010001010000; end
  8'b1xxx00xx: begin nstate=S51; out =19'b0000001010001010000; end
  8'b1xxx1xxx: begin nstate=S51; out =19'b0000001010001010000; end
  endcase
S51: casex(in)
  8'b1xxxx0xx: begin nstate=S52; out =19'b0000001000011011001; end
  8'b1xxxx1xx: begin nstate=S52; out =19'b0000001000011011101; end
  8'b0xxxx0xx: begin nstate=S20; out =19'b0000001000011011001; end
  8'b0xxxx1xx: begin nstate=S20; out =19'b0000001000011011101; end
  endcase
S52: casex(in)
  8'b1xxxxxxx: begin nstate=S53; out =19'b0001001010001010000; end
  8'b0xxxxxxx: begin nstate=S20; out =19'b0001001010001010000; end
  endcase
S53: casex(in)
  8'b1xxxx0xx: begin nstate=S54; out =19'b0000001000011011000; end
  8'b1xxxx1xx: begin nstate=S54; out =19'b0000001000011011100; end
  8'b0xxxx0xx: begin nstate=S20; out =19'b0000001000011011000; end
  8'b0xxxx1xx: begin nstate=S20; out =19'b0000001000011011100; end
  endcase
S54: casex(in)
  8'b0xxxxxxx: begin nstate=S20; out =19'b0001001010001010000; end
  8'b1xxxxxxx: begin nstate=S55; out =19'b0001001010001010000; end
  endcase
S55: casex(in)
  8'b0xxxx10x: begin nstate=S20; out =19'b0000001000011010101; end
  8'b0xxxx11x: begin nstate=S20; out =19'b0000001000011010100; end
  8'b0xxxx01x: begin nstate=S20; out =19'b0000001000011010000; end
  8'b0xxxx00x: begin nstate=S20; out =19'b0000001000011010001; end
  8'b1xxxx01x: begin nstate=S56; out =19'b0000001000011010000; end
  8'b1xxxx00x: begin nstate=S56; out =19'b0000001000011010001; end
  8'b1xxxx11x: begin nstate=S56; out =19'b0000001000011010100; end
  8'b1xxxx10x: begin nstate=S56; out =19'b0000001000011010101; end
  endcase
S56: casex(in)
  8'b0xxxxxxx: begin nstate=S20; out =19'b0000001010001010000; end
  8'b1xxxxxxx: begin nstate=S57; out =19'b0000001010001010000; end
  endcase
S57: casex(in)
  8'b0xxxx00x: begin nstate=S20; out =19'b0000000000110011000; end
  8'b0xxxx01x: begin nstate=S20; out =19'b0000000000110011001; end
  8'b0xxxx11x: begin nstate=S20; out =19'b0000000000110011101; end
  8'b0xxxx10x: begin nstate=S20; out =19'b0000000000110011100; end
  8'b1xxxx11x: begin nstate=S39; out =19'b0000000000110011101; end
  8'b1xxxx10x: begin nstate=S39; out =19'b0000000000110011100; end
  8'b1xxxx00x: begin nstate=S39; out =19'b0000000000110011000; end
  8'b1xxxx01x: begin nstate=S39; out =19'b0000000000110011001; end
  endcase
S58: casex(in)
  8'b0xxxxxxx: begin nstate=S20; out =19'b0000001000001111001; end
  8'b1xxxxxxx: begin nstate=S59; out =19'b0000001000001111001; end
  endcase
S59: casex(in)
  8'b0xxxx0xx: begin nstate=S20; out =19'b0001001010001010000; end
  8'b0xxxx1xx: begin nstate=S20; out =19'b0100001010001010000; end
  8'b1xxx01xx: begin nstate=S22; out =19'b0100001010001010000; end
  8'b1xxx00xx: begin nstate=S22; out =19'b0001001010001010000; end
  8'b1xxx11xx: begin nstate=S47; out =19'b0100001010001010000; end
  8'b1xxx10xx: begin nstate=S47; out =19'b0001001010001010000; end
  endcase
S60: casex(in)
  8'b1xxxx1xx: begin nstate=S44; out =19'b0000001010010010101; end
  8'b1xxxx00x: begin nstate=S61; out =19'b0000001010100010001; end
  8'b1xxxx01x: begin nstate=S61; out =19'b0000001010100010000; end
  8'b0xxxx00x: begin nstate=S20; out =19'b0000001010100010001; end
  8'b0xxxx01x: begin nstate=S20; out =19'b0000001010100010000; end
  8'b0xxxx1xx: begin nstate=S20; out =19'b0000001010010010101; end
  endcase
S61: casex(in)
  8'b1xxxx00x: begin nstate=S62; out =19'b0000001010001010000; end
  8'b1xxxx01x: begin nstate=S68; out =19'b0000001010001010000; end
  8'b1xxxx10x: begin nstate=S60; out =19'b0000001010001010000; end
  8'b1xxxx11x: begin nstate=S62; out =19'b0000001010001010000; end
  8'b0xxxxxxx: begin nstate=S20; out =19'b0000001010001010000; end
  endcase
S62: casex(in)
  8'b0xxxx11x: begin nstate=S20; out =19'b0000001000111010101; end
  8'b0xxxx10x: begin nstate=S20; out =19'b0000001000111010100; end
  8'b0xxxx01x: begin nstate=S20; out =19'b0000001000111010001; end
  8'b0xxxx00x: begin nstate=S20; out =19'b0000001000111010000; end
  8'b1xxxx10x: begin nstate=S63; out =19'b0000001000111010100; end
  8'b1xxxx11x: begin nstate=S63; out =19'b0000001000111010101; end
  8'b1xxxx01x: begin nstate=S64; out =19'b0000001000111010001; end
  8'b1xxxx00x: begin nstate=S64; out =19'b0000001000111010000; end
  endcase
S63: casex(in)
  8'b1xxxxxxx: begin nstate=S43; out =19'b0000001010001010000; end
  8'b0xxxxxxx: begin nstate=S20; out =19'b0000001010001010000; end
  endcase
S64: casex(in)
  8'b0xxxxxxx: begin nstate=S20; out =19'b0000001010001010000; end
  8'b1xxxxxxx: begin nstate=S60; out =19'b0000001010001010000; end
  endcase
S65: casex(in)
  8'b1xxxx0xx: begin nstate=S66; out =19'b0000001010010110001; end
  8'b0xxxx0xx: begin nstate=S20; out =19'b0000001010010110001; end
  8'b0xxxx1xx: begin nstate=S20; out =19'b0010101010010010101; end
  8'b1xxxx1xx: begin nstate=S67; out =19'b0010101010010010101; end
  endcase
S66: casex(in)
  8'b1xxxxxxx: begin nstate=S65; out =19'b0000001010001010000; end
  8'b0xxxxxxx: begin nstate=S20; out =19'b0000001010001010000; end
  endcase
S67: casex(in)
  8'bxxxxxxxx: begin nstate=S20; out =19'b1000001000011010000; end
  endcase
S68: casex(in)
  8'b0x01xxxx: begin nstate=S68; out =19'b1000000001000000001; end
  8'b0x00xxxx: begin nstate=S68; out =19'b1000000000100000001; end
  8'b0x10xxxx: begin nstate=S68; out =19'b1000000000000000000; end
  8'b0x11xxxx: begin nstate=S68; out =19'b1001001100111110001; end
  8'b1x01xxxx: begin nstate=S68; out =19'b1000000001000000001; end
  8'b1x00xxxx: begin nstate=S68; out =19'b1000000000100000001; end
  8'b1x11xxxx: begin nstate=S69; out =19'b1001001100111110001; end
  8'b1x10xxxx: begin nstate=S68; out =19'b1000000000000000000; end
  endcase
S69: casex(in)
  8'b1xxx0xxx: begin nstate=S70; out =19'b0000000000100100101; end
  8'b11xx1xxx: begin nstate=S85; out =19'b1000010010100000101; end
  8'b10xx1xxx: begin nstate=S70; out =19'b0000000000100100101; end
  8'b00xxxxxx: begin nstate=S68; out =19'b0000000000100100101; end
  8'b01xx1xxx: begin nstate=S68; out =19'b1000010010100000101; end
  8'b01xx0xxx: begin nstate=S68; out =19'b0000000000100100101; end
  endcase
S70: casex(in)
  8'b0x00x000: begin nstate=S68; out =19'b1000000000110000100; end
  8'b0x00x010: begin nstate=S68; out =19'b1000000000100000100; end
  8'b0x00x110: begin nstate=S68; out =19'b1000000100100000100; end
  8'b0x00x100: begin nstate=S68; out =19'b1000000100110000100; end
  8'b0x01x100: begin nstate=S68; out =19'b1000001101010000100; end
  8'b0x01x110: begin nstate=S68; out =19'b1000001101000000100; end
  8'b0x01x010: begin nstate=S68; out =19'b1000001001000000100; end
  8'b0x01x000: begin nstate=S68; out =19'b1000001001010000100; end
  8'b0x0xxx01: begin nstate=S68; out =19'b0100000000111111100; end
  8'b0x0xxx11: begin nstate=S68; out =19'b0100000000101111100; end
  8'b0x10x000: begin nstate=S68; out =19'b0000001000010000000; end
  8'b0x10x010: begin nstate=S68; out =19'b0000001000000000000; end
  8'b0x11x0x0: begin nstate=S68; out =19'b0000001000110110100; end
  8'b0x10x110: begin nstate=S68; out =19'b0000001100000000000; end
  8'b0x10x100: begin nstate=S68; out =19'b0000001100010000000; end
  8'b0x11x1x0: begin nstate=S68; out =19'b0000001100110110100; end
  8'b0x1xxx01: begin nstate=S68; out =19'b0100000000111111100; end
  8'b0x1xxx11: begin nstate=S68; out =19'b0100000000101111100; end
  8'b1xx1xx01: begin nstate=S71; out =19'b0100000000111111100; end
  8'b1xx1xx11: begin nstate=S71; out =19'b0100000000101111100; end
  8'b1x11x0x0: begin nstate=S102; out =19'b0000001000110110100; end
  8'b1x11x1x0: begin nstate=S102; out =19'b0000001100110110100; end
  8'b1x01x110: begin nstate=S71; out =19'b1000001101000000100; end
  8'b1x01x100: begin nstate=S71; out =19'b1000001101010000100; end
  8'b1x01x010: begin nstate=S71; out =19'b1000001001000000100; end
  8'b1x01x000: begin nstate=S71; out =19'b1000001001010000100; end
  8'b1xx0xx11: begin nstate=S71; out =19'b0100000000101111100; end
  8'b1xx0xx01: begin nstate=S71; out =19'b0100000000111111100; end
  8'b1x10x100: begin nstate=S71; out =19'b0000001100010000000; end
  8'b1x10x110: begin nstate=S71; out =19'b0000001100000000000; end
  8'b1x10x000: begin nstate=S71; out =19'b0000001000010000000; end
  8'b1x10x010: begin nstate=S71; out =19'b0000001000000000000; end
  8'b1x00x110: begin nstate=S71; out =19'b1000000100100000100; end
  8'b1x00x100: begin nstate=S71; out =19'b1000000100110000100; end
  8'b1x00x000: begin nstate=S71; out =19'b1000000000110000100; end
  8'b1x00x010: begin nstate=S71; out =19'b1000000000100000100; end
  endcase
S71: casex(in)
  8'b0xxxxxxx: begin nstate=S68; out =19'b0000000000100100101; end
  8'b1xxxxxxx: begin nstate=S72; out =19'b0000000000100100101; end
  endcase
S72: casex(in)
  8'b0xxxx0xx: begin nstate=S68; out =19'b1000000000111100001; end
  8'b0xxxx1xx: begin nstate=S68; out =19'b1000000100111100001; end
  8'b1xxxx1xx: begin nstate=S73; out =19'b1000000100111100001; end
  8'b1xxxx0xx: begin nstate=S73; out =19'b1000000000111100001; end
  endcase
S73: casex(in)
  8'b0xxxxxxx: begin nstate=S68; out =19'b0000000000100100101; end
  8'b10xxx11x: begin nstate=S74; out =19'b0000000000100100101; end
  8'b11xx011x: begin nstate=S74; out =19'b0000000000100100101; end
  8'b11xx111x: begin nstate=S112; out =19'b0000000000100100111; end
  8'b11xxx01x: begin nstate=S114; out =19'b0000000000100100101; end
  8'b10xxx01x: begin nstate=S74; out =19'b0000000000100100101; end
  8'b1xxxxx0x: begin nstate=S74; out =19'b0000000000100100101; end
  endcase
S74: casex(in)
  8'b0xxxx1xx: begin nstate=S68; out =19'b0000000100101011000; end
  8'b0xxxx0xx: begin nstate=S68; out =19'b0000000000101011000; end
  8'b1xxxx0xx: begin nstate=S75; out =19'b0000000000101011000; end
  8'b1xxxx1xx: begin nstate=S75; out =19'b0000000100101011000; end
  endcase
S75: casex(in)
  8'b1xxxx1xx: begin nstate=S76; out =19'b0000000000100100101; end
  8'b1xxxx0xx: begin nstate=S109; out =19'b0000000000100100101; end
  8'b0xxxxxxx: begin nstate=S68; out =19'b0000000000100100101; end
  endcase
S76: casex(in)
  8'b0xxxx11x: begin nstate=S68; out =19'b0000000100101110100; end
  8'b0xxxx10x: begin nstate=S68; out =19'b0000000100111110100; end
  8'b0xxxx01x: begin nstate=S68; out =19'b0000000000101110100; end
  8'b0xxxx00x: begin nstate=S68; out =19'b0000000000111110100; end
  8'b1xxxx11x: begin nstate=S77; out =19'b0000000100101110100; end
  8'b1xxxx10x: begin nstate=S77; out =19'b0000000100111110100; end
  8'b1xxxx01x: begin nstate=S77; out =19'b0000000000101110100; end
  8'b1xxxx00x: begin nstate=S77; out =19'b0000000000111110100; end
  endcase
S77: casex(in)
  8'b1xxxxxxx: begin nstate=S78; out =19'b0000000000100100101; end
  8'b0xxxxxxx: begin nstate=S68; out =19'b0000000000100100101; end
  endcase
S78: casex(in)
  8'b0xxxx01x: begin nstate=S68; out =19'b0000000000110011000; end
  8'b0xxxx00x: begin nstate=S68; out =19'b0000000000100011000; end
  8'b0xxxx10x: begin nstate=S68; out =19'b0000000100100011000; end
  8'b0xxxx11x: begin nstate=S68; out =19'b0000000100110011000; end
  8'b1xxxx11x: begin nstate=S79; out =19'b0000000100110011000; end
  8'b1xxxx10x: begin nstate=S79; out =19'b0000000100100011000; end
  8'b1xxxx01x: begin nstate=S79; out =19'b0000000000110011000; end
  8'b1xxxx00x: begin nstate=S79; out =19'b0000000000100011000; end
  endcase
S79: casex(in)
  8'b1xxxxxxx: begin nstate=S80; out =19'b0000000000100100101; end
  8'b0xxxxxxx: begin nstate=S68; out =19'b0000000000100100101; end
  endcase
S80: casex(in)
  8'b1xxxx0xx: begin nstate=S81; out =19'b1000000000110100100; end
  8'b1xxxx1xx: begin nstate=S81; out =19'b1000000100110100100; end
  8'b0xxxx0xx: begin nstate=S68; out =19'b1000000000110100100; end
  8'b0xxxx1xx: begin nstate=S68; out =19'b1000000100110100100; end
  endcase
S81: casex(in)
  8'b01xxxx0x: begin nstate=S68; out =19'b0000000000100100101; end
  8'b00xx1x0x: begin nstate=S68; out =19'b0000100000100100101; end
  8'b00xx0x0x: begin nstate=S68; out =19'b0000000000100100101; end
  8'b11xxxx01: begin nstate=S82; out =19'b0000000000100100101; end
  8'b11xx0x00: begin nstate=S82; out =19'b0000000000100100101; end
  8'b11xx1x00: begin nstate=S83; out =19'b0000000000100100101; end
  8'b10xx0x0x: begin nstate=S82; out =19'b0000000000100100101; end
  8'b10xx1x00: begin nstate=S86; out =19'b0000100000100100101; end
  8'b10xx1x01: begin nstate=S90; out =19'b0000100000100100101; end
  8'b0xxx1x1x: begin nstate=S68; out =19'b0000100000100100101; end
  8'b0xxx0x1x: begin nstate=S68; out =19'b0000000000100100101; end
  8'b1xxx0x1x: begin nstate=S82; out =19'b0000000000100100101; end
  8'b1xxx1x10: begin nstate=S86; out =19'b0000100000100100101; end
  8'b1xxx1x11: begin nstate=S90; out =19'b0000100000100100101; end
  endcase
S82: casex(in)
  8'b0xxxx0x1: begin nstate=S68; out =19'b0000000000111110001; end
  8'b0xxxx1x1: begin nstate=S68; out =19'b0000000100111110001; end
  8'b0xxxx0x0: begin nstate=S68; out =19'b1000000000111110001; end
  8'b0xxxx1x0: begin nstate=S68; out =19'b0000000100111110001; end
  8'b1xxxx0x1: begin nstate=S69; out =19'b0000000000111110001; end
  8'b1xxxx1x1: begin nstate=S69; out =19'b0000000100111110001; end
  8'b1xxxx0x0: begin nstate=S69; out =19'b1000000000111110001; end
  8'b1xxxx1x0: begin nstate=S69; out =19'b0000000100111110001; end
  endcase
S83: casex(in)
  8'b1xxxx0xx: begin nstate=S84; out =19'b1000000000111110001; end
  8'b0xxxx0xx: begin nstate=S68; out =19'b1000000000111110001; end
  8'b1xxxx1xx: begin nstate=S85; out =19'b0000010110111110001; end
  8'b0xxxx1xx: begin nstate=S68; out =19'b0000010110111110001; end
  endcase
S84: casex(in)
  8'b1xxxxxxx: begin nstate=S83; out =19'b0000000000100100101; end
  8'b0xxxxxxx: begin nstate=S68; out =19'b0000000000100100101; end
  endcase
S85: casex(in)
  8'bxxxxxxxx: begin nstate=S68; out =19'b0000000000101110100; end
  endcase
S86: casex(in)
  8'b1xxxx01x: begin nstate=S87; out =19'b0000000000100101001; end
  8'b1xxxx00x: begin nstate=S87; out =19'b0000000000110101001; end
  8'b1xxxx1xx: begin nstate=S91; out =19'b0000000100111110001; end
  8'b0xxxx01x: begin nstate=S68; out =19'b0000000000100101001; end
  8'b0xxxx00x: begin nstate=S68; out =19'b0000000000110101001; end
  8'b0xxxx1xx: begin nstate=S68; out =19'b0000000100111110001; end
  endcase
S87: casex(in)
  8'b0xxxxxxx: begin nstate=S68; out =19'b0000000000100100101; end
  8'b1xxxx00x: begin nstate=S88; out =19'b0000000000100100101; end
  8'b1xxxx01x: begin nstate=S86; out =19'b0000000000100100101; end
  8'b1xxxx11x: begin nstate=S88; out =19'b0000000000100100101; end
  8'b1xxxx10x: begin nstate=S86; out =19'b0000000000100100101; end
  endcase
S88: casex(in)
  8'b1xxxx10x: begin nstate=S89; out =19'b0000000100101111100; end
  8'b1xxxx11x: begin nstate=S89; out =19'b0000000100111111100; end
  8'b1xxxx00x: begin nstate=S108; out =19'b0000000000101111100; end
  8'b1xxxx01x: begin nstate=S108; out =19'b0000000000111111100; end
  8'b0xxxx10x: begin nstate=S68; out =19'b0000000100101111100; end
  8'b0xxxx11x: begin nstate=S68; out =19'b0000000100111111100; end
  8'b0xxxx00x: begin nstate=S68; out =19'b0000000000101111100; end
  8'b0xxxx01x: begin nstate=S68; out =19'b0000000000111111100; end
  endcase
S89: casex(in)
  8'b0xxxxxxx: begin nstate=S68; out =19'b0000000000100100101; end
  8'b1xxxxxxx: begin nstate=S90; out =19'b0000000000100100101; end
  endcase
S90: casex(in)
  8'b1xxxxxxx: begin nstate=S91; out =19'b0000000000111110001; end
  8'b0xxxxxxx: begin nstate=S68; out =19'b0000000000111110001; end
  endcase
S91: casex(in)
  8'b11xxxxxx: begin nstate=S92; out =19'b0100000000100100101; end
  8'b01xxxxxx: begin nstate=S68; out =19'b0100000000100100101; end
  8'b00xx0xxx: begin nstate=S68; out =19'b0000000000100100101; end
  8'b00xx1xxx: begin nstate=S68; out =19'b0000010000100100101; end
  8'b10xx0xxx: begin nstate=S100; out =19'b0000000000100100101; end
  8'b10xx1xxx: begin nstate=S106; out =19'b0000010000100100101; end
  endcase
S92: casex(in)
  8'b1xxxxxxx: begin nstate=S93; out =19'b1000000000111100001; end
  8'b0xxxxxxx: begin nstate=S68; out =19'b1000000000111100001; end
  endcase
S93: casex(in)
  8'b0xxxxxxx: begin nstate=S68; out =19'b0000000000100100101; end
  8'b1xxx1xxx: begin nstate=S94; out =19'b0000000000100100101; end
  8'b1xxx0xxx: begin nstate=S100; out =19'b0000000000100100101; end
  endcase
S94: casex(in)
  8'b1xxxx1xx: begin nstate=S95; out =19'b0000000100110110100; end
  8'b1xxxx0xx: begin nstate=S98; out =19'b0000000000110101001; end
  8'b0xxxx1xx: begin nstate=S68; out =19'b0000000100110110100; end
  8'b0xxxx0xx: begin nstate=S68; out =19'b0000000000110101001; end
  endcase
S95: casex(in)
  8'b0xxxxxxx: begin nstate=S68; out =19'b0010000000100100101; end
  8'b1xxxxxxx: begin nstate=S96; out =19'b0010000000100100101; end
  endcase
S96: casex(in)
  8'b0xxxx0xx: begin nstate=S68; out =19'b0000000000101110100; end
  8'b0xxxx1xx: begin nstate=S68; out =19'b0000000100101110100; end
  8'b1xxxx0xx: begin nstate=S97; out =19'b0000000000101110100; end
  8'b1xxxx1xx: begin nstate=S97; out =19'b0000000100101110100; end
  endcase
S97: casex(in)
  8'b0xxxxxxx: begin nstate=S68; out =19'b1010000000100100101; end
  8'b1xxxxxxx: begin nstate=S76; out =19'b1010000000100100101; end
  endcase
S98: casex(in)
  8'b1xxxx0xx: begin nstate=S99; out =19'b0000000000100100101; end
  8'b1xxx11xx: begin nstate=S99; out =19'b0000000000100100101; end
  8'b1xxx01xx: begin nstate=S94; out =19'b0000000000100100101; end
  8'b0xxxxxxx: begin nstate=S68; out =19'b0000000000100100101; end
  endcase
S99: casex(in)
  8'b1xxxx1xx: begin nstate=S95; out =19'b0000000100110110110; end
  8'b1xxxx0xx: begin nstate=S95; out =19'b0000000000110110110; end
  8'b0xxxx0xx: begin nstate=S68; out =19'b0000000000110110110; end
  8'b0xxxx1xx: begin nstate=S68; out =19'b0000000100110110110; end
  endcase
S100: casex(in)
  8'b0xxxx1xx: begin nstate=S68; out =19'b0000000100111110001; end
  8'b0x11x0xx: begin nstate=S68; out =19'b0000001000110110110; end
  8'b0x10x00x: begin nstate=S68; out =19'b0000001000000000000; end
  8'b0x10x01x: begin nstate=S68; out =19'b0000001000010000000; end
  8'b0x00x00x: begin nstate=S68; out =19'b1000000000100000100; end
  8'b0x00x01x: begin nstate=S68; out =19'b1000000000110000100; end
  8'b0x01x01x: begin nstate=S68; out =19'b1000001001010000100; end
  8'b0x01x00x: begin nstate=S68; out =19'b1000001001000000100; end
  8'b1xxxx1xx: begin nstate=S91; out =19'b0000000100111110001; end
  8'b1x00x00x: begin nstate=S101; out =19'b1000000000100000100; end
  8'b1x00x01x: begin nstate=S101; out =19'b1000000000110000100; end
  8'b1x01x01x: begin nstate=S101; out =19'b1000001001010000100; end
  8'b1x01x00x: begin nstate=S101; out =19'b1000001001000000100; end
  8'b1x11x0xx: begin nstate=S102; out =19'b0000001000110110110; end
  8'b1x10x00x: begin nstate=S101; out =19'b0000001000000000000; end
  8'b1x10x01x: begin nstate=S101; out =19'b0000001000010000000; end
  endcase
S101: casex(in)
  8'b1xxxx0xx: begin nstate=S100; out =19'b0010000000100100101; end
  8'b1xxxx1xx: begin nstate=S100; out =19'b0000000000100100101; end
  8'b0xxxx0xx: begin nstate=S68; out =19'b0010000000100100101; end
  8'b0xxxx1xx: begin nstate=S68; out =19'b0000000000100100101; end
  endcase
S102: casex(in)
  8'b1xxxxxxx: begin nstate=S103; out =19'b0000000000100100101; end
  8'b0xxxxxxx: begin nstate=S68; out =19'b0000000000100100101; end
  endcase
S103: casex(in)
  8'b0xxxx1xx: begin nstate=S68; out =19'b1000000100101110100; end
  8'b0xxxx0xx: begin nstate=S68; out =19'b1000000000101110100; end
  8'b1xxxx1xx: begin nstate=S104; out =19'b1000000100101110100; end
  8'b1xxxx0xx: begin nstate=S104; out =19'b1000000000101110100; end
  endcase
S104: casex(in)
  8'b0xxxxxxx: begin nstate=S68; out =19'b0000000000100100101; end
  8'b1xxxxxxx: begin nstate=S105; out =19'b0000000000100100101; end
  endcase
S105: casex(in)
  8'b1xxxx1xx: begin nstate=S73; out =19'b0010000100111001100; end
  8'b1xxxx0xx: begin nstate=S73; out =19'b0010000000111001100; end
  8'b0xxxx1xx: begin nstate=S68; out =19'b0010000100111001100; end
  8'b0xxxx0xx: begin nstate=S68; out =19'b0010000000111001100; end
  endcase
S106: casex(in)
  8'b0xxxxxxx: begin nstate=S68; out =19'b1000000000110100100; end
  8'b1xxxxxxx: begin nstate=S107; out =19'b1000000000110100100; end
  endcase
S107: casex(in)
  8'b1xxx01xx: begin nstate=S70; out =19'b0001000000100100101; end
  8'b1xxx00xx: begin nstate=S70; out =19'b0010000000100100101; end
  8'b1xxx10xx: begin nstate=S100; out =19'b0010000000100100101; end
  8'b1xxx11xx: begin nstate=S100; out =19'b0001000000100100101; end
  8'b0xxxx0xx: begin nstate=S68; out =19'b0010000000100100101; end
  8'b0xxxx1xx: begin nstate=S68; out =19'b0001000000100100101; end
  endcase
S108: casex(in)
  8'b1xxxxxxx: begin nstate=S86; out =19'b0000000000100100101; end
  8'b0xxxxxxx: begin nstate=S68; out =19'b0000000000100100101; end
  endcase
S109: casex(in)
  8'b1xxxx0xx: begin nstate=S110; out =19'b1000000000111110100; end
  8'b1xxxx1xx: begin nstate=S110; out =19'b1000000100111110100; end
  8'b0xxxx1xx: begin nstate=S68; out =19'b1000000100111110100; end
  8'b0xxxx0xx: begin nstate=S68; out =19'b1000000000111110100; end
  endcase
S110: casex(in)
  8'b0xxxxxxx: begin nstate=S68; out =19'b0000000000100100101; end
  8'b1xxxxxxx: begin nstate=S111; out =19'b0000000000100100101; end
  endcase
S111: casex(in)
  8'b0xxxx11x: begin nstate=S68; out =19'b1000000100111011000; end
  8'b0xxxx10x: begin nstate=S68; out =19'b1000000100101011000; end
  8'b0xxxx00x: begin nstate=S68; out =19'b1000000000101011000; end
  8'b0xxxx01x: begin nstate=S68; out =19'b1000000000111011000; end
  8'b1xxxx10x: begin nstate=S79; out =19'b1000000100101011000; end
  8'b1xxxx11x: begin nstate=S79; out =19'b1000000100111011000; end
  8'b1xxxx00x: begin nstate=S79; out =19'b1000000000101011000; end
  8'b1xxxx01x: begin nstate=S79; out =19'b1000000000111011000; end
  endcase
S112: casex(in)
  8'b1xxxx1xx: begin nstate=S113; out =19'b0001000100111110001; end
  8'b1x00x0xx: begin nstate=S116; out =19'b1000000000100000100; end
  8'b1x01x0xx: begin nstate=S115; out =19'b1000001001000000100; end
  8'b1x10x0xx: begin nstate=S115; out =19'b0000001000000000000; end
  8'b1x11x0xx: begin nstate=S102; out =19'b0000001000110110100; end
  8'b0x00x0xx: begin nstate=S68; out =19'b1000000000100000100; end
  8'b0x01x0xx: begin nstate=S68; out =19'b1000001001000000100; end
  8'b0x0xx1xx: begin nstate=S68; out =19'b0001000100111110001; end
  8'b0x1xx1xx: begin nstate=S68; out =19'b0001000100111110001; end
  8'b0x10x0xx: begin nstate=S68; out =19'b0000001000000000000; end
  8'b0x11x0xx: begin nstate=S68; out =19'b0000001000110110100; end
  endcase
S113: casex(in)
  8'b1xxxxxxx: begin nstate=S114; out =19'b0100000000100100101; end
  8'b0xxxxxxx: begin nstate=S68; out =19'b0100000000100100101; end
  endcase
S114: casex(in)
  8'b0xxxxxxx: begin nstate=S68; out =19'b0000000000110110110; end
  8'b1xxxxxxx: begin nstate=S102; out =19'b0000000000110110100; end
  endcase
S115: casex(in)
  8'b0xxxxxxx: begin nstate=S68; out =19'b0000000000100100101; end
  8'b1xxxxxxx: begin nstate=S112; out =19'b0000000000100100101; end
  endcase
S116: casex(in)
  8'b1x0000xx: begin nstate=S116; out =19'b0000000000000000000; end
  8'b1x10xxxx: begin nstate=S130; out =19'b0000000000000000000; end
  8'b1x1x0xxx: begin nstate=S130; out =19'b0000000000000000000; end
  8'b1x0010xx: begin nstate=S128; out =19'b1000000010000000000; end
  8'b1x0011xx: begin nstate=S128; out =19'b1000000011000000000; end
  8'b1xx11xxx: begin nstate=S116; out =19'b0000000000000000000; end
  8'b1x010xxx: begin nstate=S128; out =19'b1000000001000000000; end
  8'b1x0001xx: begin nstate=S117; out =19'b1010100110000000000; end
  8'b0xxxxxxx: begin nstate=S116; out =19'b0000000000000000000; end
  endcase
S117: casex(in)
  8'bxxxxxx0x: begin nstate=S118; out =19'b0110010000000000000; end
  8'bxxxxxx1x: begin nstate=S125; out =19'b0110100100000000000; end
  endcase
S118: casex(in)
  8'b1x00000x: begin nstate=S118; out =19'b0100000000000000000; end
  8'b1x10xxxx: begin nstate=S118; out =19'b0100000000000000000; end
  8'b1x1x0xxx: begin nstate=S118; out =19'b0100000000000000000; end
  8'b1x0010xx: begin nstate=S119; out =19'b0100000000000000000; end
  8'b1x0011xx: begin nstate=S118; out =19'b0101000000000000000; end
  8'b11x11xxx: begin nstate=S116; out =19'b0010100000000000000; end
  8'b10x11xxx: begin nstate=S116; out =19'b0000000000000000000; end
  8'b1x010xxx: begin nstate=S118; out =19'b0100000000000000000; end
  8'b1x0001xx: begin nstate=S117; out =19'b0110000100000000000; end
  8'b1x00001x: begin nstate=S123; out =19'b0100000000000000000; end
  8'b01xxxxxx: begin nstate=S116; out =19'b0010100000000000000; end
  8'b00xxxxxx: begin nstate=S116; out =19'b0000000000000000000; end
  endcase
S119: casex(in)
  8'b1x0000xx: begin nstate=S119; out =19'b0100000000000000000; end
  8'b1x10xxxx: begin nstate=S119; out =19'b0100000000000000000; end
  8'b1x1x0xxx: begin nstate=S119; out =19'b0100000000000000000; end
  8'b1x0010xx: begin nstate=S120; out =19'b0110001000000000000; end
  8'b1x0011xx: begin nstate=S119; out =19'b0101000000000000000; end
  8'b1xx11xxx: begin nstate=S116; out =19'b0000000000000000000; end
  8'b1x010xxx: begin nstate=S119; out =19'b0100000000000000000; end
  8'b1x0001xx: begin nstate=S121; out =19'b0110001100000000000; end
  8'b0xxxxxxx: begin nstate=S116; out =19'b0000000000000000000; end
  endcase
S120: casex(in)
  8'bxxxxxxxx: begin nstate=S122; out =19'b0110010000000000000; end
  endcase
S121: casex(in)
  8'bxxxxxxxx: begin nstate=S117; out =19'b0110010100000000000; end
  endcase
S122: casex(in)
  8'b1x00000x: begin nstate=S122; out =19'b0100000000000000000; end
  8'b1x10xxxx: begin nstate=S122; out =19'b0100000000000000000; end
  8'b1x1x0xxx: begin nstate=S122; out =19'b0100000000000000000; end
  8'b1x0010xx: begin nstate=S120; out =19'b0110001000000000000; end
  8'b1x0011xx: begin nstate=S122; out =19'b0101000000000000000; end
  8'b1xx11xxx: begin nstate=S116; out =19'b0000000000000000000; end
  8'b1x010xxx: begin nstate=S122; out =19'b0100000000000000000; end
  8'b1x0001xx: begin nstate=S117; out =19'b0110000100000000000; end
  8'b1x00001x: begin nstate=S124; out =19'b1100000000000000000; end
  8'b0xxxxxxx: begin nstate=S116; out =19'b0000000000000000000; end
  endcase
S123: casex(in)
  8'b1x0000xx: begin nstate=S123; out =19'b1100000000000000000; end
  8'b1x10xxxx: begin nstate=S123; out =19'b1100000000000000000; end
  8'b1x1x0xxx: begin nstate=S123; out =19'b1100000000000000000; end
  8'b1x0010xx: begin nstate=S124; out =19'b1100000000000000000; end
  8'b1x0011xx: begin nstate=S123; out =19'b1101000000000000000; end
  8'b11x11xxx: begin nstate=S116; out =19'b0010100000000000000; end
  8'b10x11xxx: begin nstate=S116; out =19'b0010000000000000000; end
  8'b1x010xxx: begin nstate=S123; out =19'b1100000000000000000; end
  8'b1x0001xx: begin nstate=S125; out =19'b0110100100000000000; end
  8'b01xxxxxx: begin nstate=S116; out =19'b0010100000000000000; end
  8'b00xxxxxx: begin nstate=S116; out =19'b0000000000000000000; end
  endcase
S124: casex(in)
  8'b1x0000xx: begin nstate=S124; out =19'b1100000000000000000; end
  8'b1x10xxxx: begin nstate=S124; out =19'b1100000000000000000; end
  8'b1x1x0xxx: begin nstate=S124; out =19'b1100000000000000000; end
  8'b1x0010xx: begin nstate=S124; out =19'b1100000000000000000; end
  8'b1x0011xx: begin nstate=S124; out =19'b1101000000000000000; end
  8'b1xx11xxx: begin nstate=S116; out =19'b0000000000000000000; end
  8'b1x010xxx: begin nstate=S124; out =19'b1100000000000000000; end
  8'b1x0001xx: begin nstate=S125; out =19'b0110100100000000000; end
  8'b0xxxxxxx: begin nstate=S116; out =19'b0000000000000000000; end
  endcase
S125: casex(in)
  8'bxxxxxxxx: begin nstate=S126; out =19'b0110010000000000000; end
  endcase
S126: casex(in)
  8'b1x00000x: begin nstate=S126; out =19'b0100000000000000000; end
  8'b1x10xxxx: begin nstate=S126; out =19'b0100000000000000000; end
  8'b1x1x0xxx: begin nstate=S126; out =19'b0100000000000000000; end
  8'b1x001xxx: begin nstate=S126; out =19'b0100000000000000000; end
  8'b1xx11xxx: begin nstate=S116; out =19'b0010100000000000000; end
  8'b1x010xxx: begin nstate=S126; out =19'b0100000000000000000; end
  8'b1x00001x: begin nstate=S127; out =19'b0100100000000000000; end
  8'b1x0001xx: begin nstate=S125; out =19'b0110000100000000000; end
  8'b0xxxxxxx: begin nstate=S116; out =19'b0010100000000000000; end
  endcase
S127: casex(in)
  8'b1x0000xx: begin nstate=S127; out =19'b1100000000000000000; end
  8'b1x10xxxx: begin nstate=S127; out =19'b1100000000000000000; end
  8'b1x1x0xxx: begin nstate=S127; out =19'b1100000000000000000; end
  8'b1x001xxx: begin nstate=S127; out =19'b1100000000000000000; end
  8'b1xx11xxx: begin nstate=S116; out =19'b0010100000000000000; end
  8'b1x010xxx: begin nstate=S128; out =19'b1100000000000000000; end
  8'b1x0001xx: begin nstate=S125; out =19'b0110000100000000000; end
  8'b0xxxxxxx: begin nstate=S116; out =19'b0010100000000000000; end
  endcase
S128: casex(in)
  8'b1xx0xxx0: begin nstate=S128; out =19'b0000000000000000000; end
  8'b1xxx0xx0: begin nstate=S128; out =19'b0000000000000000000; end
  8'b1xx0xxx1: begin nstate=S116; out =19'b0000000000000000000; end
  8'b1xxx0xx1: begin nstate=S116; out =19'b0000000000000000000; end
  8'b1xx0xxxx: begin nstate=S129; out =19'b0000000000000000000; end
  8'b1xxx0xxx: begin nstate=S129; out =19'b0000000000000000000; end
  8'b1xx11xxx: begin nstate=S116; out =19'b0000000000000000000; end
  8'b0xxxxxxx: begin nstate=S116; out =19'b0000000000000000000; end
  endcase
S129: casex(in)
  8'b1xx011x0: begin nstate=S129; out =19'b0000000000000000000; end
  8'b1xxx0xx0: begin nstate=S129; out =19'b0000000000000000000; end
  8'b1xx010x0: begin nstate=S128; out =19'b0100000000000000000; end
  8'b1xx11xxx: begin nstate=S116; out =19'b0000000000000000000; end
  8'b1xxx0xx1: begin nstate=S116; out =19'b0000000000000000000; end
  8'b1xx0xxx1: begin nstate=S116; out =19'b0000000000000000000; end
  8'b0xxxxxxx: begin nstate=S116; out =19'b0000000000000000000; end
  endcase
S130: casex(in)
  8'b1xx011xx: begin nstate=S130; out =19'b0000000000000000000; end
  8'b1xx10xxx: begin nstate=S130; out =19'b0000000000000000000; end
  8'b1xx000xx: begin nstate=S130; out =19'b0000000000000000000; end
  8'b1x0001xx: begin nstate=S128; out =19'b1000000001000000000; end
  8'b1xx010xx: begin nstate=S131; out =19'b0000000000000000000; end
  8'b1xx11xxx: begin nstate=S116; out =19'b0000000000000000000; end
  8'b0xxxxxxx: begin nstate=S116; out =19'b0000000000000000000; end
  endcase
S131: casex(in)
  8'b1xx000xx: begin nstate=S131; out =19'b0000000000000000000; end
  8'b1xx01xxx: begin nstate=S131; out =19'b0000000000000000000; end
  8'b1xx001xx: begin nstate=S132; out =19'b0000000001000000000; end
  8'b1xx10xxx: begin nstate=S132; out =19'b0000000001000000000; end
  8'b1xx11xxx: begin nstate=S116; out =19'b0000000000000000000; end
  8'b0xxxxxxx: begin nstate=S116; out =19'b0000000000000000000; end
  endcase
S132: casex(in)
  8'b1xx000xx: begin nstate=S132; out =19'b0000000000000000000; end
  8'b1xx01xxx: begin nstate=S132; out =19'b0000000000000000000; end
  8'b1xx10xxx: begin nstate=S132; out =19'b0000000000000000000; end
  8'b1xx001xx: begin nstate=S133; out =19'b0010100100000000000; end
  8'b1xx11xxx: begin nstate=S116; out =19'b0000000000000000000; end
  8'b0xxxxxxx: begin nstate=S116; out =19'b0000000000000000000; end
  endcase
S133: casex(in)
  8'bxx1xxxxx: begin nstate=S134; out =19'b0010010000000000000; end
  8'bxx0xxxxx: begin nstate=S140; out =19'b0010010000000000000; end
  endcase
S134: casex(in)
  8'b1xx000xx: begin nstate=S134; out =19'b0000000000000000000; end
  8'b1xx001xx: begin nstate=S137; out =19'b0010000100000000000; end
  8'b1xx010xx: begin nstate=S135; out =19'b0000000000000000000; end
  8'b1xx011xx: begin nstate=S134; out =19'b0000000000000000000; end
  8'b1xx1xxxx: begin nstate=S134; out =19'b0000000000000000000; end
  8'b0xxxxxxx: begin nstate=S116; out =19'b0000000000000000000; end
  endcase
S135: casex(in)
  8'b1xx000xx: begin nstate=S135; out =19'b0000000000000000000; end
  8'b1xx001xx: begin nstate=S136; out =19'b0010001100000000000; end
  8'b1xx010xx: begin nstate=S138; out =19'b0010001000000000000; end
  8'b1xx011xx: begin nstate=S135; out =19'b0000000000000000000; end
  8'b1xx1xxxx: begin nstate=S135; out =19'b0000000000000000000; end
  8'b0xxxxxxx: begin nstate=S116; out =19'b0000000000000000000; end
  endcase
S136: casex(in)
  8'bxxxxxxxx: begin nstate=S137; out =19'b0010010100000000000; end
  endcase
S137: casex(in)
  8'bxxxxxxxx: begin nstate=S134; out =19'b0010010000000000000; end
  endcase
S138: casex(in)
  8'bxxxxxxxx: begin nstate=S139; out =19'b0010010000000000000; end
  endcase
S139: casex(in)
  8'b1xx000xx: begin nstate=S139; out =19'b0000000000000000000; end
  8'b1xx001xx: begin nstate=S137; out =19'b0010000100000000000; end
  8'b1xx010xx: begin nstate=S138; out =19'b0010001000000000000; end
  8'b1xx011xx: begin nstate=S139; out =19'b0000000000000000000; end
  8'b1xx1xxxx: begin nstate=S139; out =19'b0000000000000000000; end
  8'b0xxxxxxx: begin nstate=S116; out =19'b0000000000000000000; end
  endcase
S140: casex(in)
  8'b1x0000xx: begin nstate=S140; out =19'b0000000000000000000; end
  8'b1x0001xx: begin nstate=S143; out =19'b0010000100000000000; end
  8'b1x0010xx: begin nstate=S141; out =19'b0000000000000000000; end
  8'b1x0011xx: begin nstate=S128; out =19'b1000000011000000000; end
  8'b1x010xxx: begin nstate=S140; out =19'b0000000000000000000; end
  8'b1x011xxx: begin nstate=S116; out =19'b0000000000000000000; end
  8'b1x1xxxxx: begin nstate=S130; out =19'b0000000000000000000; end
  8'b0xxxxxxx: begin nstate=S116; out =19'b0000000000000000000; end
  endcase
S141: casex(in)
  8'b1x0000xx: begin nstate=S141; out =19'b0000000000000000000; end
  8'b1x0001xx: begin nstate=S142; out =19'b0010001100000000000; end
  8'b1x0010xx: begin nstate=S144; out =19'b0010001000000000000; end
  8'b1x0011xx: begin nstate=S128; out =19'b1000000011000000000; end
  8'b1x010xxx: begin nstate=S141; out =19'b0000000000000000000; end
  8'b1x011xxx: begin nstate=S116; out =19'b0000000000000000000; end
  8'b1x1xxxxx: begin nstate=S130; out =19'b0000000000000000000; end
  8'b0xxxxxxx: begin nstate=S116; out =19'b0000000000000000000; end
  endcase
S142: casex(in)
  8'bxxxxxxxx: begin nstate=S143; out =19'b0010010100000000000; end
  endcase
S143: casex(in)
  8'bxxxxxxxx: begin nstate=S140; out =19'b0010010000000000000; end
  endcase
S144: casex(in)
  8'bxxxxxxxx: begin nstate=S145; out =19'b0010010000000000000; end
  endcase
S145: casex(in)
  8'b1x0000xx: begin nstate=S145; out =19'b0000000000000000000; end
  8'b1x0001xx: begin nstate=S143; out =19'b0010000100000000000; end
  8'b1x0010xx: begin nstate=S144; out =19'b0010001000000000000; end
  8'b1x0011xx: begin nstate=S128; out =19'b1000000011000000000; end
  8'b1x010xxx: begin nstate=S145; out =19'b0000000000000000000; end
  8'b1x011xxx: begin nstate=S116; out =19'b0000000000000000000; end
  8'b1x1xxxxx: begin nstate=S130; out =19'b0000000000000000000; end
  8'b0xxxxxxx: begin nstate=S116; out =19'b0000000000000000000; end
  endcase
endcase
end

assertion_rule1: assert property
        (@(posedge clk) $rose(out[1])|->##[14:33] $rose(out[0]))
         else $display("assertion rule 1 failed");

assertion_rule2: assert property
        (@(posedge clk) $fell(out[0])|->##[50:50] $rose(out[0]))
         else $display("assertion rule 2 failed");

assertion_rule3: assert property
        (@(posedge clk) $rose(in[7])|->##[21:41] $fell(out[10]))
         else $display("assertion rule 3 failed");

assertion_rule4: assert property
        (@(posedge clk) $rose(out[11])|->##[1:10] $fell(out[4]))
         else $display("assertion rule 4 failed");

assertion_rule5: assert property
        (@(posedge clk) $rose(out[1])|->##[10:10] $rose(out[9]))
         else $display("assertion rule 5 failed");

assertion_rule6: assert property
        (@(posedge clk) $rose(in[7])|->##[12:21] $fell(out[10]))
         else $display("assertion rule 6 failed");

assertion_rule7: assert property
        (@(posedge clk) $rose(out[10])|->##[12:12] $rose(out[5]))
         else $display("assertion rule 7 failed");

assertion_rule8: assert property
        (@(posedge clk) $rose(out[8])|->##[2:26] $fell(out[13]))
         else $display("assertion rule 8 failed");

assertion_rule9: assert property
        (@(posedge clk) $fell(out[16])|->##[39:75] $rose(out[0]))
         else $display("assertion rule 9 failed");

assertion_rule10: assert property
        (@(posedge clk) $rose(out[1])|->##[3:20] $rose(out[17]))
         else $display("assertion rule 10 failed");

assertion_rule11: assert property
        (@(posedge clk) $rose(out[14])|->##[12:41] $fell(out[3]))
         else $display("assertion rule 11 failed");

assertion_rule12: assert property
        (@(posedge clk) $rose(in[4])|->##[63:63] $fell(out[16]))
         else $display("assertion rule 12 failed");

assertion_rule13: assert property
        (@(posedge clk) $fell(out[11])|->##[10:22] $rose(out[3]))
         else $display("assertion rule 13 failed");

assertion_rule14: assert property
        (@(posedge clk) $fell(out[13])|->##[25:25] $fell(out[1]))
         else $display("assertion rule 14 failed");

assertion_rule15: assert property
        (@(posedge clk) $rose(out[3])|->##[55:56] $rose(out[18]))
         else $display("assertion rule 15 failed");

assertion_rule16: assert property
        (@(posedge clk) $rose(out[12])|->##[2:3] $rose(out[16]))
         else $display("assertion rule 16 failed");

assertion_rule17: assert property
        (@(posedge clk) $rose(out[7])|->##[17:20] $fell(out[2]))
         else $display("assertion rule 17 failed");


assertion_rule18: assert property
        (@(posedge clk) $rose(out[10])|->##[88:92] $fell(out[10]))
         else $display("assertion rule 18 failed");


assertion_rule19: assert property
        (@(posedge clk) $fell(in[0])|->##[1:5] $fell(out[11]))
         else $display("assertion rule 19 failed");

assertion_rule20: assert property
        (@(posedge clk) $fell(out[16])|->##[2:53] $fell(out[17]))
         else $display("assertion rule 20 failed");

endmodule
