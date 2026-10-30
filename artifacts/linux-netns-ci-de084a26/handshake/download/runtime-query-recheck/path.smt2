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
(declare-fun input_1_net.synack_seq () (_ BitVec 32))
(declare-fun input_1_net.synack_ack () (_ BitVec 32))
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
 (let (($x194 (= due_1_syn_rto 1000)))
 (let (($x41 (= v_1_retries 0)))
 (let (($x124 (= v_1_rto_ms 1000)))
 (let (($x125 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x192 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x129 (= v_1_snd_una (_ bv1000 32))))
 (let (($x126 (= v_1_irs (_ bv0 32))))
 (let (($x131 (= v_1_iss (_ bv1000 32))))
 (let (($x98 (= 1 state_1)))
 (let (($x73 (not active_0_syn_rto)))
 (let (($x190 (or $x73 (not (<= due_0_syn_rto 0)))))
 (let (($x39 (= state_0 0)))
 (let (($x130 (not (= state_0 2))))
 (and $x130 $x39 (>= 0 now_0) $x190 $x98 $x131 $x126 $x129 $x192 $x125 $x124 $x41 active_1_syn_rto $x194)))))))))))))))
(assert
 true)
(assert
 (let (($x172 (= due_2_syn_rto due_1_syn_rto)))
 (let (($x209 (not active_2_syn_rto)))
 (let (($x170 (= v_2_retries v_1_retries)))
 (let (($x169 (= v_2_rto_ms v_1_rto_ms)))
 (let (($x212 (= v_2_rcv_nxt (_ bv9001 32))))
 (let (($x167 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x135 (= v_2_snd_una (_ bv1001 32))))
 (let (($x137 (= v_2_irs (_ bv9000 32))))
 (let (($x164 (= v_2_iss v_1_iss)))
 (let (($x163 (= 2 state_2)))
 (let (($x199 (or (not active_1_syn_rto) (not (<= due_1_syn_rto 10)))))
 (let (($x192 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x136 (= state_1 1)))
 (let (($x185 (not (= state_1 2))))
 (and $x185 $x136 $x192 $x199 $x163 $x164 $x137 $x135 $x167 $x212 $x169 $x170 $x209 $x172))))))))))))))))
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
 (= 2 choice_1))
(assert
 (= 10 now_2))
(assert
 (= (_ bv9000 32) input_1_net.synack_seq))
(assert
 (= (_ bv1001 32) input_1_net.synack_ack))
(check-sat)
