#include <iostream>

int main() {
    int matrix[2][2] = {{0, 1}, {1, 1}};
    int result[2][2] = {{1, 0}, {0, 1}};
    int n;
    scanf("%d", &n);
    n--;
    for(int i=0; i<n; i++) {
        int temp[2][2] = {{0, 0}, {0, 0}};
        for(int k=0; k<2; k++) {
            for(int l=0; l<2; l++) {
                int sum = 0;
                for(int m=0; m<2; m++) {
                    sum += matrix[k][m]*result[m][l];
                }
                temp[k][l] = sum;
            }
        }
        
        for(int k=0; k<2; k++) {
            for(int l=0; l<2; l++) {
                result[k][l] = temp[k][l];
            }
        }
    }


    int fib = result[1][0] + result[1][1];

    printf("%d", fib);
    return 0;
}