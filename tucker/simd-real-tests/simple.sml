(*fun simdAddMul (s1:Simd128_Real32.simdReal,s2:Simd128_Real32.simdReal
                ,s3:Simd128_Real32.simdReal):Simd128_Real32.simdReal =
    Simd128_Real32.mul(s3,Simd128_Real32.add(s1,s2))*)
  val a = Simd128_Real32.fromScalar(0.0:Real32.real)
  val _ = TextIO.print (Simd128_Real32.toStringScalar a)
