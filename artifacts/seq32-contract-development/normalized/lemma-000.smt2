; benchmark generated from python API
(set-info :status unknown)
(declare-fun atom_1 () Int)
(declare-fun atom_0 () Int)
(assert
 (let ((?x107 (+ atom_0 (* (- 1) atom_1))))
(let ((?x108 (mod ?x107 4294967296)))
(let ((?x104 (mod (- atom_0 atom_1) 4294967296)))
(not (= ?x104 ?x108))))))
(check-sat)
