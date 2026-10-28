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
 true)
(assert
 (let (($x2792 (= due_1_time_wait due_0_time_wait)))
 (let (($x3128 (= due_1_user 30000)))
 (let (($x18074 (= due_1_rtx 1000)))
 (let (($x2726 (not active_1_time_wait)))
 (let (($x4170 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x6079 (= v_1_take 0)))
 (let (($x6210 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x6213 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x1505 (= v_1_snd_wnd 8)))
 (let (($x2724 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x7927 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x7928 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x6198 (= v_1_local_window 16)))
 (let (($x6216 (= v_1_msl_ms 60000)))
 (let (($x6215 (= v_1_user_timeout_ms 30000)))
 (let (($x11238 (= 0 v_1_retries)))
 (let (($x12110 (= 1000 v_1_rto_ms)))
 (let (($x11237 (= v_1_tx_flags "S")))
 (let (($x1507 (= v_1_tx_ack (_ bv0 32))))
 (let (($x1525 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x1530 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x235 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x1861 (= v_1_snd_una (_ bv1000 32))))
 (let (($x11385 (= v_1_irs (_ bv0 32))))
 (let (($x11679 (= v_1_iss (_ bv1000 32))))
 (let (($x11800 (= 2 state_1)))
 (let (($x7852 (not active_0_time_wait)))
 (let (($x4191 (or $x7852 (not (<= due_0_time_wait 0)))))
 (let (($x8362 (not active_0_user)))
 (let (($x11687 (or $x8362 (not (<= due_0_user 0)))))
 (let (($x4436 (not active_0_rtx)))
 (let (($x3131 (or $x4436 (not (<= due_0_rtx 0)))))
 (let (($x12092 (= state_0 0)))
 (and $x12092 (>= 0 now_0) $x3131 $x11687 $x4191 $x11800 $x11679 $x11385 $x1861 $x235 $x1530 $x1525 $x1507 $x11237 $x12110 $x11238 v_1_active_open $x6215 $x6216 $x6198 $x7928 $x7927 $x2724 $x1505 $x6213 $x6210 $x6079 $x4170 active_1_rtx active_1_user $x2726 $x18074 $x3128 $x2792)))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x6146 (= due_2_time_wait due_1_time_wait)))
 (let (($x9011 (= due_2_user due_1_user)))
 (let (($x1656 (= due_2_rtx due_1_rtx)))
 (let (($x9005 (= active_2_time_wait active_1_time_wait)))
 (let (($x11836 (not active_2_user)))
 (let (($x4735 (not active_2_rtx)))
 (let (($x7124 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x7623 (= v_2_take v_1_take)))
 (let (($x11379 (= v_2_snd_wl2 (_ bv1001 32))))
 (let (($x2054 (= v_2_snd_wl1 (_ bv9000 32))))
 (let (($x7631 (= v_2_snd_wnd 8)))
 (let (($x3114 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x1686 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x7172 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x1682 (= v_2_local_window v_1_local_window)))
 (let (($x1683 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x1679 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x1676 (= v_2_active_open v_1_active_open)))
 (let (($x1677 (= v_2_retries v_1_retries)))
 (let (($x1674 (= v_2_rto_ms v_1_rto_ms)))
 (let (($x1670 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x7171 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x1671 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x984 (= v_2_rcv_nxt (_ bv9001 32))))
 (let (($x7189 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x11910 (= v_2_snd_una (_ bv1001 32))))
 (let (($x1509 (= v_2_irs (_ bv9000 32))))
 (let (($x7188 (= v_2_iss v_1_iss)))
 (let (($x7123 (= 4 state_2)))
 (let (($x2726 (not active_1_time_wait)))
 (let (($x6196 (or $x2726 (not (<= due_1_time_wait 10)))))
 (let (($x1522 (or (not active_1_user) (not (<= due_1_user 10)))))
 (let (($x4713 (or (not active_1_rtx) (not (<= due_1_rtx 10)))))
 (let (($x11238 (= 0 v_1_retries)))
 (let (($x235 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x8637 (= state_1 2)))
 (and $x8637 $x235 $x11238 $x4713 $x1522 $x6196 $x7123 $x7188 $x1509 $x11910 $x7189 $x984 $x1671 $x7171 $x1670 $x1674 $x1677 $x1676 $x1679 $x1683 $x1682 $x7172 $x1686 $x3114 $x7631 $x2054 $x11379 $x7623 $x7124 $x4735 $x11836 $x9005 $x1656 $x9011 $x6146))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 (let (($x3169 (= due_3_time_wait due_2_time_wait)))
 (let (($x11466 (= due_3_user due_2_user)))
 (let (($x3192 (= due_3_rtx due_2_rtx)))
 (let (($x5340 (= active_3_time_wait active_2_time_wait)))
 (let (($x5277 (= active_3_user active_2_user)))
 (let (($x4606 (= active_3_rtx active_2_rtx)))
 (let ((?x2127 (seq.unit (_ bv1 8))))
 (let ((?x2855 (seq.len v_2_rcv_buf)))
 (let (($x7744 (<= ?x2855 15)))
 (let (($x730 (>= ?x2855 13)))
 (let (($x2677 (not $x730)))
 (let (($x8686 (or $x2677 $x7744)))
 (let ((?x1513 (ite $x730 (+ 16 (* (- 1) ?x2855)) 3)))
 (let (($x1515 (<= 0 ?x1513)))
 (let (($x8684 (and $x1515 $x8686)))
 (let ((?x1553 (seq.unit (_ bv2 8))))
 (let ((?x7649 (seq.++ ?x2127 ?x1553)))
 (let (($x7746 (or $x2677 (<= ?x2855 14))))
 (let (($x11661 (and $x1515 $x7746)))
 (let ((?x7108 (seq.unit (_ bv3 8))))
 (let ((?x9088 (seq.++ ?x1553 ?x7108)))
 (let ((?x7629 (seq.++ ?x2127 ?x9088)))
 (let (($x17004 (or $x2677 (<= ?x2855 13))))
 (let (($x11908 (and $x1515 $x17004)))
 (let ((?x8634 (ite $x11908 ?x7629 (ite $x11661 ?x7649 (ite $x8684 ?x2127 (as seq.empty (Seq (_ BitVec 8))))))))
 (let (($x1975 (= v_3_take v_2_take)))
 (let (($x2072 (= v_3_snd_wl2 v_2_snd_wl2)))
 (let (($x3170 (= v_3_snd_wl1 v_2_snd_wl1)))
 (let (($x8670 (= v_3_snd_wnd v_2_snd_wnd)))
 (let (($x11451 (= v_3_rtx_buf v_2_rtx_buf)))
 (let (($x11409 (= v_3_snd_buf v_2_snd_buf)))
 (let (($x2983 (= v_3_local_window (+ 16 (* (- 1) ?x2855) (* (- 1) (seq.len ?x8634))))))
 (let (($x3183 (= v_3_msl_ms v_2_msl_ms)))
 (let (($x11334 (= v_3_user_timeout_ms v_2_user_timeout_ms)))
 (let (($x3198 (= v_3_active_open v_2_active_open)))
 (let (($x3197 (= v_3_retries v_2_retries)))
 (let (($x11393 (= v_3_rto_ms v_2_rto_ms)))
 (let (($x7656 (= v_3_tx_flags v_2_tx_flags)))
 (let (($x8347 (= v_3_tx_ack v_2_tx_ack)))
 (let (($x11332 (= v_3_tx_seq v_2_tx_seq)))
 (let ((?x359 (bvadd v_2_rcv_nxt ((_ int_to_bv 32) (ite $x11908 3 (ite $x11661 2 (ite $x8684 1 0)))))))
 (let (($x12728 (= v_3_snd_nxt v_2_snd_nxt)))
 (let (($x7848 (= v_3_snd_una v_2_snd_una)))
 (let (($x770 (= v_3_irs v_2_irs)))
 (let (($x11460 (= v_3_iss v_2_iss)))
 (let (($x11456 (= 4 state_3)))
 (let (($x1510 (or (not active_2_time_wait) (not (<= due_2_time_wait 30)))))
 (let (($x11836 (not active_2_user)))
 (let (($x1493 (or $x11836 (not (<= due_2_user 30)))))
 (let (($x4735 (not active_2_rtx)))
 (let (($x1492 (or $x4735 (not (<= due_2_rtx 30)))))
 (let (($x984 (= v_2_rcv_nxt (_ bv9001 32))))
 (let (($x11910 (= v_2_snd_una (_ bv1001 32))))
 (let (($x8341 (= state_2 4)))
 (and $x8341 $x11910 (= 8 v_2_snd_wnd) $x984 $x7744 $x1492 $x1493 $x1510 $x11456 $x11460 $x770 $x7848 $x12728 (= v_3_rcv_nxt ?x359) $x11332 $x8347 $x7656 $x11393 $x3197 $x3198 $x11334 $x3183 $x2983 $x11409 $x11451 (= v_3_rcv_buf (seq.++ v_2_rcv_buf ?x8634)) $x8670 $x3170 $x2072 $x1975 (= v_3_rx_chunk ?x8634) $x4606 $x5277 $x5340 $x3192 $x11466 $x3169))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 (let (($x8503 (= due_4_time_wait due_3_time_wait)))
 (let (($x6988 (= due_4_user due_3_user)))
 (let (($x554 (= due_4_rtx due_3_rtx)))
 (let (($x562 (= active_4_time_wait active_3_time_wait)))
 (let (($x6143 (= active_4_user active_3_user)))
 (let (($x6987 (= active_4_rtx active_3_rtx)))
 (let ((?x1553 (seq.unit (_ bv2 8))))
 (let ((?x18973 (ubv_to_int (bvadd (_ bv4294958294 32) v_3_rcv_nxt))))
 (let ((?x7395 (* (- 1) ?x18973)))
 (let ((?x3013 (+ 4 ?x7395)))
 (let ((?x10473 (seq.len v_3_rcv_buf)))
 (let ((?x200 (* (- 1) ?x10473)))
 (let ((?x1502 (+ 16 ?x200)))
 (let ((?x7662 (ite (<= ?x200 (+ (- 12) ?x7395)) ?x1502 ?x3013)))
 (let (($x2026 (<= 0 ?x7662)))
 (let ((?x7108 (seq.unit (_ bv3 8))))
 (let ((?x9088 (seq.++ ?x1553 ?x7108)))
 (let ((?x7285 (ite (and $x2026 (>= ?x7662 2)) ?x9088 (ite (and $x2026 (>= ?x7662 1)) ?x1553 (as seq.empty (Seq (_ BitVec 8)))))))
 (let ((?x10606 (seq.++ ?x1553 (seq.++ ?x7108 (seq.unit (_ bv4 8))))))
 (let ((?x1520 (seq.++ ?x1553 (seq.++ ?x7108 (seq.++ (seq.unit (_ bv4 8)) (seq.unit (_ bv5 8)))))))
 (let ((?x4718 (ite (and $x2026 (>= ?x7662 4)) ?x1520 (ite (and $x2026 (>= ?x7662 3)) ?x10606 ?x7285))))
 (let ((?x3911 (ite (<= 0 ?x18973) (ite $x2026 (seq.extract ?x1520 ?x18973 ?x7662) (as seq.empty (Seq (_ BitVec 8)))) ?x4718)))
 (let (($x469 (= v_4_take v_3_take)))
 (let (($x6142 (= v_4_snd_wl2 v_3_snd_wl2)))
 (let (($x583 (= v_4_snd_wl1 v_3_snd_wl1)))
 (let (($x6141 (= v_4_snd_wnd v_3_snd_wnd)))
 (let (($x145 (= v_4_rtx_buf v_3_rtx_buf)))
 (let (($x6121 (= v_4_snd_buf v_3_snd_buf)))
 (let (($x161 (= v_4_msl_ms v_3_msl_ms)))
 (let (($x6137 (= v_4_user_timeout_ms v_3_user_timeout_ms)))
 (let (($x6339 (= v_4_active_open v_3_active_open)))
 (let (($x6135 (= v_4_retries v_3_retries)))
 (let (($x164 (= v_4_rto_ms v_3_rto_ms)))
 (let (($x6133 (= v_4_tx_flags v_3_tx_flags)))
 (let (($x6338 (= v_4_tx_ack v_3_tx_ack)))
 (let (($x6132 (= v_4_tx_seq v_3_tx_seq)))
 (let (($x6986 (= v_4_snd_nxt v_3_snd_nxt)))
 (let (($x6328 (= v_4_snd_una v_3_snd_una)))
 (let (($x6131 (= v_4_irs v_3_irs)))
 (let (($x6129 (= v_4_iss v_3_iss)))
 (let (($x1858 (= 4 state_4)))
 (let (($x11893 (or (not active_3_time_wait) (not (<= due_3_time_wait 31)))))
 (let (($x630 (or (not active_3_user) (not (<= due_3_user 31)))))
 (let (($x8770 (or (not active_3_rtx) (not (<= due_3_rtx 31)))))
 (let (($x1485 (<= ?x10473 15)))
 (let (($x1501 (<= ?x18973 3)))
 (let (($x9020 (and (= ((_ extract 31 14) v_3_rcv_nxt) (_ bv0 18)) (bvule ((_ extract 13 0) v_3_rcv_nxt) (_ bv9001 14)))))
 (let (($x1484 (bvule (_ bv2147492650 32) v_3_rcv_nxt)))
 (let (($x5037 (not (= v_3_rcv_nxt (_ bv9002 32)))))
 (let (($x5273 (= v_3_snd_una (_ bv1001 32))))
 (let (($x4989 (= state_3 4)))
 (and $x4989 $x5273 (= 8 v_3_snd_wnd) $x5037 (not (or $x1484 $x9020)) $x1501 $x1485 $x8770 $x630 $x11893 $x1858 $x6129 $x6131 $x6328 $x6986 (= v_4_rcv_nxt (bvadd v_3_rcv_nxt ((_ int_to_bv 32) (seq.len ?x3911)))) $x6132 $x6338 $x6133 $x164 $x6135 $x6339 $x6137 $x161 (= v_4_local_window (+ 16 ?x200 (* (- 1) (seq.len ?x3911)))) $x6121 $x145 (= v_4_rcv_buf (seq.++ v_3_rcv_buf ?x3911)) $x6141 $x583 $x6142 $x469 (= v_4_rx_chunk ?x3911) $x6987 $x6143 $x562 $x554 $x6988 $x8503)))))))))))))))))))))))))))))))))))))))))))))))))))))
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
 (let ((?x7108 (seq.unit (_ bv3 8))))
 (let ((?x1553 (seq.unit (_ bv2 8))))
 (let ((?x9088 (seq.++ ?x1553 ?x7108)))
 (let ((?x2127 (seq.unit (_ bv1 8))))
 (let ((?x7629 (seq.++ ?x2127 ?x9088)))
 (= input_2_net.data_data ?x7629)))))))
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
 (let ((?x1553 (seq.unit (_ bv2 8))))
(let ((?x1520 (seq.++ ?x1553 (seq.++ (seq.unit (_ bv3 8)) (seq.++ (seq.unit (_ bv4 8)) (seq.unit (_ bv5 8)))))))
(= input_3_net.data_data ?x1520))))
(check-sat)
