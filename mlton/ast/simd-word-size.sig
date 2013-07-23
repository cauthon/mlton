signature SIMD_WORD_STRUCTS =
  sig
    structure WordSize:WORD_SIZE
  end
signature SIMD_WORD =
sig
  type t'
  datatype t = V128WX of t'
             | V256WX of t'
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

