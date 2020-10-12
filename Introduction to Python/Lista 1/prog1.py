from math import sqrt # pierwiastek kwadratowy
from math import log


def potega(a,n):
    wynik = 1  # zmienna lokalna
    for i in range(n):
       wynik = wynik * a   # albo: wynik *= a
    return wynik

def silnia(n):
	if n == 0:
		return 1
	else: 
		sil = 1
		j = 2
		for i in range(n-1):
			sil = sil * j
			j = j + 1		 
	return sil 

n = 4

for i in range(97):
	print(n, "! ma", len( str( silnia( n ) ) ), "cyfr")
	print()
	n = n + 1

   
