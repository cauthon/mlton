functor SimdUtilReal(S:SIMD_UTIL_REAL_STRUCTS):SIMD_UTIL_REAL =
struct
type e = S.e
type t = s.t
val size = S.vec_size/S.real_size
(*I'm using c array syntax for now, I'll figure out how
 *to do it in sml later*)
fun simdFold(x:e,a:e array,f:(t*t->t)):e =
(*As a note, this will cause a bit of inaccuracy, being as floating 
 *point operations aren't assoicative, this is a fact that arises in
 *pretty much all simd computations, and is something we have to live with*)
    let
      val len = Array.length a
      val s = Simd.fromArray a
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
          loop(f(t,Simd.fromArray(a[i])),op+(i,size))
    in Simd.toScalar(f(loop(t,len),Simd.fromScalar(init(x,overflow)))) end
val simdSum = fn (x,a) => simdFold(x,a,Simd.add)
val simdProd = fn (x,a) => simdFold(x,a,Simd.mul)
(*I'm not 100% sure these will work, but I see no reason why not*)
val simdMax = fn (x,a) => simdFold(x,a,Simd.max)
val simdMin = fn (x,a) => simdFold(x,a,Simd.min)
