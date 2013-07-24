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
