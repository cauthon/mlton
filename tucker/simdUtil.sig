signature SIMD_UTIL_REAL_STRUCTS =
sig
  structure SimdReal:SIMD_REAL
end
signature SIMD_UTIL_REAL =
sig
  type t(*simd type*)
  type e(*element type*)
  val simdFold:e*e array*(t*t->t)->e
  val simdMap:e seq*(t*t->t)->seq
         
  
