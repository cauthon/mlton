signature PRIM_SIMD_WORD =
   sig
      val vecSize : Primitive.Int32.int
      val wordSize : Primitive.Int32.int
      type t 
      type simd = t
      type elt
      val add : simd * simd -> simd
      val sub : simd * simd -> simd
      val min : simd * simd -> simd
      val max : simd * simd -> simd
      val sar : simd * simd -> simd
      val sari : simd * Word8.word -> simd
      val slr : simd * simd -> simd
      val slri : simd * Word8.word -> simd
      val sll : simd * simd -> simd
      val slli : simd * Word8.word -> simd
      val andb : simd * simd -> simd
      val orb : simd * simd -> simd
      val andnb : simd * simd -> simd
      val hadd : simd * simd -> simd
      val hsub : simd * simd -> simd
      val addsub : simd * simd -> simd
      val sqrt : simd -> simd
      val fromArray : elt array -> simd
(*
 cast array to a word 8 array then
 load from word8 array using Word8Array_subSimdReal *)
      val toArray : simd -> elem array
      val fromScalar : e -> simd
      val toScalar : simd -> e
   end
