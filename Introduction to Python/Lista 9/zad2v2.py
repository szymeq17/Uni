       
from turtle import *

tracer(0, 1)
#speed('fast')
def triangle(n):
    fillcolor('red')
    begin_fill()
    for i in range(3):
        fd(n)
        lt(120)
    end_fill()
def sierpinski(lvl, bok):
    if lvl == 1:
        triangle(bok)
    else:
        sierpinski(lvl-1, bok/2)
        rt(120)
        pu()
        fd(bok/2)
        pd()
        lt(120)
        sierpinski(lvl-1, bok/2)
        pu()
        fd(bok/2)
        pd()

        sierpinski(lvl-1, bok/2)
        pu()
        bk(bok/2)
        lt(60)
        fd(bok/2)
        rt(60)

pu()
lt(90)
fd(100)
rt(90)
pd()        
sierpinski(7, 500)
    
input()   

