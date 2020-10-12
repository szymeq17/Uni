#include <stdio.h>

typedef struct Elementy
{
    int type;
    char string[10];
    int number;
    int pair1;
    int pair2;
    float floating_point;
    //Types:
    //1 - string, 2 - number, 3 - pair, 4 - floating_point

}   element;
#define size 3 //ustawilem taka dlugosc kolejki, aby mozna bylo szybko testowac
element queue[size];
int last = -1; //pozycja startowa (kiedy kolejka jest pusta)
int first = 0;
void push()
{
    if(last==size-1) //sprawdza, czy jest jeszcze miejsce w kolejce
    {
        printf("Kolejka jest pelna\n\n");
        return;
    }
    last++;
    int type;
    printf("Aby dodac napis wpisz: 1\n");
    printf("Aby dodac liczbe calkowita wpisz: 2\n");
    printf("Aby dodac pare liczb calkowitych wpisz: 3\n");
    printf("Aby dodac liczbe zmiennoprzecinkowa wpisz: 4\n\n");

    scanf("%d", &type);

    switch(type)
    {
    case 1:
    {
        printf("Wpisz napis (max. 10 znakow): ");
        scanf("%s", queue[last].string);
        queue[last].type = 1;
        break;
    }
    case 2:
    {
        printf("Wpisz liczbe: ");
        int num;
        scanf("%d", &num);
        queue[last].number = num;
        queue[last].type = 2;
        break;
    }
    case 3:
    {
        printf("Wpisz pare liczb calkowitych:\n");
        printf("Pierwsza: ");
        scanf("%d", &queue[last].pair1);
        printf("Druga: ");
        scanf("%d", &queue[last].pair2);
        queue[last].type = 3;
        break;
    }
    case 4:
    {
        printf("Wpisz liczbe zmiennopozycjna: ");
        float x;
        scanf("%f", &x);
        queue[last].floating_point = x;
        queue[last].type = 4;
        break;
    }

    }
}
void pop()
{
    if(first>last)
    {
        printf("Kolejka jest pusta\n");
        return;
    }
    if(first==last)
        last=-1;

    switch(queue[first].type) //wybiera format prezentacji wyci¹ganego elemntu w zale¿noœci od jego typu
        {
            case 1:
                {
                  printf("Z kolejki usunieto: %s\n", queue[first].string);
                  break;
                }


            case 2:
                {
                  printf("Z kolejki usunieto: %d\n", queue[first].number);
                  break;
                }


            case 3:
                {
                    printf("Z kolejki usunieto: (%d, %d)\n", queue[first].pair1, queue[first].pair2);
                    break;
                }

            case 4:
                {
                    printf("Z kolejki usunieto: %f\n", queue[first].floating_point);
                    break;
                }

        }
        first = (first+1)%size;
        return;

}



int main()
{
    int operation;
    while(1)
    {
        printf("Aby wyciagnac element z kolejki wpisz: 0 \nAby dodac element do kolejki wpisz: 1\n");
        scanf("%d", &operation);
        if(operation == 0)
        {
            pop();
        }
        if(operation == 1)
        {
            push();
        }
        else
        {
            printf("Prosze wpisac 0 lub 1\n");
        }
    }
}
