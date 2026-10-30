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
 (let (($x179 (= v_1_restored v_0_restored)))
 (let (($x180 (= v_1_advanced v_0_advanced)))
 (let (($x181 (= v_1_roundtrip v_0_roundtrip)))
 (let (($x182 (= v_1_distance v_0_distance)))
 (let (($x183 (= v_1_offset v_0_offset)))
 (let (($x184 (= v_1_right v_0_right)))
 (let (($x185 (= v_1_left v_0_left)))
 (let (($x186 (= now_1 now_0)))
 (let (($x187 (= state_1 state_0)))
 (let (($x176 (and (= choice_0 (- 1)) $x187 $x186 $x185 $x184 $x183 $x182 $x181 $x180 $x179)))
 (let ((?x201 (mod (+ input_0_probe_left input_0_probe_offset) 4294967296)))
 (let ((?x198 (mod (+ ?x201 (- 0 input_0_probe_offset)) 4294967296)))
 (let (($x189 (= v_1_restored ?x198)))
 (let (($x190 (= v_1_advanced ?x201)))
 (let ((?x205 (mod (- input_0_probe_right input_0_probe_left) 4294967296)))
 (let ((?x203 (mod (+ input_0_probe_left ?x205) 4294967296)))
 (let (($x191 (= v_1_roundtrip ?x203)))
 (let (($x192 (= v_1_distance ?x205)))
 (let (($x193 (= v_1_offset input_0_probe_offset)))
 (let (($x194 (= v_1_right input_0_probe_right)))
 (let (($x195 (= v_1_left input_0_probe_left)))
 (let (($x196 (= 0 state_1)))
 (let (($x197 (= choice_0 0)))
 (let (($x208 (>= now_1 now_0)))
 (let (($x236 (= state_0 0)))
 (let (($x188 (and and $x236 $x208 true $x197 $x196 $x195 $x194 $x193 $x192 $x191 $x190 $x189)))
 (or $x188 $x176))))))))))))))))))))))))))))
(assert
 (= choice_0 0))
(assert
 (not (and (= v_1_roundtrip v_1_right) (= v_1_restored v_1_left))))
(check-sat)
