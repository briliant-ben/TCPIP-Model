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
(declare-fun v_1_rtt_sample_at_ms () Int)
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
(declare-fun v_2_rtt_sample_at_ms () Int)
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
(declare-fun v_0_rtt_sample_at_ms () Int)
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
 (let (($x167635 (= due_1_time_wait due_0_time_wait)))
 (let (($x58049 (= due_1_user 30000)))
 (let (($x161288 (= due_1_rtx 1000)))
 (let (($x54363 (not active_1_time_wait)))
 (let (($x153929 (= v_1_rto_base_ms 1000)))
 (let (($x155981 (= v_1_rtt_samples 0)))
 (let (($x13218 (= v_1_rtt_last_ms 0)))
 (let (($x166588 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x23959 (not v_1_rtt_sample_used)))
 (let (($x33927 (= v_1_rtt_remaining 1)))
 (let (($x167975 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x172959 (= v_1_rtt_start_ms 0)))
 (let (($x16821 (= v_1_rtt_sample_at_ms 0)))
 (let (($x145116 (not v_1_rtt_ambiguous)))
 (let (($x6705 (not v_1_rtt_previous_measured)))
 (let (($x161976 (not v_1_rtt_measured)))
 (let (($x159951 (= v_1_rtt_previous_var 0.0)))
 (let (($x12206 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x8538 (= v_1_rtt_error_ms 0.0)))
 (let (($x39470 (= v_1_rttvar_ms 0.0)))
 (let (($x38340 (= v_1_srtt_ms 0.0)))
 (let (($x166824 (not v_1_rx_fin_consumed)))
 (let (($x47307 (not v_1_rx_fin_done)))
 (let (($x55143 (= v_1_rx_fin_offset 0)))
 (let (($x171707 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x169693 (not v_1_rx_fin_pending)))
 (let (($x23475 (not v_1_fin_acknowledged)))
 (let (($x33263 (= v_1_fin_seq (_ bv0 32))))
 (let (($x135289 (not v_1_fin_sent)))
 (let (($x59789 (not v_1_fin_requested)))
 (let (($x1340 (not v_1_ack_window_update)))
 (let (($x295221 (not v_1_ack_advance)))
 (let (($x85385 (not v_1_ack_is_future)))
 (let (($x9721 (not v_1_ack_is_new)))
 (let (($x156351 (= v_1_ack_delta 0)))
 (let (($x19224 (not v_1_seg_acceptable)))
 (let (($x154758 (not v_1_rx_acceptable)))
 (let (($x47764 (= v_1_rx_advance 0)))
 (let (($x47375 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x167318 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x87838 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x149852 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x58927 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x64059 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x44122 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x49295 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x57247 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x11386 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x14499 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x40068 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x133522 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x34845 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x73170 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x44400 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x155194 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x155818 (= v_1_take 0)))
 (let (($x152682 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x157065 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x72630 (= v_1_snd_wnd 8)))
 (let (($x160692 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x160088 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x173844 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x14183 (= v_1_local_window 16)))
 (let (($x136102 (= v_1_msl_ms 60000)))
 (let (($x147092 (= v_1_user_timeout_ms 30000)))
 (let (($x158137 (= 0 v_1_retries)))
 (let (($x35304 (= 1000 v_1_rto_ms)))
 (let (($x136650 (= v_1_tx_flags "S")))
 (let (($x20813 (= v_1_tx_ack (_ bv0 32))))
 (let (($x71004 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x61591 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x160119 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x83256 (= v_1_snd_una (_ bv1000 32))))
 (let (($x87996 (= v_1_irs (_ bv0 32))))
 (let (($x9916 (= v_1_iss (_ bv1000 32))))
 (let (($x160283 (= 2 state_1)))
 (let (($x162471 (not active_0_time_wait)))
 (let (($x77301 (or $x162471 (not (<= due_0_time_wait 0)))))
 (let (($x36849 (not active_0_user)))
 (let (($x167036 (or $x36849 (not (<= due_0_user 0)))))
 (let (($x7449 (not active_0_rtx)))
 (let (($x8938 (or $x7449 (not (<= due_0_rtx 0)))))
 (let (($x157543 (= state_0 0)))
 (and $x157543 (>= 0 now_0) $x8938 $x167036 $x77301 $x160283 $x9916 $x87996 $x83256 $x160119 $x61591 $x71004 $x20813 $x136650 $x35304 $x158137 v_1_active_open $x147092 $x136102 $x14183 $x173844 $x160088 $x160692 $x72630 $x157065 $x152682 $x155818 $x155194 $x44400 $x73170 $x34845 $x133522 $x40068 $x14499 $x11386 $x57247 $x49295 $x44122 $x64059 $x58927 $x149852 $x87838 $x167318 $x47375 $x47764 $x154758 $x19224 $x156351 $x9721 $x85385 $x295221 $x1340 $x59789 $x135289 $x33263 $x23475 $x169693 $x171707 $x55143 $x47307 $x166824 $x38340 $x39470 $x8538 $x12206 $x159951 $x161976 $x6705 v_1_rtt_active $x145116 $x16821 $x172959 $x167975 $x33927 v_1_rtt_start_new $x23959 $x166588 $x13218 $x155981 $x153929 active_1_rtx active_1_user $x54363 $x161288 $x58049 $x167635)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x31937 (= due_2_time_wait due_1_time_wait)))
 (let (($x156207 (= due_2_user due_1_user)))
 (let (($x297269 (= due_2_rtx due_1_rtx)))
 (let (($x33753 (= active_2_time_wait active_1_time_wait)))
 (let (($x37791 (not active_2_user)))
 (let (($x159320 (not active_2_rtx)))
 (let ((?x8350 (+ 900 (* (- 1) v_1_rtt_start_ms))))
 (let (($x145116 (not v_1_rtt_ambiguous)))
 (let ((?x51802 (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let ((?x41823 (ubv_to_int (bvadd (_ bv1001 32) (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let (($x46886 (>= ?x41823 ?x51802)))
 (let (($x41205 (and v_1_rtt_active $x46886 $x145116)))
 (let ((?x57423 (ite $x41205 ?x8350 v_1_rtt_last_ms)))
 (let ((?x137483 (to_real ?x57423)))
 (let ((?x50058 (+ v_1_srtt_ms (* (- 1.0) ?x137483))))
 (let ((?x31360 (ite $x41205 (ite (>= ?x50058 0.0) ?x50058 (+ (* (- 1.0) v_1_srtt_ms) ?x137483)) v_1_rtt_error_ms)))
 (let ((?x36840 (* (/ 3.0 4.0) v_1_rttvar_ms)))
 (let ((?x37887 (ite $x41205 (ite v_1_rtt_measured (+ ?x36840 (* (/ 1.0 4.0) ?x31360)) (* (/ 1.0 2.0) ?x137483)) v_1_rttvar_ms)))
 (let ((?x919 (ite v_1_rtt_measured (+ (* (/ 7.0 8.0) v_1_srtt_ms) (* (/ 1.0 8.0) ?x137483)) ?x137483)))
 (let ((?x6615 (ite $x41205 ?x919 v_1_srtt_ms)))
 (let ((?x153532 (+ (* (- 1.0) ?x6615) (* (- 1.0) (ite (<= ?x37887 (/ 1.0 4.0)) 1.0 (* 4.0 ?x37887))))))
 (let ((?x297392 (to_int ?x153532)))
 (let ((?x12304 (ite (<= ?x297392 (- 1000)) (* (- 1) ?x297392) 1000)))
 (let ((?x92409 (ite (<= 60000 ?x12304) 60000 ?x12304)))
 (let (($x73858 (= v_2_rtt_sample_was_ambiguous (and v_1_rtt_active v_1_rtt_ambiguous))))
 (let (($x185023 (not v_2_rtt_start_new)))
 (let ((?x14530 (* (- 1) ?x41823)))
 (let ((?x14316 (+ ?x51802 ?x14530)))
 (let ((?x138071 (ite (and v_1_rtt_active (not (<= v_1_rtt_remaining ?x14316))) ?x14316 v_1_rtt_remaining)))
 (let (($x153845 (and v_1_rtt_active $x46886)))
 (let (($x2152 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x81107 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let (($x62938 (= v_2_rtt_previous_measured (ite $x41205 v_1_rtt_measured v_1_rtt_previous_measured))))
 (let (($x287296 (= v_2_rtt_previous_var (ite $x41205 v_1_rttvar_ms v_1_rtt_previous_var))))
 (let (($x41830 (= v_2_rtt_previous_srtt (ite $x41205 v_1_srtt_ms v_1_rtt_previous_srtt))))
 (let (($x89071 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x31791 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x158011 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x152090 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x64695 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x295686 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x80505 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x75748 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x15018 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x160415 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x157109 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x2527 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x35007 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x11711 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x150339 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x32175 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x148508 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x159765 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x69230 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x152217 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x61861 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x134881 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x168391 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x167803 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x155322 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x17930 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x167711 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x300658 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x74597 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x168967 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x296709 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x55848 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x158604 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x150332 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x48409 (= v_2_take v_1_take)))
 (let (($x147406 (= v_2_snd_wl2 (_ bv1001 32))))
 (let (($x137216 (= v_2_snd_wl1 (_ bv9000 32))))
 (let (($x34796 (= v_2_snd_wnd 16)))
 (let (($x9583 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x139719 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x136231 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x166385 (= v_2_local_window v_1_local_window)))
 (let (($x9831 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x146309 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x81360 (= v_2_active_open v_1_active_open)))
 (let (($x292277 (= v_2_retries v_1_retries)))
 (let (($x52265 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x158070 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x147200 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x24684 (= v_2_rcv_nxt (_ bv9001 32))))
 (let (($x52960 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x80277 (= v_2_snd_una (_ bv1001 32))))
 (let (($x16988 (= v_2_irs (_ bv9000 32))))
 (let (($x163698 (= v_2_iss v_1_iss)))
 (let (($x54119 (= 4 state_2)))
 (let (($x54363 (not active_1_time_wait)))
 (let (($x33600 (or $x54363 (not (<= due_1_time_wait 900)))))
 (let (($x37705 (or (not active_1_user) (not (<= due_1_user 900)))))
 (let (($x148367 (or (not active_1_rtx) (not (<= due_1_rtx 900)))))
 (let (($x158137 (= 0 v_1_retries)))
 (let (($x160119 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x147029 (= state_1 2)))
 (and $x147029 $x160119 $x158137 $x148367 $x37705 $x33600 $x54119 $x163698 $x16988 $x80277 $x52960 $x24684 $x147200 $x158070 $x52265 (= v_2_rto_ms (ite $x41205 ?x92409 v_1_rto_ms)) $x292277 $x81360 $x146309 $x9831 $x166385 $x136231 $x139719 $x9583 $x34796 $x137216 $x147406 $x48409 $x150332 $x158604 $x55848 $x296709 $x168967 $x74597 $x300658 $x167711 $x17930 $x155322 $x167803 $x168391 $x134881 $x61861 $x152217 $x69230 $x159765 $x148508 $x32175 $x150339 $x11711 $x35007 $x2527 $x157109 $x160415 $x15018 $x75748 $x80505 $x295686 $x64695 $x152090 $x158011 $x31791 $x89071 (= v_2_srtt_ms ?x6615) (= v_2_rttvar_ms ?x37887) (= v_2_rtt_error_ms ?x31360) $x41830 $x287296 (= v_2_rtt_measured (or v_1_rtt_measured $x41205)) $x62938 (= v_2_rtt_active (and v_1_rtt_active (not $x153845))) (= v_2_rtt_ambiguous (and (not $x153845) v_1_rtt_ambiguous)) (= v_2_rtt_sample_at_ms (ite $x41205 900 v_1_rtt_sample_at_ms)) $x81107 $x2152 (= v_2_rtt_remaining (ite $x153845 0 ?x138071)) $x185023 (= v_2_rtt_sample_used $x41205) $x73858 (= v_2_rtt_last_ms ?x57423) (= v_2_rtt_samples (+ v_1_rtt_samples (ite $x41205 1 0))) (= v_2_rto_base_ms (ite $x41205 ?x92409 v_1_rto_base_ms)) $x159320 $x37791 $x33753 $x297269 $x156207 $x31937)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
 (= 0 v_0_rtt_sample_at_ms))
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
