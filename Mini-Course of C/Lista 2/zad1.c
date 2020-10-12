#include <stdio.h>
#include <time.h>
#include <assert.h>
#define MODULUS 1000000007
// CZÊŒÆ 1
//###########################################
int FHelper(int n, int k)
{
    if(n==0)
    {
        if(k==0)
            return 1;
        else
            return 0;
    }
    if(k==0)
        return 1;

    int sum = 0;

    for(int i=0; i<=9; i++)
        if(k-i>=0)
            sum += FHelper(n-1, k-i);


    return sum;
}
//Funkcja FHelper rozwi¹zuje problem wiod¹cych zer i zaczyna pêtle od 0.
//Funkcja F korzysta z funkcji FHelper zaczynaj¹c pêtle od 1,
//dzieki czemu 0 mo¿e siê pojawiæ na ka¿dej pozycji w liczbie oprócz pierwszej
int F(int n, int k)
{
    if(n==0)
    {
        if(k==0)
            return 1;
        else
            return 0;
    }
    if (k==0)
        return 1;

    int sum = 0;

    for(int i=1; i<=9; i++)
        if(k-i >= 0)
            sum += FHelper(n-1, k-i);


    return sum;

}
//##########################################

//CZÊŒÆ 2
//##########################################
int memory[50][50];
//FMemHelper to analogicznie funkcja pomocnicza dla FMem
int FMemHelper(int n, int k)
{
    if(n==0)
    {
        if(k==0)
            return 1;
        else
            return 0;
    }
    if (k==0)
        return 1;

    int sum = 0;

    for(int i=0; i<=9; i++)
        if(k-i >= 0)
        {
            if(memory[n-1][k-i] != 0)
            {
                sum += memory[n-1][k-i];
                sum%=MODULUS;
            }
            else
            {
                memory[n-1][k-i] = FMemHelper(n-1, k-i);
                sum += memory[n-1][k-i];
                sum%=MODULUS;
            }
        }

    return sum;

}
int FMem(int n, int k)
{
    if(n==0)
    {
        if(k==0)
            return 1;
        else
            return 0;
    }
    if (k==0)
        return 1;

    int sum = 0;

    for(int i=1; i<=9; i++)
        if(k-i >= 0)
        {
            if(memory[n-1][k-i] != 0)
            {
                sum += memory[n-1][k-i];
                sum%=MODULUS;
            }
            else
            {
                memory[n-1][k-i] = FMemHelper(n-1, k-i);
                sum += memory[n-1][k-i];
                sum%=MODULUS;
            }
        }

    return sum;

}
//##########################################

//CZÊŒÆ 3
//##########################################
//Funkcja pomocnicza do FGen
void FGenHelper(int n, int k, int i, int wyniki[])
{
    if(i<n && k>=0)
    {
        int num = 0;
        if(i==0)
            num=1; //wykluczamy przypadek, gdy 0 jest wiod¹ce
        for(num; num<=9; num++)
        {
            wyniki[i] = num;
            FGenHelper(n, k-num, i+1, wyniki);
        }
    }
    else if(i==n && k==0)
    {
        for(int j=0; j<n; j++)
        {
            printf("%d", wyniki[j]);
        }
        printf("\n");
        return;
    }
}
void FGen(int n, int k)
{
    if(k==0 && n==1)
    {
        printf("1\n");
        return;
    }

    int wyniki[n];
    FGenHelper(n, k, 0, wyniki);
    return;
}
//##########################################
int main()
{
    //Testy przy u¿yciu asercji
    assert(F(10, 1)==1 && FMem(10, 1)==1);
    assert(F(3, 2)==3 && FMem(3, 2)==3);
    assert(F(0, 0)==1 && FMem(0, 0)==1);

    //Mierzenie czasu funkcji FMem i F dla tych samych argumentów
    clock_t start, end;
    double f_time, fmem_time;
    start = clock();
    printf("FMem(20, 10) = %d\n", FMem(20, 10));
    end = clock();
    fmem_time = ((float) (end - start))/CLOCKS_PER_SEC;
    printf("Czas dzialania funkcji FMem: %fs\n", fmem_time);
    start = clock();
    printf("F(20, 10) = %d\n", F(20, 10));
    end = clock();
    f_time = ((float) (end - start))/CLOCKS_PER_SEC;
    printf("Czas dzialania funkcji F: %fs\n", f_time);
    //Testowanie funkcji FGen
    printf("FGen(3, 1):\n");
    FGen(3, 1);
    printf("FGen(3, 2):\n");
    FGen(3, 2);
    printf("FGen(1, 0):\n");
    FGen(1, 0);
    return 0;


}
