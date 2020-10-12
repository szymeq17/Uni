module control(input clk, nrst, start, eq, smaller, 
               output ready, show, swap_sub, load);
  const logic READY = 1'b1;
  const logic BUSY = 1'b0;
  logic s; //stan
  
  always_ff @(posedge clk or negedge nrst)
    if(!nrst) s <= READY;
  else case(s)
    READY: if(start) s <= BUSY;
    BUSY: if(eq) s <= READY;
  endcase
  
  always_comb begin
    show = 1'bx;
    swap_sub = 1'bx;
    ready = 1'bx;
    load = 1'bx;
    case(s)
      READY: begin
        load = start;
    	ready = 1;
        show = 0;
      	end
      BUSY: begin
        load = 0;
        ready = 0;
        show = eq;
        swap_sub = smaller;
      	end
    endcase
  end
  	    
endmodule


module data(input clk, nrst, show, swap_sub, load,
            input [7:0] ina, inb,
            output eq, smaller, output [7:0] o);
  logic [7:0] a, b;
  always_ff @(posedge clk or negedge nrst)
    if(!nrst) o <= 0;
    else if(load) begin
      a <= ina;
      b <= inb;
    end else if(show) o <= a;
  	else if(swap_sub) begin
      a <= b;
      b <= a;
  	end else a <= a - b;
  
  assign eq = a == b;
  assign smaller = a < b;
      
endmodule

module nwd(input clk, nrst, start,
           input [7:0] ina, inb,
           output ready,
           output [7:0] out);
 logic eq, smaller, ready, show, swap_sub, load;
  control ctl(clk, nrst, start, eq, smaller, 
              ready, show, swap_sub, load);
  data data(clk, nrst, show, swap_sub, load, ina, inb,
            eq, smaller, out);
endmodule