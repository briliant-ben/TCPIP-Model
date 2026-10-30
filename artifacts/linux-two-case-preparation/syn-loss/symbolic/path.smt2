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
 (let (($x28 (= due_1_syn_rto 1000)))
 (let (($x148 (= v_1_retries 0)))
 (let (($x17 (= v_1_rto_ms 1000)))
 (let (($x63 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x12 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x68 (= v_1_snd_una (_ bv1000 32))))
 (let (($x66 (= v_1_irs (_ bv0 32))))
 (let (($x64 (= v_1_iss (_ bv1000 32))))
 (let (($x62 (= 1 state_1)))
 (let (($x189 (not active_0_syn_rto)))
 (let (($x16 (or $x189 (not (<= due_0_syn_rto 0)))))
 (let (($x70 (= state_0 0)))
 (let (($x185 (not (= state_0 2))))
 (and $x185 $x70 (>= 0 now_0) $x16 $x62 $x64 $x66 $x68 $x12 $x63 $x17 $x148 active_1_syn_rto $x28)))))))))))))))
(assert
 true)
(assert
 (let (($x227 (= v_2_rcv_nxt v_1_rcv_nxt)))
 (let (($x137 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x226 (= v_2_snd_una v_1_snd_una)))
 (let (($x225 (= v_2_irs v_1_irs)))
 (let (($x34 (= v_2_iss v_1_iss)))
 (let (($x224 (= 1 state_2)))
 (let (($x209 (= state_1 1)))
 (let (($x172 (not (= state_1 2))))
 (and $x172 $x209 active_1_syn_rto (= 1000 due_1_syn_rto) $x224 $x34 $x225 $x226 $x137 $x227 (= v_2_rto_ms (* 2 v_1_rto_ms)) (= v_2_retries (+ 1 v_1_retries)) active_2_syn_rto (= due_2_syn_rto (+ 1000 (* 2 v_1_rto_ms)))))))))))))
(assert
 true)
(assert
 true)
(assert
 (let (($x288 (= due_3_syn_rto due_2_syn_rto)))
 (let (($x303 (not active_3_syn_rto)))
 (let (($x286 (= v_3_retries v_2_retries)))
 (let (($x285 (= v_3_rto_ms v_2_rto_ms)))
 (let (($x302 (= v_3_rcv_nxt (_ bv9001 32))))
 (let (($x283 (= v_3_snd_nxt v_2_snd_nxt)))
 (let (($x311 (= v_3_snd_una (_ bv1001 32))))
 (let (($x241 (= v_3_irs (_ bv9000 32))))
 (let (($x280 (= v_3_iss v_2_iss)))
 (let (($x279 (= 2 state_3)))
 (let (($x197 (not active_2_syn_rto)))
 (let (($x122 (or $x197 (not (<= due_2_syn_rto 1010)))))
 (let (($x242 (= v_2_snd_nxt (_ bv1001 32))))
 (let (($x245 (= state_2 1)))
 (let (($x69 (= state_2 2)))
 (let (($x250 (not $x69)))
 (and $x250 $x245 $x242 $x122 $x279 $x280 $x241 $x311 $x283 $x302 $x285 $x286 $x303 $x288))))))))))))))))))
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
