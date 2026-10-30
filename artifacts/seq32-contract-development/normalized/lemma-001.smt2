; benchmark generated from python API
(set-info :status unknown)
(declare-fun atom_1 () Int)
(declare-fun atom_0 () Int)
(assert
 (let ((?x130 (mod atom_1 4294967296)))
(let ((?x121 (mod (+ atom_0 (mod (+ atom_1 (* (- 1) atom_0)) 4294967296)) 4294967296)))
(not (= ?x121 ?x130)))))
(check-sat)
