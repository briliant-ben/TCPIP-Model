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
(declare-fun active_0_persist () Bool)
(declare-fun due_0_persist () Int)
(declare-fun due_1_persist () Int)
(declare-fun due_1_delack () Int)
(declare-fun due_1_time_wait () Int)
(declare-fun due_1_user () Int)
(declare-fun due_1_rtx () Int)
(declare-fun active_1_persist () Bool)
(declare-fun active_1_delack () Bool)
(declare-fun active_1_time_wait () Bool)
(declare-fun active_1_user () Bool)
(declare-fun active_1_rtx () Bool)
(declare-fun v_1_persist_elapsed_ms () Int)
(declare-fun v_1_persist_probes () Int)
(declare-fun v_1_persist_deadline_ms () Int)
(declare-fun v_1_persist_last_ms () Int)
(declare-fun v_1_persist_since_ms () Int)
(declare-fun v_1_persist_previous_interval_ms () Int)
(declare-fun v_1_persist_interval_ms () Int)
(declare-fun v_1_persist_probe_new () Bool)
(declare-fun v_1_persist_probe_sent () Bool)
(declare-fun v_1_persist_first () Bool)
(declare-fun v_1_persist_was_active () Bool)
(declare-fun v_1_persist_start () Bool)
(declare-fun v_1_persist_eligible () Bool)
(declare-fun v_1_persist_active () Bool)
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
(declare-fun due_2_persist () Int)
(declare-fun due_2_delack () Int)
(declare-fun due_2_time_wait () Int)
(declare-fun due_2_user () Int)
(declare-fun due_2_rtx () Int)
(declare-fun active_2_persist () Bool)
(declare-fun active_2_delack () Bool)
(declare-fun active_2_time_wait () Bool)
(declare-fun active_2_user () Bool)
(declare-fun active_2_rtx () Bool)
(declare-fun v_2_persist_elapsed_ms () Int)
(declare-fun v_2_persist_probes () Int)
(declare-fun v_2_persist_deadline_ms () Int)
(declare-fun v_2_persist_last_ms () Int)
(declare-fun v_2_persist_since_ms () Int)
(declare-fun v_2_persist_previous_interval_ms () Int)
(declare-fun v_2_persist_interval_ms () Int)
(declare-fun v_2_persist_probe_new () Bool)
(declare-fun v_2_persist_probe_sent () Bool)
(declare-fun v_2_persist_first () Bool)
(declare-fun v_2_persist_was_active () Bool)
(declare-fun v_2_persist_start () Bool)
(declare-fun v_2_persist_eligible () Bool)
(declare-fun v_2_persist_active () Bool)
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
(declare-fun v_0_persist_active () Bool)
(declare-fun v_0_persist_eligible () Bool)
(declare-fun v_0_persist_start () Bool)
(declare-fun v_0_persist_was_active () Bool)
(declare-fun v_0_persist_first () Bool)
(declare-fun v_0_persist_probe_sent () Bool)
(declare-fun v_0_persist_probe_new () Bool)
(declare-fun v_0_persist_interval_ms () Int)
(declare-fun v_0_persist_previous_interval_ms () Int)
(declare-fun v_0_persist_since_ms () Int)
(declare-fun v_0_persist_last_ms () Int)
(declare-fun v_0_persist_deadline_ms () Int)
(declare-fun v_0_persist_probes () Int)
(declare-fun v_0_persist_elapsed_ms () Int)
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
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
 (not active_0_persist))
(assert
 (= due_0_persist 0))
(assert
 true)
(assert
 (let (($x14963 (= due_1_persist due_0_persist)))
 (let (($x4493 (= due_1_delack due_0_delack)))
 (let (($x649 (= due_1_time_wait due_0_time_wait)))
 (let (($x14998 (= due_1_user 30000)))
 (let (($x11860 (= due_1_rtx 1000)))
 (let (($x14976 (not active_1_persist)))
 (let (($x15035 (not active_1_delack)))
 (let (($x11882 (not active_1_time_wait)))
 (let (($x1738 (= v_1_persist_elapsed_ms 0)))
 (let (($x10273 (= v_1_persist_probes 0)))
 (let (($x10317 (= v_1_persist_deadline_ms 0)))
 (let (($x10102 (= v_1_persist_last_ms 0)))
 (let (($x13808 (= v_1_persist_since_ms 0)))
 (let (($x510 (= v_1_persist_previous_interval_ms 1000)))
 (let (($x15091 (= v_1_persist_interval_ms 1000)))
 (let (($x15124 (not v_1_persist_probe_new)))
 (let (($x10512 (not v_1_persist_probe_sent)))
 (let (($x10107 (not v_1_persist_first)))
 (let (($x11813 (not v_1_persist_was_active)))
 (let (($x15078 (not v_1_persist_start)))
 (let (($x15080 (not v_1_persist_eligible)))
 (let (($x15106 (not v_1_persist_active)))
 (let (($x15093 (not v_1_ack_defer_now)))
 (let (($x15092 (not v_1_ack_defer_candidate)))
 (let (($x8491 (= v_1_ack_rmss 4)))
 (let (($x10160 (= v_1_ack_delay_ms 40)))
 (let (($x8096 (= 0 v_1_ack_full_segments)))
 (let (($x8038 (= 0 v_1_ack_bytes)))
 (let (($x8192 (= 0 v_1_ack_since_ms)))
 (let (($x4837 (not v_1_ack_pending)))
 (let (($x15050 (not v_1_syn_timeout_eligible)))
 (let (($x10555 (= v_1_tx_syn_time 0)))
 (let (($x15052 (not v_1_tx_waiting)))
 (let (($x11791 (not v_1_tx_is_fin)))
 (let (($x12502 (= v_1_tx_previous_rto 1000)))
 (let (($x1869 (= v_1_tx_elapsed 0)))
 (let (($x4819 (not v_1_tx_retransmitted)))
 (let (($x1867 (= v_1_tx_max_previous 0)))
 (let (($x9830 (= v_1_tx_eligible 0)))
 (let (($x14980 (= v_1_tx_emit_count 0)))
 (let (($x14995 (= v_1_tx_fin_time 0)))
 (let (($x14996 (= v_1_tx_time_15 0)))
 (let (($x14997 (= v_1_tx_time_14 0)))
 (let (($x14993 (= v_1_tx_time_13 0)))
 (let (($x14994 (= v_1_tx_time_12 0)))
 (let (($x7323 (= v_1_tx_time_11 0)))
 (let (($x8767 (= v_1_tx_time_10 0)))
 (let (($x15008 (= v_1_tx_time_09 0)))
 (let (($x15009 (= v_1_tx_time_08 0)))
 (let (($x763 (= v_1_tx_time_07 0)))
 (let (($x13781 (= v_1_tx_time_06 0)))
 (let (($x1770 (= v_1_tx_time_05 0)))
 (let (($x1768 (= v_1_tx_time_04 0)))
 (let (($x11886 (= v_1_tx_time_03 0)))
 (let (($x15002 (= v_1_tx_time_02 0)))
 (let (($x10796 (= v_1_tx_time_01 0)))
 (let (($x9610 (= v_1_tx_time_00 0)))
 (let (($x7913 (= v_1_rto_base_ms 1000)))
 (let (($x15077 (= v_1_rtt_samples 0)))
 (let (($x15075 (= v_1_rtt_last_ms 0)))
 (let (($x13791 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x15265 (not v_1_rtt_sample_used)))
 (let (($x7584 (= v_1_rtt_remaining 1)))
 (let (($x7586 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x15046 (= v_1_rtt_start_ms 0)))
 (let (($x15044 (= v_1_rtt_sample_at_ms 0)))
 (let (($x15036 (not v_1_rtt_ambiguous)))
 (let (($x13746 (not v_1_rtt_previous_measured)))
 (let (($x10159 (not v_1_rtt_measured)))
 (let (($x15015 (= v_1_rtt_previous_var 0.0)))
 (let (($x10596 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x10431 (= v_1_rtt_error_ms 0.0)))
 (let (($x13766 (= v_1_rttvar_ms 0.0)))
 (let (($x13708 (= v_1_srtt_ms 0.0)))
 (let (($x14856 (not v_1_rx_fin_consumed)))
 (let (($x7868 (not v_1_rx_fin_done)))
 (let (($x2661 (= v_1_rx_fin_offset 0)))
 (let (($x9813 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x11856 (not v_1_rx_fin_pending)))
 (let (($x9976 (not v_1_fin_acknowledged)))
 (let (($x569 (= v_1_fin_seq (_ bv0 32))))
 (let (($x10098 (not v_1_fin_sent)))
 (let (($x8014 (not v_1_fin_requested)))
 (let (($x13699 (not v_1_ack_window_update)))
 (let (($x1885 (not v_1_ack_advance)))
 (let (($x13807 (not v_1_ack_is_future)))
 (let (($x15120 (not v_1_ack_is_new)))
 (let (($x8047 (= v_1_ack_delta 0)))
 (let (($x15040 (not v_1_seg_acceptable)))
 (let (($x15037 (not v_1_rx_acceptable)))
 (let (($x15121 (= v_1_rx_advance 0)))
 (let (($x14985 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x761 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x14984 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x14983 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x15064 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x15066 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x15073 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x14125 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x9375 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x14971 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x14970 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x14973 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x14972 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x14975 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x14974 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x762 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x15069 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x13772 (= v_1_take 0)))
 (let (($x9951 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x11852 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x10598 (= v_1_snd_wnd 8)))
 (let (($x11854 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x14987 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x14999 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x9756 (= v_1_local_window 16)))
 (let (($x9833 (= v_1_msl_ms 60000)))
 (let (($x1309 (= v_1_user_timeout_ms 30000)))
 (let (($x14172 (= 0 v_1_retries)))
 (let (($x10554 (= 1000 v_1_rto_ms)))
 (let (($x10105 (= v_1_tx_flags "S")))
 (let (($x1860 (= v_1_tx_ack (_ bv0 32))))
 (let (($x949 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x7869 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x14991 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x7867 (= v_1_snd_una (_ bv1000 32))))
 (let (($x10070 (= v_1_irs (_ bv0 32))))
 (let (($x8198 (= v_1_iss (_ bv1000 32))))
 (let (($x10007 (= 2 state_1)))
 (let (($x10227 (not active_0_persist)))
 (let (($x14990 (or $x10227 (not (<= due_0_persist 0)))))
 (let (($x8119 (not active_0_delack)))
 (let (($x14969 (or $x8119 (not (<= due_0_delack 0)))))
 (let (($x9828 (not active_0_time_wait)))
 (let (($x898 (or $x9828 (not (<= due_0_time_wait 0)))))
 (let (($x9787 (not active_0_user)))
 (let (($x1832 (or $x9787 (not (<= due_0_user 0)))))
 (let (($x9795 (not active_0_rtx)))
 (let (($x7976 (or $x9795 (not (<= due_0_rtx 0)))))
 (let (($x847 (= state_0 0)))
 (and $x847 (>= 0 now_0) $x7976 $x1832 $x898 $x14969 $x14990 $x10007 $x8198 $x10070 $x7867 $x14991 $x7869 $x949 $x1860 $x10105 $x10554 $x14172 v_1_active_open $x1309 $x9833 $x9756 $x14999 $x14987 $x11854 $x10598 $x11852 $x9951 $x13772 $x15069 $x762 $x14974 $x14975 $x14972 $x14973 $x14970 $x14971 $x9375 $x14125 $x15073 $x15066 $x15064 $x14983 $x14984 $x761 $x14985 $x15121 $x15037 $x15040 $x8047 $x15120 $x13807 $x1885 $x13699 $x8014 $x10098 $x569 $x9976 $x11856 $x9813 $x2661 $x7868 $x14856 $x13708 $x13766 $x10431 $x10596 $x15015 $x10159 $x13746 v_1_rtt_active $x15036 $x15044 $x15046 $x7586 $x7584 v_1_rtt_start_new $x15265 $x13791 $x15075 $x15077 $x7913 $x9610 $x10796 $x15002 $x11886 $x1768 $x1770 $x13781 $x763 $x15009 $x15008 $x8767 $x7323 $x14994 $x14993 $x14997 $x14996 $x14995 $x14980 $x9830 $x1867 $x4819 $x1869 $x12502 $x11791 $x15052 $x10555 v_1_tx_syn_pending $x15050 $x4837 $x8192 $x8038 $x8096 $x10160 $x8491 $x15092 $x15093 $x15106 $x15080 $x15078 $x11813 $x10107 $x10512 $x15124 $x15091 $x510 $x13808 $x10102 $x10317 $x10273 $x1738 active_1_rtx active_1_user $x11882 $x15035 $x14976 $x11860 $x14998 $x649 $x4493 $x14963))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x7427 (= due_2_persist due_1_persist)))
 (let (($x7905 (= due_2_delack due_1_delack)))
 (let (($x9932 (= due_2_time_wait due_1_time_wait)))
 (let (($x9891 (= due_2_user due_1_user)))
 (let ((?x15083 (+ 900 (* (- 1) v_1_rtt_start_ms))))
 (let (($x15036 (not v_1_rtt_ambiguous)))
 (let ((?x7043 (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let ((?x8185 (ubv_to_int (bvadd (_ bv1001 32) (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let (($x10615 (>= ?x8185 ?x7043)))
 (let (($x11865 (and v_1_rtt_active $x10615 $x15036)))
 (let ((?x15081 (ite $x11865 ?x15083 v_1_rtt_last_ms)))
 (let ((?x1879 (to_real ?x15081)))
 (let ((?x15007 (+ v_1_srtt_ms (* (- 1.0) ?x1879))))
 (let ((?x11873 (ite $x11865 (ite (>= ?x15007 0.0) ?x15007 (+ (* (- 1.0) v_1_srtt_ms) ?x1879)) v_1_rtt_error_ms)))
 (let ((?x15005 (* (/ 3.0 4.0) v_1_rttvar_ms)))
 (let ((?x15054 (ite $x11865 (ite v_1_rtt_measured (+ ?x15005 (* (/ 1.0 4.0) ?x11873)) (* (/ 1.0 2.0) ?x1879)) v_1_rttvar_ms)))
 (let ((?x14279 (ite v_1_rtt_measured (+ (* (/ 7.0 8.0) v_1_srtt_ms) (* (/ 1.0 8.0) ?x1879)) ?x1879)))
 (let ((?x14123 (ite $x11865 ?x14279 v_1_srtt_ms)))
 (let ((?x15016 (+ (* (- 1.0) ?x14123) (* (- 1.0) (ite (<= ?x15054 (/ 1.0 4.0)) 1.0 (* 4.0 ?x15054))))))
 (let ((?x15014 (to_int ?x15016)))
 (let ((?x15023 (ite (<= ?x15014 (- 1000)) (* (- 1) ?x15014) 1000)))
 (let ((?x15024 (ite (<= 60000 ?x15023) 60000 ?x15023)))
 (let ((?x15027 (ite $x11865 ?x15024 v_1_rto_ms)))
 (let ((?x10289 (seq.len v_1_rtx_buf)))
 (let (($x5844 (<= 1 ?x10289)))
 (let (($x10453 (and v_1_persist_active $x5844)))
 (let (($x9556 (not active_2_persist)))
 (let (($x9346 (not active_2_delack)))
 (let (($x7675 (= active_2_time_wait active_1_time_wait)))
 (let (($x9803 (not active_2_user)))
 (let (($x1734 (= v_2_persist_elapsed_ms v_1_persist_elapsed_ms)))
 (let (($x5018 (= v_2_persist_probes 0)))
 (let (($x10508 (= v_2_persist_deadline_ms 0)))
 (let (($x10506 (= v_2_persist_last_ms 0)))
 (let (($x10509 (= v_2_persist_since_ms 0)))
 (let (($x7024 (= v_2_persist_previous_interval_ms v_1_persist_previous_interval_ms)))
 (let (($x7733 (= v_2_persist_interval_ms 1000)))
 (let (($x9553 (not v_2_persist_probe_new)))
 (let (($x10460 (not v_2_persist_probe_sent)))
 (let (($x9786 (not v_2_persist_first)))
 (let (($x10148 (= v_2_persist_was_active v_1_persist_active)))
 (let (($x2278 (not v_2_persist_start)))
 (let (($x14759 (not v_2_persist_eligible)))
 (let (($x12093 (not v_2_persist_active)))
 (let (($x14978 (not v_2_ack_defer_now)))
 (let (($x14977 (not v_2_ack_defer_candidate)))
 (let (($x7158 (= v_2_ack_rmss v_1_ack_rmss)))
 (let (($x7146 (= v_2_ack_delay_ms v_1_ack_delay_ms)))
 (let (($x15139 (= v_2_ack_full_segments 0)))
 (let (($x15129 (= v_2_ack_bytes 0)))
 (let (($x15132 (= v_2_ack_since_ms 0)))
 (let (($x15128 (not v_2_ack_pending)))
 (let (($x15127 (not v_2_syn_timeout_eligible)))
 (let (($x15123 (not v_2_tx_syn_pending)))
 (let (($x15117 (= v_2_tx_syn_time 0)))
 (let (($x14126 (not v_2_tx_waiting)))
 (let (($x10283 (= v_2_tx_is_fin v_1_tx_is_fin)))
 (let (($x9909 (= v_2_tx_previous_rto v_1_tx_previous_rto)))
 (let (($x9907 (= v_2_tx_elapsed v_1_tx_elapsed)))
 (let (($x15116 (not v_2_tx_retransmitted)))
 (let (($x9904 (= v_2_tx_max_previous v_1_tx_max_previous)))
 (let (($x9906 (= v_2_tx_eligible v_1_tx_eligible)))
 (let (($x9908 (= v_2_tx_emit_count v_1_tx_emit_count)))
 (let ((?x15112 (ite (and v_1_fin_sent (not v_1_fin_acknowledged)) v_1_tx_fin_time 0)))
 (let (($x15115 (= v_2_tx_fin_time ?x15112)))
 (let (($x9887 (= v_2_tx_time_15 (ite (>= 15 ?x10289) 0 v_1_tx_time_15))))
 (let (($x10281 (= v_2_tx_time_14 (ite (>= 14 ?x10289) 0 v_1_tx_time_14))))
 (let (($x10280 (= v_2_tx_time_13 (ite (>= 13 ?x10289) 0 v_1_tx_time_13))))
 (let (($x10279 (= v_2_tx_time_12 (ite (>= 12 ?x10289) 0 v_1_tx_time_12))))
 (let (($x10277 (= v_2_tx_time_11 (ite (>= 11 ?x10289) 0 v_1_tx_time_11))))
 (let (($x10275 (= v_2_tx_time_10 (ite (>= 10 ?x10289) 0 v_1_tx_time_10))))
 (let (($x8207 (= v_2_tx_time_09 (ite (>= 9 ?x10289) 0 v_1_tx_time_09))))
 (let (($x7840 (= v_2_tx_time_08 (ite (>= 8 ?x10289) 0 v_1_tx_time_08))))
 (let (($x5849 (= v_2_tx_time_07 (ite (>= 7 ?x10289) 0 v_1_tx_time_07))))
 (let (($x8024 (= v_2_tx_time_06 (ite (>= 6 ?x10289) 0 v_1_tx_time_06))))
 (let (($x9926 (= v_2_tx_time_05 (ite (>= 5 ?x10289) 0 v_1_tx_time_05))))
 (let (($x7827 (= v_2_tx_time_04 (ite (>= 4 ?x10289) 0 v_1_tx_time_04))))
 (let (($x9939 (= v_2_tx_time_03 (ite (>= 3 ?x10289) 0 v_1_tx_time_03))))
 (let (($x9938 (= v_2_tx_time_02 (ite (>= 2 ?x10289) 0 v_1_tx_time_02))))
 (let (($x9539 (= v_2_tx_time_01 (ite (>= 1 ?x10289) 0 v_1_tx_time_01))))
 (let (($x8023 (= v_2_tx_time_00 (ite (>= 0 ?x10289) 0 v_1_tx_time_00))))
 (let (($x15104 (= v_2_rtt_sample_was_ambiguous (and v_1_rtt_active v_1_rtt_ambiguous))))
 (let (($x15099 (not v_2_rtt_start_new)))
 (let ((?x15079 (* (- 1) ?x8185)))
 (let ((?x15082 (+ ?x7043 ?x15079)))
 (let ((?x15096 (ite (and v_1_rtt_active (not (<= v_1_rtt_remaining ?x15082))) ?x15082 v_1_rtt_remaining)))
 (let (($x10294 (and v_1_rtt_active $x10615)))
 (let (($x7676 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x7909 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let (($x15051 (= v_2_rtt_previous_measured (ite $x11865 v_1_rtt_measured v_1_rtt_previous_measured))))
 (let (($x15041 (= v_2_rtt_previous_var (ite $x11865 v_1_rttvar_ms v_1_rtt_previous_var))))
 (let (($x15033 (= v_2_rtt_previous_srtt (ite $x11865 v_1_srtt_ms v_1_rtt_previous_srtt))))
 (let (($x10136 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x10410 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x10127 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x10286 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x5907 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x9694 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x7729 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x7728 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x11795 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x7462 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x10367 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x10366 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x10365 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x10214 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x11788 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x7088 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x7303 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x10557 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x10556 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x10191 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x10039 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x9838 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x10459 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x10370 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x10457 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x10456 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x10042 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x10041 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x10040 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x10043 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x10516 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x10362 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x9542 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x9699 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x521 (= v_2_take v_1_take)))
 (let (($x1699 (= v_2_snd_wl2 (_ bv1001 32))))
 (let (($x13792 (= v_2_snd_wl1 (_ bv9000 32))))
 (let (($x13793 (= v_2_snd_wnd 16)))
 (let (($x5881 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x5883 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x10369 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x10368 (= v_2_local_window v_1_local_window)))
 (let (($x8088 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x12210 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x1839 (= v_2_active_open v_1_active_open)))
 (let (($x9581 (= v_2_retries v_1_retries)))
 (let (($x11778 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x10798 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x11781 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x15047 (= v_2_rcv_nxt (_ bv9001 32))))
 (let (($x8177 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x5892 (= v_2_snd_una (_ bv1001 32))))
 (let (($x11815 (= v_2_irs (_ bv9000 32))))
 (let (($x7296 (= v_2_iss v_1_iss)))
 (let (($x7297 (= 4 state_2)))
 (let (($x14976 (not active_1_persist)))
 (let (($x9698 (or $x14976 (not (<= due_1_persist 900)))))
 (let (($x15035 (not active_1_delack)))
 (let (($x13767 (or $x15035 (not (<= due_1_delack 900)))))
 (let (($x11882 (not active_1_time_wait)))
 (let (($x13742 (or $x11882 (not (<= due_1_time_wait 900)))))
 (let (($x10014 (or (not active_1_user) (not (<= due_1_user 900)))))
 (let (($x10332 (or (not active_1_rtx) (not (<= due_1_rtx 900)))))
 (let (($x14172 (= 0 v_1_retries)))
 (let (($x14991 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x15010 (= state_1 2)))
 (and $x15010 $x14991 $x14172 $x10332 $x10014 $x13742 $x13767 $x9698 $x7297 $x7296 $x11815 $x5892 $x8177 $x15047 $x11781 $x10798 $x11778 (= v_2_rto_ms ?x15027) $x9581 $x1839 $x12210 $x8088 $x10368 $x10369 $x5883 $x5881 $x13793 $x13792 $x1699 $x521 $x9699 $x9542 $x10362 $x10516 $x10043 $x10040 $x10041 $x10042 $x10456 $x10457 $x10370 $x10459 $x9838 $x10039 $x10191 $x10556 $x10557 $x7303 $x7088 $x11788 $x10214 $x10365 $x10366 $x10367 $x7462 $x11795 $x7728 $x7729 $x9694 $x5907 $x10286 $x10127 $x10410 $x10136 (= v_2_srtt_ms ?x14123) (= v_2_rttvar_ms ?x15054) (= v_2_rtt_error_ms ?x11873) $x15033 $x15041 (= v_2_rtt_measured (or v_1_rtt_measured $x11865)) $x15051 (= v_2_rtt_active (and v_1_rtt_active (not $x10294))) (= v_2_rtt_ambiguous (and (not $x10294) v_1_rtt_ambiguous)) (= v_2_rtt_sample_at_ms (ite $x11865 900 v_1_rtt_sample_at_ms)) $x7909 $x7676 (= v_2_rtt_remaining (ite $x10294 0 ?x15096)) $x15099 (= v_2_rtt_sample_used $x11865) $x15104 (= v_2_rtt_last_ms ?x15081) (= v_2_rtt_samples (+ v_1_rtt_samples (ite $x11865 1 0))) (= v_2_rto_base_ms (ite $x11865 ?x15024 v_1_rto_base_ms)) $x8023 $x9539 $x9938 $x9939 $x7827 $x9926 $x8024 $x5849 $x7840 $x8207 $x10275 $x10277 $x10279 $x10280 $x10281 $x9887 $x15115 $x9908 $x9906 $x9904 $x15116 $x9907 $x9909 $x10283 $x14126 $x15117 $x15123 $x15127 $x15128 $x15132 $x15129 $x15139 $x7146 $x7158 $x14977 $x14978 $x12093 $x14759 $x2278 $x10148 $x9786 $x10460 $x9553 $x7733 $x7024 $x10509 $x10506 $x10508 $x5018 $x1734 (= active_2_rtx $x10453) $x9803 $x7675 $x9346 $x9556 (= due_2_rtx (ite $x10453 (+ 900 ?x15027) due_1_rtx)) $x9891 $x9932 $x7905 $x7427))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
 (= v_0_persist_active false))
(assert
 (= v_0_persist_eligible false))
(assert
 (= v_0_persist_start false))
(assert
 (= v_0_persist_was_active false))
(assert
 (= v_0_persist_first false))
(assert
 (= v_0_persist_probe_sent false))
(assert
 (= v_0_persist_probe_new false))
(assert
 (= 1000 v_0_persist_interval_ms))
(assert
 (= 1000 v_0_persist_previous_interval_ms))
(assert
 (= 0 v_0_persist_since_ms))
(assert
 (= 0 v_0_persist_last_ms))
(assert
 (= 0 v_0_persist_deadline_ms))
(assert
 (= 0 v_0_persist_probes))
(assert
 (= 0 v_0_persist_elapsed_ms))
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
