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
(declare-fun state_0 () Int)
(declare-fun now_0 () Int)
(declare-fun v_0_offset () Int)
(declare-fun v_0_distance () Int)
(declare-fun input_0_probe_left () Int)
(declare-fun input_0_probe_right () Int)
(declare-fun v_1_distance () Int)
(declare-fun v_1_offset () Int)
(declare-fun now_1 () Int)
(declare-fun state_1 () Int)
(declare-fun choice_0 () Int)
(declare-fun input_0_probe_offset () Int)
(assert
 (>= v_0_left 0))
(assert
 (< v_0_left 4294967296))
(assert
 (>= v_0_right 0))
(assert
 (< v_0_right 4294967296))
(assert
 (>= v_0_roundtrip 0))
(assert
 (< v_0_roundtrip 4294967296))
(assert
 (>= v_0_advanced 0))
(assert
 (< v_0_advanced 4294967296))
(assert
 (>= v_0_restored 0))
(assert
 (< v_0_restored 4294967296))
(assert
 (>= v_1_left 0))
(assert
 (< v_1_left 4294967296))
(assert
 (>= v_1_right 0))
(assert
 (< v_1_right 4294967296))
(assert
 (>= v_1_roundtrip 0))
(assert
 (< v_1_roundtrip 4294967296))
(assert
 (>= v_1_advanced 0))
(assert
 (< v_1_advanced 4294967296))
(assert
 (>= v_1_restored 0))
(assert
 (< v_1_restored 4294967296))
(assert
 (= state_0 0))
(assert
 (= now_0 0))
(assert
 (= 0 v_0_left))
(assert
 (= 0 v_0_right))
(assert
 (= 0 v_0_offset))
(assert
 (= 0 v_0_distance))
(assert
 (= 0 v_0_roundtrip))
(assert
 (= 0 v_0_advanced))
(assert
 (= 0 v_0_restored))
(assert
 (>= input_0_probe_left 0))
(assert
 (< input_0_probe_left 4294967296))
(assert
 (>= input_0_probe_right 0))
(assert
 (< input_0_probe_right 4294967296))
(assert
 (let (($x56 (= v_1_restored v_0_restored)))
 (let (($x57 (= v_1_advanced v_0_advanced)))
 (let (($x58 (= v_1_roundtrip v_0_roundtrip)))
 (let (($x60 (= v_1_distance v_0_distance)))
 (let (($x62 (= v_1_offset v_0_offset)))
 (let (($x63 (= v_1_right v_0_right)))
 (let (($x64 (= v_1_left v_0_left)))
 (let (($x66 (= now_1 now_0)))
 (let (($x68 (= state_1 state_0)))
 (let ((?x71 (- 1)))
 (let (($x72 (= choice_0 ?x71)))
 (let (($x73 (and $x72 $x68 $x66 $x64 $x63 $x62 $x60 $x58 $x57 $x56)))
 (let ((?x104 (mod input_0_probe_left 4294967296)))
 (let (($x141 (= v_1_restored ?x104)))
 (let ((?x75 (+ input_0_probe_left input_0_probe_offset)))
 (let ((?x76 (mod ?x75 4294967296)))
 (let (($x81 (= v_1_advanced ?x76)))
 (let ((?x115 (mod input_0_probe_right 4294967296)))
 (let (($x107 (= v_1_roundtrip ?x115)))
 (let ((?x111 (mod (+ input_0_probe_right (* (- 1) input_0_probe_left)) 4294967296)))
 (let (($x114 (= v_1_distance ?x111)))
 (let (($x88 (= v_1_offset input_0_probe_offset)))
 (let (($x89 (= v_1_right input_0_probe_right)))
 (let (($x90 (= v_1_left input_0_probe_left)))
 (let (($x91 (= 0 state_1)))
 (let (($x92 (= choice_0 0)))
 (let (($x93 (>= now_1 now_0)))
 (let (($x38 (= state_0 0)))
 (let (($x120 (and and $x38 $x93 true $x92 $x91 $x90 $x89 $x88 $x114 $x107 $x81 $x141)))
 (or $x120 $x73)))))))))))))))))))))))))))))))
(assert
 (= choice_0 0))
(assert
 (let (($x98 (= v_1_restored v_1_left)))
(let (($x97 (= v_1_roundtrip v_1_right)))
(let (($x99 (and $x97 $x98)))
(not $x99)))))
(check-sat)
