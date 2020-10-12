module nine(input [3:0] i, output [3:0] o);
  assign x = i[3];
  assign y = i[2];
  assign z = i[1];
  assign w = i[0];
  assign o = { !x && !y && !z, y && !z || !y && z, z, !w };

endmodule
