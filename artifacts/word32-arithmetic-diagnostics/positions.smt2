; benchmark generated from python API
(set-info :status unknown)
(declare-fun arbitrary_word32_integer () Int)
(assert
 (let ((?x73 ((_ int_to_bv 32) arbitrary_word32_integer)))
(let ((?x80 ((_ extract 7 0) ?x73)))
(let ((?x76 ((_ extract 23 16) ?x73)))
(let ((?x77 (seq.unit ?x76)))
(let ((?x74 ((_ extract 31 24) ?x73)))
(let ((?x75 (seq.unit ?x74)))
(let ((?x84 (seq.++ ?x75 (seq.++ ?x77 (seq.++ (seq.unit ((_ extract 15 8) ?x73)) (seq.unit ?x80))))))
(let (($x103 (and (= (seq.len ?x84) 4) (= (seq.nth ?x84 0) ?x74) (= (seq.nth ?x84 1) ?x76) (= (seq.nth ?x84 2) ((_ extract 15 8) ?x73)) (= (seq.nth ?x84 3) ?x80))))
(not $x103))))))))))
(check-sat)
