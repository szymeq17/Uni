from turtle import *
from random import randint, random


import numpy as np

tracer(0,1)

def move(x, y):
    pu()
    goto(x, y)
    pd()
    
def kwadrat(bok, kolor):
    fillcolor(kolor)
    begin_fill()
    for i in range(4):
        fd(bok)
        rt(90)
    end_fill()

    
DX = 63
DY = 52
BOK = 10

def rysuj_tablice(tab):
    for x in range(DX):
        for y in range(DY):
            move(BOK * x, BOK * y)
            kwadrat(BOK, tab[DX-1-x][DY-1-y])
            print(x, y)
            
def make_numpy(s):
    k = ''
    l = ''
    m = ''
    poz = 0
    for i in range(1, len(s)):
        if s[i]!="," and s[i]!=")":
            k+=s[i]
        else:   
            poz = i+1
            break
    for i in range(poz, len(s)):
        if s[i]!="," and s[i]!=")":
            l+=s[i]
        else:
            poz = i+1
            break
    for i in range(poz, len(s)):
        if s[i]!="," and s[i]!=")":
            m+=s[i]
        else:
            poz = i+1
            break
    k=int(k)/256
    l=int(l)/256
    m=int(m)/256
    #tablica =[int(k), int(l), int(m)]
    tablica = [k, l, m]
    return tablica

painting = []
for x in open('niespodzianka.txt'):
    wiersz = []
    for tab in x.split():        
        wiersz.append(make_numpy(tab))
    painting.append(wiersz)
    
rysuj_tablice(painting)
print(len(painting[0]))
input()
