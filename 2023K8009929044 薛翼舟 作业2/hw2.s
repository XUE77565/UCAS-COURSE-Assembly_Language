.section .data

stringvar:

.ascii "0123456789abcdef"

.section .text

.globl _start

_start:

movl $stringvar, %ebx   # store stringvar's address in ebx

movb $0x31, (%ebx)        # 1
movb $0x30, 1(%ebx)       # 0
movb $0x33, 2(%ebx)       # 3
movb $0x32, 3(%ebx)       # 2
movb $0x35, 4(%ebx)       # 5
movb $0x34, 5(%ebx)       # 4
movb $0x37, 6(%ebx)       # 7
movb $0x36, 7(%ebx)       # 6
movb $0x39, 8(%ebx)       # 9
movb $0x38, 9(%ebx)       # 8
movb $0x62, 10(%ebx)      # b
movb $0x61, 11(%ebx)      # a
movb $0x64, 12(%ebx)      # d
movb $0x63, 13(%ebx)      # c   
movb $0x66, 14(%ebx)      # f
movb $0x65, 15(%ebx)      # e

#output

movl $4, %eax
movl $1, %ebx
movl $stringvar, %ecx
movl $16, %edx
int $0x80

#exit

movl $1, %eax
movl $0, %ebx
int $0x80