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
(declare-fun v_1_rto_base_ms () Int)
(declare-fun v_1_rtt_samples () Int)
(declare-fun v_1_rtt_last_ms () Int)
(declare-fun v_1_rtt_sample_was_ambiguous () Bool)
(declare-fun v_1_rtt_sample_used () Bool)
(declare-fun v_1_rtt_start_new () Bool)
(declare-fun v_1_rtt_remaining () Int)
(declare-fun v_1_rtt_end () (_ BitVec 32))
(declare-fun v_1_rtt_start_ms () Int)
(declare-fun v_1_rtt_ambiguous () Bool)
(declare-fun v_1_rtt_active () Bool)
(declare-fun v_1_rtt_previous_measured () Bool)
(declare-fun v_1_rtt_measured () Bool)
(declare-fun v_1_rtt_previous_var () Real)
(declare-fun v_1_rtt_previous_srtt () Real)
(declare-fun v_1_rtt_error_ms () Real)
(declare-fun v_1_rttvar_ms () Real)
(declare-fun v_1_srtt_ms () Real)
(declare-fun v_1_rx_fin_consumed () Bool)
(declare-fun v_1_rx_fin_done () Bool)
(declare-fun v_1_rx_fin_offset () Int)
(declare-fun v_1_rx_fin_seq () (_ BitVec 32))
(declare-fun v_1_rx_fin_pending () Bool)
(declare-fun v_1_fin_acknowledged () Bool)
(declare-fun v_1_fin_seq () (_ BitVec 32))
(declare-fun v_1_fin_sent () Bool)
(declare-fun v_1_fin_requested () Bool)
(declare-fun v_1_ack_window_update () Bool)
(declare-fun v_1_ack_advance () Bool)
(declare-fun v_1_ack_is_future () Bool)
(declare-fun v_1_ack_is_new () Bool)
(declare-fun v_1_ack_delta () Int)
(declare-fun v_1_seg_acceptable () Bool)
(declare-fun v_1_rx_acceptable () Bool)
(declare-fun v_1_rx_advance () Int)
(declare-fun v_1_rx_slot_15 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_14 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_13 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_12 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_11 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_10 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_09 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_08 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_07 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_06 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_05 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_04 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_03 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_02 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_01 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_00 () (Seq (_ BitVec 8)))
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
(declare-fun v_2_rto_base_ms () Int)
(declare-fun v_2_rtt_samples () Int)
(declare-fun v_2_rtt_last_ms () Int)
(declare-fun v_2_rtt_sample_was_ambiguous () Bool)
(declare-fun v_2_rtt_sample_used () Bool)
(declare-fun v_2_rtt_start_new () Bool)
(declare-fun v_2_rtt_remaining () Int)
(declare-fun v_2_rtt_end () (_ BitVec 32))
(declare-fun v_2_rtt_start_ms () Int)
(declare-fun v_2_rtt_ambiguous () Bool)
(declare-fun v_2_rtt_active () Bool)
(declare-fun v_2_rtt_previous_measured () Bool)
(declare-fun v_2_rtt_measured () Bool)
(declare-fun v_2_rtt_previous_var () Real)
(declare-fun v_2_rtt_previous_srtt () Real)
(declare-fun v_2_rtt_error_ms () Real)
(declare-fun v_2_rttvar_ms () Real)
(declare-fun v_2_srtt_ms () Real)
(declare-fun v_2_rx_fin_consumed () Bool)
(declare-fun v_2_rx_fin_done () Bool)
(declare-fun v_2_rx_fin_offset () Int)
(declare-fun v_2_rx_fin_seq () (_ BitVec 32))
(declare-fun v_2_rx_fin_pending () Bool)
(declare-fun v_2_fin_acknowledged () Bool)
(declare-fun v_2_fin_seq () (_ BitVec 32))
(declare-fun v_2_fin_sent () Bool)
(declare-fun v_2_fin_requested () Bool)
(declare-fun v_2_ack_window_update () Bool)
(declare-fun v_2_ack_advance () Bool)
(declare-fun v_2_ack_is_future () Bool)
(declare-fun v_2_ack_is_new () Bool)
(declare-fun v_2_ack_delta () Int)
(declare-fun v_2_seg_acceptable () Bool)
(declare-fun v_2_rx_acceptable () Bool)
(declare-fun v_2_rx_advance () Int)
(declare-fun v_2_rx_slot_15 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_14 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_13 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_12 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_11 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_10 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_09 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_08 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_07 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_06 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_05 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_04 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_03 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_02 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_01 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_00 () (Seq (_ BitVec 8)))
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
(declare-fun v_0_rx_slot_00 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_01 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_02 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_03 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_04 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_05 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_06 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_07 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_08 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_09 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_10 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_11 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_12 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_13 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_14 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_15 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_advance () Int)
(declare-fun v_0_rx_acceptable () Bool)
(declare-fun v_0_seg_acceptable () Bool)
(declare-fun v_0_ack_delta () Int)
(declare-fun v_0_ack_is_new () Bool)
(declare-fun v_0_ack_is_future () Bool)
(declare-fun v_0_ack_advance () Bool)
(declare-fun v_0_ack_window_update () Bool)
(declare-fun v_0_fin_requested () Bool)
(declare-fun v_0_fin_sent () Bool)
(declare-fun v_0_fin_seq () (_ BitVec 32))
(declare-fun v_0_fin_acknowledged () Bool)
(declare-fun v_0_rx_fin_pending () Bool)
(declare-fun v_0_rx_fin_seq () (_ BitVec 32))
(declare-fun v_0_rx_fin_offset () Int)
(declare-fun v_0_rx_fin_done () Bool)
(declare-fun v_0_rx_fin_consumed () Bool)
(declare-fun v_0_srtt_ms () Real)
(declare-fun v_0_rttvar_ms () Real)
(declare-fun v_0_rtt_error_ms () Real)
(declare-fun v_0_rtt_previous_srtt () Real)
(declare-fun v_0_rtt_previous_var () Real)
(declare-fun v_0_rtt_measured () Bool)
(declare-fun v_0_rtt_previous_measured () Bool)
(declare-fun v_0_rtt_active () Bool)
(declare-fun v_0_rtt_ambiguous () Bool)
(declare-fun v_0_rtt_start_ms () Int)
(declare-fun v_0_rtt_end () (_ BitVec 32))
(declare-fun v_0_rtt_remaining () Int)
(declare-fun v_0_rtt_start_new () Bool)
(declare-fun v_0_rtt_sample_used () Bool)
(declare-fun v_0_rtt_sample_was_ambiguous () Bool)
(declare-fun v_0_rtt_last_ms () Int)
(declare-fun v_0_rtt_samples () Int)
(declare-fun v_0_rto_base_ms () Int)
(declare-fun choice_0 () Int)
(declare-fun now_1 () Int)
(declare-fun choice_1 () Int)
(declare-fun now_2 () Int)
(declare-fun input_1_net.synack_seq () (_ BitVec 32))
(declare-fun input_1_net.synack_ack () (_ BitVec 32))
(declare-fun input_1_net.synack_window () Int)
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
 (let (($x293916 (= due_1_time_wait due_0_time_wait)))
 (let (($x78439 (= due_1_user 30000)))
 (let (($x306635 (= due_1_rtx 1000)))
 (let (($x47829 (not active_1_time_wait)))
 (let (($x337857 (= v_1_rto_base_ms 1000)))
 (let (($x314038 (= v_1_rtt_samples 0)))
 (let (($x41843 (= v_1_rtt_last_ms 0)))
 (let (($x29830 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x313807 (not v_1_rtt_sample_used)))
 (let (($x227011 (= v_1_rtt_remaining 1)))
 (let (($x115879 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x124855 (= v_1_rtt_start_ms 0)))
 (let (($x313799 (not v_1_rtt_ambiguous)))
 (let (($x341977 (not v_1_rtt_previous_measured)))
 (let (($x327475 (not v_1_rtt_measured)))
 (let (($x165412 (= v_1_rtt_previous_var 0.0)))
 (let (($x257605 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x310123 (= v_1_rtt_error_ms 0.0)))
 (let (($x320539 (= v_1_rttvar_ms 0.0)))
 (let (($x187745 (= v_1_srtt_ms 0.0)))
 (let (($x286084 (not v_1_rx_fin_consumed)))
 (let (($x312853 (not v_1_rx_fin_done)))
 (let (($x338301 (= v_1_rx_fin_offset 0)))
 (let (($x188582 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x293769 (not v_1_rx_fin_pending)))
 (let (($x295843 (not v_1_fin_acknowledged)))
 (let (($x41855 (= v_1_fin_seq (_ bv0 32))))
 (let (($x74036 (not v_1_fin_sent)))
 (let (($x181744 (not v_1_fin_requested)))
 (let (($x79436 (not v_1_ack_window_update)))
 (let (($x293133 (not v_1_ack_advance)))
 (let (($x306377 (not v_1_ack_is_future)))
 (let (($x1269 (not v_1_ack_is_new)))
 (let (($x288263 (= v_1_ack_delta 0)))
 (let (($x45437 (not v_1_seg_acceptable)))
 (let (($x352369 (not v_1_rx_acceptable)))
 (let (($x283801 (= v_1_rx_advance 0)))
 (let (($x340678 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x336786 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x93422 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x295907 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x349690 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x314738 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x344345 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x119450 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x24178 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x197993 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x21063 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x293636 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x119190 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x86855 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x293407 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x313503 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x64279 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x17462 (= v_1_take 0)))
 (let (($x253157 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x322791 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x336148 (= v_1_snd_wnd 8)))
 (let (($x341700 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x189944 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x318285 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x188575 (= v_1_local_window 16)))
 (let (($x126330 (= v_1_msl_ms 60000)))
 (let (($x205730 (= v_1_user_timeout_ms 30000)))
 (let (($x305447 (= 0 v_1_retries)))
 (let (($x334122 (= 1000 v_1_rto_ms)))
 (let (($x187870 (= v_1_tx_flags "S")))
 (let (($x86438 (= v_1_tx_ack (_ bv0 32))))
 (let (($x59947 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x171808 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x154371 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x105452 (= v_1_snd_una (_ bv1000 32))))
 (let (($x231114 (= v_1_irs (_ bv0 32))))
 (let (($x149751 (= v_1_iss (_ bv1000 32))))
 (let (($x88144 (= 2 state_1)))
 (let (($x307395 (not active_0_time_wait)))
 (let (($x43475 (or $x307395 (not (<= due_0_time_wait 0)))))
 (let (($x308299 (not active_0_user)))
 (let (($x292111 (or $x308299 (not (<= due_0_user 0)))))
 (let (($x342320 (not active_0_rtx)))
 (let (($x287268 (or $x342320 (not (<= due_0_rtx 0)))))
 (let (($x84975 (= state_0 0)))
 (and $x84975 (>= 0 now_0) $x287268 $x292111 $x43475 $x88144 $x149751 $x231114 $x105452 $x154371 $x171808 $x59947 $x86438 $x187870 $x334122 $x305447 v_1_active_open $x205730 $x126330 $x188575 $x318285 $x189944 $x341700 $x336148 $x322791 $x253157 $x17462 $x64279 $x313503 $x293407 $x86855 $x119190 $x293636 $x21063 $x197993 $x24178 $x119450 $x344345 $x314738 $x349690 $x295907 $x93422 $x336786 $x340678 $x283801 $x352369 $x45437 $x288263 $x1269 $x306377 $x293133 $x79436 $x181744 $x74036 $x41855 $x295843 $x293769 $x188582 $x338301 $x312853 $x286084 $x187745 $x320539 $x310123 $x257605 $x165412 $x327475 $x341977 v_1_rtt_active $x313799 $x124855 $x115879 $x227011 v_1_rtt_start_new $x313807 $x29830 $x41843 $x314038 $x337857 active_1_rtx active_1_user $x47829 $x306635 $x78439 $x293916))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 (let (($x10993 (= due_2_time_wait due_1_time_wait)))
 (let (($x142233 (= due_2_user due_1_user)))
 (let (($x295627 (= due_2_rtx due_1_rtx)))
 (let (($x188256 (= active_2_time_wait active_1_time_wait)))
 (let (($x140272 (not active_2_user)))
 (let (($x300873 (not active_2_rtx)))
 (let ((?x23487 (+ 900 (* (- 1) v_1_rtt_start_ms))))
 (let (($x313799 (not v_1_rtt_ambiguous)))
 (let ((?x227236 (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let ((?x315552 (ubv_to_int (bvadd (_ bv1001 32) (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let (($x325512 (>= ?x315552 ?x227236)))
 (let (($x256901 (and v_1_rtt_active $x325512 $x313799)))
 (let ((?x27231 (ite $x256901 ?x23487 v_1_rtt_last_ms)))
 (let ((?x16700 (to_real ?x27231)))
 (let ((?x284006 (+ v_1_srtt_ms (* (- 1.0) ?x16700))))
 (let ((?x149909 (ite $x256901 (ite (>= ?x284006 0.0) ?x284006 (+ (* (- 1.0) v_1_srtt_ms) ?x16700)) v_1_rtt_error_ms)))
 (let ((?x12071 (* (/ 3.0 4.0) v_1_rttvar_ms)))
 (let ((?x145490 (ite $x256901 (ite v_1_rtt_measured (+ ?x12071 (* (/ 1.0 4.0) ?x149909)) (* (/ 1.0 2.0) ?x16700)) v_1_rttvar_ms)))
 (let ((?x15734 (ite v_1_rtt_measured (+ (* (/ 7.0 8.0) v_1_srtt_ms) (* (/ 1.0 8.0) ?x16700)) ?x16700)))
 (let ((?x192404 (ite $x256901 ?x15734 v_1_srtt_ms)))
 (let ((?x130191 (+ (* (- 1.0) ?x192404) (* (- 1.0) (ite (<= ?x145490 (/ 1.0 4.0)) 1.0 (* 4.0 ?x145490))))))
 (let ((?x136504 (to_int ?x130191)))
 (let ((?x255210 (ite (<= ?x136504 (- 1000)) (* (- 1) ?x136504) 1000)))
 (let ((?x66085 (ite (<= 60000 ?x255210) 60000 ?x255210)))
 (let (($x86290 (= v_2_rtt_sample_was_ambiguous (and v_1_rtt_active v_1_rtt_ambiguous))))
 (let (($x318480 (not v_2_rtt_start_new)))
 (let ((?x159326 (* (- 1) ?x315552)))
 (let ((?x319402 (+ ?x227236 ?x159326)))
 (let ((?x256074 (ite (and v_1_rtt_active (not (<= v_1_rtt_remaining ?x319402))) ?x319402 v_1_rtt_remaining)))
 (let (($x304771 (and v_1_rtt_active $x325512)))
 (let (($x136867 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x82394 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let (($x127329 (= v_2_rtt_previous_measured (ite $x256901 v_1_rtt_measured v_1_rtt_previous_measured))))
 (let (($x195172 (= v_2_rtt_previous_var (ite $x256901 v_1_rttvar_ms v_1_rtt_previous_var))))
 (let (($x342579 (= v_2_rtt_previous_srtt (ite $x256901 v_1_srtt_ms v_1_rtt_previous_srtt))))
 (let (($x177344 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x336248 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x334651 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x66620 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x71065 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x95240 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x313813 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x37509 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x132687 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x165015 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x310982 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x37749 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x195033 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x285758 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x157241 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x341724 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x293381 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x127756 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x54154 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x71056 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x133351 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x328542 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x331886 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x149134 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x282640 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x98093 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x289401 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x199477 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x21623 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x325208 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x305379 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x317149 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x342788 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x338173 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x5006 (= v_2_take v_1_take)))
 (let (($x432151 (= v_2_snd_wl2 (_ bv1001 32))))
 (let (($x137635 (= v_2_snd_wl1 (_ bv9000 32))))
 (let (($x307060 (= v_2_snd_wnd 16)))
 (let (($x302623 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x292937 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x142242 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x311132 (= v_2_local_window v_1_local_window)))
 (let (($x142688 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x143991 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x29290 (= v_2_active_open v_1_active_open)))
 (let (($x295210 (= v_2_retries v_1_retries)))
 (let (($x295980 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x245367 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x224819 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x101996 (= v_2_rcv_nxt (_ bv9001 32))))
 (let (($x105142 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x129180 (= v_2_snd_una (_ bv1001 32))))
 (let (($x166078 (= v_2_irs (_ bv9000 32))))
 (let (($x343070 (= v_2_iss v_1_iss)))
 (let (($x342031 (= 4 state_2)))
 (let (($x47829 (not active_1_time_wait)))
 (let (($x312844 (or $x47829 (not (<= due_1_time_wait 900)))))
 (let (($x105010 (or (not active_1_user) (not (<= due_1_user 900)))))
 (let (($x339495 (or (not active_1_rtx) (not (<= due_1_rtx 900)))))
 (let (($x305447 (= 0 v_1_retries)))
 (let (($x154371 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x434191 (= state_1 2)))
 (and $x434191 $x154371 $x305447 $x339495 $x105010 $x312844 $x342031 $x343070 $x166078 $x129180 $x105142 $x101996 $x224819 $x245367 $x295980 (= v_2_rto_ms (ite $x256901 ?x66085 v_1_rto_ms)) $x295210 $x29290 $x143991 $x142688 $x311132 $x142242 $x292937 $x302623 $x307060 $x137635 $x432151 $x5006 $x338173 $x342788 $x317149 $x305379 $x325208 $x21623 $x199477 $x289401 $x98093 $x282640 $x149134 $x331886 $x328542 $x133351 $x71056 $x54154 $x127756 $x293381 $x341724 $x157241 $x285758 $x195033 $x37749 $x310982 $x165015 $x132687 $x37509 $x313813 $x95240 $x71065 $x66620 $x334651 $x336248 $x177344 (= v_2_srtt_ms ?x192404) (= v_2_rttvar_ms ?x145490) (= v_2_rtt_error_ms ?x149909) $x342579 $x195172 (= v_2_rtt_measured (or v_1_rtt_measured $x256901)) $x127329 (= v_2_rtt_active (and v_1_rtt_active (not $x304771))) (= v_2_rtt_ambiguous (and (not $x304771) v_1_rtt_ambiguous)) $x82394 $x136867 (= v_2_rtt_remaining (ite $x304771 0 ?x256074)) $x318480 (= v_2_rtt_sample_used $x256901) $x86290 (= v_2_rtt_last_ms ?x27231) (= v_2_rtt_samples (+ v_1_rtt_samples (ite $x256901 1 0))) (= v_2_rto_base_ms (ite $x256901 ?x66085 v_1_rto_base_ms)) $x300873 $x140272 $x188256 $x295627 $x142233 $x10993)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
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
 (= v_0_rx_slot_00 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_01 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_02 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_03 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_04 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_05 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_06 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_07 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_08 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_09 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_10 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_11 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_12 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_13 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_14 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_15 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= 0 v_0_rx_advance))
(assert
 (= v_0_rx_acceptable false))
(assert
 (= v_0_seg_acceptable false))
(assert
 (= 0 v_0_ack_delta))
(assert
 (= v_0_ack_is_new false))
(assert
 (= v_0_ack_is_future false))
(assert
 (= v_0_ack_advance false))
(assert
 (= v_0_ack_window_update false))
(assert
 (= v_0_fin_requested false))
(assert
 (= v_0_fin_sent false))
(assert
 (= (_ bv0 32) v_0_fin_seq))
(assert
 (= v_0_fin_acknowledged false))
(assert
 (= v_0_rx_fin_pending false))
(assert
 (= (_ bv0 32) v_0_rx_fin_seq))
(assert
 (= 0 v_0_rx_fin_offset))
(assert
 (= v_0_rx_fin_done false))
(assert
 (= v_0_rx_fin_consumed false))
(assert
 (= 0.0 v_0_srtt_ms))
(assert
 (= 0.0 v_0_rttvar_ms))
(assert
 (= 0.0 v_0_rtt_error_ms))
(assert
 (= 0.0 v_0_rtt_previous_srtt))
(assert
 (= 0.0 v_0_rtt_previous_var))
(assert
 (= v_0_rtt_measured false))
(assert
 (= v_0_rtt_previous_measured false))
(assert
 (= v_0_rtt_active false))
(assert
 (= v_0_rtt_ambiguous false))
(assert
 (= 0 v_0_rtt_start_ms))
(assert
 (= (_ bv0 32) v_0_rtt_end))
(assert
 (= 0 v_0_rtt_remaining))
(assert
 (= v_0_rtt_start_new false))
(assert
 (= v_0_rtt_sample_used false))
(assert
 (= v_0_rtt_sample_was_ambiguous false))
(assert
 (= 0 v_0_rtt_last_ms))
(assert
 (= 0 v_0_rtt_samples))
(assert
 (= 1000 v_0_rto_base_ms))
(assert
 (= 0 choice_0))
(assert
 (= 0 now_1))
(assert
 (= 4 choice_1))
(assert
 (= 900 now_2))
(assert
 (= (_ bv9000 32) input_1_net.synack_seq))
(assert
 (= (_ bv1001 32) input_1_net.synack_ack))
(assert
 (= 16 input_1_net.synack_window))
(check-sat)
