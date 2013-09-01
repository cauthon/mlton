(* Copyright (C) 2013 Tucker DiNapoli
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)
signature SIMD_REAL_COMMON =
sig
  type simdReal
  type elt
  val elements:Int32.int
(*  val fromArray:elt array -> simdReal*)
(*  val toArray:elt array * simdReal -> unit*)
(*  val fromArrayUnsafe:elt array * Int64.int -> simdReal*)
  val toArrayUnsafe:elt array * simdReal * Int32.int -> unit
  val zero:elt
end
signature SIMD_REAL_STRUCTS =
sig
  type simdReal
  type elt
(*Ask if dead code elimnation will get rid of most of this
 *because otherwise pulling it all of the Real structure is
 *excessive*)
  structure Real:REAL
  structure Simd:PRIM_SIMD_REAL
  structure Common:SIMD_REAL_COMMON
  sharing type Real.real = Simd.elt = Common.elt = elt
  sharing type Simd.simdReal = Common.simdReal = simdReal
end
functor SimdReal (S: SIMD_REAL_STRUCTS):SIMD_REAL =
  struct
  open S
(*  type t = simdReal*)
  local
    type real = elt
    local
      open Word8
      infix 4 <<
    in
(*include this in public sig or no?*)
    fun mkShuffleConst(w1:word,w2:word,w3:word,w4:word):word =
        orb(w1 << 0w6,orb(w2 << 0w4,orb(w3 << 0w2,w4 << 0w0)))
    end
  in
    open Simd
    local
      open Common
      val fromArrayUnsafe = fromArray
(*      type int = Int64.int*)
    in
      val elements = elements
      val arrElements = elements-1
      val toArray = toArray
      fun fromArrayOffset (a,i) = 
(*            if (Int64.<=((Int64.fromInt(Array.length a)),(Int64.+(i,arrElements))))
               orelse (Int64.<(i,0)) then*)
          if (Array.length a <= (i + arrElements)) orelse (i < 0) then
              raise Subscript
            else
              fromArrayUnsafe (a,Int64.fromInt(i))
      val fromArray = fn x => fromArrayUnsafe(x,0:Int64.int)
      fun toArrayOffset (a,s,i) = 
(*          if (Int64.<=((Int64.fromInt(Array.length a)),(Int64.+(i,arrElements))))
             orelse (Int64.<(i,0)) then*)
          if (Array.length a <= (i + arrElements)) orelse (i < 0) then
            raise Subscript
          else
            toArrayUnsafe (a,s,i)
    end
    fun toStringGeneric f s = let
      val temp = Array.array (elements,Common.zero)
      val _ = toArray (temp,s)
      fun make (s:string list,n:int) =
          if n = 0 then
            concat ("("::f(Array.sub(temp,n))::s)
          else make((","::f(Array.sub(temp,n))::s),(n-1))
    in make ([")"],elements-1) end
    val toString = toStringGeneric Real.toString
    val fmt = fn f => fn s =>
                 toStringGeneric (Real.fmt f) s
    fun toStringScalar s = let
      val temp = toScalar s
    in (Real.toString temp) end
    val primitiveCmp = Simd.cmp
    val primitiveShuffle = Simd.shuffle
    fun shuffle (s1,s2,wconst) =
        primitiveShuffle(s1,s2,mkShuffleConst(wconst))
    datatype cmp = eq  | lt  | gt  | le  | ge  | ord
                 | ne  | nlt | ngt | nle | nge | unord
    fun cmp (s1:simdReal,s2:simdReal,c:cmp) = let
      val imm = case c of
                    eq => 0w0
                        | lt => 0w1  
                        | gt => 0w6 
                        | le => 0w2 
                        | ge => 0w5 
                        | ne => 0w4
                        | nlt => 0w5 
                        | ngt => 0w2 
                        | nle => 0w6 
                        | nge => 0w1
                        | ord => 0w7
                        | unord  => 0w3
      in primitiveCmp(s1,s2,imm) end

  end
end
structure Simd128_Real32 : SIMD_REAL = SimdReal(
  struct
    structure Real = Real32
    structure Simd = Primitive.Simd128_Real32
    structure Common = 
       struct
          type simdReal = Simd.simdReal
          type elt = Real.real                       
          val elements = 4
          val zero = 0.0:Real32.real
          local
            type real = elt
          in
          val fromArray = _import "Simd128_Real32_load" private :
                          (real) array -> simdReal;
          val toArray = _import "Simd128_Real32_store" private :
                        (real) array * simdReal -> unit;
          val fromArrayUnsafe = _import "Simd128_Real32_fromArray" private :
                                (real) array * int -> simdReal;
          val toArrayUnsafe = _import "Simd128_Real32_toArray" private :
                                (real) array * simdReal* int -> unit;
          end
       end
    type elt = Real.real
    type simdReal = Simd.simdReal
  end)
structure Simd128_Real64 : SIMD_REAL = SimdReal(
  struct
    structure Real = Real64
    structure Simd = Primitive.Simd128_Real64
    structure Common = 
       struct
          type simdReal = Simd.simdReal
          type elt = Real.real
          local
            type real = elt

          in
          val elements = 2
          val zero = 0.0:Real64.real
          val fromArray = _import "Simd128_Real64_load" private :
                          (real) array -> simdReal;
          val toArray = _import "Simd128_Real64_store" private :
                        (real) array * simdReal -> unit;
          val fromArrayUnsafe = _import "Simd128_Real64_fromArray" private :
                                (real) array * int -> simdReal;
          val toArrayUnsafe = _import "Simd128_Real64_toArray" private :
                                (real) array *  simdReal * int -> unit;
          end
       end
    type elt = Real.real
    type simdReal = Simd.simdReal
  end)
structure Simd256_Real32 : SIMD_REAL = SimdReal(
  struct
    structure Real = Real32
    structure Simd = Primitive.Simd256_Real32
    structure Common = 
       struct
          type simdReal = Simd.simdReal
          type elt = Real.real
          local
            type real = elt
          in
          val elements = 8
          val zero = 0.0:Real32.real
          val fromArray = _import "Simd256_Real32_load" private :
                          (real) array -> simdReal;
          val toArray = _import "Simd256_Real32_store" private :
                        (real) array * simdReal -> unit;
          val fromArrayUnsafe = _import "Simd256_Real32_fromArray" private :
                                (real) array * int -> simdReal;
          val toArrayUnsafe = _import "Simd256_Real32_fromArray" private :
                                (real) array *  simdReal * int -> unit;
          end
       end
    type elt = Real.real
    type simdReal = Simd.simdReal
  end)
structure Simd256_Real64 : SIMD_REAL = SimdReal(
  struct
    structure Real = Real64
    structure Simd = Primitive.Simd256_Real64
    structure Common = 
       struct
          type simdReal = Simd.simdReal
          type elt = Real.real
          val elements = 4
          val zero = 0.0:Real64.real
          local
            type real = elt
          in
          val fromArray = _import "Simd256_Real64_load" private :
                          (real) array -> simdReal;
          val toArray = _import "Simd256_Real64_store" private :
                        (real) array * simdReal -> unit;
          val fromArrayUnsafe = _import "Simd256_Real64_fromArray" private :
                                (real) array * int -> simdReal;
          val toArrayUnsafe = _import "Simd256_Real64_toArray" private :
                                (real) array *  simdReal * int -> unit;
          end
       end
    type elt = Real.real
    type simdReal = Simd.simdReal
  end)
(*
structure Simd128_Real32 : SIMD_REAL =
struct
local
  type real = Real32.real
in
  open Primitive.Simd128_Real32
      val elements = 4
      val arrElements = 3
      val fromArray = _import "Simd128_Real32_load" private :
                      (real) array -> simdReal;
      val toArray = _import "Simd128_Real32_store" private :
                    (real) array * simdReal -> unit;
local
  val fromArrayUnsafe = _import "Simd128_Real32_fromArray" private :
                        (real) array * int -> simdReal;
in
      fun fromArrayOffset (a,i) = 
          if (Array.length a <= i + elements) 
             orelse (i < 0) then
            raise Subscript
          else
            fromArrayUnsafe (a,i)
end
      fun toStringGeneric f s = let
        val temp = Unsafe.Array.create (arrElements,0.0:real)
        val _ = toArray (temp,s)
        fun make (s:string list,n:int) =
            if n = 0 then
              concat ("("::(f(Array.sub(temp,n))::s))
            else make((","::(f(Array.sub(temp,n))::s),(n-1)))
      in make ([")"],arrElements) end
      val toString = toStringGeneric Real32.toString
      val fmt = fn f => fn s =>
                   toStringGeneric (Real32.fmt f) s

(*      fun toString s = let
        val temp = Unsafe.Array.create (4,0.0:real)
        val _ = toArray (temp,s)
        fun make (s:string list,n:int) =
            if n = 0 then
              concat ("("::(Real32.fmt(StringCvt.FIX NONE) (Array.sub(temp,n))::s))
            else make((","::(Real32.fmt(StringCvt.FIX NONE)(Array.sub(temp,n))::s),(n-1)))
      in make ([")"],elements) end*)
      fun toStringScalar s = let
        val temp = toScalar s
      in (Real32.toString temp) end
end
end

structure Simd128_Real64 : SIMD_REAL =
struct
local
  type real = Real64.real
in
  open Primitive.Simd128_Real64
      val elements = 2
      val arrElements = 1
      val fromArray = _import "Simd128_Real64_load" private :
                      (real) array -> simdReal;
      val toArray = _import "Simd128_Real64_store" private :
                    (real) array * simdReal -> unit;
local
      val fromArrayUnsafe = _import "Simd128_Real64_fromArray" private :
                            (real) array * int -> simdReal;
in
      fun fromArrayOffset (a,i) = 
          if (Array.length a <= i + elements) then
            raise Subscript
          else
            fromArrayUnsafe (a,i)
end
      fun toStringGeneric f s = let
        val temp = Unsafe.Array.create (arrElements,0.0:real)
        val _ = toArray (temp,s)
        fun make (s:string list,n:int) =
            if n = 0 then
              concat ("("::(f(Array.sub(temp,n))::s))
            else make((","::(f(Array.sub(temp,n))::s),(n-1)))
      in make ([")"],elements) end
      val toString = toStringGeneric Real64.toString
      val fmt = fn f => fn s =>
                   toStringGeneric (Real64.fmt f) s
(*      fun toString s = let
        val temp = Unsafe.Array.create (2,0.0:real)
        val _ = toArray (temp,s)
        fun make (s:string list,n:int) =
            if n = 0 then
              concat ("("::Real64.toString(Array.sub(temp,n))::s)
            else make((","::Real64.toString(Array.sub(temp,n))::s),(n-1))
      in make ([")"],elements) end*)
      fun toStringScalar s = let
        val temp = toScalar s
      in (Real64.toString temp) end
end
end

structure Simd256_Real32 : SIMD_REAL =
struct
local
  type real = Real32.real
in
   open Primitive.Simd256_Real32
      val elements = 3
      val fromArray = _import "Simd256_Real32_load" private :
                      (Real32.real) array -> simdReal;
      val toArray = _import "Simd256_Real32_store" private :
                    (Real32.real) array * simdReal -> unit;
local
      val fromArrayUnsafe = _import "Simd256_Real32_fromArray" private :
                            (real) array * int -> simdReal;
in
      fun fromArrayOffset (a,i) = 
          if (Array.length a <= i + elements) then
            raise Subscript
          else
            fromArrayUnsafe (a,i)
end
      fun toString s = let
        val temp = Unsafe.Array.create (4,0.0:real)
        val _ = toArray (temp,s)
        fun make (s:string list,n:int) =
            if n = 0 then
              concat ("("::Real32.toString(Array.sub(temp,n))::s)
            else make((","::Real32.toString(Array.sub(temp,n))::s),(n-1))
      in make ([")"],elements) end
      fun toStringScalar s = let
        val temp = toScalar s
      in (Real32.toString temp) end
end
end


structure Simd256_Real64 : SIMD_REAL = 
struct
local
  type real = Real64.real
in
   open Primitive.Simd256_Real64
      val elements = 1
      val fromArray = _import "Simd256_Real64_loadr" private :
                      (real) array -> simdReal;
      val toArray = _import "Simd256_Real64_storer" private :
                    (real) array * simdReal -> unit;
local
      val fromArrayUnsafe  = _import "Simd256_Real64_fromArray" private :
                             (real) array * int -> simdReal;
in
      fun fromArrayOffset (a,i) = 
          if (Array.length a <= i + elements) then
            raise Subscript
          else
            fromArrayUnsafe (a,i)
end
      fun toString s = let
        val temp = Unsafe.Array.create (2,0.0:real)
        val _ = toArray (temp,s)
        val elements = Int32.div(vecSize,realSize)-1
        fun make (s:string list,n:int) =
            if n = 0 then
              concat ("("::Real64.toString(Array.sub(temp,n))::s)
            else make((","::Real64.toString(Array.sub(temp,n))::s),(n-1))
      in make ([")"],elements) end
      fun toStringScalar s = let
        val temp = toScalar s
      in (Real64.toString temp) end
end
*)
(*end*)
