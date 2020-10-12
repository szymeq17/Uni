module mult(input [15:0] a, b,
            output [15:0] out);
  assign out = a * b;
endmodule

module exp(input clk, nrst, start,
           input [15:0] inx,
           input [7:0] inn,
           output ready,
           output [15:0] out);
  
  logic s; //stan
  const logic READY = 1'b1;
  const logic BUSY = 1'b0;
  logic [15:0] a, x;
  logic [7:0] n;
  logic [15:0] arg, res;
  
  assign arg = n[0] ? a : x;
  
  mult m(arg, x, res);
  
  always_ff @(posedge clk or negedge nrst)
    if(!nrst) begin s <= READY; ready <= 1; end
  		else case(s)
          READY: if(start) begin
    				a <= 1;
            		x <= inx;
          			n <= inn;
            		s <= BUSY;
            		ready <= 0;
          			end
          BUSY: begin
            ready <= 0;
            if(!n) begin
              out <= a;
              s <= READY;
              ready <= 1;
            end
            else if(!n[0]) begin
              x <= res;
              n <= n >>> 1;
            end
            else begin
              a <= res;
              n <= n - 1;
            end
          end
        endcase
  
endmodule
