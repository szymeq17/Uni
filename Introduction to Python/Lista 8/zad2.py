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
            return "NIE"
        if ds[e]>du[e]:
            return "NIE"
    return "TAK"
    

print(ukladalne("aktyw", "lokomotywa"))
