#include<stdio.h>


unsigned int shld5(unsigned int a, unsigned int b)
{

    unsigned int result;

    asm(
        "shll   %4, %1\n"
        "movl   %3, %%ecx\n"
        "subl   %4, %%ecx\n"
        "shrl   %%cl, %2\n"
        "orl    %2, %1\n"
        "movl   %1, %0\n"
        :"=r"(result)
        :"r"(a),"r"(b),"i"(32),"i"(5)
        :"ecx"
    );
    
    return result;

}

int main(){
    unsigned int a = 14;
    unsigned int b = 20;
    unsigned int result = shld5(a,b);
    unsigned int result1 = (a << 5) | ( b>>(32-5));
    printf("result1 = %d\nesult2 = %d\n",result,result1);
    return 0;
}

