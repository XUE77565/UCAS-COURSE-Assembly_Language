#include<stdio.h>

int main(){
    unsigned int x = 0x00000004;
    printf("x=00000000 00000000 00000000 00000100\n");
    extern int findfirst1(unsigned int);
    int n=findfirst1(x);
    printf("the first 1 is at (%d)\n",n);
    return 0;
}