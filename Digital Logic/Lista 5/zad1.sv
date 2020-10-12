// Half adder
module halfadder(
  input a, 
  input b,
  output o,
  output c
);

  assign o = a ^ b;
  assign c = a & b;

endmodule

// Full adder
module fulladder(
  input a,
  input b,
  input d,
  output o,
  output c
);

  logic t, c1, c2;

  halfadder ha1(a, b, t, c1);
  halfadder ha2(t, d, o, c2);

  assign c = c1 | c2;

endmodule

/*Układ ma mnożyć liczbe zapisaną na 8-bitach przez 1, 2, 3 lub 4.
Zamiast mnożyć, układ będzie dodawał liczbę samą do siebie odpowiednią
liczbę razy. 
np. 4*x to x + x + x + x
Największa liczba przez jaką będziemy mnożyć 8-bitową liczbę to 4,
więc aby zmieścić wynik potrzebujemy 10 bitów
Będą potrzebne 3 sumatory 10-bitowe. (implementacja poniżej)
Aby określać przez jaką liczbę bedziemy mnożyć, użyjemy kodowania
one-hot zapisanego na 5 bitach.
Aby ustalać przez jaką liczbę mnożyć, będziemy też potrzebowali
bramki AND, która przyjmie 10-bitową liczbe
i wykona operacje AND z jakąś 1-bitową wartością na każdym
bicie tej liczby. (implementacja poniżej)*/

// Sumator szeregowy (10-bitowy)
module ten_bits_adder(input [9:0] a, input [9:0] b, input c0,
                      output[9:0] o, output c);
  logic [9:0] cn;
  fulladder fa0(a[0], b[0], c0, o[0], cn[0]);
  fulladder fa1(a[1], b[1], cn[0], o[1], cn[1]);
  fulladder fa2(a[2], b[2], cn[1], o[2], cn[2]);
  fulladder fa3(a[3], b[3], cn[2], o[3], cn[3]);
  fulladder fa4(a[4], b[4], cn[3], o[4], cn[4]);
  fulladder fa5(a[5], b[5], cn[4], o[5], cn[5]);
  fulladder fa6(a[6], b[6], cn[5], o[6], cn[6]);
  fulladder fa7(a[7], b[7], cn[6], o[7], cn[7]);
  fulladder fa8(a[8], b[8], cn[7], o[8], cn[8]);
  fulladder fa9(a[9], b[9], cn[8], o[9], c);

endmodule

module big_and(input [9:0] i, input [0:0] x,
                      output [9:0] o);
  assign o[0] = i[0] & x;
  assign o[1] = i[1] & x;
  assign o[2] = i[2] & x;
  assign o[3] = i[3] & x;
  assign o[4] = i[4] & x;
  assign o[5] = i[5] & x;
  assign o[6] = i[6] & x;
  assign o[7] = i[7] & x;
  assign o[8] = i[8] & x;
  assign o[9] = i[9] & x;
endmodule

module multiplicator1234(input[7:0] a, input [4:0] m,
                         output [9:0] o);
  logic [9:0] add_result = a;
  logic cn, cn2, cn3;
  logic [9:0] res0, res1, res2, res3, res4;
  big_and AND1(add_result, m[4], res0);
  ten_bits_adder tia1(add_result, res0, 1'b0, res1, cn);
  assign condition = m[3] | m[4];
  big_and AND2(res1, condition, res2);
  ten_bits_adder tba2(add_result, res2, 1'b0, res3, cn2);
  assign condition1 = m[2] | m[3] | m[4];
  big_and AND3(res3, condition1, res4);
  ten_bits_adder tba3(add_result, res4, 1'b0, o, cn3);


endmodule
  