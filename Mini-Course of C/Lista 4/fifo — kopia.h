#ifndef FIFO_H
#define FIFO_H

typedef struct node
{
    int data_type;
    size_t allocated_size;
    void* data;
    struct node* next_node;
} Node;

typedef struct fifo
{
    Node* fifo_start;
    Node* fifo_end;
} FIFO;

Node* new_node()

void push(FIFO* f)

void pop(FIFO* f)

FIFO new_fifo()

#endif
