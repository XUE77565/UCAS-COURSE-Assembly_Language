.section .data
output:
    .asciz "The sum of odd numbers between 1~100 is : %d\n"

.section .text

.globl _start
_start:
    movl $100,%ecx
    movl $0,%eax    #initialize sum = 0

loop1:
    subl $1, %ecx
    addl %ecx,%eax  #sum = 99+97+95+...+1
    loop loop1

    pushl %eax
    pushl $output
    call printf
    add $8, %esp

    movl $1,%eax
    movl $0, %ebx
    int $0x80