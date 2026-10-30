; benchmark generated from python API
(set-info :status unknown)
(declare-fun state_0 () Int)
(declare-fun now_0 () Int)
(declare-fun v_0_left () (_ BitVec 32))
(declare-fun v_0_right () (_ BitVec 32))
(declare-fun v_0_offset () Int)
(declare-fun v_0_distance () Int)
(declare-fun v_0_roundtrip () (_ BitVec 32))
(declare-fun v_0_advanced () (_ BitVec 32))
(declare-fun v_0_restored () (_ BitVec 32))
(declare-fun choice_0 () Int)
(declare-fun v_1_restored () (_ BitVec 32))
(declare-fun v_1_advanced () (_ BitVec 32))
(declare-fun v_1_roundtrip () (_ BitVec 32))
(declare-fun v_1_distance () Int)
(declare-fun v_1_offset () Int)
(declare-fun v_1_right () (_ BitVec 32))
(declare-fun v_1_left () (_ BitVec 32))
(declare-fun now_1 () Int)
(declare-fun state_1 () Int)
(declare-fun input_0_probe_offset () Int)
(declare-fun input_0_probe_left () (_ BitVec 32))
(declare-fun input_0_probe_right () (_ BitVec 32))
(assert
 (= state_0 0))
(assert
 (= now_0 0))
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
 (= choice_0 0))
(assert
 (let (($x245 (= v_1_restored v_0_restored)))
 (let (($x221 (= v_1_advanced v_0_advanced)))
 (let (($x222 (= v_1_roundtrip v_0_roundtrip)))
 (let (($x161 (= v_1_distance v_0_distance)))
 (let (($x160 (= v_1_offset v_0_offset)))
 (let (($x210 (= v_1_right v_0_right)))
 (let (($x254 (= v_1_left v_0_left)))
 (let (($x157 (= now_1 now_0)))
 (let (($x156 (= state_1 state_0)))
 (let (($x166 (= choice_0 (- 1))))
 (let (($x231 (and $x166 $x156 $x157 $x254 $x210 $x160 $x161 $x222 $x221 $x245)))
 (let ((?x232 ((_ int_to_bv 32) input_0_probe_offset)))
 (let ((?x235 (bvadd input_0_probe_left ?x232)))
 (let ((?x387 (bvadd ?x235 ((_ int_to_bv 32) (- 0 input_0_probe_offset)))))
 (let (($x380 (= v_1_restored ?x387)))
 (let (($x233 (= v_1_advanced ?x235)))
 (let ((?x376 (bvadd input_0_probe_left ((_ int_to_bv 32) (ubv_to_int (bvsub input_0_probe_left input_0_probe_right))))))
 (let (($x244 (= v_1_roundtrip ?x376)))
 (let ((?x250 (ubv_to_int (bvsub input_0_probe_left input_0_probe_right))))
 (let (($x214 (= v_1_distance ?x250)))
 (let (($x150 (= v_1_offset input_0_probe_offset)))
 (let (($x264 (= v_1_right input_0_probe_right)))
 (let (($x377 (= v_1_left input_0_probe_left)))
 (let (($x147 (= 0 state_1)))
 (let (($x146 (= choice_0 0)))
 (let (($x135 (>= now_1 now_0)))
 (let (($x101 (= state_0 0)))
 (let (($x378 (and and $x101 $x135 true $x146 $x147 $x377 $x264 $x150 $x214 $x244 $x233 $x380)))
 (or $x378 $x231))))))))))))))))))))))))))))))
(assert
 (= (_ bv0 32) input_0_probe_left))
(assert
 (= (_ bv1 32) input_0_probe_right))
(assert
 (= 1 input_0_probe_offset))
(assert
 (not (and (= v_1_roundtrip v_1_right) (= v_1_restored v_1_left))))
(check-sat)
