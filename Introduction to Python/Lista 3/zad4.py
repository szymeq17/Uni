import tkinter
from turtle import fd, bk, lt, rt, ht,  speed, pencolor, pu, pd
from random import randint

speed('fastest')

def prostokat(bok):
    dl = randint(50, 200)
    for i in range(2):
        fd(bok)
        lt(90)
        fd(dl)
        lt(90)
    pu()
    fd(bok+5)
    pd()

    
n = 50
k = 8
pu()
bk(400)
pd()
for i in range(n):
    prostokat(k)


input()
