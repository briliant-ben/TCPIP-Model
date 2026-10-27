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
 (let (($x100539 (= due_1_delack due_0_delack)))
 (let (($x147855 (= due_1_time_wait due_0_time_wait)))
 (let (($x147976 (= due_1_user 30000)))
 (let (($x293151 (= due_1_rtx 1000)))
 (let (($x147255 (not active_1_delack)))
 (let (($x635565 (not active_1_time_wait)))
 (let (($x69385 (not v_1_ack_defer_now)))
 (let (($x642398 (not v_1_ack_defer_candidate)))
 (let (($x298315 (= v_1_ack_rmss 4)))
 (let (($x152271 (= v_1_ack_delay_ms 40)))
 (let (($x186567 (= 0 v_1_ack_full_segments)))
 (let (($x158139 (= 0 v_1_ack_bytes)))
 (let (($x248931 (= 0 v_1_ack_since_ms)))
 (let (($x756870 (not v_1_ack_pending)))
 (let (($x288960 (not v_1_syn_timeout_eligible)))
 (let (($x298035 (= v_1_tx_syn_time 0)))
 (let (($x341065 (not v_1_tx_waiting)))
 (let (($x37361 (not v_1_tx_is_fin)))
 (let (($x259856 (= v_1_tx_previous_rto 1000)))
 (let (($x210901 (= v_1_tx_elapsed 0)))
 (let (($x628739 (not v_1_tx_retransmitted)))
 (let (($x272509 (= v_1_tx_max_previous 0)))
 (let (($x59957 (= v_1_tx_eligible 0)))
 (let (($x155681 (= v_1_tx_emit_count 0)))
 (let (($x317023 (= v_1_tx_fin_time 0)))
 (let (($x602685 (= v_1_tx_time_15 0)))
 (let (($x530865 (= v_1_tx_time_14 0)))
 (let (($x83433 (= v_1_tx_time_13 0)))
 (let (($x459833 (= v_1_tx_time_12 0)))
 (let (($x140218 (= v_1_tx_time_11 0)))
 (let (($x86566 (= v_1_tx_time_10 0)))
 (let (($x104733 (= v_1_tx_time_09 0)))
 (let (($x234983 (= v_1_tx_time_08 0)))
 (let (($x289734 (= v_1_tx_time_07 0)))
 (let (($x311096 (= v_1_tx_time_06 0)))
 (let (($x871099 (= v_1_tx_time_05 0)))
 (let (($x23509 (= v_1_tx_time_04 0)))
 (let (($x304653 (= v_1_tx_time_03 0)))
 (let (($x641013 (= v_1_tx_time_02 0)))
 (let (($x129219 (= v_1_tx_time_01 0)))
 (let (($x214547 (= v_1_tx_time_00 0)))
 (let (($x290512 (= v_1_rto_base_ms 1000)))
 (let (($x606097 (= v_1_rtt_samples 0)))
 (let (($x343004 (= v_1_rtt_last_ms 0)))
 (let (($x252100 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x221843 (not v_1_rtt_sample_used)))
 (let (($x384280 (= v_1_rtt_remaining 1)))
 (let (($x302894 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x262685 (= v_1_rtt_start_ms 0)))
 (let (($x244323 (= v_1_rtt_sample_at_ms 0)))
 (let (($x203727 (not v_1_rtt_ambiguous)))
 (let (($x495254 (not v_1_rtt_previous_measured)))
 (let (($x211598 (not v_1_rtt_measured)))
 (let (($x65777 (= v_1_rtt_previous_var 0.0)))
 (let (($x389561 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x300444 (= v_1_rtt_error_ms 0.0)))
 (let (($x119479 (= v_1_rttvar_ms 0.0)))
 (let (($x160594 (= v_1_srtt_ms 0.0)))
 (let (($x230739 (not v_1_rx_fin_consumed)))
 (let (($x2711 (not v_1_rx_fin_done)))
 (let (($x83042 (= v_1_rx_fin_offset 0)))
 (let (($x309223 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x178377 (not v_1_rx_fin_pending)))
 (let (($x601515 (not v_1_fin_acknowledged)))
 (let (($x152358 (= v_1_fin_seq (_ bv0 32))))
 (let (($x180147 (not v_1_fin_sent)))
 (let (($x110217 (not v_1_fin_requested)))
 (let (($x310598 (not v_1_ack_window_update)))
 (let (($x163559 (not v_1_ack_advance)))
 (let (($x118481 (not v_1_ack_is_future)))
 (let (($x117293 (not v_1_ack_is_new)))
 (let (($x246600 (= v_1_ack_delta 0)))
 (let (($x96483 (not v_1_seg_acceptable)))
 (let (($x307424 (not v_1_rx_acceptable)))
 (let (($x95459 (= v_1_rx_advance 0)))
 (let (($x391809 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x205228 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x225402 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x552573 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x9220 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x95626 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x131092 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x883315 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x852973 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x243141 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x187815 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x603646 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x235339 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x73721 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x646775 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x665815 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x63240 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x318563 (= v_1_take 0)))
 (let (($x556244 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x311981 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x169645 (= v_1_snd_wnd 8)))
 (let (($x269718 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x873767 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x358676 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x62025 (= v_1_local_window 16)))
 (let (($x69748 (= v_1_msl_ms 60000)))
 (let (($x645982 (= v_1_user_timeout_ms 30000)))
 (let (($x378192 (= 0 v_1_retries)))
 (let (($x101219 (= 1000 v_1_rto_ms)))
 (let (($x385130 (= v_1_tx_flags "S")))
 (let (($x637174 (= v_1_tx_ack (_ bv0 32))))
 (let (($x162789 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x553714 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x333694 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x227860 (= v_1_snd_una (_ bv1000 32))))
 (let (($x248564 (= v_1_irs (_ bv0 32))))
 (let (($x29399 (= v_1_iss (_ bv1000 32))))
 (let (($x315943 (= 2 state_1)))
 (let (($x637707 (not active_0_delack)))
 (let (($x649071 (or $x637707 (not (<= due_0_delack 0)))))
 (let (($x604162 (not active_0_time_wait)))
 (let (($x604843 (or $x604162 (not (<= due_0_time_wait 0)))))
 (let (($x398834 (not active_0_user)))
 (let (($x148217 (or $x398834 (not (<= due_0_user 0)))))
 (let (($x113591 (not active_0_rtx)))
 (let (($x314993 (or $x113591 (not (<= due_0_rtx 0)))))
 (let (($x480467 (= state_0 0)))
 (and $x480467 (>= 0 now_0) $x314993 $x148217 $x604843 $x649071 $x315943 $x29399 $x248564 $x227860 $x333694 $x553714 $x162789 $x637174 $x385130 $x101219 $x378192 v_1_active_open $x645982 $x69748 $x62025 $x358676 $x873767 $x269718 $x169645 $x311981 $x556244 $x318563 $x63240 $x665815 $x646775 $x73721 $x235339 $x603646 $x187815 $x243141 $x852973 $x883315 $x131092 $x95626 $x9220 $x552573 $x225402 $x205228 $x391809 $x95459 $x307424 $x96483 $x246600 $x117293 $x118481 $x163559 $x310598 $x110217 $x180147 $x152358 $x601515 $x178377 $x309223 $x83042 $x2711 $x230739 $x160594 $x119479 $x300444 $x389561 $x65777 $x211598 $x495254 v_1_rtt_active $x203727 $x244323 $x262685 $x302894 $x384280 v_1_rtt_start_new $x221843 $x252100 $x343004 $x606097 $x290512 $x214547 $x129219 $x641013 $x304653 $x23509 $x871099 $x311096 $x289734 $x234983 $x104733 $x86566 $x140218 $x459833 $x83433 $x530865 $x602685 $x317023 $x155681 $x59957 $x272509 $x628739 $x210901 $x259856 $x37361 $x341065 $x298035 v_1_tx_syn_pending $x288960 $x756870 $x248931 $x158139 $x186567 $x152271 $x298315 $x642398 $x69385 active_1_rtx active_1_user $x635565 $x147255 $x293151 $x147976 $x147855 $x100539))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x610080 (= due_2_delack due_1_delack)))
 (let (($x61429 (= due_2_time_wait due_1_time_wait)))
 (let (($x292492 (= due_2_user due_1_user)))
 (let (($x135741 (not active_2_delack)))
 (let (($x307624 (= active_2_time_wait active_1_time_wait)))
 (let (($x603484 (= active_2_user active_1_user)))
 (let (($x292220 (not v_2_ack_defer_now)))
 (let (($x156519 (not v_2_ack_defer_candidate)))
 (let (($x265869 (= v_2_ack_rmss v_1_ack_rmss)))
 (let (($x29570 (= v_2_ack_delay_ms v_1_ack_delay_ms)))
 (let (($x470905 (= 0 v_2_ack_full_segments)))
 (let (($x285672 (= 0 v_2_ack_bytes)))
 (let (($x6953 (= 0 v_2_ack_since_ms)))
 (let (($x285199 (not v_2_ack_pending)))
 (let (($x883166 (= v_2_syn_timeout_eligible v_1_syn_timeout_eligible)))
 (let (($x847317 (= v_2_tx_syn_time 900)))
 (let (($x649341 (not v_2_tx_waiting)))
 (let (($x122856 (= v_2_tx_is_fin v_1_tx_is_fin)))
 (let (($x848374 (= v_2_tx_previous_rto v_1_tx_previous_rto)))
 (let (($x66542 (= v_2_tx_elapsed v_1_tx_elapsed)))
 (let (($x564348 (not v_2_tx_retransmitted)))
 (let (($x653913 (= v_2_tx_max_previous v_1_tx_max_previous)))
 (let (($x279671 (= v_2_tx_eligible v_1_tx_eligible)))
 (let (($x181875 (= v_2_tx_emit_count v_1_tx_emit_count)))
 (let ((?x112800 (ite (and v_1_fin_sent (not v_1_fin_acknowledged)) v_1_tx_fin_time 0)))
 (let (($x501353 (= v_2_tx_fin_time ?x112800)))
 (let (($x88648 (= v_2_tx_time_15 (ite (>= 15 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_15))))
 (let (($x206903 (= v_2_tx_time_14 (ite (>= 14 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_14))))
 (let (($x240263 (= v_2_tx_time_13 (ite (>= 13 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_13))))
 (let (($x75030 (= v_2_tx_time_12 (ite (>= 12 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_12))))
 (let (($x760076 (= v_2_tx_time_11 (ite (>= 11 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_11))))
 (let (($x221221 (= v_2_tx_time_10 (ite (>= 10 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_10))))
 (let (($x698763 (= v_2_tx_time_09 (ite (>= 9 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_09))))
 (let (($x601804 (= v_2_tx_time_08 (ite (>= 8 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_08))))
 (let (($x37210 (= v_2_tx_time_07 (ite (>= 7 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_07))))
 (let (($x290565 (= v_2_tx_time_06 (ite (>= 6 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_06))))
 (let (($x234422 (= v_2_tx_time_05 (ite (>= 5 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_05))))
 (let (($x601154 (= v_2_tx_time_04 (ite (>= 4 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_04))))
 (let (($x168633 (= v_2_tx_time_03 (ite (>= 3 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_03))))
 (let (($x256364 (= v_2_tx_time_02 (ite (>= 2 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_02))))
 (let (($x308564 (= v_2_tx_time_01 (ite (>= 1 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_01))))
 (let (($x640208 (= v_2_tx_time_00 (ite (>= 0 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_00))))
 (let (($x315904 (= v_2_rto_base_ms v_1_rto_base_ms)))
 (let (($x312887 (= v_2_rtt_samples v_1_rtt_samples)))
 (let (($x863986 (= v_2_rtt_last_ms v_1_rtt_last_ms)))
 (let (($x175113 (not v_2_rtt_sample_was_ambiguous)))
 (let (($x29448 (not v_2_rtt_sample_used)))
 (let (($x68615 (not v_2_rtt_start_new)))
 (let (($x17515 (= v_2_rtt_remaining v_1_rtt_remaining)))
 (let (($x31697 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x64749 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let (($x52650 (= v_2_rtt_sample_at_ms v_1_rtt_sample_at_ms)))
 (let ((?x2163 (+ (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una))) (* (- 1) v_1_rtt_remaining))))
 (let (($x222212 (= v_2_rtt_ambiguous (or v_1_rtt_ambiguous (and v_1_rtt_active (<= ?x2163 0))))))
 (let (($x350083 (= v_2_rtt_active v_1_rtt_active)))
 (let (($x603050 (= v_2_rtt_previous_measured v_1_rtt_previous_measured)))
 (let (($x455229 (= v_2_rtt_measured v_1_rtt_measured)))
 (let (($x885533 (= v_2_rtt_previous_var v_1_rtt_previous_var)))
 (let (($x135533 (= v_2_rtt_previous_srtt v_1_rtt_previous_srtt)))
 (let (($x221579 (= v_2_rtt_error_ms v_1_rtt_error_ms)))
 (let (($x635752 (= v_2_rttvar_ms v_1_rttvar_ms)))
 (let (($x272615 (= v_2_srtt_ms v_1_srtt_ms)))
 (let (($x33581 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x873171 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x299928 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x4736 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x499177 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x186632 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x708834 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x636888 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x817553 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x166367 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x645503 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x45475 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x870760 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x236724 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x760026 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x56948 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x12666 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x510288 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x401343 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x219431 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x262125 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x601343 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x601724 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x300213 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x300697 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x646851 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x143886 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x157774 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x100626 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x646670 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x48527 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x356864 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x154067 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x43123 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x155308 (= v_2_take v_1_take)))
 (let (($x9150 (= v_2_snd_wl2 v_1_snd_wl2)))
 (let (($x602435 (= v_2_snd_wl1 v_1_snd_wl1)))
 (let (($x236842 (= v_2_snd_wnd v_1_snd_wnd)))
 (let (($x392453 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x193468 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x528969 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x370278 (= v_2_local_window v_1_local_window)))
 (let (($x747548 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x790557 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x77161 (= v_2_active_open v_1_active_open)))
 (let (($x640682 (= v_2_retries v_1_retries)))
 (let (($x94543 (= v_2_rto_ms v_1_rto_ms)))
 (let (($x603556 (= v_2_tx_flags "SA")))
 (let (($x871936 (= v_2_tx_ack (_ bv9001 32))))
 (let (($x134163 (= v_2_tx_seq v_1_iss)))
 (let (($x602691 (= v_2_rcv_nxt (_ bv9001 32))))
 (let (($x604602 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x95696 (= v_2_snd_una v_1_snd_una)))
 (let (($x89633 (= v_2_irs (_ bv9000 32))))
 (let (($x610240 (= v_2_iss v_1_iss)))
 (let (($x25591 (= 3 state_2)))
 (let (($x147255 (not active_1_delack)))
 (let (($x459628 (or $x147255 (not (<= due_1_delack 900)))))
 (let (($x635565 (not active_1_time_wait)))
 (let (($x484300 (or $x635565 (not (<= due_1_time_wait 900)))))
 (let (($x191639 (or (not active_1_user) (not (<= due_1_user 900)))))
 (let (($x250778 (or (not active_1_rtx) (not (<= due_1_rtx 900)))))
 (let (($x66411 (= state_1 2)))
 (and $x66411 $x250778 $x191639 $x484300 $x459628 $x25591 $x610240 $x89633 $x95696 $x604602 $x602691 $x134163 $x871936 $x603556 $x94543 $x640682 $x77161 $x790557 $x747548 $x370278 $x528969 $x193468 $x392453 $x236842 $x602435 $x9150 $x155308 $x43123 $x154067 $x356864 $x48527 $x646670 $x100626 $x157774 $x143886 $x646851 $x300697 $x300213 $x601724 $x601343 $x262125 $x219431 $x401343 $x510288 $x12666 $x56948 $x760026 $x236724 $x870760 $x45475 $x645503 $x166367 $x817553 $x636888 $x708834 $x186632 $x499177 $x4736 $x299928 $x873171 $x33581 $x272615 $x635752 $x221579 $x135533 $x885533 $x455229 $x603050 $x350083 $x222212 $x52650 $x64749 $x31697 $x17515 $x68615 $x29448 $x175113 $x863986 $x312887 $x315904 $x640208 $x308564 $x256364 $x168633 $x601154 $x234422 $x290565 $x37210 $x601804 $x698763 $x221221 $x760076 $x75030 $x240263 $x206903 $x88648 $x501353 $x181875 $x279671 $x653913 $x564348 $x66542 $x848374 $x122856 $x649341 $x847317 v_2_tx_syn_pending $x883166 $x285199 $x6953 $x285672 $x470905 $x29570 $x265869 $x156519 $x292220 active_2_rtx $x603484 $x307624 $x135741 (= due_2_rtx (+ 900 v_1_rto_ms)) $x292492 $x61429 $x610080)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 (let (($x14520 (= due_3_delack due_2_delack)))
 (let (($x642472 (= due_3_time_wait due_2_time_wait)))
 (let (($x8038 (= due_3_user due_2_user)))
 (let ((?x542145 (ite (>= v_2_rto_ms 30000) 60000 (* 2 v_2_rto_ms))))
 (let ((?x319024 (+ v_2_tx_syn_time v_2_rto_ms)))
 (let (($x868201 (<= ?x319024 1900)))
 (let ((?x390450 (ite $x868201 ?x542145 v_2_rto_ms)))
 (let ((?x75461 (ite $x868201 1900 v_2_tx_syn_time)))
 (let ((?x498987 (ite $x868201 ?x542145 (+ (- 1900) ?x75461 ?x390450))))
 (let (($x153043 (not active_3_delack)))
 (let (($x314899 (= active_3_time_wait active_2_time_wait)))
 (let (($x51350 (= active_3_user active_2_user)))
 (let (($x471917 (not v_3_ack_defer_now)))
 (let (($x2497 (not v_3_ack_defer_candidate)))
 (let (($x601826 (= v_3_ack_rmss v_2_ack_rmss)))
 (let (($x196867 (= v_3_ack_delay_ms v_2_ack_delay_ms)))
 (let (($x307234 (= 0 v_3_ack_full_segments)))
 (let (($x604768 (= 0 v_3_ack_bytes)))
 (let (($x534582 (= 0 v_3_ack_since_ms)))
 (let (($x423990 (not v_3_ack_pending)))
 (let (($x59962 (= v_3_syn_timeout_eligible $x868201)))
 (let (($x682510 (= v_3_tx_syn_time ?x75461)))
 (let (($x472046 (not (= $x868201 v_3_tx_waiting))))
 (let (($x376622 (not v_3_tx_is_fin)))
 (let (($x14204 (= v_3_tx_previous_rto v_2_rto_ms)))
 (let (($x418258 (= v_3_tx_elapsed (ite $x868201 (+ 1900 (* (- 1) v_2_tx_syn_time)) 0))))
 (let (($x33203 (= v_3_tx_retransmitted $x868201)))
 (let (($x238588 (= v_3_tx_max_previous v_2_tx_syn_time)))
 (let (($x605207 (= v_3_tx_eligible v_2_tx_eligible)))
 (let (($x16646 (= v_3_tx_emit_count (ite $x868201 1 0))))
 (let ((?x626737 (ite (and v_2_fin_sent (not v_2_fin_acknowledged)) v_2_tx_fin_time 0)))
 (let (($x605029 (= v_3_tx_fin_time ?x626737)))
 (let (($x246221 (= v_3_tx_time_15 (ite (>= 15 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_15))))
 (let (($x157775 (= v_3_tx_time_14 (ite (>= 14 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_14))))
 (let (($x25305 (= v_3_tx_time_13 (ite (>= 13 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_13))))
 (let (($x8091 (= v_3_tx_time_12 (ite (>= 12 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_12))))
 (let (($x55436 (= v_3_tx_time_11 (ite (>= 11 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_11))))
 (let (($x314880 (= v_3_tx_time_10 (ite (>= 10 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_10))))
 (let (($x81472 (= v_3_tx_time_09 (ite (>= 9 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_09))))
 (let (($x69740 (= v_3_tx_time_08 (ite (>= 8 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_08))))
 (let (($x244798 (= v_3_tx_time_07 (ite (>= 7 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_07))))
 (let (($x873251 (= v_3_tx_time_06 (ite (>= 6 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_06))))
 (let (($x741909 (= v_3_tx_time_05 (ite (>= 5 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_05))))
 (let (($x256222 (= v_3_tx_time_04 (ite (>= 4 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_04))))
 (let (($x207745 (= v_3_tx_time_03 (ite (>= 3 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_03))))
 (let (($x69065 (= v_3_tx_time_02 (ite (>= 2 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_02))))
 (let (($x198641 (= v_3_tx_time_01 (ite (>= 1 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_01))))
 (let (($x291834 (= v_3_tx_time_00 (ite (>= 0 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_00))))
 (let (($x82781 (= v_3_rto_base_ms v_2_rto_base_ms)))
 (let (($x266136 (= v_3_rtt_samples v_2_rtt_samples)))
 (let (($x320907 (= v_3_rtt_last_ms v_2_rtt_last_ms)))
 (let (($x868325 (not v_3_rtt_sample_was_ambiguous)))
 (let (($x68467 (not v_3_rtt_sample_used)))
 (let (($x372349 (not v_3_rtt_start_new)))
 (let (($x728822 (= v_3_rtt_remaining v_2_rtt_remaining)))
 (let (($x653347 (= v_3_rtt_end v_2_rtt_end)))
 (let (($x50713 (= v_3_rtt_start_ms v_2_rtt_start_ms)))
 (let (($x870957 (= v_3_rtt_sample_at_ms v_2_rtt_sample_at_ms)))
 (let ((?x306870 (+ (ubv_to_int (bvadd v_2_rtt_end (bvmul (_ bv4294967295 32) v_2_snd_una))) (* (- 1) v_2_rtt_remaining))))
 (let (($x216513 (ite $x868201 (or v_2_rtt_ambiguous (and v_2_rtt_active (<= ?x306870 0))) v_2_rtt_ambiguous)))
 (let (($x177557 (= v_3_rtt_ambiguous $x216513)))
 (let (($x719389 (= v_3_rtt_active v_2_rtt_active)))
 (let (($x313072 (= v_3_rtt_previous_measured v_2_rtt_previous_measured)))
 (let (($x483996 (= v_3_rtt_measured v_2_rtt_measured)))
 (let (($x208292 (= v_3_rtt_previous_var v_2_rtt_previous_var)))
 (let (($x2646 (= v_3_rtt_previous_srtt v_2_rtt_previous_srtt)))
 (let (($x139440 (= v_3_rtt_error_ms v_2_rtt_error_ms)))
 (let (($x448903 (= v_3_rttvar_ms v_2_rttvar_ms)))
 (let (($x160666 (= v_3_srtt_ms v_2_srtt_ms)))
 (let (($x401342 (= v_3_rx_fin_consumed v_2_rx_fin_consumed)))
 (let (($x559793 (= v_3_rx_fin_done v_2_rx_fin_done)))
 (let (($x170689 (= v_3_rx_fin_offset v_2_rx_fin_offset)))
 (let (($x282016 (= v_3_rx_fin_seq v_2_rx_fin_seq)))
 (let (($x253487 (= v_3_rx_fin_pending v_2_rx_fin_pending)))
 (let (($x41989 (= v_3_fin_acknowledged v_2_fin_acknowledged)))
 (let (($x367863 (= v_3_fin_seq v_2_fin_seq)))
 (let (($x653505 (= v_3_fin_sent v_2_fin_sent)))
 (let (($x64042 (= v_3_fin_requested v_2_fin_requested)))
 (let (($x681351 (= v_3_ack_window_update v_2_ack_window_update)))
 (let (($x642393 (= v_3_ack_advance v_2_ack_advance)))
 (let (($x239716 (= v_3_ack_is_future v_2_ack_is_future)))
 (let (($x5062 (= v_3_ack_is_new v_2_ack_is_new)))
 (let (($x401098 (= v_3_ack_delta v_2_ack_delta)))
 (let (($x317593 (= v_3_seg_acceptable v_2_seg_acceptable)))
 (let (($x370071 (= v_3_rx_acceptable v_2_rx_acceptable)))
 (let (($x325504 (= v_3_rx_advance v_2_rx_advance)))
 (let (($x42861 (= v_3_rx_slot_15 v_2_rx_slot_15)))
 (let (($x213666 (= v_3_rx_slot_14 v_2_rx_slot_14)))
 (let (($x127145 (= v_3_rx_slot_13 v_2_rx_slot_13)))
 (let (($x221070 (= v_3_rx_slot_12 v_2_rx_slot_12)))
 (let (($x306828 (= v_3_rx_slot_11 v_2_rx_slot_11)))
 (let (($x252363 (= v_3_rx_slot_10 v_2_rx_slot_10)))
 (let (($x129520 (= v_3_rx_slot_09 v_2_rx_slot_09)))
 (let (($x288861 (= v_3_rx_slot_08 v_2_rx_slot_08)))
 (let (($x142306 (= v_3_rx_slot_07 v_2_rx_slot_07)))
 (let (($x164978 (= v_3_rx_slot_06 v_2_rx_slot_06)))
 (let (($x545619 (= v_3_rx_slot_05 v_2_rx_slot_05)))
 (let (($x140549 (= v_3_rx_slot_04 v_2_rx_slot_04)))
 (let (($x207678 (= v_3_rx_slot_03 v_2_rx_slot_03)))
 (let (($x188771 (= v_3_rx_slot_02 v_2_rx_slot_02)))
 (let (($x635869 (= v_3_rx_slot_01 v_2_rx_slot_01)))
 (let (($x212155 (= v_3_rx_slot_00 v_2_rx_slot_00)))
 (let (($x105716 (= v_3_rx_chunk v_2_rx_chunk)))
 (let (($x286374 (= v_3_take v_2_take)))
 (let (($x637258 (= v_3_snd_wl2 v_2_snd_wl2)))
 (let (($x307983 (= v_3_snd_wl1 v_2_snd_wl1)))
 (let (($x57985 (= v_3_snd_wnd v_2_snd_wnd)))
 (let (($x300942 (= v_3_rcv_buf v_2_rcv_buf)))
 (let (($x302334 (= v_3_rtx_buf v_2_rtx_buf)))
 (let (($x56804 (= v_3_snd_buf v_2_snd_buf)))
 (let (($x125370 (= v_3_local_window v_2_local_window)))
 (let (($x443310 (= v_3_msl_ms v_2_msl_ms)))
 (let (($x499792 (= v_3_user_timeout_ms v_2_user_timeout_ms)))
 (let (($x292025 (= v_3_active_open v_2_active_open)))
 (let (($x93724 (= v_3_retries (ite $x868201 (+ 1 v_2_retries) v_2_retries))))
 (let (($x13705 (= v_3_rto_ms ?x390450)))
 (let (($x300627 (= v_3_tx_flags v_2_tx_flags)))
 (let (($x149549 (= v_3_tx_ack v_2_tx_ack)))
 (let (($x733258 (= v_3_tx_seq v_2_tx_seq)))
 (let (($x296164 (= v_3_rcv_nxt v_2_rcv_nxt)))
 (let (($x635987 (= v_3_snd_nxt v_2_snd_nxt)))
 (let (($x602190 (= v_3_snd_una v_2_snd_una)))
 (let (($x159170 (= v_3_irs v_2_irs)))
 (let (($x602982 (= v_3_iss v_2_iss)))
 (let (($x292267 (= 3 state_3)))
 (let (($x42486 (= state_2 3)))
 (and $x42486 active_2_rtx (= 1900 due_2_rtx) (or (not active_2_user) (<= due_2_rtx due_2_user)) (or (not active_2_time_wait) (<= due_2_rtx due_2_time_wait)) (or (not active_2_delack) (not (<= due_2_delack due_2_rtx))) $x292267 $x602982 $x159170 $x602190 $x635987 $x296164 $x733258 $x149549 $x300627 $x13705 $x93724 $x292025 $x499792 $x443310 $x125370 $x56804 $x302334 $x300942 $x57985 $x307983 $x637258 $x286374 $x105716 $x212155 $x635869 $x188771 $x207678 $x140549 $x545619 $x164978 $x142306 $x288861 $x129520 $x252363 $x306828 $x221070 $x127145 $x213666 $x42861 $x325504 $x370071 $x317593 $x401098 $x5062 $x239716 $x642393 $x681351 $x64042 $x653505 $x367863 $x41989 $x253487 $x282016 $x170689 $x559793 $x401342 $x160666 $x448903 $x139440 $x2646 $x208292 $x483996 $x313072 $x719389 $x177557 $x870957 $x50713 $x653347 $x728822 $x372349 $x68467 $x868325 $x320907 $x266136 $x82781 $x291834 $x198641 $x69065 $x207745 $x256222 $x741909 $x873251 $x244798 $x69740 $x81472 $x314880 $x55436 $x8091 $x25305 $x157775 $x246221 $x605029 $x16646 $x605207 $x238588 $x33203 $x418258 $x14204 $x376622 $x472046 $x682510 v_3_tx_syn_pending $x59962 $x423990 $x534582 $x604768 $x307234 $x196867 $x601826 $x2497 $x471917 active_3_rtx $x51350 $x314899 $x153043 (= due_3_rtx (+ 1900 ?x498987)) $x8038 $x642472 $x14520))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
