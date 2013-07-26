signature PRIM_SIMD_REAL =
   sig
      val vecSize
      val realSize
      type t
      type elem
      val add : t * t -> t
      val sub : t * t -> t
      val mul : t * t -> t
      val div : t * t -> t
      val min : t * t -> t
      val max : t * t -> t
      val andb : t * t -> t
      val orb : t * t -> t
      val andnb : t * t -> t
      val hadd : t * t -> t
      val hsub : t * t -> t
      val addsub : t * t -> t
      val sqrt : t -> t
      val fromArray : elem array -> t
(*
 cast array to a word 8 array then
 load from word8 array using Word8Array_subSimdReal *)
      val toArray : t -> elem array
      val fromScalar : e -> t 
      val toScalar : t -> e
   end
