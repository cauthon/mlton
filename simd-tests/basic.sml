local
  type real = Real32.real
  val simple1:real array = Array.fromList([1.0,2.0,3.0,4.0])
  val simple2:real array = Array.fromList([5.0,6.0,7.0,8.0])
  val simple3:real array = Array.fromList([9.0,10.0,11.0,12.0])
  open Simd128_Real32
  structure SimdReal = Simd128_Real32
  type simdReal = Simd128_Real32.simdReal
  val ps1:simdReal = fromArray(simple1)
  val ps2:simdReal = fromArray(simple2)
  val ps3:simdReal = fromArray(simple3)
  fun simdReal_fma (s1:simdReal,s2:simdReal,s3:simdReal):simdReal =
      SimdReal.add(s1,SimdReal.mul(s2,s3))
in
  val temp = simdReal_fma(ps1,ps2,ps3)
  val _ = TextIO.print ("Results for testing simd fma:\n" ^(fmt (StringCvt.FIX NONE) temp)^"\n")
end
