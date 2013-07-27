signature PRIM_SIMD_REAL =
   sig
      val vecSize : Primitive.Int32.int
      val realSize : Primitive.Int32.int
      type simd
      type t = simd
      type elt
      val add : simd * simd -> simd
      val sub : simd * simd -> simd
      val mul : simd * simd -> simd
      val div : simd * simd -> simd
      val min : simd * simd -> simd
      val max : simd * simd -> simd
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
(*(defun make_simd_struct (name simdSize realSize)
(insert (format 
"\nstructure %s : PRIM_SIMD_REAL =
  struct
    open  %s
    
    val vecSize : Int32.int = %d
    val realSize : Int32.int = %d

    type elt = Real%d.real

      val add = _prim \"%s_add\": simd * simd -> simd
      val sub = _prim \"%s_sub\": simd * simd -> simd
      val mul = _prim \"%s_mul\": simd * simd -> simd
      val div = _prim \"%s_div\": simd * simd -> simd
      val min = _prim \"%s_min\": simd * simd -> simd
      val max = _prim \"%s_max\": simd * simd -> simd
      val andb = _prim \"%s_andb\": simd * simd -> simd
      val orb = _prim \"%s_orb\": simd * simd -> simd
      val andnb = _prim \"%s_andnb\": simd * simd -> simd
      val hadd = _prim \"%s_hadd\": simd * simd -> simd
      val hsub = _prim \"%s_hsub\": simd * simd -> simd
      val addsub = _prim \"%s_addsub\": simd * simd -> simd
      val sqrt = _prim \"%s_sqrt\": simd -> simd
      val fromArray = _prim \"%s_fromArray\": elt array -> simd
      val toArray = _prim \"%s_toArray\": simd -> elem array
      val fromScalar = _prim \"%s_fromScalar\": e -> simd
      val toScalar = _prim \"%s_toScalar\": simd -> e
  end"
name name simdSize realSize realSize name name name name name name name name
name name name name name name name name name)))*)
structure Simd128_Real32 : PRIM_SIMD_REAL =
  struct
    open  Simd128_Real32
    
    val vecSize : Int32.int = 128
    val realSize : Int32.int = 32

    type elt = Real32.real

      val add = _prim "Simd128_Real32_add": simd * simd -> simd
      val sub = _prim "Simd128_Real32_sub": simd * simd -> simd
      val mul = _prim "Simd128_Real32_mul": simd * simd -> simd
      val div = _prim "Simd128_Real32_div": simd * simd -> simd
      val min = _prim "Simd128_Real32_min": simd * simd -> simd
      val max = _prim "Simd128_Real32_max": simd * simd -> simd
      val andb = _prim "Simd128_Real32_andb": simd * simd -> simd
      val orb = _prim "Simd128_Real32_orb": simd * simd -> simd
      val andnb = _prim "Simd128_Real32_andnb": simd * simd -> simd
      val hadd = _prim "Simd128_Real32_hadd": simd * simd -> simd
      val hsub = _prim "Simd128_Real32_hsub": simd * simd -> simd
      val addsub = _prim "Simd128_Real32_addsub": simd * simd -> simd
      val sqrt = _prim "Simd128_Real32_sqrt": simd -> simd
      val fromArray = _prim "Simd128_Real32_fromArray": elt array -> simd
      val toArray = _prim "Simd128_Real32_toArray": simd -> elem array
      val fromScalar = _prim "Simd128_Real32_fromScalar": e -> simd
      val toScalar = _prim "Simd128_Real32_toScalar": simd -> e
  end
structure Simd128_Real64 : PRIM_SIMD_REAL =
  struct
    open  Simd128_Real64
    
    val vecSize : Int32.int = 128
    val realSize : Int32.int = 64

    type elt = Real64.real

      val add = _prim "Simd128_Real64_add": simd * simd -> simd
      val sub = _prim "Simd128_Real64_sub": simd * simd -> simd
      val mul = _prim "Simd128_Real64_mul": simd * simd -> simd
      val div = _prim "Simd128_Real64_div": simd * simd -> simd
      val min = _prim "Simd128_Real64_min": simd * simd -> simd
      val max = _prim "Simd128_Real64_max": simd * simd -> simd
      val andb = _prim "Simd128_Real64_andb": simd * simd -> simd
      val orb = _prim "Simd128_Real64_orb": simd * simd -> simd
      val andnb = _prim "Simd128_Real64_andnb": simd * simd -> simd
      val hadd = _prim "Simd128_Real64_hadd": simd * simd -> simd
      val hsub = _prim "Simd128_Real64_hsub": simd * simd -> simd
      val addsub = _prim "Simd128_Real64_addsub": simd * simd -> simd
      val sqrt = _prim "Simd128_Real64_sqrt": simd -> simd
      val fromArray = _prim "Simd128_Real64_fromArray": elt array -> simd
      val toArray = _prim "Simd128_Real64_toArray": simd -> elem array
      val fromScalar = _prim "Simd128_Real64_fromScalar": e -> simd
      val toScalar = _prim "Simd128_Real64_toScalar": simd -> e
  end
structure Simd256_Real32 : PRIM_SIMD_REAL =
  struct
    open  Simd256_Real32
    
    val vecSize : Int32.int = 256
    val realSize : Int32.int = 32

    type elt = Real32.real

      val add = _prim "Simd256_Real32_add": simd * simd -> simd
      val sub = _prim "Simd256_Real32_sub": simd * simd -> simd
      val mul = _prim "Simd256_Real32_mul": simd * simd -> simd
      val div = _prim "Simd256_Real32_div": simd * simd -> simd
      val min = _prim "Simd256_Real32_min": simd * simd -> simd
      val max = _prim "Simd256_Real32_max": simd * simd -> simd
      val andb = _prim "Simd256_Real32_andb": simd * simd -> simd
      val orb = _prim "Simd256_Real32_orb": simd * simd -> simd
      val andnb = _prim "Simd256_Real32_andnb": simd * simd -> simd
      val hadd = _prim "Simd256_Real32_hadd": simd * simd -> simd
      val hsub = _prim "Simd256_Real32_hsub": simd * simd -> simd
      val addsub = _prim "Simd256_Real32_addsub": simd * simd -> simd
      val sqrt = _prim "Simd256_Real32_sqrt": simd -> simd
      val fromArray = _prim "Simd256_Real32_fromArray": elt array -> simd
      val toArray = _prim "Simd256_Real32_toArray": simd -> elem array
      val fromScalar = _prim "Simd256_Real32_fromScalar": e -> simd
      val toScalar = _prim "Simd256_Real32_toScalar": simd -> e
  end
structure Simd256_Real64 : PRIM_SIMD_REAL =
  struct
    open  Simd256_Real64
    
    val vecSize : Int32.int = 256
    val realSize : Int32.int = 64

    type elt = Real64.real

      val add = _prim "Simd256_Real64_add": simd * simd -> simd
      val sub = _prim "Simd256_Real64_sub": simd * simd -> simd
      val mul = _prim "Simd256_Real64_mul": simd * simd -> simd
      val div = _prim "Simd256_Real64_div": simd * simd -> simd
      val min = _prim "Simd256_Real64_min": simd * simd -> simd
      val max = _prim "Simd256_Real64_max": simd * simd -> simd
      val andb = _prim "Simd256_Real64_andb": simd * simd -> simd
      val orb = _prim "Simd256_Real64_orb": simd * simd -> simd
      val andnb = _prim "Simd256_Real64_andnb": simd * simd -> simd
      val hadd = _prim "Simd256_Real64_hadd": simd * simd -> simd
      val hsub = _prim "Simd256_Real64_hsub": simd * simd -> simd
      val addsub = _prim "Simd256_Real64_addsub": simd * simd -> simd
      val sqrt = _prim "Simd256_Real64_sqrt": simd -> simd
      val fromArray = _prim "Simd256_Real64_fromArray": elt array -> simd
      val toArray = _prim "Simd256_Real64_toArray": simd -> elem array
      val fromScalar = _prim "Simd256_Real64_fromScalar": e -> simd
      val toScalar = _prim "Simd256_Real64_toScalar": simd -> e
  end
