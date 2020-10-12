from turtle import *
from random import choice

def kwadrat(bok):
    begin_fill()
    for i in range(4):
      fd(bok)
      rt(90)
    end_fill()
kolor = {'red', 'green', 'blue', 'purple', 'pink', 'yellow'}
color('black', 'yellow')
def murek(s,bok):
  for a in s:
     if a == 'f':
         kwadrat(bok)
         fd(bok)
     elif a == 'b':
         kwadrat(bok)
         fd(bok)         
     elif a == 'l':
         bk(bok)
         lt(90)
     elif a == 'r':
        rt(90)
        fd(bok)
     elif a == 'g':
        color('black', 'green')
     elif a == 'p':
        color('black', 'purple')
     elif a == 'c':
        color('black', 'cyan')
        
def kwadracik(n):
    s=''
    s+=n*"f"
    for i in range(n-1):
        if i%2==0:
            s+="rfr"
            s+="g"
        else:
            s+="lfl"
            s+="c"
        s+=(n-1)*"f"
    return s
def spirala(n):
    s=''
    while n>0:
        for i in range(n):
            if i%3 == 0:
                s+="gf"
            elif i%3 == 1:
                s+="pf"
            elif i%3 == 2:
                s+="cf"
        n-=1
        s+="r"
    return s

ht()

tracer(0,0) # szybkie rysowanie     
#murek('fffffffffrffffffgfffflffffffpfffrfffcffl',10)    
#murek(4 * 'fffffr', 14)    
#murek('ffffffffrfrfffffffglflfffffffrfrfffpfffflflfffffffrfrfffffcfflflfffffffrfrfffffff', 20)
murek(kwadracik(8), 20)
update()
murek(spirala(20), 15)
update() # uaktualnienie rysunku

input()
