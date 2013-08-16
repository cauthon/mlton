local
local
  type word = Word16.word
in
  structure S = Simd128_Word16
  val a1:word array = Array.fromList([0w15,0w1,0w2,0w3,0w4,0w5,0w6,0w7])
  val a2:word array = Array.fromList([0w10,0w21,0w32,0w43,0w54,0w65,0w76,0w87])
  val temp:word array = Array.array(8,0w0)
end
in
  val a1':S.simdWord = S.fromArray(a1)
  val a2':S.simdWord = S.fromArray(a2)
  val _ = S.toArray(temp,a1')
  val _ = TextIO.print("First element of a1: "^(Word16.toString(Array.sub(temp,0)))^"\n")
end
