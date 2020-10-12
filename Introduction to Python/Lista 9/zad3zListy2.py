def kolko(n):
    r = n/2
    for i in range(n):
        for j in range(n):
            if ((int(n/2)-i)**2 + (int(n/2)-j)**2)**0.5 > r:
                print(" ", end='')
            else:
                print("#", end='')
        print()  
def kolko2(n, sp):
    r = n/2
    for i in range(n):
        print(sp*" ", end='')
        for j in range(n):
            if ((int(n/2)-i)**2 + (int(n/2)-j)**2)**0.5 > r:
                print(" ", end='')
            else:
                print("#", end='')
        print() 

def balwan(a, b, c):    
    kolko2(a, int((c-a)/2))
    kolko2(b, int((c-b)/2))
    kolko(c)
    


balwan(7, 9, 15)

