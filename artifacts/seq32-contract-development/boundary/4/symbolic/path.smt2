; benchmark generated from python API
(set-info :status unknown)
(declare-fun state_0 () Int)
(declare-fun now_0 () Int)
(declare-fun v_1_restored () (_ BitVec 32))
(declare-fun v_1_advanced () (_ BitVec 32))
(declare-fun v_1_roundtrip () (_ BitVec 32))
(declare-fun v_1_distance () Int)
(declare-fun v_1_offset () Int)
(declare-fun v_1_right () (_ BitVec 32))
(declare-fun v_1_left () (_ BitVec 32))
(declare-fun state_1 () Int)
(declare-fun v_0_left () (_ BitVec 32))
(declare-fun v_0_right () (_ BitVec 32))
(declare-fun v_0_offset () Int)
(declare-fun v_0_distance () Int)
(declare-fun v_0_roundtrip () (_ BitVec 32))
(declare-fun v_0_advanced () (_ BitVec 32))
(declare-fun v_0_restored () (_ BitVec 32))
(declare-fun choice_0 () Int)
(declare-fun now_1 () Int)
(declare-fun input_0_probe_left () (_ BitVec 32))
(declare-fun input_0_probe_right () (_ BitVec 32))
(declare-fun input_0_probe_offset () Int)
(assert
 (= state_0 0))
(assert
 (= now_0 0))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 (let (($x213 (= v_1_restored (_ bv0 32))))
 (let (($x235 (= v_1_advanced (_ bv7 32))))
 (let (($x399 (= v_1_roundtrip (_ bv2147483648 32))))
 (let (($x277 (= v_1_distance 2147483648)))
 (let (($x220 (= v_1_offset 1180591620717411303431)))
 (let (($x270 (= v_1_right (_ bv2147483648 32))))
 (let (($x216 (= v_1_left (_ bv0 32))))
 (let (($x147 (= 0 state_1)))
 (let (($x101 (= state_0 0)))
 (and $x101 (>= 0 now_0) $x147 $x216 $x270 $x220 $x277 $x399 $x235 $x213)))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 (= (_ bv0 32) v_0_left))
(assert
 (= (_ bv0 32) v_0_right))
(assert
 (= 0 v_0_offset))
(assert
 (= 0 v_0_distance))
(assert
 (= (_ bv0 32) v_0_roundtrip))
(assert
 (= (_ bv0 32) v_0_advanced))
(assert
 (= (_ bv0 32) v_0_restored))
(assert
 (= 0 choice_0))
(assert
 (= 0 now_1))
(assert
 (= (_ bv0 32) input_0_probe_left))
(assert
 (= (_ bv2147483648 32) input_0_probe_right))
(assert
 (= 1180591620717411303431 input_0_probe_offset))
(check-sat)
