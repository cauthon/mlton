(* Copyright (C) 2013 Tucker DiNapoli
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)
signature SOFTWARE_SIMD_REAL_STRUCTS =
sig
  type elt
  type simdReal
  structure Real:REAL
  structure Word:WORD
  val elements:Int32.int
  val vecSize:Int32.int
  val realSize:Int32.int
  val simdBinOp:simdReal*simdReal*(elt*elt->elt)->simdReal
  val toArray:elt array * simdReal * Int32.int -> unit
  val toList:simdReal -> elt list
  val fromArray:elt array * Int32.int -> simdReal
(*for compairsons*)
  val negNaN:real
  val posZero:real
  val toWord:Real.real -> Word.word
  val fromWord:Word.word -> Real.real
  val shuffle:simdReal*simdReal*
              (Word8.word*Word8.word*Word8.word*Word8.word) -> simdReal
  sharing type Real.real = elt
end

functor SoftwareSimdReal(S: SOFTWARE_SIMD_REAL_STRUCTS):SIMD_REAL =
struct
  open S
  type elt = real
  type simdReal = real*real*real*real
  fun toStringGeneric f s =
      let
        fun mane (ls,str) =
            case ls of
                x::[] => concat ("("::(f x)::str)
              | x::xs => make(xs,(","::(f x)::str))
      in
        make (toList s,[")"])
      end
  val toString = toStringGeneric Real.toString
  val fmt = fn f => fn s =>
               toStringGeneric (Real.fmt f) s
  val toStringScalar = Real.toString o #1
  val fromArray = fn x => fromArray (x,0)
  val toArray = fn (x,y) => fromArray (x,y,0)
  val fromArrayOffset = fromArray
  fun toList s as (a,b,c,d) = [a,b,c,d]
  fun fromList (a::b::c::d::_) = (a,b,c,d)
  fun mkBinOp f = fn (x,y) => simdBinOp (x,y,f)
  val add = mkBinOp Real.+
  val sub = mkBinOp Real.-
  val mul = mkBinOp Real.*
  val div = mkBinOp Real.div
(*kind of a hack here to do a one argument function, but since its
 *the only one it should be fine*)
  local
    val tempSqrt (x,y) => Real.Math.sqrt x
  in
  fun sqrt s = simdBinOp(s,s,tempSqrt)
  end
  val min = mkBinOp Real.min
  val max = mkBinOp Real.max
  local
(*this might need to be part of the functor argument because 
 *things work differently for 128 and 256 bit values*)
    fun hop (s1:simdReal,s2:simdReal,f:(elt*elt->elt)):simdReal =
        let
          val l1 = toList s1
          val l2 = toList s2
          val doit = fn (x,y,z) =>
                        case (x,y,z) of
                            ([],[],z) => fromList z
                          | ((n::m::x),y,z) => doit(x,y,(f(n,m)::z))
                          | ([],(n::m::y),z) => doit([],y,(f(n,m)::z))
        in doit (l1,l2,[]) end
  in
  val hadd = fn (x,y) => hop(x,y,Real.+)
  val hsub = fn (x,y) => hop(x,y,Real.-)
  end
  fun addsub (s1,s2) =
      let 
        val l1 = toList s1
        val l2 = toList s2
        fun doit ([],[],z,_) = fromList z
          | doit ((x::xs),(y::ys),z,f) =
            if f then
              doit(xs,ys,(Real.-(x,y)::z),false)
            else
              doit(xs,ys,(Real.+(x,y)::z),true)
      in doit(l1,l2,[],true) end
  local
    fun simdBinLp (f:Word.word*Word.word->Word.word):elt*elt->elt =
        fn (x,y) => fromWord(f(toWord(x),toWord(y)))
  in
  val andb = mkBinOp(simdBinLp Word.andb)
  val orb = mkBinOp(simdBinLp Word.orb)
  val xorb = mkBinOp(simdBinLp Word.xorb)
  val andnb = mkBinop(simbBinLp Word.notb o Word.andb)
  local
    open Word8
    infix 4 >>
  in
    fun decodeShuffleConst(w:word) =
        ((andb(w,192)>>0w6),(andb(w,48)>>0w4),(andb(w,12)>>0w2),andb(w,3))
  end
  fun primitiveShuffle(s1,s2,w) = 
      shuffle(s1,s2,decodeShuffleConst(w))                      
  datatype cmp = eq  | lt  | gt  | le  | ge  | ord
               | ne  | nlt | ngt | nle | nge | unord
  fun cmp (s1:simdReal,s2:simdReal,c:cmp) =
      let
        fun IEEECmp (ord:IEEEReal.real_order,not:bool->bool) =
            fn(x,y)
              if not(ord = Real.compareReal(x,y)) then
                negNaN else posZero
        val t:bool->bool = fn x => x
        val f:bool->bool = Bool.not
        fun doit (ord:IEEEReal.real_order,not:bool->bool):simdReal =
            simdBinOp(s1,s2,(IEEECmp(ord,not)))
      in            
      case c of
          eq => doit(IEEEReal.EQUAL,t)
        | lt => doit(IEEEReal.LESS,t)
        | gt => doit(IEEEReal.GREATER,t)
        | le => doit(IEEEReal.GREATER,f)
        | ge => doit(IEEEReal.LESS,f)
        | ne => doit(IEEEReal.EQUAL,f)
        | nlt => doit(IEEEReal.LESS,f)
        | ngt => doit(IEEEReal.GREATER,f)
        | nle => doit(IEEEReal.GREATER,t)
        | nge => doit(IEEEReal.LESS,t)
        | ord => doit(IEEEReal.UNORDERED,f)
        | unord => doit(IEEEReal.UNORDERED,t)
      end
  fun primitiveCmp (s1:simdReal,s2:simdReal,c:Word8.word) = let
    val imm = case c of
                  0w0 => eq
                | 0w1 => lt  
                | 0w6 => gt 
                | 0w2 => le 
                | 0w5 => ge 
                | 0w4 => ne
                | 0w5 => nlt 
                | 0w2 => ngt 
                | 0w6 => nle 
                | 0w1 => nge
                | 0w7 => ord
                | 0w3  => unord
  in
    cmp(s1,s2,imm)
  end
structure Simd128_Real32 = SoftwareSimdReal(
 struct
  structure Real = Real32
  structure Word = Word32
  open Real
  type elt = real
  type simdReal = real*real*real*real
  val elements = 4
  val vecSize = 128
  val realSize = 32
  fun simdBinOp (s1 as (a1,b1,c1,d1),s2 as (a2,b2,c2,d2),f) =
      (f(a1,a2),f(b1,b2),f(c1,c2),f(d1,d2))
  fun toArray (a,s as (s1,s2,s3,s4),i) =
      (Array.update(a,i,s1);Array.update(a,i+1,s2);
       Array.update(a,i+2,s3);Array.update(a,i+3,s4))
  fun fromArray (a,i) =
      (Array.sub(i),Array.sub(i+1),Array.sub(i+2),Array.sub(i+3))
  local
    open Primitive.PackReal32
  in
     val toWord = castToWord
     val fromWord = castFromWord
  end
  val negNaN = fromWord 0wxffffffff
  val posZero = fromWord 0wx00000000
  fun shuffle (s1, s2, (w1,w2,w3,w4))=
   let
     fun select(s:simdWord,w:Word8.word) =
         case w of
             0w0 => #1(s)
           | 0w1 => #2(s)
           | 0w2 => #3(s)
           | 0w3 => #4(s)
           | _ => raise Fail "Out of bounds shuffle index"
   in
     (select(s1,w1),select(s1,w2),select(s2,w3),select(s2,w4))
   end)
structure Simd128_Real64 = SoftwareSimdReal(
 struct
  structure Real = Real64
  structure Word = Word64
  open Real
  type elt = real
  type simdReal = real*real
  val elements = 2
  val vecSize = 128
  val realSize = 64
  fun simdBinOp (s1 as (a1,b1),s2 as (a2,b2),f) =
      (f(a1,a2),f(b1,b2))
  fun toArray (a,s as (s1,s2),i) =
      (Array.update(a,i,s1);Array.update(a,i+1,s2))
  fun fromArray (a,i) =
      (Array.sub(i),Array.sub(i+1))
  local
    open Primitive.PackReal64
  in
     val toWord = castToWord
     val fromWord = castFromWord
  end
  val negNaN = fromWord 0wxffffffffffffffff
  val posZero = fromWord 0wx0000000000000000
  fun shuffle (s1, s2, (w1,w2,_w3,_w4))=
   let
     fun select(s:simdWord,w:Word8.word) =
         case w of
             0w0 => #1(s)
           | 0w1 => #2(s)
           | _ => raise Fail "Out of bounds shuffle index"
   in
     (select(s1,w1),select(s2,w2))
   end)
