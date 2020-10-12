slowa = set()
pary = set()
lista = []
j=0
def wspak(s):
    k = ""
    for i in range(len(s)):
        k+=s[len(s)-1-i]
    return k    
for x in open('slowa.txt'):
    x = x.strip()
    slowa.add(x)
for x in open('slowa.txt'):
    x = x.strip()
    k = len(slowa)
    x = wspak(x)
    if x in slowa:
        if (x, wspak(x)) not in pary:
            pary.add( (wspak(x), x) )
      
print(pary)


