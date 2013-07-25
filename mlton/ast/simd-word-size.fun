functor SimdWordSize (S: SIMD_WORD_SIZE_STRUCTS): SIMD_WORD_SIZE =
(* For now I really should make SimdSize of the form of real and not word*)
struct
open S
type t' = WordSize.prim
datatype t  = V128WX of t'
            | V256WX of t'
val all'= [WordSize.W8,WordSize.W16,WordSize.W32,WordSize.W64]
local
  val temp128 = fn x => (V128WX x)
  val temp256 = fn x => (V256WX x)
in
val all = (List.map (all',temp128) @ List.map(all',temp256))
end
val bytes =
 fn (V128WX _) => Bytes.fromInt 128
  | (V256WX _) => Bytes.fromInt 256
local
  val temp =  fn x =>
                 case x of 
                     W8 => Bytes.fromInt 8
                   | W16 => Bytes.fromInt 16
                   | W32 => Bytes.fromInt 32
                   | W64 => Bytes.fromInt 64
in
  val wordBytes = 
   fn (V128WX x) => temp x
    | (V256WX x) => temp x
end
val bits = Bytes.toBits o bytes
val wordBits = Bytes.toBits o wordBytes
fun equals (s,s') = Bits.equals(bits s,bits s') andalso 
                    Bits.equals(wordBits s,wordBits s')
val toStringSimd = Bits.toString o bits
val toStringWord = Bits.toString o wordBits
val memoize: (t -> 'a) -> t -> 'a =
   fn f =>
   let
     fun v128wx x =  f (V128WX x)
     fun v256wx x =  f (V256WX x)
   in
     fn (V128WX x) => v128wx x
      | (V256WX x) => v256wx x
   end
end
