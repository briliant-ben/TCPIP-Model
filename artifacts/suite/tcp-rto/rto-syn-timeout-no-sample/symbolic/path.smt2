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
(declare-fun due_3_time_wait () Int)
(declare-fun due_3_user () Int)
(declare-fun due_3_rtx () Int)
(declare-fun active_3_time_wait () Bool)
(declare-fun active_3_user () Bool)
(declare-fun active_3_rtx () Bool)
(declare-fun v_3_rto_base_ms () Int)
(declare-fun v_3_rtt_samples () Int)
(declare-fun v_3_rtt_last_ms () Int)
(declare-fun v_3_rtt_sample_was_ambiguous () Bool)
(declare-fun v_3_rtt_sample_used () Bool)
(declare-fun v_3_rtt_start_new () Bool)
(declare-fun v_3_rtt_remaining () Int)
(declare-fun v_3_rtt_end () (_ BitVec 32))
(declare-fun v_3_rtt_start_ms () Int)
(declare-fun v_3_rtt_ambiguous () Bool)
(declare-fun v_3_rtt_active () Bool)
(declare-fun v_3_rtt_previous_measured () Bool)
(declare-fun v_3_rtt_measured () Bool)
(declare-fun v_3_rtt_previous_var () Real)
(declare-fun v_3_rtt_previous_srtt () Real)
(declare-fun v_3_rtt_error_ms () Real)
(declare-fun v_3_rttvar_ms () Real)
(declare-fun v_3_srtt_ms () Real)
(declare-fun v_3_rx_fin_consumed () Bool)
(declare-fun v_3_rx_fin_done () Bool)
(declare-fun v_3_rx_fin_offset () Int)
(declare-fun v_3_rx_fin_seq () (_ BitVec 32))
(declare-fun v_3_rx_fin_pending () Bool)
(declare-fun v_3_fin_acknowledged () Bool)
(declare-fun v_3_fin_seq () (_ BitVec 32))
(declare-fun v_3_fin_sent () Bool)
(declare-fun v_3_fin_requested () Bool)
(declare-fun v_3_ack_window_update () Bool)
(declare-fun v_3_ack_advance () Bool)
(declare-fun v_3_ack_is_future () Bool)
(declare-fun v_3_ack_is_new () Bool)
(declare-fun v_3_ack_delta () Int)
(declare-fun v_3_seg_acceptable () Bool)
(declare-fun v_3_rx_acceptable () Bool)
(declare-fun v_3_rx_advance () Int)
(declare-fun v_3_rx_slot_15 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_14 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_13 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_12 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_11 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_10 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_09 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_08 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_07 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_06 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_05 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_04 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_03 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_02 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_01 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_00 () (Seq (_ BitVec 8)))
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
(declare-fun choice_2 () Int)
(declare-fun now_3 () Int)
(declare-fun input_2_net.synack_seq () (_ BitVec 32))
(declare-fun input_2_net.synack_ack () (_ BitVec 32))
(declare-fun input_2_net.synack_window () Int)
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
 (let (($x26683 (= due_1_time_wait due_0_time_wait)))
 (let (($x168563 (= due_1_user 30000)))
 (let (($x306979 (= due_1_rtx 1000)))
 (let (($x313050 (not active_1_time_wait)))
 (let (($x150106 (= v_1_rto_base_ms 1000)))
 (let (($x78144 (= v_1_rtt_samples 0)))
 (let (($x36989 (= v_1_rtt_last_ms 0)))
 (let (($x38728 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x154483 (not v_1_rtt_sample_used)))
 (let (($x145311 (= v_1_rtt_remaining 1)))
 (let (($x286216 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x77088 (= v_1_rtt_start_ms 0)))
 (let (($x85187 (not v_1_rtt_ambiguous)))
 (let (($x107531 (not v_1_rtt_previous_measured)))
 (let (($x155252 (not v_1_rtt_measured)))
 (let (($x6842 (= v_1_rtt_previous_var 0.0)))
 (let (($x134394 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x115862 (= v_1_rtt_error_ms 0.0)))
 (let (($x29125 (= v_1_rttvar_ms 0.0)))
 (let (($x86986 (= v_1_srtt_ms 0.0)))
 (let (($x288854 (not v_1_rx_fin_consumed)))
 (let (($x295456 (not v_1_rx_fin_done)))
 (let (($x280214 (= v_1_rx_fin_offset 0)))
 (let (($x242789 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x65248 (not v_1_rx_fin_pending)))
 (let (($x161875 (not v_1_fin_acknowledged)))
 (let (($x68536 (= v_1_fin_seq (_ bv0 32))))
 (let (($x312471 (not v_1_fin_sent)))
 (let (($x133690 (not v_1_fin_requested)))
 (let (($x177156 (not v_1_ack_window_update)))
 (let (($x300422 (not v_1_ack_advance)))
 (let (($x51641 (not v_1_ack_is_future)))
 (let (($x23973 (not v_1_ack_is_new)))
 (let (($x114278 (= v_1_ack_delta 0)))
 (let (($x53881 (not v_1_seg_acceptable)))
 (let (($x318151 (not v_1_rx_acceptable)))
 (let (($x266609 (= v_1_rx_advance 0)))
 (let (($x418858 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x142973 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x321710 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x36427 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x230297 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x285915 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x150567 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x280259 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x107053 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x294110 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x277173 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x186880 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x290078 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x185274 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x47314 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x269395 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x148525 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x179382 (= v_1_take 0)))
 (let (($x319748 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x291270 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x306284 (= v_1_snd_wnd 8)))
 (let (($x400 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x293872 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x306595 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x311988 (= v_1_local_window 16)))
 (let (($x8401 (= v_1_msl_ms 60000)))
 (let (($x245906 (= v_1_user_timeout_ms 30000)))
 (let (($x1486 (= 0 v_1_retries)))
 (let (($x267126 (= 1000 v_1_rto_ms)))
 (let (($x201498 (= v_1_tx_flags "S")))
 (let (($x135208 (= v_1_tx_ack (_ bv0 32))))
 (let (($x139402 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x66477 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x203759 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x23658 (= v_1_snd_una (_ bv1000 32))))
 (let (($x291020 (= v_1_irs (_ bv0 32))))
 (let (($x301089 (= v_1_iss (_ bv1000 32))))
 (let (($x294871 (= 2 state_1)))
 (let (($x61352 (not active_0_time_wait)))
 (let (($x105595 (or $x61352 (not (<= due_0_time_wait 0)))))
 (let (($x277725 (not active_0_user)))
 (let (($x412525 (or $x277725 (not (<= due_0_user 0)))))
 (let (($x132368 (not active_0_rtx)))
 (let (($x294285 (or $x132368 (not (<= due_0_rtx 0)))))
 (let (($x320812 (= state_0 0)))
 (and $x320812 (>= 0 now_0) $x294285 $x412525 $x105595 $x294871 $x301089 $x291020 $x23658 $x203759 $x66477 $x139402 $x135208 $x201498 $x267126 $x1486 v_1_active_open $x245906 $x8401 $x311988 $x306595 $x293872 $x400 $x306284 $x291270 $x319748 $x179382 $x148525 $x269395 $x47314 $x185274 $x290078 $x186880 $x277173 $x294110 $x107053 $x280259 $x150567 $x285915 $x230297 $x36427 $x321710 $x142973 $x418858 $x266609 $x318151 $x53881 $x114278 $x23973 $x51641 $x300422 $x177156 $x133690 $x312471 $x68536 $x161875 $x65248 $x242789 $x280214 $x295456 $x288854 $x86986 $x29125 $x115862 $x134394 $x6842 $x155252 $x107531 v_1_rtt_active $x85187 $x77088 $x286216 $x145311 v_1_rtt_start_new $x154483 $x38728 $x36989 $x78144 $x150106 active_1_rtx active_1_user $x313050 $x306979 $x168563 $x26683))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 (let (($x158702 (= due_2_time_wait due_1_time_wait)))
 (let (($x277426 (= due_2_user due_1_user)))
 (let (($x417157 (= due_2_rtx (+ 1000 (ite (>= v_1_rto_ms 30000) 60000 (* 2 v_1_rto_ms))))))
 (let (($x84040 (= active_2_time_wait active_1_time_wait)))
 (let (($x105477 (= active_2_user active_1_user)))
 (let (($x261780 (= v_2_rto_base_ms v_1_rto_base_ms)))
 (let (($x222568 (= v_2_rtt_samples v_1_rtt_samples)))
 (let (($x128759 (= v_2_rtt_last_ms v_1_rtt_last_ms)))
 (let (($x141801 (not v_2_rtt_sample_was_ambiguous)))
 (let (($x202724 (not v_2_rtt_sample_used)))
 (let (($x60144 (not v_2_rtt_start_new)))
 (let (($x173328 (= v_2_rtt_remaining v_1_rtt_remaining)))
 (let (($x314060 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x377632 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let ((?x275848 (+ (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una))) (* (- 1) v_1_rtt_remaining))))
 (let (($x407018 (= v_2_rtt_ambiguous (or v_1_rtt_ambiguous (and v_1_rtt_active (<= ?x275848 0))))))
 (let (($x316032 (= v_2_rtt_active v_1_rtt_active)))
 (let (($x101996 (= v_2_rtt_previous_measured v_1_rtt_previous_measured)))
 (let (($x148219 (= v_2_rtt_measured v_1_rtt_measured)))
 (let (($x295125 (= v_2_rtt_previous_var v_1_rtt_previous_var)))
 (let (($x172240 (= v_2_rtt_previous_srtt v_1_rtt_previous_srtt)))
 (let (($x136600 (= v_2_rtt_error_ms v_1_rtt_error_ms)))
 (let (($x297922 (= v_2_rttvar_ms v_1_rttvar_ms)))
 (let (($x276737 (= v_2_srtt_ms v_1_srtt_ms)))
 (let (($x280518 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x316031 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x140322 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x321270 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x279393 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x268339 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x276944 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x168777 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x110347 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x254113 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x276604 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x263460 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x289467 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x7018 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x284925 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x415383 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x95203 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x6708 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x301736 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x106780 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x192685 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x172609 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x169376 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x286738 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x406853 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x272725 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x172432 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x323922 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x306584 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x193319 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x79029 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x240959 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x24281 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x414760 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x11688 (= v_2_take v_1_take)))
 (let (($x145518 (= v_2_snd_wl2 v_1_snd_wl2)))
 (let (($x113838 (= v_2_snd_wl1 v_1_snd_wl1)))
 (let (($x12579 (= v_2_snd_wnd v_1_snd_wnd)))
 (let (($x254737 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x96503 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x305539 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x238665 (= v_2_local_window v_1_local_window)))
 (let (($x294446 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x23691 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x296687 (= v_2_active_open v_1_active_open)))
 (let ((?x181071 (ite (>= v_1_rto_ms 30000) 60000 (* 2 v_1_rto_ms))))
 (let (($x297133 (= v_2_rto_ms ?x181071)))
 (let (($x309129 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x315921 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x297771 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x160255 (= v_2_rcv_nxt v_1_rcv_nxt)))
 (let (($x297249 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x284892 (= v_2_snd_una v_1_snd_una)))
 (let (($x172777 (= v_2_irs v_1_irs)))
 (let (($x162249 (= v_2_iss v_1_iss)))
 (let (($x298450 (= 2 state_2)))
 (let (($x179646 (= state_1 2)))
 (and $x179646 active_1_rtx (= 1000 due_1_rtx) (or (not active_1_user) (<= due_1_rtx due_1_user)) (or (not active_1_time_wait) (<= due_1_rtx due_1_time_wait)) $x298450 $x162249 $x172777 $x284892 $x297249 $x160255 $x297771 $x315921 $x309129 $x297133 (= v_2_retries (+ 1 v_1_retries)) $x296687 $x23691 $x294446 $x238665 $x305539 $x96503 $x254737 $x12579 $x113838 $x145518 $x11688 $x414760 $x24281 $x240959 $x79029 $x193319 $x306584 $x323922 $x172432 $x272725 $x406853 $x286738 $x169376 $x172609 $x192685 $x106780 $x301736 $x6708 $x95203 $x415383 $x284925 $x7018 $x289467 $x263460 $x276604 $x254113 $x110347 $x168777 $x276944 $x268339 $x279393 $x321270 $x140322 $x316031 $x280518 $x276737 $x297922 $x136600 $x172240 $x295125 $x148219 $x101996 $x316032 $x407018 $x377632 $x314060 $x173328 $x60144 $x202724 $x141801 $x128759 $x222568 $x261780 active_2_rtx $x105477 $x84040 $x417157 $x277426 $x158702)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x3730 (= due_3_time_wait due_2_time_wait)))
 (let (($x284630 (= due_3_user due_2_user)))
 (let (($x258640 (= due_3_rtx due_2_rtx)))
 (let (($x10716 (= active_3_time_wait active_2_time_wait)))
 (let (($x154799 (not active_3_user)))
 (let (($x133346 (not active_3_rtx)))
 (let ((?x257526 (+ 1010 (* (- 1) v_2_rtt_start_ms))))
 (let (($x71136 (not v_2_rtt_ambiguous)))
 (let ((?x850 (ubv_to_int (bvadd v_2_rtt_end (bvmul (_ bv4294967295 32) v_2_snd_una)))))
 (let ((?x264931 (ubv_to_int (bvadd (_ bv1001 32) (bvmul (_ bv4294967295 32) v_2_snd_una)))))
 (let (($x76938 (>= ?x264931 ?x850)))
 (let (($x125437 (and v_2_rtt_active $x76938 $x71136)))
 (let ((?x307561 (ite $x125437 ?x257526 v_2_rtt_last_ms)))
 (let ((?x111923 (to_real ?x307561)))
 (let ((?x276225 (+ v_2_srtt_ms (* (- 1.0) ?x111923))))
 (let ((?x30831 (ite $x125437 (ite (>= ?x276225 0.0) ?x276225 (+ (* (- 1.0) v_2_srtt_ms) ?x111923)) v_2_rtt_error_ms)))
 (let ((?x303573 (* (/ 3.0 4.0) v_2_rttvar_ms)))
 (let ((?x322223 (ite $x125437 (ite v_2_rtt_measured (+ ?x303573 (* (/ 1.0 4.0) ?x30831)) (* (/ 1.0 2.0) ?x111923)) v_2_rttvar_ms)))
 (let ((?x248175 (ite v_2_rtt_measured (+ (* (/ 7.0 8.0) v_2_srtt_ms) (* (/ 1.0 8.0) ?x111923)) ?x111923)))
 (let ((?x318744 (ite $x125437 ?x248175 v_2_srtt_ms)))
 (let ((?x61889 (+ (* (- 1.0) ?x318744) (* (- 1.0) (ite (<= ?x322223 (/ 1.0 4.0)) 1.0 (* 4.0 ?x322223))))))
 (let ((?x263697 (to_int ?x61889)))
 (let ((?x18378 (ite (<= ?x263697 (- 1000)) (* (- 1) ?x263697) 1000)))
 (let (($x303735 (= v_3_rto_base_ms (ite $x125437 (ite (<= 60000 ?x18378) 60000 ?x18378) v_2_rto_base_ms))))
 (let (($x308406 (= v_3_rtt_sample_was_ambiguous (and v_2_rtt_active v_2_rtt_ambiguous))))
 (let (($x100797 (not v_3_rtt_start_new)))
 (let ((?x319402 (* (- 1) ?x264931)))
 (let ((?x276094 (+ ?x850 ?x319402)))
 (let ((?x175959 (ite (and v_2_rtt_active (not (<= v_2_rtt_remaining ?x276094))) ?x276094 v_2_rtt_remaining)))
 (let (($x279010 (and v_2_rtt_active $x76938)))
 (let (($x84759 (= v_3_rtt_end v_2_rtt_end)))
 (let (($x85182 (= v_3_rtt_start_ms v_2_rtt_start_ms)))
 (let (($x276382 (= v_3_rtt_previous_measured (ite $x125437 v_2_rtt_measured v_2_rtt_previous_measured))))
 (let (($x263064 (= v_3_rtt_previous_var (ite $x125437 v_2_rttvar_ms v_2_rtt_previous_var))))
 (let (($x127003 (= v_3_rtt_previous_srtt (ite $x125437 v_2_srtt_ms v_2_rtt_previous_srtt))))
 (let (($x95464 (= v_3_rx_fin_consumed v_2_rx_fin_consumed)))
 (let (($x312560 (= v_3_rx_fin_done v_2_rx_fin_done)))
 (let (($x92260 (= v_3_rx_fin_offset v_2_rx_fin_offset)))
 (let (($x274651 (= v_3_rx_fin_seq v_2_rx_fin_seq)))
 (let (($x318070 (= v_3_rx_fin_pending v_2_rx_fin_pending)))
 (let (($x86983 (= v_3_fin_acknowledged v_2_fin_acknowledged)))
 (let (($x113099 (= v_3_fin_seq v_2_fin_seq)))
 (let (($x38052 (= v_3_fin_sent v_2_fin_sent)))
 (let (($x312043 (= v_3_fin_requested v_2_fin_requested)))
 (let (($x294808 (= v_3_ack_window_update v_2_ack_window_update)))
 (let (($x271234 (= v_3_ack_advance v_2_ack_advance)))
 (let (($x99315 (= v_3_ack_is_future v_2_ack_is_future)))
 (let (($x226773 (= v_3_ack_is_new v_2_ack_is_new)))
 (let (($x273824 (= v_3_ack_delta v_2_ack_delta)))
 (let (($x2126 (= v_3_seg_acceptable v_2_seg_acceptable)))
 (let (($x31915 (= v_3_rx_acceptable v_2_rx_acceptable)))
 (let (($x273432 (= v_3_rx_advance v_2_rx_advance)))
 (let (($x97889 (= v_3_rx_slot_15 v_2_rx_slot_15)))
 (let (($x74047 (= v_3_rx_slot_14 v_2_rx_slot_14)))
 (let (($x282089 (= v_3_rx_slot_13 v_2_rx_slot_13)))
 (let (($x66666 (= v_3_rx_slot_12 v_2_rx_slot_12)))
 (let (($x282453 (= v_3_rx_slot_11 v_2_rx_slot_11)))
 (let (($x282479 (= v_3_rx_slot_10 v_2_rx_slot_10)))
 (let (($x290932 (= v_3_rx_slot_09 v_2_rx_slot_09)))
 (let (($x114042 (= v_3_rx_slot_08 v_2_rx_slot_08)))
 (let (($x83274 (= v_3_rx_slot_07 v_2_rx_slot_07)))
 (let (($x125646 (= v_3_rx_slot_06 v_2_rx_slot_06)))
 (let (($x296806 (= v_3_rx_slot_05 v_2_rx_slot_05)))
 (let (($x256958 (= v_3_rx_slot_04 v_2_rx_slot_04)))
 (let (($x315247 (= v_3_rx_slot_03 v_2_rx_slot_03)))
 (let (($x301729 (= v_3_rx_slot_02 v_2_rx_slot_02)))
 (let (($x209690 (= v_3_rx_slot_01 v_2_rx_slot_01)))
 (let (($x298608 (= v_3_rx_slot_00 v_2_rx_slot_00)))
 (let (($x211462 (= v_3_rx_chunk v_2_rx_chunk)))
 (let (($x120373 (= v_3_take v_2_take)))
 (let (($x111154 (= v_3_snd_wl2 (_ bv1001 32))))
 (let (($x225809 (= v_3_snd_wl1 (_ bv9000 32))))
 (let (($x77623 (= v_3_snd_wnd 16)))
 (let (($x125818 (= v_3_rcv_buf v_2_rcv_buf)))
 (let (($x285801 (= v_3_rtx_buf v_2_rtx_buf)))
 (let (($x145677 (= v_3_snd_buf v_2_snd_buf)))
 (let (($x167848 (= v_3_local_window v_2_local_window)))
 (let (($x298139 (= v_3_msl_ms v_2_msl_ms)))
 (let (($x290520 (= v_3_user_timeout_ms v_2_user_timeout_ms)))
 (let (($x109704 (= v_3_active_open v_2_active_open)))
 (let (($x88769 (= v_3_retries v_2_retries)))
 (let (($x247203 (= 3000 v_3_rto_ms)))
 (let (($x56197 (= v_3_tx_flags v_2_tx_flags)))
 (let (($x54050 (= v_3_tx_ack v_2_tx_ack)))
 (let (($x17051 (= v_3_tx_seq v_2_tx_seq)))
 (let (($x234380 (= v_3_rcv_nxt (_ bv9001 32))))
 (let (($x84543 (= v_3_snd_nxt v_2_snd_nxt)))
 (let (($x348461 (= v_3_snd_una (_ bv1001 32))))
 (let (($x129593 (= v_3_irs (_ bv9000 32))))
 (let (($x98002 (= v_3_iss v_2_iss)))
 (let (($x237800 (= 4 state_3)))
 (let (($x72354 (or (not active_2_time_wait) (not (<= due_2_time_wait 1010)))))
 (let (($x76017 (or (not active_2_user) (not (<= due_2_user 1010)))))
 (let (($x143094 (or (not active_2_rtx) (not (<= due_2_rtx 1010)))))
 (let (($x243215 (= 1 v_2_retries)))
 (let (($x107824 (= v_2_snd_nxt (_ bv1001 32))))
 (let (($x302089 (= state_2 2)))
 (and $x302089 $x107824 $x243215 $x143094 $x76017 $x72354 $x237800 $x98002 $x129593 $x348461 $x84543 $x234380 $x17051 $x54050 $x56197 $x247203 $x88769 $x109704 $x290520 $x298139 $x167848 $x145677 $x285801 $x125818 $x77623 $x225809 $x111154 $x120373 $x211462 $x298608 $x209690 $x301729 $x315247 $x256958 $x296806 $x125646 $x83274 $x114042 $x290932 $x282479 $x282453 $x66666 $x282089 $x74047 $x97889 $x273432 $x31915 $x2126 $x273824 $x226773 $x99315 $x271234 $x294808 $x312043 $x38052 $x113099 $x86983 $x318070 $x274651 $x92260 $x312560 $x95464 (= v_3_srtt_ms ?x318744) (= v_3_rttvar_ms ?x322223) (= v_3_rtt_error_ms ?x30831) $x127003 $x263064 (= v_3_rtt_measured (or v_2_rtt_measured $x125437)) $x276382 (= v_3_rtt_active (and v_2_rtt_active (not $x279010))) (= v_3_rtt_ambiguous (and (not $x279010) v_2_rtt_ambiguous)) $x85182 $x84759 (= v_3_rtt_remaining (ite $x279010 0 ?x175959)) $x100797 (= v_3_rtt_sample_used $x125437) $x308406 (= v_3_rtt_last_ms ?x307561) (= v_3_rtt_samples (+ v_2_rtt_samples (ite $x125437 1 0))) $x303735 $x133346 $x154799 $x10716 $x258640 $x284630 $x3730)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
 (= 27 choice_1))
(assert
 (= 1000 now_2))
(assert
 (= 7 choice_2))
(assert
 (= 1010 now_3))
(assert
 (= (_ bv9000 32) input_2_net.synack_seq))
(assert
 (= (_ bv1001 32) input_2_net.synack_ack))
(assert
 (= 16 input_2_net.synack_window))
(check-sat)
