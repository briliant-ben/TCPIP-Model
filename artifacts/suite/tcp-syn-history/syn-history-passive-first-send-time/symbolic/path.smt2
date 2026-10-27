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
 (let (($x839633 (= due_1_time_wait due_0_time_wait)))
 (let (($x90119 (= due_1_user due_0_user)))
 (let (($x356788 (= due_1_rtx due_0_rtx)))
 (let (($x314814 (not active_1_time_wait)))
 (let (($x126228 (not active_1_user)))
 (let (($x34435 (not active_1_rtx)))
 (let (($x390818 (not v_1_syn_timeout_eligible)))
 (let (($x72137 (not v_1_tx_syn_pending)))
 (let (($x209157 (= v_1_tx_syn_time 0)))
 (let (($x1881 (not v_1_tx_waiting)))
 (let (($x29674 (not v_1_tx_is_fin)))
 (let (($x281988 (= v_1_tx_previous_rto 1000)))
 (let (($x16800 (= v_1_tx_elapsed 0)))
 (let (($x320549 (not v_1_tx_retransmitted)))
 (let (($x455584 (= v_1_tx_max_previous 0)))
 (let (($x138204 (= v_1_tx_eligible 0)))
 (let (($x138113 (= v_1_tx_emit_count 0)))
 (let (($x173427 (= v_1_tx_fin_time 0)))
 (let (($x801 (= v_1_tx_time_15 0)))
 (let (($x468692 (= v_1_tx_time_14 0)))
 (let (($x60432 (= v_1_tx_time_13 0)))
 (let (($x525136 (= v_1_tx_time_12 0)))
 (let (($x295216 (= v_1_tx_time_11 0)))
 (let (($x177177 (= v_1_tx_time_10 0)))
 (let (($x84813 (= v_1_tx_time_09 0)))
 (let (($x459372 (= v_1_tx_time_08 0)))
 (let (($x436787 (= v_1_tx_time_07 0)))
 (let (($x73964 (= v_1_tx_time_06 0)))
 (let (($x312559 (= v_1_tx_time_05 0)))
 (let (($x310666 (= v_1_tx_time_04 0)))
 (let (($x162097 (= v_1_tx_time_03 0)))
 (let (($x281859 (= v_1_tx_time_02 0)))
 (let (($x179045 (= v_1_tx_time_01 0)))
 (let (($x158519 (= v_1_tx_time_00 0)))
 (let (($x9693 (= v_1_rto_base_ms 1000)))
 (let (($x4401 (= v_1_rtt_samples 0)))
 (let (($x85096 (= v_1_rtt_last_ms 0)))
 (let (($x146511 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x11825 (not v_1_rtt_sample_used)))
 (let (($x119214 (not v_1_rtt_start_new)))
 (let (($x390721 (= v_1_rtt_remaining 0)))
 (let (($x345058 (= v_1_rtt_end (_ bv0 32))))
 (let (($x88657 (= v_1_rtt_start_ms 0)))
 (let (($x44930 (= v_1_rtt_sample_at_ms 0)))
 (let (($x36856 (not v_1_rtt_ambiguous)))
 (let (($x302698 (not v_1_rtt_active)))
 (let (($x186020 (not v_1_rtt_previous_measured)))
 (let (($x177218 (not v_1_rtt_measured)))
 (let (($x318247 (= v_1_rtt_previous_var 0.0)))
 (let (($x301035 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x290520 (= v_1_rtt_error_ms 0.0)))
 (let (($x109865 (= v_1_rttvar_ms 0.0)))
 (let (($x398845 (= v_1_srtt_ms 0.0)))
 (let (($x145970 (not v_1_rx_fin_consumed)))
 (let (($x18902 (not v_1_rx_fin_done)))
 (let (($x316728 (= 0 v_1_rx_fin_offset)))
 (let (($x243620 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x283713 (not v_1_rx_fin_pending)))
 (let (($x153705 (not v_1_fin_acknowledged)))
 (let (($x171492 (= v_1_fin_seq (_ bv0 32))))
 (let (($x271075 (not v_1_fin_sent)))
 (let (($x165960 (not v_1_fin_requested)))
 (let (($x131935 (not v_1_ack_window_update)))
 (let (($x455339 (not v_1_ack_advance)))
 (let (($x152549 (not v_1_ack_is_future)))
 (let (($x92431 (not v_1_ack_is_new)))
 (let (($x27190 (= v_1_ack_delta 0)))
 (let (($x96041 (not v_1_seg_acceptable)))
 (let (($x344954 (not v_1_rx_acceptable)))
 (let (($x191757 (= v_1_rx_advance 0)))
 (let (($x149604 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x45395 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x162555 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x307851 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x124270 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x2947 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x31828 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x12884 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x78019 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x126254 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x121367 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x10829 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x60840 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x185368 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x299168 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x18967 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x227672 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x138892 (= v_1_take 0)))
 (let (($x114127 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x308741 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x313131 (= v_1_snd_wnd 8)))
 (let (($x33845 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x317828 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x187636 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x157063 (= 16 v_1_local_window)))
 (let (($x142367 (= v_1_msl_ms 60000)))
 (let (($x48033 (= v_1_user_timeout_ms 30000)))
 (let (($x146553 (not v_1_active_open)))
 (let (($x333224 (= v_1_retries 0)))
 (let (($x82700 (= v_1_rto_ms 1000)))
 (let (($x63629 (= v_1_tx_ack (_ bv0 32))))
 (let (($x26737 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x437398 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x174863 (= v_1_snd_nxt (_ bv1000 32))))
 (let (($x135244 (= v_1_snd_una (_ bv1000 32))))
 (let (($x2519 (= v_1_irs (_ bv0 32))))
 (let (($x318327 (= v_1_iss (_ bv1000 32))))
 (let (($x304030 (= 1 state_1)))
 (let (($x155945 (not active_0_time_wait)))
 (let (($x275043 (or $x155945 (not (<= due_0_time_wait 0)))))
 (let (($x100978 (not active_0_user)))
 (let (($x19133 (or $x100978 (not (<= due_0_user 0)))))
 (let (($x74162 (not active_0_rtx)))
 (let (($x180664 (or $x74162 (not (<= due_0_rtx 0)))))
 (let (($x48433 (= state_0 0)))
 (and $x48433 (>= 0 now_0) $x180664 $x19133 $x275043 $x304030 $x318327 $x2519 $x135244 $x174863 $x437398 $x26737 $x63629 (= v_1_tx_flags "S") $x82700 $x333224 $x146553 $x48033 $x142367 $x157063 $x187636 $x317828 $x33845 $x313131 $x308741 $x114127 $x138892 $x227672 $x18967 $x299168 $x185368 $x60840 $x10829 $x121367 $x126254 $x78019 $x12884 $x31828 $x2947 $x124270 $x307851 $x162555 $x45395 $x149604 $x191757 $x344954 $x96041 $x27190 $x92431 $x152549 $x455339 $x131935 $x165960 $x271075 $x171492 $x153705 $x283713 $x243620 $x316728 $x18902 $x145970 $x398845 $x109865 $x290520 $x301035 $x318247 $x177218 $x186020 $x302698 $x36856 $x44930 $x88657 $x345058 $x390721 $x119214 $x11825 $x146511 $x85096 $x4401 $x9693 $x158519 $x179045 $x281859 $x162097 $x310666 $x312559 $x73964 $x436787 $x459372 $x84813 $x177177 $x295216 $x525136 $x60432 $x468692 $x801 $x173427 $x138113 $x138204 $x455584 $x320549 $x16800 $x281988 $x29674 $x1881 $x209157 $x72137 $x390818 $x34435 $x126228 $x314814 $x356788 $x90119 $x839633)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x301628 (= due_2_time_wait due_1_time_wait)))
 (let (($x315185 (= due_2_rtx 1050)))
 (let (($x81048 (= active_2_time_wait active_1_time_wait)))
 (let (($x118292 (= v_2_syn_timeout_eligible v_1_syn_timeout_eligible)))
 (let (($x72082 (= v_2_tx_syn_time 50)))
 (let (($x81321 (not v_2_tx_waiting)))
 (let (($x316312 (= v_2_tx_is_fin v_1_tx_is_fin)))
 (let (($x207387 (= v_2_tx_previous_rto v_1_tx_previous_rto)))
 (let (($x120551 (= v_2_tx_elapsed v_1_tx_elapsed)))
 (let (($x122827 (not v_2_tx_retransmitted)))
 (let (($x311172 (= v_2_tx_max_previous v_1_tx_max_previous)))
 (let (($x4410 (= v_2_tx_eligible v_1_tx_eligible)))
 (let (($x398768 (= v_2_tx_emit_count v_1_tx_emit_count)))
 (let ((?x208183 (ite (and v_1_fin_sent (not v_1_fin_acknowledged)) v_1_tx_fin_time 0)))
 (let (($x376370 (= v_2_tx_fin_time ?x208183)))
 (let (($x163309 (= v_2_tx_time_15 (ite (>= 15 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_15))))
 (let (($x29194 (= v_2_tx_time_14 (ite (>= 14 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_14))))
 (let (($x88942 (= v_2_tx_time_13 (ite (>= 13 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_13))))
 (let (($x78759 (= v_2_tx_time_12 (ite (>= 12 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_12))))
 (let (($x44870 (= v_2_tx_time_11 (ite (>= 11 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_11))))
 (let (($x201882 (= v_2_tx_time_10 (ite (>= 10 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_10))))
 (let (($x6400 (= v_2_tx_time_09 (ite (>= 9 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_09))))
 (let (($x82886 (= v_2_tx_time_08 (ite (>= 8 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_08))))
 (let (($x289122 (= v_2_tx_time_07 (ite (>= 7 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_07))))
 (let (($x29117 (= v_2_tx_time_06 (ite (>= 6 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_06))))
 (let (($x164180 (= v_2_tx_time_05 (ite (>= 5 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_05))))
 (let (($x193353 (= v_2_tx_time_04 (ite (>= 4 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_04))))
 (let (($x152422 (= v_2_tx_time_03 (ite (>= 3 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_03))))
 (let (($x441964 (= v_2_tx_time_02 (ite (>= 2 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_02))))
 (let (($x144509 (= v_2_tx_time_01 (ite (>= 1 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_01))))
 (let (($x228436 (= v_2_tx_time_00 (ite (>= 0 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_00))))
 (let (($x314099 (= v_2_rto_base_ms 1000)))
 (let (($x37351 (= v_2_rtt_samples 0)))
 (let (($x137471 (= v_2_rtt_last_ms 0)))
 (let (($x108842 (not v_2_rtt_sample_was_ambiguous)))
 (let (($x34193 (not v_2_rtt_sample_used)))
 (let (($x305664 (= v_2_rtt_remaining 1)))
 (let ((?x347201 (bvadd (_ bv1 32) v_1_iss)))
 (let (($x505850 (= v_2_rtt_end ?x347201)))
 (let (($x152015 (= v_2_rtt_start_ms 50)))
 (let (($x67986 (= v_2_rtt_sample_at_ms 0)))
 (let (($x49815 (not v_2_rtt_ambiguous)))
 (let (($x304550 (not v_2_rtt_previous_measured)))
 (let (($x318236 (not v_2_rtt_measured)))
 (let (($x284492 (= v_2_rtt_previous_var 0.0)))
 (let (($x423978 (= v_2_rtt_previous_srtt 0.0)))
 (let (($x179954 (= v_2_rtt_error_ms 0.0)))
 (let (($x188131 (= v_2_rttvar_ms 0.0)))
 (let (($x316733 (= v_2_srtt_ms 0.0)))
 (let (($x298898 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x144041 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x16922 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x293120 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x74195 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x27256 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x316104 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x308928 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x304151 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x131450 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x90177 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x364147 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x21533 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x139919 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x276182 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x4937 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x14424 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x164280 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x50869 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x390607 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x3203 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x206669 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x296519 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x304996 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x290319 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x327896 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x303252 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x355328 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x190041 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x154857 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x149670 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x157046 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x118631 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x29775 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x391387 (= v_2_take v_1_take)))
 (let (($x12133 (= v_2_snd_wl2 v_1_snd_wl2)))
 (let (($x27808 (= v_2_snd_wl1 v_1_snd_wl1)))
 (let (($x77367 (= v_2_snd_wnd v_1_snd_wnd)))
 (let (($x146824 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x82983 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x8533 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x71787 (= v_2_local_window v_1_local_window)))
 (let (($x36964 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x139400 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x34746 (= v_2_active_open v_1_active_open)))
 (let (($x91360 (= 0 v_2_retries)))
 (let (($x144155 (= 1000 v_2_rto_ms)))
 (let (($x57016 (= v_2_tx_flags "SA")))
 (let (($x253340 (= v_2_tx_ack (_ bv9001 32))))
 (let (($x211156 (= v_2_tx_seq v_1_iss)))
 (let (($x280146 (= v_2_rcv_nxt (_ bv9001 32))))
 (let (($x85812 (= v_2_snd_nxt ?x347201)))
 (let (($x581720 (= v_2_snd_una v_1_iss)))
 (let (($x314570 (= v_2_irs (_ bv9000 32))))
 (let (($x168858 (= v_2_iss v_1_iss)))
 (let (($x439328 (= 3 state_2)))
 (let (($x314814 (not active_1_time_wait)))
 (let (($x48042 (or $x314814 (not (<= due_1_time_wait 50)))))
 (let (($x126228 (not active_1_user)))
 (let (($x171951 (or $x126228 (not (<= due_1_user 50)))))
 (let (($x34435 (not active_1_rtx)))
 (let (($x6540 (or $x34435 (not (<= due_1_rtx 50)))))
 (let (($x64741 (= state_1 1)))
 (and $x64741 $x6540 $x171951 $x48042 $x439328 $x168858 $x314570 $x581720 $x85812 $x280146 $x211156 $x253340 $x57016 $x144155 $x91360 $x34746 $x139400 $x36964 $x71787 $x8533 $x82983 $x146824 $x77367 $x27808 $x12133 $x391387 $x29775 $x118631 $x157046 $x149670 $x154857 $x190041 $x355328 $x303252 $x327896 $x290319 $x304996 $x296519 $x206669 $x3203 $x390607 $x50869 $x164280 $x14424 $x4937 $x276182 $x139919 $x21533 $x364147 $x90177 $x131450 $x304151 $x308928 $x316104 $x27256 $x74195 $x293120 $x16922 $x144041 $x298898 $x316733 $x188131 $x179954 $x423978 $x284492 $x318236 $x304550 v_2_rtt_active $x49815 $x67986 $x152015 $x505850 $x305664 v_2_rtt_start_new $x34193 $x108842 $x137471 $x37351 $x314099 $x228436 $x144509 $x441964 $x152422 $x193353 $x164180 $x29117 $x289122 $x82886 $x6400 $x201882 $x44870 $x78759 $x88942 $x29194 $x163309 $x376370 $x398768 $x4410 $x311172 $x122827 $x120551 $x207387 $x316312 $x81321 $x72082 v_2_tx_syn_pending $x118292 active_2_rtx active_2_user $x81048 $x315185 (= due_2_user (+ 50 v_1_user_timeout_ms)) $x301628))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 (let (($x20811 (= due_3_time_wait due_2_time_wait)))
 (let (($x148720 (= due_3_user due_2_user)))
 (let ((?x6790 (ite (>= v_2_rto_ms 30000) 60000 (* 2 v_2_rto_ms))))
 (let ((?x146388 (+ v_2_tx_syn_time v_2_rto_ms)))
 (let (($x129978 (<= ?x146388 1050)))
 (let ((?x259754 (ite $x129978 ?x6790 v_2_rto_ms)))
 (let ((?x187358 (ite $x129978 1050 v_2_tx_syn_time)))
 (let (($x53459 (= active_3_time_wait active_2_time_wait)))
 (let (($x302152 (= active_3_user active_2_user)))
 (let (($x296292 (not v_3_tx_is_fin)))
 (let (($x126873 (= v_3_tx_previous_rto v_2_rto_ms)))
 (let (($x291766 (= v_3_tx_elapsed (ite $x129978 (+ 1050 (* (- 1) v_2_tx_syn_time)) 0))))
 (let (($x75776 (= v_3_tx_max_previous v_2_tx_syn_time)))
 (let (($x81472 (= v_3_tx_eligible v_2_tx_eligible)))
 (let ((?x216831 (ite (and v_2_fin_sent (not v_2_fin_acknowledged)) v_2_tx_fin_time 0)))
 (let (($x319600 (= v_3_tx_fin_time ?x216831)))
 (let (($x203018 (= v_3_tx_time_15 (ite (>= 15 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_15))))
 (let (($x148552 (= v_3_tx_time_14 (ite (>= 14 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_14))))
 (let (($x305274 (= v_3_tx_time_13 (ite (>= 13 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_13))))
 (let (($x211895 (= v_3_tx_time_12 (ite (>= 12 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_12))))
 (let (($x31007 (= v_3_tx_time_11 (ite (>= 11 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_11))))
 (let (($x31705 (= v_3_tx_time_10 (ite (>= 10 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_10))))
 (let (($x133939 (= v_3_tx_time_09 (ite (>= 9 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_09))))
 (let (($x440872 (= v_3_tx_time_08 (ite (>= 8 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_08))))
 (let (($x151250 (= v_3_tx_time_07 (ite (>= 7 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_07))))
 (let (($x304835 (= v_3_tx_time_06 (ite (>= 6 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_06))))
 (let (($x8698 (= v_3_tx_time_05 (ite (>= 5 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_05))))
 (let (($x174342 (= v_3_tx_time_04 (ite (>= 4 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_04))))
 (let (($x275853 (= v_3_tx_time_03 (ite (>= 3 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_03))))
 (let (($x71745 (= v_3_tx_time_02 (ite (>= 2 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_02))))
 (let (($x45296 (= v_3_tx_time_01 (ite (>= 1 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_01))))
 (let (($x64682 (= v_3_tx_time_00 (ite (>= 0 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_00))))
 (let (($x300179 (= v_3_rto_base_ms v_2_rto_base_ms)))
 (let (($x307162 (= v_3_rtt_samples v_2_rtt_samples)))
 (let (($x177644 (= v_3_rtt_last_ms v_2_rtt_last_ms)))
 (let (($x135188 (not v_3_rtt_sample_was_ambiguous)))
 (let (($x100317 (not v_3_rtt_sample_used)))
 (let (($x278530 (not v_3_rtt_start_new)))
 (let (($x170202 (= v_3_rtt_remaining v_2_rtt_remaining)))
 (let (($x145885 (= v_3_rtt_end v_2_rtt_end)))
 (let (($x293514 (= v_3_rtt_start_ms v_2_rtt_start_ms)))
 (let (($x40743 (= v_3_rtt_sample_at_ms v_2_rtt_sample_at_ms)))
 (let ((?x37716 (+ (ubv_to_int (bvadd v_2_rtt_end (bvmul (_ bv4294967295 32) v_2_snd_una))) (* (- 1) v_2_rtt_remaining))))
 (let (($x211674 (or v_2_rtt_ambiguous (and v_2_rtt_active (<= ?x37716 0)))))
 (let (($x223089 (= v_3_rtt_active v_2_rtt_active)))
 (let (($x308326 (= v_3_rtt_previous_measured v_2_rtt_previous_measured)))
 (let (($x348996 (= v_3_rtt_measured v_2_rtt_measured)))
 (let (($x130056 (= v_3_rtt_previous_var v_2_rtt_previous_var)))
 (let (($x258702 (= v_3_rtt_previous_srtt v_2_rtt_previous_srtt)))
 (let (($x87314 (= v_3_rtt_error_ms v_2_rtt_error_ms)))
 (let (($x98531 (= v_3_rttvar_ms v_2_rttvar_ms)))
 (let (($x54625 (= v_3_srtt_ms v_2_srtt_ms)))
 (let (($x173218 (= v_3_rx_fin_consumed v_2_rx_fin_consumed)))
 (let (($x329964 (= v_3_rx_fin_done v_2_rx_fin_done)))
 (let (($x65116 (= v_3_rx_fin_offset v_2_rx_fin_offset)))
 (let (($x49225 (= v_3_rx_fin_seq v_2_rx_fin_seq)))
 (let (($x138858 (= v_3_rx_fin_pending v_2_rx_fin_pending)))
 (let (($x61732 (= v_3_fin_acknowledged v_2_fin_acknowledged)))
 (let (($x251941 (= v_3_fin_seq v_2_fin_seq)))
 (let (($x192403 (= v_3_fin_sent v_2_fin_sent)))
 (let (($x60613 (= v_3_fin_requested v_2_fin_requested)))
 (let (($x169096 (= v_3_ack_window_update v_2_ack_window_update)))
 (let (($x180197 (= v_3_ack_advance v_2_ack_advance)))
 (let (($x45895 (= v_3_ack_is_future v_2_ack_is_future)))
 (let (($x301190 (= v_3_ack_is_new v_2_ack_is_new)))
 (let (($x2098 (= v_3_ack_delta v_2_ack_delta)))
 (let (($x489602 (= v_3_seg_acceptable v_2_seg_acceptable)))
 (let (($x143232 (= v_3_rx_acceptable v_2_rx_acceptable)))
 (let (($x158397 (= v_3_rx_advance v_2_rx_advance)))
 (let (($x146601 (= v_3_rx_slot_15 v_2_rx_slot_15)))
 (let (($x129812 (= v_3_rx_slot_14 v_2_rx_slot_14)))
 (let (($x128957 (= v_3_rx_slot_13 v_2_rx_slot_13)))
 (let (($x304226 (= v_3_rx_slot_12 v_2_rx_slot_12)))
 (let (($x75030 (= v_3_rx_slot_11 v_2_rx_slot_11)))
 (let (($x38068 (= v_3_rx_slot_10 v_2_rx_slot_10)))
 (let (($x1967 (= v_3_rx_slot_09 v_2_rx_slot_09)))
 (let (($x14415 (= v_3_rx_slot_08 v_2_rx_slot_08)))
 (let (($x303876 (= v_3_rx_slot_07 v_2_rx_slot_07)))
 (let (($x6721 (= v_3_rx_slot_06 v_2_rx_slot_06)))
 (let (($x110860 (= v_3_rx_slot_05 v_2_rx_slot_05)))
 (let (($x481803 (= v_3_rx_slot_04 v_2_rx_slot_04)))
 (let (($x396048 (= v_3_rx_slot_03 v_2_rx_slot_03)))
 (let (($x169457 (= v_3_rx_slot_02 v_2_rx_slot_02)))
 (let (($x145877 (= v_3_rx_slot_01 v_2_rx_slot_01)))
 (let (($x325427 (= v_3_rx_slot_00 v_2_rx_slot_00)))
 (let (($x195124 (= v_3_rx_chunk v_2_rx_chunk)))
 (let (($x181806 (= v_3_take v_2_take)))
 (let (($x181708 (= v_3_snd_wl2 v_2_snd_wl2)))
 (let (($x311630 (= v_3_snd_wl1 v_2_snd_wl1)))
 (let (($x48087 (= v_3_snd_wnd v_2_snd_wnd)))
 (let (($x37184 (= v_3_rcv_buf v_2_rcv_buf)))
 (let (($x190761 (= v_3_rtx_buf v_2_rtx_buf)))
 (let (($x518576 (= v_3_snd_buf v_2_snd_buf)))
 (let (($x315018 (= v_3_local_window v_2_local_window)))
 (let (($x313480 (= v_3_msl_ms v_2_msl_ms)))
 (let (($x520675 (= v_3_user_timeout_ms v_2_user_timeout_ms)))
 (let (($x152485 (= v_3_active_open v_2_active_open)))
 (let (($x128124 (= v_3_tx_flags v_2_tx_flags)))
 (let (($x9414 (= v_3_tx_ack v_2_tx_ack)))
 (let (($x226760 (= v_3_tx_seq v_2_tx_seq)))
 (let (($x288266 (= v_3_rcv_nxt v_2_rcv_nxt)))
 (let (($x160781 (= v_3_snd_nxt v_2_snd_nxt)))
 (let (($x527427 (= v_3_snd_una v_2_snd_una)))
 (let (($x52523 (= v_3_irs v_2_irs)))
 (let (($x312038 (= v_3_iss v_2_iss)))
 (let (($x108711 (= 3 state_3)))
 (let (($x506999 (= state_2 3)))
 (and $x506999 active_2_rtx (= 1050 due_2_rtx) (or (not active_2_user) (<= due_2_rtx due_2_user)) (or (not active_2_time_wait) (<= due_2_rtx due_2_time_wait)) $x108711 $x312038 $x52523 $x527427 $x160781 $x288266 $x226760 $x9414 $x128124 (= v_3_rto_ms ?x259754) (= v_3_retries (ite $x129978 (+ 1 v_2_retries) v_2_retries)) $x152485 $x520675 $x313480 $x315018 $x518576 $x190761 $x37184 $x48087 $x311630 $x181708 $x181806 $x195124 $x325427 $x145877 $x169457 $x396048 $x481803 $x110860 $x6721 $x303876 $x14415 $x1967 $x38068 $x75030 $x304226 $x128957 $x129812 $x146601 $x158397 $x143232 $x489602 $x2098 $x301190 $x45895 $x180197 $x169096 $x60613 $x192403 $x251941 $x61732 $x138858 $x49225 $x65116 $x329964 $x173218 $x54625 $x98531 $x87314 $x258702 $x130056 $x348996 $x308326 $x223089 (= v_3_rtt_ambiguous (ite $x129978 $x211674 v_2_rtt_ambiguous)) $x40743 $x293514 $x145885 $x170202 $x278530 $x100317 $x135188 $x177644 $x307162 $x300179 $x64682 $x45296 $x71745 $x275853 $x174342 $x8698 $x304835 $x151250 $x440872 $x133939 $x31705 $x31007 $x211895 $x305274 $x148552 $x203018 $x319600 (= v_3_tx_emit_count (ite $x129978 1 0)) $x81472 $x75776 (= v_3_tx_retransmitted $x129978) $x291766 $x126873 $x296292 (not (= $x129978 v_3_tx_waiting)) (= v_3_tx_syn_time ?x187358) v_3_tx_syn_pending (= v_3_syn_timeout_eligible $x129978) active_3_rtx $x302152 $x53459 (= due_3_rtx (+ 1050 (ite $x129978 ?x6790 (+ (- 1050) ?x187358 ?x259754)))) $x148720 $x20811)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
