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
(declare-fun input_1_net.syn_seq () (_ BitVec 32))
(declare-fun choice_2 () Int)
(declare-fun now_3 () Int)
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
 (let (($x6224 (= due_1_persist due_0_persist)))
 (let (($x2869 (= due_1_delack due_0_delack)))
 (let (($x3734 (= due_1_time_wait due_0_time_wait)))
 (let (($x22617 (= due_1_user due_0_user)))
 (let (($x24148 (= due_1_rtx due_0_rtx)))
 (let (($x21554 (not active_1_persist)))
 (let (($x5254 (not active_1_delack)))
 (let (($x20162 (not active_1_time_wait)))
 (let (($x17447 (not active_1_user)))
 (let (($x6489 (not active_1_rtx)))
 (let (($x10988 (= v_1_persist_elapsed_ms 0)))
 (let (($x1902 (= v_1_persist_probes 0)))
 (let (($x18992 (= v_1_persist_deadline_ms 0)))
 (let (($x19338 (= v_1_persist_last_ms 0)))
 (let (($x8624 (= v_1_persist_since_ms 0)))
 (let (($x24132 (= v_1_persist_previous_interval_ms 1000)))
 (let (($x24131 (= v_1_persist_interval_ms 1000)))
 (let (($x9184 (not v_1_persist_probe_new)))
 (let (($x7210 (not v_1_persist_probe_sent)))
 (let (($x21403 (not v_1_persist_first)))
 (let (($x9202 (not v_1_persist_was_active)))
 (let (($x13551 (not v_1_persist_start)))
 (let (($x23321 (not v_1_persist_eligible)))
 (let (($x16511 (not v_1_persist_active)))
 (let (($x1001 (not v_1_ack_defer_now)))
 (let (($x6340 (not v_1_ack_defer_candidate)))
 (let (($x4430 (= v_1_ack_rmss 4)))
 (let (($x18233 (= v_1_ack_delay_ms 40)))
 (let (($x14865 (= 0 v_1_ack_full_segments)))
 (let (($x21877 (= 0 v_1_ack_bytes)))
 (let (($x2860 (= 0 v_1_ack_since_ms)))
 (let (($x25 (not v_1_ack_pending)))
 (let (($x8951 (not v_1_syn_timeout_eligible)))
 (let (($x3703 (not v_1_tx_syn_pending)))
 (let (($x3038 (= v_1_tx_syn_time 0)))
 (let (($x8959 (not v_1_tx_waiting)))
 (let (($x14546 (not v_1_tx_is_fin)))
 (let (($x9197 (= v_1_tx_previous_rto 1000)))
 (let (($x7044 (= v_1_tx_elapsed 0)))
 (let (($x2116 (not v_1_tx_retransmitted)))
 (let (($x7512 (= v_1_tx_max_previous 0)))
 (let (($x23386 (= v_1_tx_eligible 0)))
 (let (($x20706 (= v_1_tx_emit_count 0)))
 (let (($x18247 (= v_1_tx_fin_time 0)))
 (let (($x1899 (= v_1_tx_time_15 0)))
 (let (($x5882 (= v_1_tx_time_14 0)))
 (let (($x17894 (= v_1_tx_time_13 0)))
 (let (($x29 (= v_1_tx_time_12 0)))
 (let (($x11716 (= v_1_tx_time_11 0)))
 (let (($x8514 (= v_1_tx_time_10 0)))
 (let (($x11419 (= v_1_tx_time_09 0)))
 (let (($x10772 (= v_1_tx_time_08 0)))
 (let (($x10261 (= v_1_tx_time_07 0)))
 (let (($x25385 (= v_1_tx_time_06 0)))
 (let (($x19505 (= v_1_tx_time_05 0)))
 (let (($x6541 (= v_1_tx_time_04 0)))
 (let (($x4362 (= v_1_tx_time_03 0)))
 (let (($x15434 (= v_1_tx_time_02 0)))
 (let (($x13544 (= v_1_tx_time_01 0)))
 (let (($x16342 (= v_1_tx_time_00 0)))
 (let (($x11234 (= v_1_rto_base_ms 1000)))
 (let (($x2920 (= v_1_rtt_samples 0)))
 (let (($x17449 (= v_1_rtt_last_ms 0)))
 (let (($x17445 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x9185 (not v_1_rtt_sample_used)))
 (let (($x18732 (not v_1_rtt_start_new)))
 (let (($x20352 (= v_1_rtt_remaining 0)))
 (let (($x2354 (= v_1_rtt_end (_ bv0 32))))
 (let (($x20592 (= v_1_rtt_start_ms 0)))
 (let (($x5243 (= v_1_rtt_sample_at_ms 0)))
 (let (($x12552 (not v_1_rtt_ambiguous)))
 (let (($x1815 (not v_1_rtt_active)))
 (let (($x9827 (not v_1_rtt_previous_measured)))
 (let (($x1884 (not v_1_rtt_measured)))
 (let (($x9357 (= v_1_rtt_previous_var 0.0)))
 (let (($x171 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x6758 (= v_1_rtt_error_ms 0.0)))
 (let (($x18178 (= v_1_rttvar_ms 0.0)))
 (let (($x20713 (= v_1_srtt_ms 0.0)))
 (let (($x10167 (not v_1_rx_fin_consumed)))
 (let (($x23920 (not v_1_rx_fin_done)))
 (let (($x18397 (= 0 v_1_rx_fin_offset)))
 (let (($x20095 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x22982 (not v_1_rx_fin_pending)))
 (let (($x24081 (not v_1_fin_acknowledged)))
 (let (($x16539 (= v_1_fin_seq (_ bv0 32))))
 (let (($x3812 (not v_1_fin_sent)))
 (let (($x5586 (not v_1_fin_requested)))
 (let (($x1466 (not v_1_ack_window_update)))
 (let (($x7163 (not v_1_ack_advance)))
 (let (($x21471 (not v_1_ack_is_future)))
 (let (($x125 (not v_1_ack_is_new)))
 (let (($x10960 (= v_1_ack_delta 0)))
 (let (($x15126 (not v_1_seg_acceptable)))
 (let (($x19323 (not v_1_rx_acceptable)))
 (let (($x11172 (= v_1_rx_advance 0)))
 (let (($x22752 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x4802 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x6569 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x13558 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x9165 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x1736 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x8041 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x10999 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x6729 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x9163 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x8805 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x18734 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x17446 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x2815 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x9166 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x9966 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x3542 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x10983 (= v_1_take 0)))
 (let (($x10980 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x17216 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x8880 (= v_1_snd_wnd 8)))
 (let (($x1437 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x7564 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x12529 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x6869 (= 16 v_1_local_window)))
 (let (($x11673 (= v_1_msl_ms 60000)))
 (let (($x4809 (= v_1_user_timeout_ms 30000)))
 (let (($x5685 (not v_1_active_open)))
 (let (($x10921 (= v_1_retries 0)))
 (let (($x11387 (= v_1_rto_ms 1000)))
 (let (($x4811 (= v_1_tx_ack (_ bv0 32))))
 (let (($x7795 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x11023 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x24728 (= v_1_snd_nxt (_ bv1000 32))))
 (let (($x12243 (= v_1_snd_una (_ bv1000 32))))
 (let (($x14636 (= v_1_irs (_ bv0 32))))
 (let (($x7802 (= v_1_iss (_ bv1000 32))))
 (let (($x15598 (= 1 state_1)))
 (let (($x7571 (not active_0_persist)))
 (let (($x11720 (or $x7571 (not (<= due_0_persist 0)))))
 (let (($x9579 (not active_0_delack)))
 (let (($x21118 (or $x9579 (not (<= due_0_delack 0)))))
 (let (($x1935 (not active_0_time_wait)))
 (let (($x20205 (or $x1935 (not (<= due_0_time_wait 0)))))
 (let (($x6670 (not active_0_user)))
 (let (($x15000 (or $x6670 (not (<= due_0_user 0)))))
 (let (($x11338 (not active_0_rtx)))
 (let (($x7719 (or $x11338 (not (<= due_0_rtx 0)))))
 (let (($x1432 (= state_0 0)))
 (and $x1432 (>= 0 now_0) $x7719 $x15000 $x20205 $x21118 $x11720 $x15598 $x7802 $x14636 $x12243 $x24728 $x11023 $x7795 $x4811 (= v_1_tx_flags "S") $x11387 $x10921 $x5685 $x4809 $x11673 $x6869 $x12529 $x7564 $x1437 $x8880 $x17216 $x10980 $x10983 $x3542 $x9966 $x9166 $x2815 $x17446 $x18734 $x8805 $x9163 $x6729 $x10999 $x8041 $x1736 $x9165 $x13558 $x6569 $x4802 $x22752 $x11172 $x19323 $x15126 $x10960 $x125 $x21471 $x7163 $x1466 $x5586 $x3812 $x16539 $x24081 $x22982 $x20095 $x18397 $x23920 $x10167 $x20713 $x18178 $x6758 $x171 $x9357 $x1884 $x9827 $x1815 $x12552 $x5243 $x20592 $x2354 $x20352 $x18732 $x9185 $x17445 $x17449 $x2920 $x11234 $x16342 $x13544 $x15434 $x4362 $x6541 $x19505 $x25385 $x10261 $x10772 $x11419 $x8514 $x11716 $x29 $x17894 $x5882 $x1899 $x18247 $x20706 $x23386 $x7512 $x2116 $x7044 $x9197 $x14546 $x8959 $x3038 $x3703 $x8951 $x25 $x2860 $x21877 $x14865 $x18233 $x4430 $x6340 $x1001 $x16511 $x23321 $x13551 $x9202 $x21403 $x7210 $x9184 $x24131 $x24132 $x8624 $x19338 $x18992 $x1902 $x10988 $x6489 $x17447 $x20162 $x5254 $x21554 $x24148 $x22617 $x3734 $x2869 $x6224)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x4297 (= due_2_persist due_1_persist)))
 (let (($x3141 (= due_2_delack due_1_delack)))
 (let (($x22942 (= due_2_time_wait due_1_time_wait)))
 (let (($x21038 (= due_2_rtx 1050)))
 (let (($x10775 (not active_2_persist)))
 (let (($x24717 (not active_2_delack)))
 (let (($x15190 (= active_2_time_wait active_1_time_wait)))
 (let (($x24699 (= v_2_persist_elapsed_ms v_1_persist_elapsed_ms)))
 (let (($x15850 (= v_2_persist_probes 0)))
 (let (($x6536 (= v_2_persist_deadline_ms 0)))
 (let (($x9415 (= v_2_persist_last_ms 0)))
 (let (($x10773 (= v_2_persist_since_ms 0)))
 (let (($x12034 (= v_2_persist_previous_interval_ms v_1_persist_previous_interval_ms)))
 (let (($x10884 (= v_2_persist_interval_ms 1000)))
 (let (($x16312 (not v_2_persist_probe_new)))
 (let (($x4363 (not v_2_persist_probe_sent)))
 (let (($x17308 (not v_2_persist_first)))
 (let (($x2745 (= v_2_persist_was_active v_1_persist_active)))
 (let (($x21160 (not v_2_persist_start)))
 (let (($x16933 (not v_2_persist_eligible)))
 (let (($x23173 (not v_2_persist_active)))
 (let (($x12299 (not v_2_ack_defer_now)))
 (let (($x1883 (not v_2_ack_defer_candidate)))
 (let (($x24710 (= v_2_ack_rmss v_1_ack_rmss)))
 (let (($x7876 (= v_2_ack_delay_ms v_1_ack_delay_ms)))
 (let (($x4980 (= 0 v_2_ack_full_segments)))
 (let (($x729 (= 0 v_2_ack_bytes)))
 (let (($x6147 (= 0 v_2_ack_since_ms)))
 (let (($x3423 (not v_2_ack_pending)))
 (let (($x3486 (= v_2_syn_timeout_eligible v_1_syn_timeout_eligible)))
 (let (($x11539 (= v_2_tx_syn_time 50)))
 (let (($x12970 (not v_2_tx_waiting)))
 (let (($x8694 (= v_2_tx_is_fin v_1_tx_is_fin)))
 (let (($x16154 (= v_2_tx_previous_rto v_1_tx_previous_rto)))
 (let (($x7143 (= v_2_tx_elapsed v_1_tx_elapsed)))
 (let (($x19486 (not v_2_tx_retransmitted)))
 (let (($x850 (= v_2_tx_max_previous v_1_tx_max_previous)))
 (let (($x14230 (= v_2_tx_eligible v_1_tx_eligible)))
 (let (($x7917 (= v_2_tx_emit_count v_1_tx_emit_count)))
 (let ((?x17688 (ite (and v_1_fin_sent (not v_1_fin_acknowledged)) v_1_tx_fin_time 0)))
 (let (($x9713 (= v_2_tx_fin_time ?x17688)))
 (let (($x7034 (= v_2_tx_time_15 (ite (>= 15 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_15))))
 (let (($x10569 (= v_2_tx_time_14 (ite (>= 14 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_14))))
 (let (($x11888 (= v_2_tx_time_13 (ite (>= 13 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_13))))
 (let (($x4010 (= v_2_tx_time_12 (ite (>= 12 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_12))))
 (let (($x1120 (= v_2_tx_time_11 (ite (>= 11 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_11))))
 (let (($x6844 (= v_2_tx_time_10 (ite (>= 10 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_10))))
 (let (($x17486 (= v_2_tx_time_09 (ite (>= 9 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_09))))
 (let (($x1124 (= v_2_tx_time_08 (ite (>= 8 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_08))))
 (let (($x2942 (= v_2_tx_time_07 (ite (>= 7 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_07))))
 (let (($x13648 (= v_2_tx_time_06 (ite (>= 6 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_06))))
 (let (($x926 (= v_2_tx_time_05 (ite (>= 5 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_05))))
 (let (($x10202 (= v_2_tx_time_04 (ite (>= 4 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_04))))
 (let (($x12344 (= v_2_tx_time_03 (ite (>= 3 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_03))))
 (let (($x8653 (= v_2_tx_time_02 (ite (>= 2 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_02))))
 (let (($x7600 (= v_2_tx_time_01 (ite (>= 1 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_01))))
 (let (($x598 (= v_2_tx_time_00 (ite (>= 0 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_00))))
 (let (($x23076 (= v_2_rto_base_ms 1000)))
 (let (($x20520 (= v_2_rtt_samples 0)))
 (let (($x17339 (= v_2_rtt_last_ms 0)))
 (let (($x18891 (not v_2_rtt_sample_was_ambiguous)))
 (let (($x2716 (not v_2_rtt_sample_used)))
 (let (($x10263 (= v_2_rtt_remaining 1)))
 (let ((?x18986 (bvadd (_ bv1 32) v_1_iss)))
 (let (($x18176 (= v_2_rtt_end ?x18986)))
 (let (($x11993 (= v_2_rtt_start_ms 50)))
 (let (($x4477 (= v_2_rtt_sample_at_ms 0)))
 (let (($x18984 (not v_2_rtt_ambiguous)))
 (let (($x18102 (not v_2_rtt_previous_measured)))
 (let (($x5054 (not v_2_rtt_measured)))
 (let (($x1482 (= v_2_rtt_previous_var 0.0)))
 (let (($x13381 (= v_2_rtt_previous_srtt 0.0)))
 (let (($x20499 (= v_2_rtt_error_ms 0.0)))
 (let (($x9742 (= v_2_rttvar_ms 0.0)))
 (let (($x11377 (= v_2_srtt_ms 0.0)))
 (let (($x17262 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x24701 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x15554 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x1893 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x3531 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x12711 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x11418 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x14128 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x13621 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x6732 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x23885 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x8854 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x10868 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x18115 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x8941 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x1852 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x6952 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x13671 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x12026 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x14211 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x10080 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x17678 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x18345 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x24069 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x20307 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x18220 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x15884 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x15187 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x9056 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x24394 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x24963 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x14369 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x11110 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x12043 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x11253 (= v_2_take v_1_take)))
 (let (($x20595 (= v_2_snd_wl2 v_1_snd_wl2)))
 (let (($x12356 (= v_2_snd_wl1 v_1_snd_wl1)))
 (let (($x7416 (= v_2_snd_wnd v_1_snd_wnd)))
 (let (($x11228 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x4148 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x8573 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x23115 (= v_2_local_window v_1_local_window)))
 (let (($x14120 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x1616 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x16965 (= v_2_active_open v_1_active_open)))
 (let (($x7853 (= 0 v_2_retries)))
 (let (($x900 (= 1000 v_2_rto_ms)))
 (let (($x4949 (= v_2_tx_flags "SA")))
 (let (($x18073 (= v_2_tx_ack (_ bv9001 32))))
 (let (($x16294 (= v_2_tx_seq v_1_iss)))
 (let (($x12926 (= v_2_rcv_nxt (_ bv9001 32))))
 (let (($x1903 (= v_2_snd_nxt ?x18986)))
 (let (($x15179 (= v_2_snd_una v_1_iss)))
 (let (($x24113 (= v_2_irs (_ bv9000 32))))
 (let (($x241 (= v_2_iss v_1_iss)))
 (let (($x21156 (= 3 state_2)))
 (let (($x21554 (not active_1_persist)))
 (let (($x15788 (or $x21554 (not (<= due_1_persist 50)))))
 (let (($x5254 (not active_1_delack)))
 (let (($x11506 (or $x5254 (not (<= due_1_delack 50)))))
 (let (($x20162 (not active_1_time_wait)))
 (let (($x18062 (or $x20162 (not (<= due_1_time_wait 50)))))
 (let (($x17447 (not active_1_user)))
 (let (($x17439 (or $x17447 (not (<= due_1_user 50)))))
 (let (($x6489 (not active_1_rtx)))
 (let (($x1516 (or $x6489 (not (<= due_1_rtx 50)))))
 (let (($x17448 (= state_1 1)))
 (and $x17448 $x1516 $x17439 $x18062 $x11506 $x15788 $x21156 $x241 $x24113 $x15179 $x1903 $x12926 $x16294 $x18073 $x4949 $x900 $x7853 $x16965 $x1616 $x14120 $x23115 $x8573 $x4148 $x11228 $x7416 $x12356 $x20595 $x11253 $x12043 $x11110 $x14369 $x24963 $x24394 $x9056 $x15187 $x15884 $x18220 $x20307 $x24069 $x18345 $x17678 $x10080 $x14211 $x12026 $x13671 $x6952 $x1852 $x8941 $x18115 $x10868 $x8854 $x23885 $x6732 $x13621 $x14128 $x11418 $x12711 $x3531 $x1893 $x15554 $x24701 $x17262 $x11377 $x9742 $x20499 $x13381 $x1482 $x5054 $x18102 v_2_rtt_active $x18984 $x4477 $x11993 $x18176 $x10263 v_2_rtt_start_new $x2716 $x18891 $x17339 $x20520 $x23076 $x598 $x7600 $x8653 $x12344 $x10202 $x926 $x13648 $x2942 $x1124 $x17486 $x6844 $x1120 $x4010 $x11888 $x10569 $x7034 $x9713 $x7917 $x14230 $x850 $x19486 $x7143 $x16154 $x8694 $x12970 $x11539 v_2_tx_syn_pending $x3486 $x3423 $x6147 $x729 $x4980 $x7876 $x24710 $x1883 $x12299 $x23173 $x16933 $x21160 $x2745 $x17308 $x4363 $x16312 $x10884 $x12034 $x10773 $x9415 $x6536 $x15850 $x24699 active_2_rtx active_2_user $x15190 $x24717 $x10775 $x21038 (= due_2_user (+ 50 v_1_user_timeout_ms)) $x22942 $x3141 $x4297))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 (let (($x6764 (= due_3_persist due_2_persist)))
 (let (($x15893 (= due_3_delack due_2_delack)))
 (let (($x19525 (= due_3_time_wait due_2_time_wait)))
 (let (($x6592 (= due_3_user due_2_user)))
 (let ((?x5969 (ite (>= v_2_rto_ms 30000) 60000 (* 2 v_2_rto_ms))))
 (let ((?x21483 (+ v_2_tx_syn_time v_2_rto_ms)))
 (let (($x11474 (<= ?x21483 1050)))
 (let ((?x11374 (ite $x11474 ?x5969 v_2_rto_ms)))
 (let ((?x1907 (ite $x11474 1050 v_2_tx_syn_time)))
 (let ((?x952 (ite $x11474 ?x5969 (+ (- 1050) ?x1907 ?x11374))))
 (let (($x18679 (not active_3_persist)))
 (let (($x2008 (not active_3_delack)))
 (let (($x8430 (= active_3_time_wait active_2_time_wait)))
 (let (($x19526 (= active_3_user active_2_user)))
 (let (($x20578 (= v_3_persist_elapsed_ms v_2_persist_elapsed_ms)))
 (let (($x20166 (= v_3_persist_probes 0)))
 (let (($x1545 (= v_3_persist_deadline_ms 0)))
 (let (($x17902 (= v_3_persist_last_ms 0)))
 (let (($x7367 (= v_3_persist_since_ms 0)))
 (let (($x21463 (= v_3_persist_previous_interval_ms v_2_persist_previous_interval_ms)))
 (let (($x6522 (= v_3_persist_interval_ms 1000)))
 (let (($x14501 (not v_3_persist_probe_new)))
 (let (($x3940 (not v_3_persist_probe_sent)))
 (let (($x8013 (not v_3_persist_first)))
 (let (($x23193 (= v_3_persist_was_active v_2_persist_active)))
 (let (($x12126 (not v_3_persist_start)))
 (let (($x6350 (not v_3_persist_eligible)))
 (let (($x10559 (not v_3_persist_active)))
 (let (($x12124 (not v_3_ack_defer_now)))
 (let (($x20514 (not v_3_ack_defer_candidate)))
 (let (($x20642 (= v_3_ack_rmss v_2_ack_rmss)))
 (let (($x6465 (= v_3_ack_delay_ms v_2_ack_delay_ms)))
 (let (($x7880 (= 0 v_3_ack_full_segments)))
 (let (($x1811 (= 0 v_3_ack_bytes)))
 (let (($x7748 (= 0 v_3_ack_since_ms)))
 (let (($x5584 (not v_3_ack_pending)))
 (let (($x8992 (= v_3_syn_timeout_eligible $x11474)))
 (let (($x18727 (= v_3_tx_syn_time ?x1907)))
 (let (($x12909 (not (= $x11474 v_3_tx_waiting))))
 (let (($x17833 (not v_3_tx_is_fin)))
 (let (($x23176 (= v_3_tx_previous_rto v_2_rto_ms)))
 (let (($x744 (= v_3_tx_elapsed (ite $x11474 (+ 1050 (* (- 1) v_2_tx_syn_time)) 0))))
 (let (($x18981 (= v_3_tx_retransmitted $x11474)))
 (let (($x11765 (= v_3_tx_max_previous v_2_tx_syn_time)))
 (let (($x19996 (= v_3_tx_eligible v_2_tx_eligible)))
 (let (($x2369 (= v_3_tx_emit_count (ite $x11474 1 0))))
 (let ((?x16537 (ite (and v_2_fin_sent (not v_2_fin_acknowledged)) v_2_tx_fin_time 0)))
 (let (($x16911 (= v_3_tx_fin_time ?x16537)))
 (let (($x7464 (= v_3_tx_time_15 (ite (>= 15 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_15))))
 (let (($x5879 (= v_3_tx_time_14 (ite (>= 14 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_14))))
 (let (($x7304 (= v_3_tx_time_13 (ite (>= 13 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_13))))
 (let (($x5880 (= v_3_tx_time_12 (ite (>= 12 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_12))))
 (let (($x14826 (= v_3_tx_time_11 (ite (>= 11 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_11))))
 (let (($x7179 (= v_3_tx_time_10 (ite (>= 10 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_10))))
 (let (($x9846 (= v_3_tx_time_09 (ite (>= 9 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_09))))
 (let (($x20579 (= v_3_tx_time_08 (ite (>= 8 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_08))))
 (let (($x9815 (= v_3_tx_time_07 (ite (>= 7 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_07))))
 (let (($x7171 (= v_3_tx_time_06 (ite (>= 6 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_06))))
 (let (($x6101 (= v_3_tx_time_05 (ite (>= 5 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_05))))
 (let (($x9363 (= v_3_tx_time_04 (ite (>= 4 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_04))))
 (let (($x2162 (= v_3_tx_time_03 (ite (>= 3 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_03))))
 (let (($x4379 (= v_3_tx_time_02 (ite (>= 2 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_02))))
 (let (($x1759 (= v_3_tx_time_01 (ite (>= 1 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_01))))
 (let (($x3121 (= v_3_tx_time_00 (ite (>= 0 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_00))))
 (let (($x20712 (= v_3_rto_base_ms v_2_rto_base_ms)))
 (let (($x12557 (= v_3_rtt_samples v_2_rtt_samples)))
 (let (($x8060 (= v_3_rtt_last_ms v_2_rtt_last_ms)))
 (let (($x15232 (not v_3_rtt_sample_was_ambiguous)))
 (let (($x12853 (not v_3_rtt_sample_used)))
 (let (($x22742 (not v_3_rtt_start_new)))
 (let (($x7801 (= v_3_rtt_remaining v_2_rtt_remaining)))
 (let (($x23184 (= v_3_rtt_end v_2_rtt_end)))
 (let (($x5051 (= v_3_rtt_start_ms v_2_rtt_start_ms)))
 (let (($x20534 (= v_3_rtt_sample_at_ms v_2_rtt_sample_at_ms)))
 (let ((?x19555 (ubv_to_int (bvadd v_2_rtt_end (bvmul (_ bv4294967295 32) v_2_snd_una)))))
 (let (($x19295 (and v_2_rtt_active (<= (+ ?x19555 (* (- 1) v_2_rtt_remaining)) 0))))
 (let (($x8727 (= v_3_rtt_ambiguous (ite $x11474 (or $x19295 v_2_rtt_ambiguous) v_2_rtt_ambiguous))))
 (let (($x23182 (= v_3_rtt_active v_2_rtt_active)))
 (let (($x8592 (= v_3_rtt_previous_measured v_2_rtt_previous_measured)))
 (let (($x19512 (= v_3_rtt_measured v_2_rtt_measured)))
 (let (($x19980 (= v_3_rtt_previous_var v_2_rtt_previous_var)))
 (let (($x678 (= v_3_rtt_previous_srtt v_2_rtt_previous_srtt)))
 (let (($x20600 (= v_3_rtt_error_ms v_2_rtt_error_ms)))
 (let (($x4673 (= v_3_rttvar_ms v_2_rttvar_ms)))
 (let (($x20526 (= v_3_srtt_ms v_2_srtt_ms)))
 (let (($x4271 (= v_3_rx_fin_consumed v_2_rx_fin_consumed)))
 (let (($x3452 (= v_3_rx_fin_done v_2_rx_fin_done)))
 (let (($x4283 (= v_3_rx_fin_offset v_2_rx_fin_offset)))
 (let (($x6108 (= v_3_rx_fin_seq v_2_rx_fin_seq)))
 (let (($x15713 (= v_3_rx_fin_pending v_2_rx_fin_pending)))
 (let (($x4385 (= v_3_fin_acknowledged v_2_fin_acknowledged)))
 (let (($x6041 (= v_3_fin_seq v_2_fin_seq)))
 (let (($x2560 (= v_3_fin_sent v_2_fin_sent)))
 (let (($x16449 (= v_3_fin_requested v_2_fin_requested)))
 (let (($x3458 (= v_3_ack_window_update v_2_ack_window_update)))
 (let (($x10687 (= v_3_ack_advance v_2_ack_advance)))
 (let (($x4281 (= v_3_ack_is_future v_2_ack_is_future)))
 (let (($x1459 (= v_3_ack_is_new v_2_ack_is_new)))
 (let (($x4278 (= v_3_ack_delta v_2_ack_delta)))
 (let (($x4386 (= v_3_seg_acceptable v_2_seg_acceptable)))
 (let (($x4277 (= v_3_rx_acceptable v_2_rx_acceptable)))
 (let (($x10688 (= v_3_rx_advance v_2_rx_advance)))
 (let (($x11540 (= v_3_rx_slot_15 v_2_rx_slot_15)))
 (let (($x4397 (= v_3_rx_slot_14 v_2_rx_slot_14)))
 (let (($x2914 (= v_3_rx_slot_13 v_2_rx_slot_13)))
 (let (($x25681 (= v_3_rx_slot_12 v_2_rx_slot_12)))
 (let (($x3062 (= v_3_rx_slot_11 v_2_rx_slot_11)))
 (let (($x4387 (= v_3_rx_slot_10 v_2_rx_slot_10)))
 (let (($x23095 (= v_3_rx_slot_09 v_2_rx_slot_09)))
 (let (($x4280 (= v_3_rx_slot_08 v_2_rx_slot_08)))
 (let (($x3457 (= v_3_rx_slot_07 v_2_rx_slot_07)))
 (let (($x4279 (= v_3_rx_slot_06 v_2_rx_slot_06)))
 (let (($x14976 (= v_3_rx_slot_05 v_2_rx_slot_05)))
 (let (($x8222 (= v_3_rx_slot_04 v_2_rx_slot_04)))
 (let (($x3066 (= v_3_rx_slot_03 v_2_rx_slot_03)))
 (let (($x793 (= v_3_rx_slot_02 v_2_rx_slot_02)))
 (let (($x841 (= v_3_rx_slot_01 v_2_rx_slot_01)))
 (let (($x10689 (= v_3_rx_slot_00 v_2_rx_slot_00)))
 (let (($x3455 (= v_3_rx_chunk v_2_rx_chunk)))
 (let (($x3067 (= v_3_take v_2_take)))
 (let (($x23164 (= v_3_snd_wl2 v_2_snd_wl2)))
 (let (($x8268 (= v_3_snd_wl1 v_2_snd_wl1)))
 (let (($x4282 (= v_3_snd_wnd v_2_snd_wnd)))
 (let (($x13702 (= v_3_rcv_buf v_2_rcv_buf)))
 (let (($x4388 (= v_3_rtx_buf v_2_rtx_buf)))
 (let (($x3454 (= v_3_snd_buf v_2_snd_buf)))
 (let (($x10691 (= v_3_local_window v_2_local_window)))
 (let (($x6040 (= v_3_msl_ms v_2_msl_ms)))
 (let (($x10693 (= v_3_user_timeout_ms v_2_user_timeout_ms)))
 (let (($x9289 (= v_3_active_open v_2_active_open)))
 (let (($x1451 (= v_3_retries (ite $x11474 (+ 1 v_2_retries) v_2_retries))))
 (let (($x21406 (= v_3_rto_ms ?x11374)))
 (let (($x3426 (= v_3_tx_flags v_2_tx_flags)))
 (let (($x14483 (= v_3_tx_ack v_2_tx_ack)))
 (let (($x3424 (= v_3_tx_seq v_2_tx_seq)))
 (let (($x3427 (= v_3_rcv_nxt v_2_rcv_nxt)))
 (let (($x10695 (= v_3_snd_nxt v_2_snd_nxt)))
 (let (($x1427 (= v_3_snd_una v_2_snd_una)))
 (let (($x10694 (= v_3_irs v_2_irs)))
 (let (($x2915 (= v_3_iss v_2_iss)))
 (let (($x4391 (= 3 state_3)))
 (let (($x13392 (= state_2 3)))
 (and $x13392 active_2_rtx (= 1050 due_2_rtx) (or (not active_2_user) (<= due_2_rtx due_2_user)) (or (not active_2_time_wait) (<= due_2_rtx due_2_time_wait)) (or (not active_2_delack) (not (<= due_2_delack due_2_rtx))) (or (not active_2_persist) (not (<= due_2_persist due_2_rtx))) $x4391 $x2915 $x10694 $x1427 $x10695 $x3427 $x3424 $x14483 $x3426 $x21406 $x1451 $x9289 $x10693 $x6040 $x10691 $x3454 $x4388 $x13702 $x4282 $x8268 $x23164 $x3067 $x3455 $x10689 $x841 $x793 $x3066 $x8222 $x14976 $x4279 $x3457 $x4280 $x23095 $x4387 $x3062 $x25681 $x2914 $x4397 $x11540 $x10688 $x4277 $x4386 $x4278 $x1459 $x4281 $x10687 $x3458 $x16449 $x2560 $x6041 $x4385 $x15713 $x6108 $x4283 $x3452 $x4271 $x20526 $x4673 $x20600 $x678 $x19980 $x19512 $x8592 $x23182 $x8727 $x20534 $x5051 $x23184 $x7801 $x22742 $x12853 $x15232 $x8060 $x12557 $x20712 $x3121 $x1759 $x4379 $x2162 $x9363 $x6101 $x7171 $x9815 $x20579 $x9846 $x7179 $x14826 $x5880 $x7304 $x5879 $x7464 $x16911 $x2369 $x19996 $x11765 $x18981 $x744 $x23176 $x17833 $x12909 $x18727 v_3_tx_syn_pending $x8992 $x5584 $x7748 $x1811 $x7880 $x6465 $x20642 $x20514 $x12124 $x10559 $x6350 $x12126 $x23193 $x8013 $x3940 $x14501 $x6522 $x21463 $x7367 $x17902 $x1545 $x20166 $x20578 active_3_rtx $x19526 $x8430 $x2008 $x18679 (= due_3_rtx (+ 1050 ?x952)) $x6592 $x19525 $x15893 $x6764))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
 (= 1 choice_0))
(assert
 (= 0 now_1))
(assert
 (= 2 choice_1))
(assert
 (= 50 now_2))
(assert
 (= (_ bv9000 32) input_1_net.syn_seq))
(assert
 (= 28 choice_2))
(assert
 (= 1050 now_3))
(check-sat)
