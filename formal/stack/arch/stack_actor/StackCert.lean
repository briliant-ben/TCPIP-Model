import OctetBounds
import EffectConditions
import GuardDiscriminators

namespace StackCert
open FormalSpecAgent TypedIR TypedMachine TypedContracts TypedFiringContracts
open EffectConditions OctetBounds TimedObligations GuardDiscriminators

abbrev evalInt (e : Expr .integer) (ctx : Context) : Int := TypedIR.eval e ctx
abbrev evalBool (e : Expr .boolean) (ctx : Context) : Bool := TypedIR.eval e ctx
abbrev evalOct (e : Expr .octets) (ctx : Context) : Bytes := TypedIR.eval e ctx
abbrev evalSeq (e : Expr .sequence) (ctx : Context) : ValueOps.Seq32 := TypedIR.eval e ctx

def noFields {k : Kind} : Expr k → Bool
  | .literal _ _ => true
  | .variable _ _ => true
  | .field _ _ => false
  | .stateIs _ => true
  | .timerActive _ => true
  | .equal _ a b | .notEqual _ a b => noFields a && noFields b
  | .choose _ c y n => noFields c && noFields y && noFields n
  | .boolAnd a b | .boolOr a b | .implies a b => noFields a && noFields b
  | .boolNot a => noFields a
  | .add a b | .mul a b | .sub a b | .minimum a b => noFields a && noFields b
  | .intLe a b | .intGe a b => noFields a && noFields b
  | .seqAdd a b => noFields a && noFields b
  | .seqDistance a b | .seqComparable a b | .seqLt a b | .seqLe a b => noFields a && noFields b
  | .bytesLength a | .checksum a => noFields a
  | .concat a b => noFields a && noFields b
  | .slice a b c => noFields a && noFields b && noFields c
  | .byteAt a b => noFields a && noFields b
  | .pack8 a | .pack16 a | .pack32 a => noFields a

theorem eval_noFields {k : Kind} (e : Expr k) (s : Snapshot) (f g : Values)
    (ok : noFields e = true) : TypedMachine.eval s f e = TypedMachine.eval s g e := by
  unfold TypedMachine.eval
  induction e <;> simp_all [noFields, TypedIR.eval, context, Bool.and_eq_true] <;> rfl

def atoms {k : Kind} : Expr k → List (Expr .boolean)
  | .boolAnd a b => atoms a ++ atoms b
  | .literal .boolean b => [.literal .boolean b]
  | .variable .boolean n => [.variable .boolean n]
  | .field .boolean n => [.field .boolean n]
  | .stateIs n => [.stateIs n]
  | .timerActive n => [.timerActive n]
  | .equal k1 a b => [.equal k1 a b]
  | .notEqual k1 a b => [.notEqual k1 a b]
  | .choose .boolean c y n => [.choose .boolean c y n]
  | .boolOr a b => [.boolOr a b]
  | .boolNot a => [.boolNot a]
  | .implies a b => [.implies a b]
  | .intLe a b => [.intLe a b]
  | .intGe a b => [.intGe a b]
  | .seqComparable a b => [.seqComparable a b]
  | .seqLt a b => [.seqLt a b]
  | .seqLe a b => [.seqLe a b]
  | _ => []

theorem atoms_sound (e : Expr .boolean) (ctx : Context) (h : evalBool e ctx = true) :
    ∀ a ∈ atoms e, evalBool a ctx = true := by
  cases e with
  | boolAnd x y =>
    intro a mem
    simp only [atoms] at mem
    have hxy : evalBool x ctx = true ∧ evalBool y ctx = true := by
      simpa [evalBool, TypedIR.eval, Bool.and_eq_true] using h
    rcases List.mem_append.mp mem with mx | my
    · exact atoms_sound x ctx hxy.1 a mx
    · exact atoms_sound y ctx hxy.2 a my
  | _ =>
    intro a mem
    simp only [atoms, List.mem_singleton] at mem
    subst mem
    exact h
termination_by sizeOf e

def invAtoms (invs : List (Expr .boolean)) : List (Expr .boolean) :=
  invs.flatMap atoms

theorem invAtoms_sound (m : Model) (s : Snapshot) (f : Values)
    (noF : m.invariants.all noFields = true)
    (valid : invariantsHold m s = true) :
    ∀ a ∈ invAtoms m.invariants, evalBool a (context s f) = true := by
  intro a mem
  obtain ⟨inv, hInv, hAtom⟩ := List.mem_flatMap.mp mem
  have hHold : TypedMachine.eval s zeroValues inv = true :=
    List.all_eq_true.mp valid inv hInv
  have hNoF : noFields inv = true := List.all_eq_true.mp noF inv hInv
  have hSame : evalBool inv (context s f) = true := by
    change TypedMachine.eval s f inv = true
    rw [eval_noFields inv s f zeroValues hNoF]
    exact hHold
  exact atoms_sound inv (context s f) hSame a hAtom

private def kindEq (a b : Kind) : Decidable (a = b) := by
  cases a <;> cases b <;> first | exact isTrue rfl | exact isFalse (by intro h; cases h)

local instance (k l : Kind) : Decidable (k = l) := kindEq k l

def sameExpr {k : Kind} (a b : Expr k) : Bool :=
  match a with
  | .literal k v1 => match b with | .literal _ v2 => equalValue k v1 v2 | _ => false
  | .variable _ i => match b with | .variable _ j => i == j | _ => false
  | .field _ i => match b with | .field _ j => i == j | _ => false
  | .stateIs i => match b with | .stateIs j => i == j | _ => false
  | .timerActive i => match b with | .timerActive j => i == j | _ => false
  | .equal k1 x1 y1 => match b with
    | .equal k2 x2 y2 => if hk : k1 = k2 then sameExpr x1 (hk ▸ x2) && sameExpr y1 (hk ▸ y2) else false
    | _ => false
  | .notEqual k1 x1 y1 => match b with
    | .notEqual k2 x2 y2 => if hk : k1 = k2 then sameExpr x1 (hk ▸ x2) && sameExpr y1 (hk ▸ y2) else false
    | _ => false
  | .choose _ c1 y1 n1 => match b with
    | .choose _ c2 y2 n2 => sameExpr c1 c2 && sameExpr y1 y2 && sameExpr n1 n2 | _ => false
  | .boolAnd x1 y1 => match b with | .boolAnd x2 y2 => sameExpr x1 x2 && sameExpr y1 y2 | _ => false
  | .boolOr x1 y1 => match b with | .boolOr x2 y2 => sameExpr x1 x2 && sameExpr y1 y2 | _ => false
  | .boolNot x1 => match b with | .boolNot x2 => sameExpr x1 x2 | _ => false
  | .implies x1 y1 => match b with | .implies x2 y2 => sameExpr x1 x2 && sameExpr y1 y2 | _ => false
  | .add x1 y1 => match b with | .add x2 y2 => sameExpr x1 x2 && sameExpr y1 y2 | _ => false
  | .mul x1 y1 => match b with | .mul x2 y2 => sameExpr x1 x2 && sameExpr y1 y2 | _ => false
  | .sub x1 y1 => match b with | .sub x2 y2 => sameExpr x1 x2 && sameExpr y1 y2 | _ => false
  | .minimum x1 y1 => match b with | .minimum x2 y2 => sameExpr x1 x2 && sameExpr y1 y2 | _ => false
  | .intLe x1 y1 => match b with | .intLe x2 y2 => sameExpr x1 x2 && sameExpr y1 y2 | _ => false
  | .intGe x1 y1 => match b with | .intGe x2 y2 => sameExpr x1 x2 && sameExpr y1 y2 | _ => false
  | .seqAdd x1 y1 => match b with | .seqAdd x2 y2 => sameExpr x1 x2 && sameExpr y1 y2 | _ => false
  | .seqDistance x1 y1 => match b with | .seqDistance x2 y2 => sameExpr x1 x2 && sameExpr y1 y2 | _ => false
  | .seqComparable x1 y1 => match b with | .seqComparable x2 y2 => sameExpr x1 x2 && sameExpr y1 y2 | _ => false
  | .seqLt x1 y1 => match b with | .seqLt x2 y2 => sameExpr x1 x2 && sameExpr y1 y2 | _ => false
  | .seqLe x1 y1 => match b with | .seqLe x2 y2 => sameExpr x1 x2 && sameExpr y1 y2 | _ => false
  | .bytesLength x1 => match b with | .bytesLength x2 => sameExpr x1 x2 | _ => false
  | .concat x1 y1 => match b with | .concat x2 y2 => sameExpr x1 x2 && sameExpr y1 y2 | _ => false
  | .slice x1 y1 z1 => match b with
    | .slice x2 y2 z2 => sameExpr x1 x2 && sameExpr y1 y2 && sameExpr z1 z2 | _ => false
  | .byteAt x1 y1 => match b with | .byteAt x2 y2 => sameExpr x1 x2 && sameExpr y1 y2 | _ => false
  | .pack8 x1 => match b with | .pack8 x2 => sameExpr x1 x2 | _ => false
  | .pack16 x1 => match b with | .pack16 x2 => sameExpr x1 x2 | _ => false
  | .pack32 x1 => match b with | .pack32 x2 => sameExpr x1 x2 | _ => false
  | .checksum x1 => match b with | .checksum x2 => sameExpr x1 x2 | _ => false

private theorem equalValue_sound {k : Kind} {v1 v2 : Value k} (h : equalValue k v1 v2 = true) :
    v1 = v2 := by
  cases k <;> exact of_decide_eq_true h

theorem sameExpr_sound {k : Kind} {a b : Expr k} (ctx : Context) (h : sameExpr a b = true) :
    TypedIR.eval a ctx = TypedIR.eval b ctx := by
  induction a with
  | literal k v1 =>
    cases b <;> simp [sameExpr] at h
    exact equalValue_sound h
  | «variable» k i =>
    cases b <;> simp [sameExpr] at h
    simp [TypedIR.eval, h]
  | field k i =>
    cases b <;> simp [sameExpr] at h
    simp [TypedIR.eval, h]
  | stateIs i =>
    cases b <;> simp [sameExpr] at h
    simp [TypedIR.eval, h]
  | timerActive i =>
    cases b <;> simp [sameExpr] at h
    simp [TypedIR.eval, h]
  | equal k1 x1 y1 ihx ihy =>
    cases b <;> try (simp [sameExpr] at h; done)
    rename_i k2 x2 y2
    by_cases hk : k1 = k2
    · subst hk
      simp only [sameExpr, dite_true, Bool.and_eq_true] at h
      simp [TypedIR.eval, ihx h.1, ihy h.2]
    · simp [sameExpr, hk] at h
  | notEqual k1 x1 y1 ihx ihy =>
    cases b <;> try (simp [sameExpr] at h; done)
    rename_i k2 x2 y2
    by_cases hk : k1 = k2
    · subst hk
      simp only [sameExpr, dite_true, Bool.and_eq_true] at h
      simp [TypedIR.eval, ihx h.1, ihy h.2]
    · simp [sameExpr, hk] at h
  | choose k c1 y1 n1 ihc ihy ihn =>
    cases b <;> simp [sameExpr, Bool.and_eq_true] at h
    simp [TypedIR.eval, ihc h.1.1, ihy h.1.2, ihn h.2]
  | boolAnd x1 y1 ihx ihy =>
    cases b <;> simp [sameExpr, Bool.and_eq_true] at h
    simp [TypedIR.eval, ihx h.1, ihy h.2]
  | boolOr x1 y1 ihx ihy =>
    cases b <;> simp [sameExpr, Bool.and_eq_true] at h
    simp [TypedIR.eval, ihx h.1, ihy h.2]
  | boolNot x1 ihx =>
    cases b <;> simp [sameExpr] at h
    simp [TypedIR.eval, ihx h]
  | implies x1 y1 ihx ihy =>
    cases b <;> simp [sameExpr, Bool.and_eq_true] at h
    simp [TypedIR.eval, ihx h.1, ihy h.2]
  | add x1 y1 ihx ihy =>
    cases b <;> simp [sameExpr, Bool.and_eq_true] at h
    simp [TypedIR.eval, ihx h.1, ihy h.2]
  | mul x1 y1 ihx ihy =>
    cases b <;> simp [sameExpr, Bool.and_eq_true] at h
    simp [TypedIR.eval, ihx h.1, ihy h.2]
  | sub x1 y1 ihx ihy =>
    cases b <;> simp [sameExpr, Bool.and_eq_true] at h
    simp [TypedIR.eval, ihx h.1, ihy h.2]
  | minimum x1 y1 ihx ihy =>
    cases b <;> simp [sameExpr, Bool.and_eq_true] at h
    simp [TypedIR.eval, ihx h.1, ihy h.2]
  | intLe x1 y1 ihx ihy =>
    cases b <;> simp [sameExpr, Bool.and_eq_true] at h
    simp [TypedIR.eval, ihx h.1, ihy h.2]
  | intGe x1 y1 ihx ihy =>
    cases b <;> simp [sameExpr, Bool.and_eq_true] at h
    simp [TypedIR.eval, ihx h.1, ihy h.2]
  | seqAdd x1 y1 ihx ihy =>
    cases b <;> simp [sameExpr, Bool.and_eq_true] at h
    simp [TypedIR.eval, ihx h.1, ihy h.2]
  | seqDistance x1 y1 ihx ihy =>
    cases b <;> simp [sameExpr, Bool.and_eq_true] at h
    simp [TypedIR.eval, ihx h.1, ihy h.2]
  | seqComparable x1 y1 ihx ihy =>
    cases b <;> simp [sameExpr, Bool.and_eq_true] at h
    simp [TypedIR.eval, ihx h.1, ihy h.2]
  | seqLt x1 y1 ihx ihy =>
    cases b <;> simp [sameExpr, Bool.and_eq_true] at h
    simp [TypedIR.eval, ihx h.1, ihy h.2]
  | seqLe x1 y1 ihx ihy =>
    cases b <;> simp [sameExpr, Bool.and_eq_true] at h
    simp [TypedIR.eval, ihx h.1, ihy h.2]
  | bytesLength x1 ihx =>
    cases b <;> simp [sameExpr] at h
    simp [TypedIR.eval, ihx h]
  | concat x1 y1 ihx ihy =>
    cases b <;> simp [sameExpr, Bool.and_eq_true] at h
    simp [TypedIR.eval, ihx h.1, ihy h.2]
  | slice x1 y1 z1 ihx ihy ihz =>
    cases b <;> simp [sameExpr, Bool.and_eq_true] at h
    simp [TypedIR.eval, ihx h.1.1, ihy h.1.2, ihz h.2]
  | byteAt x1 y1 ihx ihy =>
    cases b <;> simp [sameExpr, Bool.and_eq_true] at h
    simp [TypedIR.eval, ihx h.1, ihy h.2]
  | pack8 x1 ihx =>
    cases b <;> simp [sameExpr] at h
    simp [TypedIR.eval, ihx h]
  | pack16 x1 ihx =>
    cases b <;> simp [sameExpr] at h
    simp [TypedIR.eval, ihx h]
  | pack32 x1 ihx =>
    cases b <;> simp [sameExpr] at h
    simp [TypedIR.eval, ihx h]
  | checksum x1 ihx =>
    cases b <;> simp [sameExpr] at h
    simp [TypedIR.eval, ihx h]

abbrev sameOct (a b : Expr .octets) : Bool := sameExpr a b
abbrev sameInt (a b : Expr .integer) : Bool := sameExpr a b
theorem sameOct_sound {a b : Expr .octets} (ctx : Context) (h : sameOct a b = true) :
    evalOct a ctx = evalOct b ctx := sameExpr_sound ctx h
theorem sameInt_sound {a b : Expr .integer} (ctx : Context) (h : sameInt a b = true) :
    evalInt a ctx = evalInt b ctx := sameExpr_sound ctx h

def factLo (target : Expr .integer) : Expr .boolean → Option Int
  | .intGe x (.literal .integer c) => if sameInt x target then some c else none
  | .intLe (.literal .integer c) x => if sameInt x target then some c else none
  | .equal .integer x (.literal .integer c) => if sameInt x target then some c else none
  | .boolNot (.intLe x (.literal .integer c)) => if sameInt x target then some (c + 1) else none
  | .boolNot (.intGe (.literal .integer c) x) => if sameInt x target then some (c + 1) else none
  | _ => none

theorem factLo_sound (target : Expr .integer) (fact : Expr .boolean) (ctx : Context) (c : Int)
    (hf : evalBool fact ctx = true) (found : factLo target fact = some c) :
    c ≤ evalInt target ctx := by
  unfold factLo at found
  split at found
  · rename_i x v
    change Int at v
    have ⟨hSame, hEq⟩ : sameInt x target = true ∧ v = c := by simpa using found
    have hx : evalInt x ctx = evalInt target ctx := sameInt_sound ctx hSame
    have hv : evalInt x ctx ≥ v := of_decide_eq_true hf
    omega
  · rename_i v x
    change Int at v
    have ⟨hSame, hEq⟩ : sameInt x target = true ∧ v = c := by simpa using found
    have hx : evalInt x ctx = evalInt target ctx := sameInt_sound ctx hSame
    have hv : v ≤ evalInt x ctx := of_decide_eq_true hf
    omega
  · rename_i x v
    change Int at v
    have ⟨hSame, hEq⟩ : sameInt x target = true ∧ v = c := by simpa using found
    have hx : evalInt x ctx = evalInt target ctx := sameInt_sound ctx hSame
    have hv : evalInt x ctx = v := of_decide_eq_true hf
    omega
  · rename_i x v
    change Int at v
    have ⟨hSame, hEq⟩ : sameInt x target = true ∧ v + 1 = c := by simpa using found
    have hx : evalInt x ctx = evalInt target ctx := sameInt_sound ctx hSame
    have hdec : decide (evalInt x ctx ≤ v) = false := (Bool.not_eq_true' (decide (evalInt x ctx ≤ v))).mp hf
    have hv : ¬ (evalInt x ctx ≤ v) := of_decide_eq_false hdec
    omega
  · rename_i v x
    change Int at v
    have ⟨hSame, hEq⟩ : sameInt x target = true ∧ v + 1 = c := by simpa using found
    have hx : evalInt x ctx = evalInt target ctx := sameInt_sound ctx hSame
    have hdec : decide (v ≥ evalInt x ctx) = false := (Bool.not_eq_true' (decide (v ≥ evalInt x ctx))).mp hf
    have hv : ¬ (v ≥ evalInt x ctx) := of_decide_eq_false hdec
    omega
  · contradiction

def factsLo (facts : List (Expr .boolean)) (target : Expr .integer) : Option Int :=
  facts.foldl (fun acc f =>
    match factLo target f with
    | none => acc
    | some c => match acc with | none => some c | some a => some (max a c)) none

private theorem factsLo_step (facts : List (Expr .boolean)) (target : Expr .integer)
    (ctx : Context) (acc : Option Int)
    (hAll : ∀ f ∈ facts, evalBool f ctx = true)
    (hAcc : ∀ a, acc = some a → a ≤ evalInt target ctx) :
    ∀ res, facts.foldl (fun ac f =>
      match factLo target f with
      | none => ac
      | some c => match ac with | none => some c | some a => some (max a c)) acc = some res →
      res ≤ evalInt target ctx := by
  induction facts generalizing acc with
  | nil => intro res h; exact hAcc res h
  | cons f fs ih =>
    intro res h
    simp only [List.foldl_cons] at h
    apply ih _ (fun g hg => hAll g (List.mem_cons_of_mem f hg)) _ res h
    intro a ha
    cases hf : factLo target f with
    | none => simp [hf] at ha; exact hAcc a ha
    | some c =>
      have hc := factLo_sound target f ctx c (hAll f (by simp)) hf
      cases acc with
      | none =>
        have haEq : c = a := by simpa [hf] using ha
        omega
      | some p =>
        have hp := hAcc p rfl
        have haEq : max p c = a := by simpa [hf] using ha
        omega

theorem factsLo_sound (facts : List (Expr .boolean)) (target : Expr .integer) (ctx : Context) (c : Int)
    (hAll : ∀ f ∈ facts, evalBool f ctx = true) (found : factsLo facts target = some c) :
    c ≤ evalInt target ctx :=
  factsLo_step facts target ctx none hAll (by intro _ h; cases h) c found

def factHi (target : Expr .integer) : Expr .boolean → Option Int
  | .intLe x (.literal .integer c) => if sameInt x target then some c else none
  | .intGe (.literal .integer c) x => if sameInt x target then some c else none
  | .equal .integer x (.literal .integer c) => if sameInt x target then some c else none
  | .boolNot (.intGe x (.literal .integer c)) => if sameInt x target then some (c - 1) else none
  | .boolNot (.intLe (.literal .integer c) x) => if sameInt x target then some (c - 1) else none
  | _ => none

theorem factHi_sound (target : Expr .integer) (fact : Expr .boolean) (ctx : Context) (c : Int)
    (hf : evalBool fact ctx = true) (found : factHi target fact = some c) :
    evalInt target ctx ≤ c := by
  unfold factHi at found
  split at found
  · rename_i x v
    change Int at v
    have ⟨hSame, hEq⟩ : sameInt x target = true ∧ v = c := by simpa using found
    have hx : evalInt x ctx = evalInt target ctx := sameInt_sound ctx hSame
    have hv : evalInt x ctx ≤ v := of_decide_eq_true hf
    omega
  · rename_i v x
    change Int at v
    have ⟨hSame, hEq⟩ : sameInt x target = true ∧ v = c := by simpa using found
    have hx : evalInt x ctx = evalInt target ctx := sameInt_sound ctx hSame
    have hv : v ≥ evalInt x ctx := of_decide_eq_true hf
    omega
  · rename_i x v
    change Int at v
    have ⟨hSame, hEq⟩ : sameInt x target = true ∧ v = c := by simpa using found
    have hx : evalInt x ctx = evalInt target ctx := sameInt_sound ctx hSame
    have hv : evalInt x ctx = v := of_decide_eq_true hf
    omega
  · rename_i x v
    change Int at v
    have ⟨hSame, hEq⟩ : sameInt x target = true ∧ v - 1 = c := by simpa using found
    have hx : evalInt x ctx = evalInt target ctx := sameInt_sound ctx hSame
    have hdec : decide (evalInt x ctx ≥ v) = false := (Bool.not_eq_true' (decide (evalInt x ctx ≥ v))).mp hf
    have hv : ¬ (evalInt x ctx ≥ v) := of_decide_eq_false hdec
    omega
  · rename_i v x
    change Int at v
    have ⟨hSame, hEq⟩ : sameInt x target = true ∧ v - 1 = c := by simpa using found
    have hx : evalInt x ctx = evalInt target ctx := sameInt_sound ctx hSame
    have hdec : decide (v ≤ evalInt x ctx) = false := (Bool.not_eq_true' (decide (v ≤ evalInt x ctx))).mp hf
    have hv : ¬ (v ≤ evalInt x ctx) := of_decide_eq_false hdec
    omega
  · contradiction

def factsHi (facts : List (Expr .boolean)) (target : Expr .integer) : Option Int :=
  facts.foldl (fun acc f =>
    match factHi target f with
    | none => acc
    | some c => match acc with | none => some c | some a => some (min a c)) none

private theorem factsHi_step (facts : List (Expr .boolean)) (target : Expr .integer)
    (ctx : Context) (acc : Option Int)
    (hAll : ∀ f ∈ facts, evalBool f ctx = true)
    (hAcc : ∀ a, acc = some a → evalInt target ctx ≤ a) :
    ∀ res, facts.foldl (fun ac f =>
      match factHi target f with
      | none => ac
      | some c => match ac with | none => some c | some a => some (min a c)) acc = some res →
      evalInt target ctx ≤ res := by
  induction facts generalizing acc with
  | nil => intro res h; exact hAcc res h
  | cons f fs ih =>
    intro res h
    simp only [List.foldl_cons] at h
    apply ih _ (fun g hg => hAll g (List.mem_cons_of_mem f hg)) _ res h
    intro a ha
    cases hf : factHi target f with
    | none => simp [hf] at ha; exact hAcc a ha
    | some c =>
      have hc := factHi_sound target f ctx c (hAll f (by simp)) hf
      cases acc with
      | none =>
        have haEq : c = a := by simpa [hf] using ha
        omega
      | some p =>
        have hp := hAcc p rfl
        have haEq : min p c = a := by simpa [hf] using ha
        omega

theorem factsHi_sound (facts : List (Expr .boolean)) (target : Expr .integer) (ctx : Context) (c : Int)
    (hAll : ∀ f ∈ facts, evalBool f ctx = true) (found : factsHi facts target = some c) :
    evalInt target ctx ≤ c :=
  factsHi_step facts target ctx none hAll (by intro _ h; cases h) c found

def subLoStep (x rhs : Expr .integer) (lx la : Option Int) : Option Int :=
  match rhs with
  | .literal .integer k => return (← lx) - k
  | .minimum _ b =>
    if sameInt b x then
      match la, lx with
      | some a0, some x0 => if decide (0 ≤ a0 ∧ 0 ≤ x0) then some 0 else none
      | _, _ => none
    else none
  | .choose .integer _ (.minimum _ b) (.literal .integer z) =>
    if sameInt b x && decide (z = 0) then
      match la, lx with
      | some a0, some x0 => if decide (0 ≤ a0 ∧ 0 ≤ x0) then some 0 else none
      | _, _ => none
    else none
  | _ => none

def subHiStep (x rhs : Expr .integer) (hx lx la : Option Int) : Option Int :=
  match rhs with
  | .literal .integer k => return (← hx) - k
  | .minimum _ b =>
    if sameInt b x then
      match la, lx with
      | some a0, some x0 => if decide (0 ≤ a0 ∧ 0 ≤ x0) then hx else none
      | _, _ => none
    else none
  | .choose .integer _ (.minimum _ b) (.literal .integer z) =>
    if sameInt b x && decide (z = 0) then
      match la, lx with
      | some a0, some x0 => if decide (0 ≤ a0 ∧ 0 ≤ x0) then hx else none
      | _, _ => none
    else none
  | _ => none

def subArgA : Expr .integer → Option (Expr .integer)
  | .minimum a _ => some a
  | .choose .integer _ (.minimum a _) _ => some a
  | _ => none

theorem subLoStep_sound (x rhs : Expr .integer) (lx la : Option Int) (ctx : Context) (lo : Int)
    (hlx : ∀ x0, lx = some x0 → x0 ≤ evalInt x ctx)
    (found : subLoStep x rhs lx la = some lo) : lo ≤ evalInt (.sub x rhs) ctx := by
  unfold subLoStep at found
  split at found
  · rename_i k
    change Int at k
    cases hx : lx with
    | none => simp [hx] at found
    | some x0 =>
      have hs : x0 - k = lo := by simpa [hx] using found
      have ix := hlx x0 hx
      change lo ≤ evalInt x ctx - k; omega
  · rename_i a b
    by_cases hEq : sameInt b x = true
    · cases ha : la with
      | none => simp [hEq, ha] at found
      | some a0 =>
        cases hx : lx with
        | none => simp [hEq, ha, hx] at found
        | some x0 =>
          by_cases hPos : 0 ≤ a0 ∧ 0 ≤ x0
          · have hz : 0 = lo := by simpa [hEq, ha, hx, hPos] using found
            have hbx : evalInt b ctx = evalInt x ctx := sameInt_sound ctx hEq
            change lo ≤ evalInt x ctx - min (evalInt a ctx) (evalInt b ctx); omega
          · simp [hEq, ha, hx, hPos] at found
    · simp [hEq] at found
  · rename_i cond a b z
    change Int at z
    by_cases hEq : (sameInt b x && decide (z = 0)) = true
    · have ⟨hb, hz0⟩ : sameInt b x = true ∧ z = 0 := by
        simpa [Bool.and_eq_true, decide_eq_true_eq] using hEq
      cases ha : la with
      | none => simp [hb, hz0, ha] at found
      | some a0 =>
        cases hx : lx with
        | none => simp [hb, hz0, ha, hx] at found
        | some x0 =>
          by_cases hPos : 0 ≤ a0 ∧ 0 ≤ x0
          · have hlo : 0 = lo := by simpa [hb, hz0, ha, hx, hPos] using found
            have hbx : evalInt b ctx = evalInt x ctx := sameInt_sound ctx hb
            have ix := hlx x0 hx
            change lo ≤ evalInt x ctx - (if evalBool cond ctx then min (evalInt a ctx) (evalInt b ctx) else z)
            cases evalBool cond ctx <;> simp [hbx, hz0] <;> omega
          · simp [hb, hz0, ha, hx, hPos] at found
    · simp [hEq] at found
  · contradiction

theorem subHiStep_sound (x rhs : Expr .integer) (hx lx la : Option Int) (ctx : Context) (hi : Int)
    (hhx : ∀ x0, hx = some x0 → evalInt x ctx ≤ x0)
    (hlx : ∀ x0, lx = some x0 → x0 ≤ evalInt x ctx)
    (hla : ∀ a0, la = some a0 → subArgA rhs ≠ none → ∀ a, subArgA rhs = some a → a0 ≤ evalInt a ctx)
    (found : subHiStep x rhs hx lx la = some hi) : evalInt (.sub x rhs) ctx ≤ hi := by
  unfold subHiStep at found
  split at found
  · rename_i k
    change Int at k
    cases hxe : hx with
    | none => simp [hxe] at found
    | some x0 =>
      have hs : x0 - k = hi := by simpa [hxe] using found
      have ix := hhx x0 hxe
      change evalInt x ctx - k ≤ hi; omega
  · rename_i a b
    by_cases hEq : sameInt b x = true
    · cases ha : la with
      | none => simp [hEq, ha] at found
      | some a0 =>
        cases hxl : lx with
        | none => simp [hEq, ha, hxl] at found
        | some x0 =>
          by_cases hPos : 0 ≤ a0 ∧ 0 ≤ x0
          · have hxh : hx = some hi := by simpa [hEq, ha, hxl, hPos] using found
            have hbx : evalInt b ctx = evalInt x ctx := sameInt_sound ctx hEq
            have ia := hla a0 ha (by simp [subArgA]) a rfl
            have ixl := hlx x0 hxl
            have ixh := hhx hi hxh
            change evalInt x ctx - min (evalInt a ctx) (evalInt b ctx) ≤ hi; omega
          · simp [hEq, ha, hxl, hPos] at found
    · simp [hEq] at found
  · rename_i cond a b z
    change Int at z
    by_cases hEq : (sameInt b x && decide (z = 0)) = true
    · have ⟨hb, hz0⟩ : sameInt b x = true ∧ z = 0 := by
        simpa [Bool.and_eq_true, decide_eq_true_eq] using hEq
      cases ha : la with
      | none => simp [hb, hz0, ha] at found
      | some a0 =>
        cases hxl : lx with
        | none => simp [hb, hz0, ha, hxl] at found
        | some x0 =>
          by_cases hPos : 0 ≤ a0 ∧ 0 ≤ x0
          · have hxh : hx = some hi := by simpa [hb, hz0, ha, hxl, hPos] using found
            have hbx : evalInt b ctx = evalInt x ctx := sameInt_sound ctx hb
            have ia := hla a0 ha (by simp [subArgA]) a rfl
            have ixl := hlx x0 hxl
            have ixh := hhx hi hxh
            change evalInt x ctx - (if evalBool cond ctx then min (evalInt a ctx) (evalInt b ctx) else z) ≤ hi
            cases evalBool cond ctx <;> simp [hbx, hz0] <;> omega
          · simp [hb, hz0, ha, hxl, hPos] at found
    · simp [hEq] at found
  · contradiction

def mulConst : Expr .integer → Option Int
  | .literal .integer k => if decide (0 ≤ k) then some k else none
  | _ => none

theorem mulConst_sound (rhs : Expr .integer) (ctx : Context) (k : Int)
    (h : mulConst rhs = some k) : 0 ≤ k ∧ evalInt rhs ctx = k := by
  unfold mulConst at h
  split at h
  · rename_i v
    change Int at v
    by_cases hv : 0 ≤ v
    · have hk : v = k := by simpa [hv] using h
      subst hk; exact ⟨hv, rfl⟩
    · simp [hv] at h
  · contradiction

def intLo (facts : List (Expr .boolean)) {k : Kind} (e : Expr k) : Option Int :=
  match e with
  | .literal .integer v => some v
  | .bytesLength b =>
    match factsLo facts (.bytesLength b) with
    | some c => some (max 0 c)
    | none => some 0
  | .add a b =>
    match intLo facts a, intLo facts b with
    | some la, some lb => some (la + lb)
    | _, _ => factsLo facts (.add a b)
  | .sub x rhs =>
    subLoStep x rhs (intLo facts x)
      (match rhs with
       | .minimum a _ => intLo facts a
       | .choose .integer _ (.minimum a _) _ => intLo facts a
       | _ => none)
  | .mul a rhs =>
    match mulConst rhs with
    | some k => return (← intLo facts a) * k
    | none => none
  | .minimum a b => return min (← intLo facts a) (← intLo facts b)
  | .choose .integer cond yes no =>
    return min (← intLo (facts ++ atoms cond) yes) (← intLo (facts ++ atoms (.boolNot cond)) no)
  | .variable .integer n => factsLo facts (.variable .integer n)
  | .field .integer n => factsLo facts (.field .integer n)
  | .byteAt a b => factsLo facts (.byteAt a b)
  | .seqDistance a b => factsLo facts (.seqDistance a b)
  | .checksum a => factsLo facts (.checksum a)
  | _ => none
termination_by structural e

theorem intLo_sound (facts : List (Expr .boolean)) (e : Expr .integer) (ctx : Context) (lo : Int)
    (hAll : ∀ f ∈ facts, evalBool f ctx = true)
    (found : intLo facts e = some lo) : lo ≤ evalInt e ctx := by
  match e with
  | .literal .integer v =>
    change Int at v
    have hv : v = lo := by simpa [intLo] using found
    change lo ≤ v; omega
  | .bytesLength b =>
    unfold intLo at found
    have hnn : (0 : Int) ≤ Int.ofNat (evalOct b ctx).length := Int.natCast_nonneg _
    cases hf : factsLo facts (.bytesLength b) with
    | none =>
      have hz : 0 = lo := by simpa [hf] using found
      change lo ≤ Int.ofNat (evalOct b ctx).length; omega
    | some c =>
      have hc : c ≤ Int.ofNat (evalOct b ctx).length := factsLo_sound facts (.bytesLength b) ctx c hAll hf
      have hm : max 0 c = lo := by simpa [hf] using found
      change lo ≤ Int.ofNat (evalOct b ctx).length; omega
  | .add a b =>
    unfold intLo at found
    cases ha : intLo facts a with
    | none =>
      simp only [ha] at found
      exact factsLo_sound facts (.add a b) ctx lo hAll found
    | some la =>
      cases hb : intLo facts b with
      | none =>
        simp only [ha, hb] at found
        exact factsLo_sound facts (.add a b) ctx lo hAll found
      | some lb =>
        have hs : la + lb = lo := by simpa [ha, hb] using found
        have ia := intLo_sound facts a ctx la hAll ha
        have ib := intLo_sound facts b ctx lb hAll hb
        change lo ≤ evalInt a ctx + evalInt b ctx; omega
  | .sub x rhs =>
    unfold intLo at found
    exact subLoStep_sound x rhs _ _ ctx lo (fun x0 hx => intLo_sound facts x ctx x0 hAll hx) found
  | .mul a rhs =>
    unfold intLo at found
    cases hm : mulConst rhs with
    | none => simp [hm] at found
    | some k =>
      cases ha : intLo facts a with
      | none => simp [hm, ha] at found
      | some la =>
        have hs : la * k = lo := by simpa [hm, ha] using found
        have ⟨hk, hrhs⟩ := mulConst_sound rhs ctx k hm
        have ia := intLo_sound facts a ctx la hAll ha
        have hmul : la * k ≤ evalInt a ctx * k := Int.mul_le_mul_of_nonneg_right ia hk
        change lo ≤ evalInt a ctx * evalInt rhs ctx; rw [hrhs]; omega
  | .minimum a b =>
    unfold intLo at found
    cases ha : intLo facts a with
    | none => simp [ha] at found
    | some la =>
      cases hb : intLo facts b with
      | none => simp [ha, hb] at found
      | some lb =>
        have hs : min la lb = lo := by simpa [ha, hb] using found
        have ia := intLo_sound facts a ctx la hAll ha
        have ib := intLo_sound facts b ctx lb hAll hb
        change lo ≤ min (evalInt a ctx) (evalInt b ctx); omega
  | .choose .integer cond yes no =>
    unfold intLo at found
    cases hy : intLo (facts ++ atoms cond) yes with
    | none => simp [hy] at found
    | some ly =>
      cases hn : intLo (facts ++ atoms (.boolNot cond)) no with
      | none => simp [hy, hn] at found
      | some ln =>
        have hs : min ly ln = lo := by simpa [hy, hn] using found
        change lo ≤ (if evalBool cond ctx then evalInt yes ctx else evalInt no ctx)
        cases hc : evalBool cond ctx
        · have hNot : evalBool (.boolNot cond) ctx = true := by simp [evalBool, TypedIR.eval, hc]
          have hAllN : ∀ f ∈ facts ++ atoms (.boolNot cond), evalBool f ctx = true := by
            intro f hf; rcases List.mem_append.mp hf with m1 | m2
            · exact hAll f m1
            · exact atoms_sound (.boolNot cond) ctx hNot f m2
          have ino := intLo_sound (facts ++ atoms (.boolNot cond)) no ctx ln hAllN hn
          simp; omega
        · have hAllY : ∀ f ∈ facts ++ atoms cond, evalBool f ctx = true := by
            intro f hf; rcases List.mem_append.mp hf with m1 | m2
            · exact hAll f m1
            · exact atoms_sound cond ctx hc f m2
          have iyes := intLo_sound (facts ++ atoms cond) yes ctx ly hAllY hy
          simp; omega
  | .variable .integer _ | .field .integer _ | .byteAt _ _ | .seqDistance _ _ | .checksum _ =>
    exact factsLo_sound facts _ ctx lo hAll found
termination_by sizeOf e

def intHi (facts : List (Expr .boolean)) {k : Kind} (e : Expr k) : Option Int :=
  match e with
  | .literal .integer v => some v
  | .bytesLength b =>
    match OctetBounds.upper b with
    | some u =>
      match factsHi facts (.bytesLength b) with
      | some c => some (min (Int.ofNat u) c)
      | none => some (Int.ofNat u)
    | none => factsHi facts (.bytesLength b)
  | .add a b => return (← intHi facts a) + (← intHi facts b)
  | .sub x rhs =>
    subHiStep x rhs (intHi facts x) (intLo facts x)
      (match rhs with
       | .minimum a _ => intLo facts a
       | .choose .integer _ (.minimum a _) _ => intLo facts a
       | _ => none)
  | .mul a rhs =>
    match mulConst rhs with
    | some k => return (← intHi facts a) * k
    | none => none
  | .minimum a b =>
    match intHi facts a, intHi facts b with
    | some ha, some hb => some (min ha hb)
    | some ha, none => some ha
    | none, some hb => some hb
    | none, none => none
  | .choose .integer cond yes no =>
    return max (← intHi (facts ++ atoms cond) yes) (← intHi (facts ++ atoms (.boolNot cond)) no)
  | .variable .integer n => factsHi facts (.variable .integer n)
  | .field .integer n => factsHi facts (.field .integer n)
  | .byteAt a b => factsHi facts (.byteAt a b)
  | .seqDistance a b => factsHi facts (.seqDistance a b)
  | .checksum a => factsHi facts (.checksum a)
  | _ => none
termination_by structural e

theorem intHi_sound (facts : List (Expr .boolean)) (e : Expr .integer) (ctx : Context) (hi : Int)
    (hAll : ∀ f ∈ facts, evalBool f ctx = true)
    (found : intHi facts e = some hi) : evalInt e ctx ≤ hi := by
  match e with
  | .literal .integer v =>
    change Int at v
    have hv : v = hi := by simpa [intHi] using found
    change v ≤ hi; omega
  | .bytesLength b =>
    unfold intHi at found
    cases hu : OctetBounds.upper b with
    | none => simp [hu] at found; exact factsHi_sound facts _ ctx hi hAll found
    | some u =>
      have hbu : Int.ofNat (evalOct b ctx).length ≤ Int.ofNat u :=
        Int.ofNat_le.mpr (OctetBounds.sound b ctx u hu)
      cases hf : factsHi facts (.bytesLength b) with
      | none =>
        have hs : Int.ofNat u = hi := by simpa [hu, hf] using found
        change Int.ofNat (evalOct b ctx).length ≤ hi; omega
      | some c =>
        have hc : Int.ofNat (evalOct b ctx).length ≤ c := factsHi_sound facts (.bytesLength b) ctx c hAll hf
        have hs : min (Int.ofNat u) c = hi := by simpa [hu, hf] using found
        change Int.ofNat (evalOct b ctx).length ≤ hi; omega
  | .add a b =>
    unfold intHi at found
    cases ha : intHi facts a with
    | none => simp [ha] at found
    | some ha' =>
      cases hb : intHi facts b with
      | none => simp [ha, hb] at found
      | some hb' =>
        have hs : ha' + hb' = hi := by simpa [ha, hb] using found
        have ia := intHi_sound facts a ctx ha' hAll ha
        have ib := intHi_sound facts b ctx hb' hAll hb
        change evalInt a ctx + evalInt b ctx ≤ hi; omega
  | .sub x rhs =>
    unfold intHi at found
    apply subHiStep_sound x rhs _ _ _ ctx hi
      (fun x0 hx => intHi_sound facts x ctx x0 hAll hx)
      (fun x0 hx => intLo_sound facts x ctx x0 hAll hx)
      _ found
    intro a0 ha0 _ a hsub
    cases rhs with
    | minimum a1 b1 =>
      simp [subArgA] at hsub; subst hsub
      exact intLo_sound facts a1 ctx a0 hAll ha0
    | choose _ cond y n =>
      cases y with
      | minimum a1 b1 =>
        simp [subArgA] at hsub; subst hsub
        exact intLo_sound facts a1 ctx a0 hAll ha0
      | _ => simp [subArgA] at hsub
    | _ => simp [subArgA] at hsub
  | .mul a rhs =>
    unfold intHi at found
    cases hm : mulConst rhs with
    | none => simp [hm] at found
    | some k =>
      cases ha : intHi facts a with
      | none => simp [hm, ha] at found
      | some ha' =>
        have hs : ha' * k = hi := by simpa [hm, ha] using found
        have ⟨hk, hrhs⟩ := mulConst_sound rhs ctx k hm
        have ia := intHi_sound facts a ctx ha' hAll ha
        have hmul : evalInt a ctx * k ≤ ha' * k := Int.mul_le_mul_of_nonneg_right ia hk
        change evalInt a ctx * evalInt rhs ctx ≤ hi; rw [hrhs]; omega
  | .minimum a b =>
    unfold intHi at found
    cases ha : intHi facts a with
    | some ha' =>
      have ia := intHi_sound facts a ctx ha' hAll ha
      cases hb : intHi facts b with
      | some hb' =>
        have ib := intHi_sound facts b ctx hb' hAll hb
        have hs : min ha' hb' = hi := by simpa [ha, hb] using found
        change min (evalInt a ctx) (evalInt b ctx) ≤ hi; omega
      | none =>
        have hs : ha' = hi := by simpa [ha, hb] using found
        change min (evalInt a ctx) (evalInt b ctx) ≤ hi; omega
    | none =>
      cases hb : intHi facts b with
      | some hb' =>
        have ib := intHi_sound facts b ctx hb' hAll hb
        have hs : hb' = hi := by simpa [ha, hb] using found
        change min (evalInt a ctx) (evalInt b ctx) ≤ hi; omega
      | none => simp [ha, hb] at found
  | .choose .integer cond yes no =>
    unfold intHi at found
    cases hy : intHi (facts ++ atoms cond) yes with
    | none => simp [hy] at found
    | some hy' =>
      cases hn : intHi (facts ++ atoms (.boolNot cond)) no with
      | none => simp [hy, hn] at found
      | some hn' =>
        have hs : max hy' hn' = hi := by simpa [hy, hn] using found
        change (if evalBool cond ctx then evalInt yes ctx else evalInt no ctx) ≤ hi
        cases hc : evalBool cond ctx
        · have hNot : evalBool (.boolNot cond) ctx = true := by simp [evalBool, TypedIR.eval, hc]
          have hAllN : ∀ f ∈ facts ++ atoms (.boolNot cond), evalBool f ctx = true := by
            intro f hf; rcases List.mem_append.mp hf with m1 | m2
            · exact hAll f m1
            · exact atoms_sound (.boolNot cond) ctx hNot f m2
          have ino := intHi_sound (facts ++ atoms (.boolNot cond)) no ctx hn' hAllN hn
          simp; omega
        · have hAllY : ∀ f ∈ facts ++ atoms cond, evalBool f ctx = true := by
            intro f hf; rcases List.mem_append.mp hf with m1 | m2
            · exact hAll f m1
            · exact atoms_sound cond ctx hc f m2
          have iyes := intHi_sound (facts ++ atoms cond) yes ctx hy' hAllY hy
          simp; omega
  | .variable .integer _ | .field .integer _ | .byteAt _ _ | .seqDistance _ _ | .checksum _ =>
    exact factsHi_sound facts _ ctx hi hAll found
termination_by sizeOf e

def sliceRoomFact (src : Expr .octets) (off : Expr .integer) (k : Int) : Expr .boolean → Bool
  | .intLe (.add base (.literal .integer m)) (.bytesLength s) =>
    sameOct s src && (
      (sameInt off base && decide (k ≤ m)) ||
      match off with
      | .add b2 (.literal .integer d) => sameInt b2 base && decide (0 ≤ d ∧ d + k ≤ m)
      | _ => false)
  | _ => false

theorem sliceRoomFact_sound (src : Expr .octets) (off : Expr .integer) (k : Int)
    (fact : Expr .boolean) (ctx : Context)
    (hf : evalBool fact ctx = true) (ok : sliceRoomFact src off k fact = true) :
    evalInt off ctx + k ≤ ((evalOct src ctx).length : Int) := by
  unfold sliceRoomFact at ok
  split at ok
  · rename_i base m s
    change Int at m
    simp only [Bool.and_eq_true, Bool.or_eq_true] at ok
    have hs : evalOct s ctx = evalOct src ctx := sameOct_sound ctx ok.1
    have hle : evalInt base ctx + m ≤ ((evalOct s ctx).length : Int) := of_decide_eq_true hf
    rw [← hs]
    rcases ok.2 with h1 | h2
    · have hkm : k ≤ m := of_decide_eq_true h1.2
      have hob : evalInt off ctx = evalInt base ctx := sameInt_sound ctx h1.1
      omega
    · cases off with
      | add b2 dExpr =>
        cases dExpr with
        | literal _ d =>
          change Int at d
          simp only [Bool.and_eq_true] at h2
          have hd : 0 ≤ d ∧ d + k ≤ m := of_decide_eq_true h2.2
          have hbEq : evalInt b2 ctx = evalInt base ctx := sameInt_sound ctx h2.1
          change (evalInt b2 ctx + d) + k ≤ ((evalOct s ctx).length : Int)
          omega
        | _ => simp at h2
      | _ => simp at h2
  · contradiction

def octHi (facts : List (Expr .boolean)) {k : Kind} (e : Expr k) : Option Nat :=
  match OctetBounds.upper e with
  | some u => some u
  | none =>
    match e with
    | .concat a b => return (← octHi facts a) + (← octHi facts b)
    | .choose .octets cond yes no =>
      return max (← octHi (facts ++ atoms cond) yes) (← octHi (facts ++ atoms (.boolNot cond)) no)
    | .slice src _ cnt =>
      match intHi facts cnt with
      | some hc => if decide (0 ≤ hc) then some hc.toNat else octHi facts src
      | none => octHi facts src
    | .variable .octets n =>
      match intHi facts (.bytesLength (.variable .octets n)) with
      | some hi => if decide (0 ≤ hi) then some hi.toNat else none
      | none => none
    | .field .octets n =>
      match intHi facts (.bytesLength (.field .octets n)) with
      | some hi => if decide (0 ≤ hi) then some hi.toNat else none
      | none => none
    | _ => none
termination_by structural e

theorem octHi_sound (facts : List (Expr .boolean)) (e : Expr .octets) (ctx : Context) (u : Nat)
    (hAll : ∀ f ∈ facts, evalBool f ctx = true)
    (found : octHi facts e = some u) : (evalOct e ctx).length ≤ u := by
  by_cases hU : ∃ u0, OctetBounds.upper e = some u0
  · obtain ⟨u0, hu⟩ := hU
    unfold octHi at found
    have hs : u0 = u := by simpa [hu] using found
    subst hs
    exact OctetBounds.sound e ctx u0 hu
  · have hu : OctetBounds.upper e = none := by
      cases h : OctetBounds.upper e with
      | none => rfl
      | some u0 => exact False.elim (hU ⟨u0, h⟩)
    match e with
    | .concat a b =>
      unfold octHi at found; simp only [hu] at found
      cases ha : octHi facts a with
      | none => simp [ha] at found
      | some ua =>
        cases hb : octHi facts b with
        | none => simp [ha, hb] at found
        | some ub =>
          have hs : ua + ub = u := by simpa [ha, hb] using found
          subst hs
          change (evalOct a ctx ++ evalOct b ctx).length ≤ ua + ub
          rw [List.length_append]
          exact Nat.add_le_add (octHi_sound facts a ctx ua hAll ha) (octHi_sound facts b ctx ub hAll hb)
    | .choose .octets cond yes no =>
      unfold octHi at found; simp only [hu] at found
      cases hy : octHi (facts ++ atoms cond) yes with
      | none => simp [hy] at found
      | some uy =>
        cases hn : octHi (facts ++ atoms (.boolNot cond)) no with
        | none => simp [hy, hn] at found
        | some un =>
          have hs : max uy un = u := by simpa [hy, hn] using found
          subst hs
          change (if evalBool cond ctx then evalOct yes ctx else evalOct no ctx).length ≤ max uy un
          cases hc : evalBool cond ctx
          · have hNot : evalBool (.boolNot cond) ctx = true := by simp [evalBool, TypedIR.eval, hc]
            have hAllN : ∀ f ∈ facts ++ atoms (.boolNot cond), evalBool f ctx = true := by
              intro f hf; rcases List.mem_append.mp hf with m1 | m2
              · exact hAll f m1
              · exact atoms_sound (.boolNot cond) ctx hNot f m2
            simp; exact Nat.le_trans (octHi_sound _ no ctx un hAllN hn) (Nat.le_max_right ..)
          · have hAllY : ∀ f ∈ facts ++ atoms cond, evalBool f ctx = true := by
              intro f hf; rcases List.mem_append.mp hf with m1 | m2
              · exact hAll f m1
              · exact atoms_sound cond ctx hc f m2
            simp; exact Nat.le_trans (octHi_sound _ yes ctx uy hAllY hy) (Nat.le_max_left ..)
    | .slice src off cnt =>
      unfold octHi at found; simp only [hu] at found
      cases hcnt : intHi facts cnt with
      | some hc =>
        by_cases hpos : 0 ≤ hc
        · have hs : hc.toNat = u := by simpa [hcnt, hpos] using found
          subst hs
          have ic := intHi_sound facts cnt ctx hc hAll hcnt
          change (byteSlice (evalOct src ctx) (evalInt off ctx) (evalInt cnt ctx)).length ≤ hc.toNat
          simp only [byteSlice, List.length_take]
          omega
        · simp [hcnt, hpos] at found
          have isrc := octHi_sound facts src ctx u hAll found
          change (byteSlice (evalOct src ctx) (evalInt off ctx) (evalInt cnt ctx)).length ≤ u
          simp only [byteSlice, List.length_take, List.length_drop]
          omega
      | none =>
        simp [hcnt] at found
        have isrc := octHi_sound facts src ctx u hAll found
        change (byteSlice (evalOct src ctx) (evalInt off ctx) (evalInt cnt ctx)).length ≤ u
        simp only [byteSlice, List.length_take, List.length_drop]
        omega
    | .variable .octets n =>
      unfold octHi at found; simp only [hu] at found
      cases hhi : intHi facts (.bytesLength (.variable .octets n)) with
      | none => simp [hhi] at found
      | some hi =>
        by_cases hpos : 0 ≤ hi
        · have hs : hi.toNat = u := by simpa [hhi, hpos] using found
          subst hs
          have ih : ((evalOct (.variable .octets n) ctx).length : Int) ≤ hi :=
            intHi_sound facts (.bytesLength (.variable .octets n)) ctx hi hAll hhi
          omega
        · simp [hhi, hpos] at found
    | .field .octets n =>
      unfold octHi at found; simp only [hu] at found
      cases hhi : intHi facts (.bytesLength (.field .octets n)) with
      | none => simp [hhi] at found
      | some hi =>
        by_cases hpos : 0 ≤ hi
        · have hs : hi.toNat = u := by simpa [hhi, hpos] using found
          subst hs
          have ih : ((evalOct (.field .octets n) ctx).length : Int) ≤ hi :=
            intHi_sound facts (.bytesLength (.field .octets n)) ctx hi hAll hhi
          omega
        · simp [hhi, hpos] at found
    | .literal .octets _ | .pack8 _ | .pack16 _ | .pack32 _ =>
      simp [OctetBounds.upper] at hu
termination_by sizeOf e

def sliceConstLen : Expr .integer → Option Int
  | .literal .integer k => if decide (0 ≤ k) then some k else none
  | _ => none

theorem sliceConstLen_sound (cnt : Expr .integer) (ctx : Context) (k : Int)
    (h : sliceConstLen cnt = some k) : 0 ≤ k ∧ evalInt cnt ctx = k := by
  unfold sliceConstLen at h
  split at h
  · rename_i v
    change Int at v
    by_cases hv : 0 ≤ v
    · have hk : v = k := by simpa [hv] using h
      subst hk; exact ⟨hv, rfl⟩
    · simp [hv] at h
  · contradiction

def octLo (facts : List (Expr .boolean)) {k : Kind} (e : Expr k) : Nat :=
  match e with
  | .literal .octets bs => bs.length
  | .pack8 _ => 1
  | .pack16 _ => 2
  | .pack32 _ => 4
  | .concat a b => octLo facts a + octLo facts b
  | .choose .octets cond yes no =>
    min (octLo (facts ++ atoms cond) yes) (octLo (facts ++ atoms (.boolNot cond)) no)
  | .slice src off cnt =>
    match sliceConstLen cnt with
    | some k =>
      match intLo facts off with
      | some loOff =>
        if decide (0 ≤ loOff) then
          if facts.any (sliceRoomFact src off k) then k.toNat
          else
            match intHi facts off with
            | some hiOff =>
              if decide ((hiOff + k).toNat ≤ octLo facts src ∧ 0 ≤ hiOff) then k.toNat else 0
            | none => 0
        else 0
      | none => 0
    | none => 0
  | .variable .octets n =>
    match intLo facts (.bytesLength (.variable .octets n)) with
    | some lo => if decide (0 ≤ lo) then lo.toNat else 0
    | none => 0
  | .field .octets n =>
    match intLo facts (.bytesLength (.field .octets n)) with
    | some lo => if decide (0 ≤ lo) then lo.toNat else 0
    | none => 0
  | _ => 0
termination_by structural e

theorem octLo_sound (facts : List (Expr .boolean)) (e : Expr .octets) (ctx : Context)
    (hAll : ∀ f ∈ facts, evalBool f ctx = true) :
    octLo facts e ≤ (evalOct e ctx).length := by
  match e with
  | .literal .octets _ => exact Nat.le_refl _
  | .pack8 _ => change 1 ≤ (ValueOps.pack8 _).length; simp [ValueOps.pack8]
  | .pack16 _ => change 2 ≤ (ValueOps.pack16 _).length; simp [ValueOps.pack16]
  | .pack32 _ => change 4 ≤ (ValueOps.pack32 _).length; simp [ValueOps.pack32]
  | .concat a b =>
    unfold octLo
    change octLo facts a + octLo facts b ≤ (evalOct a ctx ++ evalOct b ctx).length
    rw [List.length_append]
    exact Nat.add_le_add (octLo_sound facts a ctx hAll) (octLo_sound facts b ctx hAll)
  | .choose .octets cond yes no =>
    unfold octLo
    change min _ _ ≤ (if evalBool cond ctx then evalOct yes ctx else evalOct no ctx).length
    cases hc : evalBool cond ctx
    · have hNot : evalBool (.boolNot cond) ctx = true := by simp [evalBool, TypedIR.eval, hc]
      have hAllN : ∀ f ∈ facts ++ atoms (.boolNot cond), evalBool f ctx = true := by
        intro f hf; rcases List.mem_append.mp hf with m1 | m2
        · exact hAll f m1
        · exact atoms_sound (.boolNot cond) ctx hNot f m2
      simp; exact Nat.le_trans (Nat.min_le_right ..) (octLo_sound _ no ctx hAllN)
    · have hAllY : ∀ f ∈ facts ++ atoms cond, evalBool f ctx = true := by
        intro f hf; rcases List.mem_append.mp hf with m1 | m2
        · exact hAll f m1
        · exact atoms_sound cond ctx hc f m2
      simp; exact Nat.le_trans (Nat.min_le_left ..) (octLo_sound _ yes ctx hAllY)
  | .slice src off cnt =>
    unfold octLo
    cases hkE : sliceConstLen cnt with
    | none => exact Nat.zero_le _
    | some k =>
      have ⟨hk, hcntEq⟩ := sliceConstLen_sound cnt ctx k hkE
      cases hloE : intLo facts off with
      | none => exact Nat.zero_le _
      | some loOff =>
        by_cases hlo : 0 ≤ loOff
        · have ioffLo := intLo_sound facts off ctx loOff hAll hloE
          by_cases hRoom : facts.any (sliceRoomFact src off k) = true
          · simp only [hlo, decide_true, hRoom, ite_true]
            obtain ⟨f, hfMem, hfOk⟩ := List.any_eq_true.mp hRoom
            have hBound := sliceRoomFact_sound src off k f ctx (hAll f hfMem) hfOk
            change k.toNat ≤ (byteSlice (evalOct src ctx) (evalInt off ctx) (evalInt cnt ctx)).length
            simp only [byteSlice, List.length_take, List.length_drop, hcntEq]
            omega
          · cases hhiE : intHi facts off with
            | none => simp [hlo, hRoom]
            | some hiOff =>
              by_cases hFit : (hiOff + k).toNat ≤ octLo facts src ∧ 0 ≤ hiOff
              · simp only [hlo, decide_true, hRoom, Bool.false_eq_true, ite_false, hFit, and_self, ite_true]
                have ioffHi := intHi_sound facts off ctx hiOff hAll hhiE
                have isrc := octLo_sound facts src ctx hAll
                change k.toNat ≤ (byteSlice (evalOct src ctx) (evalInt off ctx) (evalInt cnt ctx)).length
                simp only [byteSlice, List.length_take, List.length_drop, hcntEq]
                omega
              · simp only [hlo, decide_true, hRoom, Bool.false_eq_true, ite_false, hFit, decide_false]
                exact Nat.zero_le _
        · simp [hlo]
  | .variable .octets n =>
    unfold octLo
    cases hlo : intLo facts (.bytesLength (.variable .octets n)) with
    | none => exact Nat.zero_le _
    | some lo =>
      by_cases hpos : 0 ≤ lo
      · simp only [hpos, decide_true, ite_true]
        have ilo : lo ≤ ((evalOct (.variable .octets n) ctx).length : Int) :=
          intLo_sound facts (.bytesLength (.variable .octets n)) ctx lo hAll hlo
        omega
      · simp [hpos]
  | .field .octets n =>
    unfold octLo
    cases hlo : intLo facts (.bytesLength (.field .octets n)) with
    | none => exact Nat.zero_le _
    | some lo =>
      by_cases hpos : 0 ≤ lo
      · simp only [hpos, decide_true, ite_true]
        have ilo : lo ≤ ((evalOct (.field .octets n) ctx).length : Int) :=
          intLo_sound facts (.bytesLength (.field .octets n)) ctx lo hAll hlo
        omega
      · simp [hpos]
termination_by sizeOf e

def certBool (facts : List (Expr .boolean)) {k : Kind} (e : Expr k) : Bool :=
  match e with
  | .boolAnd a b => certBool facts a && certBool facts b
  | .intGe lhs (.literal .integer rhs) =>
    match intLo facts lhs with
    | some lo => decide (rhs ≤ lo)
    | none => false
  | .intLe lhs (.literal .integer rhs) =>
    match lhs with
    | .bytesLength b =>
      match octHi facts b with
      | some sz => decide (Int.ofNat sz ≤ rhs)
      | none => false
    | _ =>
      match intHi facts lhs with
      | some hi => decide (hi ≤ rhs)
      | none => false
  | .equal .integer (.bytesLength b) (.literal .integer n) =>
    if decide (0 ≤ n) then
      match octHi facts b with
      | some sz => decide (sz ≤ n.toNat ∧ n.toNat ≤ octLo facts b)
      | none => false
    else false
  | _ => false
termination_by structural e

theorem certBool_sound (facts : List (Expr .boolean)) (e : Expr .boolean) (ctx : Context)
    (hAll : ∀ f ∈ facts, evalBool f ctx = true)
    (ok : certBool facts e = true) : evalBool e ctx = true := by
  unfold certBool at ok
  split at ok
  · rename_i a b _
    simp only [Bool.and_eq_true] at ok
    change evalBool a ctx && evalBool b ctx = true
    simp [certBool_sound facts a ctx hAll ok.1, certBool_sound facts b ctx hAll ok.2]
  · rename_i lhs rv _
    change Int at rv
    cases hlo : intLo facts lhs with
    | none => simp [hlo] at ok
    | some lo =>
      have hrv : rv ≤ lo := by simpa [hlo, decide_eq_true_eq] using ok
      have ilo := intLo_sound facts lhs ctx lo hAll hlo
      change decide (evalInt lhs ctx ≥ rv) = true
      exact decide_eq_true (by omega)
  · rename_i lhs rv _
    change Int at rv
    split at ok
    · rename_i b
      cases hu : octHi facts b with
      | none => simp [hu] at ok
      | some sz =>
        have hrv : (sz : Int) ≤ rv := by simpa [hu, Int.ofNat_eq_natCast, decide_eq_true_eq] using ok
        have ib := octHi_sound facts b ctx sz hAll hu
        change decide (((evalOct b ctx).length : Int) ≤ rv) = true
        exact decide_eq_true (by omega)
    · cases hhi : intHi facts lhs with
      | none => simp [hhi] at ok
      | some hi =>
        have hrv : hi ≤ rv := by simpa [hhi, decide_eq_true_eq] using ok
        have ihi := intHi_sound facts lhs ctx hi hAll hhi
        change decide (evalInt lhs ctx ≤ rv) = true
        exact decide_eq_true (by omega)
  · rename_i b n _
    change Int at n
    by_cases hn : 0 ≤ n
    · cases hu : octHi facts b with
      | none => simp [hn, hu] at ok
      | some sz =>
        have hbnd : sz ≤ n.toNat ∧ n.toNat ≤ octLo facts b := by
          simpa [hn, hu, decide_eq_true_eq] using ok
        have ibHi := octHi_sound facts b ctx sz hAll hu
        have ibLo := octLo_sound facts b ctx hAll
        change decide (((evalOct b ctx).length : Int) = n) = true
        exact decide_eq_true (by omega)
    · simp [hn] at ok
  · contradiction
termination_by sizeOf e

def certRule (m : Model) (r : Rule) (firing : Option Nat) : Bool :=
  m.invariants.all noFields &&
  (let facts := invAtoms m.invariants ++ atoms r.guard
   (obligations m r firing).all (certBool facts))

theorem preserves_cert (m : Model) (r : Rule) (firing : Option Nat)
    (ok : certRule m r firing = true) : FiringPreserves m r firing := by
  have ⟨hNoF, hObs⟩ : m.invariants.all noFields = true ∧
      (obligations m r firing).all (certBool (invAtoms m.invariants ++ atoms r.guard)) = true := by
    simpa [certRule, Bool.and_eq_true] using ok
  apply EffectConditions.preserves
  intro s f valid _ enabled
  have hInv := invAtoms_sound m s f hNoF valid
  have hGuard := atoms_sound r.guard (context s f) enabled
  have hFacts : ∀ a ∈ invAtoms m.invariants ++ atoms r.guard, evalBool a (context s f) = true := by
    intro a ha
    rcases List.mem_append.mp ha with m1 | m2
    · exact hInv a m1
    · exact hGuard a m2
  apply List.all_eq_true.mpr
  intro ob hOb
  exact certBool_sound _ ob (context s f) hFacts (List.all_eq_true.mp hObs ob hOb)

theorem each_of_all {α : Type} (P : α → Prop) (B : α → Bool) (xs : List α)
    (sound : ∀ x, B x = true → P x) (ok : xs.all B = true) : Each P xs := by
  induction xs with
  | nil => trivial
  | cons x rest ih =>
    simp only [List.all_cons, Bool.and_eq_true] at ok
    exact ⟨sound x ok.1, ih ok.2⟩

theorem preserves_all (m : Model) (ids : List Nat)
    (ok : (rawChecks m ids).all (fun p => certRule m p.1 p.2) = true) :
    Each (fun p => FiringPreserves m p.1 p.2) (rawChecks m ids) :=
  each_of_all _ _ _ (fun p hp => preserves_cert m p.1 p.2 hp) ok

/-- Pairwise guard clash on boolean conjuncts for residual conflict pairs. -/
def atomClashAux (p q : Expr .boolean) : Bool :=
  match p, q with
  | .boolNot (.intLe x (.literal .integer z1)), .equal .integer y (.literal .integer z2) =>
    sameExpr x y && decide (z1 = 0 ∧ z2 = 0)
  | .equal .integer x (.literal .integer z1), .boolNot (.intLe y (.literal .integer z2)) =>
    sameExpr x y && decide (z1 = 0 ∧ z2 = 0)
  | .equal .sequence s1 s2, .seqLt t2 t1 =>
    (sameExpr s1 t1 && sameExpr s2 t2) || (sameExpr s1 t2 && sameExpr s2 t1)
  | .seqLt t2 t1, .equal .sequence s1 s2 =>
    (sameExpr s1 t1 && sameExpr s2 t2) || (sameExpr s1 t2 && sameExpr s2 t1)
  | .equal .sequence s1 s2, .boolNot (.seqLe t1 t2) =>
    (sameExpr s1 t1 && sameExpr s2 t2) || (sameExpr s1 t2 && sameExpr s2 t1)
  | .boolNot (.seqLe t1 t2), .equal .sequence s1 s2 =>
    (sameExpr s1 t1 && sameExpr s2 t2) || (sameExpr s1 t2 && sameExpr s2 t1)
  | _, _ => false

theorem atomClashAux_sound (p q : Expr .boolean) (ctx : Context)
    (hp : evalBool p ctx = true) (hq : evalBool q ctx = true)
    (ok : atomClashAux p q = true) : False := by
  unfold atomClashAux at ok
  split at ok
  · rename_i x z1 y z2
    change Int at z1 z2
    simp only [Bool.and_eq_true] at ok
    have hz : z1 = 0 ∧ z2 = 0 := of_decide_eq_true ok.2
    have hxy : evalInt x ctx = evalInt y ctx := sameExpr_sound ctx ok.1
    have hy0 : evalInt y ctx = z2 := of_decide_eq_true hq
    have hdec : decide (evalInt x ctx ≤ z1) = false := (Bool.not_eq_true' _).mp hp
    have hxPos : ¬ (evalInt x ctx ≤ z1) := of_decide_eq_false hdec
    omega
  · rename_i x z1 y z2
    change Int at z1 z2
    simp only [Bool.and_eq_true] at ok
    have hz : z1 = 0 ∧ z2 = 0 := of_decide_eq_true ok.2
    have hxy : evalInt x ctx = evalInt y ctx := sameExpr_sound ctx ok.1
    have hx0 : evalInt x ctx = z1 := of_decide_eq_true hp
    have hdec : decide (evalInt y ctx ≤ z2) = false := (Bool.not_eq_true' _).mp hq
    have hyPos : ¬ (evalInt y ctx ≤ z2) := of_decide_eq_false hdec
    omega
  · rename_i s1 s2 t2 t1
    have hs : evalSeq s1 ctx = evalSeq s2 ctx := of_decide_eq_true hp
    have ht : 0 < ValueOps.seqDistance (evalSeq t2 ctx) (evalSeq t1 ctx) ∧
        ValueOps.seqDistance (evalSeq t2 ctx) (evalSeq t1 ctx) < 2147483648 := of_decide_eq_true hq
    simp only [Bool.or_eq_true, Bool.and_eq_true] at ok
    rcases ok with ⟨h1, h2⟩ | ⟨h1, h2⟩
    · have e1 : evalSeq s1 ctx = evalSeq t1 ctx := sameExpr_sound ctx h1
      have e2 : evalSeq s2 ctx = evalSeq t2 ctx := sameExpr_sound ctx h2
      have same : evalSeq t2 ctx = evalSeq t1 ctx := e2.symm.trans (hs.symm.trans e1)
      simp [same, ValueOps.seqDistance] at ht
    · have e1 : evalSeq s1 ctx = evalSeq t2 ctx := sameExpr_sound ctx h1
      have e2 : evalSeq s2 ctx = evalSeq t1 ctx := sameExpr_sound ctx h2
      have same : evalSeq t2 ctx = evalSeq t1 ctx := e1.symm.trans (hs.trans e2)
      simp [same, ValueOps.seqDistance] at ht
  · rename_i t2 t1 s1 s2
    have hs : evalSeq s1 ctx = evalSeq s2 ctx := of_decide_eq_true hq
    have ht : 0 < ValueOps.seqDistance (evalSeq t2 ctx) (evalSeq t1 ctx) ∧
        ValueOps.seqDistance (evalSeq t2 ctx) (evalSeq t1 ctx) < 2147483648 := of_decide_eq_true hp
    simp only [Bool.or_eq_true, Bool.and_eq_true] at ok
    rcases ok with ⟨h1, h2⟩ | ⟨h1, h2⟩
    · have e1 : evalSeq s1 ctx = evalSeq t1 ctx := sameExpr_sound ctx h1
      have e2 : evalSeq s2 ctx = evalSeq t2 ctx := sameExpr_sound ctx h2
      have same : evalSeq t2 ctx = evalSeq t1 ctx := e2.symm.trans (hs.symm.trans e1)
      simp [same, ValueOps.seqDistance] at ht
    · have e1 : evalSeq s1 ctx = evalSeq t2 ctx := sameExpr_sound ctx h1
      have e2 : evalSeq s2 ctx = evalSeq t1 ctx := sameExpr_sound ctx h2
      have same : evalSeq t2 ctx = evalSeq t1 ctx := e1.symm.trans (hs.trans e2)
      simp [same, ValueOps.seqDistance] at ht
  · rename_i s1 s2 t1 t2
    have hs : evalSeq s1 ctx = evalSeq s2 ctx := of_decide_eq_true hp
    simp only [Bool.or_eq_true, Bool.and_eq_true] at ok
    have same : evalSeq t1 ctx = evalSeq t2 ctx := by
      rcases ok with ⟨h1, h2⟩ | ⟨h1, h2⟩
      · exact (sameExpr_sound ctx h1).symm.trans (hs.trans (sameExpr_sound ctx h2))
      · exact (sameExpr_sound ctx h2).symm.trans (hs.symm.trans (sameExpr_sound ctx h1))
    simp [evalBool, TypedIR.eval, evalSeq, same, ValueOps.seqLe, ValueOps.seqDistance] at hq
  · rename_i t1 t2 s1 s2
    have hs : evalSeq s1 ctx = evalSeq s2 ctx := of_decide_eq_true hq
    simp only [Bool.or_eq_true, Bool.and_eq_true] at ok
    have same : evalSeq t1 ctx = evalSeq t2 ctx := by
      rcases ok with ⟨h1, h2⟩ | ⟨h1, h2⟩
      · exact (sameExpr_sound ctx h1).symm.trans (hs.trans (sameExpr_sound ctx h2))
      · exact (sameExpr_sound ctx h2).symm.trans (hs.symm.trans (sameExpr_sound ctx h1))
    simp [evalBool, TypedIR.eval, evalSeq, same, ValueOps.seqLe, ValueOps.seqDistance] at hp
  · contradiction

def negSame (p q : Expr .boolean) : Bool :=
  match p with
  | .boolNot a => sameExpr a q
  | _ => false

theorem negSame_sound (p q : Expr .boolean) (ctx : Context)
    (hp : evalBool p ctx = true) (hq : evalBool q ctx = true)
    (ok : negSame p q = true) : False := by
  unfold negSame at ok
  split at ok
  · rename_i a
    have heq : evalBool a ctx = evalBool q ctx := sameExpr_sound ctx ok
    simp [evalBool, TypedIR.eval, heq, hq] at hp
  · contradiction

def atomClash (p q : Expr .boolean) : Bool :=
  negSame p q || negSame q p || atomClashAux p q

theorem atomClash_sound (p q : Expr .boolean) (ctx : Context)
    (hp : evalBool p ctx = true) (hq : evalBool q ctx = true)
    (ok : atomClash p q = true) : False := by
  simp only [atomClash, Bool.or_eq_true] at ok
  rcases ok with (h1 | h2) | h3
  · exact negSame_sound p q ctx hp hq h1
  · exact negSame_sound q p ctx hq hp h2
  · exact atomClashAux_sound p q ctx hp hq h3

/-- Check if `atoms` implies `target` (used when the other guard has `.boolNot target`). -/
def impliedByAtoms (as : List (Expr .boolean)) {k : Kind} (target : Expr k) : Bool :=
  match k, target with
  | .boolean, t =>
    as.any (fun a => sameExpr a t) ||
    match t with
    | .boolAnd x y => impliedByAtoms as x && impliedByAtoms as y
    | .boolOr x y => impliedByAtoms as x || impliedByAtoms as y
    | _ => false
  | _, _ => false
termination_by structural target

theorem impliedByAtoms_sound (as : List (Expr .boolean)) (target : Expr .boolean) (ctx : Context)
    (hAll : ∀ a ∈ as, evalBool a ctx = true)
    (ok : impliedByAtoms as target = true) : evalBool target ctx = true := by
  by_cases hHit : as.any (fun a => sameExpr a target) = true
  · obtain ⟨a, haMem, hSame⟩ := List.any_eq_true.mp hHit
    have heq : evalBool a ctx = evalBool target ctx := sameExpr_sound ctx hSame
    rw [← heq]
    exact hAll a haMem
  · match target with
    | .boolAnd x y =>
      unfold impliedByAtoms at ok
      simp only [hHit, Bool.false_or, Bool.and_eq_true] at ok
      change evalBool x ctx && evalBool y ctx = true
      simp [impliedByAtoms_sound as x ctx hAll ok.1, impliedByAtoms_sound as y ctx hAll ok.2]
    | .boolOr x y =>
      unfold impliedByAtoms at ok
      simp only [hHit, Bool.false_or, Bool.or_eq_true] at ok
      change evalBool x ctx || evalBool y ctx = true
      rcases ok with hx | hy
      · simp [impliedByAtoms_sound as x ctx hAll hx]
      · simp [impliedByAtoms_sound as y ctx hAll hy]
    | .literal .. | .variable .. | .field .. | .stateIs .. | .timerActive .. |
      .equal .. | .notEqual .. | .choose .. | .boolNot .. | .implies .. |
      .intLe .. | .intGe .. | .seqComparable .. | .seqLt .. | .seqLe .. =>
      unfold impliedByAtoms at ok
      simp [hHit] at ok
termination_by sizeOf target

def negImplied (as : List (Expr .boolean)) : Expr .boolean → Bool
  | .boolNot inner => impliedByAtoms as inner
  | _ => false

theorem negImplied_sound (as : List (Expr .boolean)) (q : Expr .boolean) (ctx : Context)
    (hAll : ∀ a ∈ as, evalBool a ctx = true) (hq : evalBool q ctx = true)
    (ok : negImplied as q = true) : False := by
  unfold negImplied at ok
  split at ok
  · rename_i inner
    have hi := impliedByAtoms_sound as inner ctx hAll ok
    simp [evalBool, TypedIR.eval, hi] at hq
  · contradiction

def disjointRule (r1 r2 : Rule) : Bool :=
  let a1 := atoms r1.guard
  let a2 := atoms r2.guard
  a1.any (fun p => a2.any (atomClash p)) ||
  a2.any (negImplied a1) ||
  a1.any (negImplied a2)

theorem disjointRule_sound (m : Model) (r1 r2 : Rule) (ok : disjointRule r1 r2 = true) :
    PairDisjoint m (r1, r2) := by
  intro s f _ _
  cases h1 : TypedMachine.eval s f r1.guard
  · exact Or.inl rfl
  cases h2 : TypedMachine.eval s f r2.guard
  · exact Or.inr rfl
  exfalso
  have a1s := atoms_sound r1.guard (context s f) h1
  have a2s := atoms_sound r2.guard (context s f) h2
  simp only [disjointRule, Bool.or_eq_true] at ok
  rcases ok with (hClash | hNeg2) | hNeg1
  · obtain ⟨p, hpMem, hqAny⟩ := List.any_eq_true.mp hClash
    obtain ⟨q, hqMem, hpq⟩ := List.any_eq_true.mp hqAny
    exact atomClash_sound p q (context s f) (a1s p hpMem) (a2s q hqMem) hpq
  · obtain ⟨q, hqMem, hOk⟩ := List.any_eq_true.mp hNeg2
    exact negImplied_sound _ q (context s f) a1s (a2s q hqMem) hOk
  · obtain ⟨p, hpMem, hOk⟩ := List.any_eq_true.mp hNeg1
    exact negImplied_sound _ p (context s f) a2s (a1s p hpMem) hOk

def certGroup (g : List Rule) : Bool :=
  (residualPairs g).all (fun p => disjointRule p.1 p.2)

theorem certGroup_sound (m : Model) (g : List Rule) (ok : certGroup g = true) :
    ConflictFree m g :=
  conflict_from_residual m g (each_of_all _ _ _ (fun p hp => disjointRule_sound m p.1 p.2 hp) ok)

theorem conflicts_all (m : Model) (ok : (conflictChecks m).all certGroup = true) :
    Each (ConflictFree m) (conflictChecks m) :=
  each_of_all _ _ _ (certGroup_sound m) ok

/-- Timer coverage certifier for unconditional, binary partition, and 5-way TCP RTX groups. -/
def isTrueLit : Expr .boolean → Bool
  | .literal .boolean b => b
  | _ => false

def negOf : Expr .boolean → Option (Expr .boolean)
  | .boolNot p => some p
  | _ => none

theorem negOf_sound (g p : Expr .boolean) (ctx : Context) (h : negOf g = some p) :
    evalBool g ctx = !(evalBool p ctx) := by
  cases g with
  | boolNot q => simp [negOf] at h; subst h; rfl
  | _ => simp [negOf] at h

def isBinaryCover (rs : List Rule) : Bool :=
  rs.any fun r1 =>
    match negOf r1.guard with
    | some p => rs.any fun r2 => sameExpr r2.guard p
    | none => false

def extractAnd : Expr .boolean → Option (Expr .boolean × Expr .boolean)
  | .boolAnd a b => some (a, b)
  | _ => none

theorem extractAnd_sound {g a b : Expr .boolean} (ctx : Context) (h : extractAnd g = some (a, b)) :
    evalBool g ctx = (evalBool a ctx && evalBool b ctx) := by
  cases g with
  | boolAnd x y =>
    simp [extractAnd] at h
    rcases h with ⟨rfl, rfl⟩
    rfl
  | _ => simp [extractAnd] at h

def extractEqLenZero : Expr .boolean → Option (Expr .octets)
  | .equal .integer (.bytesLength sb) (.literal .integer z) =>
    if decide (z = 0) then some sb else none
  | _ => none

theorem extractEqLenZero_sound {e : Expr .boolean} {sb : Expr .octets} (ctx : Context)
    (h : extractEqLenZero e = some sb) :
    evalBool e ctx = decide (((evalOct sb ctx).length : Int) = 0) := by
  unfold extractEqLenZero at h
  split at h
  · rename_i b z
    change Int at z
    by_cases hz : z = 0
    · have hb : b = sb := by simpa [hz] using h
      subst hb; subst hz
      rfl
    · simp [hz] at h
  · contradiction

def isTcpRtxCover (rs : List Rule) : Bool :=
  match rs with
  | [r0, r1, r2, r3, r4] =>
    let zwp := r0.guard
    match extractAnd r4.guard with
    | some (negZwp, retryGe) =>
      sameExpr negZwp (.boolNot zwp) &&
      match extractAnd r2.guard with
      | some (mid, fq) =>
        match extractAnd mid with
        | some (negRetry, eqZero) =>
          match extractEqLenZero eqZero with
          | some sb =>
            sameExpr negRetry (.boolNot retryGe) &&
            sameExpr r1.guard (.boolAnd (.boolAnd (.boolNot zwp) (.boolNot retryGe))
              (.boolNot (.intLe (.bytesLength sb) (.literal .integer 0)))) &&
            sameExpr r3.guard (.boolAnd (.boolAnd (.boolNot retryGe) eqZero) (.boolNot fq))
          | none => false
        | none => false
      | none => false
    | none => false
  | _ => false

def certStateTimer (m : Model) (st tmr : Nat) : Bool :=
  let ev := m.timerEvents tmr
  let rs := m.rules.filter (fun r => r.source == st && r.event == ev)
  rs.any (fun r => isTrueLit r.guard) || isBinaryCover rs || isTcpRtxCover rs

theorem certStateTimer_sound (m : Model) (st tmr : Nat) (s : Snapshot)
    (hSt : s.state = st) (ok : certStateTimer m st tmr = true) :
    ∃ r ∈ m.rules, r.source = s.state ∧ r.event = m.timerEvents tmr ∧
      TypedMachine.eval s zeroValues r.guard = true := by
  subst hSt
  let ev := m.timerEvents tmr
  let rs := m.rules.filter (fun r => r.source == s.state && r.event == ev)
  have hMem : ∀ r ∈ rs, r ∈ m.rules ∧ r.source = s.state ∧ r.event = ev := by
    intro r hr
    obtain ⟨hm, hflt⟩ := List.mem_filter.mp hr
    simp only [Bool.and_eq_true, beq_iff_eq] at hflt
    exact ⟨hm, hflt.1, hflt.2⟩
  let ctx := context s zeroValues
  simp only [certStateTimer, Bool.or_eq_true] at ok
  rcases ok with (hTrue | hBin) | hRtx
  · obtain ⟨r, hr, ht⟩ := List.any_eq_true.mp hTrue
    obtain ⟨hm, hs, he⟩ := hMem r hr
    refine ⟨r, hm, hs, he, ?_⟩
    cases hg : r.guard with
    | literal _ b =>
      simp [hg, isTrueLit] at ht
      simp [TypedMachine.eval, TypedIR.eval, ht]
    | _ => simp [hg, isTrueLit] at ht
  · obtain ⟨r1, hr1, h1⟩ := List.any_eq_true.mp hBin
    cases hn : negOf r1.guard with
    | none => simp [hn] at h1
    | some p =>
      simp only [hn] at h1
      obtain ⟨r2, hr2, hSame⟩ := List.any_eq_true.mp h1
      cases hp : evalBool p ctx
      · obtain ⟨hm, hs, he⟩ := hMem r1 hr1
        refine ⟨r1, hm, hs, he, ?_⟩
        change evalBool r1.guard ctx = true
        rw [negOf_sound r1.guard p ctx hn, hp]
        rfl
      · obtain ⟨hm, hs, he⟩ := hMem r2 hr2
        refine ⟨r2, hm, hs, he, ?_⟩
        change TypedIR.eval r2.guard ctx = true
        rw [sameExpr_sound ctx hSame]
        exact hp
  · change isTcpRtxCover rs = true at hRtx
    cases hrs : rs with
    | nil => simp [hrs, isTcpRtxCover] at hRtx
    | cons r0 t0 =>
      cases t0 with
      | nil => simp [hrs, isTcpRtxCover] at hRtx
      | cons r1 t1 =>
        cases t1 with
        | nil => simp [hrs, isTcpRtxCover] at hRtx
        | cons r2 t2 =>
          cases t2 with
          | nil => simp [hrs, isTcpRtxCover] at hRtx
          | cons r3 t3 =>
            cases t3 with
            | nil => simp [hrs, isTcpRtxCover] at hRtx
            | cons r4 t4 =>
              cases t4 with
              | cons _ _ => simp [hrs, isTcpRtxCover] at hRtx
              | nil =>
                rw [hrs] at hRtx
                unfold isTcpRtxCover at hRtx
                cases ha4 : extractAnd r4.guard with
                | none => simp [ha4] at hRtx
                | some pair4 =>
                  rcases pair4 with ⟨negZwp, retryGe⟩
                  cases ha2 : extractAnd r2.guard with
                  | none => simp [ha4, ha2] at hRtx
                  | some pair2 =>
                    rcases pair2 with ⟨mid, fq⟩
                    cases ham : extractAnd mid with
                    | none => simp [ha4, ha2, ham] at hRtx
                    | some pairm =>
                      rcases pairm with ⟨negRetry, eqZero⟩
                      cases hez : extractEqLenZero eqZero with
                      | none => simp [ha4, ha2, ham, hez] at hRtx
                      | some sb =>
                        simp only [ha4, ha2, ham, hez, Bool.and_eq_true] at hRtx
                        rcases hRtx with ⟨hNegZwp, ⟨hNegRetry, hR1⟩, hR3⟩
                        cases hzwp : evalBool r0.guard ctx
                        · cases hret : evalBool retryGe ctx
                          · by_cases hlen0 : (evalOct sb ctx).length = 0
                            · cases hfq : evalBool fq ctx
                              · obtain ⟨hm, hs, he⟩ := hMem r3 (by simp [hrs])
                                refine ⟨r3, hm, hs, he, ?_⟩
                                change TypedIR.eval r3.guard ctx = true
                                rw [sameExpr_sound ctx hR3]
                                have hezEq := extractEqLenZero_sound ctx hez
                                simp [TypedIR.eval, hezEq, hlen0, hret, hfq]
                              · obtain ⟨hm, hs, he⟩ := hMem r2 (by simp [hrs])
                                refine ⟨r2, hm, hs, he, ?_⟩
                                change evalBool r2.guard ctx = true
                                have hnEq : evalBool negRetry ctx = evalBool (.boolNot retryGe) ctx :=
                                  sameExpr_sound ctx hNegRetry
                                rw [extractAnd_sound ctx ha2, extractAnd_sound ctx ham,
                                    hnEq, extractEqLenZero_sound ctx hez]
                                simp [evalBool, TypedIR.eval, hlen0, hret, hfq]
                            · obtain ⟨hm, hs, he⟩ := hMem r1 (by simp [hrs])
                              refine ⟨r1, hm, hs, he, ?_⟩
                              change TypedIR.eval r1.guard ctx = true
                              rw [sameExpr_sound ctx hR1]
                              have hne : TypedIR.eval sb ctx ≠ [] := by
                                intro heq; simp [evalOct, heq] at hlen0
                              simp [TypedIR.eval, hzwp, hret, hne]
                          · obtain ⟨hm, hs, he⟩ := hMem r4 (by simp [hrs])
                            refine ⟨r4, hm, hs, he, ?_⟩
                            change evalBool r4.guard ctx = true
                            have hnEq : evalBool negZwp ctx = evalBool (.boolNot r0.guard) ctx :=
                              sameExpr_sound ctx hNegZwp
                            rw [extractAnd_sound ctx ha4, hnEq]
                            simp [evalBool, TypedIR.eval, hzwp, hret]
                        · obtain ⟨hm, hs, he⟩ := hMem r0 (by simp [hrs])
                          exact ⟨r0, hm, hs, he, hzwp⟩

def certCoversTimers (m : Model) (states ids : List Nat) : Bool :=
  states.all fun st => ids.all fun tmr => certStateTimer m st tmr

theorem covers_all (m : Model) (states ids : List Nat)
    (ok : certCoversTimers m states ids = true) :
    TimedSelection.CoversTimers m states ids := by
  intro s hState _ entry _ hTimer
  have hSt := List.all_eq_true.mp ok s.state hState
  have hTm := List.all_eq_true.mp hSt entry.timer hTimer
  exact certStateTimer_sound m s.state entry.timer s rfl hTm

end StackCert
