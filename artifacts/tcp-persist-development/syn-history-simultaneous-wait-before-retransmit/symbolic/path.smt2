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
 (let (($x7773 (= due_1_persist due_0_persist)))
 (let (($x4809 (= due_1_delack due_0_delack)))
 (let (($x5685 (= due_1_time_wait due_0_time_wait)))
 (let (($x9949 (= due_1_user 30000)))
 (let (($x11765 (= due_1_rtx 1000)))
 (let (($x7763 (not active_1_persist)))
 (let (($x15078 (not active_1_delack)))
 (let (($x10193 (not active_1_time_wait)))
 (let (($x2902 (= v_1_persist_elapsed_ms 0)))
 (let (($x985 (= v_1_persist_probes 0)))
 (let (($x17072 (= v_1_persist_deadline_ms 0)))
 (let (($x15601 (= v_1_persist_last_ms 0)))
 (let (($x8467 (= v_1_persist_since_ms 0)))
 (let (($x17076 (= v_1_persist_previous_interval_ms 1000)))
 (let (($x17051 (= v_1_persist_interval_ms 1000)))
 (let (($x16425 (not v_1_persist_probe_new)))
 (let (($x11774 (not v_1_persist_probe_sent)))
 (let (($x6876 (not v_1_persist_first)))
 (let (($x11773 (not v_1_persist_was_active)))
 (let (($x3985 (not v_1_persist_start)))
 (let (($x19125 (not v_1_persist_eligible)))
 (let (($x17397 (not v_1_persist_active)))
 (let (($x12448 (not v_1_ack_defer_now)))
 (let (($x8413 (not v_1_ack_defer_candidate)))
 (let (($x9101 (= v_1_ack_rmss 4)))
 (let (($x2709 (= v_1_ack_delay_ms 40)))
 (let (($x5090 (= 0 v_1_ack_full_segments)))
 (let (($x21118 (= 0 v_1_ack_bytes)))
 (let (($x23901 (= 0 v_1_ack_since_ms)))
 (let (($x2547 (not v_1_ack_pending)))
 (let (($x7536 (not v_1_syn_timeout_eligible)))
 (let (($x13822 (= v_1_tx_syn_time 0)))
 (let (($x24593 (not v_1_tx_waiting)))
 (let (($x1853 (not v_1_tx_is_fin)))
 (let (($x17122 (= v_1_tx_previous_rto 1000)))
 (let (($x15101 (= v_1_tx_elapsed 0)))
 (let (($x10043 (not v_1_tx_retransmitted)))
 (let (($x18740 (= v_1_tx_max_previous 0)))
 (let (($x2228 (= v_1_tx_eligible 0)))
 (let (($x22591 (= v_1_tx_emit_count 0)))
 (let (($x21119 (= v_1_tx_fin_time 0)))
 (let (($x7490 (= v_1_tx_time_15 0)))
 (let (($x19329 (= v_1_tx_time_14 0)))
 (let (($x19414 (= v_1_tx_time_13 0)))
 (let (($x11469 (= v_1_tx_time_12 0)))
 (let (($x1360 (= v_1_tx_time_11 0)))
 (let (($x891 (= v_1_tx_time_10 0)))
 (let (($x17430 (= v_1_tx_time_09 0)))
 (let (($x4414 (= v_1_tx_time_08 0)))
 (let (($x21097 (= v_1_tx_time_07 0)))
 (let (($x13747 (= v_1_tx_time_06 0)))
 (let (($x13446 (= v_1_tx_time_05 0)))
 (let (($x6517 (= v_1_tx_time_04 0)))
 (let (($x16208 (= v_1_tx_time_03 0)))
 (let (($x10320 (= v_1_tx_time_02 0)))
 (let (($x13118 (= v_1_tx_time_01 0)))
 (let (($x8576 (= v_1_tx_time_00 0)))
 (let (($x15515 (= v_1_rto_base_ms 1000)))
 (let (($x20202 (= v_1_rtt_samples 0)))
 (let (($x4917 (= v_1_rtt_last_ms 0)))
 (let (($x9908 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x14236 (not v_1_rtt_sample_used)))
 (let (($x15536 (= v_1_rtt_remaining 1)))
 (let (($x5147 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x2114 (= v_1_rtt_start_ms 0)))
 (let (($x23899 (= v_1_rtt_sample_at_ms 0)))
 (let (($x15240 (not v_1_rtt_ambiguous)))
 (let (($x4094 (not v_1_rtt_previous_measured)))
 (let (($x11100 (not v_1_rtt_measured)))
 (let (($x8808 (= v_1_rtt_previous_var 0.0)))
 (let (($x14712 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x12308 (= v_1_rtt_error_ms 0.0)))
 (let (($x9616 (= v_1_rttvar_ms 0.0)))
 (let (($x13986 (= v_1_srtt_ms 0.0)))
 (let (($x11434 (not v_1_rx_fin_consumed)))
 (let (($x977 (not v_1_rx_fin_done)))
 (let (($x18149 (= v_1_rx_fin_offset 0)))
 (let (($x17675 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x15207 (not v_1_rx_fin_pending)))
 (let (($x12219 (not v_1_fin_acknowledged)))
 (let (($x7548 (= v_1_fin_seq (_ bv0 32))))
 (let (($x8318 (not v_1_fin_sent)))
 (let (($x8381 (not v_1_fin_requested)))
 (let (($x11056 (not v_1_ack_window_update)))
 (let (($x5405 (not v_1_ack_advance)))
 (let (($x14687 (not v_1_ack_is_future)))
 (let (($x4109 (not v_1_ack_is_new)))
 (let (($x8339 (= v_1_ack_delta 0)))
 (let (($x4660 (not v_1_seg_acceptable)))
 (let (($x14686 (not v_1_rx_acceptable)))
 (let (($x11454 (= v_1_rx_advance 0)))
 (let (($x16512 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x10457 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x8851 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x13364 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x11853 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x2242 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x23019 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x64 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x13758 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x17148 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x9161 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x5407 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x17152 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x12531 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x17151 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x11467 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x21164 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x19542 (= v_1_take 0)))
 (let (($x3613 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x8485 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x8484 (= v_1_snd_wnd 8)))
 (let (($x17204 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x21537 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x17150 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x21252 (= v_1_local_window 16)))
 (let (($x3983 (= v_1_msl_ms 60000)))
 (let (($x15459 (= v_1_user_timeout_ms 30000)))
 (let (($x5791 (= 0 v_1_retries)))
 (let (($x19486 (= 1000 v_1_rto_ms)))
 (let (($x2537 (= v_1_tx_flags "S")))
 (let (($x21332 (= v_1_tx_ack (_ bv0 32))))
 (let (($x4122 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x21090 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x233 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x8480 (= v_1_snd_una (_ bv1000 32))))
 (let (($x8722 (= v_1_irs (_ bv0 32))))
 (let (($x8475 (= v_1_iss (_ bv1000 32))))
 (let (($x24048 (= 2 state_1)))
 (let (($x10769 (not active_0_persist)))
 (let (($x6003 (or $x10769 (not (<= due_0_persist 0)))))
 (let (($x1562 (not active_0_delack)))
 (let (($x10456 (or $x1562 (not (<= due_0_delack 0)))))
 (let (($x5588 (not active_0_time_wait)))
 (let (($x4302 (or $x5588 (not (<= due_0_time_wait 0)))))
 (let (($x5783 (not active_0_user)))
 (let (($x3265 (or $x5783 (not (<= due_0_user 0)))))
 (let (($x16653 (not active_0_rtx)))
 (let (($x22790 (or $x16653 (not (<= due_0_rtx 0)))))
 (let (($x1514 (= state_0 0)))
 (and $x1514 (>= 0 now_0) $x22790 $x3265 $x4302 $x10456 $x6003 $x24048 $x8475 $x8722 $x8480 $x233 $x21090 $x4122 $x21332 $x2537 $x19486 $x5791 v_1_active_open $x15459 $x3983 $x21252 $x17150 $x21537 $x17204 $x8484 $x8485 $x3613 $x19542 $x21164 $x11467 $x17151 $x12531 $x17152 $x5407 $x9161 $x17148 $x13758 $x64 $x23019 $x2242 $x11853 $x13364 $x8851 $x10457 $x16512 $x11454 $x14686 $x4660 $x8339 $x4109 $x14687 $x5405 $x11056 $x8381 $x8318 $x7548 $x12219 $x15207 $x17675 $x18149 $x977 $x11434 $x13986 $x9616 $x12308 $x14712 $x8808 $x11100 $x4094 v_1_rtt_active $x15240 $x23899 $x2114 $x5147 $x15536 v_1_rtt_start_new $x14236 $x9908 $x4917 $x20202 $x15515 $x8576 $x13118 $x10320 $x16208 $x6517 $x13446 $x13747 $x21097 $x4414 $x17430 $x891 $x1360 $x11469 $x19414 $x19329 $x7490 $x21119 $x22591 $x2228 $x18740 $x10043 $x15101 $x17122 $x1853 $x24593 $x13822 v_1_tx_syn_pending $x7536 $x2547 $x23901 $x21118 $x5090 $x2709 $x9101 $x8413 $x12448 $x17397 $x19125 $x3985 $x11773 $x6876 $x11774 $x16425 $x17051 $x17076 $x8467 $x15601 $x17072 $x985 $x2902 active_1_rtx active_1_user $x10193 $x15078 $x7763 $x11765 $x9949 $x5685 $x4809 $x7773))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x15784 (= due_2_persist due_1_persist)))
 (let (($x9151 (= due_2_delack due_1_delack)))
 (let (($x25128 (= due_2_time_wait due_1_time_wait)))
 (let (($x8528 (= due_2_user due_1_user)))
 (let (($x4135 (not active_2_persist)))
 (let (($x6806 (not active_2_delack)))
 (let (($x9380 (= active_2_time_wait active_1_time_wait)))
 (let (($x17043 (= active_2_user active_1_user)))
 (let (($x25619 (= v_2_persist_elapsed_ms v_1_persist_elapsed_ms)))
 (let (($x6847 (= v_2_persist_probes 0)))
 (let (($x5714 (= v_2_persist_deadline_ms 0)))
 (let (($x21268 (= v_2_persist_last_ms 0)))
 (let (($x3574 (= v_2_persist_since_ms 0)))
 (let (($x1158 (= v_2_persist_previous_interval_ms v_1_persist_previous_interval_ms)))
 (let (($x4091 (= v_2_persist_interval_ms 1000)))
 (let (($x11144 (not v_2_persist_probe_new)))
 (let (($x6149 (not v_2_persist_probe_sent)))
 (let (($x20368 (not v_2_persist_first)))
 (let (($x25597 (= v_2_persist_was_active v_1_persist_active)))
 (let (($x10041 (not v_2_persist_start)))
 (let (($x24243 (not v_2_persist_eligible)))
 (let (($x13745 (not v_2_persist_active)))
 (let (($x21885 (not v_2_ack_defer_now)))
 (let (($x4250 (not v_2_ack_defer_candidate)))
 (let (($x6749 (= v_2_ack_rmss v_1_ack_rmss)))
 (let (($x11448 (= v_2_ack_delay_ms v_1_ack_delay_ms)))
 (let (($x3701 (= 0 v_2_ack_full_segments)))
 (let (($x5927 (= 0 v_2_ack_bytes)))
 (let (($x10908 (= 0 v_2_ack_since_ms)))
 (let (($x18759 (not v_2_ack_pending)))
 (let (($x14381 (= v_2_syn_timeout_eligible v_1_syn_timeout_eligible)))
 (let (($x992 (= v_2_tx_syn_time 900)))
 (let (($x13023 (not v_2_tx_waiting)))
 (let (($x696 (= v_2_tx_is_fin v_1_tx_is_fin)))
 (let (($x24964 (= v_2_tx_previous_rto v_1_tx_previous_rto)))
 (let (($x13584 (= v_2_tx_elapsed v_1_tx_elapsed)))
 (let (($x12324 (not v_2_tx_retransmitted)))
 (let (($x13042 (= v_2_tx_max_previous v_1_tx_max_previous)))
 (let (($x25071 (= v_2_tx_eligible v_1_tx_eligible)))
 (let (($x20702 (= v_2_tx_emit_count v_1_tx_emit_count)))
 (let ((?x4093 (ite (and v_1_fin_sent (not v_1_fin_acknowledged)) v_1_tx_fin_time 0)))
 (let (($x921 (= v_2_tx_fin_time ?x4093)))
 (let (($x24894 (= v_2_tx_time_15 (ite (>= 15 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_15))))
 (let (($x8456 (= v_2_tx_time_14 (ite (>= 14 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_14))))
 (let (($x9243 (= v_2_tx_time_13 (ite (>= 13 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_13))))
 (let (($x7781 (= v_2_tx_time_12 (ite (>= 12 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_12))))
 (let (($x10736 (= v_2_tx_time_11 (ite (>= 11 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_11))))
 (let (($x21654 (= v_2_tx_time_10 (ite (>= 10 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_10))))
 (let (($x4641 (= v_2_tx_time_09 (ite (>= 9 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_09))))
 (let (($x4240 (= v_2_tx_time_08 (ite (>= 8 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_08))))
 (let (($x24980 (= v_2_tx_time_07 (ite (>= 7 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_07))))
 (let (($x23871 (= v_2_tx_time_06 (ite (>= 6 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_06))))
 (let (($x14667 (= v_2_tx_time_05 (ite (>= 5 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_05))))
 (let (($x9252 (= v_2_tx_time_04 (ite (>= 4 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_04))))
 (let (($x7133 (= v_2_tx_time_03 (ite (>= 3 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_03))))
 (let (($x3776 (= v_2_tx_time_02 (ite (>= 2 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_02))))
 (let (($x8180 (= v_2_tx_time_01 (ite (>= 1 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_01))))
 (let (($x9183 (= v_2_tx_time_00 (ite (>= 0 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_00))))
 (let (($x19348 (= v_2_rto_base_ms v_1_rto_base_ms)))
 (let (($x7335 (= v_2_rtt_samples v_1_rtt_samples)))
 (let (($x2988 (= v_2_rtt_last_ms v_1_rtt_last_ms)))
 (let (($x3373 (not v_2_rtt_sample_was_ambiguous)))
 (let (($x25222 (not v_2_rtt_sample_used)))
 (let (($x23180 (not v_2_rtt_start_new)))
 (let (($x24192 (= v_2_rtt_remaining v_1_rtt_remaining)))
 (let (($x8956 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x14852 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let (($x12472 (= v_2_rtt_sample_at_ms v_1_rtt_sample_at_ms)))
 (let ((?x10132 (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let (($x10564 (and v_1_rtt_active (<= (+ ?x10132 (* (- 1) v_1_rtt_remaining)) 0))))
 (let (($x24257 (= v_2_rtt_active v_1_rtt_active)))
 (let (($x15184 (= v_2_rtt_previous_measured v_1_rtt_previous_measured)))
 (let (($x21236 (= v_2_rtt_measured v_1_rtt_measured)))
 (let (($x20703 (= v_2_rtt_previous_var v_1_rtt_previous_var)))
 (let (($x12787 (= v_2_rtt_previous_srtt v_1_rtt_previous_srtt)))
 (let (($x25682 (= v_2_rtt_error_ms v_1_rtt_error_ms)))
 (let (($x9705 (= v_2_rttvar_ms v_1_rttvar_ms)))
 (let (($x19084 (= v_2_srtt_ms v_1_srtt_ms)))
 (let (($x15684 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x6301 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x13128 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x13127 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x13126 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x20329 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x21488 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x17220 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x17837 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x3021 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x13159 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x20324 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x20330 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x377 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x23225 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x20351 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x4743 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x20350 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x1155 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x20336 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x1171 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x20334 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x9074 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x20332 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x20304 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x16848 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x24244 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x10287 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x20107 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x12016 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x18853 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x23029 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x6193 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x21385 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x5836 (= v_2_take v_1_take)))
 (let (($x3364 (= v_2_snd_wl2 v_1_snd_wl2)))
 (let (($x24231 (= v_2_snd_wl1 v_1_snd_wl1)))
 (let (($x15432 (= v_2_snd_wnd v_1_snd_wnd)))
 (let (($x5321 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x24238 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x6848 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x9985 (= v_2_local_window v_1_local_window)))
 (let (($x4662 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x10592 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x25384 (= v_2_active_open v_1_active_open)))
 (let (($x16952 (= v_2_retries v_1_retries)))
 (let (($x1705 (= v_2_rto_ms v_1_rto_ms)))
 (let (($x2798 (= v_2_tx_flags "SA")))
 (let (($x25041 (= v_2_tx_ack (_ bv9001 32))))
 (let (($x25338 (= v_2_tx_seq v_1_iss)))
 (let (($x15455 (= v_2_rcv_nxt (_ bv9001 32))))
 (let (($x8647 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x10703 (= v_2_snd_una v_1_snd_una)))
 (let (($x21497 (= v_2_irs (_ bv9000 32))))
 (let (($x16169 (= v_2_iss v_1_iss)))
 (let (($x8546 (= 3 state_2)))
 (let (($x7763 (not active_1_persist)))
 (let (($x9718 (or $x7763 (not (<= due_1_persist 900)))))
 (let (($x15078 (not active_1_delack)))
 (let (($x1845 (or $x15078 (not (<= due_1_delack 900)))))
 (let (($x10193 (not active_1_time_wait)))
 (let (($x4058 (or $x10193 (not (<= due_1_time_wait 900)))))
 (let (($x20117 (or (not active_1_user) (not (<= due_1_user 900)))))
 (let (($x23849 (or (not active_1_rtx) (not (<= due_1_rtx 900)))))
 (let (($x809 (= state_1 2)))
 (and $x809 $x23849 $x20117 $x4058 $x1845 $x9718 $x8546 $x16169 $x21497 $x10703 $x8647 $x15455 $x25338 $x25041 $x2798 $x1705 $x16952 $x25384 $x10592 $x4662 $x9985 $x6848 $x24238 $x5321 $x15432 $x24231 $x3364 $x5836 $x21385 $x6193 $x23029 $x18853 $x12016 $x20107 $x10287 $x24244 $x16848 $x20304 $x20332 $x9074 $x20334 $x1171 $x20336 $x1155 $x20350 $x4743 $x20351 $x23225 $x377 $x20330 $x20324 $x13159 $x3021 $x17837 $x17220 $x21488 $x20329 $x13126 $x13127 $x13128 $x6301 $x15684 $x19084 $x9705 $x25682 $x12787 $x20703 $x21236 $x15184 $x24257 (= v_2_rtt_ambiguous (or $x10564 v_1_rtt_ambiguous)) $x12472 $x14852 $x8956 $x24192 $x23180 $x25222 $x3373 $x2988 $x7335 $x19348 $x9183 $x8180 $x3776 $x7133 $x9252 $x14667 $x23871 $x24980 $x4240 $x4641 $x21654 $x10736 $x7781 $x9243 $x8456 $x24894 $x921 $x20702 $x25071 $x13042 $x12324 $x13584 $x24964 $x696 $x13023 $x992 v_2_tx_syn_pending $x14381 $x18759 $x10908 $x5927 $x3701 $x11448 $x6749 $x4250 $x21885 $x13745 $x24243 $x10041 $x25597 $x20368 $x6149 $x11144 $x4091 $x1158 $x3574 $x21268 $x5714 $x6847 $x25619 active_2_rtx $x17043 $x9380 $x6806 $x4135 (= due_2_rtx (+ 900 v_1_rto_ms)) $x8528 $x25128 $x9151 $x15784)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 (let (($x21159 (= due_3_persist due_2_persist)))
 (let (($x23957 (= due_3_delack due_2_delack)))
 (let (($x18954 (= due_3_time_wait due_2_time_wait)))
 (let (($x8097 (= due_3_user due_2_user)))
 (let ((?x19124 (ite (>= v_2_rto_ms 30000) 60000 (* 2 v_2_rto_ms))))
 (let ((?x21820 (+ v_2_tx_syn_time v_2_rto_ms)))
 (let (($x20775 (<= ?x21820 1900)))
 (let ((?x19541 (ite $x20775 ?x19124 v_2_rto_ms)))
 (let ((?x14037 (ite $x20775 1900 v_2_tx_syn_time)))
 (let (($x15446 (not active_3_persist)))
 (let (($x7304 (not active_3_delack)))
 (let (($x21289 (= active_3_time_wait active_2_time_wait)))
 (let (($x17991 (= active_3_user active_2_user)))
 (let (($x15932 (= v_3_persist_elapsed_ms v_2_persist_elapsed_ms)))
 (let (($x8507 (= v_3_persist_probes 0)))
 (let (($x13869 (= v_3_persist_deadline_ms 0)))
 (let (($x643 (= v_3_persist_last_ms 0)))
 (let (($x14240 (= v_3_persist_since_ms 0)))
 (let (($x12229 (= v_3_persist_previous_interval_ms v_2_persist_previous_interval_ms)))
 (let (($x16907 (= v_3_persist_interval_ms 1000)))
 (let (($x9376 (not v_3_persist_probe_new)))
 (let (($x8468 (not v_3_persist_probe_sent)))
 (let (($x8340 (not v_3_persist_first)))
 (let (($x18552 (= v_3_persist_was_active v_2_persist_active)))
 (let (($x14270 (not v_3_persist_start)))
 (let (($x11363 (not v_3_persist_eligible)))
 (let (($x19711 (not v_3_persist_active)))
 (let (($x14368 (not v_3_ack_defer_now)))
 (let (($x13775 (not v_3_ack_defer_candidate)))
 (let (($x23850 (= v_3_ack_rmss v_2_ack_rmss)))
 (let (($x2281 (= v_3_ack_delay_ms v_2_ack_delay_ms)))
 (let (($x18094 (= 0 v_3_ack_full_segments)))
 (let (($x23902 (= 0 v_3_ack_bytes)))
 (let (($x8250 (= 0 v_3_ack_since_ms)))
 (let (($x6359 (not v_3_ack_pending)))
 (let (($x21775 (not v_3_tx_is_fin)))
 (let (($x25706 (= v_3_tx_previous_rto v_2_rto_ms)))
 (let (($x21776 (= v_3_tx_elapsed (ite $x20775 (+ 1900 (* (- 1) v_2_tx_syn_time)) 0))))
 (let (($x13587 (= v_3_tx_max_previous v_2_tx_syn_time)))
 (let (($x10364 (= v_3_tx_eligible v_2_tx_eligible)))
 (let ((?x19273 (ite (and v_2_fin_sent (not v_2_fin_acknowledged)) v_2_tx_fin_time 0)))
 (let (($x21255 (= v_3_tx_fin_time ?x19273)))
 (let (($x3818 (= v_3_tx_time_15 (ite (>= 15 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_15))))
 (let (($x23205 (= v_3_tx_time_14 (ite (>= 14 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_14))))
 (let (($x14048 (= v_3_tx_time_13 (ite (>= 13 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_13))))
 (let (($x15319 (= v_3_tx_time_12 (ite (>= 12 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_12))))
 (let (($x17751 (= v_3_tx_time_11 (ite (>= 11 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_11))))
 (let (($x21397 (= v_3_tx_time_10 (ite (>= 10 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_10))))
 (let (($x9088 (= v_3_tx_time_09 (ite (>= 9 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_09))))
 (let (($x7597 (= v_3_tx_time_08 (ite (>= 8 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_08))))
 (let (($x16012 (= v_3_tx_time_07 (ite (>= 7 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_07))))
 (let (($x20084 (= v_3_tx_time_06 (ite (>= 6 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_06))))
 (let (($x14293 (= v_3_tx_time_05 (ite (>= 5 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_05))))
 (let (($x18915 (= v_3_tx_time_04 (ite (>= 4 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_04))))
 (let (($x11231 (= v_3_tx_time_03 (ite (>= 3 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_03))))
 (let (($x15331 (= v_3_tx_time_02 (ite (>= 2 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_02))))
 (let (($x20284 (= v_3_tx_time_01 (ite (>= 1 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_01))))
 (let (($x23012 (= v_3_tx_time_00 (ite (>= 0 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_00))))
 (let (($x10431 (= v_3_rto_base_ms v_2_rto_base_ms)))
 (let (($x5648 (= v_3_rtt_samples v_2_rtt_samples)))
 (let (($x7658 (= v_3_rtt_last_ms v_2_rtt_last_ms)))
 (let (($x9396 (not v_3_rtt_sample_was_ambiguous)))
 (let (($x14882 (not v_3_rtt_sample_used)))
 (let (($x21265 (not v_3_rtt_start_new)))
 (let (($x8899 (= v_3_rtt_remaining v_2_rtt_remaining)))
 (let (($x11624 (= v_3_rtt_end v_2_rtt_end)))
 (let (($x5848 (= v_3_rtt_start_ms v_2_rtt_start_ms)))
 (let (($x10623 (= v_3_rtt_sample_at_ms v_2_rtt_sample_at_ms)))
 (let ((?x881 (* (- 1) v_2_rtt_remaining)))
 (let (($x12358 (<= (+ (ubv_to_int (bvadd v_2_rtt_end (bvmul (_ bv4294967295 32) v_2_snd_una))) ?x881) 0)))
 (let (($x8478 (ite $x20775 (or (and v_2_rtt_active $x12358) v_2_rtt_ambiguous) v_2_rtt_ambiguous)))
 (let (($x20170 (= v_3_rtt_active v_2_rtt_active)))
 (let (($x16413 (= v_3_rtt_previous_measured v_2_rtt_previous_measured)))
 (let (($x8015 (= v_3_rtt_measured v_2_rtt_measured)))
 (let (($x9522 (= v_3_rtt_previous_var v_2_rtt_previous_var)))
 (let (($x6997 (= v_3_rtt_previous_srtt v_2_rtt_previous_srtt)))
 (let (($x12367 (= v_3_rtt_error_ms v_2_rtt_error_ms)))
 (let (($x11690 (= v_3_rttvar_ms v_2_rttvar_ms)))
 (let (($x9604 (= v_3_srtt_ms v_2_srtt_ms)))
 (let (($x7250 (= v_3_rx_fin_consumed v_2_rx_fin_consumed)))
 (let (($x25109 (= v_3_rx_fin_done v_2_rx_fin_done)))
 (let (($x24559 (= v_3_rx_fin_offset v_2_rx_fin_offset)))
 (let (($x8588 (= v_3_rx_fin_seq v_2_rx_fin_seq)))
 (let (($x21902 (= v_3_rx_fin_pending v_2_rx_fin_pending)))
 (let (($x20308 (= v_3_fin_acknowledged v_2_fin_acknowledged)))
 (let (($x9172 (= v_3_fin_seq v_2_fin_seq)))
 (let (($x6263 (= v_3_fin_sent v_2_fin_sent)))
 (let (($x7736 (= v_3_fin_requested v_2_fin_requested)))
 (let (($x15338 (= v_3_ack_window_update v_2_ack_window_update)))
 (let (($x5473 (= v_3_ack_advance v_2_ack_advance)))
 (let (($x840 (= v_3_ack_is_future v_2_ack_is_future)))
 (let (($x2550 (= v_3_ack_is_new v_2_ack_is_new)))
 (let (($x25161 (= v_3_ack_delta v_2_ack_delta)))
 (let (($x838 (= v_3_seg_acceptable v_2_seg_acceptable)))
 (let (($x16262 (= v_3_rx_acceptable v_2_rx_acceptable)))
 (let (($x8428 (= v_3_rx_advance v_2_rx_advance)))
 (let (($x11046 (= v_3_rx_slot_15 v_2_rx_slot_15)))
 (let (($x8420 (= v_3_rx_slot_14 v_2_rx_slot_14)))
 (let (($x6816 (= v_3_rx_slot_13 v_2_rx_slot_13)))
 (let (($x8044 (= v_3_rx_slot_12 v_2_rx_slot_12)))
 (let (($x12560 (= v_3_rx_slot_11 v_2_rx_slot_11)))
 (let (($x9811 (= v_3_rx_slot_10 v_2_rx_slot_10)))
 (let (($x2324 (= v_3_rx_slot_09 v_2_rx_slot_09)))
 (let (($x18344 (= v_3_rx_slot_08 v_2_rx_slot_08)))
 (let (($x16902 (= v_3_rx_slot_07 v_2_rx_slot_07)))
 (let (($x25100 (= v_3_rx_slot_06 v_2_rx_slot_06)))
 (let (($x558 (= v_3_rx_slot_05 v_2_rx_slot_05)))
 (let (($x17040 (= v_3_rx_slot_04 v_2_rx_slot_04)))
 (let (($x23860 (= v_3_rx_slot_03 v_2_rx_slot_03)))
 (let (($x9206 (= v_3_rx_slot_02 v_2_rx_slot_02)))
 (let (($x365 (= v_3_rx_slot_01 v_2_rx_slot_01)))
 (let (($x8160 (= v_3_rx_slot_00 v_2_rx_slot_00)))
 (let (($x7354 (= v_3_rx_chunk v_2_rx_chunk)))
 (let (($x6173 (= v_3_take v_2_take)))
 (let (($x9203 (= v_3_snd_wl2 v_2_snd_wl2)))
 (let (($x7226 (= v_3_snd_wl1 v_2_snd_wl1)))
 (let (($x7168 (= v_3_snd_wnd v_2_snd_wnd)))
 (let (($x7170 (= v_3_rcv_buf v_2_rcv_buf)))
 (let (($x11772 (= v_3_rtx_buf v_2_rtx_buf)))
 (let (($x7194 (= v_3_snd_buf v_2_snd_buf)))
 (let (($x7178 (= v_3_local_window v_2_local_window)))
 (let (($x14254 (= v_3_msl_ms v_2_msl_ms)))
 (let (($x20286 (= v_3_user_timeout_ms v_2_user_timeout_ms)))
 (let (($x9395 (= v_3_active_open v_2_active_open)))
 (let (($x12182 (= v_3_tx_flags v_2_tx_flags)))
 (let (($x21436 (= v_3_tx_ack v_2_tx_ack)))
 (let (($x8279 (= v_3_tx_seq v_2_tx_seq)))
 (let (($x22745 (= v_3_rcv_nxt v_2_rcv_nxt)))
 (let (($x2066 (= v_3_snd_nxt v_2_snd_nxt)))
 (let (($x10748 (= v_3_snd_una v_2_snd_una)))
 (let (($x13680 (= v_3_irs v_2_irs)))
 (let (($x21319 (= v_3_iss v_2_iss)))
 (let (($x164 (= 3 state_3)))
 (let (($x3140 (= state_2 3)))
 (and $x3140 active_2_rtx (= 1900 due_2_rtx) (or (not active_2_user) (<= due_2_rtx due_2_user)) (or (not active_2_time_wait) (<= due_2_rtx due_2_time_wait)) (or (not active_2_delack) (not (<= due_2_delack due_2_rtx))) (or (not active_2_persist) (not (<= due_2_persist due_2_rtx))) $x164 $x21319 $x13680 $x10748 $x2066 $x22745 $x8279 $x21436 $x12182 (= v_3_rto_ms ?x19541) (= v_3_retries (ite $x20775 (+ 1 v_2_retries) v_2_retries)) $x9395 $x20286 $x14254 $x7178 $x7194 $x11772 $x7170 $x7168 $x7226 $x9203 $x6173 $x7354 $x8160 $x365 $x9206 $x23860 $x17040 $x558 $x25100 $x16902 $x18344 $x2324 $x9811 $x12560 $x8044 $x6816 $x8420 $x11046 $x8428 $x16262 $x838 $x25161 $x2550 $x840 $x5473 $x15338 $x7736 $x6263 $x9172 $x20308 $x21902 $x8588 $x24559 $x25109 $x7250 $x9604 $x11690 $x12367 $x6997 $x9522 $x8015 $x16413 $x20170 (= v_3_rtt_ambiguous $x8478) $x10623 $x5848 $x11624 $x8899 $x21265 $x14882 $x9396 $x7658 $x5648 $x10431 $x23012 $x20284 $x15331 $x11231 $x18915 $x14293 $x20084 $x16012 $x7597 $x9088 $x21397 $x17751 $x15319 $x14048 $x23205 $x3818 $x21255 (= v_3_tx_emit_count (ite $x20775 1 0)) $x10364 $x13587 (= v_3_tx_retransmitted $x20775) $x21776 $x25706 $x21775 (not (= $x20775 v_3_tx_waiting)) (= v_3_tx_syn_time ?x14037) v_3_tx_syn_pending (= v_3_syn_timeout_eligible $x20775) $x6359 $x8250 $x23902 $x18094 $x2281 $x23850 $x13775 $x14368 $x19711 $x11363 $x14270 $x18552 $x8340 $x8468 $x9376 $x16907 $x12229 $x14240 $x643 $x13869 $x8507 $x15932 active_3_rtx $x17991 $x21289 $x7304 $x15446 (= due_3_rtx (+ 1900 (ite $x20775 ?x19124 (+ (- 1900) ?x14037 ?x19541)))) $x8097 $x18954 $x23957 $x21159))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
 (= 3 choice_1))
(assert
 (= 900 now_2))
(assert
 (= (_ bv9000 32) input_1_net.syn_seq))
(assert
 (= 28 choice_2))
(assert
 (= 1900 now_3))
(check-sat)
