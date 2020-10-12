from duze_cyfry import daj_cyfre

def duze_liczby(n):
	dl = len(str(n))
	liczba = str(n)
	for i in range(dl):
		for r in daj_cyfre(int(liczba[i])):
			print(r)
		print()
	


duze_liczby(123)
duze_liczby(199999)
