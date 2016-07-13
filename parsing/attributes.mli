(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2016     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(* TODO: some high level description of the role of attributes and
   links to where they are used. Must include syntax [attr(sub)] used
   in interface description. Define "empty attr" as attribute without
   sub-attributes. *)

type t = string

val compare : t -> t -> int

val equal : t -> t -> int

(** Attribute sets, which contain attributes and their
    sub-attributes. Because empty attributes are common, helper
    functions are provided to manipulate them. As a convention these
    functions end with a [_attr] suffix. *)
module Set : sig

  (** Local renaming of the type of attributes. *)
  type elt = t

  type t

  (** The empty attribute set. *)
  val empty : t

  (** [is_empty s] is [true] if and only if [s] has no attribute. *)
  val is_empty : t -> bool

  (** [add attr sub s] contains all the attributes of the attribute
      set [s] plus [attr(sub)]. If [attr(sub'] was already present,
      then it is replaced by [attr(sub ∪ sub')]. *)
  val add : elt -> t -> t -> t

  (** [add_attr attr s] contains all the attributes of the attribute
      set [s] plus the empty [attr]. It is equivalent to [add attr
      empty s]. See {!add} for more details. *)
  val add_attr : elt -> t -> t

  (** [find attr s] returns the sub-attributes of [attr] if [attr] is
      present. *)
  val find : elt -> t -> t option

  (** [find_attr attr s] is [true] if and only if [attr] is present
      and it has no sub-attribute. In other words, if [find attr s =
      Some sub] and [is_empty sub = true]. *)
  val find_attr : elt -> t -> bool

end
