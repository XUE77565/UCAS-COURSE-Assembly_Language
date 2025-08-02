.section .data
testdata:
    .byte 'A', '0', 'z', 'P', '8', 'r', 'Z', '2', 'f', 'H'
.section .text

.globl _start

_start:
    call insert_sort
#output
    call as_puts
#exit
    call as_exit


insert_sort:
    movl $testdata, %ebx        #字符串输入eax
    movl $1, %ecx               #i

.outloop:
    cmpl $10, %ecx
    jge .end_outloop
    movb (%ebx,%ecx,1), %al     #temp = a[i]
    movl %ecx, %edx
    decl %edx                   #j = i-1
    
    
    .innerloop:
        cmpl $0, %edx
        jl .end_innerloop
        cmpb %al, (%ebx,%edx,1)     #temp >= a[j]
        jle .end_innerloop
        movb (%ebx,%edx,1), %ah
        movb %ah, 1(%ebx,%edx,1)     #a[j+1] = a[j]
        decl %edx
        jmp .innerloop
    .end_innerloop:

    movb %al, 1(%ebx,%edx,1)     #a[j+1] = temp
    incl %ecx                   #i++
    jmp .outloop
.end_outloop:
    ret

as_puts:
    movl $4, %eax             # sys_write 系统调用号
    movl $1, %ebx             # 文件描述符 (stdout)
    movl $testdata, %ecx      # 字符串地址
    movl $10, %edx              # 字符串长度
    int $0x80                 # 调用内核
    ret

as_exit:
    movl $1, %eax             # sys_exit 系统调用号
    xorl %ebx, %ebx           # 退出状态码 0
    int $0x80                 # 调用内核