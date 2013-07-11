signature SIMD_SIZE =
sig
  type t
  val bits: t -> Bits.t
  val bytes: t -> Bytes.t
  val equals: t * t -> bool
  val toString: t -> string
end
