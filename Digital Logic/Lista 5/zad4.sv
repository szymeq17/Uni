module decoder_2_to_4(input [1:0] i, output [3:0] o);
	assign o = 4'b1 << i;
endmodule

module decoder_3_to_8(input [2:0] i, output [7:0] o);
  logic [3:0] four_msb_of_o;
  logic [3:0] four_lsb_of_o;
  decoder_2_to_4 d1(i[1:0], four_msb_of_o);
  decoder_2_to_4 d2(i[1:0], four_lsb_of_o);
  assign o = { (i[2] & four_msb_of_o[3]), (i[2] & four_msb_of_o[2]),
               (i[2] & four_msb_of_o[1]), (i[2] & four_msb_of_o[0]),
               (!i[2] & four_lsb_of_o[3]), (!i[2] & four_lsb_of_o[2]),
               (!i[2] & four_lsb_of_o[1]), (!i[2] & four_lsb_of_o[0]) }; 
  
endmodule