//kod może być trochę nieczytelny, ale pomysł jest prosty: to taki mergesort dla 4 liczb
module sorter(input [15:0] i, output [15:0] o);
  logic [7:0] half1, half2, half3, half4, half5, half6;
  assign half1 = i[15:12] > i[11:8] ? { i[15:12], i[11:8] } : { i[11:8], i[15:12] };
  assign half2 = i[7:4] > i[3:0] ? { i[7:4], i[3:0]} : { i[3:0], i[7:4] };
  assign half3 = half1[7:4] > half2[7:4] ? (half2[7:4] > half1[3:0] ? {half1[7:4], half2[7:4]} : {half1[7:4], half1[3:0]}) : (half2[3:0] > half1[7:4] ? {half2[7:4], half2[3:0]} : {half2[7:4], half1[7:4]});
  assign half4 = half1[3:0] > half2[3:0] ? (half1[3:0] > half2[7:4] ? {half2[7:4], half2[3:0]} : {half1[3:0], half2[3:0]}) : (half2[3:0] > half1[7:4] ? {half1[7:4], half1[3:0]} : {half2[3:0], half1[3:0]});
  assign o = { half3, half4 };
endmodule
