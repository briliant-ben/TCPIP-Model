; benchmark generated from python API
(set-info :status unknown)
(declare-fun input_0_probe_offset () Int)
(assert
 (let (($x296 (= (- 4294967305) input_0_probe_offset)))
(let ((?x272 (- 4294967305)))
(let (($x214 (= ?x272 input_0_probe_offset)))
(xor $x214 $x296)))))
(check-sat)
