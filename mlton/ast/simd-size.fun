functor SimdSize (S: SIMD_SIZE_STRUCTS): SIMD_SIZE =
(* For now I really should make SimdSize of the form of real and not word*)
struct
open S
datatype t = V128 | V256
val all = [V128, V256]
val prims = all
val equals = op =
val bytes = 
 fn V128 => Bytes.fromInt 16
  | V256 => Bytes.fromInt 32
val bits = Bytes.toBits o bytes
val toString =
 fn V128 => "128"
  | V256 => "256"
val memoize: (t -> 'a) -> t -> 'a =
   fn f =>
   let
      val v128 = f V128
      val v256 = f V256
   in
      fn V128 => v128
       | V256 => v256
   end
(*we need to be able to construct  simdReal and simdReals vals in prim-tycons
 *to do this we need vals all,bits,equals and memoize for simdReals*)
structure SimdReal =
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

(*memoize from word*)
(*memoize seems to be of the form
fn f:(t -> 'a) => let val x0 = f (first all)...val xn = f (last all)
in fn s:t => n:'a; where if s=(first all) n =x0...s=(last all), n=xn*)
val memoize: (t -> 'a) -> t -> 'a =
   fn f =>
   let
     val v128 = f (T (Bits.fromInt 128))
     val v256 = f (T (Bits.fromInt 256))
   in
     fn (T (Bits.fromInt 128)) => v128
      | (T (Bits.fromInt 256)) => v256
   end

(*val memoize:(t -> 'a) -> t -> a =*)
(*(*memoize from real*)
val memoize: (t -> 'a) -> t -> 'a =
   fn f =>
   let
      val v128 = f V128
      val v256 = f V256
   in
      fn V128 => v128
       | V256 => v256
   end*)*)
end
