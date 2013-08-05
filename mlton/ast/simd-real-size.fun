functor SimdRealSize (S: SIMD_REAL_SIZE_STRUCTS): SIMD_REAL_SIZE =
struct
open S
datatype t = V128R32 | V128R64
           | V256R32 | V256R64
val all = [V128R32, V128R64, V256R32, V256R64]
(*val real =
 fn V128R32 => RealSize.R32
  | V128R64 => RealSize.R64
  | V256R32 => RealSize.R32
  | V256R64 => RealSize.R64*)
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
fun allBits s = (bits s,realBits s)
fun equals (s,s') = op=(bits s,bits s') andalso op=(realBits s,realBits s')
fun equalsSimd (s,s') = op=(bits s,bits s')
fun equalsReal (s,s') = op=(realBits s,realBits s')
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
     val v128r32 = f V128R32
     val v128r64 = f V128R64
     val v256r32 = f V256R32
     val v256r64 = f V256R64
   in
     fn  V128R32 => v128r32
       | V128R64 => v128r64
       | V256R32 => v256r32
       | V256R64 => v256r64
   end
(*datatype cmp = cmpeq | cmplt | cmple | cmpunord
               | cmpneq | cmpnlt | cmpnle | cmpord
fun cmp (c:cmp) =
    case c of
        cmpeq => 0
      | cmplt => 1
      | cmple => 2
      | cmpunord => 3
      | cmpneq => 4
      | cmpnlt => 5
      | cmpnle => 6
      | cmpord => 7
fun cmpString (c:cmp) =
    case c of
        cmpeq => "cmpeq"
      | cmplt => "cmplt"
      | cmple => "cmple"
      | cmpunord => "cmpunord"
      | cmpneq => "cmpneq"
      | cmpnlt => "cmpnlt"
      | cmpnle => "cmpnle"
      | cmpord => "cmpord"
fun cmpFromInt (i:int) =
    case i of
        0 => cmpeq
      | 1 => cmplt
      | 2 => cmple
      | 3 => cmpunord
      | 4 => cmpneq
      | 5 => cmpnlt
      | 6 => cmpnle
      | 7 => cmpord
      | _ => Error.bug "SimdRealSize.cmp"*)
   end
