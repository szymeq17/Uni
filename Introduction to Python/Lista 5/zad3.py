from turtle import *
from random import randint, random
import numpy as np
from duze_cyfry import daj_cyfre

def tablica_cyfr(n):
    cyfra2d = []
    for r in daj_cyfre(n):
        cyfra2d.append(r)
    return cyfra2d

tracer(0, 1)

BOK = 15
D = 15
tab = np.random.rand(D, D, 3)

def move(x, y):
    pu()
    goto(x, y)
    pd()

def kwadrat(x, y, kolor):
    fillcolor([float(x) for x in kolor])
    move(BOK * x, BOK * y)
    begin_fill()
    for i in range(4):
        fd(BOK)
        rt(90)
    end_fill()
def puste(x, y):
    move(BOK*x, BOK*y)
    pu()
    for i in range(4):
        fd(BOK)
        rt(90)

def rysuj_liczbe(n, tab, u):
    k = randint(0, D-1)
    j = randint(0, D-1)
    cyfra = tablica_cyfr(n)
    for y in range(5):
        for x in range(5):
            if cyfra[4-y][x] == "#":
                x = x + u
                kwadrat(10 + x - 40, 10 + y, tab[k, j])
            else:
                x = x + u
                puste(10 + x -40, 10 + y)

u = 0
for i in range(10):
    rysuj_liczbe(i, tab, u)
    u+=7
input()
