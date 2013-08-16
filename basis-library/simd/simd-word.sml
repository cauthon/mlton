(* Copyright (C) 2013 Tucker DiNapoli
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)

(*TODO*)
structure Simd128_Word8 : SIMD_WORD =
struct
   val vec_size = 128
   val word_size = 8
   open Primitive.Simd128_Word8
local
  type word = Word8.word
in
val fromArray = _import "Simd128_Word8_load" private :
                (word) array -> simdWord;
val toArray = _import "Simd128_Word8_store" private :
              (word) array * simdWord -> unit;
end

end
structure Simd128_Word16 : SIMD_WORD =
struct
   val vec_size = 128
   val word_size = 16
   open Primitive.Simd128_Word16
local
  type word = Word16.word
in
val fromArray = _import "Simd128_Word16_load" private :
                (word) array -> simdWord;
val toArray = _import "Simd128_Word16_store" private :
              (word) array * simdWord -> unit;
end

end
structure Simd128_Word32 : SIMD_WORD =
struct
   val vec_size = 128
   val word_size = 32
   open Primitive.Simd128_Word32
local
  type word = Word32.word
in
val fromArray = _import "Simd128_Word32_load" private :
                (word) array -> simdWord;
val toArray = _import "Simd128_Word32_store" private :
              (word) array * simdWord -> unit;
end

end
structure Simd128_Word64 : SIMD_WORD =
struct
   val vec_size = 128
   val word_size = 64
   open Primitive.Simd128_Word64
local
  type word = Word64.word
in
val fromArray = _import "Simd128_Word64_load" private :
                (word) array -> simdWord;
val toArray = _import "Simd128_Word64_store" private :
              (word) array * simdWord -> unit;
end
end
