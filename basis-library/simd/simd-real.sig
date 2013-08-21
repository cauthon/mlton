(* Copyright (C) 2013 Tucker DiNapoli
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)

signature SIMD_REAL =
sig
  val vecSize:Int32.int (*size of the simd vector 128 or 256,
                          *hopefully later any multiple of 128*)
  val realSize:Int32.int (*size of real, 32/64*)
  val elements:Int32.int
  type simdReal (* high level type *)
(*  type t = simdReal*)
  type elt (* element type*)
(*load/store*)
  val fromArray:elt array -> simdReal
  val toArray:elt array * simdReal-> unit
  val fromArrayOffset:elt array*Int32.int -> simdReal
(*  val fromArraySlice:elt slice -> t (*non primtive*)
  val set:elt list -> t(*aka from list*) (*non primtive*)
  val set1:elt -> t(*fill with duplicates of elt*) (*non primtive*)*)
  val fromScalar:elt -> simdReal
  val toScalar:simdReal -> elt(*e = lowest eltent in t*)
(* because of toScalar we can get any element of a simd vector,
 * albeit not super efficently, via shuffling.*)
(*math*)
  val add:simdReal*simdReal->simdReal
  val sub:simdReal*simdReal->simdReal
  val mul:simdReal*simdReal->simdReal
  val div:simdReal*simdReal->simdReal
  val sqrt:simdReal->simdReal
  val min:simdReal*simdReal->simdReal
  val max:simdReal*simdReal->simdReal
(*HADD(HSUB follows same pattern
 *SRC :|X7|X6|X5|X4|X3|X2|X1|X0|
 *DEST:|Y7|Y6|Y5|Y4|Y3|Y2|Y1|Y0| (*or SRC2*)
 *END :|Y6+Y7|Y4+Y5|X6+X7|X4+X5|Y2+Y3|X0+Y1|X2+X3|X0+X1|*)
  val hadd:simdReal*simdReal->simdReal(*horozontal add*)
  val hsub:simdReal*simdReal->simdReal(*horozontal sub*)
  val addsub:simdReal*simdReal->simdReal(*add odd indices, sub even indices*)
(*bitwise, no shifts for floating pt numbers, for obvious reasons*)
  val andb:simdReal*simdReal->simdReal
  val xorb:simdReal*simdReal->simdReal
  val orb: simdReal*simdReal->simdReal
  val andnb:simdReal*simdReal->simdReal
(*  val notb:t->t (*0xff..ff and opperand = ! opperand*)(*non primtive*)*)
(*(*Round/Convert*)
  val vroundp:t*t*word8.word->wordx.t(*actual round instruction*)
  (*Need to implement these myself,all are just round with a different imm*)
  (*Also need to make theme take a type argument to determine size*)
  val vround:t*t*int->wordx.t(*imm=00*)
  val vceil:t*t*int->wordx.t(*imm=01*)
  val vfloor:t*t*int->wordx.t(*imm=10*)
  val vtrunc:t*t*int->wordx.t(*imm=11*)
(*these are a lot more complicated, but we should be able to just have a from
 *and a to function and pick the right instruction based on the types*)
  val vcvt2f:WordX.t->t
  val vcvt2i:t->WordX.t*)
(*SSE has 8 float comparisons, AVX has 32 so we implement comparisons using
( *a datatype of possible comparisions*)
    datatype cmp = eq  | lt  | gt  | le  | ge  | ord
                 | ne  | nlt | ngt | nle | nge | unord
    val primitiveCmp: simdReal*simdReal*Word8.word -> simdReal
    val cmp: simdReal*simdReal*cmp -> simdReal
(*return true if any of the comparisons return true, uses maskmove
   fun cmpBool(s1,s2,cmp) =
      let
         val s3 = cmp(s1,s2,s3)
      in op=(0.0,maskmove(s3)
   end
 *)
(*  val cmpBool: t*t*cmp -> bool
(*return a list of booleans, one for each comparison*)
  val cmpBools: t*t*cmp -> bool list*)
(*unpack/shuffle/blend,etc*)
  val primitiveShuffle:simdReal*simdReal*Word8.word->simdReal
  val shuffle:simdReal*simdReal*(Word8.word*Word8.word*Word8.word*Word8.word)
              -> simdReal
(*  val blend:t*t*t->t
  val extract:t*word8.word -> e*)
  val toString: simdReal -> string
  val toStringScalar: simdReal -> string
  val fmt: StringCvt.realfmt -> simdReal -> string
end
(*signature SIMD_AVAILABLE =
sig
  val sse3:bool
  val ssse3:bool
  val sse4.1:bool
  val sse4.2:bool
  val avx:bool
  val avx2:bool
end*)
