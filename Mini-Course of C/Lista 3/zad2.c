#include <stdio.h>
#include <stdlib.h>

char * strcat ( char * destination, const char * source )
{
    char *ptr = destination;
        while (*destination)
            destination++; //przesuwamy sie po destination az napotkamy "\0"
        while (*destination++ = *source++) //jesli destination ani source nie sa równe "\0" to doklejamy kolejna litere
            ;
        return ptr;
}

char* strncat(char* destination, const char* source, size_t num)
{
	char *ptr = destination;
    while (*destination)
        destination++; //przesuwamy sie po destination a napotkamy "\0"
    while (num--)
        if (!(*destination++ = *source++)) //jesli destination ani source nie sa równe "\0" i num>0 to doklejamy kolejna litere
            return ptr;
    *destination = 0;
    return ptr;
}
int strcmp(const char* str1, const char* str2)
{
    while(*str1)
        {
          if(*str1!=*str2)
            break;

          str1++;
          str2++;
        }
    return *(const unsigned char*)str1 - *(const unsigned char*)str2; //zamieniamy na const unsigned char aby dostac roznice numerow w tablicy ASCII
}

int strncmp(const char* str1, const char* str2, size_t num)
{
    while(num)
          {
            if(*str1!=*str2)
                break;

            str1++;
            str2++;
            num--;
          }
    return *(const unsigned char*)str1 - *(const unsigned char*)str2;
}

int main()
{
    char* x = (char*) calloc(30, 1);
    strcat(x, "ala");
    strcat(x, " ma kota");
    printf("%s\n", x);

    char* y = (char*) calloc(30, 1);
    strncat(y, "ala", 3);
    strncat(y, "ala", 1);
    printf("%s\n", y);

    char* a = "ala";
    char* b = "alaa";
    printf("%d\n", strcmp(a, b));

    char* z = "alaa";
    char* c = "alac";
    printf("%d", strncmp(z, c, 4));

    return 0;
}
