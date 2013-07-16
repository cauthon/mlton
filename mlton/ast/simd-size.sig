signature SIMD_SIZE_STRUCTS =
   sig
   end
signature SIMD_SIZE =
sig
  type t
  val bits: t -> Bits.t
  val bytes: t -> Bytes.t
  val equals: t * t -> bool
  val toString: t -> string
  val fromBits: Bits.t -> t
  datatype prim = V128 | V256
  val prim: t -> prim
  val prims: t list
  val all: t list
  val memoize: (t -> 'a) -> t -> 'a
end
