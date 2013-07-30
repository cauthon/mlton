local
  type real = Real32.real
  val simple1:real array = Array.fromList([1.0,2.0,3.0,4.0])
  val simple2:real array = Array.fromList([5.0,6.0,7.0,8.0])
  val rand1:real array = 
      Array.fromList([0.14751956, 0.2372235, 0.6751645, 0.8104256])
  val rand2:real array = 
      Array.fromList([0.83982096, 0.98309407, 0.78378120, 0.03415542])
  val scalar1:real = 3.14159265358
  val scalar2:real = 2.71828182845
  open Simd128_Real32
  structure SimdReal = Simd128_Real32
  type simd = t
  val print_simd = _import "Simd128_Real32_print" : simd -> unit;
  val print_scalar = _import "Simd128_Real32_printScalar" : simd -> unit;
  val ps1:simd = fromArray(simple1)
  val ps2:simd = fromArray(simple2)
  val r1:simd = fromArray(rand1)
  val r2:simd = fromArray(rand2)
  val ss1:simd = fromScalar(scalar1)
  val ss2:simd = fromScalar(scalar2)
  fun print_test (s:simd,r:simd,scalar:simd,test:string)
      (* s_ctl:real array,r_ctl:real array,scalar_ctl:real)*) = let
    val _ = TextIO.print (concat(["Results for testing simd ",test,":\n"]))
    val _ = TextIO.print "Simple:\n"
    val _ = print_simd(s)
    val _ = TextIO.print "Rand:\n"
    val _ = print_simd(r)
    val _ = TextIO.print "Scalar:\n"
    val _ = print_simd(scalar)
  in () end
in
(*run a test for binary function f*)
fun bin_test (f:(simd*simd->simd),name:string) =
    let
      val simple = f(ps1,ps2)(*6.0 8.0 10.0 12.0*)
      val rand = f(r1,r2)(*0.98734057 1.2203176 1.4589458 0.844581*)
      val scalar = f(ss1,ss2)(*5.859874399500438*)
    in print_test(simple,rand,scalar,name) end
fun test_from_string (s:string) =
    case s of
        "add" => (fn () => bin_test(SimdReal.add,s))
      | "sub" => (fn () => bin_test(SimdReal.sub,s))
      | "mul" => (fn () => bin_test(SimdReal.mul,s))
      | "div" => (fn () => bin_test(SimdReal.div,s))
      | _ => (fn () => ())
(*tests to be run*)
val tests:(((simd*simd->simd) * string) list) =
    [(SimdReal.add,"add"),(SimdReal.sub,"sub"),
     (SimdReal.mul,"mul"),(SimdReal.div,"div")]
(*run tests*)
val _ = List.app bin_test tests
end
