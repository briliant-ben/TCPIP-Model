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
(declare-fun due_2_time_wait () Int)
(declare-fun due_2_user () Int)
(declare-fun due_2_rtx () Int)
(declare-fun active_2_time_wait () Bool)
(declare-fun active_2_user () Bool)
(declare-fun active_2_rtx () Bool)
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
(declare-fun due_3_time_wait () Int)
(declare-fun due_3_user () Int)
(declare-fun due_3_rtx () Int)
(declare-fun active_3_time_wait () Bool)
(declare-fun active_3_user () Bool)
(declare-fun active_3_rtx () Bool)
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
 (let (($x163347 (= due_1_time_wait due_0_time_wait)))
 (let (($x260639 (= due_1_user 30000)))
 (let (($x328317 (= due_1_rtx 1000)))
 (let (($x146882 (not active_1_time_wait)))
 (let (($x419304 (not v_1_syn_timeout_eligible)))
 (let (($x153567 (= v_1_tx_syn_time 0)))
 (let (($x190515 (not v_1_tx_waiting)))
 (let (($x177557 (not v_1_tx_is_fin)))
 (let (($x130113 (= v_1_tx_previous_rto 1000)))
 (let (($x28522 (= v_1_tx_elapsed 0)))
 (let (($x110254 (not v_1_tx_retransmitted)))
 (let (($x74904 (= v_1_tx_max_previous 0)))
 (let (($x187691 (= v_1_tx_eligible 0)))
 (let (($x145706 (= v_1_tx_emit_count 0)))
 (let (($x170920 (= v_1_tx_fin_time 0)))
 (let (($x148552 (= v_1_tx_time_15 0)))
 (let (($x6721 (= v_1_tx_time_14 0)))
 (let (($x21042 (= v_1_tx_time_13 0)))
 (let (($x68480 (= v_1_tx_time_12 0)))
 (let (($x82581 (= v_1_tx_time_11 0)))
 (let (($x263051 (= v_1_tx_time_10 0)))
 (let (($x89329 (= v_1_tx_time_09 0)))
 (let (($x42874 (= v_1_tx_time_08 0)))
 (let (($x88405 (= v_1_tx_time_07 0)))
 (let (($x54981 (= v_1_tx_time_06 0)))
 (let (($x389358 (= v_1_tx_time_05 0)))
 (let (($x370051 (= v_1_tx_time_04 0)))
 (let (($x127232 (= v_1_tx_time_03 0)))
 (let (($x22273 (= v_1_tx_time_02 0)))
 (let (($x155824 (= v_1_tx_time_01 0)))
 (let (($x42937 (= v_1_tx_time_00 0)))
 (let (($x96248 (= v_1_rto_base_ms 1000)))
 (let (($x344506 (= v_1_rtt_samples 0)))
 (let (($x209291 (= v_1_rtt_last_ms 0)))
 (let (($x126955 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x309730 (not v_1_rtt_sample_used)))
 (let (($x31918 (= v_1_rtt_remaining 1)))
 (let (($x301630 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x15630 (= v_1_rtt_start_ms 0)))
 (let (($x188345 (= v_1_rtt_sample_at_ms 0)))
 (let (($x6736 (not v_1_rtt_ambiguous)))
 (let (($x101636 (not v_1_rtt_previous_measured)))
 (let (($x64406 (not v_1_rtt_measured)))
 (let (($x179111 (= v_1_rtt_previous_var 0.0)))
 (let (($x60586 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x44717 (= v_1_rtt_error_ms 0.0)))
 (let (($x95698 (= v_1_rttvar_ms 0.0)))
 (let (($x341929 (= v_1_srtt_ms 0.0)))
 (let (($x829710 (not v_1_rx_fin_consumed)))
 (let (($x131444 (not v_1_rx_fin_done)))
 (let (($x139313 (= v_1_rx_fin_offset 0)))
 (let (($x172567 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x122001 (not v_1_rx_fin_pending)))
 (let (($x40349 (not v_1_fin_acknowledged)))
 (let (($x6237 (= v_1_fin_seq (_ bv0 32))))
 (let (($x302161 (not v_1_fin_sent)))
 (let (($x129601 (not v_1_fin_requested)))
 (let (($x327813 (not v_1_ack_window_update)))
 (let (($x130336 (not v_1_ack_advance)))
 (let (($x60108 (not v_1_ack_is_future)))
 (let (($x312405 (not v_1_ack_is_new)))
 (let (($x292384 (= v_1_ack_delta 0)))
 (let (($x174634 (not v_1_seg_acceptable)))
 (let (($x68083 (not v_1_rx_acceptable)))
 (let (($x292618 (= v_1_rx_advance 0)))
 (let (($x178323 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x302245 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x229054 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x57176 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x36759 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x183525 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x13216 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x306207 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x129087 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x25854 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x308535 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x150615 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x162125 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x69710 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x50666 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x63870 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x267818 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x29739 (= v_1_take 0)))
 (let (($x115809 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x394491 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x23542 (= v_1_snd_wnd 8)))
 (let (($x557 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x580167 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x841932 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x222305 (= v_1_local_window 16)))
 (let (($x129246 (= v_1_msl_ms 60000)))
 (let (($x111368 (= v_1_user_timeout_ms 30000)))
 (let (($x236758 (= 0 v_1_retries)))
 (let (($x177039 (= 1000 v_1_rto_ms)))
 (let (($x357450 (= v_1_tx_flags "S")))
 (let (($x43970 (= v_1_tx_ack (_ bv0 32))))
 (let (($x82112 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x108673 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x95091 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x312590 (= v_1_snd_una (_ bv1000 32))))
 (let (($x138364 (= v_1_irs (_ bv0 32))))
 (let (($x41658 (= v_1_iss (_ bv1000 32))))
 (let (($x289982 (= 2 state_1)))
 (let (($x4385 (not active_0_time_wait)))
 (let (($x292068 (or $x4385 (not (<= due_0_time_wait 0)))))
 (let (($x37003 (not active_0_user)))
 (let (($x736 (or $x37003 (not (<= due_0_user 0)))))
 (let (($x10217 (not active_0_rtx)))
 (let (($x154459 (or $x10217 (not (<= due_0_rtx 0)))))
 (let (($x201011 (= state_0 0)))
 (and $x201011 (>= 0 now_0) $x154459 $x736 $x292068 $x289982 $x41658 $x138364 $x312590 $x95091 $x108673 $x82112 $x43970 $x357450 $x177039 $x236758 v_1_active_open $x111368 $x129246 $x222305 $x841932 $x580167 $x557 $x23542 $x394491 $x115809 $x29739 $x267818 $x63870 $x50666 $x69710 $x162125 $x150615 $x308535 $x25854 $x129087 $x306207 $x13216 $x183525 $x36759 $x57176 $x229054 $x302245 $x178323 $x292618 $x68083 $x174634 $x292384 $x312405 $x60108 $x130336 $x327813 $x129601 $x302161 $x6237 $x40349 $x122001 $x172567 $x139313 $x131444 $x829710 $x341929 $x95698 $x44717 $x60586 $x179111 $x64406 $x101636 v_1_rtt_active $x6736 $x188345 $x15630 $x301630 $x31918 v_1_rtt_start_new $x309730 $x126955 $x209291 $x344506 $x96248 $x42937 $x155824 $x22273 $x127232 $x370051 $x389358 $x54981 $x88405 $x42874 $x89329 $x263051 $x82581 $x68480 $x21042 $x6721 $x148552 $x170920 $x145706 $x187691 $x74904 $x110254 $x28522 $x130113 $x177557 $x190515 $x153567 v_1_tx_syn_pending $x419304 active_1_rtx active_1_user $x146882 $x328317 $x260639 $x163347))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x21385 (= due_2_time_wait due_1_time_wait)))
 (let (($x271460 (= due_2_user due_1_user)))
 (let ((?x72470 (ite (>= v_1_rto_ms 30000) 60000 (* 2 v_1_rto_ms))))
 (let ((?x134341 (+ v_1_tx_syn_time v_1_rto_ms)))
 (let (($x321083 (<= ?x134341 1000)))
 (let ((?x565491 (ite $x321083 ?x72470 v_1_rto_ms)))
 (let ((?x165466 (ite $x321083 1000 v_1_tx_syn_time)))
 (let (($x23607 (= active_2_time_wait active_1_time_wait)))
 (let (($x159719 (= active_2_user active_1_user)))
 (let (($x24418 (not v_2_tx_is_fin)))
 (let (($x67376 (= v_2_tx_previous_rto v_1_rto_ms)))
 (let (($x159408 (= v_2_tx_elapsed (ite $x321083 (+ 1000 (* (- 1) v_1_tx_syn_time)) 0))))
 (let (($x18808 (= v_2_tx_max_previous v_1_tx_syn_time)))
 (let (($x41099 (= v_2_tx_eligible v_1_tx_eligible)))
 (let ((?x87677 (ite (and v_1_fin_sent (not v_1_fin_acknowledged)) v_1_tx_fin_time 0)))
 (let (($x42383 (= v_2_tx_fin_time ?x87677)))
 (let (($x146654 (= v_2_tx_time_15 (ite (>= 15 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_15))))
 (let (($x315930 (= v_2_tx_time_14 (ite (>= 14 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_14))))
 (let (($x557526 (= v_2_tx_time_13 (ite (>= 13 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_13))))
 (let (($x31252 (= v_2_tx_time_12 (ite (>= 12 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_12))))
 (let (($x46612 (= v_2_tx_time_11 (ite (>= 11 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_11))))
 (let (($x369965 (= v_2_tx_time_10 (ite (>= 10 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_10))))
 (let (($x161058 (= v_2_tx_time_09 (ite (>= 9 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_09))))
 (let (($x59676 (= v_2_tx_time_08 (ite (>= 8 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_08))))
 (let (($x295207 (= v_2_tx_time_07 (ite (>= 7 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_07))))
 (let (($x303440 (= v_2_tx_time_06 (ite (>= 6 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_06))))
 (let (($x33488 (= v_2_tx_time_05 (ite (>= 5 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_05))))
 (let (($x389336 (= v_2_tx_time_04 (ite (>= 4 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_04))))
 (let (($x287340 (= v_2_tx_time_03 (ite (>= 3 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_03))))
 (let (($x57231 (= v_2_tx_time_02 (ite (>= 2 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_02))))
 (let (($x16160 (= v_2_tx_time_01 (ite (>= 1 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_01))))
 (let (($x154830 (= v_2_tx_time_00 (ite (>= 0 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_00))))
 (let (($x5474 (= v_2_rto_base_ms v_1_rto_base_ms)))
 (let (($x46889 (= v_2_rtt_samples v_1_rtt_samples)))
 (let (($x129240 (= v_2_rtt_last_ms v_1_rtt_last_ms)))
 (let (($x2825 (not v_2_rtt_sample_was_ambiguous)))
 (let (($x42859 (not v_2_rtt_sample_used)))
 (let (($x71745 (not v_2_rtt_start_new)))
 (let (($x378282 (= v_2_rtt_remaining v_1_rtt_remaining)))
 (let (($x119294 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x307731 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let (($x177566 (= v_2_rtt_sample_at_ms v_1_rtt_sample_at_ms)))
 (let ((?x177424 (+ (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una))) (* (- 1) v_1_rtt_remaining))))
 (let (($x186333 (ite $x321083 (or v_1_rtt_ambiguous (and v_1_rtt_active (<= ?x177424 0))) v_1_rtt_ambiguous)))
 (let (($x53715 (= v_2_rtt_active v_1_rtt_active)))
 (let (($x53137 (= v_2_rtt_previous_measured v_1_rtt_previous_measured)))
 (let (($x260145 (= v_2_rtt_measured v_1_rtt_measured)))
 (let (($x43054 (= v_2_rtt_previous_var v_1_rtt_previous_var)))
 (let (($x294487 (= v_2_rtt_previous_srtt v_1_rtt_previous_srtt)))
 (let (($x63049 (= v_2_rtt_error_ms v_1_rtt_error_ms)))
 (let (($x311963 (= v_2_rttvar_ms v_1_rttvar_ms)))
 (let (($x424874 (= v_2_srtt_ms v_1_srtt_ms)))
 (let (($x117371 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x237485 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x289540 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x21842 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x23311 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x188702 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x159444 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x131138 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x75601 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x161023 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x449357 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x138581 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x108048 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x296492 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x210124 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x174011 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x344880 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x120274 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x45600 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x4569 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x239933 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x226929 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x181512 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x183153 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x200177 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x139042 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x174408 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x395349 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x52197 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x3738 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x157109 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x309368 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x171571 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x63919 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x185734 (= v_2_take v_1_take)))
 (let (($x6399 (= v_2_snd_wl2 v_1_snd_wl2)))
 (let (($x58268 (= v_2_snd_wl1 v_1_snd_wl1)))
 (let (($x43640 (= v_2_snd_wnd v_1_snd_wnd)))
 (let (($x68894 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x168951 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x139159 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x229618 (= v_2_local_window v_1_local_window)))
 (let (($x314059 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x422310 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x270364 (= v_2_active_open v_1_active_open)))
 (let (($x376168 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x276849 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x346490 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x346075 (= v_2_rcv_nxt v_1_rcv_nxt)))
 (let (($x65359 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x49319 (= v_2_snd_una v_1_snd_una)))
 (let (($x6586 (= v_2_irs v_1_irs)))
 (let (($x59099 (= v_2_iss v_1_iss)))
 (let (($x112804 (= 2 state_2)))
 (let (($x140135 (= state_1 2)))
 (and $x140135 active_1_rtx (= 1000 due_1_rtx) (or (not active_1_user) (<= due_1_rtx due_1_user)) (or (not active_1_time_wait) (<= due_1_rtx due_1_time_wait)) $x112804 $x59099 $x6586 $x49319 $x65359 $x346075 $x346490 $x276849 $x376168 (= v_2_rto_ms ?x565491) (= v_2_retries (ite $x321083 (+ 1 v_1_retries) v_1_retries)) $x270364 $x422310 $x314059 $x229618 $x139159 $x168951 $x68894 $x43640 $x58268 $x6399 $x185734 $x63919 $x171571 $x309368 $x157109 $x3738 $x52197 $x395349 $x174408 $x139042 $x200177 $x183153 $x181512 $x226929 $x239933 $x4569 $x45600 $x120274 $x344880 $x174011 $x210124 $x296492 $x108048 $x138581 $x449357 $x161023 $x75601 $x131138 $x159444 $x188702 $x23311 $x21842 $x289540 $x237485 $x117371 $x424874 $x311963 $x63049 $x294487 $x43054 $x260145 $x53137 $x53715 (= v_2_rtt_ambiguous $x186333) $x177566 $x307731 $x119294 $x378282 $x71745 $x42859 $x2825 $x129240 $x46889 $x5474 $x154830 $x16160 $x57231 $x287340 $x389336 $x33488 $x303440 $x295207 $x59676 $x161058 $x369965 $x46612 $x31252 $x557526 $x315930 $x146654 $x42383 (= v_2_tx_emit_count (ite $x321083 1 0)) $x41099 $x18808 (= v_2_tx_retransmitted $x321083) $x159408 $x67376 $x24418 (not (= $x321083 v_2_tx_waiting)) (= v_2_tx_syn_time ?x165466) v_2_tx_syn_pending (= v_2_syn_timeout_eligible $x321083) active_2_rtx $x159719 $x23607 (= due_2_rtx (+ 1000 (ite $x321083 ?x72470 (+ (- 1000) ?x165466 ?x565491)))) $x271460 $x21385)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 (let (($x319722 (= due_3_time_wait due_2_time_wait)))
 (let (($x122849 (= due_3_user due_2_user)))
 (let (($x1192 (= due_3_rtx due_2_rtx)))
 (let (($x62882 (= active_3_time_wait active_2_time_wait)))
 (let (($x58144 (not active_3_user)))
 (let (($x326676 (not active_3_rtx)))
 (let (($x73826 (not v_3_syn_timeout_eligible)))
 (let (($x60634 (not v_3_tx_syn_pending)))
 (let (($x153084 (= v_3_tx_syn_time 0)))
 (let (($x156297 (not v_3_tx_waiting)))
 (let (($x396140 (= v_3_tx_is_fin v_2_tx_is_fin)))
 (let (($x242008 (= v_3_tx_previous_rto v_2_tx_previous_rto)))
 (let (($x314533 (= v_3_tx_elapsed v_2_tx_elapsed)))
 (let (($x312688 (not v_3_tx_retransmitted)))
 (let (($x340447 (= v_3_tx_max_previous v_2_tx_max_previous)))
 (let (($x88850 (= v_3_tx_eligible v_2_tx_eligible)))
 (let (($x14650 (= v_3_tx_emit_count v_2_tx_emit_count)))
 (let ((?x100919 (ite (and v_2_fin_sent (not v_2_fin_acknowledged)) v_2_tx_fin_time 0)))
 (let (($x296618 (= v_3_tx_fin_time ?x100919)))
 (let (($x186181 (= v_3_tx_time_15 (ite (>= 15 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_15))))
 (let (($x275236 (= v_3_tx_time_14 (ite (>= 14 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_14))))
 (let (($x317158 (= v_3_tx_time_13 (ite (>= 13 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_13))))
 (let (($x342639 (= v_3_tx_time_12 (ite (>= 12 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_12))))
 (let (($x111902 (= v_3_tx_time_11 (ite (>= 11 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_11))))
 (let (($x74714 (= v_3_tx_time_10 (ite (>= 10 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_10))))
 (let (($x168447 (= v_3_tx_time_09 (ite (>= 9 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_09))))
 (let (($x388636 (= v_3_tx_time_08 (ite (>= 8 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_08))))
 (let (($x247866 (= v_3_tx_time_07 (ite (>= 7 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_07))))
 (let (($x240158 (= v_3_tx_time_06 (ite (>= 6 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_06))))
 (let (($x19649 (= v_3_tx_time_05 (ite (>= 5 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_05))))
 (let (($x372958 (= v_3_tx_time_04 (ite (>= 4 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_04))))
 (let (($x53456 (= v_3_tx_time_03 (ite (>= 3 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_03))))
 (let (($x117188 (= v_3_tx_time_02 (ite (>= 2 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_02))))
 (let (($x132299 (= v_3_tx_time_01 (ite (>= 1 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_01))))
 (let (($x98681 (= v_3_tx_time_00 (ite (>= 0 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_00))))
 (let ((?x391056 (+ 1010 (* (- 1) v_2_rtt_start_ms))))
 (let (($x843519 (not v_2_rtt_ambiguous)))
 (let ((?x198892 (ubv_to_int (bvadd v_2_rtt_end (bvmul (_ bv4294967295 32) v_2_snd_una)))))
 (let ((?x98153 (ubv_to_int (bvadd (_ bv1001 32) (bvmul (_ bv4294967295 32) v_2_snd_una)))))
 (let (($x25677 (>= ?x98153 ?x198892)))
 (let (($x158543 (and v_2_rtt_active $x25677 $x843519)))
 (let ((?x298898 (ite $x158543 ?x391056 v_2_rtt_last_ms)))
 (let ((?x16922 (to_real ?x298898)))
 (let ((?x828023 (+ v_2_srtt_ms (* (- 1.0) ?x16922))))
 (let ((?x390304 (ite $x158543 (ite (>= ?x828023 0.0) ?x828023 (+ (* (- 1.0) v_2_srtt_ms) ?x16922)) v_2_rtt_error_ms)))
 (let ((?x441964 (* (/ 3.0 4.0) v_2_rttvar_ms)))
 (let ((?x7802 (ite $x158543 (ite v_2_rtt_measured (+ ?x441964 (* (/ 1.0 4.0) ?x390304)) (* (/ 1.0 2.0) ?x16922)) v_2_rttvar_ms)))
 (let ((?x311734 (ite v_2_rtt_measured (+ (* (/ 7.0 8.0) v_2_srtt_ms) (* (/ 1.0 8.0) ?x16922)) ?x16922)))
 (let ((?x389892 (ite $x158543 ?x311734 v_2_srtt_ms)))
 (let ((?x153959 (+ (* (- 1.0) ?x389892) (* (- 1.0) (ite (<= ?x7802 (/ 1.0 4.0)) 1.0 (* 4.0 ?x7802))))))
 (let ((?x252507 (to_int ?x153959)))
 (let ((?x280500 (ite (<= ?x252507 (- 1000)) (* (- 1) ?x252507) 1000)))
 (let (($x89477 (= v_3_rto_base_ms (ite $x158543 (ite (<= 60000 ?x280500) 60000 ?x280500) v_2_rto_base_ms))))
 (let (($x152595 (= v_3_rtt_sample_was_ambiguous (and v_2_rtt_active v_2_rtt_ambiguous))))
 (let (($x297206 (not v_3_rtt_start_new)))
 (let ((?x160898 (* (- 1) ?x98153)))
 (let ((?x312451 (+ ?x198892 ?x160898)))
 (let ((?x282902 (ite (and v_2_rtt_active (not (<= v_2_rtt_remaining ?x312451))) ?x312451 v_2_rtt_remaining)))
 (let (($x110339 (and v_2_rtt_active $x25677)))
 (let (($x45818 (= v_3_rtt_end v_2_rtt_end)))
 (let (($x101047 (= v_3_rtt_start_ms v_2_rtt_start_ms)))
 (let (($x25129 (= v_3_rtt_previous_measured (ite $x158543 v_2_rtt_measured v_2_rtt_previous_measured))))
 (let (($x159123 (= v_3_rtt_previous_var (ite $x158543 v_2_rttvar_ms v_2_rtt_previous_var))))
 (let (($x310646 (= v_3_rtt_previous_srtt (ite $x158543 v_2_srtt_ms v_2_rtt_previous_srtt))))
 (let (($x117901 (= v_3_rx_fin_consumed v_2_rx_fin_consumed)))
 (let (($x183757 (= v_3_rx_fin_done v_2_rx_fin_done)))
 (let (($x145006 (= v_3_rx_fin_offset v_2_rx_fin_offset)))
 (let (($x122560 (= v_3_rx_fin_seq v_2_rx_fin_seq)))
 (let (($x43765 (= v_3_rx_fin_pending v_2_rx_fin_pending)))
 (let (($x186812 (= v_3_fin_acknowledged v_2_fin_acknowledged)))
 (let (($x10411 (= v_3_fin_seq v_2_fin_seq)))
 (let (($x341993 (= v_3_fin_sent v_2_fin_sent)))
 (let (($x121840 (= v_3_fin_requested v_2_fin_requested)))
 (let (($x22776 (= v_3_ack_window_update v_2_ack_window_update)))
 (let (($x116558 (= v_3_ack_advance v_2_ack_advance)))
 (let (($x67982 (= v_3_ack_is_future v_2_ack_is_future)))
 (let (($x1759 (= v_3_ack_is_new v_2_ack_is_new)))
 (let (($x57559 (= v_3_ack_delta v_2_ack_delta)))
 (let (($x166092 (= v_3_seg_acceptable v_2_seg_acceptable)))
 (let (($x6945 (= v_3_rx_acceptable v_2_rx_acceptable)))
 (let (($x307467 (= v_3_rx_advance v_2_rx_advance)))
 (let (($x211279 (= v_3_rx_slot_15 v_2_rx_slot_15)))
 (let (($x227794 (= v_3_rx_slot_14 v_2_rx_slot_14)))
 (let (($x240234 (= v_3_rx_slot_13 v_2_rx_slot_13)))
 (let (($x315290 (= v_3_rx_slot_12 v_2_rx_slot_12)))
 (let (($x202271 (= v_3_rx_slot_11 v_2_rx_slot_11)))
 (let (($x39939 (= v_3_rx_slot_10 v_2_rx_slot_10)))
 (let (($x184201 (= v_3_rx_slot_09 v_2_rx_slot_09)))
 (let (($x757038 (= v_3_rx_slot_08 v_2_rx_slot_08)))
 (let (($x10953 (= v_3_rx_slot_07 v_2_rx_slot_07)))
 (let (($x258713 (= v_3_rx_slot_06 v_2_rx_slot_06)))
 (let (($x274893 (= v_3_rx_slot_05 v_2_rx_slot_05)))
 (let (($x201504 (= v_3_rx_slot_04 v_2_rx_slot_04)))
 (let (($x23170 (= v_3_rx_slot_03 v_2_rx_slot_03)))
 (let (($x155070 (= v_3_rx_slot_02 v_2_rx_slot_02)))
 (let (($x186548 (= v_3_rx_slot_01 v_2_rx_slot_01)))
 (let (($x315850 (= v_3_rx_slot_00 v_2_rx_slot_00)))
 (let (($x23701 (= v_3_rx_chunk v_2_rx_chunk)))
 (let (($x425349 (= v_3_take v_2_take)))
 (let (($x62018 (= v_3_snd_wl2 (_ bv1001 32))))
 (let (($x146367 (= v_3_snd_wl1 (_ bv9000 32))))
 (let (($x185797 (= v_3_snd_wnd 16)))
 (let (($x144464 (= v_3_rcv_buf v_2_rcv_buf)))
 (let (($x176996 (= v_3_rtx_buf v_2_rtx_buf)))
 (let (($x91169 (= v_3_snd_buf v_2_snd_buf)))
 (let (($x27114 (= v_3_local_window v_2_local_window)))
 (let (($x138721 (= v_3_msl_ms v_2_msl_ms)))
 (let (($x172927 (= v_3_user_timeout_ms v_2_user_timeout_ms)))
 (let (($x365073 (= v_3_active_open v_2_active_open)))
 (let (($x155353 (= v_3_retries v_2_retries)))
 (let (($x41609 (= 3000 v_3_rto_ms)))
 (let (($x82788 (= v_3_tx_flags v_2_tx_flags)))
 (let (($x83829 (= v_3_tx_ack v_2_tx_ack)))
 (let (($x391744 (= v_3_tx_seq v_2_tx_seq)))
 (let (($x233561 (= v_3_rcv_nxt (_ bv9001 32))))
 (let (($x152162 (= v_3_snd_nxt v_2_snd_nxt)))
 (let (($x160959 (= v_3_snd_una (_ bv1001 32))))
 (let (($x98110 (= v_3_irs (_ bv9000 32))))
 (let (($x845324 (= v_3_iss v_2_iss)))
 (let (($x28470 (= 4 state_3)))
 (let (($x84538 (or (not active_2_time_wait) (not (<= due_2_time_wait 1010)))))
 (let (($x65556 (or (not active_2_user) (not (<= due_2_user 1010)))))
 (let (($x312400 (or (not active_2_rtx) (not (<= due_2_rtx 1010)))))
 (let (($x120718 (= 1 v_2_retries)))
 (let (($x215311 (= v_2_snd_nxt (_ bv1001 32))))
 (let (($x316522 (= state_2 2)))
 (and $x316522 $x215311 $x120718 $x312400 $x65556 $x84538 $x28470 $x845324 $x98110 $x160959 $x152162 $x233561 $x391744 $x83829 $x82788 $x41609 $x155353 $x365073 $x172927 $x138721 $x27114 $x91169 $x176996 $x144464 $x185797 $x146367 $x62018 $x425349 $x23701 $x315850 $x186548 $x155070 $x23170 $x201504 $x274893 $x258713 $x10953 $x757038 $x184201 $x39939 $x202271 $x315290 $x240234 $x227794 $x211279 $x307467 $x6945 $x166092 $x57559 $x1759 $x67982 $x116558 $x22776 $x121840 $x341993 $x10411 $x186812 $x43765 $x122560 $x145006 $x183757 $x117901 (= v_3_srtt_ms ?x389892) (= v_3_rttvar_ms ?x7802) (= v_3_rtt_error_ms ?x390304) $x310646 $x159123 (= v_3_rtt_measured (or v_2_rtt_measured $x158543)) $x25129 (= v_3_rtt_active (and v_2_rtt_active (not $x110339))) (= v_3_rtt_ambiguous (and (not $x110339) v_2_rtt_ambiguous)) (= v_3_rtt_sample_at_ms (ite $x158543 1010 v_2_rtt_sample_at_ms)) $x101047 $x45818 (= v_3_rtt_remaining (ite $x110339 0 ?x282902)) $x297206 (= v_3_rtt_sample_used $x158543) $x152595 (= v_3_rtt_last_ms ?x298898) (= v_3_rtt_samples (+ v_2_rtt_samples (ite $x158543 1 0))) $x89477 $x98681 $x132299 $x117188 $x53456 $x372958 $x19649 $x240158 $x247866 $x388636 $x168447 $x74714 $x111902 $x342639 $x317158 $x275236 $x186181 $x296618 $x14650 $x88850 $x340447 $x312688 $x314533 $x242008 $x396140 $x156297 $x153084 $x60634 $x73826 $x326676 $x58144 $x62882 $x1192 $x122849 $x319722))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
