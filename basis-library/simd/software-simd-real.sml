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
  val toArray:elt array * Int32.int * simdReal-> unit
  val fromArray:elt array * Int32.int -> simdReal
  val toList:simdReal -> elt list
  val fromList:elt list -> simdReal
(*for compairsons*)
  val negNaN:Real.real
  val posZero:Real.real
  val toWord:Real.real -> Word.word
  val fromWord:Word.word -> Real.real
  val shuffle:simdReal*simdReal*
              (Word8.word*Word8.word*Word8.word*Word8.word) -> simdReal
  val fromScalar: elt -> simdReal
  val toScalar: simdReal -> elt
  val fromScalarFill: elt -> simdReal
  sharing type elt = Real.real
end

functor SoftwareSimdReal(S: SOFTWARE_SIMD_REAL_STRUCTS):SIMD_REAL =
struct
  open S
  type elt = S.elt
  type simdReal = S.simdReal
  fun toStringGeneric f s =
      let
        fun make (ls,str) =
            case ls of
                x::[] => concat ("("::(f x)::str)
              | x::xs => make(xs,(","::(f x)::str))
              | [] => raise Empty
      in
        make (toList s,[")"])
      end
  val toString = toStringGeneric Real.toString
  val fmt = fn f => fn s =>
               toStringGeneric (Real.fmt f) s
  val toStringScalar = (Real.toString o toScalar)
  fun fmtScalar f s = let
    val temp = toScalar s
  in (Real.fmt f) temp end
  val toStringElt = Real.toString
  val toArrayOffset = toArray
  val toArray = fn (x,y) => toArrayOffset (x,0,y)
  val fromArrayOffset = fromArray
  val fromArray = fn x => fromArrayOffset (x,0)
  fun mkBinOp f = fn (x,y) => simdBinOp (x,y,f)
  val add = mkBinOp Real.+
  val sub = mkBinOp Real.-
  val mul = mkBinOp Real.*
  nonfix div
  val div = mkBinOp Real./
  val min = mkBinOp Real.min
  val max = mkBinOp Real.max
(*kind of a hack here to do a one argument function, but since its
 *the only one it should be fine*)
  local
    fun tempSqrt (x,y) = Real.Math.sqrt x
  in
    fun sqrt s = simdBinOp(s,s,tempSqrt)
  end
  local
(*this might need to be part of the functor argument because 
 *things work differently for 128 and 256 bit values*)
    fun hop (s1:simdReal,s2:simdReal,f:(S.elt*S.elt->S.elt)):simdReal =
        let
          val l1 = toList s1
          val l2 = toList s2
          val rec  doit = fn (x,y,z) =>
                        case (x,y,z) of
                            ([],[],z) => fromList z
                          | ((n::m::x),y,z) => doit(x,y,(f(n,m)::z))
                          | ([],(n::m::y),z) => doit([],y,(f(n,m)::z))
                          | _ => raise Empty
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
          | doit (_) = raise Empty
      in doit(l1,l2,[],true) end
  local
    fun simdBinLp (f:Word.word*Word.word->Word.word):elt*elt->elt =
        fn (x,y) => fromWord(f(toWord(x),toWord(y)))
  in
  val andb = mkBinOp(simdBinLp Word.andb)
  val orb = mkBinOp(simdBinLp Word.orb)
  val xorb = mkBinOp(simdBinLp Word.xorb)
  val andnb = mkBinOp(simdBinLp (Word.notb o Word.andb))
  end
  local
    open Word8
    infix 4 >>
  in
    fun decodeShuffleConst(w:word) =
        ((andb(w,0w192)>>0w6),(andb(w,0w48)>>0w4),(andb(w,0w12)>>0w2),andb(w,0w3))
  end
  fun primitiveShuffle(s1,s2,w) = 
      shuffle(s1,s2,decodeShuffleConst(w))                      
  datatype cmp = eq  | lt  | gt  | le  | ge  | ord
               | ne  | nlt | ngt | nle | nge | unord
  local
    type real = elt
  in
  fun cmp (s1:simdReal,s2:simdReal,c:cmp) =
      let
        fun IEEECmp (order:IEEEReal.real_order,not:bool->bool) =
            fn(x:Real.real,y:Real.real) =>
              (if not(order = Real.compareReal(x,y)) then
                negNaN else posZero)
        val t:bool->bool = fn x => x
        val f:bool->bool = Bool.not
        fun doit (order:IEEEReal.real_order,not:bool->bool):simdReal =
            simdBinOp(s1,s2,(IEEECmp(order,not)))
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
      end end
  fun primitiveCmp (s1:simdReal,s2:simdReal,c:Word8.word) = let
    val imm = case c of
                  0w0 => eq
                | 0w1 => lt  
                | 0w6 => gt 
                | 0w2 => le 
                | 0w5 => ge 
                | 0w4 => ne
                | 0w7 => ord
                | 0w3  => unord
                | _ => raise Fail ("Comparison using immediate of " ^ 
                                   Word8.toString(c)^ " is undefined")
  in
    cmp(s1,s2,imm)
  end
end
structure Simd128_Real32 = SoftwareSimdReal(
 struct
  structure Real = Real32
  structure Word = Word32
  type elt = Real32.real
  type real = Real32.real
  type simdReal = real*real*real*real
  val elements = 4
  val vecSize = 128
  val realSize = 32
  fun simdBinOp (s1 as (a1,b1,c1,d1),s2 as (a2,b2,c2,d2),f) =
      (f(a1,a2),f(b1,b2),f(c1,c2),f(d1,d2))
  fun toArray (a,i,s as (s1,s2,s3,s4)) =
      (Array.update(a,i,s1);Array.update(a,i+1,s2);
       Array.update(a,i+2,s3);Array.update(a,i+3,s4))
  fun fromArray (a,i) =
      (Array.sub(a,i),Array.sub(a,i+1),Array.sub(a,i+2),Array.sub(a,i+3))
  fun toList(s as (a,b,c,d)) = [a,b,c,d]
  fun fromList(a::b::c::d::e) = (a,b,c,d)
    | fromList(_) = raise Empty
  fun fromScalar r = (r,0.0:real,0.0:real,0.0:real)
  fun fromScalarFill r = (r,r,r,r)
  val toScalar = fn (a,b,c,d) => a
  local
    open Primitive.PackReal32
  in
     val toWord = castToWord
     val fromWord = castFromWord
  end
  val negNaN:Real32.real = fromWord 0wxffffffff
  val posZero:Real32.real = fromWord 0wx00000000
  fun shuffle (s1, s2, (w1,w2,w3,w4))=
   let
     fun select(s:simdReal,w:Word8.word) =
         case w of
             0w0 => #1(s)
           | 0w1 => #2(s)
           | 0w2 => #3(s)
           | 0w3 => #4(s)
           | _ => raise Fail "Out of bounds shuffle index"
   in
     (select(s1,w1),select(s1,w2),select(s2,w3),select(s2,w4))
   end
end)
structure Simd128_Real64  = SoftwareSimdReal(
 struct
  structure Real = Real64
  structure Word = Word64
  type elt = Real64.real
  type simdReal = real*real
  val elements = 2
  val vecSize = 128
  val realSize = 64
  fun simdBinOp (s1 as (a1,b1),s2 as (a2,b2),f) =
      (f(a1,a2),f(b1,b2))
  fun toArray (a,i,s as (s1,s2)) =
      (Array.update(a,i,s1);Array.update(a,i+1,s2))
  fun fromArray (a,i) =
      (Array.sub(a,i),Array.sub(a,i+1))
  fun toList (s as (a,b))=[a,b]
  fun fromList (a::b::c) = (a,b)
    | fromList (_) = raise Empty
  fun fromScalar r = (r,0.0)
  fun fromScalarFill r = (r,r)
  val toScalar = fn (a,b) => a
  local
    open Primitive.PackReal64
  in
     val toWord = castToWord
     val fromWord = castFromWord
  end
  val negNaN = fromWord 0wxffffffffffffffff
  val posZero = fromWord 0wx0000000000000000
  fun shuffle (s1, s2, (w1,w2,w3,w4))=
   let
     fun select(s:simdReal,w:Word8.word) =
         case w of
             0w0 => #1(s)
           | 0w1 => #2(s)
           | _ => raise Fail "Out of bounds shuffle index"
   in
     (select(s1,w1),select(s2,w2))
   end
end)
