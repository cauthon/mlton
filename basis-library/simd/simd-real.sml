(* Copyright (C) 2013 Tucker DiNapoli
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)

structure Simd128_Real32 =
struct
  open Primitive.Simd128_Real32
      val fromArray = _import "Simd128_Real32_loadr" private : (Real32.t) array -> Simd128_Real32.t;
      val toArray = _import "Simd128_Real32_storer" private : (Real32.t) array * Simd128_Real32.t -> unit;
      fun toString s = let
        val temp = toArray s
        val elements = (vecSize/realSize)-1
        fun make (s:string list,n:int) =
            if n = 0 then
              concat ("("::R.toString(Array.sub(temp,n))::s)
            else make((", "::R.toString(Array.sub(temp,n))::s),(n-1))
      in make (")",elements) end
end

structure Simd128_Real64 =
struct
  open Primitive.Simd128_Real64
      val fromArray = _import "Simd128_Real64_loadr" private : (Real64.t) array -> Simd128_Real64.t;
      val toArray = _import "Simd128_Real64_storer" private : (Real64.t) array * Simd128_Real64.t -> unit;
      fun toString s = let
        val temp = toArray s
        val elements = (vecSize/realSize)-1
        fun make (s:string list,n:int) =
            if n = 0 then
              concat ("("::R.toString(Array.sub(temp,n))::s)
            else make((", "::R.toString(Array.sub(temp,n))::s),(n-1))
      in make (")",elements) end
end

structure Simd256_Real32 =
struct
  open Primitive.Simd256_Real32
      val fromArray = _import "Simd256_Real32_loadr" private : (Real32.t) array -> Simd256_Real32.t;
      val toArray = _import "Simd256_Real32_storer" private : (Real32.t) array * Simd256_Real32.t -> unit;
      fun toString s = let
        val temp = toArray s
        val elements = (vecSize/realSize)-1
        fun make (s:string list,n:int) =
            if n = 0 then
              concat ("("::R.toString(Array.sub(temp,n))::s)
            else make((", "::R.toString(Array.sub(temp,n))::s),(n-1))
      in make (")",elements) end
end


structure Simd256_Real64 =
struct
  open Primitive.Simd256_Real64
      val fromArray = _import "Simd256_Real64_loadr" private : (Real64.t) array -> Simd256_Real64.t;
      val toArray = _import "Simd256_Real64_storer" private : (Real64.t) array * Simd256_Real64.t -> unit;
      fun toString s = let
        val temp = toArray s
        val elements = (vecSize/realSize)-1
        fun make (s:string list,n:int) =
            if n = 0 then
              concat ("("::R.toString(Array.sub(temp,n))::s)
            else make((", "::R.toString(Array.sub(temp,n))::s),(n-1))
      in make (")",elements) end
end

