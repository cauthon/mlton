local
  type real = Real32.real
  val simple1:real array = Array.fromList([1.0,2.0,3.0,4.0])
  val simple2:real array = Array.fromList([5.0,6.0,7.0,8.0])
  val rand1:real array = 
      Array.fromList([0.14751956, 0.2372235, 0.6751645, 0.8104256])
  val rand2:real array = 
      Array.fromList([0.83982096, 0.98309407, 0.78378120, 0.03415542])
  val pi = 3.14159265358
  val e = 2.71828182845
  open Simd128_Real32
  type simd = t
  val print_simd = _import "Simd128_Real32_print" : simd -> unit;
  val print_scalar = _import "Simd128_Real32_printScalar" : simd -> unit;
  val s1:simd = fromArray(simple1)
  val s2:simd = fromArray(simple2)
  val r1:simd = fromArray(rand1)
  val r2:simd = fromArray(rand2)
  val simd_pi:simd = fromScalar(pi)
  val simd_e:simd = fromScalar(e)
  fun print_test (s:simd,r:simd,scalar:simd,test:string)
      (* s_ctl:real array,r_ctl:real array,scalar_ctl:real)*) = let
    val _ = TextIO.print concat(["results for testing simd ",test,":\n"])
    val _ = print_simd(s)
    val _ = print_simd(r)
    val _ = print_simd(scalar)
  in () end
      
in
fun test_add () =
    let
      val simple_add = add(s1,s2)(*6.0 8.0 10.0 12.0*)
      val rand_add = add(r1,r2)(*0.98734057 1.2203176 1.4589458 0.844581*)
      val scalar_add = add(simd_pi,simd_e)(*5.859874399500438*)
    in print_test(simple_add,rand_add,scalar_add,"add") end
fun test_sub () =
    let


      val simple_sub = sub(s1,s2)(*-4.0 -4.0 -4.0 -4.0*)
      val rand_sub = sub(r1,r2)(*-0.6923014 -0.7458706 -0.10861665 0.77627015*)
      val scalar_sub = sub(simd_pi,simd_e)(*0.4233109076791486d0*)
    in print_test(simple_sub,rand_sub,scalar_sub,"sub") end
fun test_mul () =
let 
(*(5.0 12.0 21.0 32.0)
(0.12389002 0.23321302 0.52918124 0.027680427)
8.539733963340117d0*)
in end
fun test_div () =
let 
(*(0.2 0.33333334 0.42857143 0.5)
(0.17565596 0.24130295 0.8614197 23.727583)
1.1557273848878886d0*)
fun test_max () =
let
(*(5.0 6.0 7.0 8.0)
(0.839821 0.9830941 0.7837812 0.8104256)
3.141592653589793d0*)
in end
fun test_min () = 
let 
(*(1.0 2.0 3.0 4.0)
(0.14751956 0.2372235 0.6751645 0.03415542)
2.7182817*)
in end
