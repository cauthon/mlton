signature SIMD_REAL_SIZE_STRUCTS =
  sig
    (*    RealSize:REAL_SIZE(*needed for real fxn*)*)
  end
signature SIMD_REAL_SIZE =
sig
  datatype t = V128R32 | V128R64
             | V256R32 | V256R64
  val all: t list
  val bits: t -> Bits.t
  val bytes: t -> Bytes.t
  val equals: t*t -> bool
  val equalsSimd: t*t -> bool
  val equalsReal: t*t -> bool
  val memoize: (t -> 'a) -> t -> 'a
  val realBits: t -> Bits.t
  val realBytes: t -> Bytes.t
  val toStringReal: t -> string
  val toStringSimd: t -> string
(*  datatype cmp = cmpeq | cmplt | cmple | cmpunord
               | cmpneq | cmpnlt | cmpnle | cmpord
  val cmp:cmp -> int
  val cmpString: cmp -> string*)
end
