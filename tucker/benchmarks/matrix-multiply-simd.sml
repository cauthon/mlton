(* Written by Stephen Weeks (sweeks@sweeks.com). *)
local
open Array
structure S = Simd128Word64
type real = Real64.real
(*might need to use array slices, ask matthew about array access*)
fun dot (a:real array,b:real array,n:int,b_step:int) = 
(*given a row vector a(presumably from a matrix) and a matrix b
 *multiply column n of b by a and sum the resulting vector
 *for (i=0;i<n;i+=2)
 *load a[i],a[i+1] and b[i*b_step],b[(i+1)*bstep] into xmm registers x1 and x2,
 *multiply x1 by x2(result is in x1) mov x1,x2(copy x1 to x2)
 *shuffle x2(i,j)->(j,i), add x1,x2, extract low 64 bits of x1 as a scalar double
 *add double to the result, loop
 *return the result*)
    let val i = ref 0 
        val result = ref 0.0 
    in (while ((!i)<n) do
              (let 
                val s1 = S.mul
                           (S.fromArrayOffset(a,2)),
                            Simd.set(sub(b,(b_step*(!i))),sub(b,(b_step*(!i)))))
              in
                (result:=(!result)+
                         (S.toScalar
                            (S.add
                               (S.shuffle(s1,s1,0w2(*imm8=00000010*)))));
                 i:=(!i)+2) end)
              ;(!result))
    end
in
(* A:MxN * B:NxL -> C:MxL 
 * Arrays are not modified*)
fun matMult (A: real Array.array, B: real Array.array,
             M: int, N: int, L: int) : real Array.array =
    if length(A) <> M*N orelse length(B) <> N*L
    then raise Fail "Matrix size" else
    let 
      val i = ref 0
      val j = ref 0
      val C = Unsafe.Array.create (M*L,0.0:real)
    in
      ((while ((!i)<M) do
              (while((!j)<L) do
                    (Unsafe.Array.update(C,((!i)*L+(!j)),
(*here's where I'm not sure of what to do, because sml*)
                                         dot(A[(!i)*N],B[(!j)])))
                   ;j:=(!j)+1)
       ;i:=(!i)+i)
      ;C)
    end
end
structure Array = Array2
   
fun 'a fold (n : int, b : 'a, f : int * 'a -> 'a) =
   let
      fun loop (i : int, b : 'a) : 'a =
         if i = n
            then b
         else loop (i + 1, f (i, b))
   in loop (0, b)
   end

fun foreach (n : int, f : int -> unit) : unit =
   fold (n, (), f o #1)
fun mult (a1 : real Array.array, a2 : real Array.array) : real Array.array =
   let
      val r1 = Array.nRows a1
      val c1 = Array.nCols a1
      val r2 = Array.nRows a2
      val c2 = Array.nCols a2
   in if c1 <> r2
         then raise Fail "mult"
      else

         let val a = Array2.array (r1, c2, 0.0)
            fun dot (r, c) =
               fold (c1, 0.0, fn (i, sum) =>
                    sum + Array.sub (a1, r, i) * Array.sub (a2, i, c))
         in foreach (r1, fn r =>
                    foreach (c2, fn c =>
                            Array.update (a, r, c, dot (r,c))));
         end
   end

structure Main =
   struct
      fun doit () =
         let
            val dim = 500
            val a = Array.tabulate Array.RowMajor (dim, dim, fn (r, c) =>
                                                   Real.fromInt (r + c))
         in
            if Real.== (41541750.0, Array2.sub (mult (a, a), 0, 0))
               then ()
            else raise Fail "bug"
         end
      
      val doit =
         fn size =>
         let
            fun loop n =
               if n = 0
                  then ()
               else (doit ();
                     loop (n-1))
         in loop size
         end
   end
