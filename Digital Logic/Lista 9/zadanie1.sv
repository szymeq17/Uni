module circuit(input a, clk, rst, output o,
               output [1:0] p);
  logic [1:0] q;
  always_ff @(posedge clk or posedge rst)
    if(rst) q <= 2'b0;
  else q <= {!q[1] && !q[0] || q[1] && !a, (q[0] ^ q[1]) ^ a};
  assign o = q[0] && q[1];
  assign p = q;
  
endmodule
