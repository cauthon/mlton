structure Simd128Word32 : SIMD_REAL =
struct
  val vec_size = 128
  val real_size = 32
(*I suppose this should be a conditonal for sse, but all 64 bit
 *computers have sse*)
  val add = _prim "Simd128_Real32_add"
(*...*)
  val andnb = _prim "Simd128_Real32_andn"
(*conditional for sse3*)
  val hadd = _prim "Simd128_Real32_hadd"
  val hsub = _prim "Simd128_Real32_hsub"
  val addsub = _prim "Simd128_Real32_addsub"
(*if we don't have prims*)
  val hadd = SoftwareSSE3.hadd
  val hsub = SoftwareSSE3.hsub
  val addsub = Software SSE3.addsub
(*endif*)
(*non primitives*)
(*val not = andn 0xffffffffffffffffffffffffffffffff s*)
end                        
structure Simd128Word64 : SIMD_REAL =
struct
  val vec_size = 128
  val real_size = 64
  val add = _prim "Simd128_Real64_add"
(*...*)
  val andnb = _prim "Simd128_Real64_andn"
(*conditional for sse3*)
  val hadd = _prim "Simd128_Real64_hadd"
  val hsub = _prim "Simd128_Real64_hsub"
  val addsub = _prim "Simd128_Real64_addsub"
(*if we don't have prims*)
  val hadd = SoftwareSSE3.hadd
  val hsub = SoftwareSSE3.hsub
  val addsub = Software SSE3.addsub
(*endif*)
(*non primitives*)
(*val not = andn 0xffffffffffffffffffffffffffffffff s*)
end
(*structure Simd256Word32 : SIMD_REAL =
struct
  val vec_size = 256
  val real_size = 32
  val add = _prim "Simd256_Real32_add"
(*...*)
  val andnb = _prim "Simd256_Real32_andn"
(*conditional for sse3*)
  val hadd = _prim "Simd256_Real32_hadd"
  val hsub = _prim "Simd256_Real32_hsub"
  val addsub = _prim "Simd256_Real32_addsub"
(*if we don't have prims*)
  val hadd = SoftwareSSE3.hadd
  val hsub = SoftwareSSE3.hsub
  val addsub = Software SSE3.addsub
(*endif*)
(*non primitives*)
(*val not = andn 0xffffffffffffffffffffffffffffffff s*)
end                        
structure Simd256Word64 : SIMD_REAL =
struct
  val vec_size = 256
  val real_size = 64
  val add = _prim "Simd256_Real64_add"
(*...*)
  val andnb = _prim "Simd256_Real64_andn"
(*conditional for sse3*)
  val hadd = _prim "Simd256_Real64_hadd"
  val hsub = _prim "Simd256_Real64_hsub"
  val addsub = _prim "Simd256_Real64_addsub"
(*if we don't have prims*)
  val hadd = SoftwareSSE3.hadd
  val hsub = SoftwareSSE3.hsub
  val addsub = Software SSE3.addsub
(*endif*)
(*non primitives*)
(*val not = andn 0xffffffffffffffffffffffffffffffff s*)
end*)
