def pierwsze(n):
    lista = []
    modulo = [2]
    for i in range(0, n+1):
        lista.append(i)
    for i in range(3, n+1):
        for j in range(len(modulo)):
            if i%modulo[j]==0:
                lista[i] = 0
                break
        if lista[i]!=0: modulo.append(lista[i])
    pierwsze = []
    for i in range(n+1):
        if lista[i]!=0:
            pierwsze.append(lista[i])
    return pierwsze
def czy_palindrom(k):
    p = str(k)
    dl=int(len(p)/2)
    if len(p)%2!=0:
        dl+=1
    for i in range(dl):
        if p[i] != p[len(p)-1-i]:
            return False
    return True
        
        
def palindromy_pierwsze(n):
    L = pierwsze(n)
    palindromy = []
    for i in range(len(L)):
        if czy_palindrom(L[i]):
            palindromy.append(L[i])
    print(palindromy)

palindromy_pierwsze(100000)

