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
 (let (($x164 (= v_1_restored v_0_restored)))
 (let (($x163 (= v_1_advanced v_0_advanced)))
 (let (($x162 (= v_1_roundtrip v_0_roundtrip)))
 (let (($x161 (= v_1_distance v_0_distance)))
 (let (($x160 (= v_1_offset v_0_offset)))
 (let (($x159 (= v_1_right v_0_right)))
 (let (($x158 (= v_1_left v_0_left)))
 (let (($x157 (= now_1 now_0)))
 (let (($x156 (= state_1 state_0)))
 (let (($x167 (and (= choice_0 (- 1)) $x156 $x157 $x158 $x159 $x160 $x161 $x162 $x163 $x164)))
 (let ((?x141 (+ input_0_probe_left input_0_probe_offset)))
 (let ((?x142 (mod ?x141 4294967296)))
 (let ((?x145 (mod (+ ?x142 (- 0 input_0_probe_offset)) 4294967296)))
 (let (($x154 (= v_1_restored ?x145)))
 (let (($x153 (= v_1_advanced ?x142)))
 (let ((?x138 (mod (- input_0_probe_right input_0_probe_left) 4294967296)))
 (let ((?x140 (mod (+ input_0_probe_left ?x138) 4294967296)))
 (let (($x152 (= v_1_roundtrip ?x140)))
 (let (($x151 (= v_1_distance ?x138)))
 (let (($x150 (= v_1_offset input_0_probe_offset)))
 (let (($x149 (= v_1_right input_0_probe_right)))
 (let (($x148 (= v_1_left input_0_probe_left)))
 (let (($x147 (= 0 state_1)))
 (let (($x146 (= choice_0 0)))
 (let (($x135 (>= now_1 now_0)))
 (let (($x101 (= state_0 0)))
 (let (($x155 (and and $x101 $x135 true $x146 $x147 $x148 $x149 $x150 $x151 $x152 $x153 $x154)))
 (or $x155 $x167)))))))))))))))))))))))))))))
(assert
 (= choice_0 0))
(assert
 (not (and (= v_1_roundtrip v_1_right) (= v_1_restored v_1_left))))
(check-sat)
