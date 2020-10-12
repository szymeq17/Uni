#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
    int n;
    scanf("%d", &n);
    char strings[n][21], temp[21];
    for(int i=0; i<n; i++)
    {
        scanf("%s", temp);
        strcpy(strings[i], temp);
    }
    for(int i=0; i<n; i++)
      for(int j=i+1; j<n; j++)
      {
         if(strcmp(strings[i],strings[j])>0)
            {
                strcpy(temp,strings[i]);
                strcpy(strings[i],strings[j]);
                strcpy(strings[j],temp);
            }
      }
    int cnt = 1;
    for(int i=0; i<n; i++)
    {
        if(i != n && strcmp(strings[i],strings[i+1]) == 0)
        {
            cnt++;
        }
        else
        {
            printf("%s %d\n",strings[i], cnt);
            cnt = 1;
        }
    }



    return 0;
}
