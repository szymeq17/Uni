from turtle import *
from random import randint, random
import numpy as np

speed('fastest')

def krzyz(bok, kolor):
	fillcolor(kolor)
	begin_fill()
	lt(45)
	fd(bok)
	lt(90)
	for i in range(3):
		fd(bok)
		rt(90)
		fd(bok)
		lt(90)
		fd(bok)
		lt(90)
	fd(bok)
	rt(90)
	fd(bok)
	lt(45)
	end_fill()

kolor2 = np.array( [0.3, 0.0, 1.0]) 
#kolor1 = [float(x) for x in kolor1]
#kolor2 = [float(x) for x in ]


bok=20
dl=215
ilosc = 35
for i in range(ilosc):
	kolor1 = [1, randint(0, 128)/256, randint(0, 128)/256]
	lt(360/ilosc)
	pu()
	fd(dl)
	pd()
	krzyz(bok, kolor1)
	pu()
	fd(-dl)
	pd()
	
input()
