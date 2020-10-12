def dzielniki(n):
    if n == 1:
        return [1]
    sqrt = int(n**0.5) + 1
    dzielniki = []
    for i in range(1, sqrt+1):
        if n % i == 0:
            dzielniki.append(i)
            dzielniki.append(int(n/i))
    return dzielniki
def pierwsza(n):
    if len(dzielniki(n)) == 2:
        return True
    else:
        return False
def zbior_pierwszych(n):
    zbior = set()
    L = dzielniki(n)
    for e in L:
        if pierwsza(e):
            zbior.add(e)
    return zbior

print(zbior_pierwszych(24))
