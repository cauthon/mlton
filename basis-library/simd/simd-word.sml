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
  type intElt
  structure Word:WORD
  structure Int:INTEGER
  structure Simd:PRIM_SIMD_WORD
  val zero:elt
  val one:elt(*all bits 1, not 2s compliment one*)
  val elements:Int32.int
  val toIntElt:Word.word -> Int.int
  sharing type Word.word = Simd.elt = elt
  sharing type Simd.simdWord = simdWord
  sharing type Int.int = intElt
end
functor SimdWord (S: SIMD_WORD_STRUCTS):SIMD_WORD =
   struct        
   open S
   open Simd
   val fromArrayUnsafe = fromArray
   val fromIntArrayUnsafe = fromIntArray
   val fromArray = fn x => fromArrayUnsafe(x,0:Int64.int)
   val fromIntArray = fn x => fromIntArrayUnsafe(x,0:Int64.int)
   fun fromArrayOffset (a,i) =
       if (Array.length a <= (i + elements)) orelse (i <0)
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
     fun toStringGeneric f s = let
       val temp = Array.arrayUnsafe (Int64.fromInt(elements))
       val _ = toArray (temp,s)
       fun make (s:string list,n:Int64.int) =
      if n = 0 then
        concat ("("::f(Array.subUnsafe(temp,n))::s)
      else make((","::f(Array.subUnsafe(temp,n))::s),Int64.-(n,1))
     in make ([")"],Int64.fromInt(elements-1)) end
     val toString = toStringGeneric toStringElt
     val toStringInt = toStringGeneric (Int.toString o toIntElt)
     val fmtInt = fn f => fn s =>
                     toStringGeneric ((Int.fmt f) o toIntElt) s
     val fmt = fn f => fn s =>
                  toStringGeneric (Word.fmt f) s
     fun toStringScalar s = let
       val temp = toScalar s
     in (toStringElt temp) end
    fun fmtScalar f s = let
      val temp = toScalar s
    in (Word.fmt f) temp end
   end
(*   local*)
(*     val Word1Const= Array.array(elements,one)
     val simdWord1=fromArray(Word1Const)*)
(*   in
     val notb = fn x => andnb(x,simdWord1)
   end*)
(*
   fun cmp (w:simdWord,w':simdWord,c:cmp):simdWord =
       case c of
           eq => cmpeq(w,w')
         | lt => notb(orb(cmpgt(w,w'),cmpeq(w,w')))
         | gt => cmpgt(w,w')
         | ge => orb(cmpgt(w,w'),cmpeq(w,w'))
         | le => cmpgt(w',w)
         | ne => notb(cmpeq(w,w'))
         | nlt => orb(cmpgt(w,w'),cmpeq(w,w'))
         | ngt => notb(cmpgt(w,w'))
         | nle => cmpgt(w,w')
         | nge => notb(orb(cmpgt(w,w'),cmpeq(w,w')))
         | nlt => cmpgt(w,w')*)
end
structure Simd128_Word8:SIMD_WORD = SimdWord(
  struct
    structure Word = Word8                       
    structure Int = Int8
    structure Simd = Primitive.Simd128_Word8
    type elt = Word.word
    type intElt = Int.int
    type simdWord = Simd.simdWord
    val toIntElt = Primitive.IntWordConv.idFromWord8ToInt8
    val zero = 0w0:elt
    val one = 0wxff:elt
    val elements = 16
  end)
structure Simd128_Word16:SIMD_WORD = SimdWord(
  struct
    structure Word = Word16                       
    structure Int =Int16
    structure Simd = Primitive.Simd128_Word16
    type elt = Word.word
    type intElt = Int.int
    type simdWord = Simd.simdWord
    val toIntElt = Primitive.IntWordConv.idFromWord16ToInt16
    val zero = 0w0:elt
    val one = 0wxffff:elt
    val elements = 8
  end)
structure Simd128_Word32:SIMD_WORD = SimdWord(
  struct
    structure Word = Word32                       
    structure Int =Int32
    structure Simd = Primitive.Simd128_Word32
    type elt = Word.word
    type intElt = Int.int
    type simdWord = Simd.simdWord
    val toIntElt = Primitive.IntWordConv.idFromWord32ToInt32
    val zero = 0w0:elt
    val one = 0wxffffffff:elt
    val elements = 4
  end)
structure Simd128_Word64:SIMD_WORD = SimdWord(
  struct
    structure Word = Word64                       
    structure Int =Int64
    structure Simd = Primitive.Simd128_Word64
    type elt = Word.word
    type intElt = Int.int
    type simdWord = Simd.simdWord
    val toIntElt = Primitive.IntWordConv.idFromWord64ToInt64
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
