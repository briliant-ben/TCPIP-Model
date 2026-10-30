From Stdlib Require Import List ZArith.
Import ListNotations.
Open Scope Z_scope.

(* Formal denotation for an explicitly restricted IR assignment fragment. *)
Inductive expr : Type :=
| ELit : Z -> expr
| EVar : nat -> expr
| EField : nat -> expr
| EAdd : expr -> expr -> expr
| ESub : expr -> expr -> expr
| ESeqAdd : expr -> expr -> expr
| EDistance : expr -> expr -> expr.
Definition env := nat -> Z.
Fixpoint eval (e : expr) (state fields : env) : Z :=
  match e with
  | ELit value => value
  | EVar index => state index
  | EField index => fields index
  | EAdd a b => eval a state fields + eval b state fields
  | ESub a b => eval a state fields - eval b state fields
  | ESeqAdd a b => (eval a state fields + eval b state fields) mod 4294967296
  | EDistance a b => (eval b state fields - eval a state fields) mod 4294967296
  end.
Definition put (state : env) (index : nat) (value : Z) : env :=
  fun key => if Nat.eqb key index then value else state key.
Fixpoint execute (actions : list (nat * expr)) (state fields : env) : env :=
  match actions with
  | [] => state
  | (index, value) :: rest => execute rest (put state index (eval value state fields)) fields
  end.
Definition initial (values : list Z) : env := fun index => nth index values 0.
Definition holds (property : expr * expr) (state fields : env) : Prop :=
  eval (fst property) state fields = eval (snd property) state fields.
