#include <stdio.h>
#include <stdlib.h>


char * strcat ( char * destination, const char * source )
{


    char* point = destination + sizeof *destination;   //wskaznik na koniec destination


    while(*source!='\0')
    {
        *point++ = *source++; // przepisanie z source kazdej literki
    }
    *point='\0'; //koniec stringa;


    return destination;
}


char * strncat ( char * destination, const char * source, size_t num )
{
    char* point = destination + sizeof *destination;   //wskaznik na koniec destination


    while(*source!='\0' &&  num--)
    {
        *point++ = *source++; // przepisanie z source kazdej literki (do konca lub do momentu az num=0)

    }

    *point='\0';  //koniec stringa;



    return destination;
}

int strcmp ( const char * str1, const char * str2 )
{
    while(*str1)
    {
        if (*str1!=*str2)
        {
            return *(const unsigned char*)str1-*(const unsigned char*)str2;  // zeby skorzystac z ASCII konwertuje na unsigned
        }
        *str1++;
        *str2++;
    }
    return 0;
}


int strncmp ( const char * str1, const char * str2, size_t num )
{
    while(*str1!='\0' && num--)
    {
        if (*str1!=*str2)
        {
            return *(const unsigned char*)str1-*(const unsigned char*)str2;  // zeby skorzystac z ASCII konwertuje na unsigned
        }
        *str1++;
        *str2++;
    }
    return 0;
}




int main()
{
    printf("Testy dla strcat\n");
    char* test_str = (char*)calloc(50,1);
    strcat(test_str,"alla");
    strcat(test_str,"ma");
    strcat(test_str,"cota");
    strcat(test_str,"niewiem");
    printf("%s\n", test_str);



    printf("testy dla strncat\n");
    char dest[17]="wsta";
    strncat(dest,"ala", 10);
    char dest2[17]="wstawaj";
    strncat(dest2,"ala", 2);
    printf("%s\n", dest);
    printf("%s\n", dest2);



    printf ("testy dla strcmp\n");
    char* a="ala";
    char* b= "alba";
    strcmp(a,b);




    char* c="ala";
    char* d= "ala";
    strcmp(c,d);




    char* e="aladster";
    char* f= "alaaaaas";
    strcmp(e,f);




    printf("testy dla strncmp\n");
     char* a1="alana";
    char* b1= "alaba";
    strncmp(a1,b1,4);




     char* c1="omanoter";
    char* d1= "omanote";
    strncmp(c1,d1,10);



return 0;
}
