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
 (let (($x9741 (= due_1_time_wait due_0_time_wait)))
 (let (($x4621 (= due_1_user 30000)))
 (let (($x5344 (= due_1_rtx 1000)))
 (let (($x16933 (not active_1_time_wait)))
 (let (($x760 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x2658 (= v_1_take 0)))
 (let (($x4407 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x5898 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x6251 (= v_1_snd_wnd 8)))
 (let (($x7207 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x7199 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x1351 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x6256 (= v_1_local_window 16)))
 (let (($x2697 (= v_1_msl_ms 60000)))
 (let (($x12923 (= v_1_user_timeout_ms 30000)))
 (let (($x3691 (= 0 v_1_retries)))
 (let (($x8038 (= 1000 v_1_rto_ms)))
 (let (($x5097 (= v_1_tx_flags "S")))
 (let (($x7018 (= v_1_tx_ack (_ bv0 32))))
 (let (($x11948 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x3882 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x5512 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x3980 (= v_1_snd_una (_ bv1000 32))))
 (let (($x531 (= v_1_irs (_ bv0 32))))
 (let (($x18211 (= v_1_iss (_ bv1000 32))))
 (let (($x16295 (= 2 state_1)))
 (let (($x17951 (not active_0_time_wait)))
 (let (($x8817 (or $x17951 (not (<= due_0_time_wait 0)))))
 (let (($x5006 (not active_0_user)))
 (let (($x18844 (or $x5006 (not (<= due_0_user 0)))))
 (let (($x16500 (not active_0_rtx)))
 (let (($x12409 (or $x16500 (not (<= due_0_rtx 0)))))
 (let (($x5234 (= state_0 0)))
 (and $x5234 (>= 0 now_0) $x12409 $x18844 $x8817 $x16295 $x18211 $x531 $x3980 $x5512 $x3882 $x11948 $x7018 $x5097 $x8038 $x3691 v_1_active_open $x12923 $x2697 $x6256 $x1351 $x7199 $x7207 $x6251 $x5898 $x4407 $x2658 $x760 active_1_rtx active_1_user $x16933 $x5344 $x4621 $x9741)))))))))))))))))))))))))))))))))))
(assert
 (let (($x15028 (= due_2_time_wait due_1_time_wait)))
 (let (($x2005 (= due_2_user due_1_user)))
 (let (($x2001 (= due_2_rtx due_1_rtx)))
 (let (($x19033 (= active_2_time_wait active_1_time_wait)))
 (let (($x10825 (not active_2_user)))
 (let (($x7579 (not active_2_rtx)))
 (let (($x10458 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x7186 (= v_2_take v_1_take)))
 (let (($x8879 (= v_2_snd_wl2 (_ bv1001 32))))
 (let (($x550 (= v_2_snd_wl1 (_ bv9000 32))))
 (let (($x11967 (= v_2_snd_wnd 8)))
 (let (($x9421 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x11060 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x5000 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x11702 (= v_2_local_window v_1_local_window)))
 (let (($x13792 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x4962 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x18978 (= v_2_active_open v_1_active_open)))
 (let (($x8832 (= v_2_retries v_1_retries)))
 (let (($x8712 (= v_2_rto_ms v_1_rto_ms)))
 (let (($x8697 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x2066 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x2064 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x18925 (= v_2_rcv_nxt (_ bv9001 32))))
 (let (($x8865 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x222 (= v_2_snd_una (_ bv1001 32))))
 (let (($x11429 (= v_2_irs (_ bv9000 32))))
 (let (($x17544 (= v_2_iss v_1_iss)))
 (let (($x12585 (= 4 state_2)))
 (let (($x16933 (not active_1_time_wait)))
 (let (($x11445 (or $x16933 (not (<= due_1_time_wait 10)))))
 (let (($x782 (or (not active_1_user) (not (<= due_1_user 10)))))
 (let (($x19747 (or (not active_1_rtx) (not (<= due_1_rtx 10)))))
 (let (($x3691 (= 0 v_1_retries)))
 (let (($x5512 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x9376 (= state_1 2)))
 (and $x9376 $x5512 $x3691 $x19747 $x782 $x11445 $x12585 $x17544 $x11429 $x222 $x8865 $x18925 $x2064 $x2066 $x8697 $x8712 $x8832 $x18978 $x4962 $x13792 $x11702 $x5000 $x11060 $x9421 $x11967 $x550 $x8879 $x7186 $x10458 $x7579 $x10825 $x19033 $x2001 $x2005 $x15028))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x13407 (= due_3_time_wait due_2_time_wait)))
 (let (($x12339 (= due_3_user due_2_user)))
 (let (($x3238 (= due_3_rtx due_2_rtx)))
 (let (($x13479 (= active_3_time_wait active_2_time_wait)))
 (let (($x13493 (= active_3_user active_2_user)))
 (let (($x13494 (= active_3_rtx active_2_rtx)))
 (let ((?x2917 (seq.unit (_ bv1 8))))
 (let ((?x4259 (seq.len v_2_rcv_buf)))
 (let (($x10795 (<= ?x4259 15)))
 (let (($x6741 (>= ?x4259 13)))
 (let (($x10814 (not $x6741)))
 (let (($x11594 (or $x10814 $x10795)))
 (let ((?x19441 (ite $x6741 (+ 16 (* (- 1) ?x4259)) 3)))
 (let (($x6188 (<= 0 ?x19441)))
 (let (($x16989 (and $x6188 $x11594)))
 (let ((?x13312 (seq.unit (_ bv2 8))))
 (let ((?x12059 (seq.++ ?x2917 ?x13312)))
 (let (($x4289 (or $x10814 (<= ?x4259 14))))
 (let (($x6247 (and $x6188 $x4289)))
 (let ((?x10123 (seq.unit (_ bv3 8))))
 (let ((?x16477 (seq.++ ?x13312 ?x10123)))
 (let ((?x19679 (seq.++ ?x2917 ?x16477)))
 (let (($x6068 (or $x10814 (<= ?x4259 13))))
 (let (($x7133 (and $x6188 $x6068)))
 (let ((?x13588 (ite $x7133 ?x19679 (ite $x6247 ?x12059 (ite $x16989 ?x2917 (as seq.empty (Seq (_ BitVec 8))))))))
 (let (($x13389 (= v_3_take v_2_take)))
 (let (($x13390 (= v_3_snd_wl2 v_2_snd_wl2)))
 (let (($x3188 (= v_3_snd_wl1 v_2_snd_wl1)))
 (let (($x5271 (= v_3_snd_wnd v_2_snd_wnd)))
 (let (($x13387 (= v_3_rtx_buf v_2_rtx_buf)))
 (let (($x2445 (= v_3_snd_buf v_2_snd_buf)))
 (let (($x25112 (= v_3_local_window (+ 16 (* (- 1) ?x4259) (* (- 1) (seq.len ?x13588))))))
 (let (($x2438 (= v_3_msl_ms v_2_msl_ms)))
 (let (($x2439 (= v_3_user_timeout_ms v_2_user_timeout_ms)))
 (let (($x13481 (= v_3_active_open v_2_active_open)))
 (let (($x13440 (= v_3_retries v_2_retries)))
 (let (($x4734 (= v_3_rto_ms v_2_rto_ms)))
 (let (($x9657 (= v_3_tx_flags v_2_tx_flags)))
 (let (($x377 (= v_3_tx_ack v_2_tx_ack)))
 (let (($x13438 (= v_3_tx_seq v_2_tx_seq)))
 (let ((?x7460 (bvadd v_2_rcv_nxt ((_ int_to_bv 32) (ite $x7133 3 (ite $x6247 2 (ite $x16989 1 0)))))))
 (let (($x5008 (= v_3_snd_nxt v_2_snd_nxt)))
 (let (($x13437 (= v_3_snd_una v_2_snd_una)))
 (let (($x3417 (= v_3_irs v_2_irs)))
 (let (($x3447 (= v_3_iss v_2_iss)))
 (let (($x14590 (= 4 state_3)))
 (let (($x12882 (or (not active_2_time_wait) (not (<= due_2_time_wait 30)))))
 (let (($x10825 (not active_2_user)))
 (let (($x3786 (or $x10825 (not (<= due_2_user 30)))))
 (let (($x7579 (not active_2_rtx)))
 (let (($x11884 (or $x7579 (not (<= due_2_rtx 30)))))
 (let (($x18925 (= v_2_rcv_nxt (_ bv9001 32))))
 (let (($x222 (= v_2_snd_una (_ bv1001 32))))
 (let (($x3008 (= state_2 4)))
 (and $x3008 $x222 (= 8 v_2_snd_wnd) $x18925 $x10795 $x11884 $x3786 $x12882 $x14590 $x3447 $x3417 $x13437 $x5008 (= v_3_rcv_nxt ?x7460) $x13438 $x377 $x9657 $x4734 $x13440 $x13481 $x2439 $x2438 $x25112 $x2445 $x13387 (= v_3_rcv_buf (seq.++ v_2_rcv_buf ?x13588)) $x5271 $x3188 $x13390 $x13389 (= v_3_rx_chunk ?x13588) $x13494 $x13493 $x13479 $x3238 $x12339 $x13407))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x13973 (= due_4_time_wait due_3_time_wait)))
 (let (($x9475 (= due_4_user due_3_user)))
 (let (($x18195 (= due_4_rtx due_3_rtx)))
 (let (($x14018 (= active_4_time_wait active_3_time_wait)))
 (let (($x5231 (= active_4_user active_3_user)))
 (let (($x14030 (= active_4_rtx active_3_rtx)))
 (let ((?x13312 (seq.unit (_ bv2 8))))
 (let ((?x14967 (ubv_to_int (bvadd (_ bv4294958294 32) v_3_rcv_nxt))))
 (let ((?x11677 (* (- 1) ?x14967)))
 (let ((?x11674 (+ 4 ?x11677)))
 (let ((?x10503 (seq.len v_3_rcv_buf)))
 (let ((?x2874 (* (- 1) ?x10503)))
 (let ((?x7895 (+ 16 ?x2874)))
 (let ((?x12509 (ite (<= ?x2874 (+ (- 12) ?x11677)) ?x7895 ?x11674)))
 (let (($x12477 (<= 0 ?x12509)))
 (let ((?x10123 (seq.unit (_ bv3 8))))
 (let ((?x16477 (seq.++ ?x13312 ?x10123)))
 (let ((?x13531 (ite (and $x12477 (>= ?x12509 2)) ?x16477 (ite (and $x12477 (>= ?x12509 1)) ?x13312 (as seq.empty (Seq (_ BitVec 8)))))))
 (let ((?x10275 (seq.++ ?x13312 (seq.++ ?x10123 (seq.unit (_ bv4 8))))))
 (let ((?x16627 (seq.++ ?x13312 (seq.++ ?x10123 (seq.++ (seq.unit (_ bv4 8)) (seq.unit (_ bv5 8)))))))
 (let ((?x367 (ite (and $x12477 (>= ?x12509 4)) ?x16627 (ite (and $x12477 (>= ?x12509 3)) ?x10275 ?x13531))))
 (let ((?x6431 (ite (<= 0 ?x14967) (ite $x12477 (seq.extract ?x16627 ?x14967 ?x12509) (as seq.empty (Seq (_ BitVec 8)))) ?x367)))
 (let (($x3197 (= v_4_take v_3_take)))
 (let (($x845 (= v_4_snd_wl2 v_3_snd_wl2)))
 (let (($x1702 (= v_4_snd_wl1 v_3_snd_wl1)))
 (let (($x1670 (= v_4_snd_wnd v_3_snd_wnd)))
 (let (($x6010 (= v_4_rtx_buf v_3_rtx_buf)))
 (let (($x10709 (= v_4_snd_buf v_3_snd_buf)))
 (let (($x8209 (= v_4_msl_ms v_3_msl_ms)))
 (let (($x6404 (= v_4_user_timeout_ms v_3_user_timeout_ms)))
 (let (($x16823 (= v_4_active_open v_3_active_open)))
 (let (($x1892 (= v_4_retries v_3_retries)))
 (let (($x991 (= v_4_rto_ms v_3_rto_ms)))
 (let (($x12239 (= v_4_tx_flags v_3_tx_flags)))
 (let (($x8205 (= v_4_tx_ack v_3_tx_ack)))
 (let (($x11695 (= v_4_tx_seq v_3_tx_seq)))
 (let (($x3600 (= v_4_snd_nxt v_3_snd_nxt)))
 (let (($x5223 (= v_4_snd_una v_3_snd_una)))
 (let (($x1753 (= v_4_irs v_3_irs)))
 (let (($x5310 (= v_4_iss v_3_iss)))
 (let (($x13743 (= 4 state_4)))
 (let (($x4191 (or (not active_3_time_wait) (not (<= due_3_time_wait 31)))))
 (let (($x9489 (or (not active_3_user) (not (<= due_3_user 31)))))
 (let (($x1286 (or (not active_3_rtx) (not (<= due_3_rtx 31)))))
 (let (($x2315 (<= ?x10503 15)))
 (let (($x7780 (<= ?x14967 3)))
 (let (($x11743 (and (= ((_ extract 31 14) v_3_rcv_nxt) (_ bv0 18)) (bvule ((_ extract 13 0) v_3_rcv_nxt) (_ bv9001 14)))))
 (let (($x9150 (bvule (_ bv2147492650 32) v_3_rcv_nxt)))
 (let (($x9724 (not (= v_3_rcv_nxt (_ bv9002 32)))))
 (let (($x6564 (= v_3_snd_una (_ bv1001 32))))
 (let (($x11387 (= state_3 4)))
 (and $x11387 $x6564 (= 8 v_3_snd_wnd) $x9724 (not (or $x9150 $x11743)) $x7780 $x2315 $x1286 $x9489 $x4191 $x13743 $x5310 $x1753 $x5223 $x3600 (= v_4_rcv_nxt (bvadd v_3_rcv_nxt ((_ int_to_bv 32) (seq.len ?x6431)))) $x11695 $x8205 $x12239 $x991 $x1892 $x16823 $x6404 $x8209 (= v_4_local_window (+ 16 ?x2874 (* (- 1) (seq.len ?x6431)))) $x10709 $x6010 (= v_4_rcv_buf (seq.++ v_3_rcv_buf ?x6431)) $x1670 $x1702 $x845 $x3197 (= v_4_rx_chunk ?x6431) $x14030 $x5231 $x14018 $x18195 $x9475 $x13973)))))))))))))))))))))))))))))))))))))))))))))))))))))
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
 (= 111 choice_2))
(assert
 (= 30 now_3))
(assert
 (= (_ bv9001 32) input_2_net.data_seq))
(assert
 (= (_ bv1001 32) input_2_net.data_ack))
(assert
 (= 8 input_2_net.data_window))
(assert
 (let ((?x10123 (seq.unit (_ bv3 8))))
 (let ((?x13312 (seq.unit (_ bv2 8))))
 (let ((?x16477 (seq.++ ?x13312 ?x10123)))
 (let ((?x2917 (seq.unit (_ bv1 8))))
 (let ((?x19679 (seq.++ ?x2917 ?x16477)))
 (= input_2_net.data_data ?x19679)))))))
(assert
 (= 112 choice_3))
(assert
 (= 31 now_4))
(assert
 (= (_ bv9002 32) input_3_net.data_seq))
(assert
 (= (_ bv1001 32) input_3_net.data_ack))
(assert
 (= 8 input_3_net.data_window))
(assert
 (let ((?x13312 (seq.unit (_ bv2 8))))
(let ((?x16627 (seq.++ ?x13312 (seq.++ (seq.unit (_ bv3 8)) (seq.++ (seq.unit (_ bv4 8)) (seq.unit (_ bv5 8)))))))
(= input_3_net.data_data ?x16627))))
(check-sat)
