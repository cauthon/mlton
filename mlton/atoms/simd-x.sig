(* Copyright (C) 2013 Tucker DiNapoli
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)
signature SIMD_AVAIL =
sig
  val sse:bool
  val sse2:bool
  val sse3:bool
  val ssse3:bool
  val sse4.1:bool
  val sse4.2:bool
  val avx:bool
  val avx2:bool
end
signature SIMD_REAL_X_STRUCTS =
   sig
      structure SimdSize: SIMD_SIZE
      structure RealSize: REAL_SIZE
   end
signature SIMD_WORD_X_STRUCTS =
   sig
      structure SimdSize: SIMD_SIZE
      structure WordSize: WORD_SIZE
   end
signature SIMD_REAL_X =
   sig
      include SIMD_REAL_X_STRUCTS
      type t (*type of SimdSize.t*RealX.t*)
      val add: t * t -> t
      val sub: t * t -> t
      val mul: t * t -> t
      val div: t * t -> t
      val min: t * t -> t
      val max: t * t -> t
      val sqrt: t -> t
      val abs: t -> t
      val hadd: t * t -> t
      val hsub: t * t -> t
      val addsub: t * t -> t
      val andb: t * t -> t
      val orb: t * t -> t
      val xorb: t * t -> t
      val notb: t -> t
      val zero: SimdSize.t -> t
      val equals: t * t -> t (*bitwise equality*)
      val toString: t -> string
      val layout: t -> Layout.t
      val hash: t -> word
   end
