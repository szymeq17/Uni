module funnel_shifter(input [7:0] a, b, input [3:0] n, output [7:0] o);
  logic [15:0] temp = { a, b };
  assign o = temp[n+7:n];
endmodule 
  
module toplevel(input [7:0] i, input [3:0] n, input ar, lr, rot, output [7:0] o);
  logic [7:0] a;
  logic [7:0] b;
  logic [3:0] position;
  assign a = rot ? (lr ? i : i) : (ar ? (lr ? i : { 8{i[7]} }) : (lr ? i : 0));
  assign b = rot ? (lr ? i : i) : (ar ? (lr ? 0 : i) : (lr ? 0 : i));
  assign position = rot ? (lr ? 8-n : n) : (ar ? (lr ? 8-n : n) : (lr ? 8-n : n));
  
  funnel_shifter shift(a, b, position, o);
  
endmodule
  
  

