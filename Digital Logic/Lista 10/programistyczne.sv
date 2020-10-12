module ram(input nrst, clk, wr, input [9:0] addr,
           input [15:0] in,
           input [1:0] op,
           output [15:0] data);
  
  logic [15:0] mem[0:1023]; 
     
  always_ff @(posedge clk or negedge nrst)
    if(!nrst) data <= 0;
  		else if (wr) data <= in;  
  		else unique casez (op)
          1: data <= -data; 
          2: data <= mem[addr] + data; 
          3: data <= mem[addr] * data;
        endcase
  
  always_ff @(posedge clk)
  	if (wr) mem[addr] <= in;
  	else unique casez (op)
      1: mem[addr] <= -mem[addr]; 
      2: mem[addr] <= mem[addr] + data;
      3: mem[addr] <= mem[addr] * data;
    endcase
  
endmodule

module RPN(input nrst, step, push,
           input [1:0] op,
           input [15:0] d,
           output [15:0] out,
           output [9:0] cnt);
  
//wyznaczanie adresu, do którego będzie odwołanie w module ram
  logic [9:0] pos = push ? cnt : (op > 1 ? cnt-2 : cnt-1);
  
  ram memory(nrst, step, push, pos, d, op, out); 
  
  always_ff @(posedge step or negedge nrst)
    if(!nrst) cnt <= 0;
//sprawdzenie czy jest jeszcze miejsce
  	else if(push && cnt < 1024) cnt <= cnt + 1;
//sprawdzenie czy są chociaż dwie liczby w pamięci (dodawanie i mnożenie)
  	else if((op == 2 || op == 3) && cnt > 1) cnt <= cnt - 1;
//sprawdzenie czy jest chociaż jedna liczba w pamięci (dla minusa unarnego)
  	else if(op == 1 && cnt >0 || op == 0) cnt <= cnt;
  	   
           
endmodule

