.section .data
input: .byte '1','2','3','4','5'

.section .text
.globl _start

_start:
    la   $a0, input           # a0 = p
    li   $a2, 5               # a1是长度
    addi $t0, $a2, -1         #t0 = length-1
    add  $t1, $a0, $t0        #t1= a+length-1=q     


reverse_loop:
    # 如果 $a0 >= $t1, 跳出
    bge $a0, $t1, write_out
    lb $t4, ($a0)           #temp
    lb $t5, ($t1)
    sb $t4, ($t1)
    sb $t5, ($a0)
    addi $a0,$a0, 1
    addi $t1,$t1,-1

write_out:
    la   $a1, input      # $a1 = input
    li   $a2, 5
    li   $v0, 4004       # SYS_write
    li   $a0, 1          # stdout
    syscall

    # 退出
    li   $v0, 4001         # SYS_exit
    li   $a0, 0
    syscall

