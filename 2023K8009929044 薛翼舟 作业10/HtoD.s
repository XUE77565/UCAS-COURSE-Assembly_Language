.section .data
result: .space 12      # 存储10位数字、结尾符

.section .text
.globl _start

_start:
    li   $a0, 0x9812abcd      # 以a0作为输入
    la   $t0, result          # t0寄存器是result的首地址
    li   $t1, 10              # 除数
    li   $t2, 0               # 偏移，代表当前result要写入的位数
    beq  $a0, $zero, output_zero   # 输入为0，特判

convert_loop:
    divu $a0, $t1
    mfhi $t3                # hi中是余数，lo中是余数
    mflo $a0                
    addi $t3, $t3, 48       # $t3 = '0' + 余数，将整形转为char类型
    add  $t4, $t0, $t2
    sb   $t3, 0($t4)        #因为t4实际上是内存所指的地址，所以要寻址
    addi $t2, $t2, 1
    bnez $a0, convert_loop  #如果不是商不是0，则继续这个循环

    # 写入终止符
    add  $t4, $t0, $t2
    sb   $zero, 0($t4)

    # 逆序输出到
    la   $a1, result        # $a1 = result
    add  $t5, $t2, $zero    # $t5 = 字符个数
    sub  $t6, $t2, 1        # $t6 = $t2-1, 指向最后一位的数字所在的地址

#将结果翻转
reverse_loop:
    bltz $t6, write_out
    add  $t7, $t0, $t6      # t7表示的是当前result中最后的一位数字的地址
    lb   $t8, 0($t7)        # 将这一位数字提取出来，存到a1上
    sb   $t8, 0($a1)
    addi $a1, $a1, 1
    addi $t6, $t6, -1
    j    reverse_loop

write_out:
    la   $a1, result       # $a1 = result
    move $a2, $t5          # $a2 = 长度

    li   $v0, 4004         # SYS_write
    li   $a0, 1            # stdout
    syscall

    # 退出
    li   $v0, 4001         # SYS_exit
    li   $a0, 0
    syscall

output_zero:
    la   $a1, result
    li   $t3, 48           # '0'
    sb   $t3, 0($a1)
    sb   $zero, 1($a1)     # 终止符（可选）
    li   $a2, 1            # 长度1
    li   $v0, 4004
    li   $a0, 1
    syscall

    li   $v0, 4001
    li   $a0, 0
    syscall