local
  type real = Real32.real
in
  val a1:real array=Array.fromList([1.0,2.0,3.0,4.0])
  val a2:real array=Array.fromList([10.0,20.0,30.0,40.0])
  val a3:real array=Array.fromList([5.0,6.0,7.0,8.0])
  val a4:real array=Array.fromList([9.0,90.0,900.0,9000.0])
end
local
  type real = Real64.real
in
  val b1=Array.fromList([1.0,2.0])
  val b2=Array.fromList([3.0,4.0])
  val b3=Array.fromList([10.0,20.0])
  val b4=Array.fromList([~1000.0,1000.0])
end
local
  open Word8
  infix 4 <<
in
fun mkSC(w1:word,w2:word,w3:word,w4:word):word =
    orb(w4 << 0w6,orb(w3 << 0w4,orb(w2 << 0w2,w1 << 0w0)))
end
local
  type word = Word8.word
in
  type w8 = Word8.word*Word8.word*Word8.word*Word8.word
  val sc1:word=mkSC(0w1,0w3,0w2,0w0)
  val sct1:w8=(0w1,0w3,0w2,0w0)
  val sc2:word=mkSC(0w2,0w2,0w2,0w2)
  val sct2:w8=(0w2,0w2,0w2,0w2)
  val sc3:word=mkSC(0w3,0w2,0w1,0w0)
  val sct3:w8=(0w3,0w2,0w1,0w0)
  val sc4:word=mkSC(0w0,0w1,0w2,0w3)
  val sct4:w8=(0w0,0w1,0w2,0w3)
  fun w8_toString (w:w8) =
      let
        val f = Word8.toString
      in
      concat(["(",f(#1w),",",f(#2w),",",f(#3w),",",f(#4w),")"])    
      end  
end
local
  structure S = Simd128_Real32

fun expected_String (arr,arr',SCtuple:w8)=
    let
      val f = Word8.toInt
    in
    concat(["(",S.toStringElt(Array.sub(arr,f(#1SCtuple))),
            ",",S.toStringElt(Array.sub(arr,f(#2SCtuple))),
            ",",S.toStringElt(Array.sub(arr',f(#3SCtuple))),
            ",",S.toStringElt(Array.sub(arr',f(#4SCtuple))),")"])
    end
in
fun testShuffle32(arr,arr',sc:Word8.word,SCtuple:w8):unit=
let
  val simd = S.fromArray(arr)
  val simd'= S.fromArray(arr')
  val shufImm = w8_toString(SCtuple)
  val init = concat(["Arg1 = ",S.toString(simd)," and Arg2 = ",S.toString(simd')])
  val shuf1 = S.toString(S.primitiveShuffle(simd,simd',sc))
  val shuf3 = S.toString(S.shuffle(simd,simd',SCtuple))
  val expected = expected_String(arr,arr',SCtuple)
in
  TextIO.print(concat["Testing Shuffle using ",init," and ",shufImm,"\n",
                      "result of shuffle with imm = ",Word8.toString(sc),": ",
                      shuf1,"\n","result of shuffle with tuple = ",shufImm,
                      ": ",shuf3,"\n","Expected result: ",expected,"\n"])
end
end                    
local
  structure S = Simd128_Real64
  fun expected_String (arr,arr',SCtuple:w8)=
    let
      val f = Word8.toInt
    in
    concat(["(",S.toStringElt(Array.sub(arr,f(#1SCtuple))),
            ",",S.toStringElt(Array.sub(arr',f(#2SCtuple))),")"])
    end
in
fun testShuffle64(arr,arr',sc:Word8.word,SCtuple:w8):unit=
let
  val simd = S.fromArray(arr)
  val simd'= S.fromArray(arr')
  val shufImm = w8_toString(SCtuple)
  val init = "Arg1 = " ^ S.toString(simd) ^ " and Arg2 = " ^ S.toString(simd')
  val shuf1 = S.toString(S.primitiveShuffle(simd,simd',sc))
  val shuf3 = S.toString(S.shuffle(simd,simd',SCtuple))
  val expected = expected_String(arr,arr',SCtuple)
in
  TextIO.print(concat["Testing Shuffle using ",init," and ",shufImm,"\n",
                      "result of shuffle with imm = ",Word8.toString(sc),": ",
                      shuf1,"\n","result of shuffle with tuple = ",shufImm,
                      ": ",shuf3,"\n","Expected result: ",expected,"\n"])
end
end
val _ = testShuffle32(a1,a2,sc1,sct1)
val _ = testShuffle32(a1,a2,sc2,sct2)
val _ = testShuffle32(a3,a4,sc3,sct3)
val _ = testShuffle32(a3,a4,sc4,sct4)
val _ = testShuffle64(b1,b2,sc4,sct4)
val _ = testShuffle64(b1,b2,sc4,sct4)
val _ = testShuffle64(b3,b4,sc4,sct4)
val _ = testShuffle64(b3,b4,sc4,sct4)
