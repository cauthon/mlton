(* Copyright (C) 2013 Tucker DiNapoli
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)

functor SimdReal (structure S : PRIM_SIMD_REAL): SIMD_REAL =
   struct 
      open S
   end          
structure Simd128_Real32 = SimdReal(Simd128_Real32)
structure Simd128_Real64 = SimdReal(Simd128_Real64)
structure Simd256_Real32 = SimdReal(Simd256_Real32)
structure Simd256_Real64 = SimdReal(Simd256_Real64)
