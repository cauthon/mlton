; ModuleID = 'test.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind readonly uwtable
define float @dot_product(float* nocapture %A, float* nocapture %B, i32 %len) #0 {
  %1 = icmp sgt i32 %len, 0
  br i1 %1, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0
  %cnt.cast = zext i32 %len to i64
  %n.vec = and i64 %cnt.cast, 4294967264
  %cmp.zero = icmp eq i64 %n.vec, 0
  br i1 %cmp.zero, label %middle.block, label %vector.body

vector.body:                                      ; preds = %.lr.ph, %vector.body
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %.lr.ph ]
  %vec.phi = phi <8 x float> [ %22, %vector.body ], [ zeroinitializer, %.lr.ph ]
  %vec.phi6 = phi <8 x float> [ %23, %vector.body ], [ zeroinitializer, %.lr.ph ]
  %vec.phi7 = phi <8 x float> [ %24, %vector.body ], [ zeroinitializer, %.lr.ph ]
  %vec.phi8 = phi <8 x float> [ %25, %vector.body ], [ zeroinitializer, %.lr.ph ]
  %2 = getelementptr inbounds float* %A, i64 %index
  %3 = bitcast float* %2 to <8 x float>*
  %wide.load = load <8 x float>* %3, align 4
  %.sum33 = or i64 %index, 8
  %4 = getelementptr float* %A, i64 %.sum33
  %5 = bitcast float* %4 to <8 x float>*
  %wide.load9 = load <8 x float>* %5, align 4
  %.sum34 = or i64 %index, 16
  %6 = getelementptr float* %A, i64 %.sum34
  %7 = bitcast float* %6 to <8 x float>*
  %wide.load10 = load <8 x float>* %7, align 4
  %.sum35 = or i64 %index, 24
  %8 = getelementptr float* %A, i64 %.sum35
  %9 = bitcast float* %8 to <8 x float>*
  %wide.load11 = load <8 x float>* %9, align 4
  %10 = getelementptr inbounds float* %B, i64 %index
  %11 = bitcast float* %10 to <8 x float>*
  %wide.load12 = load <8 x float>* %11, align 4
  %.sum36 = or i64 %index, 8
  %12 = getelementptr float* %B, i64 %.sum36
  %13 = bitcast float* %12 to <8 x float>*
  %wide.load13 = load <8 x float>* %13, align 4
  %.sum37 = or i64 %index, 16
  %14 = getelementptr float* %B, i64 %.sum37
  %15 = bitcast float* %14 to <8 x float>*
  %wide.load14 = load <8 x float>* %15, align 4
  %.sum38 = or i64 %index, 24
  %16 = getelementptr float* %B, i64 %.sum38
  %17 = bitcast float* %16 to <8 x float>*
  %wide.load15 = load <8 x float>* %17, align 4
  %18 = fadd <8 x float> %wide.load, %wide.load12
  %19 = fadd <8 x float> %wide.load9, %wide.load13
  %20 = fadd <8 x float> %wide.load10, %wide.load14
  %21 = fadd <8 x float> %wide.load11, %wide.load15
  %22 = fadd <8 x float> %vec.phi, %18
  %23 = fadd <8 x float> %vec.phi6, %19
  %24 = fadd <8 x float> %vec.phi7, %20
  %25 = fadd <8 x float> %vec.phi8, %21
  %index.next = add i64 %index, 32
  %26 = icmp eq i64 %index.next, %n.vec
  br i1 %26, label %middle.block, label %vector.body

middle.block:                                     ; preds = %vector.body, %.lr.ph
  %resume.val = phi i64 [ 0, %.lr.ph ], [ %n.vec, %vector.body ]
  %rdx.vec.exit.phi = phi <8 x float> [ zeroinitializer, %.lr.ph ], [ %22, %vector.body ]
  %rdx.vec.exit.phi18 = phi <8 x float> [ zeroinitializer, %.lr.ph ], [ %23, %vector.body ]
  %rdx.vec.exit.phi19 = phi <8 x float> [ zeroinitializer, %.lr.ph ], [ %24, %vector.body ]
  %rdx.vec.exit.phi20 = phi <8 x float> [ zeroinitializer, %.lr.ph ], [ %25, %vector.body ]
  %bin.rdx = fadd <8 x float> %rdx.vec.exit.phi18, %rdx.vec.exit.phi
  %bin.rdx21 = fadd <8 x float> %rdx.vec.exit.phi19, %bin.rdx
  %bin.rdx22 = fadd <8 x float> %rdx.vec.exit.phi20, %bin.rdx21
  %rdx.shuf = shufflevector <8 x float> %bin.rdx22, <8 x float> undef, <8 x i32> <i32 4, i32 5, i32 6, i32 7, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx23 = fadd <8 x float> %bin.rdx22, %rdx.shuf
  %rdx.shuf24 = shufflevector <8 x float> %bin.rdx23, <8 x float> undef, <8 x i32> <i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx25 = fadd <8 x float> %bin.rdx23, %rdx.shuf24
  %rdx.shuf26 = shufflevector <8 x float> %bin.rdx25, <8 x float> undef, <8 x i32> <i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %bin.rdx27 = fadd <8 x float> %bin.rdx25, %rdx.shuf26
  %27 = extractelement <8 x float> %bin.rdx27, i32 0
  %cmp.n = icmp eq i64 %cnt.cast, %resume.val
  br i1 %cmp.n, label %._crit_edge, label %scalar.ph

scalar.ph:                                        ; preds = %middle.block, %scalar.ph
  %indvars.iv = phi i64 [ %indvars.iv.next, %scalar.ph ], [ %resume.val, %middle.block ]
  %temp.01 = phi float [ %33, %scalar.ph ], [ %27, %middle.block ]
  %28 = getelementptr inbounds float* %A, i64 %indvars.iv
  %29 = load float* %28, align 4, !tbaa !0
  %30 = getelementptr inbounds float* %B, i64 %indvars.iv
  %31 = load float* %30, align 4, !tbaa !0
  %32 = fadd fast float %29, %31
  %33 = fadd fast float %temp.01, %32
  %indvars.iv.next = add i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %len
  br i1 %exitcond, label %._crit_edge, label %scalar.ph, !llvm.vectorizer.already_vectorized !3

._crit_edge:                                      ; preds = %middle.block, %scalar.ph, %0
  %temp.0.lcssa = phi float [ 0.000000e+00, %0 ], [ %27, %middle.block ], [ %33, %scalar.ph ]
  ret float %temp.0.lcssa
}

attributes #0 = { nounwind readonly uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-frame-pointer-elim-non-leaf"="false" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "unsafe-fp-math"="true" "use-soft-float"="false" }

!0 = metadata !{metadata !"float", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA"}
!3 = metadata !{}
