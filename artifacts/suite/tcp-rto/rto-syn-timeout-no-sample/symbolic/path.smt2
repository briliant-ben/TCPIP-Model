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
(declare-fun v_3_rtt_sample_at_ms () Int)
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
 (let (($x25113 (= due_1_time_wait due_0_time_wait)))
 (let (($x330460 (= due_1_user 30000)))
 (let (($x46576 (= due_1_rtx 1000)))
 (let (($x43220 (not active_1_time_wait)))
 (let (($x16010 (= v_1_rto_base_ms 1000)))
 (let (($x52775 (= v_1_rtt_samples 0)))
 (let (($x177820 (= v_1_rtt_last_ms 0)))
 (let (($x301953 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x63974 (not v_1_rtt_sample_used)))
 (let (($x59934 (= v_1_rtt_remaining 1)))
 (let (($x30073 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x131925 (= v_1_rtt_start_ms 0)))
 (let (($x49686 (= v_1_rtt_sample_at_ms 0)))
 (let (($x217080 (not v_1_rtt_ambiguous)))
 (let (($x10571 (not v_1_rtt_previous_measured)))
 (let (($x77031 (not v_1_rtt_measured)))
 (let (($x176713 (= v_1_rtt_previous_var 0.0)))
 (let (($x333116 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x51415 (= v_1_rtt_error_ms 0.0)))
 (let (($x32294 (= v_1_rttvar_ms 0.0)))
 (let (($x152699 (= v_1_srtt_ms 0.0)))
 (let (($x327357 (not v_1_rx_fin_consumed)))
 (let (($x79050 (not v_1_rx_fin_done)))
 (let (($x182957 (= v_1_rx_fin_offset 0)))
 (let (($x192467 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x66831 (not v_1_rx_fin_pending)))
 (let (($x54343 (not v_1_fin_acknowledged)))
 (let (($x127899 (= v_1_fin_seq (_ bv0 32))))
 (let (($x50513 (not v_1_fin_sent)))
 (let (($x128700 (not v_1_fin_requested)))
 (let (($x74051 (not v_1_ack_window_update)))
 (let (($x31908 (not v_1_ack_advance)))
 (let (($x152307 (not v_1_ack_is_future)))
 (let (($x330492 (not v_1_ack_is_new)))
 (let (($x6769 (= v_1_ack_delta 0)))
 (let (($x43893 (not v_1_seg_acceptable)))
 (let (($x59493 (not v_1_rx_acceptable)))
 (let (($x133390 (= v_1_rx_advance 0)))
 (let (($x159648 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x137098 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x166770 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x44923 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x1945 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x58028 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x28946 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x485 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x5662 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x47613 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x128193 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x214898 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x61164 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x159379 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x60150 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x67270 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x2080 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x58687 (= v_1_take 0)))
 (let (($x160469 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x58148 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x169163 (= v_1_snd_wnd 8)))
 (let (($x134426 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x11369 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x159700 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x33854 (= v_1_local_window 16)))
 (let (($x1959 (= v_1_msl_ms 60000)))
 (let (($x222671 (= v_1_user_timeout_ms 30000)))
 (let (($x161701 (= 0 v_1_retries)))
 (let (($x407068 (= 1000 v_1_rto_ms)))
 (let (($x75912 (= v_1_tx_flags "S")))
 (let (($x160803 (= v_1_tx_ack (_ bv0 32))))
 (let (($x127049 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x320306 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x139509 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x33822 (= v_1_snd_una (_ bv1000 32))))
 (let (($x102386 (= v_1_irs (_ bv0 32))))
 (let (($x217563 (= v_1_iss (_ bv1000 32))))
 (let (($x55001 (= 2 state_1)))
 (let (($x97592 (not active_0_time_wait)))
 (let (($x137009 (or $x97592 (not (<= due_0_time_wait 0)))))
 (let (($x76819 (not active_0_user)))
 (let (($x163950 (or $x76819 (not (<= due_0_user 0)))))
 (let (($x41661 (not active_0_rtx)))
 (let (($x123892 (or $x41661 (not (<= due_0_rtx 0)))))
 (let (($x163498 (= state_0 0)))
 (and $x163498 (>= 0 now_0) $x123892 $x163950 $x137009 $x55001 $x217563 $x102386 $x33822 $x139509 $x320306 $x127049 $x160803 $x75912 $x407068 $x161701 v_1_active_open $x222671 $x1959 $x33854 $x159700 $x11369 $x134426 $x169163 $x58148 $x160469 $x58687 $x2080 $x67270 $x60150 $x159379 $x61164 $x214898 $x128193 $x47613 $x5662 $x485 $x28946 $x58028 $x1945 $x44923 $x166770 $x137098 $x159648 $x133390 $x59493 $x43893 $x6769 $x330492 $x152307 $x31908 $x74051 $x128700 $x50513 $x127899 $x54343 $x66831 $x192467 $x182957 $x79050 $x327357 $x152699 $x32294 $x51415 $x333116 $x176713 $x77031 $x10571 v_1_rtt_active $x217080 $x49686 $x131925 $x30073 $x59934 v_1_rtt_start_new $x63974 $x301953 $x177820 $x52775 $x16010 active_1_rtx active_1_user $x43220 $x46576 $x330460 $x25113)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x172863 (= due_2_time_wait due_1_time_wait)))
 (let (($x54523 (= due_2_user due_1_user)))
 (let (($x129992 (= due_2_rtx (+ 1000 (ite (>= v_1_rto_ms 30000) 60000 (* 2 v_1_rto_ms))))))
 (let (($x155814 (= active_2_time_wait active_1_time_wait)))
 (let (($x223981 (= active_2_user active_1_user)))
 (let (($x34387 (= v_2_rto_base_ms v_1_rto_base_ms)))
 (let (($x55844 (= v_2_rtt_samples v_1_rtt_samples)))
 (let (($x159936 (= v_2_rtt_last_ms v_1_rtt_last_ms)))
 (let (($x320070 (not v_2_rtt_sample_was_ambiguous)))
 (let (($x132379 (not v_2_rtt_sample_used)))
 (let (($x141093 (not v_2_rtt_start_new)))
 (let (($x51357 (= v_2_rtt_remaining v_1_rtt_remaining)))
 (let (($x17364 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x129769 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let (($x97230 (= v_2_rtt_sample_at_ms v_1_rtt_sample_at_ms)))
 (let ((?x128882 (+ (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una))) (* (- 1) v_1_rtt_remaining))))
 (let (($x157186 (= v_2_rtt_ambiguous (or (and v_1_rtt_active (<= ?x128882 0)) v_1_rtt_ambiguous))))
 (let (($x348543 (= v_2_rtt_active v_1_rtt_active)))
 (let (($x17192 (= v_2_rtt_previous_measured v_1_rtt_previous_measured)))
 (let (($x165868 (= v_2_rtt_measured v_1_rtt_measured)))
 (let (($x129931 (= v_2_rtt_previous_var v_1_rtt_previous_var)))
 (let (($x54753 (= v_2_rtt_previous_srtt v_1_rtt_previous_srtt)))
 (let (($x162831 (= v_2_rtt_error_ms v_1_rtt_error_ms)))
 (let (($x50939 (= v_2_rttvar_ms v_1_rttvar_ms)))
 (let (($x52856 (= v_2_srtt_ms v_1_srtt_ms)))
 (let (($x253217 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x20193 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x177832 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x36163 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x202847 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x15863 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x128047 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x130467 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x82098 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x135915 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x163666 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x17112 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x132524 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x141110 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x24639 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x60284 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x210154 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x13929 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x132945 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x349069 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x4183 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x49563 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x21148 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x27380 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x461274 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x50281 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x47969 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x37829 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x28896 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x114380 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x63218 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x112282 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x161827 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x318511 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x116709 (= v_2_take v_1_take)))
 (let (($x51342 (= v_2_snd_wl2 v_1_snd_wl2)))
 (let (($x41785 (= v_2_snd_wl1 v_1_snd_wl1)))
 (let (($x138011 (= v_2_snd_wnd v_1_snd_wnd)))
 (let (($x67658 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x30597 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x194741 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x9246 (= v_2_local_window v_1_local_window)))
 (let (($x55063 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x19435 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x430792 (= v_2_active_open v_1_active_open)))
 (let ((?x165608 (ite (>= v_1_rto_ms 30000) 60000 (* 2 v_1_rto_ms))))
 (let (($x179891 (= v_2_rto_ms ?x165608)))
 (let (($x104547 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x64387 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x32081 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x48626 (= v_2_rcv_nxt v_1_rcv_nxt)))
 (let (($x45305 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x154963 (= v_2_snd_una v_1_snd_una)))
 (let (($x134158 (= v_2_irs v_1_irs)))
 (let (($x61472 (= v_2_iss v_1_iss)))
 (let (($x184799 (= 2 state_2)))
 (let (($x8304 (= state_1 2)))
 (and $x8304 active_1_rtx (= 1000 due_1_rtx) (or (not active_1_user) (<= due_1_rtx due_1_user)) (or (not active_1_time_wait) (<= due_1_rtx due_1_time_wait)) $x184799 $x61472 $x134158 $x154963 $x45305 $x48626 $x32081 $x64387 $x104547 $x179891 (= v_2_retries (+ 1 v_1_retries)) $x430792 $x19435 $x55063 $x9246 $x194741 $x30597 $x67658 $x138011 $x41785 $x51342 $x116709 $x318511 $x161827 $x112282 $x63218 $x114380 $x28896 $x37829 $x47969 $x50281 $x461274 $x27380 $x21148 $x49563 $x4183 $x349069 $x132945 $x13929 $x210154 $x60284 $x24639 $x141110 $x132524 $x17112 $x163666 $x135915 $x82098 $x130467 $x128047 $x15863 $x202847 $x36163 $x177832 $x20193 $x253217 $x52856 $x50939 $x162831 $x54753 $x129931 $x165868 $x17192 $x348543 $x157186 $x97230 $x129769 $x17364 $x51357 $x141093 $x132379 $x320070 $x159936 $x55844 $x34387 active_2_rtx $x223981 $x155814 $x129992 $x54523 $x172863))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 (let (($x38397 (= due_3_time_wait due_2_time_wait)))
 (let (($x348958 (= due_3_user due_2_user)))
 (let (($x172387 (= due_3_rtx due_2_rtx)))
 (let (($x129185 (= active_3_time_wait active_2_time_wait)))
 (let (($x211430 (not active_3_user)))
 (let (($x137632 (not active_3_rtx)))
 (let ((?x21981 (+ 1010 (* (- 1) v_2_rtt_start_ms))))
 (let (($x319886 (not v_2_rtt_ambiguous)))
 (let ((?x165289 (ubv_to_int (bvadd v_2_rtt_end (bvmul (_ bv4294967295 32) v_2_snd_una)))))
 (let ((?x130862 (ubv_to_int (bvadd (_ bv1001 32) (bvmul (_ bv4294967295 32) v_2_snd_una)))))
 (let (($x137545 (>= ?x130862 ?x165289)))
 (let (($x179967 (and v_2_rtt_active $x137545 $x319886)))
 (let ((?x46978 (ite $x179967 ?x21981 v_2_rtt_last_ms)))
 (let ((?x132927 (to_real ?x46978)))
 (let ((?x40945 (+ v_2_srtt_ms (* (- 1.0) ?x132927))))
 (let ((?x132640 (ite $x179967 (ite (>= ?x40945 0.0) ?x40945 (+ (* (- 1.0) v_2_srtt_ms) ?x132927)) v_2_rtt_error_ms)))
 (let ((?x130337 (* (/ 3.0 4.0) v_2_rttvar_ms)))
 (let ((?x58782 (ite $x179967 (ite v_2_rtt_measured (+ ?x130337 (* (/ 1.0 4.0) ?x132640)) (* (/ 1.0 2.0) ?x132927)) v_2_rttvar_ms)))
 (let ((?x67606 (ite v_2_rtt_measured (+ (* (/ 7.0 8.0) v_2_srtt_ms) (* (/ 1.0 8.0) ?x132927)) ?x132927)))
 (let ((?x32750 (ite $x179967 ?x67606 v_2_srtt_ms)))
 (let ((?x133410 (+ (* (- 1.0) ?x32750) (* (- 1.0) (ite (<= ?x58782 (/ 1.0 4.0)) 1.0 (* 4.0 ?x58782))))))
 (let ((?x63282 (to_int ?x133410)))
 (let ((?x180902 (ite (<= ?x63282 (- 1000)) (* (- 1) ?x63282) 1000)))
 (let (($x164912 (= v_3_rto_base_ms (ite $x179967 (ite (<= 60000 ?x180902) 60000 ?x180902) v_2_rto_base_ms))))
 (let (($x20286 (= v_3_rtt_sample_was_ambiguous (and v_2_rtt_active v_2_rtt_ambiguous))))
 (let (($x225018 (not v_3_rtt_start_new)))
 (let ((?x135478 (* (- 1) ?x130862)))
 (let ((?x138911 (+ ?x165289 ?x135478)))
 (let ((?x12535 (ite (and v_2_rtt_active (not (<= v_2_rtt_remaining ?x138911))) ?x138911 v_2_rtt_remaining)))
 (let (($x132510 (and v_2_rtt_active $x137545)))
 (let (($x53301 (= v_3_rtt_end v_2_rtt_end)))
 (let (($x340829 (= v_3_rtt_start_ms v_2_rtt_start_ms)))
 (let (($x137265 (= v_3_rtt_previous_measured (ite $x179967 v_2_rtt_measured v_2_rtt_previous_measured))))
 (let (($x55969 (= v_3_rtt_previous_var (ite $x179967 v_2_rttvar_ms v_2_rtt_previous_var))))
 (let (($x133439 (= v_3_rtt_previous_srtt (ite $x179967 v_2_srtt_ms v_2_rtt_previous_srtt))))
 (let (($x126906 (= v_3_rx_fin_consumed v_2_rx_fin_consumed)))
 (let (($x36986 (= v_3_rx_fin_done v_2_rx_fin_done)))
 (let (($x35810 (= v_3_rx_fin_offset v_2_rx_fin_offset)))
 (let (($x631 (= v_3_rx_fin_seq v_2_rx_fin_seq)))
 (let (($x75236 (= v_3_rx_fin_pending v_2_rx_fin_pending)))
 (let (($x35310 (= v_3_fin_acknowledged v_2_fin_acknowledged)))
 (let (($x73126 (= v_3_fin_seq v_2_fin_seq)))
 (let (($x105161 (= v_3_fin_sent v_2_fin_sent)))
 (let (($x137576 (= v_3_fin_requested v_2_fin_requested)))
 (let (($x62155 (= v_3_ack_window_update v_2_ack_window_update)))
 (let (($x72275 (= v_3_ack_advance v_2_ack_advance)))
 (let (($x340746 (= v_3_ack_is_future v_2_ack_is_future)))
 (let (($x72588 (= v_3_ack_is_new v_2_ack_is_new)))
 (let (($x76369 (= v_3_ack_delta v_2_ack_delta)))
 (let (($x159068 (= v_3_seg_acceptable v_2_seg_acceptable)))
 (let (($x137703 (= v_3_rx_acceptable v_2_rx_acceptable)))
 (let (($x93672 (= v_3_rx_advance v_2_rx_advance)))
 (let (($x18009 (= v_3_rx_slot_15 v_2_rx_slot_15)))
 (let (($x127580 (= v_3_rx_slot_14 v_2_rx_slot_14)))
 (let (($x9634 (= v_3_rx_slot_13 v_2_rx_slot_13)))
 (let (($x11809 (= v_3_rx_slot_12 v_2_rx_slot_12)))
 (let (($x180600 (= v_3_rx_slot_11 v_2_rx_slot_11)))
 (let (($x263311 (= v_3_rx_slot_10 v_2_rx_slot_10)))
 (let (($x464002 (= v_3_rx_slot_09 v_2_rx_slot_09)))
 (let (($x158545 (= v_3_rx_slot_08 v_2_rx_slot_08)))
 (let (($x54534 (= v_3_rx_slot_07 v_2_rx_slot_07)))
 (let (($x68601 (= v_3_rx_slot_06 v_2_rx_slot_06)))
 (let (($x25867 (= v_3_rx_slot_05 v_2_rx_slot_05)))
 (let (($x14321 (= v_3_rx_slot_04 v_2_rx_slot_04)))
 (let (($x58163 (= v_3_rx_slot_03 v_2_rx_slot_03)))
 (let (($x70170 (= v_3_rx_slot_02 v_2_rx_slot_02)))
 (let (($x125418 (= v_3_rx_slot_01 v_2_rx_slot_01)))
 (let (($x48103 (= v_3_rx_slot_00 v_2_rx_slot_00)))
 (let (($x330163 (= v_3_rx_chunk v_2_rx_chunk)))
 (let (($x128721 (= v_3_take v_2_take)))
 (let (($x10073 (= v_3_snd_wl2 (_ bv1001 32))))
 (let (($x73203 (= v_3_snd_wl1 (_ bv9000 32))))
 (let (($x46383 (= v_3_snd_wnd 16)))
 (let (($x66485 (= v_3_rcv_buf v_2_rcv_buf)))
 (let (($x52776 (= v_3_rtx_buf v_2_rtx_buf)))
 (let (($x132388 (= v_3_snd_buf v_2_snd_buf)))
 (let (($x212754 (= v_3_local_window v_2_local_window)))
 (let (($x336914 (= v_3_msl_ms v_2_msl_ms)))
 (let (($x218714 (= v_3_user_timeout_ms v_2_user_timeout_ms)))
 (let (($x131680 (= v_3_active_open v_2_active_open)))
 (let (($x4780 (= v_3_retries v_2_retries)))
 (let (($x18036 (= 3000 v_3_rto_ms)))
 (let (($x140307 (= v_3_tx_flags v_2_tx_flags)))
 (let (($x52945 (= v_3_tx_ack v_2_tx_ack)))
 (let (($x32912 (= v_3_tx_seq v_2_tx_seq)))
 (let (($x77109 (= v_3_rcv_nxt (_ bv9001 32))))
 (let (($x2468 (= v_3_snd_nxt v_2_snd_nxt)))
 (let (($x14879 (= v_3_snd_una (_ bv1001 32))))
 (let (($x331193 (= v_3_irs (_ bv9000 32))))
 (let (($x13576 (= v_3_iss v_2_iss)))
 (let (($x140393 (= 4 state_3)))
 (let (($x471021 (or (not active_2_time_wait) (not (<= due_2_time_wait 1010)))))
 (let (($x165587 (or (not active_2_user) (not (<= due_2_user 1010)))))
 (let (($x183242 (or (not active_2_rtx) (not (<= due_2_rtx 1010)))))
 (let (($x231475 (= 1 v_2_retries)))
 (let (($x173156 (= v_2_snd_nxt (_ bv1001 32))))
 (let (($x129178 (= state_2 2)))
 (and $x129178 $x173156 $x231475 $x183242 $x165587 $x471021 $x140393 $x13576 $x331193 $x14879 $x2468 $x77109 $x32912 $x52945 $x140307 $x18036 $x4780 $x131680 $x218714 $x336914 $x212754 $x132388 $x52776 $x66485 $x46383 $x73203 $x10073 $x128721 $x330163 $x48103 $x125418 $x70170 $x58163 $x14321 $x25867 $x68601 $x54534 $x158545 $x464002 $x263311 $x180600 $x11809 $x9634 $x127580 $x18009 $x93672 $x137703 $x159068 $x76369 $x72588 $x340746 $x72275 $x62155 $x137576 $x105161 $x73126 $x35310 $x75236 $x631 $x35810 $x36986 $x126906 (= v_3_srtt_ms ?x32750) (= v_3_rttvar_ms ?x58782) (= v_3_rtt_error_ms ?x132640) $x133439 $x55969 (= v_3_rtt_measured (or v_2_rtt_measured $x179967)) $x137265 (= v_3_rtt_active (and v_2_rtt_active (not $x132510))) (= v_3_rtt_ambiguous (and (not $x132510) v_2_rtt_ambiguous)) (= v_3_rtt_sample_at_ms (ite $x179967 1010 v_2_rtt_sample_at_ms)) $x340829 $x53301 (= v_3_rtt_remaining (ite $x132510 0 ?x12535)) $x225018 (= v_3_rtt_sample_used $x179967) $x20286 (= v_3_rtt_last_ms ?x46978) (= v_3_rtt_samples (+ v_2_rtt_samples (ite $x179967 1 0))) $x164912 $x137632 $x211430 $x129185 $x172387 $x348958 $x38397)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
