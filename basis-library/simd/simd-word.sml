(* Copyright (C) 2013 Tucker DiNapoli
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)



structure Simd128_Word8 : SIMD_WORD =
struct
   val vec_size = 128
   val word_size = 8
   val elements = 16
   open Primitive.Simd128_Word8
local
  type word = Word8.word
in
val fromArray = _import "Simd128_Word8_load" private :
                (word) array -> simdWord;
val toArray = _import "Simd128_Word8_store" private :
              (word) array * simdWord -> unit;
val toStringElt = Word8.toString
fun toString s = let
  val temp = Unsafe.Array.create (elements,0w0:word)
  val _ = toArray (temp,s)
  fun make (s:string list,n:int) =
      if n = 0 then
        concat ("("::toStringElt(Array.sub(temp,n))::s)
      else make((","::toStringElt(Array.sub(temp,n))::s),(n-1))
  in make ([")"],elements-1) end
  fun toStringScalar s = let
        val temp = toScalar s
  in (toStringElt temp) end
end

end
structure Simd128_Word16 : SIMD_WORD =
struct
   val vec_size = 128
   val word_size = 16
   val elements = 8
   open Primitive.Simd128_Word16
local
  type word = Word16.word
in
val fromArray = _import "Simd128_Word16_load" private :
                (word) array -> simdWord;
val toArray = _import "Simd128_Word16_store" private :
              (word) array * simdWord -> unit;
val toStringElt = Word16.toString
fun toString s = let
  val temp = Unsafe.Array.create (elements,0w0:word)
  val _ = toArray (temp,s)
  fun make (s:string list,n:int) =
      if n = 0 then
        concat ("("::toStringElt(Array.sub(temp,n))::s)
      else make((","::toStringElt(Array.sub(temp,n))::s),(n-1))
  in make ([")"],elements-1) end
  fun toStringScalar s = let
    val temp = toScalar s
  in (toStringElt temp) end
end

end
structure Simd128_Word32 : SIMD_WORD =
struct
   val vec_size = 128
   val word_size = 32
   val elements = 4
   open Primitive.Simd128_Word32
local
  type word = Word32.word
in
val fromArray = _import "Simd128_Word32_load" private :
                (word) array -> simdWord;
val toArray = _import "Simd128_Word32_store" private :
              (word) array * simdWord -> unit;
val toStringElt = Word32.toString
fun toString s = let
  val temp = Unsafe.Array.create (elements,0w0:word)
  val _ = toArray (temp,s)
  fun make (s:string list,n:int) =
      if n = 0 then
        concat ("("::toStringElt(Array.sub(temp,n))::s)
      else make((","::toStringElt(Array.sub(temp,n))::s),(n-1))
  in make ([")"],elements-1) end
  fun toStringScalar s = let
    val temp = toScalar s
  in (toStringElt temp) end
end

end
structure Simd128_Word64 : SIMD_WORD =
struct
   val vec_size = 128
   val word_size = 64
   val elements = 2
   open Primitive.Simd128_Word64
local
  type word = Word64.word
in
val fromArray = _import "Simd128_Word64_load" private :
                (word) array -> simdWord;
val toArray = _import "Simd128_Word64_store" private :
              (word) array * simdWord -> unit;
val toStringElt = Word64.toString
fun toString s = let
  val temp = Unsafe.Array.create (elements,0w0:word)
  val _ = toArray (temp,s)
  fun make (s:string list,n:int) =
      if n = 0 then
        concat ("("::toStringElt(Array.sub(temp,n))::s)
      else make((","::toStringElt(Array.sub(temp,n))::s),(n-1))
  in make ([")"],elements-1) end
  fun toStringScalar s = let
    val temp = toScalar s
  in (toStringElt temp) end
end
end
