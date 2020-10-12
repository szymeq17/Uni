#include <stdio.h>
#include <stdlib.h>
#include <string.h>


//funkcja wypisujaca wybrana linie pliku
void showline(char name[], int line)
{
    FILE *f = fopen(name, "r");

    char L = getc(f);

    while (L != EOF)
    {
        if(line < 1)
        {
            fclose(f);
            return;
        }
        if(line == 1 && L != '\n')
            printf("%c", L);

        if (L == '\n')
        {
            line--;
        }
        L = getc(f);
    }

    fclose(f);
}

void diff(char name1[], char name2[])
{
    FILE *f1 = fopen(name1, "r");
    FILE *f2 = fopen(name2, "r");

    if (f1 == NULL || f2 == NULL)
    {
        printf("Error : Files not open");
        fclose(f1);
        fclose(f2);
        return;
    }

    char L1 = getc(f1);
    char L2 = getc(f2);

    int pos = 0, line = 1;

    while (L1 != EOF || L2 != EOF)
    {
        pos++;

        if (L1 == '\n' && L2 == '\n')
        {
            line++;
            pos = 0;
        }


        if (L1 != L2 )
        {
            printf("%d %d\n", pos, line);
            fclose(f1);
            fclose(f2);
            showline(name1, line);
            printf("\n");
            showline(name2, line);
            return;
        }
        L1 = getc(f1);
        L2 = getc(f2);

    }
    fclose(f1);
    fclose(f2);
}




int main(int argc, char** argv[])
{
    if(argc < 3)
    {
        printf("Za malo argumentow");
        return 0;
    }
    if(argc > 3)
    {
        printf("Za duzo argumentow");
        return 0;
    }

    diff(argv[1], argv[2]);


    return 0;
}
