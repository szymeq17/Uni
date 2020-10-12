from random import randint, random, choice

def randperm(n):
    wszystkie = []
    q = 0
    while q<n:
        k = randint(0, n-1)
        if k not in wszystkie:
            wszystkie.append(k)
            q += 1
    print(wszystkie)
randperm(1000000)
