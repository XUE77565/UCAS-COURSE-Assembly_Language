.section .data
testdata:
    .byte '6', '0', '8', '1', '7', '3', '4', '2', '5', '9'
.section .text

.globl _start

_start:
    movl $9, %eax             #利用eax来存储输入数据的长度, eax=right
    movl $0,   %ecx             #ecx=left
    call quick_sort
#output
    call as_puts
#exit
    call as_exit


quick_sort:
    cmpl %eax, %ecx
    jge  .end_sort              #如果left>=right 则结束当前排序
    movl $testdata, %esi        #讲字符串的地址存入esi
    push %ecx
    push %eax
    addl %ecx, %eax             #eax=eax+ecx
    sarl %eax
    movb (%esi,%eax,1), %bl     #这时候bl存储的是中间的元素
    movb (%esi,%ecx,1), %bh
    movb %bh, (%esi,%eax,1)
    movb %bl, (%esi,%ecx,1)     #swap(left, left+right/2)
    movl %ecx, %edx             #edx=last
    movl %ecx, %edi             #edx=last
    addl $1, %ecx               #i=left+1
    pop %eax
.loop_swap:
    cmpl %eax, %ecx
    jg  .end_loop
    movb (%esi,%edi,1),%bl      #v[left]
    cmpb %bl, (%esi,%ecx,1)     #if(v[i]<=v[left])
    jg  .no_swap
    incl %edx                   #edx++
    movb (%esi,%edx,1),%bl      #v[last]
    movb (%esi,%ecx,1),%bh      #v[i]
    movb %bl, (%esi,%ecx,1)     
    movb %bh, (%esi,%edx,1)     #swap(++last, i)
.no_swap:
    incl %ecx
    jmp .loop_swap
.end_loop:
    pop %ecx
    movb (%esi,%ecx,1),%bl      
    movb (%esi,%edx,1),%bh      
    movb %bl, (%esi,%edx,1)     
    movb %bh, (%esi,%ecx,1)     #swap(last, left)
    push %eax
    push %ecx
    decl %edx
    movl %edx, %eax             #sort(left,last-1)
    call quick_sort
    pop %ecx
    pop %eax
    addl $2,%edx
    movl %edx, %ecx 
    call quick_sort             #sort(last+1,right)
.end_sort:
    ret



as_puts:
    movl $4, %eax             # sys_write 系统调用号
    movl $1, %ebx             # 文件描述符 (stdout)
    movl $testdata, %ecx      # 字符串地址
    movl $10, %edx            # 字符串长度
    int $0x80                 # 调用内核
    ret

as_exit:
    movl $1, %eax             # sys_exit 系统调用号
    xorl %esi, %esi           # 退出状态码 0
    int $0x80                 # 调用内核