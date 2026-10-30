; benchmark generated from python API
(set-info :status unknown)
(declare-fun input_0_probe_offset () Int)
(assert
 (let (($x222 (= (- 1) input_0_probe_offset)))
(let ((?x298 (- 1)))
(let (($x286 (= ?x298 input_0_probe_offset)))
(xor $x286 $x222)))))
(check-sat)
