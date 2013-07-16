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


fun fromBits (b: Bits.t): t =
   if Bits.>= (b, Bits.zero)
      then T b
   else Error.bug (concat ["WordSize.fromBits: strange word size: ", Bits.toString b])

datatype prim = V128 | V256

fun prim s =
    case Bits.toInt (bits s) of
        128 => V128
      | 256 => V256
      | _ => Error.bug "SimdSize.prim"

val prims = List.map ([128,256], fromBits o Bits.fromInt)

val all = prims

(*memoize from word*)
val allVector = Vector.fromList [SOME (T (Bits.fromInt 128)),
                                 SOME (T (Bits.fromInt 256))]
val memoize: (t -> 'a) -> t -> 'a =
   fn f =>
   let
      val v = Vector.map (allVector, fn opt => Option.map (opt, f))
   in
      fn s => valOf (Vector.sub (v, Bits.toInt (bits s)))
   end

val simdReals = List.concat(List.map (all,fn x => (List.map(RealSize.all,(fn y => (x,y))))))
(*(*memoize from real*)
val memoize: (t -> 'a) -> t -> 'a =
   fn f =>
   let
      val v128 = f V128
      val v256 = f V256
   in
      fn V128 => v128
       | V256 => v256
   end*)
(*val primReals = 
List.concat(List.map (fn x => List.map (fn y => (x,y)) RealSize.all) all);
val primWords = 
List.concat(List.map (fn x => List.map (fn y => (x,y)) WordSize.prims) all);
*)
end
