(* Copyright (C) 2013 Tucker DiNapoli
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)
(*simd128_word16 tests*)
local
  type word = Word16.word
  type simdConst = word*word*word*word*word*word*word*word
  fun toConst (a:word array,i:int):simdConst =
        (Array.sub(a,i),Array.sub(a,i+1),Array.sub(a,i+2),Array.sub(a,i+3),Array.sub(a,i+4),Array.sub(a,i+5),Array.sub(a,i+6),Array.sub(a,i+7))
  fun toStringConst (s:simdConst as (a,b,c,d,e,f,g,h)) =
        concat(["(",Word16.toString(a),",",Word16.toString(b),",",
                Word16.toString(c),",",Word16.toString(d),",",
                Word16.toString(e),",",Word16.toString(f),",",
                Word16.toString(g),",",Word16.toString(h),")"])
  structure S = Simd128_Word16
  fun print_test (actual:S.simdWord,expected:simdConst,
                 test:string) = let
    val _ = TextIO.print (concat(["Results for testing ",test,":\n",
                          "Expected result: ",toStringConst(expected),"\n",
                          "Actual result  : ",S.toString(actual),"\n"]))
  in () end
 fun print_test_scalar (actual:S.simdWord,expected:word,
                 test:string) = let
    val _ = TextIO.print 
              (concat(["Results for testing ",test,":\n",
                       "Expected result: ",Word16.toString(expected),"\n",
                       "Actual result  : ",S.toStringScalar(actual),"\n"]))
  in () end
  fun test_exception (actual:string,expected:string,test:string) = let
      val _ = TextIO.print (concat(["Results for testing ",test,":\n"]))
      val _ = TextIO.print (concat(["Expected result: ",expected,"\n"]))
      val _ = TextIO.print (concat(["Actual result  : ",actual,"\n"]))
  in () end
  val pi:word = 0w31416
  val e:word = 0w27182
  val phi:word = 0w16180
  val a1:word array = 
      Array.fromList([0w1,0w1,0w2,0w3,0w5,0w8,0w13,0w21])
  val C_a1:simdConst = toConst(a1,0)
  val a2:word array =
      Array.fromList([0w34,0w55,0w89,0w144,0w233,0w377,0w610,0w987])
  val C_a2:simdConst = toConst(a2,0)
  val b1:word array = Array.fromList
         ([0w2,0w3,0w5,0w7,0w11,0w13,0w17,0w19])
  val C_b1:simdConst = toConst(b1,0)
  val b2:word array = Array.fromList
         ([0w23,0w29,0w31,0w37,0w41,0w43,0w47,0w59])
  val C_b2:simdConst = toConst(b2,0)
  val c1:word array = Array.fromList
                        ([0w11449,0w19605,0w25787,0w16202,0w6956,0w14639,
                          0w5980,0w27203,0w23886,0w20146,0w9296,0w5592,0w26153,
                          0w24000,0w25507])
  val C_c1:simdConst = toConst(c1,0)
  val c2:word array = Array.fromList 
                        ([0w30581,0w31209,0w30695,0w14541,0w7262,0w11446,
                          0w22657,0w9185,0w19043,0w21800,0w11166,0w30394,
                          0w10651,0w15234,0w15137,0w18958])
  val C_c2:simdConst = toConst(c2,0)
  val d1:word array = Array.fromList
                        ([0w25120,0w4484,0w12817,0w6284,0w25381,0w20679,
                          0w30777,0w13659,0w7741,0w24844,0w831,0w18910,0w20763,
                          0w12458,0w25751])
  val C_d1:simdConst = toConst(d1,0)
  val d2:word array = Array.fromList
                        ([0w28121,0w24726,0w2638,0w26512,0w25794,0w15849,
                          0w14049,0w20711,0w18621,0w31938,0w9868,0w28962,
                          0w23927,0w2066,0w23053,0w18596])
  val C_d2:simdConst = toConst(d2,0)
  fun gen_expected (f,arr1,arr2,i) = 
      toConst(Array.fromList
                (List.tabulate
                   (8, fn x =>f(Array.sub(arr1,x+i),Array.sub(arr2,x+i)))),0)
in
(*seperated print statements in order to determine
 which load failed in case of an error*)
   val a1'= S.fromArray(a1)
   val _ = print_test(a1',C_a1,"fromArray a1")
   val a2'= S.fromArray(a2)
   val _ = print_test(a2',C_a2,"fromArray a2")
   val b1'= S.fromArray(b1)
   val _ = print_test(b1',C_b1,"fromArray b1")
   val b2'= S.fromArray(b2)
   val _ = print_test(b2',C_b2,"fromArray b2")
(*   val c1'= S.fromArrayOffset(c1,4)
   val _ = print_test(c1',C_c1(4),"fromArrayOffset c1")
   val c2'= S.fromArrayOffset(c2,8)
   val _ = print_test(c2',C_c2(8),"fromArrayOffset c2")
   val d1'= S.fromArrayOffset(d1,12)
   val _ = print_test(d1',C_d1(12),"fromArrayOffset d1")
   val d2'= S.toString(S.fromArrayOffset(d2,16))
            handle Subscript => "Handled out of bounds load"
   val _ = test_exception(d2',"Handled out of bounds load","fromArrayOffset d1")*)
   val a1'':word array = Array.array(8,0w0)
(*   val _ = (S.toArray(a1'',a1');
            TextIO.print 
             (concat(["Results for testing toArray a1':\nExpected result: ",
                      toStringConst(C_a1),"\nActual Result  : ",
                      toStringConst(toConst(a1'',0)),"\n"])))*)
   val _ = 
       (print_test(S.add(a1',a2'),gen_expected(op+,a1,a2,0),"simd add a1 + a2");
        print_test(S.sub(a1',a2'),gen_expected(op-,a1,a2,0),"simd sub a1 + a2");
        print_test(S.mins(a1',a2'),gen_expected(Word16.min,a1,a2,0), "simd min a1 + a2");
        print_test(S.maxs(a1',a2'),gen_expected(Word16.max,a1,a2,0),"simd max a1 + a2"))
(*n   val e32' = S.fromScalar(e32)
   val pi32' = S.fromScalar(pi32)
   val phi32' = S.fromScalar(phi32)
   val _ = (print_test_scalar(e32',e32,"fromScalar e32");
            print_test_scalar(pi32',pi32,"fromScalar pi32");
            print_test_scalar(phi32',phi32,"fromScalar phi32"))*)
end

