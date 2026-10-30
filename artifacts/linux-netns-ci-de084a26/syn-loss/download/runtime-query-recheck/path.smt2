; benchmark generated from python API
(set-info :status unknown)
(declare-fun state_0 () Int)
(declare-fun now_0 () Int)
(declare-fun active_0_syn_rto () Bool)
(declare-fun due_0_syn_rto () Int)
(declare-fun due_1_syn_rto () Int)
(declare-fun active_1_syn_rto () Bool)
(declare-fun v_1_retries () Int)
(declare-fun v_1_rto_ms () Int)
(declare-fun v_1_rcv_nxt () (_ BitVec 32))
(declare-fun v_1_snd_nxt () (_ BitVec 32))
(declare-fun v_1_snd_una () (_ BitVec 32))
(declare-fun v_1_irs () (_ BitVec 32))
(declare-fun v_1_iss () (_ BitVec 32))
(declare-fun state_1 () Int)
(declare-fun due_2_syn_rto () Int)
(declare-fun active_2_syn_rto () Bool)
(declare-fun v_2_retries () Int)
(declare-fun v_2_rto_ms () Int)
(declare-fun v_2_rcv_nxt () (_ BitVec 32))
(declare-fun v_2_snd_nxt () (_ BitVec 32))
(declare-fun v_2_snd_una () (_ BitVec 32))
(declare-fun v_2_irs () (_ BitVec 32))
(declare-fun v_2_iss () (_ BitVec 32))
(declare-fun state_2 () Int)
(declare-fun due_3_syn_rto () Int)
(declare-fun active_3_syn_rto () Bool)
(declare-fun v_3_retries () Int)
(declare-fun v_3_rto_ms () Int)
(declare-fun v_3_rcv_nxt () (_ BitVec 32))
(declare-fun v_3_snd_nxt () (_ BitVec 32))
(declare-fun v_3_snd_una () (_ BitVec 32))
(declare-fun v_3_irs () (_ BitVec 32))
(declare-fun v_3_iss () (_ BitVec 32))
(declare-fun state_3 () Int)
(declare-fun v_0_iss () (_ BitVec 32))
(declare-fun v_0_irs () (_ BitVec 32))
(declare-fun v_0_snd_una () (_ BitVec 32))
(declare-fun v_0_snd_nxt () (_ BitVec 32))
(declare-fun v_0_rcv_nxt () (_ BitVec 32))
(declare-fun v_0_rto_ms () Int)
(declare-fun v_0_retries () Int)
(declare-fun choice_0 () Int)
(declare-fun now_1 () Int)
(declare-fun choice_1 () Int)
(declare-fun now_2 () Int)
(declare-fun choice_2 () Int)
(declare-fun now_3 () Int)
(declare-fun input_2_net.synack_seq () (_ BitVec 32))
(declare-fun input_2_net.synack_ack () (_ BitVec 32))
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
 (not active_0_syn_rto))
(assert
 (= due_0_syn_rto 0))
(assert
 true)
(assert
 (let (($x215 (= due_1_syn_rto 1000)))
 (let (($x52 (= v_1_retries 0)))
 (let (($x146 (= v_1_rto_ms 1000)))
 (let (($x271 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x214 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x269 (= v_1_snd_una (_ bv1000 32))))
 (let (($x262 (= v_1_irs (_ bv0 32))))
 (let (($x266 (= v_1_iss (_ bv1000 32))))
 (let (($x109 (= 1 state_1)))
 (let (($x84 (not active_0_syn_rto)))
 (let (($x217 (or $x84 (not (<= due_0_syn_rto 0)))))
 (let (($x50 (= state_0 0)))
 (let (($x212 (not (= state_0 2))))
 (and $x212 $x50 (>= 0 now_0) $x217 $x109 $x266 $x262 $x269 $x214 $x271 $x146 $x52 active_1_syn_rto $x215)))))))))))))))
(assert
 true)
(assert
 (let (($x182 (= v_2_rcv_nxt v_1_rcv_nxt)))
 (let (($x181 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x180 (= v_2_snd_una v_1_snd_una)))
 (let (($x179 (= v_2_irs v_1_irs)))
 (let (($x178 (= v_2_iss v_1_iss)))
 (let (($x177 (= 1 state_2)))
 (let (($x147 (= state_1 1)))
 (let (($x270 (not (= state_1 2))))
 (and $x270 $x147 active_1_syn_rto (= 1000 due_1_syn_rto) $x177 $x178 $x179 $x180 $x181 $x182 (= v_2_rto_ms (* 2 v_1_rto_ms)) (= v_2_retries (+ 1 v_1_retries)) active_2_syn_rto (= due_2_syn_rto (+ 1000 (* 2 v_1_rto_ms)))))))))))))
(assert
 true)
(assert
 true)
(assert
 (let (($x248 (= due_3_syn_rto due_2_syn_rto)))
 (let (($x153 (not active_3_syn_rto)))
 (let (($x246 (= v_3_retries v_2_retries)))
 (let (($x245 (= v_3_rto_ms v_2_rto_ms)))
 (let (($x149 (= v_3_rcv_nxt (_ bv9001 32))))
 (let (($x243 (= v_3_snd_nxt v_2_snd_nxt)))
 (let (($x268 (= v_3_snd_una (_ bv1001 32))))
 (let (($x201 (= v_3_irs (_ bv9000 32))))
 (let (($x240 (= v_3_iss v_2_iss)))
 (let (($x239 (= 2 state_3)))
 (let (($x273 (or (not active_2_syn_rto) (not (<= due_2_syn_rto 1010)))))
 (let (($x142 (= v_2_snd_nxt (_ bv1001 32))))
 (let (($x205 (= state_2 1)))
 (let (($x148 (not (= state_2 2))))
 (and $x148 $x205 $x142 $x273 $x239 $x240 $x201 $x268 $x243 $x149 $x245 $x246 $x153 $x248))))))))))))))))
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
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 (= (_ bv1000 32) v_0_iss))
(assert
 (= (_ bv0 32) v_0_irs))
(assert
 (= (_ bv1000 32) v_0_snd_una))
(assert
 (= (_ bv1000 32) v_0_snd_nxt))
(assert
 (= (_ bv0 32) v_0_rcv_nxt))
(assert
 (= 1000 v_0_rto_ms))
(assert
 (= 0 v_0_retries))
(assert
 (= 0 choice_0))
(assert
 (= 0 now_1))
(assert
 (= 1 choice_1))
(assert
 (= 1000 now_2))
(assert
 (= 2 choice_2))
(assert
 (= 1010 now_3))
(assert
 (= (_ bv9000 32) input_2_net.synack_seq))
(assert
 (= (_ bv1001 32) input_2_net.synack_ack))
(check-sat)
