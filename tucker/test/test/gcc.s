	.file	"test.c"
	.text
	.p2align 4,,15
	.globl	dot_f
	.type	dot_f, @function
dot_f:
.LFB846:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	vxorps	%xmm0, %xmm0, %xmm0
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	andq	$-32, %rsp
	addq	$32, %rsp
	testl	%edx, %edx
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	jle	.L30
	movq	%rdi, %rax
	andl	$31, %eax
	shrq	$2, %rax
	negq	%rax
	andl	$7, %eax
	cmpl	%edx, %eax
	cmova	%edx, %eax
	cmpl	$9, %edx
	movl	%eax, %ecx
	movl	%edx, %eax
	ja	.L33
.L3:
	vmovss	(%rdi), %xmm0
	cmpl	$1, %eax
	vaddss	(%rsi), %xmm0, %xmm0
	jbe	.L17
	vmovss	4(%rdi), %xmm1
	cmpl	$2, %eax
	vaddss	4(%rsi), %xmm1, %xmm1
	vaddss	%xmm1, %xmm0, %xmm0
	jbe	.L18
	vmovss	8(%rdi), %xmm1
	cmpl	$3, %eax
	vaddss	8(%rsi), %xmm1, %xmm1
	vaddss	%xmm1, %xmm0, %xmm0
	jbe	.L19
	vmovss	12(%rdi), %xmm1
	cmpl	$4, %eax
	vaddss	12(%rsi), %xmm1, %xmm1
	vaddss	%xmm1, %xmm0, %xmm0
	jbe	.L20
	vmovss	16(%rdi), %xmm1
	cmpl	$5, %eax
	vaddss	16(%rsi), %xmm1, %xmm1
	vaddss	%xmm1, %xmm0, %xmm0
	jbe	.L21
	vmovss	20(%rdi), %xmm1
	cmpl	$6, %eax
	vaddss	20(%rsi), %xmm1, %xmm1
	vaddss	%xmm1, %xmm0, %xmm0
	jbe	.L22
	vmovss	24(%rdi), %xmm1
	cmpl	$7, %eax
	vaddss	24(%rsi), %xmm1, %xmm1
	vaddss	%xmm1, %xmm0, %xmm0
	jbe	.L23
	vmovss	28(%rdi), %xmm1
	cmpl	$8, %eax
	vaddss	28(%rsi), %xmm1, %xmm1
	vaddss	%xmm1, %xmm0, %xmm0
	jbe	.L24
	vmovss	32(%rsi), %xmm1
	movl	$9, %ecx
	vaddss	32(%rdi), %xmm1, %xmm1
	vaddss	%xmm1, %xmm0, %xmm0
.L5:
	cmpl	%eax, %edx
	je	.L30
.L4:
	movl	%edx, %r11d
	movl	%eax, %ebx
	subl	%eax, %r11d
	movl	%r11d, %r10d
	shrl	$3, %r10d
	leal	0(,%r10,8), %r9d
	testl	%r9d, %r9d
	je	.L7
	vxorps	%xmm1, %xmm1, %xmm1
	salq	$2, %rbx
	leaq	(%rdi,%rbx), %r12
	xorl	%eax, %eax
	addq	%rsi, %rbx
	xorl	%r8d, %r8d
.L13:
	vmovups	(%rbx,%rax), %xmm2
	addl	$1, %r8d
	vinsertf128	$0x1, 16(%rbx,%rax), %ymm2, %ymm2
	vaddps	(%r12,%rax), %ymm2, %ymm2
	addq	$32, %rax
	cmpl	%r8d, %r10d
	vaddps	%ymm2, %ymm1, %ymm1
	ja	.L13
	vhaddps	%ymm1, %ymm1, %ymm1
	addl	%r9d, %ecx
	cmpl	%r9d, %r11d
	vhaddps	%ymm1, %ymm1, %ymm2
	vperm2f128	$1, %ymm2, %ymm2, %ymm1
	vaddps	%ymm2, %ymm1, %ymm1
	vaddss	%xmm1, %xmm0, %xmm0
	je	.L29
	vzeroupper
.L7:
	movslq	%ecx, %rax
	vmovss	(%rdi,%rax,4), %xmm1
	vaddss	(%rsi,%rax,4), %xmm1, %xmm1
	leal	1(%rcx), %eax
	cmpl	%eax, %edx
	vaddss	%xmm1, %xmm0, %xmm0
	jle	.L30
	cltq
	vmovss	(%rdi,%rax,4), %xmm1
	vaddss	(%rsi,%rax,4), %xmm1, %xmm1
	leal	2(%rcx), %eax
	cmpl	%eax, %edx
	vaddss	%xmm1, %xmm0, %xmm0
	jle	.L30
	cltq
	vmovss	(%rdi,%rax,4), %xmm1
	vaddss	(%rsi,%rax,4), %xmm1, %xmm1
	leal	3(%rcx), %eax
	cmpl	%eax, %edx
	vaddss	%xmm1, %xmm0, %xmm0
	jle	.L30
	cltq
	vmovss	(%rdi,%rax,4), %xmm1
	vaddss	(%rsi,%rax,4), %xmm1, %xmm1
	leal	4(%rcx), %eax
	cmpl	%eax, %edx
	vaddss	%xmm1, %xmm0, %xmm0
	jle	.L30
	cltq
	vmovss	(%rdi,%rax,4), %xmm1
	vaddss	(%rsi,%rax,4), %xmm1, %xmm1
	leal	5(%rcx), %eax
	cmpl	%eax, %edx
	vaddss	%xmm1, %xmm0, %xmm0
	jle	.L30
	cltq
	addl	$6, %ecx
	vmovss	(%rdi,%rax,4), %xmm1
	cmpl	%ecx, %edx
	vaddss	(%rsi,%rax,4), %xmm1, %xmm1
	vaddss	%xmm1, %xmm0, %xmm0
	jle	.L30
	movslq	%ecx, %rcx
	vmovss	(%rdi,%rcx,4), %xmm1
	vaddss	(%rsi,%rcx,4), %xmm1, %xmm1
	vaddss	%xmm1, %xmm0, %xmm0
.L30:
	leaq	-16(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L33:
	.cfi_restore_state
	testl	%ecx, %ecx
	jne	.L34
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	vxorps	%xmm0, %xmm0, %xmm0
	jmp	.L4
	.p2align 4,,10
	.p2align 3
.L29:
	vzeroupper
	leaq	-16(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L20:
	.cfi_restore_state
	movl	$4, %ecx
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L21:
	movl	$5, %ecx
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L22:
	movl	$6, %ecx
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L23:
	movl	$7, %ecx
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L18:
	movl	$2, %ecx
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L19:
	movl	$3, %ecx
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L17:
	movl	$1, %ecx
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L24:
	movl	$8, %ecx
	jmp	.L5
.L34:
	movl	%ecx, %eax
	jmp	.L3
	.cfi_endproc
.LFE846:
	.size	dot_f, .-dot_f
	.p2align 4,,15
	.globl	dot_d
	.type	dot_d, @function
dot_d:
.LFB847:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	andq	$-32, %rsp
	addq	$32, %rsp
	testl	%edx, %edx
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	jle	.L59
	movq	%rdi, %rax
	andl	$31, %eax
	shrq	$3, %rax
	negq	%rax
	andl	$3, %eax
	cmpl	%edx, %eax
	cmova	%edx, %eax
	cmpl	$5, %edx
	movl	%eax, %ecx
	movl	%edx, %eax
	ja	.L61
.L37:
	vmovsd	(%rdi), %xmm0
	cmpl	$1, %eax
	vaddsd	(%rsi), %xmm0, %xmm0
	jbe	.L50
	vmovsd	8(%rdi), %xmm1
	cmpl	$2, %eax
	vaddsd	8(%rsi), %xmm1, %xmm1
	vaddsd	%xmm1, %xmm0, %xmm0
	jbe	.L51
	vmovsd	16(%rdi), %xmm1
	cmpl	$3, %eax
	vaddsd	16(%rsi), %xmm1, %xmm1
	vaddsd	%xmm1, %xmm0, %xmm0
	jbe	.L52
	vmovsd	24(%rdi), %xmm1
	cmpl	$4, %eax
	vaddsd	24(%rsi), %xmm1, %xmm1
	vaddsd	%xmm1, %xmm0, %xmm0
	jbe	.L53
	vmovsd	32(%rsi), %xmm1
	movl	$5, %ecx
	vaddsd	32(%rdi), %xmm1, %xmm1
	vaddsd	%xmm1, %xmm0, %xmm0
.L39:
	cmpl	%eax, %edx
	je	.L59
.L38:
	movl	%edx, %ebx
	movl	%eax, %r9d
	subl	%eax, %ebx
	movl	%ebx, %r10d
	shrl	$2, %r10d
	leal	0(,%r10,4), %r11d
	testl	%r11d, %r11d
	je	.L41
	vxorpd	%xmm1, %xmm1, %xmm1
	salq	$3, %r9
	leaq	(%rdi,%r9), %r12
	xorl	%eax, %eax
	addq	%rsi, %r9
	xorl	%r8d, %r8d
.L47:
	vmovupd	(%r9,%rax), %xmm2
	addl	$1, %r8d
	vinsertf128	$0x1, 16(%r9,%rax), %ymm2, %ymm2
	vaddpd	(%r12,%rax), %ymm2, %ymm2
	addq	$32, %rax
	cmpl	%r8d, %r10d
	vaddpd	%ymm2, %ymm1, %ymm1
	ja	.L47
	vhaddpd	%ymm1, %ymm1, %ymm1
	addl	%r11d, %ecx
	cmpl	%r11d, %ebx
	vperm2f128	$1, %ymm1, %ymm1, %ymm2
	vaddpd	%ymm2, %ymm1, %ymm1
	vaddsd	%xmm1, %xmm0, %xmm0
	je	.L58
	vzeroupper
.L41:
	movslq	%ecx, %rax
	vmovsd	(%rdi,%rax,8), %xmm1
	vaddsd	(%rsi,%rax,8), %xmm1, %xmm1
	leal	1(%rcx), %eax
	cmpl	%eax, %edx
	vaddsd	%xmm1, %xmm0, %xmm0
	jle	.L59
	cltq
	addl	$2, %ecx
	vmovsd	(%rdi,%rax,8), %xmm1
	cmpl	%ecx, %edx
	vaddsd	(%rsi,%rax,8), %xmm1, %xmm1
	vaddsd	%xmm1, %xmm0, %xmm0
	jle	.L59
	movslq	%ecx, %rcx
	vmovsd	(%rdi,%rcx,8), %xmm1
	vaddsd	(%rsi,%rcx,8), %xmm1, %xmm1
	vaddsd	%xmm1, %xmm0, %xmm0
.L59:
	leaq	-16(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L61:
	.cfi_restore_state
	testl	%ecx, %ecx
	jne	.L62
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	jmp	.L38
	.p2align 4,,10
	.p2align 3
.L53:
	movl	$4, %ecx
	jmp	.L39
	.p2align 4,,10
	.p2align 3
.L50:
	movl	$1, %ecx
	jmp	.L39
	.p2align 4,,10
	.p2align 3
.L51:
	movl	$2, %ecx
	jmp	.L39
	.p2align 4,,10
	.p2align 3
.L52:
	movl	$3, %ecx
	jmp	.L39
	.p2align 4,,10
	.p2align 3
.L58:
	vzeroupper
	leaq	-16(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L62:
	.cfi_restore_state
	movl	%ecx, %eax
	jmp	.L37
	.cfi_endproc
.LFE847:
	.size	dot_d, .-dot_d
	.p2align 4,,15
	.globl	x2_m128d
	.type	x2_m128d, @function
x2_m128d:
.LFB848:
	.cfi_startproc
	vmovsd	.LC2(%rip), %xmm1
	vmovsd	%xmm1, -24(%rsp)
	vmovsd	%xmm1, -16(%rsp)
	vmovapd	-24(%rsp), %xmm3
	vmulpd	(%rdi), %xmm3, %xmm0
	ret
	.cfi_endproc
.LFE848:
	.size	x2_m128d, .-x2_m128d
	.p2align 4,,15
	.globl	x2_m256d
	.type	x2_m256d, @function
x2_m256d:
.LFB849:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	andq	$-32, %rsp
	addq	$16, %rsp
	vmovapd	(%rdi), %ymm0
	vmulpd	.LC3(%rip), %ymm0, %ymm0
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE849:
	.size	x2_m256d, .-x2_m256d
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC2:
	.long	0
	.long	1073741824
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC3:
	.long	0
	.long	1073741824
	.long	0
	.long	1073741824
	.long	0
	.long	1073741824
	.long	0
	.long	1073741824
	.ident	"GCC: (GNU) 4.8.1"
	.section	.note.GNU-stack,"",@progbits
