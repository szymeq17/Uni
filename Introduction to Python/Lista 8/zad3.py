def slownik(s):
    d = {}
    for l in s:
        if l in d:
            d[l] += 1
        else:
            d[l] = 1
    return d
    
def ukladalne(s, u):
    ds = slownik(s)
    du = slownik(u)
    for e in ds:
        if e not in du:
            return False
        if ds[e]>du[e]:
            return False
    return True
def ukladalnev2(s, u):
    ds = slownik(s)
    du = slownik(u)
    for e in ds:
        if e not in du:
            return False
        if ds[e]!=du[e]:
            return False
    for e in du:
        if e not in ds:
            return False
        if ds[e]!=du[e]:
            return False
    return True
def sklej(s):
    s2 = ''
    for i in range(len(s)):
        if s[i] == ' ': 
            s2 = s[:i] + s[i+1:]
            return s2
    return s        
slowa = set()    
for x in open('popularne_slowa.txt'):
    x = x.strip()
    slowa.add(x)
                
def zagadka(dane):
    slowa = set()    
    for x in open('popularne_slowa.txt'):
        x = x.strip()
        x = x.lower()
        dane = sklej(dane).lower()
        if ukladalne(x, dane):
            slowa.add(x)
    #return slowa
    warianty = set()
    for s in slowa:
        for t in slowa:
            k = s+t
            if ukladalnev2(k, dane):
                if (t, s) not in warianty:
                    warianty.add( (s, t) )
                    #print( (s, t) )
    return warianty
print(zagadka("Szymon Rysz"))



            
    



