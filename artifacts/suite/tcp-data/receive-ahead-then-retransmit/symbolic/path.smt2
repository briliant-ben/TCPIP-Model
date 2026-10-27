; benchmark generated from python API
(set-info :status unknown)
(declare-fun state_0 () Int)
(declare-fun now_0 () Int)
(declare-fun active_0_rtx () Bool)
(declare-fun due_0_rtx () Int)
(declare-fun active_0_user () Bool)
(declare-fun due_0_user () Int)
(declare-fun active_0_time_wait () Bool)
(declare-fun due_0_time_wait () Int)
(declare-fun due_1_time_wait () Int)
(declare-fun due_1_user () Int)
(declare-fun due_1_rtx () Int)
(declare-fun active_1_time_wait () Bool)
(declare-fun active_1_user () Bool)
(declare-fun active_1_rtx () Bool)
(declare-fun v_1_rx_chunk () (Seq (_ BitVec 8)))
(declare-fun v_1_take () Int)
(declare-fun v_1_snd_wl2 () (_ BitVec 32))
(declare-fun v_1_snd_wl1 () (_ BitVec 32))
(declare-fun v_1_snd_wnd () Int)
(declare-fun v_1_rcv_buf () (Seq (_ BitVec 8)))
(declare-fun v_1_rtx_buf () (Seq (_ BitVec 8)))
(declare-fun v_1_snd_buf () (Seq (_ BitVec 8)))
(declare-fun v_1_local_window () Int)
(declare-fun v_1_msl_ms () Int)
(declare-fun v_1_user_timeout_ms () Int)
(declare-fun v_1_active_open () Bool)
(declare-fun v_1_retries () Int)
(declare-fun v_1_rto_ms () Int)
(declare-fun v_1_tx_flags () String)
(declare-fun v_1_tx_ack () (_ BitVec 32))
(declare-fun v_1_tx_seq () (_ BitVec 32))
(declare-fun v_1_rcv_nxt () (_ BitVec 32))
(declare-fun v_1_snd_nxt () (_ BitVec 32))
(declare-fun v_1_snd_una () (_ BitVec 32))
(declare-fun v_1_irs () (_ BitVec 32))
(declare-fun v_1_iss () (_ BitVec 32))
(declare-fun state_1 () Int)
(declare-fun due_2_time_wait () Int)
(declare-fun due_2_user () Int)
(declare-fun due_2_rtx () Int)
(declare-fun active_2_time_wait () Bool)
(declare-fun active_2_user () Bool)
(declare-fun active_2_rtx () Bool)
(declare-fun v_2_rx_chunk () (Seq (_ BitVec 8)))
(declare-fun v_2_take () Int)
(declare-fun v_2_snd_wl2 () (_ BitVec 32))
(declare-fun v_2_snd_wl1 () (_ BitVec 32))
(declare-fun v_2_snd_wnd () Int)
(declare-fun v_2_rcv_buf () (Seq (_ BitVec 8)))
(declare-fun v_2_rtx_buf () (Seq (_ BitVec 8)))
(declare-fun v_2_snd_buf () (Seq (_ BitVec 8)))
(declare-fun v_2_local_window () Int)
(declare-fun v_2_msl_ms () Int)
(declare-fun v_2_user_timeout_ms () Int)
(declare-fun v_2_active_open () Bool)
(declare-fun v_2_retries () Int)
(declare-fun v_2_rto_ms () Int)
(declare-fun v_2_tx_flags () String)
(declare-fun v_2_tx_ack () (_ BitVec 32))
(declare-fun v_2_tx_seq () (_ BitVec 32))
(declare-fun v_2_rcv_nxt () (_ BitVec 32))
(declare-fun v_2_snd_nxt () (_ BitVec 32))
(declare-fun v_2_snd_una () (_ BitVec 32))
(declare-fun v_2_irs () (_ BitVec 32))
(declare-fun v_2_iss () (_ BitVec 32))
(declare-fun state_2 () Int)
(declare-fun due_3_time_wait () Int)
(declare-fun due_3_user () Int)
(declare-fun due_3_rtx () Int)
(declare-fun active_3_time_wait () Bool)
(declare-fun active_3_user () Bool)
(declare-fun active_3_rtx () Bool)
(declare-fun v_3_rx_chunk () (Seq (_ BitVec 8)))
(declare-fun v_3_take () Int)
(declare-fun v_3_snd_wl2 () (_ BitVec 32))
(declare-fun v_3_snd_wl1 () (_ BitVec 32))
(declare-fun v_3_snd_wnd () Int)
(declare-fun v_3_rcv_buf () (Seq (_ BitVec 8)))
(declare-fun v_3_rtx_buf () (Seq (_ BitVec 8)))
(declare-fun v_3_snd_buf () (Seq (_ BitVec 8)))
(declare-fun v_3_local_window () Int)
(declare-fun v_3_msl_ms () Int)
(declare-fun v_3_user_timeout_ms () Int)
(declare-fun v_3_active_open () Bool)
(declare-fun v_3_retries () Int)
(declare-fun v_3_rto_ms () Int)
(declare-fun v_3_tx_flags () String)
(declare-fun v_3_tx_ack () (_ BitVec 32))
(declare-fun v_3_tx_seq () (_ BitVec 32))
(declare-fun v_3_rcv_nxt () (_ BitVec 32))
(declare-fun v_3_snd_nxt () (_ BitVec 32))
(declare-fun v_3_snd_una () (_ BitVec 32))
(declare-fun v_3_irs () (_ BitVec 32))
(declare-fun v_3_iss () (_ BitVec 32))
(declare-fun state_3 () Int)
(declare-fun due_4_time_wait () Int)
(declare-fun due_4_user () Int)
(declare-fun due_4_rtx () Int)
(declare-fun active_4_time_wait () Bool)
(declare-fun active_4_user () Bool)
(declare-fun active_4_rtx () Bool)
(declare-fun v_4_rx_chunk () (Seq (_ BitVec 8)))
(declare-fun v_4_take () Int)
(declare-fun v_4_snd_wl2 () (_ BitVec 32))
(declare-fun v_4_snd_wl1 () (_ BitVec 32))
(declare-fun v_4_snd_wnd () Int)
(declare-fun v_4_rcv_buf () (Seq (_ BitVec 8)))
(declare-fun v_4_rtx_buf () (Seq (_ BitVec 8)))
(declare-fun v_4_snd_buf () (Seq (_ BitVec 8)))
(declare-fun v_4_local_window () Int)
(declare-fun v_4_msl_ms () Int)
(declare-fun v_4_user_timeout_ms () Int)
(declare-fun v_4_active_open () Bool)
(declare-fun v_4_retries () Int)
(declare-fun v_4_rto_ms () Int)
(declare-fun v_4_tx_flags () String)
(declare-fun v_4_tx_ack () (_ BitVec 32))
(declare-fun v_4_tx_seq () (_ BitVec 32))
(declare-fun v_4_rcv_nxt () (_ BitVec 32))
(declare-fun v_4_snd_nxt () (_ BitVec 32))
(declare-fun v_4_snd_una () (_ BitVec 32))
(declare-fun v_4_irs () (_ BitVec 32))
(declare-fun v_4_iss () (_ BitVec 32))
(declare-fun state_4 () Int)
(declare-fun due_5_time_wait () Int)
(declare-fun due_5_user () Int)
(declare-fun due_5_rtx () Int)
(declare-fun active_5_time_wait () Bool)
(declare-fun active_5_user () Bool)
(declare-fun active_5_rtx () Bool)
(declare-fun v_5_rx_chunk () (Seq (_ BitVec 8)))
(declare-fun v_5_take () Int)
(declare-fun v_5_snd_wl2 () (_ BitVec 32))
(declare-fun v_5_snd_wl1 () (_ BitVec 32))
(declare-fun v_5_snd_wnd () Int)
(declare-fun v_5_rcv_buf () (Seq (_ BitVec 8)))
(declare-fun v_5_rtx_buf () (Seq (_ BitVec 8)))
(declare-fun v_5_snd_buf () (Seq (_ BitVec 8)))
(declare-fun v_5_local_window () Int)
(declare-fun v_5_msl_ms () Int)
(declare-fun v_5_user_timeout_ms () Int)
(declare-fun v_5_active_open () Bool)
(declare-fun v_5_retries () Int)
(declare-fun v_5_rto_ms () Int)
(declare-fun v_5_tx_flags () String)
(declare-fun v_5_tx_ack () (_ BitVec 32))
(declare-fun v_5_tx_seq () (_ BitVec 32))
(declare-fun v_5_rcv_nxt () (_ BitVec 32))
(declare-fun v_5_snd_nxt () (_ BitVec 32))
(declare-fun v_5_snd_una () (_ BitVec 32))
(declare-fun v_5_irs () (_ BitVec 32))
(declare-fun v_5_iss () (_ BitVec 32))
(declare-fun state_5 () Int)
(declare-fun v_0_iss () (_ BitVec 32))
(declare-fun v_0_irs () (_ BitVec 32))
(declare-fun v_0_snd_una () (_ BitVec 32))
(declare-fun v_0_snd_nxt () (_ BitVec 32))
(declare-fun v_0_rcv_nxt () (_ BitVec 32))
(declare-fun v_0_tx_seq () (_ BitVec 32))
(declare-fun v_0_tx_ack () (_ BitVec 32))
(declare-fun v_0_tx_flags () String)
(declare-fun v_0_rto_ms () Int)
(declare-fun v_0_retries () Int)
(declare-fun v_0_active_open () Bool)
(declare-fun v_0_user_timeout_ms () Int)
(declare-fun v_0_msl_ms () Int)
(declare-fun v_0_local_window () Int)
(declare-fun v_0_snd_buf () (Seq (_ BitVec 8)))
(declare-fun v_0_rtx_buf () (Seq (_ BitVec 8)))
(declare-fun v_0_rcv_buf () (Seq (_ BitVec 8)))
(declare-fun v_0_snd_wnd () Int)
(declare-fun v_0_snd_wl1 () (_ BitVec 32))
(declare-fun v_0_snd_wl2 () (_ BitVec 32))
(declare-fun v_0_take () Int)
(declare-fun v_0_rx_chunk () (Seq (_ BitVec 8)))
(declare-fun choice_0 () Int)
(declare-fun now_1 () Int)
(declare-fun choice_1 () Int)
(declare-fun now_2 () Int)
(declare-fun input_1_net.synack_seq () (_ BitVec 32))
(declare-fun input_1_net.synack_ack () (_ BitVec 32))
(declare-fun input_1_net.synack_window () Int)
(declare-fun choice_2 () Int)
(declare-fun now_3 () Int)
(declare-fun input_2_net.data_seq () (_ BitVec 32))
(declare-fun input_2_net.data_ack () (_ BitVec 32))
(declare-fun input_2_net.data_window () Int)
(declare-fun input_2_net.data_data () (Seq (_ BitVec 8)))
(declare-fun choice_3 () Int)
(declare-fun now_4 () Int)
(declare-fun input_3_net.data_seq () (_ BitVec 32))
(declare-fun input_3_net.data_ack () (_ BitVec 32))
(declare-fun input_3_net.data_window () Int)
(declare-fun input_3_net.data_data () (Seq (_ BitVec 8)))
(declare-fun choice_4 () Int)
(declare-fun now_5 () Int)
(declare-fun input_4_net.data_seq () (_ BitVec 32))
(declare-fun input_4_net.data_ack () (_ BitVec 32))
(declare-fun input_4_net.data_window () Int)
(declare-fun input_4_net.data_data () (Seq (_ BitVec 8)))
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
 (not active_0_rtx))
(assert
 (= due_0_rtx 0))
(assert
 (not active_0_user))
(assert
 (= due_0_user 0))
(assert
 (not active_0_time_wait))
(assert
 (= due_0_time_wait 0))
(assert
 true)
(assert
 (let (($x8643 (= due_1_time_wait due_0_time_wait)))
 (let (($x9117 (= due_1_user 30000)))
 (let (($x12725 (= due_1_rtx 1000)))
 (let (($x10536 (not active_1_time_wait)))
 (let (($x6490 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x6529 (= v_1_take 0)))
 (let (($x4750 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x4748 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x4749 (= v_1_snd_wnd 8)))
 (let (($x6489 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x2610 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x9800 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x7053 (= v_1_local_window 16)))
 (let (($x7709 (= v_1_msl_ms 60000)))
 (let (($x7719 (= v_1_user_timeout_ms 30000)))
 (let (($x9111 (= 0 v_1_retries)))
 (let (($x8716 (= 1000 v_1_rto_ms)))
 (let (($x2900 (= v_1_tx_flags "S")))
 (let (($x7349 (= v_1_tx_ack (_ bv0 32))))
 (let (($x6493 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x5966 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x11726 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x5283 (= v_1_snd_una (_ bv1000 32))))
 (let (($x12735 (= v_1_irs (_ bv0 32))))
 (let (($x6449 (= v_1_iss (_ bv1000 32))))
 (let (($x11191 (= 2 state_1)))
 (let (($x11176 (not active_0_time_wait)))
 (let (($x5152 (or $x11176 (not (<= due_0_time_wait 0)))))
 (let (($x10417 (not active_0_user)))
 (let (($x10507 (or $x10417 (not (<= due_0_user 0)))))
 (let (($x10081 (not active_0_rtx)))
 (let (($x10692 (or $x10081 (not (<= due_0_rtx 0)))))
 (let (($x11366 (= state_0 0)))
 (and $x11366 (>= 0 now_0) $x10692 $x10507 $x5152 $x11191 $x6449 $x12735 $x5283 $x11726 $x5966 $x6493 $x7349 $x2900 $x8716 $x9111 v_1_active_open $x7719 $x7709 $x7053 $x9800 $x2610 $x6489 $x4749 $x4748 $x4750 $x6529 $x6490 active_1_rtx active_1_user $x10536 $x12725 $x9117 $x8643)))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x11050 (= due_2_time_wait due_1_time_wait)))
 (let (($x8565 (= due_2_user due_1_user)))
 (let (($x11911 (= due_2_rtx due_1_rtx)))
 (let (($x11049 (= active_2_time_wait active_1_time_wait)))
 (let (($x7936 (not active_2_user)))
 (let (($x7972 (not active_2_rtx)))
 (let (($x2049 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x5250 (= v_2_take v_1_take)))
 (let (($x3733 (= v_2_snd_wl2 (_ bv1001 32))))
 (let (($x10526 (= v_2_snd_wl1 (_ bv9000 32))))
 (let (($x11066 (= v_2_snd_wnd 8)))
 (let (($x1961 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x3068 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x2045 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x1941 (= v_2_local_window v_1_local_window)))
 (let (($x6373 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x4136 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x5308 (= v_2_active_open v_1_active_open)))
 (let (($x557 (= v_2_retries v_1_retries)))
 (let (($x5364 (= v_2_rto_ms v_1_rto_ms)))
 (let (($x4079 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x2073 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x11989 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x7973 (= v_2_rcv_nxt (_ bv9001 32))))
 (let (($x3936 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x11868 (= v_2_snd_una (_ bv1001 32))))
 (let (($x11098 (= v_2_irs (_ bv9000 32))))
 (let (($x11046 (= v_2_iss v_1_iss)))
 (let (($x2507 (= 4 state_2)))
 (let (($x10536 (not active_1_time_wait)))
 (let (($x2605 (or $x10536 (not (<= due_1_time_wait 10)))))
 (let (($x4731 (or (not active_1_user) (not (<= due_1_user 10)))))
 (let (($x10534 (or (not active_1_rtx) (not (<= due_1_rtx 10)))))
 (let (($x9111 (= 0 v_1_retries)))
 (let (($x11726 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x4474 (= state_1 2)))
 (and $x4474 $x11726 $x9111 $x10534 $x4731 $x2605 $x2507 $x11046 $x11098 $x11868 $x3936 $x7973 $x11989 $x2073 $x4079 $x5364 $x557 $x5308 $x4136 $x6373 $x1941 $x2045 $x3068 $x1961 $x11066 $x10526 $x3733 $x5250 $x2049 $x7972 $x7936 $x11049 $x11911 $x8565 $x11050))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 (let (($x170 (= due_3_time_wait due_2_time_wait)))
 (let (($x153 (= due_3_user due_2_user)))
 (let (($x128 (= due_3_rtx due_2_rtx)))
 (let (($x3045 (= active_3_time_wait active_2_time_wait)))
 (let (($x7926 (= active_3_user active_2_user)))
 (let (($x4576 (= active_3_rtx active_2_rtx)))
 (let (($x4589 (= v_3_rx_chunk v_2_rx_chunk)))
 (let (($x4165 (= v_3_take v_2_take)))
 (let (($x4064 (= v_3_snd_wl2 v_2_snd_wl2)))
 (let (($x3059 (= v_3_snd_wl1 v_2_snd_wl1)))
 (let (($x7925 (= v_3_snd_wnd v_2_snd_wnd)))
 (let (($x4588 (= v_3_rcv_buf v_2_rcv_buf)))
 (let (($x4048 (= v_3_rtx_buf v_2_rtx_buf)))
 (let (($x4047 (= v_3_snd_buf v_2_snd_buf)))
 (let (($x4043 (= v_3_local_window v_2_local_window)))
 (let (($x3058 (= v_3_msl_ms v_2_msl_ms)))
 (let (($x7924 (= v_3_user_timeout_ms v_2_user_timeout_ms)))
 (let (($x8664 (= v_3_active_open v_2_active_open)))
 (let (($x7923 (= v_3_retries v_2_retries)))
 (let (($x4488 (= v_3_rto_ms v_2_rto_ms)))
 (let (($x4042 (= v_3_tx_flags v_2_tx_flags)))
 (let (($x8663 (= v_3_tx_ack v_2_tx_ack)))
 (let (($x7586 (= v_3_tx_seq v_2_tx_seq)))
 (let (($x7576 (= v_3_rcv_nxt v_2_rcv_nxt)))
 (let (($x3047 (= v_3_snd_nxt v_2_snd_nxt)))
 (let (($x4608 (= v_3_snd_una v_2_snd_una)))
 (let (($x4133 (= v_3_irs v_2_irs)))
 (let (($x4755 (= v_3_iss v_2_iss)))
 (let (($x8688 (= 4 state_3)))
 (let (($x7337 (or (not active_2_time_wait) (not (<= due_2_time_wait 30)))))
 (let (($x7936 (not active_2_user)))
 (let (($x9124 (or $x7936 (not (<= due_2_user 30)))))
 (let (($x7972 (not active_2_rtx)))
 (let (($x11797 (or $x7972 (not (<= due_2_rtx 30)))))
 (let (($x4736 (or (not (= ((_ extract 31 31) (bvmul (_ bv4294967295 32) v_2_rcv_nxt)) (_ bv0 1))) (bvule (_ bv2147474645 31) (bvmul (_ bv2147483647 31) ((_ extract 30 0) v_2_rcv_nxt))))))
 (let (($x11792 (not (and (bvule (bvmul (_ bv4294967295 32) v_2_rcv_nxt) (_ bv4294958292 32)) $x4736))))
 (let (($x8874 (not (= v_2_rcv_nxt (_ bv9003 32)))))
 (let (($x11868 (= v_2_snd_una (_ bv1001 32))))
 (let (($x457 (= state_2 4)))
 (and $x457 $x11868 (= 8 v_2_snd_wnd) $x8874 $x11792 $x11797 $x9124 $x7337 $x8688 $x4755 $x4133 $x4608 $x3047 $x7576 $x7586 $x8663 $x4042 $x4488 $x7923 $x8664 $x7924 $x3058 $x4043 $x4047 $x4048 $x4588 $x7925 $x3059 $x4064 $x4165 $x4589 $x4576 $x7926 $x3045 $x128 $x153 $x170)))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 (let (($x11261 (= due_4_time_wait due_3_time_wait)))
 (let (($x11260 (= due_4_user due_3_user)))
 (let (($x11259 (= due_4_rtx due_3_rtx)))
 (let (($x11258 (= active_4_time_wait active_3_time_wait)))
 (let (($x11257 (= active_4_user active_3_user)))
 (let (($x9607 (= active_4_rtx active_3_rtx)))
 (let ((?x10212 (seq.unit (_ bv1 8))))
 (let ((?x9649 (seq.len v_3_rcv_buf)))
 (let (($x3066 (<= ?x9649 15)))
 (let (($x11788 (>= ?x9649 14)))
 (let (($x370 (not $x11788)))
 (let (($x2792 (or $x370 $x3066)))
 (let ((?x11791 (ite $x11788 (+ 16 (* (- 1) ?x9649)) 2)))
 (let (($x4743 (<= 0 ?x11791)))
 (let (($x297 (and $x4743 $x2792)))
 (let ((?x10216 (seq.++ ?x10212 (seq.unit (_ bv2 8)))))
 (let (($x7976 (or $x370 (<= ?x9649 14))))
 (let (($x6435 (and $x4743 $x7976)))
 (let ((?x354 (ite $x6435 ?x10216 (ite $x297 ?x10212 (as seq.empty (Seq (_ BitVec 8)))))))
 (let (($x11255 (= v_4_take v_3_take)))
 (let (($x11254 (= v_4_snd_wl2 v_3_snd_wl2)))
 (let (($x11253 (= v_4_snd_wl1 v_3_snd_wl1)))
 (let (($x11252 (= v_4_snd_wnd v_3_snd_wnd)))
 (let (($x9610 (= v_4_rtx_buf v_3_rtx_buf)))
 (let (($x11250 (= v_4_snd_buf v_3_snd_buf)))
 (let (($x11811 (= v_4_local_window (+ 16 (* (- 1) ?x9649) (* (- 1) (seq.len ?x354))))))
 (let (($x9609 (= v_4_msl_ms v_3_msl_ms)))
 (let (($x11248 (= v_4_user_timeout_ms v_3_user_timeout_ms)))
 (let (($x11247 (= v_4_active_open v_3_active_open)))
 (let (($x9608 (= v_4_retries v_3_retries)))
 (let (($x11246 (= v_4_rto_ms v_3_rto_ms)))
 (let (($x11245 (= v_4_tx_flags v_3_tx_flags)))
 (let (($x11244 (= v_4_tx_ack v_3_tx_ack)))
 (let (($x11243 (= v_4_tx_seq v_3_tx_seq)))
 (let ((?x11820 (bvadd v_3_rcv_nxt ((_ int_to_bv 32) (ite $x6435 2 (ite $x297 1 0))))))
 (let (($x11241 (= v_4_snd_nxt v_3_snd_nxt)))
 (let (($x11240 (= v_4_snd_una v_3_snd_una)))
 (let (($x11239 (= v_4_irs v_3_irs)))
 (let (($x11238 (= v_4_iss v_3_iss)))
 (let (($x11237 (= 4 state_4)))
 (let (($x8895 (or (not active_3_time_wait) (not (<= due_3_time_wait 31)))))
 (let (($x11803 (or (not active_3_user) (not (<= due_3_user 31)))))
 (let (($x11790 (or (not active_3_rtx) (not (<= due_3_rtx 31)))))
 (let (($x4751 (= v_3_rcv_nxt (_ bv9001 32))))
 (let (($x7463 (= v_3_snd_una (_ bv1001 32))))
 (let (($x3072 (= state_3 4)))
 (and $x3072 $x7463 (= 8 v_3_snd_wnd) $x4751 $x3066 $x11790 $x11803 $x8895 $x11237 $x11238 $x11239 $x11240 $x11241 (= v_4_rcv_nxt ?x11820) $x11243 $x11244 $x11245 $x11246 $x9608 $x11247 $x11248 $x9609 $x11811 $x11250 $x9610 (= v_4_rcv_buf (seq.++ v_3_rcv_buf ?x354)) $x11252 $x11253 $x11254 $x11255 (= v_4_rx_chunk ?x354) $x9607 $x11257 $x11258 $x11259 $x11260 $x11261))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 (let (($x11710 (= due_5_time_wait due_4_time_wait)))
 (let (($x11750 (= due_5_user due_4_user)))
 (let (($x11748 (= due_5_rtx due_4_rtx)))
 (let (($x11746 (= active_5_time_wait active_4_time_wait)))
 (let (($x11747 (= active_5_user active_4_user)))
 (let (($x11745 (= active_5_rtx active_4_rtx)))
 (let ((?x10196 (seq.unit (_ bv3 8))))
 (let ((?x5426 (seq.len v_4_rcv_buf)))
 (let (($x11174 (<= ?x5426 15)))
 (let (($x8893 (>= ?x5426 14)))
 (let (($x6446 (not $x8893)))
 (let (($x11871 (or $x6446 $x11174)))
 (let ((?x7954 (ite $x8893 (+ 16 (* (- 1) ?x5426)) 2)))
 (let (($x11806 (<= 0 ?x7954)))
 (let (($x11827 (and $x11806 $x11871)))
 (let ((?x10199 (seq.unit (_ bv4 8))))
 (let ((?x10200 (seq.++ ?x10196 ?x10199)))
 (let (($x7361 (or $x6446 (<= ?x5426 14))))
 (let (($x7362 (and $x11806 $x7361)))
 (let ((?x3740 (ite $x7362 ?x10200 (ite $x11827 ?x10196 (as seq.empty (Seq (_ BitVec 8)))))))
 (let (($x11744 (= v_5_take v_4_take)))
 (let (($x11709 (= v_5_snd_wl2 v_4_snd_wl2)))
 (let (($x687 (= v_5_snd_wl1 v_4_snd_wl1)))
 (let (($x11742 (= v_5_snd_wnd v_4_snd_wnd)))
 (let (($x11741 (= v_5_rtx_buf v_4_rtx_buf)))
 (let (($x11707 (= v_5_snd_buf v_4_snd_buf)))
 (let (($x7538 (= v_5_local_window (+ 16 (* (- 1) ?x5426) (* (- 1) (seq.len ?x3740))))))
 (let (($x11737 (= v_5_msl_ms v_4_msl_ms)))
 (let (($x11738 (= v_5_user_timeout_ms v_4_user_timeout_ms)))
 (let (($x11736 (= v_5_active_open v_4_active_open)))
 (let (($x11734 (= v_5_retries v_4_retries)))
 (let (($x11015 (= v_5_rto_ms v_4_rto_ms)))
 (let (($x5414 (= v_5_tx_flags v_4_tx_flags)))
 (let (($x5413 (= v_5_tx_ack v_4_tx_ack)))
 (let (($x5412 (= v_5_tx_seq v_4_tx_seq)))
 (let ((?x4622 (bvadd v_4_rcv_nxt ((_ int_to_bv 32) (ite $x7362 2 (ite $x11827 1 0))))))
 (let (($x5365 (= v_5_snd_nxt v_4_snd_nxt)))
 (let (($x5361 (= v_5_snd_una v_4_snd_una)))
 (let (($x5411 (= v_5_irs v_4_irs)))
 (let (($x5410 (= v_5_iss v_4_iss)))
 (let (($x5409 (= 4 state_5)))
 (let (($x7415 (or (not active_4_time_wait) (not (<= due_4_time_wait 32)))))
 (let (($x12741 (or (not active_4_user) (not (<= due_4_user 32)))))
 (let (($x748 (or (not active_4_rtx) (not (<= due_4_rtx 32)))))
 (let (($x3060 (= v_4_rcv_nxt (_ bv9003 32))))
 (let (($x7934 (= v_4_snd_una (_ bv1001 32))))
 (let (($x6441 (= state_4 4)))
 (and $x6441 $x7934 (= 8 v_4_snd_wnd) $x3060 $x11174 $x748 $x12741 $x7415 $x5409 $x5410 $x5411 $x5361 $x5365 (= v_5_rcv_nxt ?x4622) $x5412 $x5413 $x5414 $x11015 $x11734 $x11736 $x11738 $x11737 $x7538 $x11707 $x11741 (= v_5_rcv_buf (seq.++ v_4_rcv_buf ?x3740)) $x11742 $x687 $x11709 $x11744 (= v_5_rx_chunk ?x3740) $x11745 $x11747 $x11746 $x11748 $x11750 $x11710)))))))))))))))))))))))))))))))))))))))))))))))))
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
 (= (_ bv1000 32) v_0_tx_seq))
(assert
 (= (_ bv0 32) v_0_tx_ack))
(assert
 (= v_0_tx_flags "S"))
(assert
 (= 1000 v_0_rto_ms))
(assert
 (= 0 v_0_retries))
(assert
 (= v_0_active_open true))
(assert
 (= 30000 v_0_user_timeout_ms))
(assert
 (= 60000 v_0_msl_ms))
(assert
 (= 16 v_0_local_window))
(assert
 (= v_0_snd_buf (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rtx_buf (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rcv_buf (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= 8 v_0_snd_wnd))
(assert
 (= (_ bv0 32) v_0_snd_wl1))
(assert
 (= (_ bv0 32) v_0_snd_wl2))
(assert
 (= 0 v_0_take))
(assert
 (= v_0_rx_chunk (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= 0 choice_0))
(assert
 (= 0 now_1))
(assert
 (= 4 choice_1))
(assert
 (= 10 now_2))
(assert
 (= (_ bv9000 32) input_1_net.synack_seq))
(assert
 (= (_ bv1001 32) input_1_net.synack_ack))
(assert
 (= 8 input_1_net.synack_window))
(assert
 (= 114 choice_2))
(assert
 (= 30 now_3))
(assert
 (= (_ bv9003 32) input_2_net.data_seq))
(assert
 (= (_ bv1001 32) input_2_net.data_ack))
(assert
 (= 8 input_2_net.data_window))
(assert
 (let ((?x10199 (seq.unit (_ bv4 8))))
 (let ((?x10196 (seq.unit (_ bv3 8))))
 (let ((?x10200 (seq.++ ?x10196 ?x10199)))
 (= input_2_net.data_data ?x10200)))))
(assert
 (= 111 choice_3))
(assert
 (= 31 now_4))
(assert
 (= (_ bv9001 32) input_3_net.data_seq))
(assert
 (= (_ bv1001 32) input_3_net.data_ack))
(assert
 (= 8 input_3_net.data_window))
(assert
 (let ((?x10212 (seq.unit (_ bv1 8))))
 (let ((?x10216 (seq.++ ?x10212 (seq.unit (_ bv2 8)))))
 (= input_3_net.data_data ?x10216))))
(assert
 (= 111 choice_4))
(assert
 (= 32 now_5))
(assert
 (= (_ bv9003 32) input_4_net.data_seq))
(assert
 (= (_ bv1001 32) input_4_net.data_ack))
(assert
 (= 8 input_4_net.data_window))
(assert
 (let ((?x10199 (seq.unit (_ bv4 8))))
(let ((?x10196 (seq.unit (_ bv3 8))))
(let ((?x10200 (seq.++ ?x10196 ?x10199)))
(= input_4_net.data_data ?x10200)))))
(check-sat)
