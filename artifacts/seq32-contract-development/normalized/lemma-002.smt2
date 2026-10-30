; benchmark generated from python API
(set-info :status unknown)
(declare-fun atom_0 () Int)
(declare-fun atom_1 () Int)
(assert
 (let ((?x103 (mod atom_0 4294967296)))
(let ((?x121 (mod (+ (mod (+ atom_0 atom_1) 4294967296) (- 0 atom_1)) 4294967296)))
(not (= ?x121 ?x103)))))
(check-sat)
