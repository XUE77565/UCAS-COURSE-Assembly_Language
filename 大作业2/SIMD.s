	.file	"SIMD.c"
	.text
	.globl	matrixmultiply
	.def	matrixmultiply;	.scl	2;	.type	32;	.endef
	.seh_proc	matrixmultiply
matrixmultiply:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$96, %rsp
	.seh_stackalloc	96
	.seh_endprologue
	movl	%ecx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	movq	%r8, 32(%rbp)
	movq	%r9, 40(%rbp)
	movq	40(%rbp), %rax
	movq	%rax, -48(%rbp)
	movq	32(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	24(%rbp), %rax
	movq	%rax, -64(%rbp)
	movl	16(%rbp), %eax
	movl	%eax, -40(%rbp)
	leaq	-64(%rbp), %rax
	movl	$0, %r9d
	movl	$0, %r8d
	movq	%rax, %rdx
	leaq	matrixmultiply._omp_fn.0(%rip), %rax
	movq	%rax, %rcx
	call	GOMP_parallel
	nop
	addq	$96, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC1:
	.ascii "SIMD time: %.2f seconds\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$88, %rsp
	.seh_stackalloc	88
	leaq	80(%rsp), %rbp
	.seh_setframe	%rbp, 80
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
	movl	$4, %edx
	movl	$4096, %ecx
	call	calloc
	movq	%rax, (%rbx)
	movl	$0, -8(%rbp)
	jmp	.L4
.L5:
	call	rand
	movl	%eax, %edx
	movslq	%edx, %rax
	imulq	$1717986919, %rax, %rax
	shrq	$32, %rax
	movl	%eax, %ecx
	sarl	$2, %ecx
	movl	%edx, %eax
	sarl	$31, %eax
	subl	%eax, %ecx
	movl	%ecx, %eax
	sall	$2, %eax
	addl	%ecx, %eax
	addl	%eax, %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rdx, %rax
	vcvtsi2ssl	%ecx, %xmm0, %xmm0
	vmovss	%xmm0, (%rax)
	call	rand
	movl	%eax, %edx
	movslq	%edx, %rax
	imulq	$1717986919, %rax, %rax
	shrq	$32, %rax
	movl	%eax, %ecx
	sarl	$2, %ecx
	movl	%edx, %eax
	sarl	$31, %eax
	subl	%eax, %ecx
	movl	%ecx, %eax
	sall	$2, %eax
	addl	%ecx, %eax
	addl	%eax, %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	addq	%rdx, %rax
	vcvtsi2ssl	%ecx, %xmm0, %xmm0
	vmovss	%xmm0, (%rax)
	addl	$1, -8(%rbp)
.L4:
	cmpl	$4095, -8(%rbp)
	jle	.L5
	addl	$1, -4(%rbp)
.L3:
	cmpl	$4095, -4(%rbp)
	jle	.L6
	call	clock
	movl	%eax, -44(%rbp)
	movq	-40(%rbp), %rcx
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rcx, %r9
	movq	%rdx, %r8
	movq	%rax, %rdx
	movl	$4096, %ecx
	call	matrixmultiply
	call	clock
	movl	%eax, -48(%rbp)
	movl	-48(%rbp), %eax
	subl	-44(%rbp), %eax
	vcvtsi2sdl	%eax, %xmm0, %xmm0
	vmovsd	.LC0(%rip), %xmm1
	vdivsd	%xmm1, %xmm0, %xmm0
	vmovapd	%xmm0, %xmm1
	vmovapd	%xmm1, %xmm0
	vmovq	%xmm1, %rax
	vmovapd	%xmm0, %xmm1
	movq	%rax, %rdx
	leaq	.LC1(%rip), %rax
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
	addq	$88, %rsp
	popq	%rbx
	popq	%rbp
	ret
	.seh_endproc
	.def	matrixmultiply._omp_fn.0;	.scl	3;	.type	32;	.endef
	.seh_proc	matrixmultiply._omp_fn.0
matrixmultiply._omp_fn.0:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$392, %rsp
	.seh_stackalloc	392
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.seh_endprologue
	movq	%rcx, 304(%rbp)
	leaq	256(%rbp), %rax
	subq	$320, %rax
	addq	$31, %rax
	shrq	$5, %rax
	salq	$5, %rax
	movq	%rax, %rbx
	movq	304(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, 224(%rbp)
	movq	304(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, 216(%rbp)
	movq	304(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, 208(%rbp)
	movq	304(%rbp), %rax
	movl	24(%rax), %eax
	movl	%eax, 204(%rbp)
	movl	204(%rbp), %esi
	call	omp_get_num_threads
	movl	%eax, %edi
	call	omp_get_thread_num
	movl	%eax, %r8d
	movl	%esi, %eax
	cltd
	idivl	%edi
	movl	%eax, %ecx
	movl	%esi, %eax
	cltd
	idivl	%edi
	movl	%edx, %eax
	cmpl	%eax, %r8d
	jl	.L11
.L24:
	movl	%r8d, %edx
	imull	%ecx, %edx
	addl	%edx, %eax
	leal	(%rax,%rcx), %edx
	cmpl	%edx, %eax
	jge	.L25
	movl	%eax, 252(%rbp)
.L14:
	movl	$0, 248(%rbp)
	nop
.L18:
	movl	248(%rbp), %eax
	cmpl	204(%rbp), %eax
	jl	.L13
	addl	$1, 252(%rbp)
	cmpl	%edx, 252(%rbp)
	jl	.L14
	jmp	.L25
.L13:
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%ymm0, 192(%rbx)
	movl	$0, 244(%rbp)
	nop
.L23:
	cmpl	$4095, 244(%rbp)
	jle	.L16
	leaq	-96(%rbp), %rax
	movq	%rax, 192(%rbp)
	vmovups	192(%rbx), %ymm0
	vmovups	%ymm0, 96(%rbx)
	vmovups	96(%rbx), %ymm0
	movq	192(%rbp), %rax
	vmovups	%ymm0, (%rax)
	nop
	vxorps	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 240(%rbp)
	movl	$0, 236(%rbp)
	nop
.L19:
	cmpl	$7, 236(%rbp)
	jle	.L17
	movl	252(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	movq	224(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	movl	248(%rbp), %ecx
	movslq	%ecx, %rcx
	salq	$2, %rcx
	addq	%rcx, %rax
	vmovss	240(%rbp), %xmm0
	vmovss	%xmm0, (%rax)
	addl	$1, 248(%rbp)
	jmp	.L18
.L17:
	movl	236(%rbp), %eax
	cltq
	vmovss	-96(%rbp,%rax,4), %xmm0
	vmovss	240(%rbp), %xmm1
	vaddss	%xmm0, %xmm1, %xmm0
	vmovss	%xmm0, 240(%rbp)
	addl	$1, 236(%rbp)
	jmp	.L19
.L16:
	movl	252(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	movq	208(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	movl	244(%rbp), %ecx
	movslq	%ecx, %rcx
	salq	$2, %rcx
	addq	%rcx, %rax
	movq	%rax, 176(%rbp)
	movq	176(%rbp), %rax
	vmovups	(%rax), %ymm0
	vmovups	%ymm0, 160(%rbx)
	movl	244(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	movq	216(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	movl	248(%rbp), %ecx
	movslq	%ecx, %rcx
	salq	$2, %rcx
	addq	%rcx, %rax
	movq	%rax, 184(%rbp)
	movq	184(%rbp), %rax
	vmovups	(%rax), %ymm0
	vmovups	%ymm0, 128(%rbx)
	vmovups	160(%rbx), %ymm0
	vmovups	%ymm0, 64(%rbx)
	vmovups	128(%rbx), %ymm0
	vmovups	%ymm0, 32(%rbx)
	vmovups	192(%rbx), %ymm0
	vmovups	%ymm0, (%rbx)
	vmovups	32(%rbx), %ymm1
	vmovups	(%rbx), %ymm0
	vfmadd231ps	64(%rbx), %ymm1, %ymm0
	nop
	vmovups	%ymm0, 192(%rbx)
	addl	$8, 244(%rbp)
	jmp	.L23
.L11:
	movl	$0, %eax
	addl	$1, %ecx
	jmp	.L24
.L25:
	nop
	addq	$392, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC0:
	.long	0
	.long	1083129856
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (Rev2, Built by MSYS2 project) 14.2.0"
	.def	GOMP_parallel;	.scl	2;	.type	32;	.endef
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	calloc;	.scl	2;	.type	32;	.endef
	.def	rand;	.scl	2;	.type	32;	.endef
	.def	clock;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
	.def	omp_get_num_threads;	.scl	2;	.type	32;	.endef
	.def	omp_get_thread_num;	.scl	2;	.type	32;	.endef
