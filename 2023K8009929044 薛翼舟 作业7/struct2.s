	.file	"struct2.c"
	.text
	.globl	create_struct
	.type	create_struct, @function
create_struct:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	.cfi_offset 3, -24
	movq	%rdi, -80(%rbp)
	movl	$100, -72(%rbp)
	movss	.LC0(%rip), %xmm0
	movss	%xmm0, -68(%rbp)
	movsd	.LC1(%rip), %xmm0
	movsd	%xmm0, -64(%rbp)
	movw	$4, -56(%rbp)
	movq	$5, -48(%rbp)
	movss	.LC2(%rip), %xmm0
	movss	%xmm0, -40(%rbp)
	movl	$7, -36(%rbp)
	movsd	.LC3(%rip), %xmm0
	movsd	%xmm0, -32(%rbp)
	movb	$88, -24(%rbp)
	movq	$1000, -16(%rbp)
	movq	-80(%rbp), %rax
	movq	-72(%rbp), %rcx
	movq	-64(%rbp), %rbx
	movq	%rcx, (%rax)
	movq	%rbx, 8(%rax)
	movq	-56(%rbp), %rcx
	movq	-48(%rbp), %rbx
	movq	%rcx, 16(%rax)
	movq	%rbx, 24(%rax)
	movq	-40(%rbp), %rcx
	movq	-32(%rbp), %rbx
	movq	%rcx, 32(%rax)
	movq	%rbx, 40(%rax)
	movq	-24(%rbp), %rcx
	movq	-16(%rbp), %rbx
	movq	%rcx, 48(%rax)
	movq	%rbx, 56(%rax)
	movq	-80(%rbp), %rax
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	create_struct, .-create_struct
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
	subq	$80, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-80(%rbp), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	create_struct
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	xorq	%fs:40, %rdx
	je	.L5
	call	__stack_chk_fail@PLT
.L5:
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
	.align 8
.LC1:
	.long	3367254360
	.long	1074118262
	.align 4
.LC2:
	.long	1086911939
	.align 8
.LC3:
	.long	1992864825
	.long	1073127358
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
