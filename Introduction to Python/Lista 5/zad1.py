def F(n):
    if n%2 == 0:
        return n/2
    else:
        return 3*n + 1

def energia(n):
    pozycja = 0;
    while n!=1:
        n = F(n)
        pozycja += 1
    return pozycja

def analiza_collatza(a, b):
    L = []
    for i in range(a, b+1):
        L.append(energia(i))
    suma = 0
    for e in L:
        suma += e
    srednia = suma/len(L)
    print("Średnia: ", srednia)
    L.sort()
    if len(L)%2==1:
        mediana = L[int(len(L)/2) + 1]
    else:
        mediana = L[int(len(L)/2)] + L[int(len(L)/2)-1]
    print("Media: ", mediana)
    print("Maksymalna energia: ", L[len(L)-1])
    print("Minimalna energia: ", L[0])

analiza_collatza(1, 7)
    
