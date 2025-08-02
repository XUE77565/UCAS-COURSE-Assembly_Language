.section .data
    # var: .int 0x7312abcd
    var: .int 0x00123abc
    # var: .int 0x80001234
.section .text
.globl  _start
_start:
    pushl var
    call  print_hex
    mov   $1, %eax
    mov   $1, %ebx
    int   $0x80

.type print_hex, @function
print_hex:
    pushl %ebp
    movl  %esp, %ebp
    subl  $16, %esp
    movl  %ebx, 12(%esp)
    movl  8(%ebp),%ecx
    movb  $0, 10(%esp)
    leal  9(%esp),%eax
# 判断x的正负
    cmpl  $0,%ecx
    jge positive
    negl  %ecx
    jmp negative

# 处理正数的情况
positive:
    movl  $2,%ebx
positive_L1:
    mov   %ecx, %edx
    andb  $0xf, %dl
    cmpb  $10, %dl
    jb    positive_L2
    addb  $0x57, %dl
    jmp   positive_L3
positive_L2:
    orb   $0x30, %dl
positive_L3:
    movb  %dl, (%eax)
    incl  %ebx
    dec   %eax
    shrl  $4, %ecx
    testl %ecx,%ecx          #检查ecx是否只剩下0
    jne   positive_L1
    movb  $'x', (%eax)
    decl   %eax
    movb  $'0', (%eax)
    jmp end

negative:
    movl $3,%ebx
negative_L1:
    mov   %ecx, %edx
    andb  $0xf, %dl
    cmpb  $10, %dl
    jb    negative_L2
    addb  $0x57, %dl
    jmp   negative_L3
negative_L2:
    orb   $0x30, %dl
negative_L3:
    movb  %dl, (%eax)
    incl  %ebx
    dec   %eax
    shrl  $4, %ecx
    testl %ecx,%ecx          #检查ecx是否只剩下0
    jne   negative_L1
    movb  $'x', (%eax)
    decl  %eax
    movb  $'0', (%eax)
    decl  %eax
    movb  $'-', (%eax)
    jmp end
    
end:
    movl  %ebx,%edx
    movl  %eax,%ecx
    movl  $4, %eax
    movl  $1, %ebx
    #movl  %esp, %ecx
    int   $0x80
    movl 12(%esp), %ebx 
    leave
    ret

