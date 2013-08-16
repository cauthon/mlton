functor SimdWordSize (S: SIMD_WORD_SIZE_STRUCTS): SIMD_WORD_SIZE =
struct
open S
datatype t  = V128W8
       | V128W16
       | V128W32
       | V128W64
val all = [V128W8,V128W16,V128W32,V128W64]

val bytes =
 fn w =>
    case w of
        V128W8 => Bytes.fromInt 16
      | V128W16 => Bytes.fromInt 16
      | V128W32 => Bytes.fromInt 16
      | V128W64 => Bytes.fromInt 16
val wordBytes = 
   fn w =>
      case w of 
    V128W8 => Bytes.fromInt 1
    | V128W16 => Bytes.fromInt 2
    | V128W32 => Bytes.fromInt 4
    | V128W64 => Bytes.fromInt 8
val bits = Bytes.toBits o bytes
val wordBits = Bytes.toBits o wordBytes
fun equals (s,s') = Bits.equals(bits s,bits s') andalso 
                    Bits.equals(wordBits s,wordBits s')
val toStringSimd = Bits.toString o bits
val toStringWord = Bits.toString o wordBits
val memoize: (t -> 'a) -> t -> 'a =
   fn f =>
   let
     val v128w8 =  f V128W8
     val v128w16 =  f V128W16
     val v128w32 =  f V128W32
     val v128w64 =  f V128W64
   in
     fn V128W8 => v128w8
     | V128W16 => v128w16
     | V128W32 => v128w32
     | V128W64 => v128w64
   end
end
