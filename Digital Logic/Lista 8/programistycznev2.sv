module PWM(input clk,
           input [15:0] d,
           input [1:0] sel,
           output logic [15:0] cnt, cmp, top,
           output logic out);
  
  assign out = cnt >= cmp ? 0 : 1;
  
  always_ff @(posedge clk)
    if (sel==1)
      	cmp <= d;
  
  always_ff @(posedge clk)
  	if(sel==2)
      	top <= d;
  
  always_ff @(posedge clk)
      if(sel==3)
          cnt <= d;       
  		else if (cnt >= top)
            cnt <= 16'b0;   
            else
              cnt <= cnt + 16'b1;
    
  	


endmodule
