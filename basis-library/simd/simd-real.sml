(* Copyright (C) 2013 Tucker DiNapoli
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)
(*signature SIMD_REAL_COMMON =
sig
  type simdReal
  type elt
  val elements:Int32.int
  val fromArray:elt array -> simdReal
  val toArray:elt array * simdReal -> unit
  val fromArrayUnsafe:elt array * Int32.int -> simdReal
  val toArrayUnsafe:elt array * simdReal * Int32.int -> unit
  val eltToString:elt -> string
end
signature SIMD_REAL_STRUCTS =
sig
  type simdReal
  type elt
  structure Simd:PRIM_SIMD_REAL
  structure Common:SIMD_REAL_COMMON
  sharing type S.elt = elt
  sharing type S.simdReal = simdReal
end
functor SimdReal (S: SIMD_REAL_STRUCTS):SIMD_REAL =
  struct
  local
    type real = S.elt
  in
    open S.Simd
    local
      open S.Common
    in
      val elements = elements
      val fromArray = fromArray
      val toArray = toArray
      fun fromArrayOffset (a,i) = 
          if (Array.length a <= i + elements) 
             orelse (i < 0) then
            raise Subscript
          else
            fromArrayUnsafe (a,i)
      fun toArrayOffset (a,ni) = 
          if (Array.length a <= i + elements) 
             orelse (i < 0) then
            raise Subscript
          else
            toArrayUnsafe (a,s,i)
      val eltToString = eltToString
    end
    fun toString s = let
      val temp = Unsafe.Array.create ((elements + 1),0.0:real)
      val _ = toArray (temp,s)
      fun make (s:string list,n:int) =
          if n = 0 then
            concat ("("::eltToString(Array.sub(temp,n))::s)
          else make((","::eltToString(Array.sub(temp,n))::s),(n-1))
    in make ([")"],elements) end
    fun toStringScalar s = let
      val temp = toScalar s
    in (eltToString temp) end
    datatype cmp = eq | lt | gt | le | ge | ne | nlt | ngt | nle | ord | unord
    fun cmp (s1:simdReal,s2:simdReal,c:cmp) = let
      val imm = case c of
                    eq => 0w0
                        | lt => 0w1  | gt => 0w6 | le => 0w2 | ge => 0w5 | ne => 0w4| nlt => 0w5 | ngt => 0w2 | nle => 0w6 | ord => 0w7| unord  => 0w3
      in S.Simd.cmp(s1,s2,imm)
    end
  end
end*)

structure Simd128_Real32 : SIMD_REAL =
struct
local
  type real = Real32.real
in
  open Primitive.Simd128_Real32
      val elements = 3
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

structure Simd128_Real64 : SIMD_REAL =
struct
local
  type real = Real64.real
in
  open Primitive.Simd128_Real64
      val elements = 1
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
      fun toString s = let
        val temp = Unsafe.Array.create (2,0.0:real)
        val _ = toArray (temp,s)
        fun make (s:string list,n:int) =
            if n = 0 then
              concat ("("::Real64.toString(Array.sub(temp,n))::s)
            else make((","::Real64.toString(Array.sub(temp,n))::s),(n-1))
      in make ([")"],elements) end
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
end

