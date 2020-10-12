module microwave(input clk, nrst, door, start, finish,
                output heat, light, bell);
  const logic [2:0] CLOSED = 3'b000, OPEN = 3'b001, 
  					PAUSE = 3'b010, COOK = 3'b011, 
					BELL = 3'b100;
  logic [2:0] q;
  always_comb begin
    heat = 0; light = 0; bell = 0;
    unique case (q)
      OPEN, PAUSE: light = 1;
      COOK: begin heat = 1; light = 1; end
      BELL: bell = 1;
    endcase
  end
  
  always_ff @(posedge clk or negedge nrst)
    if(!nrst) q <= CLOSED;
  else unique case(q)
    CLOSED: 
      begin 
        if(start && !door) q <= COOK; 
          else if(door) q  <= OPEN;
      end
    OPEN: if(!door) q <= CLOSED;
    COOK: 
      begin
        if(door) q <= PAUSE;
        else if(finish) q <= BELL;
      end
    PAUSE: if(!door) q <= COOK;
    BELL: if(door) q <= OPEN;
  endcase

endmodule
