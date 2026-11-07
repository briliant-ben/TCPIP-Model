; benchmark generated from python API
(set-info :status unknown)
(declare-fun independent_octet_3 () (_ BitVec 8))
(declare-fun independent_octet_2 () (_ BitVec 8))
(declare-fun independent_octet_1 () (_ BitVec 8))
(declare-fun independent_octet_0 () (_ BitVec 8))
(assert
 (let ((?x119 (+ (+ 0 (* (ubv_to_int independent_octet_0) 16777216)) (* (ubv_to_int independent_octet_1) 65536))))
(let ((?x126 (+ (+ ?x119 (* (ubv_to_int independent_octet_2) 256)) (* (ubv_to_int independent_octet_3) 1))))
(let ((?x109 (concat (concat independent_octet_0 independent_octet_1) independent_octet_2)))
(let (($x127 (= (ubv_to_int (concat ?x109 independent_octet_3)) ?x126)))
(not $x127))))))
(check-sat)
