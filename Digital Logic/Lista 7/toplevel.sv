module tff(output q, nq, input t, clk, nrst);
  logic ns, nr, ns1, nr1, j, k;
  nand n1(ns, clk, j), n2(nr, clk, k),
  n3(q, ns, nq), n4(nq, nr, q, nrst),
  n5(ns1, !clk, t, nq), n6(nr1, !clk, t, q),
  n7(j, ns1, k), n8(k, nr1, j, nrst);
endmodule

module mux(output [3:0] o, input a, b,
           input [3:0] q1, q2, q3, q4);
  logic [3:0] cond1, cond2; 
  assign cond1 = a ? q1 : q2;
  assign cond2 = a ? q3 : q4;
  assign o = b ? cond1 : cond2;
endmodule

module toplevel(output [3:0] out, input clk, nrst, step, down);
  genvar n;
  logic [3:0] t, s0d0, s0d1, s1d0, s1d1;
  assign s0d0 = {out[2] & t[2], out[1] & t[1], out[0] & t[0], nrst};
  assign s0d1 = {!out[2] & t[2], !out[1] & t[1], !out[0] & t[0], nrst};
  assign s1d0 = {out[2] & t[1], out[1] & t[0], nrst};
  assign s1d1 = {!out[2] & t[1], !out[1] & t[0], nrst};
  mux m(t, step, down, s1d1, s0d1, s1d0, s0d0);

  tff tff(.q(out[0]), .t(step ? 0 : t[0]), .clk(step ? 1 : clk), .nrst(nrst));
  for (n = 1; n < 4; n = n + 1) 
    tff tf(.q(out[n]), .t(step ? t[n-1] : t[n]), .clk(clk), .nrst(nrst));
endmodule
