alf1 = {}
alf2 = {}
a = 'aąbcćdeęfghijklłmnńoóprsśtuwyzźż' #32
for i in range(len(a)):
    alf1[i] = a[i]
    alf2[a[i]] = i

def ceasar(s, k):
    nowe = ''
    for i in range(len(s)):
        nowe += alf1[(alf2[a[i]]+k)%32]
    return nowe

s = 'abcdef'
k = 33
print(ceasar(s, k))
