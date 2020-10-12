def kółko(n):
    k=int((n-1)/2)
    for i in range(k):
        print((k-(i+1))*" ", (3+(2*i))*"#", sep='')
    for i in range(n-6):
        print(n*"#")
    for i in range(k):
        print(i*" ", (n-(2*i))*"#", sep='')


kółko(7)
kółko(9)
kółko(11)

