module PWM(input clk,
           input [15:0] d,
           input [1:0] sel,
           output logic [15:0] cnt, cmp, top,
           output logic out);
  assign out = cnt >= cmp ? 0 : 1;
  
  always_ff @(posedge clk)
    if (sel==1)
      begin
      	cmp <= d;
        cnt <= cnt + 16'b1;
        if (cnt >= top) cnt <= 16'b0;
      end
  	else if(sel==2)
      begin
      	top <= d;
        cnt <= cnt + 16'b1;
        if (cnt >= top) cnt <= 16'b0;
      end
      else if(sel==3)
        begin
          if (cnt >= top) cnt <= 16'b0;
          cnt <= d;
        end
        else if (cnt >= top)
          cnt <= 16'b0;   
          else
            cnt <= cnt + 16'b1;
    
  	


endmodule
