def szachownica(n, k):

    for a in range(n):
        for j in range(k):   
            for i in range(n):
                print(k*" ", k*"#", sep='', end='')
            print()
        for j in range(k):   
            for i in range(n):
                print(k*"#", k*" ", sep='', end='')
            print()

szachownica(4,3)
        
