functor SimdSize (S: SIMD_SIZE_STRUCTS): SIMD_SIZE =
(* For now I really should make SimdSize of the form of real and not word*)
struct
open S
datatype t = V128R32 | V128R64 | V128WX
           | V256R32 | V256R64 | V256WX
val all = [V128R32, V128R64, V128WX, V256R32, V256R64, V256WX]
val prims = all
val equals = op =
val bytes = 
 fn V128R32 => Bytes.fromInt 16
  | V128R64 => Bytes.fromInt 16
  | V128WX => Bytes.fromInt 16
  | V256R32 => Bytes.fromInt 32
  | V256R64 => Bytes.fromInt 32
  | V256WX => Bytes.fromInt 32
val bits = Bytes.toBits o bytes
val toString =
 fn V128R32 => "128"
  | V128R64 => "128"
  | V128WX => "128"
  | V256R32 => "256"
  | V256R64 => "256"
  | V256WX => "256"
val toStringReal =
 fn V128R32 => "32"
  | V128R64 => "64"
  | V128WX => Error.bug "simd-size.toStringReal"
  | V256R32 => "32"
  | V256R64 => "64"
  | V256WX => Error.bug "simd-size.toStringReal"
val memoize: (t -> 'a) -> t -> 'a =
   fn f =>
   let
     val v128r32 => f V128R32
     val v128r64 => f V128R64
     val v128wx =>  f V128WX
     val v256r32 => f V256R32
     val v256r64 => f V256R64
     val v256wx =>  f V256WX
   in
     fn  V128R32 => v128r32
   | V128R64 => v128r64
   | V128WX => v128wx
   | V256R32 => v256r32
   | V256R64 => v256r64
   | V256WX => v256wx 
   end
(*we need to be able to construct  simdReal and simdReals vals in prim-tycons
 *to do this we need vals all,bits,equals and memoize for simdReals*)
(*structure SimdReal =
  struct
  type t = t*RealSize.t
  val all = List.concat(List.map 
                          (all,fn x => (List.map
                                          (RealSize.all,(fn y => (x,y))))))
  val bits = fn (s,_) => bits (s)
  val bytes = fn (s,_) => bytes (s)
  val equals = fn ((s,r),(s',r')) => equals (s,s') andalso
                                     RealSize.equals (r,r')
  fun toStringReal (_,r) = RealSize.toString r
  val toStringSimd = fn (s,_) => toString s
  val memoize = 
   fn f =>
      let
        val v128r32 = f (V128,RealSize.R32)
        val v128r64 = f (V128,RealSize.R64)
        val v256r32 = f (V256,RealSize.R32)
        val v256r64 = f (V256,RealSize.R64)
      in
        fn (V128,RealSize.R32) => v128r32
         | (V128,RealSize.R64) => v128r64
         | (V256,RealSize.R32) => v256r32
         | (V256,RealSize.R64) => v256r64
      end
  end
(*structure SimdWord
  type t = t*WordSize.t
  allWords = List.map WordSize.prims WordSize.prim
  val all = List.concat(List.map 
                          (all,fn x => (List.map
                                          (allWords,(fn y => (x,y))))))
  val bits = fn (s,_) => bits (s)
  val bytes = fn (s,_) => bytes (s)
  val equals = fn ((s,w),(s',w')) => equals (s,s') andalso
                                     WordSize.equals (r,w')
  fun toStringWord (_,w) = WordSize.toString r
  val toStringSimd = fn (s,_) => toString s
  local
  val memoize = 
   fn f =>
  
end
  
(*in word-esq form*)

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
*)*)
end
functor SimdReal (S: SIMD_REAL_STRUCTS): SIMD_REAL =
(* For now I really should make SimdSize of the form of real and not word*)
struct
open S
datatype t = V128R32 | V128R64
           | V256R32 | V256R64
val all = [V128R32, V128R64, V256R32, V256R64]
val equals = op =
val bytes = 
 fn V128R32 => Bytes.fromInt 16
  | V128R64 => Bytes.fromInt 16
  | V256R32 => Bytes.fromInt 32
  | V256R64 => Bytes.fromInt 32
val realBytes =
 fn V128R32 => Bytes.fromInt 4
  | V128R64 => Bytes.fromInt 8
  | V256R32 => Bytes.fromInt 4
  | V256R64 => Bytes.fromInt 8
val bits = Bytes.toBits o bytes
val realBits = Bytes.toBits o realBytes
val toStringSimd =
 fn V128R32 => "128"
  | V128R64 => "128"
  | V256R32 => "256"
  | V256R64 => "256"
val toStringReal =
 fn V128R32 => "32"
  | V128R64 => "64"
  | V256R32 => "32"
  | V256R64 => "64"
val memoize: (t -> 'a) -> t -> 'a =
   fn f =>
   let
     val v128r32 => f V128R32
     val v128r64 => f V128R64
     val v256r32 => f V256R32
     val v256r64 => f V256R64
   in
     fn  V128R32 => v128r32
   | V128R64 => v128r64
   | V256R32 => v256r32
   | V256R64 => v256r64
   end
