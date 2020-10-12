import random

def podziel(s):
    spacja = True
    slowa = []
    k = ""
    for i in range(len(s)):
        if s[i] not in '/–.-?!().…,:;0123456789=\ ':
            k+=s[i]
        else:
            if len(k)>0:
                slowa.append(k)
            k = ""
        if i==len(s)-1 and s[i] not in '/–.-?!().…,:;0123456789=\ ':
            slowa.append(k)
    return slowa
    
popular = {}
for x in open('brown.txt'):
    for slowo in podziel(x):
        slowo = slowo.lower()
        if slowo in popular:
            popular[slowo] += 1
        else:
            popular[slowo] = 1
            
pol_ang = {}
def tlumacz(zdanie):
    wynik = []
    for w in zdanie:
        ranking = []
        if w in pol_ang:
           for e in pol_ang[w]:
                if e in popular:
                    ranking.append( (popular[e], e) )
        else:
            wynik.append('[?]')      
        ranking.sort()
        if len(ranking) == 0:
            wynik.append(random.choice(pol_ang[w]))
        else:
            wynik.append(ranking[len(ranking)-1][1])

    return ' '.join(wynik)

for wiersz in open('pol_ang.txt'):
    wiersz = wiersz.strip()
    if '=' not in wiersz:
        continue
    pola = wiersz.split('=')
    if len(pola) != 2:
        continue
    p, a = pola
    if p in pol_ang:
        pol_ang[p].append(a)
    else:
        pol_ang[p] = [a]            
    

zdanie = 'chłopiec i dziewczyna pójść do kino'.split()
zdanie2 = 'gdzie ty iść'.split()

print(tlumacz(zdanie))
print(tlumacz(zdanie2))
#print(popular)
