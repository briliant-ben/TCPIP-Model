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
(declare-fun due_3_delack () Int)
(declare-fun due_3_time_wait () Int)
(declare-fun due_3_user () Int)
(declare-fun due_3_rtx () Int)
(declare-fun active_3_delack () Bool)
(declare-fun active_3_time_wait () Bool)
(declare-fun active_3_user () Bool)
(declare-fun active_3_rtx () Bool)
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
 (let (($x290287 (= due_1_delack due_0_delack)))
 (let (($x234742 (= due_1_time_wait due_0_time_wait)))
 (let (($x89440 (= due_1_user 30000)))
 (let (($x788566 (= due_1_rtx 1000)))
 (let (($x882428 (not active_1_delack)))
 (let (($x28779 (not active_1_time_wait)))
 (let (($x20822 (not v_1_ack_defer_now)))
 (let (($x51958 (not v_1_ack_defer_candidate)))
 (let (($x479148 (= v_1_ack_rmss 4)))
 (let (($x868681 (= v_1_ack_delay_ms 40)))
 (let (($x338423 (= 0 v_1_ack_full_segments)))
 (let (($x636051 (= 0 v_1_ack_bytes)))
 (let (($x216390 (= 0 v_1_ack_since_ms)))
 (let (($x875146 (not v_1_ack_pending)))
 (let (($x169481 (not v_1_syn_timeout_eligible)))
 (let (($x741358 (= v_1_tx_syn_time 0)))
 (let (($x684046 (not v_1_tx_waiting)))
 (let (($x312120 (not v_1_tx_is_fin)))
 (let (($x506945 (= v_1_tx_previous_rto 1000)))
 (let (($x35527 (= v_1_tx_elapsed 0)))
 (let (($x135183 (not v_1_tx_retransmitted)))
 (let (($x399692 (= v_1_tx_max_previous 0)))
 (let (($x383984 (= v_1_tx_eligible 0)))
 (let (($x129576 (= v_1_tx_emit_count 0)))
 (let (($x509434 (= v_1_tx_fin_time 0)))
 (let (($x733594 (= v_1_tx_time_15 0)))
 (let (($x868077 (= v_1_tx_time_14 0)))
 (let (($x233580 (= v_1_tx_time_13 0)))
 (let (($x870163 (= v_1_tx_time_12 0)))
 (let (($x244638 (= v_1_tx_time_11 0)))
 (let (($x875365 (= v_1_tx_time_10 0)))
 (let (($x682383 (= v_1_tx_time_09 0)))
 (let (($x311165 (= v_1_tx_time_08 0)))
 (let (($x442213 (= v_1_tx_time_07 0)))
 (let (($x321089 (= v_1_tx_time_06 0)))
 (let (($x844231 (= v_1_tx_time_05 0)))
 (let (($x45508 (= v_1_tx_time_04 0)))
 (let (($x825246 (= v_1_tx_time_03 0)))
 (let (($x226640 (= v_1_tx_time_02 0)))
 (let (($x610030 (= v_1_tx_time_01 0)))
 (let (($x147861 (= v_1_tx_time_00 0)))
 (let (($x79336 (= v_1_rto_base_ms 1000)))
 (let (($x60408 (= v_1_rtt_samples 0)))
 (let (($x150148 (= v_1_rtt_last_ms 0)))
 (let (($x605054 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x491246 (not v_1_rtt_sample_used)))
 (let (($x428921 (= v_1_rtt_remaining 1)))
 (let (($x5103 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x602728 (= v_1_rtt_start_ms 0)))
 (let (($x637272 (= v_1_rtt_sample_at_ms 0)))
 (let (($x519120 (not v_1_rtt_ambiguous)))
 (let (($x258720 (not v_1_rtt_previous_measured)))
 (let (($x166457 (not v_1_rtt_measured)))
 (let (($x3815 (= v_1_rtt_previous_var 0.0)))
 (let (($x16219 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x239378 (= v_1_rtt_error_ms 0.0)))
 (let (($x139556 (= v_1_rttvar_ms 0.0)))
 (let (($x639633 (= v_1_srtt_ms 0.0)))
 (let (($x354700 (not v_1_rx_fin_consumed)))
 (let (($x749658 (not v_1_rx_fin_done)))
 (let (($x107673 (= v_1_rx_fin_offset 0)))
 (let (($x211149 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x163537 (not v_1_rx_fin_pending)))
 (let (($x50929 (not v_1_fin_acknowledged)))
 (let (($x293346 (= v_1_fin_seq (_ bv0 32))))
 (let (($x187018 (not v_1_fin_sent)))
 (let (($x290140 (not v_1_fin_requested)))
 (let (($x172746 (not v_1_ack_window_update)))
 (let (($x333135 (not v_1_ack_advance)))
 (let (($x87420 (not v_1_ack_is_future)))
 (let (($x360483 (not v_1_ack_is_new)))
 (let (($x58657 (= v_1_ack_delta 0)))
 (let (($x138423 (not v_1_seg_acceptable)))
 (let (($x150446 (not v_1_rx_acceptable)))
 (let (($x114896 (= v_1_rx_advance 0)))
 (let (($x421162 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x143270 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x150107 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x182353 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x767590 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x171289 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x39099 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x827912 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x848094 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x308094 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x609902 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x58610 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x604680 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x500431 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x266748 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x867486 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x215647 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x547821 (= v_1_take 0)))
 (let (($x377352 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x217058 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x256469 (= v_1_snd_wnd 8)))
 (let (($x47604 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x139138 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x604034 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x303268 (= v_1_local_window 16)))
 (let (($x517643 (= v_1_msl_ms 60000)))
 (let (($x34314 (= v_1_user_timeout_ms 30000)))
 (let (($x601044 (= 0 v_1_retries)))
 (let (($x640139 (= 1000 v_1_rto_ms)))
 (let (($x243141 (= v_1_tx_flags "S")))
 (let (($x165142 (= v_1_tx_ack (_ bv0 32))))
 (let (($x140470 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x291030 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x78530 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x258449 (= v_1_snd_una (_ bv1000 32))))
 (let (($x289604 (= v_1_irs (_ bv0 32))))
 (let (($x47797 (= v_1_iss (_ bv1000 32))))
 (let (($x139025 (= 2 state_1)))
 (let (($x296005 (not active_0_delack)))
 (let (($x604736 (or $x296005 (not (<= due_0_delack 0)))))
 (let (($x604834 (not active_0_time_wait)))
 (let (($x42861 (or $x604834 (not (<= due_0_time_wait 0)))))
 (let (($x269838 (not active_0_user)))
 (let (($x835839 (or $x269838 (not (<= due_0_user 0)))))
 (let (($x548419 (not active_0_rtx)))
 (let (($x333383 (or $x548419 (not (<= due_0_rtx 0)))))
 (let (($x645503 (= state_0 0)))
 (and $x645503 (>= 0 now_0) $x333383 $x835839 $x42861 $x604736 $x139025 $x47797 $x289604 $x258449 $x78530 $x291030 $x140470 $x165142 $x243141 $x640139 $x601044 v_1_active_open $x34314 $x517643 $x303268 $x604034 $x139138 $x47604 $x256469 $x217058 $x377352 $x547821 $x215647 $x867486 $x266748 $x500431 $x604680 $x58610 $x609902 $x308094 $x848094 $x827912 $x39099 $x171289 $x767590 $x182353 $x150107 $x143270 $x421162 $x114896 $x150446 $x138423 $x58657 $x360483 $x87420 $x333135 $x172746 $x290140 $x187018 $x293346 $x50929 $x163537 $x211149 $x107673 $x749658 $x354700 $x639633 $x139556 $x239378 $x16219 $x3815 $x166457 $x258720 v_1_rtt_active $x519120 $x637272 $x602728 $x5103 $x428921 v_1_rtt_start_new $x491246 $x605054 $x150148 $x60408 $x79336 $x147861 $x610030 $x226640 $x825246 $x45508 $x844231 $x321089 $x442213 $x311165 $x682383 $x875365 $x244638 $x870163 $x233580 $x868077 $x733594 $x509434 $x129576 $x383984 $x399692 $x135183 $x35527 $x506945 $x312120 $x684046 $x741358 v_1_tx_syn_pending $x169481 $x875146 $x216390 $x636051 $x338423 $x868681 $x479148 $x51958 $x20822 active_1_rtx active_1_user $x28779 $x882428 $x788566 $x89440 $x234742 $x290287))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x155691 (= due_2_delack due_1_delack)))
 (let (($x4423 (= due_2_time_wait due_1_time_wait)))
 (let (($x57937 (= due_2_user due_1_user)))
 (let ((?x207292 (ite (>= v_1_rto_ms 30000) 60000 (* 2 v_1_rto_ms))))
 (let ((?x115752 (+ v_1_tx_syn_time v_1_rto_ms)))
 (let (($x157515 (<= ?x115752 1000)))
 (let ((?x603390 (ite $x157515 ?x207292 v_1_rto_ms)))
 (let ((?x302563 (ite $x157515 1000 v_1_tx_syn_time)))
 (let (($x863292 (not active_2_delack)))
 (let (($x278019 (= active_2_time_wait active_1_time_wait)))
 (let (($x143554 (= active_2_user active_1_user)))
 (let (($x456828 (not v_2_ack_defer_now)))
 (let (($x259197 (not v_2_ack_defer_candidate)))
 (let (($x459007 (= v_2_ack_rmss v_1_ack_rmss)))
 (let (($x173549 (= v_2_ack_delay_ms v_1_ack_delay_ms)))
 (let (($x526336 (= 0 v_2_ack_full_segments)))
 (let (($x111442 (= 0 v_2_ack_bytes)))
 (let (($x107940 (= 0 v_2_ack_since_ms)))
 (let (($x194584 (not v_2_ack_pending)))
 (let (($x139261 (not v_2_tx_is_fin)))
 (let (($x471093 (= v_2_tx_previous_rto v_1_rto_ms)))
 (let (($x100476 (= v_2_tx_elapsed (ite $x157515 (+ 1000 (* (- 1) v_1_tx_syn_time)) 0))))
 (let (($x92459 (= v_2_tx_max_previous v_1_tx_syn_time)))
 (let (($x601007 (= v_2_tx_eligible v_1_tx_eligible)))
 (let ((?x261063 (ite (and v_1_fin_sent (not v_1_fin_acknowledged)) v_1_tx_fin_time 0)))
 (let (($x603319 (= v_2_tx_fin_time ?x261063)))
 (let (($x682847 (= v_2_tx_time_15 (ite (>= 15 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_15))))
 (let (($x20848 (= v_2_tx_time_14 (ite (>= 14 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_14))))
 (let (($x118419 (= v_2_tx_time_13 (ite (>= 13 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_13))))
 (let (($x94245 (= v_2_tx_time_12 (ite (>= 12 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_12))))
 (let (($x26422 (= v_2_tx_time_11 (ite (>= 11 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_11))))
 (let (($x84086 (= v_2_tx_time_10 (ite (>= 10 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_10))))
 (let (($x190278 (= v_2_tx_time_09 (ite (>= 9 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_09))))
 (let (($x300617 (= v_2_tx_time_08 (ite (>= 8 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_08))))
 (let (($x26426 (= v_2_tx_time_07 (ite (>= 7 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_07))))
 (let (($x305431 (= v_2_tx_time_06 (ite (>= 6 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_06))))
 (let (($x681502 (= v_2_tx_time_05 (ite (>= 5 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_05))))
 (let (($x875131 (= v_2_tx_time_04 (ite (>= 4 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_04))))
 (let (($x395340 (= v_2_tx_time_03 (ite (>= 3 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_03))))
 (let (($x18924 (= v_2_tx_time_02 (ite (>= 2 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_02))))
 (let (($x358339 (= v_2_tx_time_01 (ite (>= 1 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_01))))
 (let (($x764863 (= v_2_tx_time_00 (ite (>= 0 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_00))))
 (let (($x872915 (= v_2_rto_base_ms v_1_rto_base_ms)))
 (let (($x205670 (= v_2_rtt_samples v_1_rtt_samples)))
 (let (($x219557 (= v_2_rtt_last_ms v_1_rtt_last_ms)))
 (let (($x605523 (not v_2_rtt_sample_was_ambiguous)))
 (let (($x97761 (not v_2_rtt_sample_used)))
 (let (($x157801 (not v_2_rtt_start_new)))
 (let (($x825065 (= v_2_rtt_remaining v_1_rtt_remaining)))
 (let (($x174993 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x391132 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let (($x600799 (= v_2_rtt_sample_at_ms v_1_rtt_sample_at_ms)))
 (let ((?x181967 (+ (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una))) (* (- 1) v_1_rtt_remaining))))
 (let (($x472660 (ite $x157515 (or v_1_rtt_ambiguous (and v_1_rtt_active (<= ?x181967 0))) v_1_rtt_ambiguous)))
 (let (($x869642 (= v_2_rtt_active v_1_rtt_active)))
 (let (($x609099 (= v_2_rtt_previous_measured v_1_rtt_previous_measured)))
 (let (($x520880 (= v_2_rtt_measured v_1_rtt_measured)))
 (let (($x71338 (= v_2_rtt_previous_var v_1_rtt_previous_var)))
 (let (($x637849 (= v_2_rtt_previous_srtt v_1_rtt_previous_srtt)))
 (let (($x78045 (= v_2_rtt_error_ms v_1_rtt_error_ms)))
 (let (($x146770 (= v_2_rttvar_ms v_1_rttvar_ms)))
 (let (($x409917 (= v_2_srtt_ms v_1_srtt_ms)))
 (let (($x82593 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x775814 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x307094 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x316258 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x297022 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x547216 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x114032 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x130039 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x239826 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x137081 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x651006 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x765967 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x240693 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x31789 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x135744 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x86423 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x213495 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x3908 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x191325 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x602116 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x458196 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x72808 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x137623 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x869851 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x580883 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x45822 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x72979 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x22284 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x881552 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x69650 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x172885 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x162586 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x371312 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x85149 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x16958 (= v_2_take v_1_take)))
 (let (($x711606 (= v_2_snd_wl2 v_1_snd_wl2)))
 (let (($x217062 (= v_2_snd_wl1 v_1_snd_wl1)))
 (let (($x207888 (= v_2_snd_wnd v_1_snd_wnd)))
 (let (($x410241 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x884588 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x682525 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x779829 (= v_2_local_window v_1_local_window)))
 (let (($x185326 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x161816 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x56804 (= v_2_active_open v_1_active_open)))
 (let (($x476362 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x870414 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x558891 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x196867 (= v_2_rcv_nxt v_1_rcv_nxt)))
 (let (($x376854 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x407130 (= v_2_snd_una v_1_snd_una)))
 (let (($x309596 (= v_2_irs v_1_irs)))
 (let (($x814369 (= v_2_iss v_1_iss)))
 (let (($x426907 (= 2 state_2)))
 (let (($x365441 (= state_1 2)))
 (and $x365441 active_1_rtx (= 1000 due_1_rtx) (or (not active_1_user) (<= due_1_rtx due_1_user)) (or (not active_1_time_wait) (<= due_1_rtx due_1_time_wait)) (or (not active_1_delack) (not (<= due_1_delack due_1_rtx))) $x426907 $x814369 $x309596 $x407130 $x376854 $x196867 $x558891 $x870414 $x476362 (= v_2_rto_ms ?x603390) (= v_2_retries (ite $x157515 (+ 1 v_1_retries) v_1_retries)) $x56804 $x161816 $x185326 $x779829 $x682525 $x884588 $x410241 $x207888 $x217062 $x711606 $x16958 $x85149 $x371312 $x162586 $x172885 $x69650 $x881552 $x22284 $x72979 $x45822 $x580883 $x869851 $x137623 $x72808 $x458196 $x602116 $x191325 $x3908 $x213495 $x86423 $x135744 $x31789 $x240693 $x765967 $x651006 $x137081 $x239826 $x130039 $x114032 $x547216 $x297022 $x316258 $x307094 $x775814 $x82593 $x409917 $x146770 $x78045 $x637849 $x71338 $x520880 $x609099 $x869642 (= v_2_rtt_ambiguous $x472660) $x600799 $x391132 $x174993 $x825065 $x157801 $x97761 $x605523 $x219557 $x205670 $x872915 $x764863 $x358339 $x18924 $x395340 $x875131 $x681502 $x305431 $x26426 $x300617 $x190278 $x84086 $x26422 $x94245 $x118419 $x20848 $x682847 $x603319 (= v_2_tx_emit_count (ite $x157515 1 0)) $x601007 $x92459 (= v_2_tx_retransmitted $x157515) $x100476 $x471093 $x139261 (not (= $x157515 v_2_tx_waiting)) (= v_2_tx_syn_time ?x302563) v_2_tx_syn_pending (= v_2_syn_timeout_eligible $x157515) $x194584 $x107940 $x111442 $x526336 $x173549 $x459007 $x259197 $x456828 active_2_rtx $x143554 $x278019 $x863292 (= due_2_rtx (+ 1000 (ite $x157515 ?x207292 (+ (- 1000) ?x302563 ?x603390)))) $x57937 $x4423 $x155691)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 (let (($x207939 (= due_3_delack due_2_delack)))
 (let (($x319976 (= due_3_time_wait due_2_time_wait)))
 (let (($x83356 (= due_3_user due_2_user)))
 (let (($x92131 (= due_3_rtx due_2_rtx)))
 (let (($x218452 (not active_3_delack)))
 (let (($x278567 (= active_3_time_wait active_2_time_wait)))
 (let (($x870193 (not active_3_user)))
 (let (($x144033 (not active_3_rtx)))
 (let (($x602316 (not v_3_ack_defer_now)))
 (let (($x842007 (not v_3_ack_defer_candidate)))
 (let (($x18382 (= v_3_ack_rmss v_2_ack_rmss)))
 (let (($x8492 (= v_3_ack_delay_ms v_2_ack_delay_ms)))
 (let (($x759079 (= v_3_ack_full_segments 0)))
 (let (($x83265 (= v_3_ack_bytes 0)))
 (let (($x549402 (= v_3_ack_since_ms 0)))
 (let (($x169508 (not v_3_ack_pending)))
 (let (($x144721 (not v_3_syn_timeout_eligible)))
 (let (($x643810 (not v_3_tx_syn_pending)))
 (let (($x747491 (= v_3_tx_syn_time 0)))
 (let (($x36719 (not v_3_tx_waiting)))
 (let (($x20160 (= v_3_tx_is_fin v_2_tx_is_fin)))
 (let (($x107918 (= v_3_tx_previous_rto v_2_tx_previous_rto)))
 (let (($x137684 (= v_3_tx_elapsed v_2_tx_elapsed)))
 (let (($x67151 (not v_3_tx_retransmitted)))
 (let (($x25945 (= v_3_tx_max_previous v_2_tx_max_previous)))
 (let (($x302362 (= v_3_tx_eligible v_2_tx_eligible)))
 (let (($x13137 (= v_3_tx_emit_count v_2_tx_emit_count)))
 (let ((?x256715 (ite (and v_2_fin_sent (not v_2_fin_acknowledged)) v_2_tx_fin_time 0)))
 (let (($x139107 (= v_3_tx_fin_time ?x256715)))
 (let (($x3739 (= v_3_tx_time_15 (ite (>= 15 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_15))))
 (let (($x446596 (= v_3_tx_time_14 (ite (>= 14 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_14))))
 (let (($x262454 (= v_3_tx_time_13 (ite (>= 13 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_13))))
 (let (($x269258 (= v_3_tx_time_12 (ite (>= 12 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_12))))
 (let (($x180823 (= v_3_tx_time_11 (ite (>= 11 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_11))))
 (let (($x636657 (= v_3_tx_time_10 (ite (>= 10 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_10))))
 (let (($x192447 (= v_3_tx_time_09 (ite (>= 9 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_09))))
 (let (($x147605 (= v_3_tx_time_08 (ite (>= 8 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_08))))
 (let (($x607881 (= v_3_tx_time_07 (ite (>= 7 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_07))))
 (let (($x180285 (= v_3_tx_time_06 (ite (>= 6 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_06))))
 (let (($x165578 (= v_3_tx_time_05 (ite (>= 5 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_05))))
 (let (($x16375 (= v_3_tx_time_04 (ite (>= 4 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_04))))
 (let (($x699473 (= v_3_tx_time_03 (ite (>= 3 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_03))))
 (let (($x166299 (= v_3_tx_time_02 (ite (>= 2 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_02))))
 (let (($x133262 (= v_3_tx_time_01 (ite (>= 1 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_01))))
 (let (($x112825 (= v_3_tx_time_00 (ite (>= 0 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_00))))
 (let ((?x169752 (+ 1010 (* (- 1) v_2_rtt_start_ms))))
 (let (($x71417 (not v_2_rtt_ambiguous)))
 (let ((?x99191 (ubv_to_int (bvadd v_2_rtt_end (bvmul (_ bv4294967295 32) v_2_snd_una)))))
 (let ((?x473454 (ubv_to_int (bvadd (_ bv1001 32) (bvmul (_ bv4294967295 32) v_2_snd_una)))))
 (let (($x297344 (>= ?x473454 ?x99191)))
 (let (($x155438 (and v_2_rtt_active $x297344 $x71417)))
 (let ((?x124796 (ite $x155438 ?x169752 v_2_rtt_last_ms)))
 (let ((?x115742 (to_real ?x124796)))
 (let ((?x307733 (+ v_2_srtt_ms (* (- 1.0) ?x115742))))
 (let ((?x100791 (ite $x155438 (ite (>= ?x307733 0.0) ?x307733 (+ (* (- 1.0) v_2_srtt_ms) ?x115742)) v_2_rtt_error_ms)))
 (let ((?x177580 (* (/ 3.0 4.0) v_2_rttvar_ms)))
 (let ((?x180651 (ite $x155438 (ite v_2_rtt_measured (+ ?x177580 (* (/ 1.0 4.0) ?x100791)) (* (/ 1.0 2.0) ?x115742)) v_2_rttvar_ms)))
 (let ((?x41932 (ite v_2_rtt_measured (+ (* (/ 7.0 8.0) v_2_srtt_ms) (* (/ 1.0 8.0) ?x115742)) ?x115742)))
 (let ((?x48761 (ite $x155438 ?x41932 v_2_srtt_ms)))
 (let ((?x18925 (+ (* (- 1.0) ?x48761) (* (- 1.0) (ite (<= ?x180651 (/ 1.0 4.0)) 1.0 (* 4.0 ?x180651))))))
 (let ((?x250739 (to_int ?x18925)))
 (let ((?x635962 (ite (<= ?x250739 (- 1000)) (* (- 1) ?x250739) 1000)))
 (let (($x645131 (= v_3_rto_base_ms (ite $x155438 (ite (<= 60000 ?x635962) 60000 ?x635962) v_2_rto_base_ms))))
 (let (($x135596 (= v_3_rtt_sample_was_ambiguous (and v_2_rtt_active v_2_rtt_ambiguous))))
 (let (($x100528 (not v_3_rtt_start_new)))
 (let ((?x220415 (* (- 1) ?x473454)))
 (let ((?x103765 (+ ?x99191 ?x220415)))
 (let ((?x150988 (ite (and v_2_rtt_active (not (<= v_2_rtt_remaining ?x103765))) ?x103765 v_2_rtt_remaining)))
 (let (($x175404 (and v_2_rtt_active $x297344)))
 (let (($x232175 (= v_3_rtt_end v_2_rtt_end)))
 (let (($x68435 (= v_3_rtt_start_ms v_2_rtt_start_ms)))
 (let (($x70659 (= v_3_rtt_previous_measured (ite $x155438 v_2_rtt_measured v_2_rtt_previous_measured))))
 (let (($x246884 (= v_3_rtt_previous_var (ite $x155438 v_2_rttvar_ms v_2_rtt_previous_var))))
 (let (($x149187 (= v_3_rtt_previous_srtt (ite $x155438 v_2_srtt_ms v_2_rtt_previous_srtt))))
 (let (($x249019 (= v_3_rx_fin_consumed v_2_rx_fin_consumed)))
 (let (($x37757 (= v_3_rx_fin_done v_2_rx_fin_done)))
 (let (($x602271 (= v_3_rx_fin_offset v_2_rx_fin_offset)))
 (let (($x2540 (= v_3_rx_fin_seq v_2_rx_fin_seq)))
 (let (($x526319 (= v_3_rx_fin_pending v_2_rx_fin_pending)))
 (let (($x390129 (= v_3_fin_acknowledged v_2_fin_acknowledged)))
 (let (($x653760 (= v_3_fin_seq v_2_fin_seq)))
 (let (($x199038 (= v_3_fin_sent v_2_fin_sent)))
 (let (($x301810 (= v_3_fin_requested v_2_fin_requested)))
 (let (($x638754 (= v_3_ack_window_update v_2_ack_window_update)))
 (let (($x354630 (= v_3_ack_advance v_2_ack_advance)))
 (let (($x786953 (= v_3_ack_is_future v_2_ack_is_future)))
 (let (($x147498 (= v_3_ack_is_new v_2_ack_is_new)))
 (let (($x872949 (= v_3_ack_delta v_2_ack_delta)))
 (let (($x95784 (= v_3_seg_acceptable v_2_seg_acceptable)))
 (let (($x604431 (= v_3_rx_acceptable v_2_rx_acceptable)))
 (let (($x602174 (= v_3_rx_advance v_2_rx_advance)))
 (let (($x263656 (= v_3_rx_slot_15 v_2_rx_slot_15)))
 (let (($x1244 (= v_3_rx_slot_14 v_2_rx_slot_14)))
 (let (($x49754 (= v_3_rx_slot_13 v_2_rx_slot_13)))
 (let (($x642314 (= v_3_rx_slot_12 v_2_rx_slot_12)))
 (let (($x541966 (= v_3_rx_slot_11 v_2_rx_slot_11)))
 (let (($x64911 (= v_3_rx_slot_10 v_2_rx_slot_10)))
 (let (($x282714 (= v_3_rx_slot_09 v_2_rx_slot_09)))
 (let (($x7540 (= v_3_rx_slot_08 v_2_rx_slot_08)))
 (let (($x66351 (= v_3_rx_slot_07 v_2_rx_slot_07)))
 (let (($x443234 (= v_3_rx_slot_06 v_2_rx_slot_06)))
 (let (($x637002 (= v_3_rx_slot_05 v_2_rx_slot_05)))
 (let (($x132643 (= v_3_rx_slot_04 v_2_rx_slot_04)))
 (let (($x128285 (= v_3_rx_slot_03 v_2_rx_slot_03)))
 (let (($x617792 (= v_3_rx_slot_02 v_2_rx_slot_02)))
 (let (($x522859 (= v_3_rx_slot_01 v_2_rx_slot_01)))
 (let (($x614543 (= v_3_rx_slot_00 v_2_rx_slot_00)))
 (let (($x210171 (= v_3_rx_chunk v_2_rx_chunk)))
 (let (($x318710 (= v_3_take v_2_take)))
 (let (($x219427 (= v_3_snd_wl2 (_ bv1001 32))))
 (let (($x258855 (= v_3_snd_wl1 (_ bv9000 32))))
 (let (($x273797 (= v_3_snd_wnd 16)))
 (let (($x216804 (= v_3_rcv_buf v_2_rcv_buf)))
 (let (($x85747 (= v_3_rtx_buf v_2_rtx_buf)))
 (let (($x227571 (= v_3_snd_buf v_2_snd_buf)))
 (let (($x147033 (= v_3_local_window v_2_local_window)))
 (let (($x152856 (= v_3_msl_ms v_2_msl_ms)))
 (let (($x212692 (= v_3_user_timeout_ms v_2_user_timeout_ms)))
 (let (($x224023 (= v_3_active_open v_2_active_open)))
 (let (($x77679 (= v_3_retries v_2_retries)))
 (let (($x30667 (= 3000 v_3_rto_ms)))
 (let (($x314263 (= v_3_tx_flags v_2_tx_flags)))
 (let (($x343171 (= v_3_tx_ack v_2_tx_ack)))
 (let (($x47085 (= v_3_tx_seq v_2_tx_seq)))
 (let (($x147291 (= v_3_rcv_nxt (_ bv9001 32))))
 (let (($x635706 (= v_3_snd_nxt v_2_snd_nxt)))
 (let (($x753509 (= v_3_snd_una (_ bv1001 32))))
 (let (($x37431 (= v_3_irs (_ bv9000 32))))
 (let (($x303398 (= v_3_iss v_2_iss)))
 (let (($x151115 (= 4 state_3)))
 (let (($x863292 (not active_2_delack)))
 (let (($x514403 (or $x863292 (not (<= due_2_delack 1010)))))
 (let (($x664672 (or (not active_2_time_wait) (not (<= due_2_time_wait 1010)))))
 (let (($x78236 (or (not active_2_user) (not (<= due_2_user 1010)))))
 (let (($x56941 (or (not active_2_rtx) (not (<= due_2_rtx 1010)))))
 (let (($x606377 (= 1 v_2_retries)))
 (let (($x450723 (= v_2_snd_nxt (_ bv1001 32))))
 (let (($x311589 (= state_2 2)))
 (and $x311589 $x450723 $x606377 $x56941 $x78236 $x664672 $x514403 $x151115 $x303398 $x37431 $x753509 $x635706 $x147291 $x47085 $x343171 $x314263 $x30667 $x77679 $x224023 $x212692 $x152856 $x147033 $x227571 $x85747 $x216804 $x273797 $x258855 $x219427 $x318710 $x210171 $x614543 $x522859 $x617792 $x128285 $x132643 $x637002 $x443234 $x66351 $x7540 $x282714 $x64911 $x541966 $x642314 $x49754 $x1244 $x263656 $x602174 $x604431 $x95784 $x872949 $x147498 $x786953 $x354630 $x638754 $x301810 $x199038 $x653760 $x390129 $x526319 $x2540 $x602271 $x37757 $x249019 (= v_3_srtt_ms ?x48761) (= v_3_rttvar_ms ?x180651) (= v_3_rtt_error_ms ?x100791) $x149187 $x246884 (= v_3_rtt_measured (or v_2_rtt_measured $x155438)) $x70659 (= v_3_rtt_active (and v_2_rtt_active (not $x175404))) (= v_3_rtt_ambiguous (and (not $x175404) v_2_rtt_ambiguous)) (= v_3_rtt_sample_at_ms (ite $x155438 1010 v_2_rtt_sample_at_ms)) $x68435 $x232175 (= v_3_rtt_remaining (ite $x175404 0 ?x150988)) $x100528 (= v_3_rtt_sample_used $x155438) $x135596 (= v_3_rtt_last_ms ?x124796) (= v_3_rtt_samples (+ v_2_rtt_samples (ite $x155438 1 0))) $x645131 $x112825 $x133262 $x166299 $x699473 $x16375 $x165578 $x180285 $x607881 $x147605 $x192447 $x636657 $x180823 $x269258 $x262454 $x446596 $x3739 $x139107 $x13137 $x302362 $x25945 $x67151 $x137684 $x107918 $x20160 $x36719 $x747491 $x643810 $x144721 $x169508 $x549402 $x83265 $x759079 $x8492 $x18382 $x842007 $x602316 $x144033 $x870193 $x278567 $x218452 $x92131 $x83356 $x319976 $x207939))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
