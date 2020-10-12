import random

def losowa_lista(N):
    wynik = []
    for i in range(N):
        wynik.append(random.randint(0,10))
    return wynik

def usun_duplikaty(L):
    pary = []
    for i in range(len(L)):
        pary.append( (L[i], i) )
    pary.sort()
    
    element = pary[0][0]
    indeks = pary[0][1]
    pary2 = []
    for i in range(len(pary)):
        if element == pary[i][0]:
            if pary[i][1] < indeks:
                indeks = pary[i][1]
        else:
                pary2.append( (indeks, element))
                element = pary[i][0]
                indeks = pary[i][1]
    pary2.sort()

    bez_duplikatow = []
    for i in range(len(pary2)):
        bez_duplikatow.append(pary2[i][1])

    return bez_duplikatow


print(usun_duplikaty(losowa_lista(500000)))
