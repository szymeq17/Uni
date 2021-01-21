from scipy.integrate import quad
import numpy as np
import math

# SPOSÓB 1

def lambda_k(x, k, n, a, b):
    res = 1
    h = (b-a)/n
    for i in range(n+1):
        if(i != k):
            res *= (x - a - h*i)/(h*(k-i))
    return res

def Nn(a, b, n, func):
    h = (b - a)/n
    res = 0
    for i in range(n+1):
        res += quad(lambda x: lambda_k(x, i, n, a, b), a, b)[0] * func(a + i * h)
    
    return res

# SPOSÓB 2

def to_integrate(x, n, k):
    res = 1
    for i in range(n+1):
        if(i != k):
            res *= (x - i)
    return res


def Ak(k, n, a, b):
    h = (b-a)/n
    first = ((-1)**(n-k) * h)/(math.factorial(k)*math.factorial(n-k))
    second = quad(lambda x: to_integrate(x, n, k), 0, n)[0]
    return first*second

def Nn2(a, b, n, func):
    h = (b - a)/n
    res = 0
    for i in range(n+1):
        res += Ak(i, n, a, b) * func(a + i * h)
    
    return res


# WYNIKI

def f(x):
    return 1/(1 + x*x)

for i in range(2, 13, 2):
    x = Nn(-3, 3, i, f)
    y = 2 * np.arctan(3)
    print("dla n =", i, "wynik:", x, "poprawny wynik:", y, "błąd względny:", abs(y - x)/y)
