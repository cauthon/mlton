local
  type real = Real32.real
  val simple1:real array = Array.fromList([1.0,2.0,3.0,4.0])
  val simple2:real array = Array.fromList([5.0,6.0,7.0,8.0])
  val simple3:real array = Array.fromList([9.0,10.0,11.0,12.0])
  val rand1:real array = 
      Array.fromList([0.14751956, 0.2372235, 0.6751645, 0.8104256])
  val rand2:real array = 
      Array.fromList([0.83982096, 0.98309407, 0.78378120, 0.03415542])
  open Simd128_Real32
  structure SimdReal = Simd128_Real32
  type simdReal = Simd128_Real32.simdReal
  val print_simd = _import "Simd128_Real32_print" : simdReal -> unit;
  val ps1:simdReal = fromArray(simple1)
  val ps2:simdReal = fromArray(simple2)
  val ps3:simdReal = fromArray(simple3)
  val r1:simdReal = fromArray(rand1)
  val r2:simdReal = fromArray(rand2)
  val _ = TextIO.print("simple 1: "^(toString ps1)^"\n")
  val _ = TextIO.print("simple 2: "^(toString ps2)^"\n")
  val _ = TextIO.print("simple 3: "^(toString ps3)^"\n")
  fun print_test (s:simdReal,r:simdReal,test:string)
      (* s_ctl:real array,r_ctl:real array,scalar_ctl:real)*) = let
    val _ = TextIO.print (concat(["Results for testing simd ",test,":\n"]))
    val _ = TextIO.print("Simple: "^(toString s)^"\n")
    val _ = TextIO.print("Rand: "^(toString s)^"\n")
  in () end
  fun simdReal_fma (s1:simdReal,s2:simdReal,s3:simdReal):simdReal =
      SimdReal.add(s1,SimdReal.mul(s2,s3))
in
(*run a test for binary function f*)
fun bin_test (f:(simdReal*simdReal->simdReal),name:string) =
    let
      val simple = f(ps1,ps2)(*6.0 8.0 10.0 12.0*)
      val rand = f(r1,r2)(*0.98734057 1.2203176 1.4589458 0.844581*)
    in print_test(simple,rand,name) end
fun test_from_string (s:string) =
    case s of
        "add" => (fn () => bin_test(SimdReal.add,s))
      | "sub" => (fn () => bin_test(SimdReal.sub,s))
      | "mul" => (fn () => bin_test(SimdReal.mul,s))
      | "div" => (fn () => bin_test(SimdReal.div,s))
      | _ => (fn () => ())
(*tests to be run*)
val tests:(((simdReal*simdReal->simdReal) * string) list) =
    [(SimdReal.add,"add"),(SimdReal.sub,"sub"),
     (SimdReal.mul,"mul")]
(*run tests*)
val temp = simdReal_fma(ps1,ps2,ps3)
val _ = TextIO.print "Results for testing simd fma:\n"
val _ = TextIO.print("Simple: "^(toString temp)^"\n")
val _ = List.app bin_test tests

end
