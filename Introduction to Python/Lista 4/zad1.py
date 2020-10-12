from turtle import fd, bk, lt, rt,ht,  speed, pencolor, fillcolor, begin_fill, end_fill, pu, pd, goto
from random import randint
import numpy as np

speed('fastest')

    
def kwadrat(bok, kolor):
    fillcolor(kolor)
    begin_fill()
    for i in range(4):
        fd(bok)
        lt(90)
    end_fill()
    lt(90)
    pu()
    fd(bok)
    pd()
    lt(-90)

def figura(n, bok):
    kolor = [0, 0, 0]    
    kolor1 = [0.8, 0.0, 0.0]
    kolor2 = [0.0, 0.5, 0.9]
    p = 0
    const_n = n
    while n>0:
        waga = p/const_n
        for k in range(3):
            kolor[k] = waga*kolor1[k] + (1-waga)*kolor2[k]
        for i in range(n):
            kwadrat(bok, kolor)
        n -= 1
        p += 1
        lt(90)
        bk(bok)
       
figura(15, 20)
input()
