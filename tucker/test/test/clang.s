	.file	"test.c"
	.text
	.globl	m128d_mdot
	.align	16, 0x90
	.type	m128d_mdot,@function
m128d_mdot:                             # @m128d_mdot
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp4:
	.cfi_def_cfa_offset 16
	pushq	%r14
.Ltmp5:
	.cfi_def_cfa_offset 24
	pushq	%rbx
.Ltmp6:
	.cfi_def_cfa_offset 32
.Ltmp7:
	.cfi_offset %rbx, -32
.Ltmp8:
	.cfi_offset %r14, -24
.Ltmp9:
	.cfi_offset %rbp, -16
	vxorps	%xmm0, %xmm0, %xmm0
	testl	%edx, %edx
	jle	.LBB0_3
# BB#1:                                 # %.lr.ph.preheader
	leal	(%rcx,%rcx,2), %r8d
	leal	(%rcx,%rcx), %r9d
	vxorps	%xmm0, %xmm0, %xmm0
	leal	(,%rcx,4), %r10d
	xorl	%r11d, %r11d
	xorl	%eax, %eax
	.align	16, 0x90
.LBB0_2:                                # %.lr.ph
                                        # =>This Inner Loop Header: Depth=1
	leal	(%r8,%rax), %ebx
	leal	(%rcx,%rax), %r14d
	movslq	%ebx, %rbx
	leal	(%r9,%rax), %ebp
	movslq	%ebp, %rbp
	vmovsd	(%rsi,%rbp,8), %xmm1
	vmovhpd	(%rsi,%rbx,8), %xmm1, %xmm1
	movslq	%r14d, %rbx
	movslq	%eax, %rax
	vmovsd	(%rsi,%rax,8), %xmm2
	vmovhpd	(%rsi,%rbx,8), %xmm2, %xmm2
	vinsertf128	$1, %xmm1, %ymm2, %ymm1
	addl	%r10d, %eax
	vmulpd	(%rdi,%r11,8), %ymm1, %ymm1
	addq	$4, %r11
	vextractf128	$1, %ymm1, %xmm2
	vunpckhpd	%xmm1, %xmm1, %xmm3 # xmm3 = xmm1[1,1]
	cmpl	%edx, %r11d
	vaddsd	%xmm3, %xmm1, %xmm1
	vaddsd	%xmm1, %xmm2, %xmm1
	vunpckhpd	%xmm2, %xmm2, %xmm2 # xmm2 = xmm2[1,1]
	vaddsd	%xmm1, %xmm2, %xmm1
	vaddsd	%xmm1, %xmm0, %xmm0
	jl	.LBB0_2
.LBB0_3:                                # %._crit_edge
	popq	%rbx
	popq	%r14
	popq	%rbp
	vzeroupper
	ret
.Ltmp10:
	.size	m128d_mdot, .Ltmp10-m128d_mdot
	.cfi_endproc


	.section	".note.GNU-stack","",@progbits
