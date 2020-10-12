#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

Node* new_node()
{
    Node* n = (Node*)malloc(sizeof(Node));
    n->data_type = 0;
    n->allocated_size = 0;
    n->data = NULL;
    n->next_node = NULL;
    return n;
}

void push(FIFO* f)
{
    printf("Wybierz typ elementu, ktory chcesz dodac: \n 1. int \n 2. tablica intow \n 3. float \n 4. string \n");
    int type;
    scanf("%d", &type);
    Node* new_elem = new_node();
    new_elem->data_type = type;

    switch (type)
    {
    case 1:
    {
        new_elem->allocated_size = sizeof(int);
        new_elem->data = malloc(new_elem->allocated_size);
        int d;
        printf("Wpisz liczbe calkowita:\n");
        scanf("%d", &d);
        *((int*)new_elem->data) = d;
        break;
    }
    case 2:
    {
        int size;
        printf("Podaj rozmiar tablicy: \n");
        scanf("%d", &size);
        new_elem->allocated_size = size * sizeof(int);
        new_elem->data = malloc(new_elem->allocated_size);
        printf("Wpisz tablice: \n");
        int* tablica = new_elem->data;
        for (int i=0; i<size; i++)
        {
            scanf("%d",&tablica[i]);
        }
        break;
    }
    case 3:
    {
        new_elem->allocated_size = sizeof(float);
        new_elem->data = malloc(new_elem->allocated_size);
        float f;
        printf("Wpisz liczbe zmiennopozycyjna:\n");
        scanf("%f",&f);
        *((float*)new_elem->data) = f;
        break;
    }
    case 4:
    {
        int len;
        printf("Podaj dlugosc napisu: \n");
        scanf("%d",&len);
        new_elem->allocated_size = sizeof(char)*(len+1);
        new_elem->data =  malloc(new_elem->allocated_size);
        printf("Wpisz napis :\n");
        scanf("%s", new_elem->data);
        break;
    }
    }

    if(f->fifo_start == NULL)
    {
        f->fifo_start = new_elem;
    }
    else
    {
        f->fifo_end->next_node = new_elem;
    }
    f->fifo_end = new_elem;
}

void pop(FIFO* f)
{

    assert(f->fifo_start != NULL);

    Node* tmp = f->fifo_start;
    f->fifo_start = f->fifo_start->next_node;
    Node* r = tmp;

    int t = tmp->data_type;
    switch(t)
    {
    case 1:
    {
        printf("Usunieto: %d \n", *(int*) tmp->data);
        break;
    }

    case 2:
    {
        printf("Usunieto tablice: ");
        int* tab = (int*) tmp->data;
        size_t n = tmp->allocated_size/4;
        while(n)
        {
            printf("%d ", *tab);
            tab++;
            n--;
        }
        printf("\n");
        break;
    }
    case 3:
    {
        printf("Usunieto: %f \n", *(float*) tmp->data);
        break;
    }
    case 4:
    {
        printf("Usunieto: %s \n", (char*) tmp->data);
        break;
    }
    }
    free(tmp->data);
    return r;
}

FIFO new_fifo()
{
    FIFO f;
    f.fifo_start = NULL;
    f.fifo_end = f.fifo_start;
    return f;
}

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
        }
        }
    }
    return 0;
}
