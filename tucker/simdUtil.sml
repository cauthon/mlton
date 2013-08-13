functor SimdUtilReal(S:SIMD_UTIL_REAL_STRUCTS):SIMD_UTIL_REAL =
struct
type e = S.e
type t = s.t
val size = S.vec_size/S.real_size
(*I'm using c array syntax for now, I'll figure out how
 *to do it in sml later*)
fun simdFold (x:e,a:e array,f:(t*t->t)):e =
(*As a note, this will cause a bit of inaccuracy, being as floating 
 *point operations aren't assoicative, this is a fact that arises in
 *pretty much all simd computations, and is something we have to live with*)
    let
      val len = Array.length a
      val t = Simd.fromArray a
(*like when unrolling loops we need to deal with excess elements
 *that don't fit exactally in a simd vector, could probably optimize
 *this a bit more*)
      val overflow = len mod size
      fun init (acc:e,n:int) = 
          if n = 0 then acc else
          init(f(Simd.fromScalar(acc),
                 Simd.fromScalar(Array.sub(a,len-1-n))),n-1)
(*after we finish looping we fold the elements of the resulant simd vector
 *by doing some tricks with shuffling*)
      val fin = fn x =>
                   let
                     val y = x
                     val x = Simd.shuffle(x,y,0x1b)
                     (*or Simd.movhl/movlh?*)
                     val x = f(x,y)
                     val y = Simd.shuffle(x,y,0x55)
                     val x = f(x,y)
                   in x end
(*the main loop, fold the array using simd instructions *)
      fun loop(s,i) =
          if i >= len then fin s else
          loop(f(t,Simd.fromArrayOffset(a,i)),op+(i,size))
    in Simd.toScalar(f(loop(t,size),Simd.fromScalar(init(x,overflow)))) end
val simdSum = fn (x,a) => simdFold(x,a,Simd.add)
val simdProd = fn (x,a) => simdFold(x,a,Simd.mul)
(*I'm not 100% sure these will work, but I see no reason why not*)
val simdMax = fn (x,a) => simdFold(x,a,Simd.max)
val simdMin = fn (x,a) => simdFold(x,a,Simd.min)
(*I tried to make this as functional-esq as I could*)
fun simdApp (a:e array,f:(t->t)) =
    let
      val len = Array.length a
      val overflow = len mod size
      fun atEnd (n:int) = 
          if n = 0 then () else
          let 
            val _ = Array.update(a,n,
                      Simd.toScalar(f(Simd.fromScalar(acc),
                                      Simd.fromScalar(Array.sub(a,len-1-n)))));
          in atEnd(n-1) end
      fun loop (n:int) =
          if n >= len then atEnd(overflow)
          else (*this is going to look really weird untill I figure out 
                *sml pointer stuff*)
            let
              val _ = Simd.toArrayOffset
                        (a,f(Simd.fromArrayOffset(a,n)),n)
            in loop(n+size) end
      val _ = loop(0)
    in () end
(*fun simdSearch (a:e array,x: e,c:cmp) =
    let 
      val search = set1(x)(*load a simd vector of repeated x's*)
      val len = Array.length a
      val overflow = len mod size
(*test excess valuse that don't fill a simd vector*)
      fun over (i:int,n:int) = 
          if n = 0 then -1
          else let
            val temp = Simd.toScalar(
                  Simd.maskMove(Simd.cmp(Simd.fromScalar(Array.sub(a,i)),
                                         search,cmp)))
          in if temp = 0 then over(i+1,n-1)
             else i end
(*run at end, return index of earliest instance if we found somthing
 *or else run over if we have overflow or else just return -1 to indicate 
 *failure*)
      fun atEnd (n:int,i:int,m:int)=
          case i of
              0x1 => i
            | 0x2 => i+1
            | 0x3 => i
            | 0x4 => i+2
            | 0x5 => i
            | 0x6 => i+1
            | 0x7 => i
            | 0x8 => i+3
            | 0x9 => i
            | 0xa => i+1
            | 0xb => i
            | 0xc => i+2
            | 0xd => i
            | 0xe => i+1
            | 0xf => i
            | _ => if m = 0 then -1 else over(n,m)
      fun loop (i:int) = if i >= len then 
                           atEnd(simd.maskMove(Simd.fromArrya(a[i-n]),
                                               search,cmp),i-n,overflow)
          else if Simd.cmpBool(Simd.fromArray(a[i]),search,cmp)
               then atEnd(simd.maskMove(Simd.fromArray(a[i]),search,cmp),i,0)
          else loop(i+n)
   in loop 0 end
fun simdFind (a:e array,x:e) = simdSearch(a,x,cmpeq)*)
end
