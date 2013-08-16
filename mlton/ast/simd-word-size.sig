signature SIMD_WORD_SIZE_STRUCTS =
  sig
  end
signature SIMD_WORD_SIZE =
sig
  datatype t = V128W8
             | V128W16
             | V128W32
             | V128W64
  val bits: t -> Bits.t
  val wordBits: t -> Bits.t
  val bytes: t -> Bytes.t
  val wordBytes: t -> Bytes.t
  val memoize: (t -> 'a) -> t -> 'a
  val all: t list
  val equals: t*t -> bool
  val toStringWord: t -> string
  val toStringSimd: t -> string
end

