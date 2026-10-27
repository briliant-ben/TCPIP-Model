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
(declare-fun active_0_delack () Bool)
(declare-fun due_0_delack () Int)
(declare-fun due_1_delack () Int)
(declare-fun due_1_time_wait () Int)
(declare-fun due_1_user () Int)
(declare-fun due_1_rtx () Int)
(declare-fun active_1_delack () Bool)
(declare-fun active_1_time_wait () Bool)
(declare-fun active_1_user () Bool)
(declare-fun active_1_rtx () Bool)
(declare-fun v_1_ack_defer_now () Bool)
(declare-fun v_1_ack_defer_candidate () Bool)
(declare-fun v_1_ack_rmss () Int)
(declare-fun v_1_ack_delay_ms () Int)
(declare-fun v_1_ack_full_segments () Int)
(declare-fun v_1_ack_bytes () Int)
(declare-fun v_1_ack_since_ms () Int)
(declare-fun v_1_ack_pending () Bool)
(declare-fun v_1_syn_timeout_eligible () Bool)
(declare-fun v_1_tx_syn_pending () Bool)
(declare-fun v_1_tx_syn_time () Int)
(declare-fun v_1_tx_waiting () Bool)
(declare-fun v_1_tx_is_fin () Bool)
(declare-fun v_1_tx_previous_rto () Int)
(declare-fun v_1_tx_elapsed () Int)
(declare-fun v_1_tx_retransmitted () Bool)
(declare-fun v_1_tx_max_previous () Int)
(declare-fun v_1_tx_eligible () Int)
(declare-fun v_1_tx_emit_count () Int)
(declare-fun v_1_tx_fin_time () Int)
(declare-fun v_1_tx_time_15 () Int)
(declare-fun v_1_tx_time_14 () Int)
(declare-fun v_1_tx_time_13 () Int)
(declare-fun v_1_tx_time_12 () Int)
(declare-fun v_1_tx_time_11 () Int)
(declare-fun v_1_tx_time_10 () Int)
(declare-fun v_1_tx_time_09 () Int)
(declare-fun v_1_tx_time_08 () Int)
(declare-fun v_1_tx_time_07 () Int)
(declare-fun v_1_tx_time_06 () Int)
(declare-fun v_1_tx_time_05 () Int)
(declare-fun v_1_tx_time_04 () Int)
(declare-fun v_1_tx_time_03 () Int)
(declare-fun v_1_tx_time_02 () Int)
(declare-fun v_1_tx_time_01 () Int)
(declare-fun v_1_tx_time_00 () Int)
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
(declare-fun due_2_delack () Int)
(declare-fun due_2_time_wait () Int)
(declare-fun due_2_user () Int)
(declare-fun due_2_rtx () Int)
(declare-fun active_2_delack () Bool)
(declare-fun active_2_time_wait () Bool)
(declare-fun active_2_user () Bool)
(declare-fun active_2_rtx () Bool)
(declare-fun v_2_ack_defer_now () Bool)
(declare-fun v_2_ack_defer_candidate () Bool)
(declare-fun v_2_ack_rmss () Int)
(declare-fun v_2_ack_delay_ms () Int)
(declare-fun v_2_ack_full_segments () Int)
(declare-fun v_2_ack_bytes () Int)
(declare-fun v_2_ack_since_ms () Int)
(declare-fun v_2_ack_pending () Bool)
(declare-fun v_2_syn_timeout_eligible () Bool)
(declare-fun v_2_tx_syn_pending () Bool)
(declare-fun v_2_tx_syn_time () Int)
(declare-fun v_2_tx_waiting () Bool)
(declare-fun v_2_tx_is_fin () Bool)
(declare-fun v_2_tx_previous_rto () Int)
(declare-fun v_2_tx_elapsed () Int)
(declare-fun v_2_tx_retransmitted () Bool)
(declare-fun v_2_tx_max_previous () Int)
(declare-fun v_2_tx_eligible () Int)
(declare-fun v_2_tx_emit_count () Int)
(declare-fun v_2_tx_fin_time () Int)
(declare-fun v_2_tx_time_15 () Int)
(declare-fun v_2_tx_time_14 () Int)
(declare-fun v_2_tx_time_13 () Int)
(declare-fun v_2_tx_time_12 () Int)
(declare-fun v_2_tx_time_11 () Int)
(declare-fun v_2_tx_time_10 () Int)
(declare-fun v_2_tx_time_09 () Int)
(declare-fun v_2_tx_time_08 () Int)
(declare-fun v_2_tx_time_07 () Int)
(declare-fun v_2_tx_time_06 () Int)
(declare-fun v_2_tx_time_05 () Int)
(declare-fun v_2_tx_time_04 () Int)
(declare-fun v_2_tx_time_03 () Int)
(declare-fun v_2_tx_time_02 () Int)
(declare-fun v_2_tx_time_01 () Int)
(declare-fun v_2_tx_time_00 () Int)
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
(declare-fun v_0_tx_time_00 () Int)
(declare-fun v_0_tx_time_01 () Int)
(declare-fun v_0_tx_time_02 () Int)
(declare-fun v_0_tx_time_03 () Int)
(declare-fun v_0_tx_time_04 () Int)
(declare-fun v_0_tx_time_05 () Int)
(declare-fun v_0_tx_time_06 () Int)
(declare-fun v_0_tx_time_07 () Int)
(declare-fun v_0_tx_time_08 () Int)
(declare-fun v_0_tx_time_09 () Int)
(declare-fun v_0_tx_time_10 () Int)
(declare-fun v_0_tx_time_11 () Int)
(declare-fun v_0_tx_time_12 () Int)
(declare-fun v_0_tx_time_13 () Int)
(declare-fun v_0_tx_time_14 () Int)
(declare-fun v_0_tx_time_15 () Int)
(declare-fun v_0_tx_fin_time () Int)
(declare-fun v_0_tx_emit_count () Int)
(declare-fun v_0_tx_eligible () Int)
(declare-fun v_0_tx_max_previous () Int)
(declare-fun v_0_tx_retransmitted () Bool)
(declare-fun v_0_tx_elapsed () Int)
(declare-fun v_0_tx_previous_rto () Int)
(declare-fun v_0_tx_is_fin () Bool)
(declare-fun v_0_tx_waiting () Bool)
(declare-fun v_0_tx_syn_time () Int)
(declare-fun v_0_tx_syn_pending () Bool)
(declare-fun v_0_syn_timeout_eligible () Bool)
(declare-fun v_0_ack_pending () Bool)
(declare-fun v_0_ack_since_ms () Int)
(declare-fun v_0_ack_bytes () Int)
(declare-fun v_0_ack_full_segments () Int)
(declare-fun v_0_ack_delay_ms () Int)
(declare-fun v_0_ack_rmss () Int)
(declare-fun v_0_ack_defer_candidate () Bool)
(declare-fun v_0_ack_defer_now () Bool)
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
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
 (not active_0_delack))
(assert
 (= due_0_delack 0))
(assert
 true)
(assert
 (let (($x264770 (= due_1_delack due_0_delack)))
 (let (($x72622 (= due_1_time_wait due_0_time_wait)))
 (let (($x632305 (= due_1_user 30000)))
 (let (($x173096 (= due_1_rtx 1000)))
 (let (($x870505 (not active_1_delack)))
 (let (($x17756 (not active_1_time_wait)))
 (let (($x711822 (not v_1_ack_defer_now)))
 (let (($x67088 (not v_1_ack_defer_candidate)))
 (let (($x414460 (= v_1_ack_rmss 4)))
 (let (($x423701 (= v_1_ack_delay_ms 40)))
 (let (($x32055 (= 0 v_1_ack_full_segments)))
 (let (($x517510 (= 0 v_1_ack_bytes)))
 (let (($x602002 (= 0 v_1_ack_since_ms)))
 (let (($x219440 (not v_1_ack_pending)))
 (let (($x57887 (not v_1_syn_timeout_eligible)))
 (let (($x637681 (= v_1_tx_syn_time 0)))
 (let (($x489693 (not v_1_tx_waiting)))
 (let (($x609326 (not v_1_tx_is_fin)))
 (let (($x834903 (= v_1_tx_previous_rto 1000)))
 (let (($x183244 (= v_1_tx_elapsed 0)))
 (let (($x439969 (not v_1_tx_retransmitted)))
 (let (($x14028 (= v_1_tx_max_previous 0)))
 (let (($x297030 (= v_1_tx_eligible 0)))
 (let (($x506236 (= v_1_tx_emit_count 0)))
 (let (($x338494 (= v_1_tx_fin_time 0)))
 (let (($x487059 (= v_1_tx_time_15 0)))
 (let (($x400909 (= v_1_tx_time_14 0)))
 (let (($x308441 (= v_1_tx_time_13 0)))
 (let (($x332966 (= v_1_tx_time_12 0)))
 (let (($x50895 (= v_1_tx_time_11 0)))
 (let (($x279527 (= v_1_tx_time_10 0)))
 (let (($x213452 (= v_1_tx_time_09 0)))
 (let (($x848585 (= v_1_tx_time_08 0)))
 (let (($x195448 (= v_1_tx_time_07 0)))
 (let (($x306550 (= v_1_tx_time_06 0)))
 (let (($x530098 (= v_1_tx_time_05 0)))
 (let (($x78511 (= v_1_tx_time_04 0)))
 (let (($x637616 (= v_1_tx_time_03 0)))
 (let (($x191842 (= v_1_tx_time_02 0)))
 (let (($x663212 (= v_1_tx_time_01 0)))
 (let (($x310820 (= v_1_tx_time_00 0)))
 (let (($x99232 (= v_1_rto_base_ms 1000)))
 (let (($x29855 (= v_1_rtt_samples 0)))
 (let (($x146709 (= v_1_rtt_last_ms 0)))
 (let (($x480021 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x820266 (not v_1_rtt_sample_used)))
 (let (($x43951 (= v_1_rtt_remaining 1)))
 (let (($x313352 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x558676 (= v_1_rtt_start_ms 0)))
 (let (($x609033 (= v_1_rtt_sample_at_ms 0)))
 (let (($x601721 (not v_1_rtt_ambiguous)))
 (let (($x610330 (not v_1_rtt_previous_measured)))
 (let (($x602815 (not v_1_rtt_measured)))
 (let (($x634278 (= v_1_rtt_previous_var 0.0)))
 (let (($x495015 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x137270 (= v_1_rtt_error_ms 0.0)))
 (let (($x276749 (= v_1_rttvar_ms 0.0)))
 (let (($x519360 (= v_1_srtt_ms 0.0)))
 (let (($x362941 (not v_1_rx_fin_consumed)))
 (let (($x499230 (not v_1_rx_fin_done)))
 (let (($x439991 (= v_1_rx_fin_offset 0)))
 (let (($x195298 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x10784 (not v_1_rx_fin_pending)))
 (let (($x874825 (not v_1_fin_acknowledged)))
 (let (($x635692 (= v_1_fin_seq (_ bv0 32))))
 (let (($x8722 (not v_1_fin_sent)))
 (let (($x283927 (not v_1_fin_requested)))
 (let (($x678429 (not v_1_ack_window_update)))
 (let (($x391332 (not v_1_ack_advance)))
 (let (($x172101 (not v_1_ack_is_future)))
 (let (($x176230 (not v_1_ack_is_new)))
 (let (($x223287 (= v_1_ack_delta 0)))
 (let (($x32773 (not v_1_seg_acceptable)))
 (let (($x653359 (not v_1_rx_acceptable)))
 (let (($x168759 (= v_1_rx_advance 0)))
 (let (($x3834 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x224619 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x426575 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x602191 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x819350 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x61349 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x628501 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x638289 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x164336 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x874766 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x7311 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x861699 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x604184 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x266499 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x218016 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x138057 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x498858 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x3290 (= v_1_take 0)))
 (let (($x549529 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x494616 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x601544 (= v_1_snd_wnd 8)))
 (let (($x446529 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x471124 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x853749 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x173149 (= v_1_local_window 16)))
 (let (($x647321 (= v_1_msl_ms 60000)))
 (let (($x647366 (= v_1_user_timeout_ms 30000)))
 (let (($x73094 (= 0 v_1_retries)))
 (let (($x339258 (= 1000 v_1_rto_ms)))
 (let (($x95385 (= v_1_tx_flags "S")))
 (let (($x601835 (= v_1_tx_ack (_ bv0 32))))
 (let (($x28680 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x156454 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x303038 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x331127 (= v_1_snd_una (_ bv1000 32))))
 (let (($x602614 (= v_1_irs (_ bv0 32))))
 (let (($x602817 (= v_1_iss (_ bv1000 32))))
 (let (($x77923 (= 2 state_1)))
 (let (($x444152 (not active_0_delack)))
 (let (($x858371 (or $x444152 (not (<= due_0_delack 0)))))
 (let (($x284844 (not active_0_time_wait)))
 (let (($x39338 (or $x284844 (not (<= due_0_time_wait 0)))))
 (let (($x506407 (not active_0_user)))
 (let (($x602710 (or $x506407 (not (<= due_0_user 0)))))
 (let (($x652884 (not active_0_rtx)))
 (let (($x638831 (or $x652884 (not (<= due_0_rtx 0)))))
 (let (($x255939 (= state_0 0)))
 (and $x255939 (>= 0 now_0) $x638831 $x602710 $x39338 $x858371 $x77923 $x602817 $x602614 $x331127 $x303038 $x156454 $x28680 $x601835 $x95385 $x339258 $x73094 v_1_active_open $x647366 $x647321 $x173149 $x853749 $x471124 $x446529 $x601544 $x494616 $x549529 $x3290 $x498858 $x138057 $x218016 $x266499 $x604184 $x861699 $x7311 $x874766 $x164336 $x638289 $x628501 $x61349 $x819350 $x602191 $x426575 $x224619 $x3834 $x168759 $x653359 $x32773 $x223287 $x176230 $x172101 $x391332 $x678429 $x283927 $x8722 $x635692 $x874825 $x10784 $x195298 $x439991 $x499230 $x362941 $x519360 $x276749 $x137270 $x495015 $x634278 $x602815 $x610330 v_1_rtt_active $x601721 $x609033 $x558676 $x313352 $x43951 v_1_rtt_start_new $x820266 $x480021 $x146709 $x29855 $x99232 $x310820 $x663212 $x191842 $x637616 $x78511 $x530098 $x306550 $x195448 $x848585 $x213452 $x279527 $x50895 $x332966 $x308441 $x400909 $x487059 $x338494 $x506236 $x297030 $x14028 $x439969 $x183244 $x834903 $x609326 $x489693 $x637681 v_1_tx_syn_pending $x57887 $x219440 $x602002 $x517510 $x32055 $x423701 $x414460 $x67088 $x711822 active_1_rtx active_1_user $x17756 $x870505 $x173096 $x632305 $x72622 $x264770))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x44366 (= due_2_delack due_1_delack)))
 (let (($x248931 (= due_2_time_wait due_1_time_wait)))
 (let (($x346612 (= due_2_user due_1_user)))
 (let (($x143501 (= due_2_rtx due_1_rtx)))
 (let (($x343711 (not active_2_delack)))
 (let (($x602349 (= active_2_time_wait active_1_time_wait)))
 (let (($x823823 (not active_2_user)))
 (let (($x299462 (not active_2_rtx)))
 (let (($x308244 (not v_2_ack_defer_now)))
 (let (($x600991 (not v_2_ack_defer_candidate)))
 (let (($x823230 (= v_2_ack_rmss v_1_ack_rmss)))
 (let (($x134753 (= v_2_ack_delay_ms v_1_ack_delay_ms)))
 (let (($x339883 (= v_2_ack_full_segments 0)))
 (let (($x338518 (= v_2_ack_bytes 0)))
 (let (($x478853 (= v_2_ack_since_ms 0)))
 (let (($x395208 (not v_2_ack_pending)))
 (let (($x604432 (not v_2_syn_timeout_eligible)))
 (let (($x601193 (not v_2_tx_syn_pending)))
 (let (($x439545 (= v_2_tx_syn_time 0)))
 (let (($x8215 (not v_2_tx_waiting)))
 (let (($x40990 (= v_2_tx_is_fin v_1_tx_is_fin)))
 (let (($x78671 (= v_2_tx_previous_rto v_1_tx_previous_rto)))
 (let (($x605365 (= v_2_tx_elapsed v_1_tx_elapsed)))
 (let (($x134163 (not v_2_tx_retransmitted)))
 (let (($x243451 (= v_2_tx_max_previous v_1_tx_max_previous)))
 (let (($x604844 (= v_2_tx_eligible v_1_tx_eligible)))
 (let (($x183178 (= v_2_tx_emit_count v_1_tx_emit_count)))
 (let ((?x203971 (ite (and v_1_fin_sent (not v_1_fin_acknowledged)) v_1_tx_fin_time 0)))
 (let (($x438347 (= v_2_tx_fin_time ?x203971)))
 (let (($x317023 (= v_2_tx_time_15 (ite (>= 15 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_15))))
 (let (($x459951 (= v_2_tx_time_14 (ite (>= 14 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_14))))
 (let (($x262245 (= v_2_tx_time_13 (ite (>= 13 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_13))))
 (let (($x36112 (= v_2_tx_time_12 (ite (>= 12 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_12))))
 (let (($x547216 (= v_2_tx_time_11 (ite (>= 11 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_11))))
 (let (($x307962 (= v_2_tx_time_10 (ite (>= 10 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_10))))
 (let (($x298737 (= v_2_tx_time_09 (ite (>= 9 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_09))))
 (let (($x604454 (= v_2_tx_time_08 (ite (>= 8 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_08))))
 (let (($x826557 (= v_2_tx_time_07 (ite (>= 7 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_07))))
 (let (($x602807 (= v_2_tx_time_06 (ite (>= 6 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_06))))
 (let (($x373952 (= v_2_tx_time_05 (ite (>= 5 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_05))))
 (let (($x35171 (= v_2_tx_time_04 (ite (>= 4 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_04))))
 (let (($x301827 (= v_2_tx_time_03 (ite (>= 3 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_03))))
 (let (($x229833 (= v_2_tx_time_02 (ite (>= 2 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_02))))
 (let (($x304627 (= v_2_tx_time_01 (ite (>= 1 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_01))))
 (let (($x524165 (= v_2_tx_time_00 (ite (>= 0 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_00))))
 (let ((?x470768 (+ 900 (* (- 1) v_1_rtt_start_ms))))
 (let (($x601721 (not v_1_rtt_ambiguous)))
 (let ((?x643075 (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let ((?x307680 (ubv_to_int (bvadd (_ bv1001 32) (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let (($x313695 (>= ?x307680 ?x643075)))
 (let (($x601633 (and v_1_rtt_active $x313695 $x601721)))
 (let ((?x632254 (ite $x601633 ?x470768 v_1_rtt_last_ms)))
 (let ((?x603203 (to_real ?x632254)))
 (let ((?x263206 (+ v_1_srtt_ms (* (- 1.0) ?x603203))))
 (let ((?x829337 (ite $x601633 (ite (>= ?x263206 0.0) ?x263206 (+ (* (- 1.0) v_1_srtt_ms) ?x603203)) v_1_rtt_error_ms)))
 (let ((?x33897 (* (/ 3.0 4.0) v_1_rttvar_ms)))
 (let ((?x76508 (ite $x601633 (ite v_1_rtt_measured (+ ?x33897 (* (/ 1.0 4.0) ?x829337)) (* (/ 1.0 2.0) ?x603203)) v_1_rttvar_ms)))
 (let ((?x458196 (ite v_1_rtt_measured (+ (* (/ 7.0 8.0) v_1_srtt_ms) (* (/ 1.0 8.0) ?x603203)) ?x603203)))
 (let ((?x211807 (ite $x601633 ?x458196 v_1_srtt_ms)))
 (let ((?x24446 (+ (* (- 1.0) ?x211807) (* (- 1.0) (ite (<= ?x76508 (/ 1.0 4.0)) 1.0 (* 4.0 ?x76508))))))
 (let ((?x180197 (to_int ?x24446)))
 (let ((?x179102 (ite (<= ?x180197 (- 1000)) (* (- 1) ?x180197) 1000)))
 (let ((?x182538 (ite (<= 60000 ?x179102) 60000 ?x179102)))
 (let (($x34645 (= v_2_rtt_sample_was_ambiguous (and v_1_rtt_active v_1_rtt_ambiguous))))
 (let (($x635970 (not v_2_rtt_start_new)))
 (let ((?x215765 (* (- 1) ?x307680)))
 (let ((?x562942 (+ ?x643075 ?x215765)))
 (let ((?x447601 (ite (and v_1_rtt_active (not (<= v_1_rtt_remaining ?x562942))) ?x562942 v_1_rtt_remaining)))
 (let (($x274621 (and v_1_rtt_active $x313695)))
 (let (($x525517 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x282120 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let (($x287549 (= v_2_rtt_previous_measured (ite $x601633 v_1_rtt_measured v_1_rtt_previous_measured))))
 (let (($x873251 (= v_2_rtt_previous_var (ite $x601633 v_1_rttvar_ms v_1_rtt_previous_var))))
 (let (($x432928 (= v_2_rtt_previous_srtt (ite $x601633 v_1_srtt_ms v_1_rtt_previous_srtt))))
 (let (($x214459 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x601890 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x163422 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x340379 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x764984 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x64550 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x712898 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x603021 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x563983 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x634889 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x601221 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x219393 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x185326 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x604072 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x705247 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x82372 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x828499 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x616750 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x235291 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x230427 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x440666 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x603075 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x313623 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x219226 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x247256 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x268853 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x259715 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x269058 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x603390 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x457227 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x164097 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x642999 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x399253 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x315693 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x303016 (= v_2_take v_1_take)))
 (let (($x601072 (= v_2_snd_wl2 (_ bv1001 32))))
 (let (($x605073 (= v_2_snd_wl1 (_ bv9000 32))))
 (let (($x605374 (= v_2_snd_wnd 16)))
 (let (($x287206 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x292918 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x325998 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x115432 (= v_2_local_window v_1_local_window)))
 (let (($x882390 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x12342 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x464972 (= v_2_active_open v_1_active_open)))
 (let (($x311681 (= v_2_retries v_1_retries)))
 (let (($x171167 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x152254 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x316179 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x151615 (= v_2_rcv_nxt (_ bv9001 32))))
 (let (($x769128 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x605079 (= v_2_snd_una (_ bv1001 32))))
 (let (($x604969 (= v_2_irs (_ bv9000 32))))
 (let (($x168947 (= v_2_iss v_1_iss)))
 (let (($x3792 (= 4 state_2)))
 (let (($x870505 (not active_1_delack)))
 (let (($x268788 (or $x870505 (not (<= due_1_delack 900)))))
 (let (($x17756 (not active_1_time_wait)))
 (let (($x88703 (or $x17756 (not (<= due_1_time_wait 900)))))
 (let (($x184022 (or (not active_1_user) (not (<= due_1_user 900)))))
 (let (($x166851 (or (not active_1_rtx) (not (<= due_1_rtx 900)))))
 (let (($x73094 (= 0 v_1_retries)))
 (let (($x303038 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x169080 (= state_1 2)))
 (and $x169080 $x303038 $x73094 $x166851 $x184022 $x88703 $x268788 $x3792 $x168947 $x604969 $x605079 $x769128 $x151615 $x316179 $x152254 $x171167 (= v_2_rto_ms (ite $x601633 ?x182538 v_1_rto_ms)) $x311681 $x464972 $x12342 $x882390 $x115432 $x325998 $x292918 $x287206 $x605374 $x605073 $x601072 $x303016 $x315693 $x399253 $x642999 $x164097 $x457227 $x603390 $x269058 $x259715 $x268853 $x247256 $x219226 $x313623 $x603075 $x440666 $x230427 $x235291 $x616750 $x828499 $x82372 $x705247 $x604072 $x185326 $x219393 $x601221 $x634889 $x563983 $x603021 $x712898 $x64550 $x764984 $x340379 $x163422 $x601890 $x214459 (= v_2_srtt_ms ?x211807) (= v_2_rttvar_ms ?x76508) (= v_2_rtt_error_ms ?x829337) $x432928 $x873251 (= v_2_rtt_measured (or v_1_rtt_measured $x601633)) $x287549 (= v_2_rtt_active (and v_1_rtt_active (not $x274621))) (= v_2_rtt_ambiguous (and (not $x274621) v_1_rtt_ambiguous)) (= v_2_rtt_sample_at_ms (ite $x601633 900 v_1_rtt_sample_at_ms)) $x282120 $x525517 (= v_2_rtt_remaining (ite $x274621 0 ?x447601)) $x635970 (= v_2_rtt_sample_used $x601633) $x34645 (= v_2_rtt_last_ms ?x632254) (= v_2_rtt_samples (+ v_1_rtt_samples (ite $x601633 1 0))) (= v_2_rto_base_ms (ite $x601633 ?x182538 v_1_rto_base_ms)) $x524165 $x304627 $x229833 $x301827 $x35171 $x373952 $x602807 $x826557 $x604454 $x298737 $x307962 $x547216 $x36112 $x262245 $x459951 $x317023 $x438347 $x183178 $x604844 $x243451 $x134163 $x605365 $x78671 $x40990 $x8215 $x439545 $x601193 $x604432 $x395208 $x478853 $x338518 $x339883 $x134753 $x823230 $x600991 $x308244 $x299462 $x823823 $x602349 $x343711 $x143501 $x346612 $x248931 $x44366))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
 (= 0 v_0_tx_time_00))
(assert
 (= 0 v_0_tx_time_01))
(assert
 (= 0 v_0_tx_time_02))
(assert
 (= 0 v_0_tx_time_03))
(assert
 (= 0 v_0_tx_time_04))
(assert
 (= 0 v_0_tx_time_05))
(assert
 (= 0 v_0_tx_time_06))
(assert
 (= 0 v_0_tx_time_07))
(assert
 (= 0 v_0_tx_time_08))
(assert
 (= 0 v_0_tx_time_09))
(assert
 (= 0 v_0_tx_time_10))
(assert
 (= 0 v_0_tx_time_11))
(assert
 (= 0 v_0_tx_time_12))
(assert
 (= 0 v_0_tx_time_13))
(assert
 (= 0 v_0_tx_time_14))
(assert
 (= 0 v_0_tx_time_15))
(assert
 (= 0 v_0_tx_fin_time))
(assert
 (= 0 v_0_tx_emit_count))
(assert
 (= 0 v_0_tx_eligible))
(assert
 (= 0 v_0_tx_max_previous))
(assert
 (= v_0_tx_retransmitted false))
(assert
 (= 0 v_0_tx_elapsed))
(assert
 (= 1000 v_0_tx_previous_rto))
(assert
 (= v_0_tx_is_fin false))
(assert
 (= v_0_tx_waiting false))
(assert
 (= 0 v_0_tx_syn_time))
(assert
 (= v_0_tx_syn_pending false))
(assert
 (= v_0_syn_timeout_eligible false))
(assert
 (= v_0_ack_pending false))
(assert
 (= 0 v_0_ack_since_ms))
(assert
 (= 0 v_0_ack_bytes))
(assert
 (= 0 v_0_ack_full_segments))
(assert
 (= 40 v_0_ack_delay_ms))
(assert
 (= 4 v_0_ack_rmss))
(assert
 (= v_0_ack_defer_candidate false))
(assert
 (= v_0_ack_defer_now false))
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
