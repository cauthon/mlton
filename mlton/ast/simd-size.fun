functor SimdSize (S: SIMD_SIZE_STRUCTS): SIMD_SIZE =
struct
open S
datatype t = T of Bits.t
fun bits (T b) = b

val toString = Bits.toString o bits

fun isValidSize (i: int) =
    (i <> 0 andalso i mod 128 = 0)

val bytes: t -> Bytes.t = Bits.toBytes o bits

fun compare (s, s') = Bits.compare (bits s, bits s')

val {equals, ...} = Relation.compare compare
fun prim s =
    case Bits.toInt (bits s) of
        128 => V128
      | 256 => V256
      | _ => Error.bug "SimdSize.prim"
val prims = List.map ([128,256], fromBits o Bits.fromInt)
(* Right now I'm too lazy to think up a fancy higher order function
 * to map/concatinate lists
 * TODO: I should fix this, because if either of the types change this will
   fail*)
val primReals = 
    [((hd prims),R32),((hd prims),R64),((last prims),R32),((last prims),R64)]
end
