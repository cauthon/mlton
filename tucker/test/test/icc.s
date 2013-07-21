# mark_description "Intel(R) C Intel(R) 64 Compiler XE for applications running on Intel(R) 64, Version 13.1.2.183 Build 2013051";
# mark_description "4";
# mark_description "-S -mavx -Ofast -o icc.s -std=gnu99";
	.file "test.c"
	.text
..TXTST0:
# -- Begin  dot_f
# mark_begin;
       .align    16,0x90
	.globl dot_f
dot_f:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %edx
..B1.1:                         # Preds ..B1.0
..___tag_value_dot_f.1:                                         #48.40
        vxorps    %xmm0, %xmm0, %xmm0                           #49.13
        testl     %edx, %edx                                    #50.17
        jle       ..B1.18       # Prob 50%                      #50.17
                                # LOE rbx rbp rsi rdi r12 r13 r14 r15 edx xmm0
..B1.2:                         # Preds ..B1.1
        movslq    %edx, %rcx                                    #50.3
        cmpq      $16, %rcx                                     #50.3
        jl        ..B1.19       # Prob 10%                      #50.3
                                # LOE rcx rbx rbp rsi rdi r12 r13 r14 r15 edx xmm0
..B1.3:                         # Preds ..B1.2
        movq      %rsi, %r8                                     #50.3
        andq      $31, %r8                                      #50.3
        movl      %r8d, %r8d                                    #50.3
        testl     %r8d, %r8d                                    #50.3
        je        ..B1.6        # Prob 50%                      #50.3
                                # LOE rcx rbx rbp rsi rdi r8 r12 r13 r14 r15 edx xmm0
..B1.4:                         # Preds ..B1.3
        testl     $3, %r8d                                      #50.3
        jne       ..B1.19       # Prob 10%                      #50.3
                                # LOE rcx rbx rbp rsi rdi r8 r12 r13 r14 r15 edx xmm0
..B1.5:                         # Preds ..B1.4
        negl      %r8d                                          #50.3
        addl      $32, %r8d                                     #50.3
        shrl      $2, %r8d                                      #50.3
                                # LOE rcx rbx rbp rsi rdi r8 r12 r13 r14 r15 edx xmm0
..B1.6:                         # Preds ..B1.5 ..B1.3
        lea       16(%r8), %eax                                 #50.3
        cmpq      %rax, %rcx                                    #50.3
        jl        ..B1.19       # Prob 10%                      #50.3
                                # LOE rcx rbx rbp rsi rdi r8 r12 r13 r14 r15 edx xmm0
..B1.7:                         # Preds ..B1.6
        movl      %edx, %eax                                    #50.3
        subl      %r8d, %eax                                    #50.3
        andl      $15, %eax                                     #50.3
        subl      %eax, %edx                                    #50.3
        xorl      %eax, %eax                                    #50.3
        testq     %r8, %r8                                      #50.3
        jbe       ..B1.11       # Prob 10%                      #50.3
                                # LOE rax rcx rbx rbp rsi rdi r8 r12 r13 r14 r15 edx xmm0
..B1.9:                         # Preds ..B1.7 ..B1.9
        vaddss    (%rdi,%rax,4), %xmm0, %xmm0                   #51.5
        vaddss    (%rsi,%rax,4), %xmm0, %xmm0                   #51.16
        incq      %rax                                          #50.3
        cmpq      %r8, %rax                                     #50.3
        jb        ..B1.9        # Prob 82%                      #50.3
                                # LOE rax rcx rbx rbp rsi rdi r8 r12 r13 r14 r15 edx xmm0
..B1.11:                        # Preds ..B1.9 ..B1.7
        movslq    %edx, %rax                                    #50.3
        vxorps    %xmm1, %xmm1, %xmm1                           #49.13
        vmovss    %xmm0, %xmm1, %xmm0                           #49.13
        vinsertf128 $1, %xmm1, %ymm0, %ymm1                     #49.13
        vxorps    %ymm0, %ymm0, %ymm0                           #49.13
                                # LOE rax rcx rbx rbp rsi rdi r8 r12 r13 r14 r15 edx ymm0 ymm1
..B1.12:                        # Preds ..B1.12 ..B1.11
        vmovups   (%rdi,%r8,4), %xmm2                           #51.11
        vmovups   32(%rdi,%r8,4), %xmm5                         #51.11
        vinsertf128 $1, 16(%rdi,%r8,4), %ymm2, %ymm3            #51.11
        vinsertf128 $1, 48(%rdi,%r8,4), %ymm5, %ymm6            #51.11
        vaddps    (%rsi,%r8,4), %ymm3, %ymm4                    #51.16
        vaddps    32(%rsi,%r8,4), %ymm6, %ymm7                  #51.16
        vaddps    %ymm4, %ymm1, %ymm1                           #51.5
        vaddps    %ymm7, %ymm0, %ymm0                           #51.5
        addq      $16, %r8                                      #50.3
        cmpq      %rax, %r8                                     #50.3
        jb        ..B1.12       # Prob 82%                      #50.3
                                # LOE rax rcx rbx rbp rsi rdi r8 r12 r13 r14 r15 edx ymm0 ymm1
..B1.13:                        # Preds ..B1.12
        vaddps    %ymm0, %ymm1, %ymm0                           #49.13
        vextractf128 $1, %ymm0, %xmm1                           #49.13
        vaddps    %xmm1, %xmm0, %xmm2                           #49.13
        vmovhlps  %xmm2, %xmm2, %xmm3                           #49.13
        vaddps    %xmm3, %xmm2, %xmm4                           #49.13
        vshufps   $245, %xmm4, %xmm4, %xmm5                     #49.13
        vaddss    %xmm5, %xmm4, %xmm0                           #49.13
                                # LOE rcx rbx rbp rsi rdi r12 r13 r14 r15 edx xmm0
..B1.14:                        # Preds ..B1.13 ..B1.19
        xorl      %eax, %eax                                    #50.3
        lea       1(%rdx), %r8d                                 #50.3
        movslq    %r8d, %r8                                     #50.3
        cmpq      %r8, %rcx                                     #50.3
        jb        ..B1.18       # Prob 10%                      #50.3
                                # LOE rax rcx rbx rbp rsi rdi r12 r13 r14 r15 edx xmm0
..B1.15:                        # Preds ..B1.14
        movslq    %edx, %rdx                                    #50.3
        subq      %rdx, %rcx                                    #50.3
        lea       (%rsi,%rdx,4), %rsi                           #51.16
        lea       (%rdi,%rdx,4), %rdx                           #51.11
                                # LOE rax rdx rcx rbx rbp rsi r12 r13 r14 r15 xmm0
..B1.16:                        # Preds ..B1.16 ..B1.15
        vaddss    (%rdx,%rax,4), %xmm0, %xmm0                   #51.5
        vaddss    (%rsi,%rax,4), %xmm0, %xmm0                   #51.16
        incq      %rax                                          #50.3
        cmpq      %rcx, %rax                                    #50.3
        jb        ..B1.16       # Prob 82%                      #50.3
                                # LOE rax rdx rcx rbx rbp rsi r12 r13 r14 r15 xmm0
..B1.18:                        # Preds ..B1.16 ..B1.14 ..B1.1
        vzeroupper                                              #53.10
        ret                                                     #53.10
                                # LOE
..B1.19:                        # Preds ..B1.2 ..B1.6 ..B1.4    # Infreq
        xorl      %edx, %edx                                    #50.3
        jmp       ..B1.14       # Prob 100%                     #50.3
        .align    16,0x90
..___tag_value_dot_f.3:                                         #
                                # LOE rcx rbx rbp rsi rdi r12 r13 r14 r15 edx xmm0
# mark_end;
	.type	dot_f,@function
	.size	dot_f,.-dot_f
	.data
# -- End  dot_f
	.text
# -- Begin  dot_d
# mark_begin;
       .align    16,0x90
	.globl dot_d
dot_d:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %edx
..B2.1:                         # Preds ..B2.0
..___tag_value_dot_d.4:                                         #55.43
        vxorpd    %xmm0, %xmm0, %xmm0                           #56.3
        testl     %edx, %edx                                    #57.17
        jle       ..B2.18       # Prob 50%                      #57.17
                                # LOE rbx rbp rsi rdi r12 r13 r14 r15 edx xmm0
..B2.2:                         # Preds ..B2.1
        movslq    %edx, %rcx                                    #57.3
        cmpq      $16, %rcx                                     #57.3
        jl        ..B2.19       # Prob 10%                      #57.3
                                # LOE rcx rbx rbp rsi rdi r12 r13 r14 r15 edx xmm0
..B2.3:                         # Preds ..B2.2
        movq      %rsi, %r8                                     #57.3
        andq      $31, %r8                                      #57.3
        movl      %r8d, %r8d                                    #57.3
        testl     %r8d, %r8d                                    #57.3
        je        ..B2.6        # Prob 50%                      #57.3
                                # LOE rcx rbx rbp rsi rdi r8 r12 r13 r14 r15 edx xmm0
..B2.4:                         # Preds ..B2.3
        testl     $7, %r8d                                      #57.3
        jne       ..B2.19       # Prob 10%                      #57.3
                                # LOE rcx rbx rbp rsi rdi r8 r12 r13 r14 r15 edx xmm0
..B2.5:                         # Preds ..B2.4
        negl      %r8d                                          #57.3
        addl      $32, %r8d                                     #57.3
        shrl      $3, %r8d                                      #57.3
                                # LOE rcx rbx rbp rsi rdi r8 r12 r13 r14 r15 edx xmm0
..B2.6:                         # Preds ..B2.5 ..B2.3
        lea       16(%r8), %eax                                 #57.3
        cmpq      %rax, %rcx                                    #57.3
        jl        ..B2.19       # Prob 10%                      #57.3
                                # LOE rcx rbx rbp rsi rdi r8 r12 r13 r14 r15 edx xmm0
..B2.7:                         # Preds ..B2.6
        movl      %edx, %eax                                    #57.3
        subl      %r8d, %eax                                    #57.3
        andl      $15, %eax                                     #57.3
        subl      %eax, %edx                                    #57.3
        xorl      %eax, %eax                                    #57.3
        testq     %r8, %r8                                      #57.3
        jbe       ..B2.11       # Prob 10%                      #57.3
                                # LOE rax rcx rbx rbp rsi rdi r8 r12 r13 r14 r15 edx xmm0
..B2.9:                         # Preds ..B2.7 ..B2.9
        vaddsd    (%rdi,%rax,8), %xmm0, %xmm0                   #58.5
        vaddsd    (%rsi,%rax,8), %xmm0, %xmm0                   #58.16
        incq      %rax                                          #57.3
        cmpq      %r8, %rax                                     #57.3
        jb        ..B2.9        # Prob 82%                      #57.3
                                # LOE rax rcx rbx rbp rsi rdi r8 r12 r13 r14 r15 edx xmm0
..B2.11:                        # Preds ..B2.9 ..B2.7
        movslq    %edx, %rax                                    #57.3
        vxorpd    %xmm1, %xmm1, %xmm1                           #56.3
        vxorps    %xmm2, %xmm2, %xmm2                           #56.3
        vmovsd    %xmm0, %xmm1, %xmm0                           #56.3
        vxorpd    %ymm1, %ymm1, %ymm1                           #56.3
        vmovapd   %ymm1, %ymm3                                  #56.3
        vinsertf128 $1, %xmm2, %ymm0, %ymm2                     #56.3
        vmovapd   %ymm1, %ymm0                                  #56.3
        .align    16,0x90
                                # LOE rax rcx rbx rbp rsi rdi r8 r12 r13 r14 r15 edx ymm0 ymm1 ymm2 ymm3
..B2.12:                        # Preds ..B2.12 ..B2.11
        vmovupd   (%rdi,%r8,8), %xmm4                           #58.11
        vmovupd   32(%rdi,%r8,8), %xmm7                         #58.11
        vmovupd   64(%rdi,%r8,8), %xmm10                        #58.11
        vmovupd   96(%rdi,%r8,8), %xmm13                        #58.11
        vinsertf128 $1, 48(%rdi,%r8,8), %ymm7, %ymm8            #58.11
        vinsertf128 $1, 16(%rdi,%r8,8), %ymm4, %ymm5            #58.11
        vinsertf128 $1, 80(%rdi,%r8,8), %ymm10, %ymm11          #58.11
        vinsertf128 $1, 112(%rdi,%r8,8), %ymm13, %ymm14         #58.11
        vaddpd    (%rsi,%r8,8), %ymm5, %ymm6                    #58.16
        vaddpd    32(%rsi,%r8,8), %ymm8, %ymm9                  #58.16
        vaddpd    64(%rsi,%r8,8), %ymm11, %ymm12                #58.16
        vaddpd    96(%rsi,%r8,8), %ymm14, %ymm15                #58.16
        vaddpd    %ymm6, %ymm2, %ymm2                           #58.5
        vaddpd    %ymm9, %ymm1, %ymm1                           #58.5
        vaddpd    %ymm12, %ymm3, %ymm3                          #58.5
        vaddpd    %ymm15, %ymm0, %ymm0                          #58.5
        addq      $16, %r8                                      #57.3
        cmpq      %rax, %r8                                     #57.3
        jb        ..B2.12       # Prob 82%                      #57.3
                                # LOE rax rcx rbx rbp rsi rdi r8 r12 r13 r14 r15 edx ymm0 ymm1 ymm2 ymm3
..B2.13:                        # Preds ..B2.12
        vaddpd    %ymm1, %ymm2, %ymm1                           #56.3
        vaddpd    %ymm0, %ymm3, %ymm0                           #56.3
        vaddpd    %ymm0, %ymm1, %ymm2                           #56.3
        vextractf128 $1, %ymm2, %xmm3                           #56.3
        vaddpd    %xmm3, %xmm2, %xmm4                           #56.3
        vunpckhpd %xmm4, %xmm4, %xmm5                           #56.3
        vaddsd    %xmm5, %xmm4, %xmm0                           #56.3
                                # LOE rcx rbx rbp rsi rdi r12 r13 r14 r15 edx xmm0
..B2.14:                        # Preds ..B2.13 ..B2.19
        xorl      %eax, %eax                                    #57.3
        lea       1(%rdx), %r8d                                 #57.3
        movslq    %r8d, %r8                                     #57.3
        cmpq      %r8, %rcx                                     #57.3
        jb        ..B2.18       # Prob 10%                      #57.3
                                # LOE rax rcx rbx rbp rsi rdi r12 r13 r14 r15 edx xmm0
..B2.15:                        # Preds ..B2.14
        movslq    %edx, %rdx                                    #57.3
        subq      %rdx, %rcx                                    #57.3
        lea       (%rsi,%rdx,8), %rsi                           #58.16
        lea       (%rdi,%rdx,8), %rdx                           #58.11
                                # LOE rax rdx rcx rbx rbp rsi r12 r13 r14 r15 xmm0
..B2.16:                        # Preds ..B2.16 ..B2.15
        vaddsd    (%rdx,%rax,8), %xmm0, %xmm0                   #58.5
        vaddsd    (%rsi,%rax,8), %xmm0, %xmm0                   #58.16
        incq      %rax                                          #57.3
        cmpq      %rcx, %rax                                    #57.3
        jb        ..B2.16       # Prob 82%                      #57.3
                                # LOE rax rdx rcx rbx rbp rsi r12 r13 r14 r15 xmm0
..B2.18:                        # Preds ..B2.16 ..B2.14 ..B2.1
        vzeroupper                                              #60.10
        ret                                                     #60.10
                                # LOE
..B2.19:                        # Preds ..B2.2 ..B2.6 ..B2.4    # Infreq
        xorl      %edx, %edx                                    #57.3
        jmp       ..B2.14       # Prob 100%                     #57.3
        .align    16,0x90
..___tag_value_dot_d.6:                                         #
                                # LOE rcx rbx rbp rsi rdi r12 r13 r14 r15 edx xmm0
# mark_end;
	.type	dot_d,@function
	.size	dot_d,.-dot_d
	.data
# -- End  dot_d
	.text
# -- Begin  x2_m128d
# mark_begin;
       .align    16,0x90
	.globl x2_m128d
x2_m128d:
# parameter 1: %rdi
..B3.1:                         # Preds ..B3.0
..___tag_value_x2_m128d.7:                                      #62.29
        movq      $0x4000000000000000, %rax                     #65.15
        vmovupd   (%rdi), %xmm1                                 #64.42
        movq      %rax, -24(%rsp)                               #65.3
        movq      %rax, -16(%rsp)                               #65.19
        vmulpd    -24(%rsp), %xmm1, %xmm0                       #66.10
        ret                                                     #66.10
        .align    16,0x90
..___tag_value_x2_m128d.9:                                      #
                                # LOE
# mark_end;
	.type	x2_m128d,@function
	.size	x2_m128d,.-x2_m128d
	.data
# -- End  x2_m128d
	.text
# -- Begin  x2_m256d
# mark_begin;
       .align    16,0x90
	.globl x2_m256d
x2_m256d:
# parameter 1: %rdi
..B4.1:                         # Preds ..B4.0
..___tag_value_x2_m256d.10:                                     #68.29
        vmovupd   (%rdi), %ymm1                                 #71.10
        vmulpd    .L_2il0floatpacket.15(%rip), %ymm1, %ymm0     #71.10
        ret                                                     #71.10
        .align    16,0x90
..___tag_value_x2_m256d.12:                                     #
                                # LOE
# mark_end;
	.type	x2_m256d,@function
	.size	x2_m256d,.-x2_m256d
	.data
# -- End  x2_m256d
	.section .rodata, "a"
	.align 32
	.align 32
.L_2il0floatpacket.15:
	.long	0x00000000,0x40000000,0x00000000,0x40000000,0x00000000,0x40000000,0x00000000,0x40000000
	.type	.L_2il0floatpacket.15,@object
	.size	.L_2il0floatpacket.15,32
	.align 8
.L_2il0floatpacket.13:
	.long	0x00000000,0x40000000
	.type	.L_2il0floatpacket.13,@object
	.size	.L_2il0floatpacket.13,8
	.data
	.section .note.GNU-stack, ""
// -- Begin DWARF2 SEGMENT .eh_frame
	.section .eh_frame,"a",@progbits
.eh_frame_seg:
	.align 8
	.4byte 0x00000014
	.8byte 0x7801000100000000
	.8byte 0x0000019008070c10
	.4byte 0x00000000
	.4byte 0x00000014
	.4byte 0x0000001c
	.8byte ..___tag_value_dot_f.1
	.8byte ..___tag_value_dot_f.3-..___tag_value_dot_f.1
	.4byte 0x00000014
	.4byte 0x00000034
	.8byte ..___tag_value_dot_d.4
	.8byte ..___tag_value_dot_d.6-..___tag_value_dot_d.4
	.4byte 0x00000014
	.4byte 0x0000004c
	.8byte ..___tag_value_x2_m128d.7
	.8byte ..___tag_value_x2_m128d.9-..___tag_value_x2_m128d.7
	.4byte 0x00000014
	.4byte 0x00000064
	.8byte ..___tag_value_x2_m256d.10
	.8byte ..___tag_value_x2_m256d.12-..___tag_value_x2_m256d.10
# End
