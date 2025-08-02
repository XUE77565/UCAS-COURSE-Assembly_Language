	.file	"struct.c"
	.text
	.globl	process_struct
	.type	process_struct, @function
process_struct:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$100, 16(%rbp)				#修改传入的参数a
	movss	.LC0(%rip), %xmm0
	movss	%xmm0, 20(%rbp)				#修改传入的参数b
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	process_struct, .-process_struct
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp				#为结构体变量来分配空间
	# 初始化结构体赋值，逐个成员来初始化
	movl	$1, -64(%rbp)			#为成员a赋值
	movss	.LC1(%rip), %xmm0
	movss	%xmm0, -60(%rbp)		#为成员b赋值
	movsd	.LC2(%rip), %xmm0
	movsd	%xmm0, -56(%rbp)		#为成员c赋值，因为c为double类型，占8个字节
	movw	$4, -48(%rbp)			#为成员d赋值
	movq	$5, -40(%rbp)			#为成员e赋值
	movss	.LC3(%rip), %xmm0
	movss	%xmm0, -32(%rbp)		#为成员f赋值
	movl	$7, -28(%rbp)			#为成员e赋值
	movsd	.LC4(%rip), %xmm0		#为成员h赋值
	movsd	%xmm0, -24(%rbp)
	movb	$57, -16(%rbp)			#为成员i赋值，9的ASCII码是57
	movq	$10, -8(%rbp)			#为成员j赋值
	pushq	-8(%rbp)				#将结构体的各个参数压栈，
	pushq	-16(%rbp)				#8个字节8个字节来压栈
	pushq	-24(%rbp)
	pushq	-32(%rbp)
	pushq	-40(%rbp)
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	call	process_struct
	addq	$64, %rsp				#清理栈空间
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC0:
	.long	1078523331
	.align 4
.LC1:
	.long	1073741824
	.align 8
.LC2:
	.long	0
	.long	1074266112
	.align 4
.LC3:
	.long	1086324736
	.align 8
.LC4:
	.long	0
	.long	1075838976
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
