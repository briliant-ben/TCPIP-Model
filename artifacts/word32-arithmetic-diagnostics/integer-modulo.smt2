; benchmark generated from python API
(set-info :status unknown)
(declare-fun arbitrary_word32_integer () Int)
(assert
 (let ((?x106 (mod arbitrary_word32_integer 4294967296)))
(let ((?x73 ((_ int_to_bv 32) arbitrary_word32_integer)))
(let ((?x104 (ubv_to_int ?x73)))
(let (($x107 (= ?x104 ?x106)))
(not $x107))))))
(check-sat)
