local
  open Word32
  open Simd128_Word32
  val one = 0wxffffffff:elt
in
(*  val simdW32_1 = fromArray(Array.array(elements,one))*)
  val simdW32_not = fn x => andnb(fromArray(Array.array(elements,one)),x)
end
local
  open Word16
  open Simd128_Word16
  val one = 0wxffff:elt
in
  val W16_1 = Array.array(elements,one)
  val simdW16_1 = fromArray(W16_1)
  val simdW16_not = fn x => andnb(x,simdW16_1)
end
val sw16 = Simd128_Word16.fromArray(Array.fromList([0w10,0w20,0w30,0w40,0w1000,0w1024,0w2048,0w4096]))
val sw16' = simdW16_not(sw16)
val _ = TextIO.print ("a simd128word16 value"^ Simd128_Word16.toString(sw16)^
                      "\nbitwise not of that value"^Simd128_Word16.toString(sw16') ^"\n")
