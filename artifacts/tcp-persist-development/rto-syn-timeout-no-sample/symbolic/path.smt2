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
(declare-fun due_3_persist () Int)
(declare-fun due_3_delack () Int)
(declare-fun due_3_time_wait () Int)
(declare-fun due_3_user () Int)
(declare-fun due_3_rtx () Int)
(declare-fun active_3_persist () Bool)
(declare-fun active_3_delack () Bool)
(declare-fun active_3_time_wait () Bool)
(declare-fun active_3_user () Bool)
(declare-fun active_3_rtx () Bool)
(declare-fun v_3_persist_elapsed_ms () Int)
(declare-fun v_3_persist_probes () Int)
(declare-fun v_3_persist_deadline_ms () Int)
(declare-fun v_3_persist_last_ms () Int)
(declare-fun v_3_persist_since_ms () Int)
(declare-fun v_3_persist_previous_interval_ms () Int)
(declare-fun v_3_persist_interval_ms () Int)
(declare-fun v_3_persist_probe_new () Bool)
(declare-fun v_3_persist_probe_sent () Bool)
(declare-fun v_3_persist_first () Bool)
(declare-fun v_3_persist_was_active () Bool)
(declare-fun v_3_persist_start () Bool)
(declare-fun v_3_persist_eligible () Bool)
(declare-fun v_3_persist_active () Bool)
(declare-fun v_3_ack_defer_now () Bool)
(declare-fun v_3_ack_defer_candidate () Bool)
(declare-fun v_3_ack_rmss () Int)
(declare-fun v_3_ack_delay_ms () Int)
(declare-fun v_3_ack_full_segments () Int)
(declare-fun v_3_ack_bytes () Int)
(declare-fun v_3_ack_since_ms () Int)
(declare-fun v_3_ack_pending () Bool)
(declare-fun v_3_syn_timeout_eligible () Bool)
(declare-fun v_3_tx_syn_pending () Bool)
(declare-fun v_3_tx_syn_time () Int)
(declare-fun v_3_tx_waiting () Bool)
(declare-fun v_3_tx_is_fin () Bool)
(declare-fun v_3_tx_previous_rto () Int)
(declare-fun v_3_tx_elapsed () Int)
(declare-fun v_3_tx_retransmitted () Bool)
(declare-fun v_3_tx_max_previous () Int)
(declare-fun v_3_tx_eligible () Int)
(declare-fun v_3_tx_emit_count () Int)
(declare-fun v_3_tx_fin_time () Int)
(declare-fun v_3_tx_time_15 () Int)
(declare-fun v_3_tx_time_14 () Int)
(declare-fun v_3_tx_time_13 () Int)
(declare-fun v_3_tx_time_12 () Int)
(declare-fun v_3_tx_time_11 () Int)
(declare-fun v_3_tx_time_10 () Int)
(declare-fun v_3_tx_time_09 () Int)
(declare-fun v_3_tx_time_08 () Int)
(declare-fun v_3_tx_time_07 () Int)
(declare-fun v_3_tx_time_06 () Int)
(declare-fun v_3_tx_time_05 () Int)
(declare-fun v_3_tx_time_04 () Int)
(declare-fun v_3_tx_time_03 () Int)
(declare-fun v_3_tx_time_02 () Int)
(declare-fun v_3_tx_time_01 () Int)
(declare-fun v_3_tx_time_00 () Int)
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
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
 (let (($x8264 (= due_1_persist due_0_persist)))
 (let (($x14734 (= due_1_delack due_0_delack)))
 (let (($x9899 (= due_1_time_wait due_0_time_wait)))
 (let (($x20551 (= due_1_user 30000)))
 (let (($x20549 (= due_1_rtx 1000)))
 (let (($x20606 (not active_1_persist)))
 (let (($x14718 (not active_1_delack)))
 (let (($x14717 (not active_1_time_wait)))
 (let (($x3287 (= v_1_persist_elapsed_ms 0)))
 (let (($x5155 (= v_1_persist_probes 0)))
 (let (($x19811 (= v_1_persist_deadline_ms 0)))
 (let (($x21799 (= v_1_persist_last_ms 0)))
 (let (($x19812 (= v_1_persist_since_ms 0)))
 (let (($x5138 (= v_1_persist_previous_interval_ms 1000)))
 (let (($x5054 (= v_1_persist_interval_ms 1000)))
 (let (($x14721 (not v_1_persist_probe_new)))
 (let (($x18388 (not v_1_persist_probe_sent)))
 (let (($x14719 (not v_1_persist_first)))
 (let (($x14722 (not v_1_persist_was_active)))
 (let (($x20705 (not v_1_persist_start)))
 (let (($x12134 (not v_1_persist_eligible)))
 (let (($x6653 (not v_1_persist_active)))
 (let (($x20704 (not v_1_ack_defer_now)))
 (let (($x23437 (not v_1_ack_defer_candidate)))
 (let (($x1435 (= v_1_ack_rmss 4)))
 (let (($x23058 (= v_1_ack_delay_ms 40)))
 (let (($x9764 (= 0 v_1_ack_full_segments)))
 (let (($x21904 (= 0 v_1_ack_bytes)))
 (let (($x9355 (= 0 v_1_ack_since_ms)))
 (let (($x20702 (not v_1_ack_pending)))
 (let (($x20559 (not v_1_syn_timeout_eligible)))
 (let (($x21620 (= v_1_tx_syn_time 0)))
 (let (($x20703 (not v_1_tx_waiting)))
 (let (($x16712 (not v_1_tx_is_fin)))
 (let (($x17549 (= v_1_tx_previous_rto 1000)))
 (let (($x9054 (= v_1_tx_elapsed 0)))
 (let (($x16713 (not v_1_tx_retransmitted)))
 (let (($x785 (= v_1_tx_max_previous 0)))
 (let (($x17292 (= v_1_tx_eligible 0)))
 (let (($x16935 (= v_1_tx_emit_count 0)))
 (let (($x14399 (= v_1_tx_fin_time 0)))
 (let (($x10436 (= v_1_tx_time_15 0)))
 (let (($x22645 (= v_1_tx_time_14 0)))
 (let (($x8501 (= v_1_tx_time_13 0)))
 (let (($x24943 (= v_1_tx_time_12 0)))
 (let (($x2673 (= v_1_tx_time_11 0)))
 (let (($x499 (= v_1_tx_time_10 0)))
 (let (($x10287 (= v_1_tx_time_09 0)))
 (let (($x6484 (= v_1_tx_time_08 0)))
 (let (($x16595 (= v_1_tx_time_07 0)))
 (let (($x11078 (= v_1_tx_time_06 0)))
 (let (($x1970 (= v_1_tx_time_05 0)))
 (let (($x8864 (= v_1_tx_time_04 0)))
 (let (($x15590 (= v_1_tx_time_03 0)))
 (let (($x7301 (= v_1_tx_time_02 0)))
 (let (($x1051 (= v_1_tx_time_01 0)))
 (let (($x22783 (= v_1_tx_time_00 0)))
 (let (($x10835 (= v_1_rto_base_ms 1000)))
 (let (($x20569 (= v_1_rtt_samples 0)))
 (let (($x5329 (= v_1_rtt_last_ms 0)))
 (let (($x20633 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x16740 (not v_1_rtt_sample_used)))
 (let (($x16782 (= v_1_rtt_remaining 1)))
 (let (($x17816 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x17826 (= v_1_rtt_start_ms 0)))
 (let (($x18360 (= v_1_rtt_sample_at_ms 0)))
 (let (($x17817 (not v_1_rtt_ambiguous)))
 (let (($x20643 (not v_1_rtt_previous_measured)))
 (let (($x17821 (not v_1_rtt_measured)))
 (let (($x24953 (= v_1_rtt_previous_var 0.0)))
 (let (($x7388 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x7391 (= v_1_rtt_error_ms 0.0)))
 (let (($x7389 (= v_1_rttvar_ms 0.0)))
 (let (($x5481 (= v_1_srtt_ms 0.0)))
 (let (($x17318 (not v_1_rx_fin_consumed)))
 (let (($x12665 (not v_1_rx_fin_done)))
 (let (($x2123 (= v_1_rx_fin_offset 0)))
 (let (($x14023 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x10672 (not v_1_rx_fin_pending)))
 (let (($x15855 (not v_1_fin_acknowledged)))
 (let (($x13865 (= v_1_fin_seq (_ bv0 32))))
 (let (($x20518 (not v_1_fin_sent)))
 (let (($x3230 (not v_1_fin_requested)))
 (let (($x23256 (not v_1_ack_window_update)))
 (let (($x7385 (not v_1_ack_advance)))
 (let (($x15084 (not v_1_ack_is_future)))
 (let (($x14725 (not v_1_ack_is_new)))
 (let (($x14178 (= v_1_ack_delta 0)))
 (let (($x12984 (not v_1_seg_acceptable)))
 (let (($x7612 (not v_1_rx_acceptable)))
 (let (($x25648 (= v_1_rx_advance 0)))
 (let (($x7666 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x7624 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x7607 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x18369 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x25655 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x9370 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x23401 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x6470 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x18365 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x4696 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x5953 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x9247 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x14623 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x7761 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x14624 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x7711 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x7736 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x13995 (= v_1_take 0)))
 (let (($x24894 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x10909 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x10911 (= v_1_snd_wnd 8)))
 (let (($x23394 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x7720 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x7690 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x7631 (= v_1_local_window 16)))
 (let (($x7645 (= v_1_msl_ms 60000)))
 (let (($x4755 (= v_1_user_timeout_ms 30000)))
 (let (($x20197 (= 0 v_1_retries)))
 (let (($x16488 (= 1000 v_1_rto_ms)))
 (let (($x12532 (= v_1_tx_flags "S")))
 (let (($x11073 (= v_1_tx_ack (_ bv0 32))))
 (let (($x4416 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x18343 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x18249 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x7251 (= v_1_snd_una (_ bv1000 32))))
 (let (($x7623 (= v_1_irs (_ bv0 32))))
 (let (($x19486 (= v_1_iss (_ bv1000 32))))
 (let (($x4811 (= 2 state_1)))
 (let (($x7112 (not active_0_persist)))
 (let (($x18247 (or $x7112 (not (<= due_0_persist 0)))))
 (let (($x1142 (not active_0_delack)))
 (let (($x21718 (or $x1142 (not (<= due_0_delack 0)))))
 (let (($x6546 (not active_0_time_wait)))
 (let (($x194 (or $x6546 (not (<= due_0_time_wait 0)))))
 (let (($x20596 (not active_0_user)))
 (let (($x5110 (or $x20596 (not (<= due_0_user 0)))))
 (let (($x4641 (not active_0_rtx)))
 (let (($x8269 (or $x4641 (not (<= due_0_rtx 0)))))
 (let (($x7570 (= state_0 0)))
 (and $x7570 (>= 0 now_0) $x8269 $x5110 $x194 $x21718 $x18247 $x4811 $x19486 $x7623 $x7251 $x18249 $x18343 $x4416 $x11073 $x12532 $x16488 $x20197 v_1_active_open $x4755 $x7645 $x7631 $x7690 $x7720 $x23394 $x10911 $x10909 $x24894 $x13995 $x7736 $x7711 $x14624 $x7761 $x14623 $x9247 $x5953 $x4696 $x18365 $x6470 $x23401 $x9370 $x25655 $x18369 $x7607 $x7624 $x7666 $x25648 $x7612 $x12984 $x14178 $x14725 $x15084 $x7385 $x23256 $x3230 $x20518 $x13865 $x15855 $x10672 $x14023 $x2123 $x12665 $x17318 $x5481 $x7389 $x7391 $x7388 $x24953 $x17821 $x20643 v_1_rtt_active $x17817 $x18360 $x17826 $x17816 $x16782 v_1_rtt_start_new $x16740 $x20633 $x5329 $x20569 $x10835 $x22783 $x1051 $x7301 $x15590 $x8864 $x1970 $x11078 $x16595 $x6484 $x10287 $x499 $x2673 $x24943 $x8501 $x22645 $x10436 $x14399 $x16935 $x17292 $x785 $x16713 $x9054 $x17549 $x16712 $x20703 $x21620 v_1_tx_syn_pending $x20559 $x20702 $x9355 $x21904 $x9764 $x23058 $x1435 $x23437 $x20704 $x6653 $x12134 $x20705 $x14722 $x14719 $x18388 $x14721 $x5054 $x5138 $x19812 $x21799 $x19811 $x5155 $x3287 active_1_rtx active_1_user $x14717 $x14718 $x20606 $x20549 $x20551 $x9899 $x14734 $x8264))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x14149 (= due_2_persist due_1_persist)))
 (let (($x17059 (= due_2_delack due_1_delack)))
 (let (($x15775 (= due_2_time_wait due_1_time_wait)))
 (let (($x220 (= due_2_user due_1_user)))
 (let ((?x14386 (ite (>= v_1_rto_ms 30000) 60000 (* 2 v_1_rto_ms))))
 (let ((?x5316 (+ v_1_tx_syn_time v_1_rto_ms)))
 (let (($x18892 (<= ?x5316 1000)))
 (let ((?x22938 (ite $x18892 ?x14386 v_1_rto_ms)))
 (let ((?x2102 (ite $x18892 1000 v_1_tx_syn_time)))
 (let (($x17311 (not active_2_persist)))
 (let (($x1377 (not active_2_delack)))
 (let (($x17065 (= active_2_time_wait active_1_time_wait)))
 (let (($x8132 (= active_2_user active_1_user)))
 (let (($x16136 (= v_2_persist_elapsed_ms v_1_persist_elapsed_ms)))
 (let (($x25674 (= v_2_persist_probes 0)))
 (let (($x25676 (= v_2_persist_deadline_ms 0)))
 (let (($x19240 (= v_2_persist_last_ms 0)))
 (let (($x17551 (= v_2_persist_since_ms 0)))
 (let (($x13674 (= v_2_persist_previous_interval_ms v_1_persist_previous_interval_ms)))
 (let (($x14606 (= v_2_persist_interval_ms 1000)))
 (let (($x17897 (not v_2_persist_probe_new)))
 (let (($x18099 (not v_2_persist_probe_sent)))
 (let (($x7600 (not v_2_persist_first)))
 (let (($x1162 (= v_2_persist_was_active v_1_persist_active)))
 (let (($x21719 (not v_2_persist_start)))
 (let (($x23393 (not v_2_persist_eligible)))
 (let (($x23433 (not v_2_persist_active)))
 (let (($x22782 (not v_2_ack_defer_now)))
 (let (($x17823 (not v_2_ack_defer_candidate)))
 (let (($x557 (= v_2_ack_rmss v_1_ack_rmss)))
 (let (($x7635 (= v_2_ack_delay_ms v_1_ack_delay_ms)))
 (let (($x13669 (= 0 v_2_ack_full_segments)))
 (let (($x743 (= 0 v_2_ack_bytes)))
 (let (($x4149 (= 0 v_2_ack_since_ms)))
 (let (($x7633 (not v_2_ack_pending)))
 (let (($x9793 (not v_2_tx_is_fin)))
 (let (($x3000 (= v_2_tx_previous_rto v_1_rto_ms)))
 (let (($x2310 (= v_2_tx_elapsed (ite $x18892 (+ 1000 (* (- 1) v_1_tx_syn_time)) 0))))
 (let (($x8210 (= v_2_tx_max_previous v_1_tx_syn_time)))
 (let (($x7370 (= v_2_tx_eligible v_1_tx_eligible)))
 (let ((?x7611 (ite (and v_1_fin_sent (not v_1_fin_acknowledged)) v_1_tx_fin_time 0)))
 (let (($x7651 (= v_2_tx_fin_time ?x7611)))
 (let (($x774 (= v_2_tx_time_15 (ite (>= 15 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_15))))
 (let (($x14928 (= v_2_tx_time_14 (ite (>= 14 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_14))))
 (let (($x45 (= v_2_tx_time_13 (ite (>= 13 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_13))))
 (let (($x12385 (= v_2_tx_time_12 (ite (>= 12 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_12))))
 (let (($x1061 (= v_2_tx_time_11 (ite (>= 11 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_11))))
 (let (($x15768 (= v_2_tx_time_10 (ite (>= 10 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_10))))
 (let (($x15769 (= v_2_tx_time_09 (ite (>= 9 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_09))))
 (let (($x13701 (= v_2_tx_time_08 (ite (>= 8 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_08))))
 (let (($x22462 (= v_2_tx_time_07 (ite (>= 7 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_07))))
 (let (($x16382 (= v_2_tx_time_06 (ite (>= 6 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_06))))
 (let (($x6488 (= v_2_tx_time_05 (ite (>= 5 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_05))))
 (let (($x16381 (= v_2_tx_time_04 (ite (>= 4 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_04))))
 (let (($x10669 (= v_2_tx_time_03 (ite (>= 3 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_03))))
 (let (($x13668 (= v_2_tx_time_02 (ite (>= 2 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_02))))
 (let (($x22963 (= v_2_tx_time_01 (ite (>= 1 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_01))))
 (let (($x8141 (= v_2_tx_time_00 (ite (>= 0 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_00))))
 (let (($x1117 (= v_2_rto_base_ms v_1_rto_base_ms)))
 (let (($x8868 (= v_2_rtt_samples v_1_rtt_samples)))
 (let (($x19773 (= v_2_rtt_last_ms v_1_rtt_last_ms)))
 (let (($x19122 (not v_2_rtt_sample_was_ambiguous)))
 (let (($x5462 (not v_2_rtt_sample_used)))
 (let (($x20065 (not v_2_rtt_start_new)))
 (let (($x11687 (= v_2_rtt_remaining v_1_rtt_remaining)))
 (let (($x16166 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x7128 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let (($x18634 (= v_2_rtt_sample_at_ms v_1_rtt_sample_at_ms)))
 (let ((?x643 (+ (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una))) (* (- 1) v_1_rtt_remaining))))
 (let (($x7466 (or (and v_1_rtt_active (<= ?x643 0)) v_1_rtt_ambiguous)))
 (let (($x10466 (= v_2_rtt_active v_1_rtt_active)))
 (let (($x5836 (= v_2_rtt_previous_measured v_1_rtt_previous_measured)))
 (let (($x18278 (= v_2_rtt_measured v_1_rtt_measured)))
 (let (($x8867 (= v_2_rtt_previous_var v_1_rtt_previous_var)))
 (let (($x4545 (= v_2_rtt_previous_srtt v_1_rtt_previous_srtt)))
 (let (($x14480 (= v_2_rtt_error_ms v_1_rtt_error_ms)))
 (let (($x4626 (= v_2_rttvar_ms v_1_rttvar_ms)))
 (let (($x11735 (= v_2_srtt_ms v_1_srtt_ms)))
 (let (($x15887 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x10501 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x15886 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x206 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x15885 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x7890 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x15884 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x16848 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x15883 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x8153 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x15882 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x16140 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x15881 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x8182 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x15880 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x10663 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x15879 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x5928 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x15878 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x22369 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x15877 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x7652 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x15876 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x15205 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x15875 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x9963 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x15874 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x9906 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x15873 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x7485 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x15872 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x17027 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x15871 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x9751 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x15870 (= v_2_take v_1_take)))
 (let (($x822 (= v_2_snd_wl2 v_1_snd_wl2)))
 (let (($x15869 (= v_2_snd_wl1 v_1_snd_wl1)))
 (let (($x997 (= v_2_snd_wnd v_1_snd_wnd)))
 (let (($x15868 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x14145 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x15867 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x4955 (= v_2_local_window v_1_local_window)))
 (let (($x15866 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x19059 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x15865 (= v_2_active_open v_1_active_open)))
 (let (($x3594 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x15863 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x11848 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x16668 (= v_2_rcv_nxt v_1_rcv_nxt)))
 (let (($x9539 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x15862 (= v_2_snd_una v_1_snd_una)))
 (let (($x22916 (= v_2_irs v_1_irs)))
 (let (($x15861 (= v_2_iss v_1_iss)))
 (let (($x13418 (= 2 state_2)))
 (let (($x16931 (= state_1 2)))
 (and $x16931 active_1_rtx (= 1000 due_1_rtx) (or (not active_1_user) (<= due_1_rtx due_1_user)) (or (not active_1_time_wait) (<= due_1_rtx due_1_time_wait)) (or (not active_1_delack) (not (<= due_1_delack due_1_rtx))) (or (not active_1_persist) (not (<= due_1_persist due_1_rtx))) $x13418 $x15861 $x22916 $x15862 $x9539 $x16668 $x11848 $x15863 $x3594 (= v_2_rto_ms ?x22938) (= v_2_retries (ite $x18892 (+ 1 v_1_retries) v_1_retries)) $x15865 $x19059 $x15866 $x4955 $x15867 $x14145 $x15868 $x997 $x15869 $x822 $x15870 $x9751 $x15871 $x17027 $x15872 $x7485 $x15873 $x9906 $x15874 $x9963 $x15875 $x15205 $x15876 $x7652 $x15877 $x22369 $x15878 $x5928 $x15879 $x10663 $x15880 $x8182 $x15881 $x16140 $x15882 $x8153 $x15883 $x16848 $x15884 $x7890 $x15885 $x206 $x15886 $x10501 $x15887 $x11735 $x4626 $x14480 $x4545 $x8867 $x18278 $x5836 $x10466 (= v_2_rtt_ambiguous (ite $x18892 $x7466 v_1_rtt_ambiguous)) $x18634 $x7128 $x16166 $x11687 $x20065 $x5462 $x19122 $x19773 $x8868 $x1117 $x8141 $x22963 $x13668 $x10669 $x16381 $x6488 $x16382 $x22462 $x13701 $x15769 $x15768 $x1061 $x12385 $x45 $x14928 $x774 $x7651 (= v_2_tx_emit_count (ite $x18892 1 0)) $x7370 $x8210 (= v_2_tx_retransmitted $x18892) $x2310 $x3000 $x9793 (not (= $x18892 v_2_tx_waiting)) (= v_2_tx_syn_time ?x2102) v_2_tx_syn_pending (= v_2_syn_timeout_eligible $x18892) $x7633 $x4149 $x743 $x13669 $x7635 $x557 $x17823 $x22782 $x23433 $x23393 $x21719 $x1162 $x7600 $x18099 $x17897 $x14606 $x13674 $x17551 $x19240 $x25676 $x25674 $x16136 active_2_rtx $x8132 $x17065 $x1377 $x17311 (= due_2_rtx (+ 1000 (ite $x18892 ?x14386 (+ (- 1000) ?x2102 ?x22938)))) $x220 $x15775 $x17059 $x14149)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 (let (($x13528 (= due_3_persist due_2_persist)))
 (let (($x10232 (= due_3_delack due_2_delack)))
 (let (($x17881 (= due_3_time_wait due_2_time_wait)))
 (let (($x17375 (= due_3_user due_2_user)))
 (let ((?x24041 (seq.len v_2_rtx_buf)))
 (let (($x23940 (<= 1 ?x24041)))
 (let (($x16909 (and v_2_persist_active $x23940)))
 (let (($x16903 (not active_3_persist)))
 (let (($x16908 (not active_3_delack)))
 (let (($x11683 (= active_3_time_wait active_2_time_wait)))
 (let (($x16907 (not active_3_user)))
 (let (($x25020 (= v_3_persist_elapsed_ms v_2_persist_elapsed_ms)))
 (let (($x2243 (= v_3_persist_probes 0)))
 (let (($x8536 (= v_3_persist_deadline_ms 0)))
 (let (($x16936 (= v_3_persist_last_ms 0)))
 (let (($x10535 (= v_3_persist_since_ms 0)))
 (let (($x15743 (= v_3_persist_previous_interval_ms v_2_persist_previous_interval_ms)))
 (let (($x17519 (= v_3_persist_interval_ms 1000)))
 (let (($x24977 (not v_3_persist_probe_new)))
 (let (($x5162 (not v_3_persist_probe_sent)))
 (let (($x2122 (not v_3_persist_first)))
 (let (($x12121 (= v_3_persist_was_active v_2_persist_active)))
 (let (($x13518 (not v_3_persist_start)))
 (let (($x5167 (not v_3_persist_eligible)))
 (let (($x25362 (not v_3_persist_active)))
 (let (($x10784 (not v_3_ack_defer_now)))
 (let (($x24928 (not v_3_ack_defer_candidate)))
 (let (($x2279 (= v_3_ack_rmss v_2_ack_rmss)))
 (let (($x1750 (= v_3_ack_delay_ms v_2_ack_delay_ms)))
 (let (($x14458 (= v_3_ack_full_segments 0)))
 (let (($x13643 (= v_3_ack_bytes 0)))
 (let (($x2312 (= v_3_ack_since_ms 0)))
 (let (($x4455 (not v_3_ack_pending)))
 (let (($x1823 (not v_3_syn_timeout_eligible)))
 (let (($x18201 (not v_3_tx_syn_pending)))
 (let (($x20519 (= v_3_tx_syn_time 0)))
 (let (($x6911 (not v_3_tx_waiting)))
 (let (($x4457 (= v_3_tx_is_fin v_2_tx_is_fin)))
 (let (($x4465 (= v_3_tx_previous_rto v_2_tx_previous_rto)))
 (let (($x16719 (= v_3_tx_elapsed v_2_tx_elapsed)))
 (let (($x86 (not v_3_tx_retransmitted)))
 (let (($x10765 (= v_3_tx_max_previous v_2_tx_max_previous)))
 (let (($x17880 (= v_3_tx_eligible v_2_tx_eligible)))
 (let (($x20602 (= v_3_tx_emit_count v_2_tx_emit_count)))
 (let ((?x22800 (ite (and v_2_fin_sent (not v_2_fin_acknowledged)) v_2_tx_fin_time 0)))
 (let (($x11758 (= v_3_tx_fin_time ?x22800)))
 (let (($x11862 (= v_3_tx_time_15 (ite (>= 15 ?x24041) 0 v_2_tx_time_15))))
 (let (($x10498 (= v_3_tx_time_14 (ite (>= 14 ?x24041) 0 v_2_tx_time_14))))
 (let (($x17949 (= v_3_tx_time_13 (ite (>= 13 ?x24041) 0 v_2_tx_time_13))))
 (let (($x7230 (= v_3_tx_time_12 (ite (>= 12 ?x24041) 0 v_2_tx_time_12))))
 (let (($x16720 (= v_3_tx_time_11 (ite (>= 11 ?x24041) 0 v_2_tx_time_11))))
 (let (($x5945 (= v_3_tx_time_10 (ite (>= 10 ?x24041) 0 v_2_tx_time_10))))
 (let (($x23891 (= v_3_tx_time_09 (ite (>= 9 ?x24041) 0 v_2_tx_time_09))))
 (let (($x23894 (= v_3_tx_time_08 (ite (>= 8 ?x24041) 0 v_2_tx_time_08))))
 (let (($x23898 (= v_3_tx_time_07 (ite (>= 7 ?x24041) 0 v_2_tx_time_07))))
 (let (($x23903 (= v_3_tx_time_06 (ite (>= 6 ?x24041) 0 v_2_tx_time_06))))
 (let (($x23900 (= v_3_tx_time_05 (ite (>= 5 ?x24041) 0 v_2_tx_time_05))))
 (let (($x23907 (= v_3_tx_time_04 (ite (>= 4 ?x24041) 0 v_2_tx_time_04))))
 (let (($x2089 (= v_3_tx_time_03 (ite (>= 3 ?x24041) 0 v_2_tx_time_03))))
 (let (($x11508 (= v_3_tx_time_02 (ite (>= 2 ?x24041) 0 v_2_tx_time_02))))
 (let (($x1371 (= v_3_tx_time_01 (ite (>= 1 ?x24041) 0 v_2_tx_time_01))))
 (let (($x23858 (= v_3_tx_time_00 (ite (>= 0 ?x24041) 0 v_2_tx_time_00))))
 (let ((?x1432 (+ 1010 (* (- 1) v_2_rtt_start_ms))))
 (let (($x24117 (not v_2_rtt_ambiguous)))
 (let ((?x5922 (ubv_to_int (bvadd v_2_rtt_end (bvmul (_ bv4294967295 32) v_2_snd_una)))))
 (let ((?x4468 (ubv_to_int (bvadd (_ bv1001 32) (bvmul (_ bv4294967295 32) v_2_snd_una)))))
 (let (($x230 (>= ?x4468 ?x5922)))
 (let (($x4759 (and v_2_rtt_active $x230 $x24117)))
 (let ((?x6316 (ite $x4759 ?x1432 v_2_rtt_last_ms)))
 (let ((?x1434 (to_real ?x6316)))
 (let ((?x5837 (+ v_2_srtt_ms (* (- 1.0) ?x1434))))
 (let ((?x17598 (ite $x4759 (ite (>= ?x5837 0.0) ?x5837 (+ (* (- 1.0) v_2_srtt_ms) ?x1434)) v_2_rtt_error_ms)))
 (let ((?x8813 (* (/ 3.0 4.0) v_2_rttvar_ms)))
 (let ((?x16184 (ite $x4759 (ite v_2_rtt_measured (+ ?x8813 (* (/ 1.0 4.0) ?x17598)) (* (/ 1.0 2.0) ?x1434)) v_2_rttvar_ms)))
 (let ((?x9052 (ite v_2_rtt_measured (+ (* (/ 7.0 8.0) v_2_srtt_ms) (* (/ 1.0 8.0) ?x1434)) ?x1434)))
 (let ((?x11623 (ite $x4759 ?x9052 v_2_srtt_ms)))
 (let ((?x19107 (+ (* (- 1.0) ?x11623) (* (- 1.0) (ite (<= ?x16184 (/ 1.0 4.0)) 1.0 (* 4.0 ?x16184))))))
 (let ((?x17334 (to_int ?x19107)))
 (let ((?x8105 (ite (<= ?x17334 (- 1000)) (* (- 1) ?x17334) 1000)))
 (let (($x9078 (= v_3_rto_base_ms (ite $x4759 (ite (<= 60000 ?x8105) 60000 ?x8105) v_2_rto_base_ms))))
 (let (($x20422 (= v_3_rtt_sample_was_ambiguous (and v_2_rtt_active v_2_rtt_ambiguous))))
 (let (($x22934 (not v_3_rtt_start_new)))
 (let ((?x10017 (* (- 1) ?x4468)))
 (let ((?x6917 (+ ?x5922 ?x10017)))
 (let ((?x11879 (ite (and v_2_rtt_active (not (<= v_2_rtt_remaining ?x6917))) ?x6917 v_2_rtt_remaining)))
 (let (($x7478 (and v_2_rtt_active $x230)))
 (let (($x1153 (= v_3_rtt_end v_2_rtt_end)))
 (let (($x9075 (= v_3_rtt_start_ms v_2_rtt_start_ms)))
 (let (($x8146 (= v_3_rtt_previous_measured (ite $x4759 v_2_rtt_measured v_2_rtt_previous_measured))))
 (let (($x9571 (= v_3_rtt_previous_var (ite $x4759 v_2_rttvar_ms v_2_rtt_previous_var))))
 (let (($x25321 (= v_3_rtt_previous_srtt (ite $x4759 v_2_srtt_ms v_2_rtt_previous_srtt))))
 (let (($x1503 (= v_3_rx_fin_consumed v_2_rx_fin_consumed)))
 (let (($x1428 (= v_3_rx_fin_done v_2_rx_fin_done)))
 (let (($x1319 (= v_3_rx_fin_offset v_2_rx_fin_offset)))
 (let (($x1480 (= v_3_rx_fin_seq v_2_rx_fin_seq)))
 (let (($x1518 (= v_3_rx_fin_pending v_2_rx_fin_pending)))
 (let (($x23391 (= v_3_fin_acknowledged v_2_fin_acknowledged)))
 (let (($x1406 (= v_3_fin_seq v_2_fin_seq)))
 (let (($x2308 (= v_3_fin_sent v_2_fin_sent)))
 (let (($x15557 (= v_3_fin_requested v_2_fin_requested)))
 (let (($x15222 (= v_3_ack_window_update v_2_ack_window_update)))
 (let (($x10826 (= v_3_ack_advance v_2_ack_advance)))
 (let (($x23001 (= v_3_ack_is_future v_2_ack_is_future)))
 (let (($x2297 (= v_3_ack_is_new v_2_ack_is_new)))
 (let (($x1303 (= v_3_ack_delta v_2_ack_delta)))
 (let (($x3633 (= v_3_seg_acceptable v_2_seg_acceptable)))
 (let (($x141 (= v_3_rx_acceptable v_2_rx_acceptable)))
 (let (($x14141 (= v_3_rx_advance v_2_rx_advance)))
 (let (($x12217 (= v_3_rx_slot_15 v_2_rx_slot_15)))
 (let (($x14736 (= v_3_rx_slot_14 v_2_rx_slot_14)))
 (let (($x12149 (= v_3_rx_slot_13 v_2_rx_slot_13)))
 (let (($x12150 (= v_3_rx_slot_12 v_2_rx_slot_12)))
 (let (($x4536 (= v_3_rx_slot_11 v_2_rx_slot_11)))
 (let (($x1421 (= v_3_rx_slot_10 v_2_rx_slot_10)))
 (let (($x23231 (= v_3_rx_slot_09 v_2_rx_slot_09)))
 (let (($x4528 (= v_3_rx_slot_08 v_2_rx_slot_08)))
 (let (($x212 (= v_3_rx_slot_07 v_2_rx_slot_07)))
 (let (($x3378 (= v_3_rx_slot_06 v_2_rx_slot_06)))
 (let (($x17359 (= v_3_rx_slot_05 v_2_rx_slot_05)))
 (let (($x12059 (= v_3_rx_slot_04 v_2_rx_slot_04)))
 (let (($x14804 (= v_3_rx_slot_03 v_2_rx_slot_03)))
 (let (($x17548 (= v_3_rx_slot_02 v_2_rx_slot_02)))
 (let (($x12223 (= v_3_rx_slot_01 v_2_rx_slot_01)))
 (let (($x9522 (= v_3_rx_slot_00 v_2_rx_slot_00)))
 (let (($x12225 (= v_3_rx_chunk v_2_rx_chunk)))
 (let (($x12229 (= v_3_take v_2_take)))
 (let (($x13382 (= v_3_snd_wl2 (_ bv1001 32))))
 (let (($x8135 (= v_3_snd_wl1 (_ bv9000 32))))
 (let (($x2672 (= v_3_snd_wnd 16)))
 (let (($x24981 (= v_3_rcv_buf v_2_rcv_buf)))
 (let (($x16213 (= v_3_rtx_buf v_2_rtx_buf)))
 (let (($x9228 (= v_3_snd_buf v_2_snd_buf)))
 (let (($x5532 (= v_3_local_window v_2_local_window)))
 (let (($x8937 (= v_3_msl_ms v_2_msl_ms)))
 (let (($x9230 (= v_3_user_timeout_ms v_2_user_timeout_ms)))
 (let (($x8481 (= v_3_active_open v_2_active_open)))
 (let (($x8848 (= v_3_retries v_2_retries)))
 (let (($x8916 (= 3000 v_3_rto_ms)))
 (let (($x5121 (= v_3_tx_flags v_2_tx_flags)))
 (let (($x10846 (= v_3_tx_ack v_2_tx_ack)))
 (let (($x16878 (= v_3_tx_seq v_2_tx_seq)))
 (let (($x24883 (= v_3_rcv_nxt (_ bv9001 32))))
 (let (($x20771 (= v_3_snd_nxt v_2_snd_nxt)))
 (let (($x5163 (= v_3_snd_una (_ bv1001 32))))
 (let (($x16617 (= v_3_irs (_ bv9000 32))))
 (let (($x23919 (= v_3_iss v_2_iss)))
 (let (($x23923 (= 4 state_3)))
 (let (($x17311 (not active_2_persist)))
 (let (($x7167 (or $x17311 (not (<= due_2_persist 1010)))))
 (let (($x1377 (not active_2_delack)))
 (let (($x2887 (or $x1377 (not (<= due_2_delack 1010)))))
 (let (($x24902 (or (not active_2_time_wait) (not (<= due_2_time_wait 1010)))))
 (let (($x22490 (or (not active_2_user) (not (<= due_2_user 1010)))))
 (let (($x4424 (or (not active_2_rtx) (not (<= due_2_rtx 1010)))))
 (let (($x24142 (= 1 v_2_retries)))
 (let (($x4426 (= v_2_snd_nxt (_ bv1001 32))))
 (let (($x5352 (= state_2 2)))
 (and $x5352 $x4426 $x24142 $x4424 $x22490 $x24902 $x2887 $x7167 $x23923 $x23919 $x16617 $x5163 $x20771 $x24883 $x16878 $x10846 $x5121 $x8916 $x8848 $x8481 $x9230 $x8937 $x5532 $x9228 $x16213 $x24981 $x2672 $x8135 $x13382 $x12229 $x12225 $x9522 $x12223 $x17548 $x14804 $x12059 $x17359 $x3378 $x212 $x4528 $x23231 $x1421 $x4536 $x12150 $x12149 $x14736 $x12217 $x14141 $x141 $x3633 $x1303 $x2297 $x23001 $x10826 $x15222 $x15557 $x2308 $x1406 $x23391 $x1518 $x1480 $x1319 $x1428 $x1503 (= v_3_srtt_ms ?x11623) (= v_3_rttvar_ms ?x16184) (= v_3_rtt_error_ms ?x17598) $x25321 $x9571 (= v_3_rtt_measured (or v_2_rtt_measured $x4759)) $x8146 (= v_3_rtt_active (and v_2_rtt_active (not $x7478))) (= v_3_rtt_ambiguous (and (not $x7478) v_2_rtt_ambiguous)) (= v_3_rtt_sample_at_ms (ite $x4759 1010 v_2_rtt_sample_at_ms)) $x9075 $x1153 (= v_3_rtt_remaining (ite $x7478 0 ?x11879)) $x22934 (= v_3_rtt_sample_used $x4759) $x20422 (= v_3_rtt_last_ms ?x6316) (= v_3_rtt_samples (+ v_2_rtt_samples (ite $x4759 1 0))) $x9078 $x23858 $x1371 $x11508 $x2089 $x23907 $x23900 $x23903 $x23898 $x23894 $x23891 $x5945 $x16720 $x7230 $x17949 $x10498 $x11862 $x11758 $x20602 $x17880 $x10765 $x86 $x16719 $x4465 $x4457 $x6911 $x20519 $x18201 $x1823 $x4455 $x2312 $x13643 $x14458 $x1750 $x2279 $x24928 $x10784 $x25362 $x5167 $x13518 $x12121 $x2122 $x5162 $x24977 $x17519 $x15743 $x10535 $x16936 $x8536 $x2243 $x25020 (= active_3_rtx $x16909) $x16907 $x11683 $x16908 $x16903 (= due_3_rtx (ite $x16909 4010 due_2_rtx)) $x17375 $x17881 $x10232 $x13528)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
