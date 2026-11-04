From Stdlib Require Import List ZArith.
Import ListNotations.
Open Scope Z_scope.

(* Separate expression sorts prevent an integer from being used as a buffer.
   Lists of Z include every legal octet list. The content theorem is stronger:
   it holds even without restricting elements to 0..255. *)
Inductive bexpr : Type :=
| BLit : list Z -> bexpr
| BVar : nat -> bexpr
| BField : nat -> bexpr
| BConcat : bexpr -> bexpr -> bexpr
| BSlice : bexpr -> iexpr -> iexpr -> bexpr
with iexpr : Type :=
| ILit : Z -> iexpr
| IField : nat -> iexpr
| ILength : bexpr -> iexpr.
Definition benv := nat -> list Z.
Definition ienv := nat -> Z.
Definition slice (xs : list Z) (offset count : Z) :=
  firstn (Z.to_nat count) (skipn (Z.to_nat offset) xs).
Fixpoint evalb (e : bexpr) (state fields : benv) (ints : ienv) : list Z :=
  match e with
  | BLit xs => xs
  | BVar n => state n
  | BField n => fields n
  | BConcat a b => evalb a state fields ints ++ evalb b state fields ints
  | BSlice a offset count => slice (evalb a state fields ints)
      (evali offset state fields ints) (evali count state fields ints)
  end
with evali (e : iexpr) (state fields : benv) (ints : ienv) : Z :=
  match e with
  | ILit n => n
  | IField n => ints n
  | ILength a => Z.of_nat (length (evalb a state fields ints))
  end.
Definition put (state : benv) (index : nat) (value : list Z) : benv :=
  fun key => if Nat.eqb key index then value else state key.
Fixpoint execute (actions : list (nat * bexpr)) (state fields : benv) (ints : ienv) : benv :=
  match actions with
  | [] => state
  | (index,value)::rest => execute rest (put state index (evalb value state fields ints)) fields ints
  end.
Definition initial (values : list (list Z)) : benv := fun index => nth index values [].
Definition holds (property : bexpr * bexpr) (state fields : benv) (ints : ienv) :=
  evalb (fst property) state fields ints = evalb (snd property) state fields ints.
