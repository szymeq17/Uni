def podziel(s):
    spacja = True
    slowa = []
    k = ""
    for i in range(len(s)):
        if s[i]!=" ":
            k+=s[i]
        else:
            if len(k)>0:
                slowa.append(k)
            k = ""
        if i==len(s)-1 and s[i]!=" ":
            slowa.append(k)
    return slowa

print(podziel("   Ala   ma   kota  "))
