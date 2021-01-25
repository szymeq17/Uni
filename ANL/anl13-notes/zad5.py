import math
from scipy.integrate import quad

def romberg(k, func, a, b):
    T = [[]]
    # WYPEŁNIANIE PIERWSZEJ KOLUMNY
    for i in range(k+1):
        n = 2**i
        hk = (b-a)/n
        xs = [a + i*hk for i in range(n+1)]
        sum = 0
        for j in range(n+1):
            to_add = func(xs[j])
            if(j==0 or j==n):
                to_add *= 1/2
            sum += to_add
        T[0].append(sum*hk)
    # WYPEŁNIANIE POZOSTAŁYCH KOLUMN
    for i in range(1, k+1):
        column = []
        for j in range(0, k-i+1):
            T_i_j = (4**i * T[i-1][j+1] - T[i-1][j])/(4**i - 1)
            column.append(T_i_j)
        T += [column]
    
    return T[0][k]

print(romberg(16, lambda x: 2021 * x**5 - 2020 * x**4 + 2019 * x**2, -1, 2))
print("POPRAWNY WYNIK:")
print(quad(lambda x: 2021 * x**5 - 2020 * x**4 + 2019 * x**2, -1, 2)[0])
print("-------------------")
print(romberg(16, lambda x: 1/(1 + 25 * x**2), -2, 2))
print("POPRAWNY WYNIK:")
print(quad(lambda x: 1/(1 + 25 * x**2), -2, 2)[0])
print("-------------------")
print(romberg(16, lambda x: math.sin(7*x - 2)/x, 2, 3 * math.pi))
print("POPRAWNY WYNIK:")
print(quad(lambda x: math.sin(7*x - 2)/x, 2, 3 * math.pi)[0])