signature SIMD_SIZE_STRUCTS =
   sig
     structure RealSize: REAL_SIZE
   end
signature SIMD_TYPED =
sig
  type t
  val bits: t -> Bits.t
  val bytes: t -> Bytes.t
  val equals: t*t -> bool
  val all: t list
  val memoize: (t -> 'a) -> t -> 'a
  val toStringReal: t -> string
  val toStringSimd: t -> string
end
signature SIMD_SIZE =
sig
  type t
  val bits: t -> Bits.t
  val bytes: t -> Bytes.t
  val equals: t * t -> bool
  val toString: t -> string
(*  val fromBits: Bits.t -> t
  datatype prim = V128 | V256
  val prim: t -> prim*)
  val prims: t list
  val all: t list
  val memoize: (t -> 'a) -> t -> 'a
  structure SimdReal: SIMD_TYPED
end
