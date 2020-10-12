module gray_to_binary(input [31:0] i, output [31:0] o);
  assign o[31] = i[31];
  integer k;
  always_comb begin
    for(k = 30; k >= 0; k = k - 1)
      o[k] = o[k+1] ^ i[k];
  end
endmodule
