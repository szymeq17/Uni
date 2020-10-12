from losowanie_fragmentow import losuj_fragment

def losuj_haslo(n):
    haslo = ""
    while True:
        los = losuj_fragment()

        if len(los + haslo) <= n and ((n - len(los + haslo)) % 2 == 0 or (n - len(los + haslo)) % 3 == 0  or (n - len(los + haslo)) % 4 == 0):
            haslo = haslo + los
        if len(haslo) == n:
            break
    print(haslo)

for i in range(10):
    losuj_haslo(8)
for i in range(10):
    losuj_haslo(12)
