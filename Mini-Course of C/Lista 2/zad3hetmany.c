#include <stdio.h>


void start(int b[], int n)
{
    int i;
    for (i=0; i<n; i++)
        b[i]=-1;
}

int not_attacked(int b[], int x, int y)
{
    int i;
    for (i=0; i<x; i++)
        if (b[i]-i==y-x || b[i]+i==y+x || b[i]==y)
            return 0;
    return 1;
}

int queens(int b[], int n)
{
    if(n==1)
        return 1;
    int k=1;
    int ile=0;
    b[0]=0;
    while (k<n && k>=0)
    {
        do
        {
            b[k]++;
        }
        while (b[k]<n && !not_attacked(b, k, b[k]));
        if (b[k]<n)
        {
            k++;
            if(k==n)
            {
                ile++;
                k--;
            }
        }
        else
        {
            b[k]=-1;
            k--;
        }
    }
    return ile;
}



int main()
{
    int n;
    scanf("%d", &n);
    int b[n];
    start(b, n);
    printf("%d", queens(b, n));


    return 0;
}



