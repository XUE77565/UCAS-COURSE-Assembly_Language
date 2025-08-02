.text
.globl findfirst1
.type findfirst1,@function
    
findfirst1:
    movl 4(%esp), %ecx      #x
    xor %eax, %eax          #store the position
    test %ecx, %ecx         #ecx = 0
    jz .no1
.loop:
    test $1, %ecx
    jnz .find
    shr $1, %ecx
    inc %eax                #eax++
    jmp .loop

.find:
    ret

.no1:
    movl $-1, %eax
    ret