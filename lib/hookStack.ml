(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2016     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

type 'a t = ('a -> 'a) list ref

type 'a run = 'a t

let  make () =
  let ans = ref [] in
  (ans,ans)

let register s f =
  s := f::!s


let run r x =
  let rec run x = function
    | [] -> x
    | f::r -> run (f x) r
  in
  run x r
