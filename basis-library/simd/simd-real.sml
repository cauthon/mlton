(* Copyright (C) 2013 Tucker DiNapoli
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)

structure Simd128_Real32 : SIMD_REAL =
struct
local
  type real = Real32.real
in
  open Primitive.Simd128_Real32
      val elements = 3
      val fromArray = _import "Simd128_Real32_loadu" private :
                      (real) array -> simdReal;
      val toArray = _import "Simd128_Real32_storeu" private :
                    (real) array * simdReal -> unit;
(*      fun fromArrayUnsafe (a,i) = _import "Simd128_Real32_fromArray" private :
                            (real) array * int -> simdReal
      fun fromArraySafe (a,i) = 
          if (Array.length a <= i + elements) then
            raise Subscript
          else
            fromArrayUnsafe (a,i)*)
      fun toString s = let
        val temp = Unsafe.Array.create (4,0.0:real)
        val _ = toArray (temp,s)
        fun make (s:string list,n:int) =
            if n = 0 then
              concat ("("::Real32.toString(Array.sub(temp,n))::s)
            else make((", "::Real32.toString(Array.sub(temp,n))::s),(n-1))
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
      val fromArray = _import "Simd128_Real64_loadr" private :
                      (real) array -> simdReal;
      val toArray = _import "Simd128_Real64_storer" private :
                    (real) array * simdReal -> unit;
      fun toString s = let
        val temp = Unsafe.Array.create (2,0.0:real)
        val _ = toArray (temp,s)
        val elements = 1
        fun make (s:string list,n:int) =
            if n = 0 then
              concat ("("::Real64.toString(Array.sub(temp,n))::s)
            else make((", "::Real64.toString(Array.sub(temp,n))::s),(n-1))
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
      val fromArray = _import "Simd256_Real32_loadr" private :
                      (Real32.real) array -> simdReal;
      val toArray = _import "Simd256_Real32_storer" private :
                    (Real32.real) array * simdReal -> unit;
      fun toString s = let
        val temp = Unsafe.Array.create (4,0.0:real)
        val _ = toArray (temp,s)
        val elements = Int32.div(vecSize,realSize)-1
        fun make (s:string list,n:int) =
            if n = 0 then
              concat ("("::Real32.toString(Array.sub(temp,n))::s)
            else make((", "::Real32.toString(Array.sub(temp,n))::s),(n-1))
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
      val fromArray = _import "Simd256_Real64_loadr" private :
                      (real) array -> simdReal;
      val toArray = _import "Simd256_Real64_storer" private :
                    (real) array * simdReal -> unit;
      fun toString s = let
        val temp = Unsafe.Array.create (2,0.0:real)
        val _ = toArray (temp,s)
        val elements = Int32.div(vecSize,realSize)-1
        fun make (s:string list,n:int) =
            if n = 0 then
              concat ("("::Real64.toString(Array.sub(temp,n))::s)
            else make((", "::Real64.toString(Array.sub(temp,n))::s),(n-1))
      in make ([")"],elements) end
      fun toStringScalar s = let
        val temp = toScalar s
      in (Real64.toString temp) end
end
end

