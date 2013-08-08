(* Copyright (C) 2013 Tucker DiNapoli
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)
(*Note: need to ask about casting b/t real array and word8 array*)
(*NOTE: change type simd to simdReal to fix type errors*)
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
(*      val shuffle : simdReal * simdReal -> simdReal
      val cmp : simdReal * simdReal * Primitive.Word8.word -> simdReal*)
      val sqrt : simdReal -> simdReal
(*      val fromArray : elt array -> simd
(*
 cast array to a word 8 array then
 load from word8 array using Word8Array_subSimdReal *)
      val toArray : elt array * simd -> unit*)
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
      val add : simdWord * simdWord -> simdWord
      val sub : simdWord * simdWord -> simdWord
      val mul : simdWord * simdWord -> simdWord
      val div : simdWord * simdWord -> simdWord
      val min : simdWord * simdWord -> simdWord
      val max : simdWord * simdWord -> simdWord
      val andb : simdWord * simdWord -> simdWord
      val orb : simdWord * simdWord -> simdWord
      val xorb : simdWord * simdWord -> simdWord
      val andnb : simdWord * simdWord -> simdWord
      val hadd : simdWord * simdWord -> simdWord
      val hsub : simdWord * simdWord -> simdWord
      val addsub : simdWord * simdWord -> simdWord
      val sqrt : simdWord -> simdWord
(*      val fromArray : elt array -> simd
(*
 cast array to a word 8 array then
 load from word8 array using Word8Array_subSimdWord *)
      val toArray : elt array * simd -> unit*)
      val fromScalar : elt -> simdWord
      val toScalar : simdWord -> elt
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
      val sub = _prim "Simd128_Real32_sub": simdReal * simdReal -> simdReal ;
      val mul = _prim "Simd128_Real32_mul": simdReal * simdReal -> simdReal ;
      val div = _prim "Simd128_Real32_div": simdReal * simdReal -> simdReal ;
      val min = _prim "Simd128_Real32_min": simdReal * simdReal -> simdReal ;
      val max = _prim "Simd128_Real32_max": simdReal * simdReal -> simdReal ;
      val andb = _prim "Simd128_Real32_andb": simdReal * simdReal -> simdReal ;
      val orb = _prim "Simd128_Real32_orb": simdReal * simdReal -> simdReal ;
      val xorb = _prim "Simd128_Real32_xorb": simdReal * simdReal -> simdReal ;
      val andnb = _prim "Simd128_Real32_andnotb": simdReal * simdReal -> simdReal ;
      val hadd = _prim "Simd128_Real32_hadd": simdReal * simdReal -> simdReal ;
      val hsub = _prim "Simd128_Real32_hsub": simdReal * simdReal -> simdReal ;
      val addsub = _prim "Simd128_Real32_addsub": simdReal * simdReal -> simdReal ;
      val sqrt = _prim "Simd128_Real32_sqrt": simdReal -> simdReal ;
(*      val fromArray = _prim "Simd128_Real32_fromArray": elt array -> simdReal ;
      val toArray = _prim "Simd128_Real32_toArray": simdReal -> elt array ;*)
      val fromScalar = _prim "Simd128_Real32_loads": elt -> simdReal ;
      val toScalar = _prim "Simd128_Real32_stores": simdReal -> elt ;
  end
structure Simd128_Real64 : PRIM_SIMD_REAL =
  struct
    open  Simd128_Real64
    
    val vecSize : Int32.int = 128
    val realSize : Int32.int = 64

    type elt = Real64.real
(*    type simdReal = t*)

      val add = _prim "Simd128_Real64_add": simdReal * simdReal -> simdReal ;
      val sub = _prim "Simd128_Real64_sub": simdReal * simdReal -> simdReal ;
      val mul = _prim "Simd128_Real64_mul": simdReal * simdReal -> simdReal ;
      val div = _prim "Simd128_Real64_div": simdReal * simdReal -> simdReal ;
      val min = _prim "Simd128_Real64_min": simdReal * simdReal -> simdReal ;
      val max = _prim "Simd128_Real64_max": simdReal * simdReal -> simdReal ;
      val andb = _prim "Simd128_Real64_andb": simdReal * simdReal -> simdReal ;
      val orb = _prim "Simd128_Real64_orb": simdReal * simdReal -> simdReal ;
      val xorb = _prim "Simd128_Real64_xorb": simdReal * simdReal -> simdReal ;
      val andnb = _prim "Simd128_Real64_andnotb": simdReal * simdReal -> simdReal ;
      val hadd = _prim "Simd128_Real64_hadd": simdReal * simdReal -> simdReal ;
      val hsub = _prim "Simd128_Real64_hsub": simdReal * simdReal -> simdReal ;
      val addsub = _prim "Simd128_Real64_addsub": simdReal * simdReal -> simdReal ;
      val sqrt = _prim "Simd128_Real64_sqrt": simdReal -> simdReal ;
(*      val fromArray = _prim "Simd128_Real64_fromArray": elt array -> simdReal ;
      val toArray = _prim "Simd128_Real64_toArray": simdReal -> elt array ;*)
      val fromScalar = _prim "Simd128_Real64_loads": elt -> simdReal ;
      val toScalar = _prim "Simd128_Real64_stores": simdReal -> elt ;
  end
structure Simd256_Real32 : PRIM_SIMD_REAL =
  struct
    open  Simd256_Real32
    
    val vecSize : Int32.int = 256
    val realSize : Int32.int = 32

    type elt = Real32.real
(*    type simd = t*)

      val add = _prim "Simd256_Real32_add":simdReal * simdReal -> simdReal ;
      val sub = _prim "Simd256_Real32_sub":simdReal * simdReal -> simdReal ;
      val mul = _prim "Simd256_Real32_mul":simdReal * simdReal -> simdReal ;
      val div = _prim "Simd256_Real32_div":simdReal * simdReal -> simdReal ;
      val min = _prim "Simd256_Real32_min":simdReal * simdReal -> simdReal ;
      val max = _prim "Simd256_Real32_max":simdReal * simdReal -> simdReal ;
      val andb = _prim "Simd256_Real32_andb":simdReal * simdReal -> simdReal ;
      val orb = _prim "Simd256_Real32_orb":simdReal * simdReal -> simdReal ;
      val xorb = _prim "Simd256_Real32_xorb":simdReal * simdReal -> simdReal;
      val andnb = _prim "Simd256_Real32_andnotb":simdReal * simdReal -> simdReal ;
      val hadd = _prim "Simd256_Real32_hadd":simdReal * simdReal -> simdReal ;
      val hsub = _prim "Simd256_Real32_hsub":simdReal * simdReal -> simdReal ;
      val addsub = _prim "Simd256_Real32_addsub":simdReal * simdReal -> simdReal ;
      val sqrt = _prim "Simd256_Real32_sqrt":simdReal -> simdReal ;
(*      val fromArray = _prim "Simd256_Real32_fromArray": elt array -> simdReal ;
      val toArray = _prim "Simd256_Real32_toArray": simdReal -> elt array ;*)
      val fromScalar = _prim "Simd256_Real32_loads": elt -> simdReal ;
      val toScalar = _prim "Simd256_Real32_stores": simdReal -> elt ;
  end
structure Simd256_Real64 : PRIM_SIMD_REAL =
  struct
    open  Simd256_Real64
    
    val vecSize : Int32.int = 256
    val realSize : Int32.int = 64

    type elt = Real64.real
(*    type simdReal = t*)

      val add = _prim "Simd256_Real64_add": simdReal * simdReal -> simdReal ;
      val sub = _prim "Simd256_Real64_sub": simdReal * simdReal -> simdReal ;
      val mul = _prim "Simd256_Real64_mul": simdReal * simdReal -> simdReal ;
      val div = _prim "Simd256_Real64_div": simdReal * simdReal -> simdReal ;
      val min = _prim "Simd256_Real64_min": simdReal * simdReal -> simdReal ;
      val max = _prim "Simd256_Real64_max": simdReal * simdReal -> simdReal ;
      val andb = _prim "Simd256_Real64_andb": simdReal * simdReal -> simdReal ;
      val orb = _prim "Simd256_Real64_orb": simdReal * simdReal -> simdReal ;
      val xorb = _prim "Simd256_Real64_xorb": simdReal * simdReal -> simdReal ;
      val andnb = _prim "Simd256_Real64_andnotb": simdReal * simdReal -> simdReal ;
      val hadd = _prim "Simd256_Real64_hadd": simdReal * simdReal -> simdReal ;
      val hsub = _prim "Simd256_Real64_hsub": simdReal * simdReal -> simdReal ;
      val addsub = _prim "Simd256_Real64_addsub": simdReal * simdReal -> simdReal ;
      val sqrt = _prim "Simd256_Real64_sqrt": simdReal -> simdReal ;
(*      val fromArray = _prim "Simd256_Real64_fromArray": elt array -> simdReal ;
      val toArray = _prim "Simd256_Real64_toArray": simdReal -> elt array ;*)
      val fromScalar = _prim "Simd256_Real64_loads": elt -> simdReal ;
      val toScalar = _prim "Simd256_Real64_stores": simdReal -> elt ;
  end
end
