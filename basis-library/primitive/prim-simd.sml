(* Copyright (C) 2013 Tucker DiNapoli
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)
(*Note: need to ask about casting b/t real array and word8 array*)
signature PRIM_SIMD_REAL =
   sig
      val vecSize : Primitive.Int32.int
      val realSize : Primitive.Int32.int
      type t 
      type simdReal(* = t*)
      type elt
      val add : simdReal * simdReal -> simdReal
      val sub : simdReal * simdReal -> simdReal
      val mul : simdReal * simdReal -> simdReal
      val div : simdReal * simdReal -> simdReal
      val min : simdReal * simdReal -> simdReal
      val max : simdReal * simdReal -> simdReal
      val andb : simdReal * simdReal -> simdReal
      val orb : simdReal * simdReal -> simdReal
      val xorb : simdReal * simdReal -> simdReal
      val andnb : simdReal * simdReal -> simdReal
      val hadd : simdReal * simdReal -> simdReal
      val hsub : simdReal * simdReal -> simdReal
      val addsub : simdReal * simdReal -> simdReal
      val shuffle : simdReal * simdReal * Primitive.Word8.word -> simdReal
      val cmp : simdReal * simdReal * Primitive.Word8.word -> simdReal
      val sqrt : simdReal -> simdReal
(*      val fromArray : elt array -> simdReal
      val toArray : elt array * simdReal -> unit*)
      val fromScalar : elt -> simdReal
      val toScalar : simdReal -> elt
   end
signature PRIM_SIMD_WORD =
   sig
      val vecSize : Primitive.Int32.int
      val wordSize : Primitive.Int32.int
      type t 
      type simdWord(* = t*)
      type elt
      val add:simdWord * simdWord -> simdWord (* b w d q *)
      val adds:simdWord * simdWord -> simdWord (* b w *)
      val addus:simdWord * simdWord -> simdWord (* b w *)
      val sub:simdWord * simdWord -> simdWord (* b w d q *)
      val subs:simdWord * simdWord -> simdWord (* b w *)
      val subus:simdWord * simdWord -> simdWord (* b w *)
      val minu:simdWord * simdWord -> simdWord (* w, if sse4.1 then + b d *)
      val min:simdWord * simdWord -> simdWord (* b, if sse4.1 then + w d *)
      val maxu:simdWord * simdWord -> simdWord (* w, if sse4.1 then + b d *)
      val max:simdWord * simdWord -> simdWord (* b, if sse4.1 then + w d *)

      val mulshi:simdWord * simdWord -> simdWord (*multiply t*t and take low bytes of t2 results*)
      val muluhi:simdWord * simdWord -> simdWord (*multiply t*t and take low bytes of t2 results*)
      val mull:simdWord * simdWord -> simdWord (*multiply t*t and take higt bytes of t2 results*)
(*      val mul32:simdWord * simdWord -> simdWord2 (*multiply odd elements of t,t and return t2 result*)*)
      val hsub:simdWord * simdWord -> simdWord
      val abs:t->t
      (*bitwise*)
      val andb:simdWord * simdWord -> simdWord
      val orb: simdWord * simdWord -> simdWord
      val xorb:simdWord * simdWord -> simdWord
      val andnb:simdWord * simdWord -> simdWord
      (*sa=arathmatic shift(preserve sign) sl=logical shift(fill w/zeros*)
      val sar:simdWord * simdWord -> simdWord
      val slr:simdWord * simdWord -> simdWord
      val sll:simdWord * simdWord -> simdWord
      val sari:simdWord * Primitive.Word8.word -> simdWord
      val slri:simdWord * Primitive.Word8.word -> simdWord
      val slli:simdWord * Primitive.Word8.word -> simdWord
      (*we can also logically shift a full 128bit vector left/right*)
      (*Comparison*)
      (*this is all we get for builtin integer comparison*)
      val cmpeq:simdWord * simdWord -> simdWord
      val cmpgt:simdWord * simdWord -> simdWord
   (*so i'll need to write these myself
    *vcmpne(!=),vcmpgep(= | >),vcmplt(!(> | =)),vcmple(!>)
    *vcmpngt(!>),vcmpnge(!(= | >)),vcmpnlt(> | =),vcmpnle(>)*)
end
(*(defun make_simd_struct (name simdSize realSize)
(insert (format 
"\nstructure %s : PRIM_SIMD_REAL =
  struct
    open  %s
    
    val vecSize : Int32.int = %d
    val realSize : Int32.int = %d

    type elt = Real%d.real

      val add = _prim \"%s_add\": simd * simd -> simd
      val sub = _prim \"%s_sub\": simd * simd -> simd
      val mul = _prim \"%s_mul\": simd * simd -> simd
      val div = _prim \"%s_div\": simd * simd -> simd
      val min = _prim \"%s_min\": simd * simd -> simd
      val max = _prim \"%s_max\": simd * simd -> simd
      val andb = _prim \"%s_andb\": simd * simd -> simd
      val orb = _prim \"%s_orb\": simd * simd -> simd
      val andnb = _prim \"%s_andnb\": simd * simd -> simd
      val hadd = _prim \"%s_hadd\": simd * simd -> simd
      val hsub = _prim \"%s_hsub\": simd * simd -> simd
      val addsub = _prim \"%s_addsub\": simd * simd -> simd
      val sqrt = _prim \"%s_sqrt\": simd -> simd
      val fromArray = _prim \"%s_fromArray\": elt array -> simd
      val toArray = _prim \"%s_toArray\": simd -> elem array
      val fromScalar = _prim \"%s_fromScalar\": e -> simd
      val toScalar = _prim \"%s_toScalar\": simd -> e
  end"
name name simdSize realSize realSize name name name name name name name name
name name name name name name name name name)))*)
structure Primitive = struct

open Primitive

structure Simd128_Real32 : PRIM_SIMD_REAL =
  struct
    open  Simd128_Real32
    
    val vecSize : Int32.int = 128
    val realSize : Int32.int = 32

    type elt = Real32.real
(*    type simd = t*)

      val add = _prim "Simd128_Real32_add": simdReal * simdReal -> simdReal ;
      val addsub = _prim "Simd128_Real32_addsub": simdReal * simdReal -> simdReal ;
      val andb = _prim "Simd128_Real32_andb": simdReal * simdReal -> simdReal ;
      val andnb = _prim "Simd128_Real32_andnotb": simdReal * simdReal -> simdReal ;
      val cmp = _prim "Simd128_Real32_cmp": simdReal * simdReal * Word8.word -> simdReal ;
      val div = _prim "Simd128_Real32_div": simdReal * simdReal -> simdReal ;
(*      val fromArray = _prim "Simd128_Real32_load": elt array -> simdReal ;*)
      val fromScalar = _prim "Simd128_Real32_loads": elt -> simdReal ;
      val hadd = _prim "Simd128_Real32_hadd": simdReal * simdReal -> simdReal ;
      val hsub = _prim "Simd128_Real32_hsub": simdReal * simdReal -> simdReal ;
      val max = _prim "Simd128_Real32_max": simdReal * simdReal -> simdReal ;
      val min = _prim "Simd128_Real32_min": simdReal * simdReal -> simdReal ;
      val mul = _prim "Simd128_Real32_mul": simdReal * simdReal -> simdReal ;
      val orb = _prim "Simd128_Real32_orb": simdReal * simdReal -> simdReal ;
      val shuffle = _prim "Simd128_Real32_shuffle": simdReal * simdReal * Word8.word -> simdReal ;
      val sqrt = _prim "Simd128_Real32_sqrt": simdReal -> simdReal ;
      val sub = _prim "Simd128_Real32_sub": simdReal * simdReal -> simdReal ;
(*      val toArray = _prim "Simd128_Real32_store": elt array * simdReal -> unit;*)
      val toScalar = _prim "Simd128_Real32_stores": simdReal -> elt ;
      val xorb = _prim "Simd128_Real32_xorb": simdReal * simdReal -> simdReal ;
  end
structure Simd128_Real64 : PRIM_SIMD_REAL =
  struct
    open  Simd128_Real64
    
    val vecSize : Int32.int = 128
    val realSize : Int32.int = 64

    type elt = Real64.real
(*    type simdReal = t*)

      val add = _prim "Simd128_Real64_add": simdReal * simdReal -> simdReal ;
      val addsub = _prim "Simd128_Real64_addsub": simdReal * simdReal -> simdReal ;
      val andb = _prim "Simd128_Real64_andb": simdReal * simdReal -> simdReal ;
      val andnb = _prim "Simd128_Real64_andnotb": simdReal * simdReal -> simdReal ;
      val cmp = _prim "Simd128_Real64_cmp": simdReal * simdReal * Word8.word -> simdReal ;
      val div = _prim "Simd128_Real64_div": simdReal * simdReal -> simdReal ;
(*      val fromArray = _prim "Simd128_Real64_load": elt array -> simdReal ;*)
      val fromScalar = _prim "Simd128_Real64_loads": elt -> simdReal ;
      val hadd = _prim "Simd128_Real64_hadd": simdReal * simdReal -> simdReal ;
      val hsub = _prim "Simd128_Real64_hsub": simdReal * simdReal -> simdReal ;
      val max = _prim "Simd128_Real64_max": simdReal * simdReal -> simdReal ;
      val min = _prim "Simd128_Real64_min": simdReal * simdReal -> simdReal ;
      val mul = _prim "Simd128_Real64_mul": simdReal * simdReal -> simdReal ;
      val orb = _prim "Simd128_Real64_orb": simdReal * simdReal -> simdReal ;
      val shuffle = _prim "Simd128_Real64_shuffle": simdReal * simdReal * Word8.word -> simdReal ;
      val sqrt = _prim "Simd128_Real64_sqrt": simdReal -> simdReal ;
      val sub = _prim "Simd128_Real64_sub": simdReal * simdReal -> simdReal ;
(*      val toArray = _prim "Simd128_Real64_store": elt array * simdReal -> unit;*)
      val toScalar = _prim "Simd128_Real64_stores": simdReal -> elt ;
      val xorb = _prim "Simd128_Real64_xorb": simdReal * simdReal -> simdReal ;
  end
structure Simd256_Real32 : PRIM_SIMD_REAL =
  struct
    open  Simd256_Real32
    
    val vecSize : Int32.int = 256
    val realSize : Int32.int = 32

    type elt = Real32.real
(*    type simd = t*)

      val add = _prim "Simd256_Real32_add":simdReal * simdReal -> simdReal ;
      val addsub = _prim "Simd256_Real32_addsub":simdReal * simdReal -> simdReal ;
      val andb = _prim "Simd256_Real32_andb":simdReal * simdReal -> simdReal ;
      val andnb = _prim "Simd256_Real32_andnotb":simdReal * simdReal -> simdReal ;
      val cmp = _prim "Simd256_Real32_cmp": simdReal * simdReal * Word8.word -> simdReal ;
      val div = _prim "Simd256_Real32_div":simdReal * simdReal -> simdReal ;
(*      val fromArray = _prim "Simd256_Real32_load": elt array -> simdReal ;*)
      val fromScalar = _prim "Simd256_Real32_loads": elt -> simdReal ;
      val hadd = _prim "Simd256_Real32_hadd":simdReal * simdReal -> simdReal ;
      val hsub = _prim "Simd256_Real32_hsub":simdReal * simdReal -> simdReal ;
      val max = _prim "Simd256_Real32_max":simdReal * simdReal -> simdReal ;
      val min = _prim "Simd256_Real32_min":simdReal * simdReal -> simdReal ;
      val mul = _prim "Simd256_Real32_mul":simdReal * simdReal -> simdReal ;
      val orb = _prim "Simd256_Real32_orb":simdReal * simdReal -> simdReal ;
      val shuffle = _prim "Simd256_Real32_shuffle": simdReal * simdReal * Word8.word -> simdReal ;
      val sqrt = _prim "Simd256_Real32_sqrt":simdReal -> simdReal ;
      val sub = _prim "Simd256_Real32_sub":simdReal * simdReal -> simdReal ;
(*      val toArray = _prim "Simd256_Real32_store": elt array * simdReal -> unit;*)
      val toScalar = _prim "Simd256_Real32_stores": simdReal -> elt ;
      val xorb = _prim "Simd256_Real32_xorb":simdReal * simdReal -> simdReal;
  end
structure Simd256_Real64 : PRIM_SIMD_REAL =
  struct
    open  Simd256_Real64
    
    val vecSize : Int32.int = 256
    val realSize : Int32.int = 64

    type elt = Real64.real
(*    type simdReal = t*)

      val add = _prim "Simd256_Real64_add": simdReal * simdReal -> simdReal ;
      val addsub = _prim "Simd256_Real64_addsub": simdReal * simdReal -> simdReal ;
      val andb = _prim "Simd256_Real64_andb": simdReal * simdReal -> simdReal ;
      val andnb = _prim "Simd256_Real64_andnotb": simdReal * simdReal -> simdReal ;
      val cmp = _prim "Simd256_Real64_cmp": simdReal * simdReal * Word8.word -> simdReal ;
      val div = _prim "Simd256_Real64_div": simdReal * simdReal -> simdReal ;
(*      val fromArray = _prim "Simd256_Real64_load": elt array -> simdReal ;*)
      val fromScalar = _prim "Simd256_Real64_loads": elt -> simdReal ;
      val hadd = _prim "Simd256_Real64_hadd": simdReal * simdReal -> simdReal ;
      val hsub = _prim "Simd256_Real64_hsub": simdReal * simdReal -> simdReal ;
      val max = _prim "Simd256_Real64_max": simdReal * simdReal -> simdReal ;
      val min = _prim "Simd256_Real64_min": simdReal * simdReal -> simdReal ;
      val mul = _prim "Simd256_Real64_mul": simdReal * simdReal -> simdReal ;
      val orb = _prim "Simd256_Real64_orb": simdReal * simdReal -> simdReal ;
      val shuffle = _prim "Simd256_Real64_shuffle": simdReal * simdReal * Word8.word -> simdReal ;
      val sqrt = _prim "Simd256_Real64_sqrt": simdReal -> simdReal ;
      val sub = _prim "Simd256_Real64_sub": simdReal * simdReal -> simdReal ;
(*      val toArray = _prim "Simd256_Real64_store": elt array * simdReal -> unit;*)
      val toScalar = _prim "Simd256_Real64_stores": simdReal -> elt ;
      val xorb = _prim "Simd256_Real64_xorb": simdReal * simdReal -> simdReal ;
  end

(*(defun make_simd_struct (x n m)
  (insert (format"
structure %s : PRIM_SIMD_WORD =
   struct
      open %s
      val vecSize : Int32.int = %d
      val wordSize : Int32.int = %d

      type elt = Word%d.word
      val add = _prim \"%s_add\": simdWord * simdWord -> simdWord; (* b w d q *)
      val adds = _prim \"%s_adds\": simdWord * simdWord -> simdWord; (* b w *)
      val addus = _prim \"%s_addus\": simdWord * simdWord -> simdWord; (* b w *)
      val sub = _prim \"%s_sub\": simdWord * simdWord -> simdWord; (* b w d q *)
      val subs = _prim \"%s_subs\": simdWord * simdWord -> simdWord; (* b w *)
      val subus = _prim \"%s_subus\": simdWord * simdWord -> simdWord; (* b w *)
      val minu = _prim \"%s_minu\": simdWord * simdWord -> simdWord; (* w, if sse4.1 then + b d *)
      val min = _prim \"%s_min\": simdWord * simdWord -> simdWord; (* b, if sse4.1 then + w d *)
      val maxu = _prim \"%s_maxu\": simdWord * simdWord -> simdWord; (* w, if sse4.1 then + b d *)
      val max = _prim \"%s_max\": simdWord * simdWord -> simdWord; (* b, if sse4.1 then + w d *)

      val mulshi = _prim \"%s_mulshi\": simdWord * simdWord -> simdWord; (*mul signed high, w*)
      val muluhi = _prim \"%s_muluhi\": simdWord * simdWord -> simdWord; (*mul unsigned high w*)
      val mullo = _prim \"%s_mullo\": simdWord * simdWord -> simdWord; (*mul low, w*)
      val mul32 = _prim \"%s_mul32\": simdWord * simdWord -> simdWord2; (*multiply odd elements of t,t and return t2 result, d*)
      val hsub = _prim \"%s_hsub\": simdWord * simdWord -> simdWord;(*w d*)
      val hadd = _prim \"%s_hadd\": simdWord * simdWord -> simdWord;(*w d*)
      val abs = _prim \"%s_abs\": simdWord -> simdWord;(*b w*)
      (*bitwise*)
      val andb = _prim \"%s_andb\": simdWord * simdWord -> simdWord;(*all*)
      val orb = _prim \"%s_orb\":  simdWord * simdWord -> simdWord;(*all*)
      val xorb = _prim \"%s_xorb\": simdWord * simdWord -> simdWord;(*all*)
      val andnb = _prim \"%s_andnb\": simdWord * simdWord -> simdWord;(*all*)
      (*sa=arathmatic shift(preserve sign) sl=logical shift(fill w/zeros*)
      val sar = _prim \"%s_sar\": simdWord * simdWord -> simdWord;(*w d*)
      val slr = _prim \"%s_slr\": simdWord * simdWord -> simdWord;(*w d q*)
      val sll = _prim \"%s_sll\": simdWord * simdWord -> simdWord;(*w d q*)
      val sari = _prim \"%s_sari\": simdWord * word8 -> simdWord;(*w d*)
      val slri = _prim \"%s_slri\": simdWord * word8 -> simdWord;(*w d q*)
      val slli = _prim \"%s_slli\": simdWord * word8 -> simdWord;(*w d q*)
      (*we can also logically shift a full 128bit vector left/right*)
      (*Comparison*)
      (*this is all we get for builtin integer comparison*)
      val cmpeq = _prim \"%s_cmpeq\": simdWord * simdWord -> simdWord;
      val cmpgt = _prim \"%s_cmpgt\": simdWord * simdWord -> simdWord;

end\n" x x n m m x x x x x x x x x x x x x x x x x x x x x x x x x x x x x)))
(make_simd_struct "Simd128_Word8" 128 8)
(dolist (i '(("Simd128_Word8" 128 8) ("Simd128_Word16" 128 16) 
             ("Simd128_Word32" 128 32)("Simd128_Word64" 128 64)
             ("Simd256_Word8" 256 8) ("Simd256_Word16" 256 16) 
             ("Simd256_Word32" 256 32)("Simd256_Word64" 256 64)))
  (apply #'make_simd_struct i))*)
(* local
   fun unimp (name,size) =
       concat ["Function ",name," is not implemented for size Word",
               size,"\n"])
 in
structure Simd128_Word8 : PRIM_SIMD_WORD =
   struct
      open Simd128_Word8
      val vecSize : Int32.int = 128
      val wordSize : Int32.int = 8

      type elt = Word8.word
      val add = _prim "Simd128_Word8_add": simdWord * simdWord -> simdWord; (* b w d q *)
      val adds = _prim "Simd128_Word8_adds": simdWord * simdWord -> simdWord; (* b w *)
      val addus = _prim "Simd128_Word8_addus": simdWord * simdWord -> simdWord; (* b w *)
      val sub = _prim "Simd128_Word8_sub": simdWord * simdWord -> simdWord; (* b w d q *)
      val subs = _prim "Simd128_Word8_subs": simdWord * simdWord -> simdWord; (* b w *)
      val subus = _prim "Simd128_Word8_subus": simdWord * simdWord -> simdWord; (* b w *)
      val minu = _prim "Simd128_Word8_minu": simdWord * simdWord -> simdWord; (* w, if sse4.1 then + b d *)
      val min = _prim "Simd128_Word8_min": simdWord * simdWord -> simdWord; (* b, if sse4.1 then + w d *)
      val maxu = _prim "Simd128_Word8_maxu": simdWord * simdWord -> simdWord; (* w, if sse4.1 then + b d *)
      val max = _prim "Simd128_Word8_max": simdWord * simdWord -> simdWord; (* b, if sse4.1 then + w d *)

      val mulshi = raise Fail (unimp("mulshi","8"))
      val muluhi = raise Fail (unimp("muluhi","8"))
      val mullo = raise Fail (unimp("mullo","8"))
      val mul32 = raise Fail (unimp("mul32","8"))
      val hsub =  raise Fail (unimp("hsub","8"))
      val hadd = raise Fail (unimp("hadd","8"))
      val abs = _prim Simd128_Word8: simdWord -> simdWord;(*b w*)

      (*bitwise*)
      val andb = _prim "Simd128_Word8_andb": simdWord * simdWord -> simdWord;(*all*)
      val orb = _prim "Simd128_Word8_orb":  simdWord * simdWord -> simdWord;(*all*)
      val xorb = _prim "Simd128_Word8_xorb": simdWord * simdWord -> simdWord;(*all*)
      val andnb = _prim "Simd128_Word8_andnb": simdWord * simdWord -> simdWord;(*all*)

      (*sa=arathmatic shift(preserve sign) sl=logical shift(fill w/zeros*)
      val sar = raise Fail (unimp("sar","8"))
      val slr = raise Fail (unimp("slr","8"))
      val sll = raise Fail (unimp("sll","8"))
      val sari = raise Fail (unimp("sari","8"))
      val slri = raise Fail (unimp("slri","8"))
      val slli = raise Fail (unimp("slli","8"))

      (*Comparison*)
      (*this is all we get for builtin integer comparison*)
      val cmpeq = _prim "Simd128_Word8_cmpeq": simdWord * simdWord -> simdWord;
      val cmpgt = _prim "Simd128_Word8_cmpgt": simdWord * simdWord -> simdWord;
   end

structure Simd128_Word16 : PRIM_SIMD_WORD =
   struct
      open Simd128_Word16
      val vecSize : Int32.int = 128
      val wordSize : Int32.int = 16

      type elt = Word16.word
      val add = _prim "Simd128_Word16_add": simdWord * simdWord -> simdWord; (* b w d q *)
      val adds = _prim "Simd128_Word16_adds": simdWord * simdWord -> simdWord; (* b w *)
      val addus = _prim "Simd128_Word16_addus": simdWord * simdWord -> simdWord; (* b w *)
      val sub = _prim "Simd128_Word16_sub": simdWord * simdWord -> simdWord; (* b w d q *)
      val subs = _prim "Simd128_Word16_subs": simdWord * simdWord -> simdWord; (* b w *)
      val subus = _prim "Simd128_Word16_subus": simdWord * simdWord -> simdWord; (* b w *)
      val minu = _prim "Simd128_Word16_minu": simdWord * simdWord -> simdWord; (* w, if sse4.1 then + b d *)
      val min = _prim "Simd128_Word16_min": simdWord * simdWord -> simdWord; (* b, if sse4.1 then + w d *)
      val maxu = _prim "Simd128_Word16_maxu": simdWord * simdWord -> simdWord; (* w, if sse4.1 then + b d *)
      val max = _prim "Simd128_Word16_max": simdWord * simdWord -> simdWord; (* b, if sse4.1 then + w d *)

      val mulshi = _prim "Simd128_Word16_mulshi": simdWord * simdWord -> simdWord; (*mul signed high, w*)
      val muluhi = _prim "Simd128_Word16_muluhi": simdWord * simdWord -> simdWord; (*mul unsigned high w*)
      val mullo = _prim "Simd128_Word16_mullo": simdWord * simdWord -> simdWord; (*mul low, w*)
      val mul32 = raise Fail (unimp("mul32","16"))
      val hsub = _prim "Simd128_Word16_hsub": simdWord * simdWord -> simdWord;(*w d*)
      val hadd = _prim "Simd128_Word16_hadd": simdWord * simdWord -> simdWord;(*w d*)
      val abs = _prim "Simd128_Word16_abs": simdWord -> simdWord;(*b w*)
      (*bitwise*)
      val andb = _prim "Simd128_Word16_andb": simdWord * simdWord -> simdWord;(*all*)
      val orb = _prim "Simd128_Word16_orb":  simdWord * simdWord -> simdWord;(*all*)
      val xorb = _prim "Simd128_Word16_xorb": simdWord * simdWord -> simdWord;(*all*)
      val andnb = _prim "Simd128_Word16_andnb": simdWord * simdWord -> simdWord;(*all*)
      (*sa=arathmatic shift(preserve sign) sl=logical shift(fill w/zeros*)
      val sar = _prim "Simd128_Word16_sar": simdWord * simdWord -> simdWord;(*w d*)
      val slr = _prim "Simd128_Word16_slr": simdWord * simdWord -> simdWord;(*w d q*)
      val sll = _prim "Simd128_Word16_sll": simdWord * simdWord -> simdWord;(*w d q*)
      val sari = _prim "Simd128_Word16_sari": simdWord * word8 -> simdWord;(*w d*)
      val slri = _prim "Simd128_Word16_slri": simdWord * word8 -> simdWord;(*w d q*)
      val slli = _prim "Simd128_Word16_slli": simdWord * word8 -> simdWord;(*w d q*)
      (*we can also logically shift a full 128bit vector left/right*)
      (*Comparison*)
      (*this is all we get for builtin integer comparison*)
      val cmpeq = _prim "Simd128_Word16_cmpeq": simdWord * simdWord -> simdWord;
      val cmpgt = _prim "Simd128_Word16_cmpgt": simdWord * simdWord -> simdWord;

end

structure Simd128_Word32 : PRIM_SIMD_WORD =
   struct
      open Simd128_Word32
      val vecSize : Int32.int = 128
      val wordSize : Int32.int = 32

      type elt = Word32.word
      val add = _prim "Simd128_Word32_add": simdWord * simdWord -> simdWord; (* b w d q *)
      val adds = raise Fail (unimp("adds","32"))
      val addus = raise Fail (unimp("addus","32"))
      val sub = _prim "Simd128_Word32_sub": simdWord * simdWord -> simdWord; (* b w d q *)
      val subs = raise Fail (unimp("subs","32"))
      val subus = raise Fail (unimp("subus","32"))
      val minu = _prim "Simd128_Word32_minu": simdWord * simdWord -> simdWord; (* w, if sse4.1 then + b d *)
      val min = _prim "Simd128_Word32_min": simdWord * simdWord -> simdWord; (* b, if sse4.1 then + w d *)
      val maxu = _prim "Simd128_Word32_maxu": simdWord * simdWord -> simdWord; (* w, if sse4.1 then + b d *)
      val max = _prim "Simd128_Word32_max": simdWord * simdWord -> simdWord; (* b, if sse4.1 then + w d *)

      val mulshi = raise Fail (unimp("mulshi","32"))
      val muluhi = raise Fail (unimp("muluhi","32"))
      val mullo = raise Fail (unimp("mullo","32"))
      val mul32 = _prim "Simd128_Word32_mul32": simdWord * simdWord -> simdWord2; (*multiply odd elements of t,t and return t2 result, d*)
      val hsub = _prim "Simd128_Word32_hsub": simdWord * simdWord -> simdWord;(*w d*)
      val hadd = _prim "Simd128_Word32_hadd": simdWord * simdWord -> simdWord;(*w d*)
      val abs = raise Fail (unimp("abs","32"))
      (*bitwise*)
      val andb = _prim "Simd128_Word32_andb": simdWord * simdWord -> simdWord;(*all*)
      val orb = _prim "Simd128_Word32_orb":  simdWord * simdWord -> simdWord;(*all*)
      val xorb = _prim "Simd128_Word32_xorb": simdWord * simdWord -> simdWord;(*all*)
      val andnb = _prim "Simd128_Word32_andnb": simdWord * simdWord -> simdWord;(*all*)
      (*sa=arathmatic shift(preserve sign) sl=logical shift(fill w/zeros*)
      val sar = _prim "Simd128_Word32_sar": simdWord * simdWord -> simdWord;(*w d*)
      val slr = _prim "Simd128_Word32_slr": simdWord * simdWord -> simdWord;(*w d q*)
      val sll = _prim "Simd128_Word32_sll": simdWord * simdWord -> simdWord;(*w d q*)
      val sari = _prim "Simd128_Word32_sari": simdWord * word8 -> simdWord;(*w d*)
      val slri = _prim "Simd128_Word32_slri": simdWord * word8 -> simdWord;(*w d q*)
      val slli = _prim "Simd128_Word32_slli": simdWord * word8 -> simdWord;(*w d q*)
      (*we can also logically shift a full 128bit vector left/right*)
      (*Comparison*)
      (*this is all we get for builtin integer comparison*)
      val cmpeq = _prim "Simd128_Word32_cmpeq": simdWord * simdWord -> simdWord;
      val cmpgt = _prim "Simd128_Word32_cmpgt": simdWord * simdWord -> simdWord;

end

structure Simd128_Word64 : PRIM_SIMD_WORD =
   struct
      open Simd128_Word64
      val vecSize : Int32.int = 128
      val wordSize : Int32.int = 64

      type elt = Word64.word

      val add = _prim "Simd128_Word64_add": simdWord * simdWord -> simdWord; (* b w d q *)
      val adds = raise Fail (unimp("abbs","64"))
      val addus = raise Fail (unimp("abbus","64"))
      val sub = _prim "Simd128_Word64_sub": simdWord * simdWord -> simdWord; (* b w d q *)
      val subs = raise Fail (unimp("subs","64"))
      val subus = raise Fail (unimp("subus","64"))
      val minu = raise Fail (unimp("minu","64"))
      val min = raise Fail (unimp("min","64"))
      val maxu = raise Fail (unimp("maxu","64"))
      val max = raise Fail (unimp("max","64"))

      val mulshi = raise Fail (unimp("mulshi","64"))
      val muluhi = raise Fail (unimp("muluhi","64"))
      val mullo = raise Fail (unimp("mullo","64"))
      val mul32 = raise Fail (unimp("mul32","64"))
      val hsub = raise Fail (unimp("hsub","64"))
      val hadd = raise Fail (unimp("hadd","64"))
      val abs = raise Fail (unimp("abs","64"))
      (*bitwise*)
      val andb = _prim "Simd128_Word64_andb": simdWord * simdWord -> simdWord;(*all*)
      val orb = _prim "Simd128_Word64_orb":  simdWord * simdWord -> simdWord;(*all*)
      val xorb = _prim "Simd128_Word64_xorb": simdWord * simdWord -> simdWord;(*all*)
      val andnb = _prim "Simd128_Word64_andnb": simdWord * simdWord -> simdWord;(*all*)
      (*sa=arathmatic shift(preserve sign) sl=logical shift(fill w/zeros*)
      val sar = raise Fail (unimp("sar","64"))
      val slr = _prim "Simd128_Word64_slr": simdWord * simdWord -> simdWord;(*w d q*)
      val sll = _prim "Simd128_Word64_sll": simdWord * simdWord -> simdWord;(*w d q*)
      val sari = raise Fail (unimp("sari","64"))
      val slri = _prim "Simd128_Word64_slri": simdWord * word8 -> simdWord;(*w d q*)
      val slli = _prim "Simd128_Word64_slli": simdWord * word8 -> simdWord;(*w d q*)
      (*we can also logically shift a full 128bit vector left/right*)
      (*Comparison*)
      (*this is all we get for builtin integer comparison*)
      val cmpeq = _prim "Simd128_Word64_cmpeq": simdWord * simdWord -> simdWord;
      val cmpgt = _prim "Simd128_Word64_cmpgt": simdWord * simdWord -> simdWord;
end
structure Simd256_Word8 : PRIM_SIMD_WORD =
   struct
      open Simd256_Word8
      val vecSize : Int32.int = 256
      val wordSize : Int32.int = 8

      type elt = Word8.word
      val add = _prim "Simd256_Word8_add": simdWord * simdWord -> simdWord; (* b w d q *)
      val adds = _prim "Simd256_Word8_adds": simdWord * simdWord -> simdWord; (* b w *)
      val addus = _prim "Simd256_Word8_addus": simdWord * simdWord -> simdWord; (* b w *)
      val sub = _prim "Simd256_Word8_sub": simdWord * simdWord -> simdWord; (* b w d q *)
      val subs = _prim "Simd256_Word8_subs": simdWord * simdWord -> simdWord; (* b w *)
      val subus = _prim "Simd256_Word8_subus": simdWord * simdWord -> simdWord; (* b w *)
      val minu = _prim "Simd256_Word8_minu": simdWord * simdWord -> simdWord; (* w, if sse4.1 then + b d *)
      val min = _prim "Simd256_Word8_min": simdWord * simdWord -> simdWord; (* b, if sse4.1 then + w d *)
      val maxu = _prim "Simd256_Word8_maxu": simdWord * simdWord -> simdWord; (* w, if sse4.1 then + b d *)
      val max = _prim "Simd256_Word8_max": simdWord * simdWord -> simdWord; (* b, if sse4.1 then + w d *)

      val mulshi = raise Fail (unimp("mulshi","8"))
      val muluhi = raise Fail (unimp("muluhi","8"))
      val mullo = raise Fail (unimp("mullo","8"))
      val mul32 = raise Fail (unimp("mul32","8"))
      val hsub =  raise Fail (unimp("hsub","8"))
      val hadd = raise Fail (unimp("hadd","8"))
      val abs = _prim Simd256_Word8: simdWord -> simdWord;(*b w*)

      (*bitwise*)
      val andb = _prim "Simd256_Word8_andb": simdWord * simdWord -> simdWord;(*all*)
      val orb = _prim "Simd256_Word8_orb":  simdWord * simdWord -> simdWord;(*all*)
      val xorb = _prim "Simd256_Word8_xorb": simdWord * simdWord -> simdWord;(*all*)
      val andnb = _prim "Simd256_Word8_andnb": simdWord * simdWord -> simdWord;(*all*)

      (*sa=arathmatic shift(preserve sign) sl=logical shift(fill w/zeros*)
      val sar = raise Fail (unimp("sar","8"))
      val slr = raise Fail (unimp("slr","8"))
      val sll = raise Fail (unimp("sll","8"))
      val sari = raise Fail (unimp("sari","8"))
      val slri = raise Fail (unimp("slri","8"))
      val slli = raise Fail (unimp("slli","8"))

      (*Comparison*)
      (*this is all we get for builtin integer comparison*)
      val cmpeq = _prim "Simd256_Word8_cmpeq": simdWord * simdWord -> simdWord;
      val cmpgt = _prim "Simd256_Word8_cmpgt": simdWord * simdWord -> simdWord;
   end

structure Simd256_Word16 : PRIM_SIMD_WORD =
   struct
      open Simd256_Word16
      val vecSize : Int32.int = 256
      val wordSize : Int32.int = 16

      type elt = Word16.word
      val add = _prim "Simd256_Word16_add": simdWord * simdWord -> simdWord; (* b w d q *)
      val adds = _prim "Simd256_Word16_adds": simdWord * simdWord -> simdWord; (* b w *)
      val addus = _prim "Simd256_Word16_addus": simdWord * simdWord -> simdWord; (* b w *)
      val sub = _prim "Simd256_Word16_sub": simdWord * simdWord -> simdWord; (* b w d q *)
      val subs = _prim "Simd256_Word16_subs": simdWord * simdWord -> simdWord; (* b w *)
      val subus = _prim "Simd256_Word16_subus": simdWord * simdWord -> simdWord; (* b w *)
      val minu = _prim "Simd256_Word16_minu": simdWord * simdWord -> simdWord; (* w, if sse4.1 then + b d *)
      val min = _prim "Simd256_Word16_min": simdWord * simdWord -> simdWord; (* b, if sse4.1 then + w d *)
      val maxu = _prim "Simd256_Word16_maxu": simdWord * simdWord -> simdWord; (* w, if sse4.1 then + b d *)
      val max = _prim "Simd256_Word16_max": simdWord * simdWord -> simdWord; (* b, if sse4.1 then + w d *)

      val mulshi = _prim "Simd256_Word16_mulshi": simdWord * simdWord -> simdWord; (*mul signed high, w*)
      val muluhi = _prim "Simd256_Word16_muluhi": simdWord * simdWord -> simdWord; (*mul unsigned high w*)
      val mullo = _prim "Simd256_Word16_mullo": simdWord * simdWord -> simdWord; (*mul low, w*)
      val mul32 = raise Fail (unimp("mul32","16"))
      val hsub = _prim "Simd256_Word16_hsub": simdWord * simdWord -> simdWord;(*w d*)
      val hadd = _prim "Simd256_Word16_hadd": simdWord * simdWord -> simdWord;(*w d*)
      val abs = _prim "Simd256_Word16_abs": simdWord -> simdWord;(*b w*)
      (*bitwise*)
      val andb = _prim "Simd256_Word16_andb": simdWord * simdWord -> simdWord;(*all*)
      val orb = _prim "Simd256_Word16_orb":  simdWord * simdWord -> simdWord;(*all*)
      val xorb = _prim "Simd256_Word16_xorb": simdWord * simdWord -> simdWord;(*all*)
      val andnb = _prim "Simd256_Word16_andnb": simdWord * simdWord -> simdWord;(*all*)
      (*sa=arathmatic shift(preserve sign) sl=logical shift(fill w/zeros*)
      val sar = _prim "Simd256_Word16_sar": simdWord * simdWord -> simdWord;(*w d*)
      val slr = _prim "Simd256_Word16_slr": simdWord * simdWord -> simdWord;(*w d q*)
      val sll = _prim "Simd256_Word16_sll": simdWord * simdWord -> simdWord;(*w d q*)
      val sari = _prim "Simd256_Word16_sari": simdWord * word8 -> simdWord;(*w d*)
      val slri = _prim "Simd256_Word16_slri": simdWord * word8 -> simdWord;(*w d q*)
      val slli = _prim "Simd256_Word16_slli": simdWord * word8 -> simdWord;(*w d q*)
      (*we can also logically shift a full 256bit vector left/right*)
      (*Comparison*)
      (*this is all we get for builtin integer comparison*)
      val cmpeq = _prim "Simd256_Word16_cmpeq": simdWord * simdWord -> simdWord;
      val cmpgt = _prim "Simd256_Word16_cmpgt": simdWord * simdWord -> simdWord;

end

structure Simd256_Word32 : PRIM_SIMD_WORD =
   struct
      open Simd256_Word32
      val vecSize : Int32.int = 256
      val wordSize : Int32.int = 32

      type elt = Word32.word
      val add = _prim "Simd256_Word32_add": simdWord * simdWord -> simdWord; (* b w d q *)
      val adds = raise Fail (unimp("adds","32"))
      val addus = raise Fail (unimp("addus","32"))
      val sub = _prim "Simd256_Word32_sub": simdWord * simdWord -> simdWord; (* b w d q *)
      val subs = raise Fail (unimp("subs","32"))
      val subus = raise Fail (unimp("subus","32"))
      val minu = _prim "Simd256_Word32_minu": simdWord * simdWord -> simdWord; (* w, if sse4.1 then + b d *)
      val min = _prim "Simd256_Word32_min": simdWord * simdWord -> simdWord; (* b, if sse4.1 then + w d *)
      val maxu = _prim "Simd256_Word32_maxu": simdWord * simdWord -> simdWord; (* w, if sse4.1 then + b d *)
      val max = _prim "Simd256_Word32_max": simdWord * simdWord -> simdWord; (* b, if sse4.1 then + w d *)

      val mulshi = raise Fail (unimp("mulshi","32"))
      val muluhi = raise Fail (unimp("muluhi","32"))
      val mullo = raise Fail (unimp("mullo","32"))
      val mul32 = _prim "Simd256_Word32_mul32": simdWord * simdWord -> simdWord2; (*multiply odd elements of t,t and return t2 result, d*)
      val hsub = _prim "Simd256_Word32_hsub": simdWord * simdWord -> simdWord;(*w d*)
      val hadd = _prim "Simd256_Word32_hadd": simdWord * simdWord -> simdWord;(*w d*)
      val abs = raise Fail (unimp("abs","32"))
      (*bitwise*)
      val andb = _prim "Simd256_Word32_andb": simdWord * simdWord -> simdWord;(*all*)
      val orb = _prim "Simd256_Word32_orb":  simdWord * simdWord -> simdWord;(*all*)
      val xorb = _prim "Simd256_Word32_xorb": simdWord * simdWord -> simdWord;(*all*)
      val andnb = _prim "Simd256_Word32_andnb": simdWord * simdWord -> simdWord;(*all*)
      (*sa=arathmatic shift(preserve sign) sl=logical shift(fill w/zeros*)
      val sar = _prim "Simd256_Word32_sar": simdWord * simdWord -> simdWord;(*w d*)
      val slr = _prim "Simd256_Word32_slr": simdWord * simdWord -> simdWord;(*w d q*)
      val sll = _prim "Simd256_Word32_sll": simdWord * simdWord -> simdWord;(*w d q*)
      val sari = _prim "Simd256_Word32_sari": simdWord * word8 -> simdWord;(*w d*)
      val slri = _prim "Simd256_Word32_slri": simdWord * word8 -> simdWord;(*w d q*)
      val slli = _prim "Simd256_Word32_slli": simdWord * word8 -> simdWord;(*w d q*)
      (*we can also logically shift a full 256bit vector left/right*)
      (*Comparison*)
      (*this is all we get for builtin integer comparison*)
      val cmpeq = _prim "Simd256_Word32_cmpeq": simdWord * simdWord -> simdWord;
      val cmpgt = _prim "Simd256_Word32_cmpgt": simdWord * simdWord -> simdWord;

end

structure Simd256_Word64 : PRIM_SIMD_WORD =
   struct
      open Simd256_Word64
      val vecSize : Int32.int = 256
      val wordSize : Int32.int = 64

      type elt = Word64.word

      val add = _prim "Simd256_Word64_add": simdWord * simdWord -> simdWord; (* b w d q *)
      val adds = raise Fail (unimp("abbs","64"))
      val addus = raise Fail (unimp("abbus","64"))
      val sub = _prim "Simd256_Word64_sub": simdWord * simdWord -> simdWord; (* b w d q *)
      val subs = raise Fail (unimp("subs","64"))
      val subus = raise Fail (unimp("subus","64"))
      val minu = raise Fail (unimp("minu","64"))
      val min = raise Fail (unimp("min","64"))
      val maxu = raise Fail (unimp("maxu","64"))
      val max = raise Fail (unimp("max","64"))

      val mulshi = raise Fail (unimp("mulshi","64"))
      val muluhi = raise Fail (unimp("muluhi","64"))
      val mullo = raise Fail (unimp("mullo","64"))
      val mul32 = raise Fail (unimp("mul32","64"))
      val hsub = raise Fail (unimp("hsub","64"))
      val hadd = raise Fail (unimp("hadd","64"))
      val abs = raise Fail (unimp("abs","64"))
      (*bitwise*)
      val andb = _prim "Simd256_Word64_andb": simdWord * simdWord -> simdWord;(*all*)
      val orb = _prim "Simd256_Word64_orb":  simdWord * simdWord -> simdWord;(*all*)
      val xorb = _prim "Simd256_Word64_xorb": simdWord * simdWord -> simdWord;(*all*)
      val andnb = _prim "Simd256_Word64_andnb": simdWord * simdWord -> simdWord;(*all*)
      (*sa=arathmatic shift(preserve sign) sl=logical shift(fill w/zeros*)
      val sar = raise Fail (unimp("sar","64"))
      val slr = _prim "Simd256_Word64_slr": simdWord * simdWord -> simdWord;(*w d q*)
      val sll = _prim "Simd256_Word64_sll": simdWord * simdWord -> simdWord;(*w d q*)
      val sari = raise Fail (unimp("sari","64"))
      val slri = _prim "Simd256_Word64_slri": simdWord * word8 -> simdWord;(*w d q*)
      val slli = _prim "Simd256_Word64_slli": simdWord * word8 -> simdWord;(*w d q*)
      (*we can also logically shift a full 256bit vector left/right*)
      (*Comparison*)
      (*this is all we get for builtin integer comparison*)
      val cmpeq = _prim "Simd256_Word64_cmpeq": simdWord * simdWord -> simdWord;
      val cmpgt = _prim "Simd256_Word64_cmpgt": simdWord * simdWord -> simdWord;
end
end*)
end
