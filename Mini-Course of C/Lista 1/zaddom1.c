#include <stdio.h>


int main()
{
    int m, n;
    scanf("%d", &m);
    char A[m];
    scanf("%s", A);
    scanf("%d", &n);
    char B[n];
    scanf("%s", B);
    int i;
    for(i=0; i<m; i++)
    {
        if(A[i]<B[i])
        {
            printf("%s", A);
            return 0;
        }
        else if(A[i]>B[i])
        {
            printf("%s", B);
            return 0;
        }
        if(i>=n-1)
        {
            printf("%s", B);
            return 0;
        }
    }
    printf("%s", A);
    return 0;


    return 0;
}

