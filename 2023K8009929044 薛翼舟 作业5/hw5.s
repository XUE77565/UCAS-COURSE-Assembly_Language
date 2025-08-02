.section .data
iostring:
    .asciz "ab1g2hA0H56po9wK78nB"

.section .text
.globl _start
_start:
    movl $iostring, %eax
.loop1:
    cmpb $0, (%eax)
    je .endloop1
    cmpb $0x61, (%eax)
    jl .endchange
    cmpb $0x7A, (%eax)
    jg .endchange
    subb $0x20, (%eax)
.endchange:
    addl $1, %eax
    jmp .loop1
.endloop1:

    # output
    movl $4, %eax      
    movl $1, %ebx       
    movl $iostring, %ecx 
    movl $20, %edx      
    int $0x80
              
    # exit
    movl $1, %eax       
    movl $0, %ebx     
    int $0x80           