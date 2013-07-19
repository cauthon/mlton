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
signature SIMD_REAL_STRUCTS =
  sig
  end
signature SIMD_REAL =
sig
  datatype t = V128R32 | V128R64
             | V256R32 | V256R64
  val bits: t -> Bits.t
  val bypes: t -> Bytes.t
  val memoize: (t -> 'a) -> t -> 'a
  val all: t list
  val equals: t*t -> bool
  val toStringReal: t -> string
  val toStringSimd: t -> string
end
signature SIMD_WORD_STRUCTS =
  sig
  end
signature SIMD_WORD =
sig
  datatype t = V128W8 | V128W16 | V128W32 | V128W64
             | V256W8 | V256W16 | V256W32 | V256W64
  val bits: t -> Bits.t
  val bypes: t -> Bytes.t
  val memoize: (t -> 'a) -> t -> 'a
  val all: t list
  val equals: t*t -> bool
  val toStringWord: t -> string
  val toStringSimd: t -> string
end
