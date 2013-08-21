local
  open Real32
  type simdReal = real*real*real*real
  fun simdBinOp (s1 as (a1,b1,c1,d1):simdReal,
                 s2 as (a2,b2,c2,d2):simdReal,
                 f:real*real->real):simdReal =
      (f(a1,a2),f(b1,b2),f(c1,c2),f(d1,d2))
  val simple1:simdReal=(1.0,2.0,3.0,4.0)
  val simple2:simdReal=(5.0,6.0,7.0,8.0)
  val simple3:simdReal=(9.0,10.0,11.0,12.0)
  fun fma (s1:simdReal,s2:simdReal,s3:simdReal):simdReal =
      simdBinOp(s1,simdBinOp(s2,s3,op*),op+)
  fun toString (s as (a,b,c,d):simdReal):string =
      let
        val f = fmt (StringCvt.FIX NONE)
      in
        concat(["(",f(a),",",f(b),",",f(c),",",f(d),")"])
      end
in
  val temp = fma(simple1,simple2,simple3)
  val _ = TextIO.print ("Results for testing simd fma:\n" ^(toString temp)^"\n")
end      
