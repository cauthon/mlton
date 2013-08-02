(*fun simdAddMul (s1:Simd128_Real32.simdReal,s2:Simd128_Real32.simdReal
                ,s3:Simd128_Real32.simdReal):Simd128_Real32.simdReal =
    Simd128_Real32.mul(s3,Simd128_Real32.add(s1,s2))*)
  val a = Simd128_Real32.fromScalar(2.0:Real32.real)
  val b = Simd128_Real32.fromScalar(2.0:Real32.real)
  val c = Simd128_Real32.add(a,b)
  val _ = TextIO.print ("a: "^(Simd128_Real32.toStringScalar a)^"\n")
  val _ = TextIO.print ("b: "^(Simd128_Real32.toStringScalar b)^"\n")
  val _ = TextIO.print ("c: "^(Simd128_Real32.toStringScalar c)^"\n")
  val _ = TextIO.print ("sqrt(a): "^(Simd128_Real32.toStringScalar
                                        (Simd128_Real32.sqrt(a)))^"\n")
