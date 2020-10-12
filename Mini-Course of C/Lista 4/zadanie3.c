#include <stdio.h>
#include <stdlib.h>


typedef struct node
{
    int value;
    struct node* next_node;
    struct node* prev_node;
} Node;

typedef struct list
{
    Node* start_node;
    Node* end_node;
} List;

Node* new_node(int v)
{
    Node* n = (Node*)malloc(sizeof(Node));
    n->value = v;
    n->next_node = NULL;
    n->prev_node = NULL;
    return n;
}

List new_list()
{
    List l;
    l.start_node = NULL;
    l.end_node = NULL;
    return l;
}


void add_front(List* l, int x)
{
    if(l->end_node == NULL || l->start_node == NULL)
    {
        l->start_node = new_node(x);
        l->end_node = l->start_node;
        return;
    }
    else
    {
        Node* t = new_node(x);
        l->end_node->next_node = t;
        t->prev_node = l->end_node;
        l->end_node = t;
    }
}

void add_back(List* l, int x)
{
    if(l->end_node == NULL || l->start_node == NULL)
    {
        l->end_node = new_node(x);
        l->start_node = l->end_node;
        return;
    }
    else
    {
        Node* t = new_node(x);
        l->start_node->prev_node = t;
        t->next_node = l->start_node;
        l->start_node = t;
    }
}
void remove_front(List* l)
{
    if(l->start_node == NULL || l->end_node == NULL)
    {
        printf("LISTA PUSTA\n");
        return;
    }
    else
    {
        Node* tmp = l->end_node;
        printf("%d\n", tmp->value);
        if(l->start_node == l->end_node)
        {
            l->start_node = NULL;
            l->end_node = NULL;
            free(tmp);
            return;
        }
        l->end_node = tmp->prev_node;
        if(!l->end_node)
            l->start_node = NULL;
        free(tmp);
    }
}
void remove_back(List* l)
{
    if(l->start_node == NULL || l->end_node == NULL)
    {
        printf("LISTA PUSTA\n");
        return;
    }
    else
    {
        Node* tmp = l->start_node;
        printf("%d\n", tmp->value);
        if(l->start_node == l->end_node)
        {
            l->start_node = NULL;
            l->end_node = NULL;
            free(tmp);
            return;
        }
        l->start_node = tmp->next_node;
        if(!l->start_node)
            l->end_node = NULL;
        if(l->start_node == NULL)
            printf("TAK\n");
        free(tmp);
    }
}

int main()
{
    List list = new_list();
    int n;
    scanf("%d", &n);
    while(n--)
    {
        int op;
        scanf("%d", &op);
        switch(op)
        {
        case 1:
            {
                int a;
                scanf("%d", &a);
                add_back(&list, a);
                break;
            }
        case 2:
            {
                int a;
                scanf("%d", &a);
                add_front(&list, a);
                break;
            }
        case 3:
            {
                remove_back(&list);
                break;
            }
        case 4:
            {
                remove_front(&list);
                break;
            }
        }

    }

    return 0;
}
