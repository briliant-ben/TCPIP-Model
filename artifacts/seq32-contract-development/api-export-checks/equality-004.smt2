; benchmark generated from python API
(set-info :status unknown)
(declare-fun input_0_probe_offset () Int)
(assert
 (let (($x211 (= (- 1180591620717411303421) input_0_probe_offset)))
(let ((?x232 (- 1180591620717411303421)))
(let (($x210 (= ?x232 input_0_probe_offset)))
(xor $x210 $x211)))))
(check-sat)
