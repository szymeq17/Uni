from math import sqrt # pierwiastek kwadratowy
from math import log


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
	w = len( str( silnia( n ) ) )
	if w % 100 == 12 or w % 100 == 13 or w % 100 == 14:
		print(n, "! ma", w, "cyfr")	
	elif w % 10 == 2 or w % 10 == 3 or w % 10 == 4:
		print(n, "! ma", w, "cyfry")
	else:
		print(n, "! ma", w, "cyfr")
	print()
	n = n + 1

   
