from random import randint, random, choice

def randperm(n):
    lista = []
    zbior = set()
    while len(zbior)<n:
        dlugosc = len(zbior)
        x = randint(0, n-1)
        zbior.add(x)
        if len(zbior) != dlugosc:
            lista.append(x)
    print(lista)

randperm(1000000)
    
