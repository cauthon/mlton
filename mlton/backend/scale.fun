(* Copyright (C) 2004-2007 Henry Cejtin, Matthew Fluet, Suresh
 *    Jagannathan, and Stephen Weeks.
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)

functor Scale (S: SCALE_STRUCTS): SCALE =
struct

open S

datatype t = One | Two | Four | Eight(* | Sixteen | ThirtyTwo*)

val toString =
   fn One => "1"
    | Two => "2"
    | Four => "4"
    | Eight => "8"
(*    | Sixteen => "16"
    | ThirtyTwo => "32"*)

val layout = Layout.str o toString

val fromInt: int -> t option =
   fn 1 => SOME One
    | 2 => SOME Two
    | 4 => SOME Four
    | 8 => SOME Eight
(*    | 16 => SOME Sixteen
    | 32 => SOME ThirtyTwo*)
    | _ => NONE

val fromBytes: Bytes.t -> t option =
   fromInt o Bytes.toInt

val toInt: t -> int =
   fn One => 1
    | Two => 2
    | Four => 4
    | Eight => 8
(*    | Sixteen => 16
    | ThirtyTwo => 32*)

end
