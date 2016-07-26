(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2016     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(** This modules defines the notion of {i hook stacks}. Hook stacks
    are stacks of functions which are added to the stack by side
    effect ("a hook is registered"). They are intended to offer
    plugins entry points to modify the behaviour of Coq (for instance
    attributes have corresponding hooks).

    This is a different notion of hooks than in the {!Hook}
    module. But the interfaces share commonalities. *)

type 'a t
(** A stack containing hooks of type ['a -> 'a]. *)

type 'a run
(** A view of a hook stack which makes it possible to run the current hooks. *)

val make : unit -> 'a run * 'a t
(** Create a new hook stack. *)

val register : 'a t -> ('a -> 'a) -> unit
(** Register a new hook. [register] is not thread safe.*)

val run : 'a run -> 'a -> 'a
(** [run r x] applies the functions of [r] to [x] starting with the
    most recently added. For instance [let (r,s) = make () in register
    s f1; register s f2; register s f3; run r x = f1 (f2 (f3
    x))]. [run] is thread-safe. *)
