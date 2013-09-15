signature SIMD_NOT = sig
  structure Simd:SIMD_WORD
  structure Word:WORD
  val one:Simd.elt
  sharing type Simd.elt=Word.word
end
functor SimdNot(S:SIMD_NOT)=
struct
  local
    open S
    open Word
    open Simd
    val temp = fromArray(Array.array(elements,one))
  in
    val simdNot = fn x => andnb(x,temp)
  end
end
structure Simd128_Word16_notb = SimdNot(structure Simd = Simd128_Word16
                                        structure Word = Word16
                                        val one = 0wxffff:Word16.word)
val sw16 = (Simd128_Word16.fromArray(Array.fromList([0w10,0w20,0w30,0w40,0w1000,0w1024,0w2048,0w4096])))
val sw16' = Simd128_Word16_notb.simdNot(sw16)
val _ = TextIO.print ("a simd128word16 value"^ Simd128_Word16.toString(sw16)^
                      "\nbitwise not of that value"^Simd128_Word16.toString(sw16') ^"\n")
