#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "fifo.h"


int main()
{


    FIFO f = new_fifo();
    int n;
    while (1)
    {
        printf("Jesli chcesz dodac element wcisnij 1\n");
        printf("Jesli chcesz usunac element wcisnij 2\n");
        scanf("%d",&n);
        switch(n)
        {
        case 1:
        {
            push(&f);
            break;

        }
        case 2:
        {
            pop(&f);
            break;
        }
        }
    }
    return 0;
}
