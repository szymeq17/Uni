
module bcd(input [3:0] n, output [6:0] o);
  assign x = n[3];
  assign y = n[2];
  assign z = n[1];
  assign w = n[0];
  
  assign a = x || z || y && w || !w && !y;
  assign b = x || !y || z && w || !z && !w;
  assign c = x || y || !z || z && w;
  assign d = x || z && !w || !z && w && y || !z && !y && z || !y && !w && !x;
  assign e = z && !w || !y && !w;
  assign f = x || !z && !w || y && !z || y && !w && z;
  assign g = x || z && !w || !z && y || !x && !y && z;
  
  assign o[6] = a;
  assign o[5] = b;
  assign o[4] = c;
  assign o[3] = d;
  assign o[2] = e;
  assign o[1] = f;
  assign o[0] = g;
endmodule
