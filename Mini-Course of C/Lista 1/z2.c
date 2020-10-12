#include <stdio.h>
#include <stdint.h>

int32_t cread(int *xp) {
    int32_t defaultVal = 0;
    int32_t *yp = &defaultVal;
    int32_t *res = (xp != NULL ? xp : yp);
    return *res;
}
int32_t cread2(int32_t *xp){
    return (xp ? *xp : 0);
}
int main()
{
    int x = 12;
    return cread(&x);
}
