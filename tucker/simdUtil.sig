signature SIMD_UTIL_REAL_STRUCTS =
sig
  structure SimdReal:SIMD_REAL
end
signature SIMD_UTIL_REAL =
sig
  type t(*simd type*)
  type e(*element type*)
(*functions of type e*e-> are emultaned by using a
 * function f of type (t*t -> t) as follows
 *Simd.toScalar(f(Simd.fromScalar e -> t,SimdfromScalar e))
 *these functions could take an arguement e*e->e which does the same thing
 *as f on single elements for a slight performance increase*)
(*fold array using simd opperations, function t*t->t and e*e->e
 *should do the same thing, e*e->e is necessary to translate the
 *simd values into an actuals result and deal with arrays of non exact size*)
  val simdFold:e*e array*(t*t->t)->e
  val simdSum:e*e array->e
  val simdProd:e*e array->e
  val simdMax:e*e array->e
  val simdMin:e*e array->e
(*apply function (t*t->t) to all elements of seq,e*e->e necessary for the
 *same reason*)
  val simdApp:e array*(t->t)->array(*or -> ()*)
(*search for element e in array using comparison function (t*t->t)*)
  val simdSearch:e array*e*SimdReal.cmp->int
  val simdFind:e array*e->int
end
         
  
