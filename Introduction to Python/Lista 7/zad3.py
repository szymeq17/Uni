def podziel(s):
    spacja = True
    slowa = []
    k = ""
    for i in range(len(s)):
        if s[i] not in '/–.-?!().…,:;0123456789 ':
            k+=s[i]
        else:
            if len(k)>0:
                slowa.append(k)
            k = ""
        if i==len(s)-1 and s[i] not in '/–.-?!().…,:;0123456789 ':
            slowa.append(k)
    return slowa


ilerazy = {}
for w in open('lalka-tom-pierwszy.txt'):
    w = w.strip()
    for s in podziel(w):
        s = s.lower()
        if s not in ilerazy:
            ilerazy[s] = 1
        else:
            ilerazy[s] += 1
def waga_10(a, d):
    wagi = d
    for klucz in wagi:
        ile = d[klucz]
        d[klucz] = ile * (len(klucz)**a)
    lista = [ (value, key) for key, value in d.items() ]
    lista.sort()
    for i in range(10):
        print(lista[len(lista)-1-i][1], ":", lista[len(lista)-1-i][0]) 
print("Dla a=1:")
waga_10(1, ilerazy) 
print("Dla a=2:")
waga_10(2, ilerazy)
print("Dla a=3:")
waga_10(3, ilerazy)        
    

