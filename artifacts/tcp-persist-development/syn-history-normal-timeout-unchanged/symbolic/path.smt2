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
 (let (($x3974 (= due_1_persist due_0_persist)))
 (let (($x21041 (= due_1_delack due_0_delack)))
 (let (($x20711 (= due_1_time_wait due_0_time_wait)))
 (let (($x9155 (= due_1_user 30000)))
 (let (($x21093 (= due_1_rtx 1000)))
 (let (($x8482 (not active_1_persist)))
 (let (($x4306 (not active_1_delack)))
 (let (($x8356 (not active_1_time_wait)))
 (let (($x19894 (= v_1_persist_elapsed_ms 0)))
 (let (($x15622 (= v_1_persist_probes 0)))
 (let (($x8454 (= v_1_persist_deadline_ms 0)))
 (let (($x18165 (= v_1_persist_last_ms 0)))
 (let (($x8453 (= v_1_persist_since_ms 0)))
 (let (($x2613 (= v_1_persist_previous_interval_ms 1000)))
 (let (($x16800 (= v_1_persist_interval_ms 1000)))
 (let (($x17288 (not v_1_persist_probe_new)))
 (let (($x5693 (not v_1_persist_probe_sent)))
 (let (($x5690 (not v_1_persist_first)))
 (let (($x9312 (not v_1_persist_was_active)))
 (let (($x9791 (not v_1_persist_start)))
 (let (($x19077 (not v_1_persist_eligible)))
 (let (($x15278 (not v_1_persist_active)))
 (let (($x6501 (not v_1_ack_defer_now)))
 (let (($x5700 (not v_1_ack_defer_candidate)))
 (let (($x5858 (= v_1_ack_rmss 4)))
 (let (($x24800 (= v_1_ack_delay_ms 40)))
 (let (($x5389 (= 0 v_1_ack_full_segments)))
 (let (($x23856 (= 0 v_1_ack_bytes)))
 (let (($x8464 (= 0 v_1_ack_since_ms)))
 (let (($x24185 (not v_1_ack_pending)))
 (let (($x5908 (not v_1_syn_timeout_eligible)))
 (let (($x1598 (= v_1_tx_syn_time 0)))
 (let (($x11395 (not v_1_tx_waiting)))
 (let (($x10145 (not v_1_tx_is_fin)))
 (let (($x19839 (= v_1_tx_previous_rto 1000)))
 (let (($x9816 (= v_1_tx_elapsed 0)))
 (let (($x21653 (not v_1_tx_retransmitted)))
 (let (($x11479 (= v_1_tx_max_previous 0)))
 (let (($x2849 (= v_1_tx_eligible 0)))
 (let (($x2851 (= v_1_tx_emit_count 0)))
 (let (($x12607 (= v_1_tx_fin_time 0)))
 (let (($x15548 (= v_1_tx_time_15 0)))
 (let (($x8607 (= v_1_tx_time_14 0)))
 (let (($x15780 (= v_1_tx_time_13 0)))
 (let (($x9986 (= v_1_tx_time_12 0)))
 (let (($x15127 (= v_1_tx_time_11 0)))
 (let (($x5433 (= v_1_tx_time_10 0)))
 (let (($x7773 (= v_1_tx_time_09 0)))
 (let (($x21761 (= v_1_tx_time_08 0)))
 (let (($x22767 (= v_1_tx_time_07 0)))
 (let (($x8993 (= v_1_tx_time_06 0)))
 (let (($x24830 (= v_1_tx_time_05 0)))
 (let (($x4753 (= v_1_tx_time_04 0)))
 (let (($x19484 (= v_1_tx_time_03 0)))
 (let (($x19482 (= v_1_tx_time_02 0)))
 (let (($x1664 (= v_1_tx_time_01 0)))
 (let (($x1263 (= v_1_tx_time_00 0)))
 (let (($x10595 (= v_1_rto_base_ms 1000)))
 (let (($x5291 (= v_1_rtt_samples 0)))
 (let (($x6610 (= v_1_rtt_last_ms 0)))
 (let (($x7571 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x9579 (not v_1_rtt_sample_used)))
 (let (($x14250 (= v_1_rtt_remaining 1)))
 (let (($x6670 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x6448 (= v_1_rtt_start_ms 0)))
 (let (($x13471 (= v_1_rtt_sample_at_ms 0)))
 (let (($x12945 (not v_1_rtt_ambiguous)))
 (let (($x11338 (not v_1_rtt_previous_measured)))
 (let (($x11345 (not v_1_rtt_measured)))
 (let (($x2977 (= v_1_rtt_previous_var 0.0)))
 (let (($x14196 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x14269 (= v_1_rtt_error_ms 0.0)))
 (let (($x11443 (= v_1_rttvar_ms 0.0)))
 (let (($x10447 (= v_1_srtt_ms 0.0)))
 (let (($x11344 (not v_1_rx_fin_consumed)))
 (let (($x15839 (not v_1_rx_fin_done)))
 (let (($x4111 (= v_1_rx_fin_offset 0)))
 (let (($x14506 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x7473 (not v_1_rx_fin_pending)))
 (let (($x10999 (not v_1_fin_acknowledged)))
 (let (($x17976 (= v_1_fin_seq (_ bv0 32))))
 (let (($x16713 (not v_1_fin_sent)))
 (let (($x20477 (not v_1_fin_requested)))
 (let (($x21015 (not v_1_ack_window_update)))
 (let (($x532 (not v_1_ack_advance)))
 (let (($x18411 (not v_1_ack_is_future)))
 (let (($x21095 (not v_1_ack_is_new)))
 (let (($x10278 (= v_1_ack_delta 0)))
 (let (($x6115 (not v_1_seg_acceptable)))
 (let (($x15170 (not v_1_rx_acceptable)))
 (let (($x18434 (= v_1_rx_advance 0)))
 (let (($x23954 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x4796 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x20617 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x15296 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x23966 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x9626 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x15156 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x14942 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x10617 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x24202 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x18167 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x3154 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x12516 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x3153 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x4700 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x3415 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x25667 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x15090 (= v_1_take 0)))
 (let (($x8804 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x2777 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x18914 (= v_1_snd_wnd 8)))
 (let (($x2491 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x24691 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x2243 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x10360 (= v_1_local_window 16)))
 (let (($x25108 (= v_1_msl_ms 60000)))
 (let (($x2646 (= v_1_user_timeout_ms 30000)))
 (let (($x1100 (= 0 v_1_retries)))
 (let (($x7389 (= 1000 v_1_rto_ms)))
 (let (($x4573 (= v_1_tx_flags "S")))
 (let (($x831 (= v_1_tx_ack (_ bv0 32))))
 (let (($x2800 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x9501 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x10531 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x372 (= v_1_snd_una (_ bv1000 32))))
 (let (($x2455 (= v_1_irs (_ bv0 32))))
 (let (($x2817 (= v_1_iss (_ bv1000 32))))
 (let (($x18002 (= 2 state_1)))
 (let (($x17030 (not active_0_persist)))
 (let (($x23197 (or $x17030 (not (<= due_0_persist 0)))))
 (let (($x3384 (not active_0_delack)))
 (let (($x17715 (or $x3384 (not (<= due_0_delack 0)))))
 (let (($x17077 (not active_0_time_wait)))
 (let (($x11974 (or $x17077 (not (<= due_0_time_wait 0)))))
 (let (($x24054 (not active_0_user)))
 (let (($x2110 (or $x24054 (not (<= due_0_user 0)))))
 (let (($x17180 (not active_0_rtx)))
 (let (($x15538 (or $x17180 (not (<= due_0_rtx 0)))))
 (let (($x16488 (= state_0 0)))
 (and $x16488 (>= 0 now_0) $x15538 $x2110 $x11974 $x17715 $x23197 $x18002 $x2817 $x2455 $x372 $x10531 $x9501 $x2800 $x831 $x4573 $x7389 $x1100 v_1_active_open $x2646 $x25108 $x10360 $x2243 $x24691 $x2491 $x18914 $x2777 $x8804 $x15090 $x25667 $x3415 $x4700 $x3153 $x12516 $x3154 $x18167 $x24202 $x10617 $x14942 $x15156 $x9626 $x23966 $x15296 $x20617 $x4796 $x23954 $x18434 $x15170 $x6115 $x10278 $x21095 $x18411 $x532 $x21015 $x20477 $x16713 $x17976 $x10999 $x7473 $x14506 $x4111 $x15839 $x11344 $x10447 $x11443 $x14269 $x14196 $x2977 $x11345 $x11338 v_1_rtt_active $x12945 $x13471 $x6448 $x6670 $x14250 v_1_rtt_start_new $x9579 $x7571 $x6610 $x5291 $x10595 $x1263 $x1664 $x19482 $x19484 $x4753 $x24830 $x8993 $x22767 $x21761 $x7773 $x5433 $x15127 $x9986 $x15780 $x8607 $x15548 $x12607 $x2851 $x2849 $x11479 $x21653 $x9816 $x19839 $x10145 $x11395 $x1598 v_1_tx_syn_pending $x5908 $x24185 $x8464 $x23856 $x5389 $x24800 $x5858 $x5700 $x6501 $x15278 $x19077 $x9791 $x9312 $x5690 $x5693 $x17288 $x16800 $x2613 $x8453 $x18165 $x8454 $x15622 $x19894 active_1_rtx active_1_user $x8356 $x4306 $x8482 $x21093 $x9155 $x20711 $x21041 $x3974))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x13715 (= due_2_persist due_1_persist)))
 (let (($x5681 (= due_2_delack due_1_delack)))
 (let (($x3353 (= due_2_time_wait due_1_time_wait)))
 (let (($x23316 (= due_2_user due_1_user)))
 (let ((?x1332 (ite (>= v_1_rto_ms 30000) 60000 (* 2 v_1_rto_ms))))
 (let ((?x8898 (+ v_1_tx_syn_time v_1_rto_ms)))
 (let (($x16159 (<= ?x8898 1000)))
 (let ((?x8649 (ite $x16159 ?x1332 v_1_rto_ms)))
 (let ((?x5318 (ite $x16159 1000 v_1_tx_syn_time)))
 (let ((?x13871 (ite $x16159 ?x1332 (+ (- 1000) ?x5318 ?x8649))))
 (let (($x18169 (not active_2_persist)))
 (let (($x10075 (not active_2_delack)))
 (let (($x13679 (= active_2_time_wait active_1_time_wait)))
 (let (($x345 (= active_2_user active_1_user)))
 (let (($x4392 (= v_2_persist_elapsed_ms v_1_persist_elapsed_ms)))
 (let (($x10269 (= v_2_persist_probes 0)))
 (let (($x7461 (= v_2_persist_deadline_ms 0)))
 (let (($x24794 (= v_2_persist_last_ms 0)))
 (let (($x22282 (= v_2_persist_since_ms 0)))
 (let (($x9191 (= v_2_persist_previous_interval_ms v_1_persist_previous_interval_ms)))
 (let (($x16394 (= v_2_persist_interval_ms 1000)))
 (let (($x10863 (not v_2_persist_probe_new)))
 (let (($x7062 (not v_2_persist_probe_sent)))
 (let (($x8444 (not v_2_persist_first)))
 (let (($x7314 (= v_2_persist_was_active v_1_persist_active)))
 (let (($x1756 (not v_2_persist_start)))
 (let (($x13578 (not v_2_persist_eligible)))
 (let (($x6604 (not v_2_persist_active)))
 (let (($x9782 (not v_2_ack_defer_now)))
 (let (($x537 (not v_2_ack_defer_candidate)))
 (let (($x7229 (= v_2_ack_rmss v_1_ack_rmss)))
 (let (($x9192 (= v_2_ack_delay_ms v_1_ack_delay_ms)))
 (let (($x9840 (= 0 v_2_ack_full_segments)))
 (let (($x13646 (= 0 v_2_ack_bytes)))
 (let (($x8107 (= 0 v_2_ack_since_ms)))
 (let (($x8821 (not v_2_ack_pending)))
 (let (($x4712 (= v_2_syn_timeout_eligible $x16159)))
 (let (($x10856 (= v_2_tx_syn_time ?x5318)))
 (let (($x1767 (not (= $x16159 v_2_tx_waiting))))
 (let (($x9233 (not v_2_tx_is_fin)))
 (let (($x3748 (= v_2_tx_previous_rto v_1_rto_ms)))
 (let (($x8887 (= v_2_tx_elapsed (ite $x16159 (+ 1000 (* (- 1) v_1_tx_syn_time)) 0))))
 (let (($x816 (= v_2_tx_retransmitted $x16159)))
 (let (($x4123 (= v_2_tx_max_previous v_1_tx_syn_time)))
 (let (($x24255 (= v_2_tx_eligible v_1_tx_eligible)))
 (let (($x7757 (= v_2_tx_emit_count (ite $x16159 1 0))))
 (let ((?x16619 (ite (and v_1_fin_sent (not v_1_fin_acknowledged)) v_1_tx_fin_time 0)))
 (let (($x2920 (= v_2_tx_fin_time ?x16619)))
 (let (($x16342 (= v_2_tx_time_15 (ite (>= 15 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_15))))
 (let (($x10596 (= v_2_tx_time_14 (ite (>= 14 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_14))))
 (let (($x7411 (= v_2_tx_time_13 (ite (>= 13 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_13))))
 (let (($x7261 (= v_2_tx_time_12 (ite (>= 12 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_12))))
 (let (($x610 (= v_2_tx_time_11 (ite (>= 11 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_11))))
 (let (($x10670 (= v_2_tx_time_10 (ite (>= 10 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_10))))
 (let (($x5303 (= v_2_tx_time_09 (ite (>= 9 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_09))))
 (let (($x7744 (= v_2_tx_time_08 (ite (>= 8 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_08))))
 (let (($x11885 (= v_2_tx_time_07 (ite (>= 7 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_07))))
 (let (($x4537 (= v_2_tx_time_06 (ite (>= 6 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_06))))
 (let (($x16866 (= v_2_tx_time_05 (ite (>= 5 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_05))))
 (let (($x7567 (= v_2_tx_time_04 (ite (>= 4 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_04))))
 (let (($x9236 (= v_2_tx_time_03 (ite (>= 3 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_03))))
 (let (($x198 (= v_2_tx_time_02 (ite (>= 2 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_02))))
 (let (($x18748 (= v_2_tx_time_01 (ite (>= 1 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_01))))
 (let (($x5803 (= v_2_tx_time_00 (ite (>= 0 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_00))))
 (let (($x11741 (= v_2_rto_base_ms v_1_rto_base_ms)))
 (let (($x7182 (= v_2_rtt_samples v_1_rtt_samples)))
 (let (($x8610 (= v_2_rtt_last_ms v_1_rtt_last_ms)))
 (let (($x7031 (not v_2_rtt_sample_was_ambiguous)))
 (let (($x15662 (not v_2_rtt_sample_used)))
 (let (($x3370 (not v_2_rtt_start_new)))
 (let (($x7200 (= v_2_rtt_remaining v_1_rtt_remaining)))
 (let (($x10763 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x23100 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let (($x20285 (= v_2_rtt_sample_at_ms v_1_rtt_sample_at_ms)))
 (let ((?x18767 (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let (($x3331 (and v_1_rtt_active (<= (+ ?x18767 (* (- 1) v_1_rtt_remaining)) 0))))
 (let (($x2555 (= v_2_rtt_ambiguous (ite $x16159 (or $x3331 v_1_rtt_ambiguous) v_1_rtt_ambiguous))))
 (let (($x23232 (= v_2_rtt_active v_1_rtt_active)))
 (let (($x20283 (= v_2_rtt_previous_measured v_1_rtt_previous_measured)))
 (let (($x6162 (= v_2_rtt_measured v_1_rtt_measured)))
 (let (($x16867 (= v_2_rtt_previous_var v_1_rtt_previous_var)))
 (let (($x2902 (= v_2_rtt_previous_srtt v_1_rtt_previous_srtt)))
 (let (($x3873 (= v_2_rtt_error_ms v_1_rtt_error_ms)))
 (let (($x6713 (= v_2_rttvar_ms v_1_rttvar_ms)))
 (let (($x8856 (= v_2_srtt_ms v_1_srtt_ms)))
 (let (($x5369 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x24023 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x245 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x2731 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x10121 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x2735 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x24071 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x10990 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x20623 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x20164 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x9412 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x2733 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x14127 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x8390 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x12040 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x16395 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x7891 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x3499 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x1227 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x7280 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x15149 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x18660 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x1192 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x9410 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x8946 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x15148 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x2533 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x10663 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x1123 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x24252 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x8837 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x14281 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x7520 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x16559 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x5791 (= v_2_take v_1_take)))
 (let (($x18105 (= v_2_snd_wl2 v_1_snd_wl2)))
 (let (($x1434 (= v_2_snd_wl1 v_1_snd_wl1)))
 (let (($x24254 (= v_2_snd_wnd v_1_snd_wnd)))
 (let (($x24265 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x11596 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x5548 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x8156 (= v_2_local_window v_1_local_window)))
 (let (($x2067 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x12042 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x16078 (= v_2_active_open v_1_active_open)))
 (let (($x6755 (= v_2_retries (ite $x16159 (+ 1 v_1_retries) v_1_retries))))
 (let (($x6903 (= v_2_rto_ms ?x8649)))
 (let (($x8155 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x4839 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x12039 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x20237 (= v_2_rcv_nxt v_1_rcv_nxt)))
 (let (($x7310 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x4007 (= v_2_snd_una v_1_snd_una)))
 (let (($x7488 (= v_2_irs v_1_irs)))
 (let (($x12255 (= v_2_iss v_1_iss)))
 (let (($x12036 (= 2 state_2)))
 (let (($x22478 (= state_1 2)))
 (and $x22478 active_1_rtx (= 1000 due_1_rtx) (or (not active_1_user) (<= due_1_rtx due_1_user)) (or (not active_1_time_wait) (<= due_1_rtx due_1_time_wait)) (or (not active_1_delack) (not (<= due_1_delack due_1_rtx))) (or (not active_1_persist) (not (<= due_1_persist due_1_rtx))) $x12036 $x12255 $x7488 $x4007 $x7310 $x20237 $x12039 $x4839 $x8155 $x6903 $x6755 $x16078 $x12042 $x2067 $x8156 $x5548 $x11596 $x24265 $x24254 $x1434 $x18105 $x5791 $x16559 $x7520 $x14281 $x8837 $x24252 $x1123 $x10663 $x2533 $x15148 $x8946 $x9410 $x1192 $x18660 $x15149 $x7280 $x1227 $x3499 $x7891 $x16395 $x12040 $x8390 $x14127 $x2733 $x9412 $x20164 $x20623 $x10990 $x24071 $x2735 $x10121 $x2731 $x245 $x24023 $x5369 $x8856 $x6713 $x3873 $x2902 $x16867 $x6162 $x20283 $x23232 $x2555 $x20285 $x23100 $x10763 $x7200 $x3370 $x15662 $x7031 $x8610 $x7182 $x11741 $x5803 $x18748 $x198 $x9236 $x7567 $x16866 $x4537 $x11885 $x7744 $x5303 $x10670 $x610 $x7261 $x7411 $x10596 $x16342 $x2920 $x7757 $x24255 $x4123 $x816 $x8887 $x3748 $x9233 $x1767 $x10856 v_2_tx_syn_pending $x4712 $x8821 $x8107 $x13646 $x9840 $x9192 $x7229 $x537 $x9782 $x6604 $x13578 $x1756 $x7314 $x8444 $x7062 $x10863 $x16394 $x9191 $x22282 $x24794 $x7461 $x10269 $x4392 active_2_rtx $x345 $x13679 $x10075 $x18169 (= due_2_rtx (+ 1000 ?x13871)) $x23316 $x3353 $x5681 $x13715))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
 (= 27 choice_1))
(assert
 (= 1000 now_2))
(check-sat)
