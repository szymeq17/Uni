module NWD(input clk, ini,
           input [15:0] x, y,
           output [15:0] o,
           output fin);
  logic neq, cmp;
  logic [15:0] a, b, new_a, new_b;
  assign neq = a != b;
  assign cmp = a > b;
  assign new_a = ini ? x : (neq ? (cmp ? a - b : a) : a);
  assign new_b = ini ? y : (neq ? (cmp ? b : b - a) : b);
  assign o = a;
  assign fin = !neq;
  
  always_ff @(posedge clk)
    a <= new_a;
  always_ff @(posedge clk)
    b <= new_b; 
    
endmodule

