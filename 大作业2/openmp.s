	.file	"openmp.c"
	.text
	.globl	matrixmultiply
	.def	matrixmultiply;	.scl	2;	.type	32;	.endef
	.seh_proc	matrixmultiply
matrixmultiply:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$64, %rsp
	.seh_stackalloc	64
	.seh_endprologue
	movl	%ecx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	movq	%r8, 32(%rbp)
	movq	%r9, 40(%rbp)
	movq	40(%rbp), %rax
	movq	%rax, -16(%rbp)
	movq	32(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	24(%rbp), %rax
	movq	%rax, -32(%rbp)
	movl	16(%rbp), %eax
	movl	%eax, -8(%rbp)
	leaq	-32(%rbp), %rax
	movl	$0, %r9d
	movl	$0, %r8d
	movq	%rax, %rdx
	leaq	matrixmultiply._omp_fn.0(%rip), %rax
	movq	%rax, %rcx
	call	GOMP_parallel
	nop
	addq	$64, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "OpenMP time: %.2f seconds\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$104, %rsp
	.seh_stackalloc	104
	leaq	96(%rsp), %rbp
	.seh_setframe	%rbp, 96
	.seh_endprologue
	call	__main
	movl	$32768, %ecx
	call	malloc
	movq	%rax, -24(%rbp)
	movl	$32768, %ecx
	call	malloc
	movq	%rax, -32(%rbp)
	movl	$32768, %ecx
	call	malloc
	movq	%rax, -40(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L3
.L6:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	leaq	(%rdx,%rax), %rbx
	movl	$16384, %ecx
	call	malloc
	movq	%rax, (%rbx)
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-32(%rbp), %rax
	leaq	(%rdx,%rax), %rbx
	movl	$16384, %ecx
	call	malloc
	movq	%rax, (%rbx)
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	leaq	(%rdx,%rax), %rbx
	movl	$16384, %ecx
	call	malloc
	movq	%rax, (%rbx)
	movl	$0, -8(%rbp)
	jmp	.L4
.L5:
	call	rand
	movl	%eax, %ecx
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	leaq	(%rax,%rdx), %r8
	movslq	%ecx, %rax
	imulq	$1717986919, %rax, %rax
	shrq	$32, %rax
	movl	%eax, %edx
	sarl	$2, %edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	subl	%eax, %ecx
	movl	%ecx, %edx
	movl	%edx, (%r8)
	call	rand
	movl	%eax, %ecx
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	leaq	(%rax,%rdx), %r8
	movslq	%ecx, %rax
	imulq	$1717986919, %rax, %rax
	shrq	$32, %rax
	movl	%eax, %edx
	sarl	$2, %edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	subl	%eax, %ecx
	movl	%ecx, %edx
	movl	%edx, (%r8)
	addl	$1, -8(%rbp)
.L4:
	cmpl	$4095, -8(%rbp)
	jle	.L5
	addl	$1, -4(%rbp)
.L3:
	cmpl	$4095, -4(%rbp)
	jle	.L6
	call	omp_get_wtime
	vmovq	%xmm0, %rax
	movq	%rax, -48(%rbp)
	movq	-40(%rbp), %rcx
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rcx, %r9
	movq	%rdx, %r8
	movq	%rax, %rdx
	movl	$4096, %ecx
	call	matrixmultiply
	call	omp_get_wtime
	vmovq	%xmm0, %rax
	movq	%rax, -56(%rbp)
	vmovsd	-56(%rbp), %xmm0
	vsubsd	-48(%rbp), %xmm0, %xmm0
	vmovapd	%xmm0, %xmm1
	vmovapd	%xmm1, %xmm0
	vmovq	%xmm1, %rax
	vmovapd	%xmm0, %xmm1
	movq	%rax, %rdx
	leaq	.LC0(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movl	$0, -12(%rbp)
	jmp	.L7
.L8:
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rcx
	call	free
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rcx
	call	free
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rcx
	call	free
	addl	$1, -12(%rbp)
.L7:
	cmpl	$4095, -12(%rbp)
	jle	.L8
	movq	-24(%rbp), %rax
	movq	%rax, %rcx
	call	free
	movq	-32(%rbp), %rax
	movq	%rax, %rcx
	call	free
	movq	-40(%rbp), %rax
	movq	%rax, %rcx
	call	free
	movl	$0, %eax
	addq	$104, %rsp
	popq	%rbx
	popq	%rbp
	ret
	.seh_endproc
	.def	matrixmultiply._omp_fn.0;	.scl	3;	.type	32;	.endef
	.seh_proc	matrixmultiply._omp_fn.0
matrixmultiply._omp_fn.0:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$80, %rsp
	.seh_stackalloc	80
	leaq	80(%rsp), %rbp
	.seh_setframe	%rbp, 80
	.seh_endprologue
	movq	%rcx, 32(%rbp)
	movq	32(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -24(%rbp)
	movq	32(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	32(%rbp), %rax
	movl	24(%rax), %eax
	movl	%eax, -44(%rbp)
	movl	-44(%rbp), %ebx
	call	omp_get_num_threads
	movl	%eax, %esi
	call	omp_get_thread_num
	movl	%eax, %r8d
	movl	%ebx, %eax
	cltd
	idivl	%esi
	movl	%eax, %ecx
	movl	%ebx, %eax
	cltd
	idivl	%esi
	movl	%edx, %eax
	cmpl	%eax, %r8d
	jl	.L11
.L18:
	movl	%r8d, %edx
	imull	%ecx, %edx
	addl	%edx, %eax
	leal	(%rax,%rcx), %edx
	cmpl	%edx, %eax
	jge	.L19
	movl	%eax, -4(%rbp)
.L14:
	movl	$0, -8(%rbp)
	nop
.L16:
	movl	-8(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jl	.L13
	addl	$1, -4(%rbp)
	cmpl	%edx, -4(%rbp)
	jl	.L14
	jmp	.L19
.L13:
	movl	$0, -12(%rbp)
	movl	$0, -16(%rbp)
	nop
.L17:
	movl	-16(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jl	.L15
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	movq	-24(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	movl	-8(%rbp), %ecx
	movslq	%ecx, %rcx
	salq	$2, %rcx
	addq	%rax, %rcx
	movl	-12(%rbp), %eax
	movl	%eax, (%rcx)
	addl	$1, -8(%rbp)
	jmp	.L16
.L15:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	movq	-40(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	movl	-16(%rbp), %ecx
	movslq	%ecx, %rcx
	salq	$2, %rcx
	addq	%rcx, %rax
	movl	(%rax), %ecx
	movl	-16(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %r8
	movq	-32(%rbp), %rax
	addq	%r8, %rax
	movq	(%rax), %rax
	movl	-8(%rbp), %r8d
	movslq	%r8d, %r8
	salq	$2, %r8
	addq	%r8, %rax
	movl	(%rax), %eax
	imull	%ecx, %eax
	addl	%eax, -12(%rbp)
	addl	$1, -16(%rbp)
	jmp	.L17
.L11:
	movl	$0, %eax
	addl	$1, %ecx
	jmp	.L18
.L19:
	nop
	addq	$80, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (Rev2, Built by MSYS2 project) 14.2.0"
	.def	GOMP_parallel;	.scl	2;	.type	32;	.endef
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	rand;	.scl	2;	.type	32;	.endef
	.def	omp_get_wtime;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
	.def	omp_get_num_threads;	.scl	2;	.type	32;	.endef
	.def	omp_get_thread_num;	.scl	2;	.type	32;	.endef
