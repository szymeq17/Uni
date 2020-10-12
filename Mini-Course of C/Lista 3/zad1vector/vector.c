#include <stdio.h>
#include <stdlib.h>

typedef struct vector {
    size_t size;
    size_t capacity;
    size_t element_size;
    void* data;
    } vector;

void vector_init(vector* v, size_t capacity, size_t element_size)
{
    (*v).data = malloc(capacity * element_size);
    (*v).size = 0;
    (*v).capacity = capacity;
    (*v).element_size = element_size;
}

void vector_copy(vector* destination, vector* source)
{
    while(source->data)
    {
        destination->data = source->data;
        source->data++;
    }
}
void vector_assign(vector *v, int i, void* elem)
{
    if(i > v->size)
        return;
//    v->data[i] = elem;
}
void* vector_at(vector *v, int i)
{
    if(i > v->size)
        return;
    return &v->data[i];
}


int main()
{
    vector* vec;
    vector_init(vec, 5, 4);
    vec->data = 1;
    printf ("%d",  *((*vec).data) );
    return 0;
}
