(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2016     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

module Base = struct
  type t = string

  let compare = CString.compare

  let equal = CString.equal
end

include Base

module Map = CMap.Make(Base)

module Set = struct

  (** Local renaming of the type of attributes. *)
  type elt = Base.t

  type t = Set of t Map.t

  let empty = Set Map.empty

  let is_empty (Set s) = Map.is_empty s

  let rec union (Set l) (Set r) =
    let merge _ s1 s2 =
      match s1,s2 with
      | Some s1, Some s2 -> Some (union s1 s2)
      | None,Some s | Some s,None -> Some s
      | _ -> assert false
    in
    let v = Map.merge merge l r in
    Set v

  let add attr sub (Set s) =
    let prev_sub = Map.find_default empty attr s in
    Set (Map.add attr (union sub prev_sub) s)

  let add_attr attr s = add attr empty s

  let find attr (Set s) =
    try Some (Map.find attr s)
    with Not_found -> None

  let find_attr attr s =
    match find attr s with
    | Some sub -> is_empty sub
    | None -> false

end
