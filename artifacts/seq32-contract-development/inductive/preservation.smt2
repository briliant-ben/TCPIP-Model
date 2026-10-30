; PROBE -> READY
(reset)
; benchmark generated from python API
(set-info :status unknown)
(declare-fun v_0_left () Int)
(declare-fun v_0_right () Int)
(declare-fun v_0_roundtrip () Int)
(declare-fun v_0_advanced () Int)
(declare-fun v_0_restored () Int)
(declare-fun v_1_left () Int)
(declare-fun v_1_right () Int)
(declare-fun v_1_roundtrip () Int)
(declare-fun v_1_advanced () Int)
(declare-fun v_1_restored () Int)
(declare-fun now_0 () Int)
(declare-fun input_0_probe_left () Int)
(declare-fun input_0_probe_right () Int)
(declare-fun input_0_probe_offset () Int)
(declare-fun v_1_distance () Int)
(declare-fun v_1_offset () Int)
(declare-fun now_1 () Int)
(declare-fun choice_0 () Int)
(declare-fun state_0 () Int)
(declare-fun state_1 () Int)
(assert
 (>= v_0_left 0))
(assert
 (not (<= 4294967296 v_0_left)))
(assert
 (>= v_0_right 0))
(assert
 (not (<= 4294967296 v_0_right)))
(assert
 (>= v_0_roundtrip 0))
(assert
 (not (<= 4294967296 v_0_roundtrip)))
(assert
 (>= v_0_advanced 0))
(assert
 (not (<= 4294967296 v_0_advanced)))
(assert
 (>= v_0_restored 0))
(assert
 (not (<= 4294967296 v_0_restored)))
(assert
 (>= v_1_left 0))
(assert
 (not (<= 4294967296 v_1_left)))
(assert
 (>= v_1_right 0))
(assert
 (not (<= 4294967296 v_1_right)))
(assert
 (>= v_1_roundtrip 0))
(assert
 (not (<= 4294967296 v_1_roundtrip)))
(assert
 (>= v_1_advanced 0))
(assert
 (not (<= 4294967296 v_1_advanced)))
(assert
 (>= v_1_restored 0))
(assert
 (not (<= 4294967296 v_1_restored)))
(assert
 true)
(assert
 true)
(assert
 (>= now_0 0))
(assert
 (>= input_0_probe_left 0))
(assert
 (not (<= 4294967296 input_0_probe_left)))
(assert
 (>= input_0_probe_right 0))
(assert
 (not (<= 4294967296 input_0_probe_right)))
(assert
 (let ((?x141 (+ input_0_probe_left input_0_probe_offset)))
 (let ((?x142 (mod ?x141 4294967296)))
 (let (($x153 (= v_1_advanced ?x142)))
 (let (($x356 (= v_1_distance (mod (+ input_0_probe_right (* (- 1) input_0_probe_left)) 4294967296))))
 (let (($x150 (= v_1_offset input_0_probe_offset)))
 (let (($x149 (= v_1_right input_0_probe_right)))
 (let (($x148 (= v_1_left input_0_probe_left)))
 (let (($x135 (>= now_1 now_0)))
 (and $x135 $x148 $x149 $x150 $x356 (= v_1_roundtrip (mod input_0_probe_right 4294967296)) $x153 (= v_1_restored (mod input_0_probe_left 4294967296))))))))))))
(assert
 (= v_0_roundtrip v_0_right))
(assert
 (= v_0_restored v_0_left))
(assert
 (not (and (= v_1_roundtrip v_1_right) (= v_1_restored v_1_left))))
(assert
 (= 0 choice_0))
(assert
 (= 0 state_0))
(assert
 (= 0 state_1))
(check-sat)
