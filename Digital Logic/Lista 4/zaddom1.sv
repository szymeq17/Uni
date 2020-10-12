module shifter(input [3:0] i, input l, r, output [3:0] o);
  assign o[0] = r && i[1] || l && 1'b0 || !(l || r) && i[0];
  assign o[1] = r && i[2] || l && i[0] || !(l || r) && i[1];
  assign o[2] = r && i[3] || l && i[1] || !(l || r) && i[2];
  assign o[3] = r && 1'b0 || l && i[2] || !(l || r) && i[3];
endmodule