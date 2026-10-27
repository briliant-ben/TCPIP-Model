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
 (let (($x162560 (= due_1_delack due_0_delack)))
 (let (($x91800 (= due_1_time_wait due_0_time_wait)))
 (let (($x67371 (= due_1_user due_0_user)))
 (let (($x87848 (= due_1_rtx due_0_rtx)))
 (let (($x10517 (not active_1_delack)))
 (let (($x766734 (not active_1_time_wait)))
 (let (($x195710 (not active_1_user)))
 (let (($x309254 (not active_1_rtx)))
 (let (($x313293 (not v_1_ack_defer_now)))
 (let (($x196983 (not v_1_ack_defer_candidate)))
 (let (($x45328 (= v_1_ack_rmss 4)))
 (let (($x164832 (= v_1_ack_delay_ms 40)))
 (let (($x461601 (= 0 v_1_ack_full_segments)))
 (let (($x301401 (= 0 v_1_ack_bytes)))
 (let (($x471212 (= 0 v_1_ack_since_ms)))
 (let (($x183114 (not v_1_ack_pending)))
 (let (($x601667 (not v_1_syn_timeout_eligible)))
 (let (($x635247 (not v_1_tx_syn_pending)))
 (let (($x107602 (= v_1_tx_syn_time 0)))
 (let (($x326230 (not v_1_tx_waiting)))
 (let (($x288757 (not v_1_tx_is_fin)))
 (let (($x141182 (= v_1_tx_previous_rto 1000)))
 (let (($x88369 (= v_1_tx_elapsed 0)))
 (let (($x90447 (not v_1_tx_retransmitted)))
 (let (($x37166 (= v_1_tx_max_previous 0)))
 (let (($x163058 (= v_1_tx_eligible 0)))
 (let (($x218544 (= v_1_tx_emit_count 0)))
 (let (($x600925 (= v_1_tx_fin_time 0)))
 (let (($x226158 (= v_1_tx_time_15 0)))
 (let (($x273458 (= v_1_tx_time_14 0)))
 (let (($x101348 (= v_1_tx_time_13 0)))
 (let (($x23996 (= v_1_tx_time_12 0)))
 (let (($x67740 (= v_1_tx_time_11 0)))
 (let (($x176265 (= v_1_tx_time_10 0)))
 (let (($x756417 (= v_1_tx_time_09 0)))
 (let (($x202834 (= v_1_tx_time_08 0)))
 (let (($x4169 (= v_1_tx_time_07 0)))
 (let (($x841900 (= v_1_tx_time_06 0)))
 (let (($x23153 (= v_1_tx_time_05 0)))
 (let (($x318442 (= v_1_tx_time_04 0)))
 (let (($x67852 (= v_1_tx_time_03 0)))
 (let (($x162589 (= v_1_tx_time_02 0)))
 (let (($x407355 (= v_1_tx_time_01 0)))
 (let (($x211481 (= v_1_tx_time_00 0)))
 (let (($x14028 (= v_1_rto_base_ms 1000)))
 (let (($x648468 (= v_1_rtt_samples 0)))
 (let (($x243378 (= v_1_rtt_last_ms 0)))
 (let (($x636798 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x306917 (not v_1_rtt_sample_used)))
 (let (($x168727 (not v_1_rtt_start_new)))
 (let (($x601246 (= v_1_rtt_remaining 0)))
 (let (($x134411 (= v_1_rtt_end (_ bv0 32))))
 (let (($x789231 (= v_1_rtt_start_ms 0)))
 (let (($x483016 (= v_1_rtt_sample_at_ms 0)))
 (let (($x601475 (not v_1_rtt_ambiguous)))
 (let (($x368657 (not v_1_rtt_active)))
 (let (($x85976 (not v_1_rtt_previous_measured)))
 (let (($x80662 (not v_1_rtt_measured)))
 (let (($x88147 (= v_1_rtt_previous_var 0.0)))
 (let (($x602018 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x86910 (= v_1_rtt_error_ms 0.0)))
 (let (($x286487 (= v_1_rttvar_ms 0.0)))
 (let (($x346728 (= v_1_srtt_ms 0.0)))
 (let (($x90606 (not v_1_rx_fin_consumed)))
 (let (($x841011 (not v_1_rx_fin_done)))
 (let (($x829274 (= 0 v_1_rx_fin_offset)))
 (let (($x703558 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x95007 (not v_1_rx_fin_pending)))
 (let (($x819646 (not v_1_fin_acknowledged)))
 (let (($x293620 (= v_1_fin_seq (_ bv0 32))))
 (let (($x149068 (not v_1_fin_sent)))
 (let (($x631330 (not v_1_fin_requested)))
 (let (($x16885 (not v_1_ack_window_update)))
 (let (($x44481 (not v_1_ack_advance)))
 (let (($x604037 (not v_1_ack_is_future)))
 (let (($x359822 (not v_1_ack_is_new)))
 (let (($x220599 (= v_1_ack_delta 0)))
 (let (($x221506 (not v_1_seg_acceptable)))
 (let (($x494411 (not v_1_rx_acceptable)))
 (let (($x63724 (= v_1_rx_advance 0)))
 (let (($x746169 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x651384 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x49073 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x464972 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x333075 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x473937 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x305011 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x600940 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x307663 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x69838 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x210026 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x439049 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x868711 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x844231 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x494328 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x526917 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x93679 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x304813 (= v_1_take 0)))
 (let (($x41905 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x295313 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x125464 (= v_1_snd_wnd 8)))
 (let (($x305478 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x608680 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x293860 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x552183 (= 16 v_1_local_window)))
 (let (($x24593 (= v_1_msl_ms 60000)))
 (let (($x544119 (= v_1_user_timeout_ms 30000)))
 (let (($x513644 (not v_1_active_open)))
 (let (($x318931 (= v_1_retries 0)))
 (let (($x370508 (= v_1_rto_ms 1000)))
 (let (($x55229 (= v_1_tx_ack (_ bv0 32))))
 (let (($x133193 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x480465 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x300530 (= v_1_snd_nxt (_ bv1000 32))))
 (let (($x277446 (= v_1_snd_una (_ bv1000 32))))
 (let (($x213254 (= v_1_irs (_ bv0 32))))
 (let (($x652939 (= v_1_iss (_ bv1000 32))))
 (let (($x156303 (= 1 state_1)))
 (let (($x861741 (not active_0_delack)))
 (let (($x359267 (or $x861741 (not (<= due_0_delack 0)))))
 (let (($x158784 (not active_0_time_wait)))
 (let (($x396749 (or $x158784 (not (<= due_0_time_wait 0)))))
 (let (($x61400 (not active_0_user)))
 (let (($x81906 (or $x61400 (not (<= due_0_user 0)))))
 (let (($x248931 (not active_0_rtx)))
 (let (($x49807 (or $x248931 (not (<= due_0_rtx 0)))))
 (let (($x601606 (= state_0 0)))
 (and $x601606 (>= 0 now_0) $x49807 $x81906 $x396749 $x359267 $x156303 $x652939 $x213254 $x277446 $x300530 $x480465 $x133193 $x55229 (= v_1_tx_flags "S") $x370508 $x318931 $x513644 $x544119 $x24593 $x552183 $x293860 $x608680 $x305478 $x125464 $x295313 $x41905 $x304813 $x93679 $x526917 $x494328 $x844231 $x868711 $x439049 $x210026 $x69838 $x307663 $x600940 $x305011 $x473937 $x333075 $x464972 $x49073 $x651384 $x746169 $x63724 $x494411 $x221506 $x220599 $x359822 $x604037 $x44481 $x16885 $x631330 $x149068 $x293620 $x819646 $x95007 $x703558 $x829274 $x841011 $x90606 $x346728 $x286487 $x86910 $x602018 $x88147 $x80662 $x85976 $x368657 $x601475 $x483016 $x789231 $x134411 $x601246 $x168727 $x306917 $x636798 $x243378 $x648468 $x14028 $x211481 $x407355 $x162589 $x67852 $x318442 $x23153 $x841900 $x4169 $x202834 $x756417 $x176265 $x67740 $x23996 $x101348 $x273458 $x226158 $x600925 $x218544 $x163058 $x37166 $x90447 $x88369 $x141182 $x288757 $x326230 $x107602 $x635247 $x601667 $x183114 $x471212 $x301401 $x461601 $x164832 $x45328 $x196983 $x313293 $x309254 $x195710 $x766734 $x10517 $x87848 $x67371 $x91800 $x162560)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x109745 (= due_2_delack due_1_delack)))
 (let (($x637693 (= due_2_time_wait due_1_time_wait)))
 (let (($x630713 (= due_2_rtx 1050)))
 (let (($x220954 (not active_2_delack)))
 (let (($x133728 (= active_2_time_wait active_1_time_wait)))
 (let (($x71075 (not v_2_ack_defer_now)))
 (let (($x1305 (not v_2_ack_defer_candidate)))
 (let (($x103582 (= v_2_ack_rmss v_1_ack_rmss)))
 (let (($x208503 (= v_2_ack_delay_ms v_1_ack_delay_ms)))
 (let (($x304327 (= 0 v_2_ack_full_segments)))
 (let (($x825872 (= 0 v_2_ack_bytes)))
 (let (($x298596 (= 0 v_2_ack_since_ms)))
 (let (($x741407 (not v_2_ack_pending)))
 (let (($x160313 (= v_2_syn_timeout_eligible v_1_syn_timeout_eligible)))
 (let (($x393137 (= v_2_tx_syn_time 50)))
 (let (($x386043 (not v_2_tx_waiting)))
 (let (($x456449 (= v_2_tx_is_fin v_1_tx_is_fin)))
 (let (($x759027 (= v_2_tx_previous_rto v_1_tx_previous_rto)))
 (let (($x251849 (= v_2_tx_elapsed v_1_tx_elapsed)))
 (let (($x234678 (not v_2_tx_retransmitted)))
 (let (($x291318 (= v_2_tx_max_previous v_1_tx_max_previous)))
 (let (($x22970 (= v_2_tx_eligible v_1_tx_eligible)))
 (let (($x49445 (= v_2_tx_emit_count v_1_tx_emit_count)))
 (let ((?x29479 (ite (and v_1_fin_sent (not v_1_fin_acknowledged)) v_1_tx_fin_time 0)))
 (let (($x545846 (= v_2_tx_fin_time ?x29479)))
 (let (($x363070 (= v_2_tx_time_15 (ite (>= 15 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_15))))
 (let (($x59431 (= v_2_tx_time_14 (ite (>= 14 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_14))))
 (let (($x291298 (= v_2_tx_time_13 (ite (>= 13 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_13))))
 (let (($x185326 (= v_2_tx_time_12 (ite (>= 12 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_12))))
 (let (($x647764 (= v_2_tx_time_11 (ite (>= 11 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_11))))
 (let (($x600834 (= v_2_tx_time_10 (ite (>= 10 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_10))))
 (let (($x46013 (= v_2_tx_time_09 (ite (>= 9 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_09))))
 (let (($x229014 (= v_2_tx_time_08 (ite (>= 8 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_08))))
 (let (($x236529 (= v_2_tx_time_07 (ite (>= 7 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_07))))
 (let (($x491533 (= v_2_tx_time_06 (ite (>= 6 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_06))))
 (let (($x161186 (= v_2_tx_time_05 (ite (>= 5 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_05))))
 (let (($x750403 (= v_2_tx_time_04 (ite (>= 4 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_04))))
 (let (($x190101 (= v_2_tx_time_03 (ite (>= 3 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_03))))
 (let (($x371961 (= v_2_tx_time_02 (ite (>= 2 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_02))))
 (let (($x95083 (= v_2_tx_time_01 (ite (>= 1 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_01))))
 (let (($x294635 (= v_2_tx_time_00 (ite (>= 0 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_00))))
 (let (($x605142 (= v_2_rto_base_ms 1000)))
 (let (($x153931 (= v_2_rtt_samples 0)))
 (let (($x36750 (= v_2_rtt_last_ms 0)))
 (let (($x354554 (not v_2_rtt_sample_was_ambiguous)))
 (let (($x108435 (not v_2_rtt_sample_used)))
 (let (($x4025 (= v_2_rtt_remaining 1)))
 (let ((?x603443 (bvadd (_ bv1 32) v_1_iss)))
 (let (($x653694 (= v_2_rtt_end ?x603443)))
 (let (($x770428 (= v_2_rtt_start_ms 50)))
 (let (($x38544 (= v_2_rtt_sample_at_ms 0)))
 (let (($x57611 (not v_2_rtt_ambiguous)))
 (let (($x23628 (not v_2_rtt_previous_measured)))
 (let (($x766433 (not v_2_rtt_measured)))
 (let (($x234563 (= v_2_rtt_previous_var 0.0)))
 (let (($x218406 (= v_2_rtt_previous_srtt 0.0)))
 (let (($x38674 (= v_2_rtt_error_ms 0.0)))
 (let (($x646019 (= v_2_rttvar_ms 0.0)))
 (let (($x308790 (= v_2_srtt_ms 0.0)))
 (let (($x204606 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x51972 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x628575 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x378192 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x385130 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x606413 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x129697 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x151708 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x315943 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x814397 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x605426 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x8067 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x652838 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x81229 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x604853 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x551539 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x36174 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x60199 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x184606 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x601310 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x214459 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x74155 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x276464 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x74965 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x237588 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x311381 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x78429 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x600797 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x114250 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x297817 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x60831 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x637707 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x604162 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x398834 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x113591 (= v_2_take v_1_take)))
 (let (($x215860 (= v_2_snd_wl2 v_1_snd_wl2)))
 (let (($x141507 (= v_2_snd_wl1 v_1_snd_wl1)))
 (let (($x136324 (= v_2_snd_wnd v_1_snd_wnd)))
 (let (($x604680 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x547821 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x168786 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x33730 (= v_2_local_window v_1_local_window)))
 (let (($x868233 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x819241 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x152397 (= v_2_active_open v_1_active_open)))
 (let (($x481389 (= 0 v_2_retries)))
 (let (($x605100 (= 1000 v_2_rto_ms)))
 (let (($x825065 (= v_2_tx_flags "SA")))
 (let (($x17225 (= v_2_tx_ack (_ bv9001 32))))
 (let (($x48738 (= v_2_tx_seq v_1_iss)))
 (let (($x872965 (= v_2_rcv_nxt (_ bv9001 32))))
 (let (($x287093 (= v_2_snd_nxt ?x603443)))
 (let (($x218452 (= v_2_snd_una v_1_iss)))
 (let (($x261027 (= v_2_irs (_ bv9000 32))))
 (let (($x605233 (= v_2_iss v_1_iss)))
 (let (($x206724 (= 3 state_2)))
 (let (($x10517 (not active_1_delack)))
 (let (($x17544 (or $x10517 (not (<= due_1_delack 50)))))
 (let (($x766734 (not active_1_time_wait)))
 (let (($x303600 (or $x766734 (not (<= due_1_time_wait 50)))))
 (let (($x195710 (not active_1_user)))
 (let (($x517811 (or $x195710 (not (<= due_1_user 50)))))
 (let (($x309254 (not active_1_rtx)))
 (let (($x149835 (or $x309254 (not (<= due_1_rtx 50)))))
 (let (($x507265 (= state_1 1)))
 (and $x507265 $x149835 $x517811 $x303600 $x17544 $x206724 $x605233 $x261027 $x218452 $x287093 $x872965 $x48738 $x17225 $x825065 $x605100 $x481389 $x152397 $x819241 $x868233 $x33730 $x168786 $x547821 $x604680 $x136324 $x141507 $x215860 $x113591 $x398834 $x604162 $x637707 $x60831 $x297817 $x114250 $x600797 $x78429 $x311381 $x237588 $x74965 $x276464 $x74155 $x214459 $x601310 $x184606 $x60199 $x36174 $x551539 $x604853 $x81229 $x652838 $x8067 $x605426 $x814397 $x315943 $x151708 $x129697 $x606413 $x385130 $x378192 $x628575 $x51972 $x204606 $x308790 $x646019 $x38674 $x218406 $x234563 $x766433 $x23628 v_2_rtt_active $x57611 $x38544 $x770428 $x653694 $x4025 v_2_rtt_start_new $x108435 $x354554 $x36750 $x153931 $x605142 $x294635 $x95083 $x371961 $x190101 $x750403 $x161186 $x491533 $x236529 $x229014 $x46013 $x600834 $x647764 $x185326 $x291298 $x59431 $x363070 $x545846 $x49445 $x22970 $x291318 $x234678 $x251849 $x759027 $x456449 $x386043 $x393137 v_2_tx_syn_pending $x160313 $x741407 $x298596 $x825872 $x304327 $x208503 $x103582 $x1305 $x71075 active_2_rtx active_2_user $x133728 $x220954 $x630713 (= due_2_user (+ 50 v_1_user_timeout_ms)) $x637693 $x109745))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 (let (($x444018 (= due_3_delack due_2_delack)))
 (let (($x234499 (= due_3_time_wait due_2_time_wait)))
 (let (($x835839 (= due_3_user due_2_user)))
 (let ((?x294934 (ite (>= v_2_rto_ms 30000) 60000 (* 2 v_2_rto_ms))))
 (let ((?x5727 (+ v_2_tx_syn_time v_2_rto_ms)))
 (let (($x172374 (<= ?x5727 1050)))
 (let ((?x300014 (ite $x172374 ?x294934 v_2_rto_ms)))
 (let ((?x356352 (ite $x172374 1050 v_2_tx_syn_time)))
 (let (($x634023 (not active_3_delack)))
 (let (($x84100 (= active_3_time_wait active_2_time_wait)))
 (let (($x139199 (= active_3_user active_2_user)))
 (let (($x179253 (not v_3_ack_defer_now)))
 (let (($x447965 (not v_3_ack_defer_candidate)))
 (let (($x70138 (= v_3_ack_rmss v_2_ack_rmss)))
 (let (($x848349 (= v_3_ack_delay_ms v_2_ack_delay_ms)))
 (let (($x297971 (= 0 v_3_ack_full_segments)))
 (let (($x878218 (= 0 v_3_ack_bytes)))
 (let (($x94670 (= 0 v_3_ack_since_ms)))
 (let (($x634871 (not v_3_ack_pending)))
 (let (($x220291 (not v_3_tx_is_fin)))
 (let (($x874549 (= v_3_tx_previous_rto v_2_rto_ms)))
 (let (($x39762 (= v_3_tx_elapsed (ite $x172374 (+ 1050 (* (- 1) v_2_tx_syn_time)) 0))))
 (let (($x603711 (= v_3_tx_max_previous v_2_tx_syn_time)))
 (let (($x826557 (= v_3_tx_eligible v_2_tx_eligible)))
 (let ((?x98689 (ite (and v_2_fin_sent (not v_2_fin_acknowledged)) v_2_tx_fin_time 0)))
 (let (($x200810 (= v_3_tx_fin_time ?x98689)))
 (let (($x244761 (= v_3_tx_time_15 (ite (>= 15 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_15))))
 (let (($x98697 (= v_3_tx_time_14 (ite (>= 14 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_14))))
 (let (($x650580 (= v_3_tx_time_13 (ite (>= 13 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_13))))
 (let (($x19205 (= v_3_tx_time_12 (ite (>= 12 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_12))))
 (let (($x373872 (= v_3_tx_time_11 (ite (>= 11 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_11))))
 (let (($x314154 (= v_3_tx_time_10 (ite (>= 10 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_10))))
 (let (($x7543 (= v_3_tx_time_09 (ite (>= 9 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_09))))
 (let (($x44347 (= v_3_tx_time_08 (ite (>= 8 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_08))))
 (let (($x303928 (= v_3_tx_time_07 (ite (>= 7 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_07))))
 (let (($x116120 (= v_3_tx_time_06 (ite (>= 6 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_06))))
 (let (($x77492 (= v_3_tx_time_05 (ite (>= 5 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_05))))
 (let (($x635246 (= v_3_tx_time_04 (ite (>= 4 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_04))))
 (let (($x866900 (= v_3_tx_time_03 (ite (>= 3 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_03))))
 (let (($x92981 (= v_3_tx_time_02 (ite (>= 2 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_02))))
 (let (($x75738 (= v_3_tx_time_01 (ite (>= 1 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_01))))
 (let (($x614362 (= v_3_tx_time_00 (ite (>= 0 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_00))))
 (let (($x93689 (= v_3_rto_base_ms v_2_rto_base_ms)))
 (let (($x85269 (= v_3_rtt_samples v_2_rtt_samples)))
 (let (($x1096 (= v_3_rtt_last_ms v_2_rtt_last_ms)))
 (let (($x440686 (not v_3_rtt_sample_was_ambiguous)))
 (let (($x897 (not v_3_rtt_sample_used)))
 (let (($x214253 (not v_3_rtt_start_new)))
 (let (($x391649 (= v_3_rtt_remaining v_2_rtt_remaining)))
 (let (($x604754 (= v_3_rtt_end v_2_rtt_end)))
 (let (($x55888 (= v_3_rtt_start_ms v_2_rtt_start_ms)))
 (let (($x305073 (= v_3_rtt_sample_at_ms v_2_rtt_sample_at_ms)))
 (let ((?x331405 (* (- 1) v_2_rtt_remaining)))
 (let (($x314240 (<= (+ (ubv_to_int (bvadd v_2_rtt_end (bvmul (_ bv4294967295 32) v_2_snd_una))) ?x331405) 0)))
 (let (($x286989 (ite $x172374 (or v_2_rtt_ambiguous (and v_2_rtt_active $x314240)) v_2_rtt_ambiguous)))
 (let (($x373329 (= v_3_rtt_active v_2_rtt_active)))
 (let (($x406587 (= v_3_rtt_previous_measured v_2_rtt_previous_measured)))
 (let (($x82738 (= v_3_rtt_measured v_2_rtt_measured)))
 (let (($x90099 (= v_3_rtt_previous_var v_2_rtt_previous_var)))
 (let (($x36685 (= v_3_rtt_previous_srtt v_2_rtt_previous_srtt)))
 (let (($x391355 (= v_3_rtt_error_ms v_2_rtt_error_ms)))
 (let (($x327922 (= v_3_rttvar_ms v_2_rttvar_ms)))
 (let (($x603039 (= v_3_srtt_ms v_2_srtt_ms)))
 (let (($x54464 (= v_3_rx_fin_consumed v_2_rx_fin_consumed)))
 (let (($x282213 (= v_3_rx_fin_done v_2_rx_fin_done)))
 (let (($x144897 (= v_3_rx_fin_offset v_2_rx_fin_offset)))
 (let (($x814719 (= v_3_rx_fin_seq v_2_rx_fin_seq)))
 (let (($x684046 (= v_3_rx_fin_pending v_2_rx_fin_pending)))
 (let (($x409073 (= v_3_fin_acknowledged v_2_fin_acknowledged)))
 (let (($x299387 (= v_3_fin_seq v_2_fin_seq)))
 (let (($x682620 (= v_3_fin_sent v_2_fin_sent)))
 (let (($x217059 (= v_3_fin_requested v_2_fin_requested)))
 (let (($x3882 (= v_3_ack_window_update v_2_ack_window_update)))
 (let (($x68598 (= v_3_ack_advance v_2_ack_advance)))
 (let (($x303829 (= v_3_ack_is_future v_2_ack_is_future)))
 (let (($x94318 (= v_3_ack_is_new v_2_ack_is_new)))
 (let (($x69018 (= v_3_ack_delta v_2_ack_delta)))
 (let (($x490526 (= v_3_seg_acceptable v_2_seg_acceptable)))
 (let (($x881772 (= v_3_rx_acceptable v_2_rx_acceptable)))
 (let (($x878117 (= v_3_rx_advance v_2_rx_advance)))
 (let (($x72549 (= v_3_rx_slot_15 v_2_rx_slot_15)))
 (let (($x295747 (= v_3_rx_slot_14 v_2_rx_slot_14)))
 (let (($x395176 (= v_3_rx_slot_13 v_2_rx_slot_13)))
 (let (($x319786 (= v_3_rx_slot_12 v_2_rx_slot_12)))
 (let (($x438347 (= v_3_rx_slot_11 v_2_rx_slot_11)))
 (let (($x239895 (= v_3_rx_slot_10 v_2_rx_slot_10)))
 (let (($x33190 (= v_3_rx_slot_09 v_2_rx_slot_09)))
 (let (($x9154 (= v_3_rx_slot_08 v_2_rx_slot_08)))
 (let (($x302780 (= v_3_rx_slot_07 v_2_rx_slot_07)))
 (let (($x344929 (= v_3_rx_slot_06 v_2_rx_slot_06)))
 (let (($x545195 (= v_3_rx_slot_05 v_2_rx_slot_05)))
 (let (($x604872 (= v_3_rx_slot_04 v_2_rx_slot_04)))
 (let (($x269838 (= v_3_rx_slot_03 v_2_rx_slot_03)))
 (let (($x390906 (= v_3_rx_slot_02 v_2_rx_slot_02)))
 (let (($x604003 (= v_3_rx_slot_01 v_2_rx_slot_01)))
 (let (($x201330 (= v_3_rx_slot_00 v_2_rx_slot_00)))
 (let (($x90413 (= v_3_rx_chunk v_2_rx_chunk)))
 (let (($x261336 (= v_3_take v_2_take)))
 (let (($x312120 (= v_3_snd_wl2 v_2_snd_wl2)))
 (let (($x259664 (= v_3_snd_wl1 v_2_snd_wl1)))
 (let (($x463915 (= v_3_snd_wnd v_2_snd_wnd)))
 (let (($x168998 (= v_3_rcv_buf v_2_rcv_buf)))
 (let (($x174401 (= v_3_rtx_buf v_2_rtx_buf)))
 (let (($x617393 (= v_3_snd_buf v_2_snd_buf)))
 (let (($x58958 (= v_3_local_window v_2_local_window)))
 (let (($x276760 (= v_3_msl_ms v_2_msl_ms)))
 (let (($x4201 (= v_3_user_timeout_ms v_2_user_timeout_ms)))
 (let (($x211476 (= v_3_active_open v_2_active_open)))
 (let (($x226114 (= v_3_tx_flags v_2_tx_flags)))
 (let (($x444 (= v_3_tx_ack v_2_tx_ack)))
 (let (($x262740 (= v_3_tx_seq v_2_tx_seq)))
 (let (($x180524 (= v_3_rcv_nxt v_2_rcv_nxt)))
 (let (($x94357 (= v_3_snd_nxt v_2_snd_nxt)))
 (let (($x777075 (= v_3_snd_una v_2_snd_una)))
 (let (($x188328 (= v_3_irs v_2_irs)))
 (let (($x139078 (= v_3_iss v_2_iss)))
 (let (($x294717 (= 3 state_3)))
 (let (($x372178 (= state_2 3)))
 (and $x372178 active_2_rtx (= 1050 due_2_rtx) (or (not active_2_user) (<= due_2_rtx due_2_user)) (or (not active_2_time_wait) (<= due_2_rtx due_2_time_wait)) (or (not active_2_delack) (not (<= due_2_delack due_2_rtx))) $x294717 $x139078 $x188328 $x777075 $x94357 $x180524 $x262740 $x444 $x226114 (= v_3_rto_ms ?x300014) (= v_3_retries (ite $x172374 (+ 1 v_2_retries) v_2_retries)) $x211476 $x4201 $x276760 $x58958 $x617393 $x174401 $x168998 $x463915 $x259664 $x312120 $x261336 $x90413 $x201330 $x604003 $x390906 $x269838 $x604872 $x545195 $x344929 $x302780 $x9154 $x33190 $x239895 $x438347 $x319786 $x395176 $x295747 $x72549 $x878117 $x881772 $x490526 $x69018 $x94318 $x303829 $x68598 $x3882 $x217059 $x682620 $x299387 $x409073 $x684046 $x814719 $x144897 $x282213 $x54464 $x603039 $x327922 $x391355 $x36685 $x90099 $x82738 $x406587 $x373329 (= v_3_rtt_ambiguous $x286989) $x305073 $x55888 $x604754 $x391649 $x214253 $x897 $x440686 $x1096 $x85269 $x93689 $x614362 $x75738 $x92981 $x866900 $x635246 $x77492 $x116120 $x303928 $x44347 $x7543 $x314154 $x373872 $x19205 $x650580 $x98697 $x244761 $x200810 (= v_3_tx_emit_count (ite $x172374 1 0)) $x826557 $x603711 (= v_3_tx_retransmitted $x172374) $x39762 $x874549 $x220291 (not (= $x172374 v_3_tx_waiting)) (= v_3_tx_syn_time ?x356352) v_3_tx_syn_pending (= v_3_syn_timeout_eligible $x172374) $x634871 $x94670 $x878218 $x297971 $x848349 $x70138 $x447965 $x179253 active_3_rtx $x139199 $x84100 $x634023 (= due_3_rtx (+ 1050 (ite $x172374 ?x294934 (+ (- 1050) ?x356352 ?x300014)))) $x835839 $x234499 $x444018))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
