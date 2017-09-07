read_verilog verilogs/cadb160.v
proc; opt; techmap -map techlibs/adff2dff.v; techmap -map techlibs/techmap.v;
write_blif blifs/cadb160.blif
