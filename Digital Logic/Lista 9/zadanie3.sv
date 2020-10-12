module circuit(input w1, w2, clk, rst, output o);
  logic [2:0] cnt;
  always_ff @(posedge clk or posedge rst)
    if(rst) cnt <= 3'b0;
  else if(w1 ^ w2) cnt <= 3'b0;
  else if(cnt == 4) cnt <= 3'b100;
  	else cnt <= cnt + 3'b1;
  
  assign o = cnt == 4;
endmodule
