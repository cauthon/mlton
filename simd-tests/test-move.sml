(* Copyright (C) 2013 Tucker DiNapoli
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)
(*simd128_real32 tests*)
local
  type real = Real32.real
  type simdConst = real*real*real*real
  fun toConst (a:real array,i:int):simdConst =
        (Array.sub(a,i),Array.sub(a,i+1),Array.sub(a,i+2),Array.sub(a,i+3))
  fun toStringConst (s:simdConst as (a,b,c,d)) =
        concat(["(",Real32.toString(a),",",Real32.toString(b),",",
                Real32.toString(c),",",Real32.toString(d),")"])
  structure S = Simd128_Real32
  fun print_test (actual:S.simdReal,expected:simdConst,
                 test:string) = let
      val _ = TextIO.print (concat(["Results for testing ",test,":\n"]))
      val _ = TextIO.print (concat(["Expected result: ",toStringConst(expected),"\n"]))
      val _ = TextIO.print (concat(["Actual result  : ",S.toString(actual),"\n"]))
  in () end
  fun print_test_scalar (actual:S.simdReal,expected:real,
                 test:string) = let
      val _ = TextIO.print (concat(["Results for testing ",test,":\n"]))
      val _ = TextIO.print (concat(["Expected result: ",Real32.toString(expected),"\n"]))
      val _ = TextIO.print (concat(["Actual result  : ",S.toStringScalar(actual),"\n"]))
  in () end
  fun test_exception (actual:string,expected:string,test:string) = let
      val _ = TextIO.print (concat(["Results for testing ",test,":\n"]))
      val _ = TextIO.print (concat(["Expected result: ",expected,"\n"]))
      val _ = TextIO.print (concat(["Actual result  : ",actual,"\n"]))
  in () end
  val pi32:real = 3.1415927
  val e32:real = 2.7182817
  val phi32:real = 1.618033
  val a1:real array = 
      Array.fromList([594.0589, 283.77258, 9.566903, 843.5225])
  val C_a1:simdConst = toConst(a1,0)
  val a2:real array =
      Array.fromList([224.92897, 831.47095, 279.5267, 584.4146])
  val C_a2:simdConst = toConst(a2,0)
  val b1:real array = Array.fromList
         ([0.7568612, 0.9189848, 0.0073252916, 0.31148136])
  val C_b1:simdConst = toConst(b1,0)
  val b2:real array = Array.fromList
         ([0.59585714, 0.07142329, 0.72258794, 0.6982585])
  val C_b2:simdConst = toConst(b2,0)
  val c1:real array = Array.fromList
                        ([423.84863, 867.98645, 362.71906, 357.47028, 797.477, 515.48016, 481.2944, 486.26483, 949.5173, 784.454, 844.17535, 310.95575, 347.7303, 342.37338, 603.8262, 412.0921])
  val C_c1:(int -> simdConst) = fn x => toConst(c1,x)
  val c2:real array = Array.fromList 
                        ([594.5598, 63.665627, 633.1009, 553.8459, 744.85754, 92.342735, 298.2279, 194.26346, 988.1369, 646.9155, 643.80646, 389.65714, 250.3655, 634.1989, 527.49994, 900.44403])
  val C_c2:(int -> simdConst) = fn x => toConst(c2,x)
  val d1:real array = Array.fromList
                        ([0.9751378, 0.2926259, 0.5879499, 0.41872954, 0.84174955, 0.5093733, 0.615062, 0.5520501, 0.4115485, 0.35940528, 0.0056368113, 0.31019592, 0.4214077, 0.32522345, 0.2879219, 0.23799527])
  val C_d1:(int -> simdConst) = fn x => toConst(d1,x)
  val d2:real array = Array.fromList
([0.98117805, 0.06889212, 0.32721102, 0.8774886, 0.25179327, 0.76311684, 0.42041814, 0.5310335, 0.10243285, 0.59039974, 0.072882414, 0.3737452, 0.8174622, 0.9795288, 0.9159782, 0.8911723])
  val C_d2:(int -> simdConst) = fn x => toConst(d2,x)
  fun gen_expected (f,arr1,arr2,i) = 
      toConst(Array.fromList
                (List.tabulate
                   (4, fn x =>f(Array.sub(arr1,x+i),Array.sub(arr2,x+i)))),0)
in
   val a1'= S.fromArray(a1)
   val _ = print_test(a1',C_a1,"fromArray a1")
   val a2'= S.fromArray(a2)
   val _ = print_test(a2',C_a2,"fromArray a2")
   val b1'= S.fromArray(b1)
   val _ = print_test(b1',C_b1,"fromArray b1")
   val b2'= S.fromArray(b2)
   val _ = print_test(b2',C_b2,"fromArray b2")
   val c1'= S.fromArrayOffset(c1,4)
   val _ = print_test(c1',C_c1(4),"fromArrayOffset c1")
   val c2'= S.fromArrayOffset(c2,8)
   val _ = print_test(c2',C_c2(8),"fromArrayOffset c2")
   val d1'= S.fromArrayOffset(d1,12)
   val _ = print_test(d1',C_d1(12),"fromArrayOffset d1")
   val d2'= S.toString(S.fromArrayOffset(d2,16))
            handle Subscript => "Handled out of bounds load"
   val _ = test_exception(d2',"Handled out of bounds load","fromArrayOffset d1")
   val a1'':real array = Array.array(4,0.0)
   val _ = S.toArray(a1'',a1')
   val _ = TextIO.print 
             (concat(["Results for testing toArray a1':\nExpected results: ",toStringConst(C_a1),
                      "\nActual Results: ",toStringConst(toConst(a1'',0)),"\n"]))
   val _ = print_test(S.add(a1',a2'),gen_expected(op+,a1,a2,0),"simd add a1 + a2")
   val e32' = S.fromScalar(e32)
   val pi32' = S.fromScalar(pi32)
   val phi32' = S.fromScalar(phi32)
end
(*local
  local
    type real = Real64.real
    type simdConst = real*real
    fun toStringConst (s:simdConst as (a,b)) =
        concat(["(",Real32.toString(a),",",Real32.toString(b),")"])
    structure S = Simd128_Real64
  in
  val phi64 = 1.618033988749895
  val pi64 = 3.14159265358979323846
  val e64 = 2.7182818284590452354

  end
in
end*)
