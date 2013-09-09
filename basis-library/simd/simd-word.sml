(* Copyright (C) 2013 Tucker DiNapoli
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)
(*add fromArrayInt*)
signature SIMD_WORD_STRUCTS =
sig
  type simdWord
  type elt
  structure Word:WORD
  structure Simd:PRIM_SIMD_WORD
  val zero:elt
  val one:elt(*all bits 1, not 2s compliment one*)
  val elements:Int32.int
  sharing type Word.word = Simd.elt = elt
  sharing type Simd.simdWord = simdWord
end
functor SimdWord (S: SIMD_WORD_STRUCTS):SIMD_WORD =
   struct        
   open S
   open Simd
   type intElt = intElt
   val fromArrayUnsafe = fromArray
   val fromIntArrayUnsafe = fromIntArray
   val fromArray = fn x => fromArrayUnsafe(x,0:Int64.int)
   val fromIntArray = fn x => fromIntArrayUnsafe(x,0:Int64.int)
   fun fromArrayOffset (a,i) =
       if (Array.length a <= (i + elements-1)) orelse (i <0)
       then raise Subscript
       else if (Int32.mod(i,elements) = 0)
       then fromArrayUnsafe(a,Int64.fromInt(i))
       (*Deal with unaligned index
        *we copy the desired elements to a new array, and load from that*)
       else let
         val temp = Primitive.Array.arrayUnsafe(Int64.fromInt(elements))
         (*I assume this'll be optimized into a simple loop*)
         fun loop (j) = 
             if j = elements then ()
             else (Primitive.Array.updateUnsafe(temp,Int64.fromInt(j),Array.sub(a,(i+j)));
                   loop(j+1))
         val _ = loop(0)
       in fromArrayUnsafe(temp,Int64.fromInt(0)) end
   fun fromIntArrayOffset (a,i) =
       if (Array.length a <= (i + elements-1)) orelse (i <0)
       then raise Subscript
       else if (Int32.mod(i,elements) = 0)
       then fromIntArrayUnsafe(a,Int64.fromInt(i))
       (*Deal with unaligned index
        *we copy the desired elements to a new array, and load from that*)
       else let
         val temp = Primitive.Array.arrayUnsafe(Int64.fromInt(elements))
         (*I assume this'll be optimized into a simple loop*)
         fun loop (j) = 
             if j = elements then ()
             else (Primitive.Array.updateUnsafe(temp,Int64.fromInt(j),Array.sub(a,(i+j)));
                   loop(j+1))
         val _ = loop(0)
       in fromIntArrayUnsafe(temp,Int64.fromInt(0)) end
   local
     type word = elt
     structure Array = Primitive.Array
   in
     val toStringElt=Word.toString
     fun toString s = let
       val temp = Array.arrayUnsafe (Int64.fromInt(elements))
       val _ = toArray (temp,s)
       fun make (s:string list,n:Int64.int) =
      if n = 0 then
        concat ("("::toStringElt(Array.subUnsafe(temp,n))::s)
      else make((","::toStringElt(Array.subUnsafe(temp,n))::s),Int64.-(n,1))
     in make ([")"],Int64.fromInt(elements-1)) end
     fun toStringScalar s = let
       val temp = toScalar s
     in (toStringElt temp) end
   end
   local
     val simdWord1=fromArrayUnsafe(Array.array(elements,one),0:Int64.int)
   in
     val notb = fn x => andnb(simdWord1,x)
   end
(*   datatype cmp = eq  | lt  | gt  | le  | ge
                | ne  | nlt | ngt | nle | nge
   fun cmp (w:simdWord,w':simdWord,c:cmp):simdWord =
       case c of
           eq => cmpeq(w,w')
         | lt => notb(orb(cmpgt(w,w'),cmpeq(w,w')))
         | gt => cmpgt(w,w')
         | lt => cmpgt(w',w)
         | ge => orb(cmpgt(w,w'),cmpeq(w,w'))
         | ne => notb(cmpeq(w,w'))
         | nlt => cmpgt(w,w')*)
end
structure Simd128_Word8:SIMD_WORD = SimdWord(
  struct
    structure Word = Word8                       
    structure Simd = Primitive.Simd128_Word8
    type elt = Word.word
    type simdWord = Simd.simdWord
    val zero = 0w0:elt
    val one = 0wxff:elt
    val elements = 16
  end)
structure Simd128_Word16:SIMD_WORD = SimdWord(
  struct
    structure Word = Word16                       
    structure Simd = Primitive.Simd128_Word16
    type elt = Word.word
    type simdWord = Simd.simdWord
    val zero = 0w0:elt
    val one = 0wxffff:elt
    val elements = 8
  end)
structure Simd128_Word32:SIMD_WORD = SimdWord(
  struct
    structure Word = Word32                       
    structure Simd = Primitive.Simd128_Word32
    type elt = Word.word
    type simdWord = Simd.simdWord
    val zero = 0w0:elt
    val one = 0wxffffffff:elt
    val elements = 4
  end)
structure Simd128_Word64:SIMD_WORD = SimdWord(
  struct
    structure Word = Word64                       
    structure Simd = Primitive.Simd128_Word64
    type elt = Word.word
    type simdWord = Simd.simdWord
    val zero = 0w0:elt
    val one = 0wxffffffffffffffff:elt
    val elements = 2
  end)
(*structure Simd128_Word8 : SIMD_WORD =
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
  val temp = Primitive.Array.arrayUnsafe (elements)
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
*)
