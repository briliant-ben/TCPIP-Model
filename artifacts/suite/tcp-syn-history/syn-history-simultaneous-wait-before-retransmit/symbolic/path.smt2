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
 (let (($x308214 (= due_1_time_wait due_0_time_wait)))
 (let (($x146580 (= due_1_user 30000)))
 (let (($x839746 (= due_1_rtx 1000)))
 (let (($x290075 (not active_1_time_wait)))
 (let (($x187155 (not v_1_syn_timeout_eligible)))
 (let (($x297042 (= v_1_tx_syn_time 0)))
 (let (($x29298 (not v_1_tx_waiting)))
 (let (($x391565 (not v_1_tx_is_fin)))
 (let (($x184106 (= v_1_tx_previous_rto 1000)))
 (let (($x182803 (= v_1_tx_elapsed 0)))
 (let (($x276382 (not v_1_tx_retransmitted)))
 (let (($x17389 (= v_1_tx_max_previous 0)))
 (let (($x117005 (= v_1_tx_eligible 0)))
 (let (($x15753 (= v_1_tx_emit_count 0)))
 (let (($x49730 (= v_1_tx_fin_time 0)))
 (let (($x7959 (= v_1_tx_time_15 0)))
 (let (($x92438 (= v_1_tx_time_14 0)))
 (let (($x96685 (= v_1_tx_time_13 0)))
 (let (($x58436 (= v_1_tx_time_12 0)))
 (let (($x156287 (= v_1_tx_time_11 0)))
 (let (($x150184 (= v_1_tx_time_10 0)))
 (let (($x176231 (= v_1_tx_time_09 0)))
 (let (($x196636 (= v_1_tx_time_08 0)))
 (let (($x308507 (= v_1_tx_time_07 0)))
 (let (($x43219 (= v_1_tx_time_06 0)))
 (let (($x180347 (= v_1_tx_time_05 0)))
 (let (($x106749 (= v_1_tx_time_04 0)))
 (let (($x357450 (= v_1_tx_time_03 0)))
 (let (($x430981 (= v_1_tx_time_02 0)))
 (let (($x321994 (= v_1_tx_time_01 0)))
 (let (($x195238 (= v_1_tx_time_00 0)))
 (let (($x317771 (= v_1_rto_base_ms 1000)))
 (let (($x166248 (= v_1_rtt_samples 0)))
 (let (($x176202 (= v_1_rtt_last_ms 0)))
 (let (($x345145 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x81990 (not v_1_rtt_sample_used)))
 (let (($x130138 (= v_1_rtt_remaining 1)))
 (let (($x137550 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x388851 (= v_1_rtt_start_ms 0)))
 (let (($x306692 (= v_1_rtt_sample_at_ms 0)))
 (let (($x162027 (not v_1_rtt_ambiguous)))
 (let (($x477262 (not v_1_rtt_previous_measured)))
 (let (($x145501 (not v_1_rtt_measured)))
 (let (($x222096 (= v_1_rtt_previous_var 0.0)))
 (let (($x268826 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x97640 (= v_1_rtt_error_ms 0.0)))
 (let (($x133938 (= v_1_rttvar_ms 0.0)))
 (let (($x191242 (= v_1_srtt_ms 0.0)))
 (let (($x273270 (not v_1_rx_fin_consumed)))
 (let (($x83836 (not v_1_rx_fin_done)))
 (let (($x339285 (= v_1_rx_fin_offset 0)))
 (let (($x102420 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x84910 (not v_1_rx_fin_pending)))
 (let (($x305158 (not v_1_fin_acknowledged)))
 (let (($x278530 (= v_1_fin_seq (_ bv0 32))))
 (let (($x370451 (not v_1_fin_sent)))
 (let (($x130035 (not v_1_fin_requested)))
 (let (($x197383 (not v_1_ack_window_update)))
 (let (($x21896 (not v_1_ack_advance)))
 (let (($x266702 (not v_1_ack_is_future)))
 (let (($x168153 (not v_1_ack_is_new)))
 (let (($x157102 (= v_1_ack_delta 0)))
 (let (($x12068 (not v_1_seg_acceptable)))
 (let (($x192170 (not v_1_rx_acceptable)))
 (let (($x117541 (= v_1_rx_advance 0)))
 (let (($x162401 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x217406 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x223195 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x189851 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x310512 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x441488 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x353842 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x81047 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x296476 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x74484 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x137075 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x310273 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x824290 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x843792 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x52199 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x196793 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x154553 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x266559 (= v_1_take 0)))
 (let (($x6493 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x21408 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x153730 (= v_1_snd_wnd 8)))
 (let (($x162557 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x41218 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x136673 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x31476 (= v_1_local_window 16)))
 (let (($x158103 (= v_1_msl_ms 60000)))
 (let (($x70256 (= v_1_user_timeout_ms 30000)))
 (let (($x193353 (= 0 v_1_retries)))
 (let (($x51650 (= 1000 v_1_rto_ms)))
 (let (($x28706 (= v_1_tx_flags "S")))
 (let (($x181176 (= v_1_tx_ack (_ bv0 32))))
 (let (($x121708 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x139193 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x211566 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x184602 (= v_1_snd_una (_ bv1000 32))))
 (let (($x117871 (= v_1_irs (_ bv0 32))))
 (let (($x125629 (= v_1_iss (_ bv1000 32))))
 (let (($x134905 (= 2 state_1)))
 (let (($x12133 (not active_0_time_wait)))
 (let (($x129387 (or $x12133 (not (<= due_0_time_wait 0)))))
 (let (($x27808 (not active_0_user)))
 (let (($x311192 (or $x27808 (not (<= due_0_user 0)))))
 (let (($x77367 (not active_0_rtx)))
 (let (($x117675 (or $x77367 (not (<= due_0_rtx 0)))))
 (let (($x194356 (= state_0 0)))
 (and $x194356 (>= 0 now_0) $x117675 $x311192 $x129387 $x134905 $x125629 $x117871 $x184602 $x211566 $x139193 $x121708 $x181176 $x28706 $x51650 $x193353 v_1_active_open $x70256 $x158103 $x31476 $x136673 $x41218 $x162557 $x153730 $x21408 $x6493 $x266559 $x154553 $x196793 $x52199 $x843792 $x824290 $x310273 $x137075 $x74484 $x296476 $x81047 $x353842 $x441488 $x310512 $x189851 $x223195 $x217406 $x162401 $x117541 $x192170 $x12068 $x157102 $x168153 $x266702 $x21896 $x197383 $x130035 $x370451 $x278530 $x305158 $x84910 $x102420 $x339285 $x83836 $x273270 $x191242 $x133938 $x97640 $x268826 $x222096 $x145501 $x477262 v_1_rtt_active $x162027 $x306692 $x388851 $x137550 $x130138 v_1_rtt_start_new $x81990 $x345145 $x176202 $x166248 $x317771 $x195238 $x321994 $x430981 $x357450 $x106749 $x180347 $x43219 $x308507 $x196636 $x176231 $x150184 $x156287 $x58436 $x96685 $x92438 $x7959 $x49730 $x15753 $x117005 $x17389 $x276382 $x182803 $x184106 $x391565 $x29298 $x297042 v_1_tx_syn_pending $x187155 active_1_rtx active_1_user $x290075 $x839746 $x146580 $x308214))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x64240 (= due_2_time_wait due_1_time_wait)))
 (let (($x183632 (= due_2_user due_1_user)))
 (let (($x136588 (= active_2_time_wait active_1_time_wait)))
 (let (($x297730 (= active_2_user active_1_user)))
 (let (($x70224 (= v_2_syn_timeout_eligible v_1_syn_timeout_eligible)))
 (let (($x147757 (= v_2_tx_syn_time 900)))
 (let (($x223076 (not v_2_tx_waiting)))
 (let (($x135247 (= v_2_tx_is_fin v_1_tx_is_fin)))
 (let (($x183686 (= v_2_tx_previous_rto v_1_tx_previous_rto)))
 (let (($x389103 (= v_2_tx_elapsed v_1_tx_elapsed)))
 (let (($x127536 (not v_2_tx_retransmitted)))
 (let (($x45611 (= v_2_tx_max_previous v_1_tx_max_previous)))
 (let (($x161909 (= v_2_tx_eligible v_1_tx_eligible)))
 (let (($x68321 (= v_2_tx_emit_count v_1_tx_emit_count)))
 (let ((?x211605 (ite (and v_1_fin_sent (not v_1_fin_acknowledged)) v_1_tx_fin_time 0)))
 (let (($x295611 (= v_2_tx_fin_time ?x211605)))
 (let (($x292913 (= v_2_tx_time_15 (ite (>= 15 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_15))))
 (let (($x370051 (= v_2_tx_time_14 (ite (>= 14 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_14))))
 (let (($x152933 (= v_2_tx_time_13 (ite (>= 13 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_13))))
 (let (($x67409 (= v_2_tx_time_12 (ite (>= 12 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_12))))
 (let (($x148858 (= v_2_tx_time_11 (ite (>= 11 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_11))))
 (let (($x52474 (= v_2_tx_time_10 (ite (>= 10 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_10))))
 (let (($x94336 (= v_2_tx_time_09 (ite (>= 9 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_09))))
 (let (($x223706 (= v_2_tx_time_08 (ite (>= 8 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_08))))
 (let (($x153633 (= v_2_tx_time_07 (ite (>= 7 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_07))))
 (let (($x142210 (= v_2_tx_time_06 (ite (>= 6 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_06))))
 (let (($x116163 (= v_2_tx_time_05 (ite (>= 5 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_05))))
 (let (($x160214 (= v_2_tx_time_04 (ite (>= 4 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_04))))
 (let (($x159839 (= v_2_tx_time_03 (ite (>= 3 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_03))))
 (let (($x57217 (= v_2_tx_time_02 (ite (>= 2 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_02))))
 (let (($x283518 (= v_2_tx_time_01 (ite (>= 1 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_01))))
 (let (($x183567 (= v_2_tx_time_00 (ite (>= 0 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_00))))
 (let (($x323658 (= v_2_rto_base_ms v_1_rto_base_ms)))
 (let (($x219159 (= v_2_rtt_samples v_1_rtt_samples)))
 (let (($x116113 (= v_2_rtt_last_ms v_1_rtt_last_ms)))
 (let (($x310589 (not v_2_rtt_sample_was_ambiguous)))
 (let (($x246568 (not v_2_rtt_sample_used)))
 (let (($x150904 (not v_2_rtt_start_new)))
 (let (($x140985 (= v_2_rtt_remaining v_1_rtt_remaining)))
 (let (($x1497 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x560342 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let (($x168388 (= v_2_rtt_sample_at_ms v_1_rtt_sample_at_ms)))
 (let ((?x306386 (+ (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una))) (* (- 1) v_1_rtt_remaining))))
 (let (($x100303 (= v_2_rtt_ambiguous (or v_1_rtt_ambiguous (and v_1_rtt_active (<= ?x306386 0))))))
 (let (($x268869 (= v_2_rtt_active v_1_rtt_active)))
 (let (($x4860 (= v_2_rtt_previous_measured v_1_rtt_previous_measured)))
 (let (($x396049 (= v_2_rtt_measured v_1_rtt_measured)))
 (let (($x307385 (= v_2_rtt_previous_var v_1_rtt_previous_var)))
 (let (($x3012 (= v_2_rtt_previous_srtt v_1_rtt_previous_srtt)))
 (let (($x86837 (= v_2_rtt_error_ms v_1_rtt_error_ms)))
 (let (($x131595 (= v_2_rttvar_ms v_1_rttvar_ms)))
 (let (($x150032 (= v_2_srtt_ms v_1_srtt_ms)))
 (let (($x99203 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x57854 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x12488 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x42937 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x329784 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x276932 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x67004 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x264447 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x223312 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x297232 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x130889 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x149840 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x310707 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x165466 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x120155 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x151739 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x301074 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x182445 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x303375 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x95083 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x82443 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x42644 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x51958 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x173636 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x164653 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x96248 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x320117 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x135201 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x22039 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x5158 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x318910 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x289540 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x135441 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x168514 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x358307 (= v_2_take v_1_take)))
 (let (($x27451 (= v_2_snd_wl2 v_1_snd_wl2)))
 (let (($x20884 (= v_2_snd_wl1 v_1_snd_wl1)))
 (let (($x148690 (= v_2_snd_wnd v_1_snd_wnd)))
 (let (($x295895 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x136863 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x166116 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x144920 (= v_2_local_window v_1_local_window)))
 (let (($x32794 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x9616 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x85887 (= v_2_active_open v_1_active_open)))
 (let (($x223130 (= v_2_retries v_1_retries)))
 (let (($x162465 (= v_2_rto_ms v_1_rto_ms)))
 (let (($x104890 (= v_2_tx_flags "SA")))
 (let (($x32247 (= v_2_tx_ack (_ bv9001 32))))
 (let (($x26888 (= v_2_tx_seq v_1_iss)))
 (let (($x327904 (= v_2_rcv_nxt (_ bv9001 32))))
 (let (($x243971 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x128641 (= v_2_snd_una v_1_snd_una)))
 (let (($x292251 (= v_2_irs (_ bv9000 32))))
 (let (($x196686 (= v_2_iss v_1_iss)))
 (let (($x5376 (= 3 state_2)))
 (let (($x290075 (not active_1_time_wait)))
 (let (($x384266 (or $x290075 (not (<= due_1_time_wait 900)))))
 (let (($x137352 (or (not active_1_user) (not (<= due_1_user 900)))))
 (let (($x126492 (or (not active_1_rtx) (not (<= due_1_rtx 900)))))
 (let (($x168888 (= state_1 2)))
 (and $x168888 $x126492 $x137352 $x384266 $x5376 $x196686 $x292251 $x128641 $x243971 $x327904 $x26888 $x32247 $x104890 $x162465 $x223130 $x85887 $x9616 $x32794 $x144920 $x166116 $x136863 $x295895 $x148690 $x20884 $x27451 $x358307 $x168514 $x135441 $x289540 $x318910 $x5158 $x22039 $x135201 $x320117 $x96248 $x164653 $x173636 $x51958 $x42644 $x82443 $x95083 $x303375 $x182445 $x301074 $x151739 $x120155 $x165466 $x310707 $x149840 $x130889 $x297232 $x223312 $x264447 $x67004 $x276932 $x329784 $x42937 $x12488 $x57854 $x99203 $x150032 $x131595 $x86837 $x3012 $x307385 $x396049 $x4860 $x268869 $x100303 $x168388 $x560342 $x1497 $x140985 $x150904 $x246568 $x310589 $x116113 $x219159 $x323658 $x183567 $x283518 $x57217 $x159839 $x160214 $x116163 $x142210 $x153633 $x223706 $x94336 $x52474 $x148858 $x67409 $x152933 $x370051 $x292913 $x295611 $x68321 $x161909 $x45611 $x127536 $x389103 $x183686 $x135247 $x223076 $x147757 v_2_tx_syn_pending $x70224 active_2_rtx $x297730 $x136588 (= due_2_rtx (+ 900 v_1_rto_ms)) $x183632 $x64240)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 (let (($x306103 (= due_3_time_wait due_2_time_wait)))
 (let (($x211203 (= due_3_user due_2_user)))
 (let ((?x268174 (ite (>= v_2_rto_ms 30000) 60000 (* 2 v_2_rto_ms))))
 (let ((?x26723 (+ v_2_tx_syn_time v_2_rto_ms)))
 (let (($x36202 (<= ?x26723 1900)))
 (let ((?x31457 (ite $x36202 ?x268174 v_2_rto_ms)))
 (let ((?x272753 (ite $x36202 1900 v_2_tx_syn_time)))
 (let (($x195028 (= active_3_time_wait active_2_time_wait)))
 (let (($x304456 (= active_3_user active_2_user)))
 (let (($x192245 (not v_3_tx_is_fin)))
 (let (($x281997 (= v_3_tx_previous_rto v_2_rto_ms)))
 (let (($x489570 (= v_3_tx_elapsed (ite $x36202 (+ 1900 (* (- 1) v_2_tx_syn_time)) 0))))
 (let (($x301838 (= v_3_tx_max_previous v_2_tx_syn_time)))
 (let (($x290834 (= v_3_tx_eligible v_2_tx_eligible)))
 (let ((?x354474 (ite (and v_2_fin_sent (not v_2_fin_acknowledged)) v_2_tx_fin_time 0)))
 (let (($x219193 (= v_3_tx_fin_time ?x354474)))
 (let (($x296133 (= v_3_tx_time_15 (ite (>= 15 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_15))))
 (let (($x580853 (= v_3_tx_time_14 (ite (>= 14 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_14))))
 (let (($x47260 (= v_3_tx_time_13 (ite (>= 13 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_13))))
 (let (($x48041 (= v_3_tx_time_12 (ite (>= 12 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_12))))
 (let (($x395065 (= v_3_tx_time_11 (ite (>= 11 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_11))))
 (let (($x13986 (= v_3_tx_time_10 (ite (>= 10 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_10))))
 (let (($x122504 (= v_3_tx_time_09 (ite (>= 9 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_09))))
 (let (($x304700 (= v_3_tx_time_08 (ite (>= 8 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_08))))
 (let (($x32068 (= v_3_tx_time_07 (ite (>= 7 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_07))))
 (let (($x207480 (= v_3_tx_time_06 (ite (>= 6 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_06))))
 (let (($x11353 (= v_3_tx_time_05 (ite (>= 5 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_05))))
 (let (($x49687 (= v_3_tx_time_04 (ite (>= 4 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_04))))
 (let (($x64144 (= v_3_tx_time_03 (ite (>= 3 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_03))))
 (let (($x321343 (= v_3_tx_time_02 (ite (>= 2 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_02))))
 (let (($x83645 (= v_3_tx_time_01 (ite (>= 1 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_01))))
 (let (($x180571 (= v_3_tx_time_00 (ite (>= 0 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_00))))
 (let (($x139767 (= v_3_rto_base_ms v_2_rto_base_ms)))
 (let (($x157899 (= v_3_rtt_samples v_2_rtt_samples)))
 (let (($x108673 (= v_3_rtt_last_ms v_2_rtt_last_ms)))
 (let (($x121863 (not v_3_rtt_sample_was_ambiguous)))
 (let (($x75218 (not v_3_rtt_sample_used)))
 (let (($x304377 (not v_3_rtt_start_new)))
 (let (($x138364 (= v_3_rtt_remaining v_2_rtt_remaining)))
 (let (($x139110 (= v_3_rtt_end v_2_rtt_end)))
 (let (($x343626 (= v_3_rtt_start_ms v_2_rtt_start_ms)))
 (let (($x100963 (= v_3_rtt_sample_at_ms v_2_rtt_sample_at_ms)))
 (let ((?x39002 (+ (ubv_to_int (bvadd v_2_rtt_end (bvmul (_ bv4294967295 32) v_2_snd_una))) (* (- 1) v_2_rtt_remaining))))
 (let (($x208851 (ite $x36202 (or (and v_2_rtt_active (<= ?x39002 0)) v_2_rtt_ambiguous) v_2_rtt_ambiguous)))
 (let (($x135615 (= v_3_rtt_active v_2_rtt_active)))
 (let (($x453851 (= v_3_rtt_previous_measured v_2_rtt_previous_measured)))
 (let (($x95091 (= v_3_rtt_measured v_2_rtt_measured)))
 (let (($x490628 (= v_3_rtt_previous_var v_2_rtt_previous_var)))
 (let (($x92523 (= v_3_rtt_previous_srtt v_2_rtt_previous_srtt)))
 (let (($x56503 (= v_3_rtt_error_ms v_2_rtt_error_ms)))
 (let (($x87374 (= v_3_rttvar_ms v_2_rttvar_ms)))
 (let (($x127198 (= v_3_srtt_ms v_2_srtt_ms)))
 (let (($x15163 (= v_3_rx_fin_consumed v_2_rx_fin_consumed)))
 (let (($x311433 (= v_3_rx_fin_done v_2_rx_fin_done)))
 (let (($x140475 (= v_3_rx_fin_offset v_2_rx_fin_offset)))
 (let (($x88491 (= v_3_rx_fin_seq v_2_rx_fin_seq)))
 (let (($x66523 (= v_3_rx_fin_pending v_2_rx_fin_pending)))
 (let (($x184472 (= v_3_fin_acknowledged v_2_fin_acknowledged)))
 (let (($x253458 (= v_3_fin_seq v_2_fin_seq)))
 (let (($x304352 (= v_3_fin_sent v_2_fin_sent)))
 (let (($x108855 (= v_3_fin_requested v_2_fin_requested)))
 (let (($x176223 (= v_3_ack_window_update v_2_ack_window_update)))
 (let (($x395011 (= v_3_ack_advance v_2_ack_advance)))
 (let (($x57917 (= v_3_ack_is_future v_2_ack_is_future)))
 (let (($x115762 (= v_3_ack_is_new v_2_ack_is_new)))
 (let (($x171778 (= v_3_ack_delta v_2_ack_delta)))
 (let (($x119449 (= v_3_seg_acceptable v_2_seg_acceptable)))
 (let (($x119967 (= v_3_rx_acceptable v_2_rx_acceptable)))
 (let (($x313943 (= v_3_rx_advance v_2_rx_advance)))
 (let (($x114876 (= v_3_rx_slot_15 v_2_rx_slot_15)))
 (let (($x284004 (= v_3_rx_slot_14 v_2_rx_slot_14)))
 (let (($x346842 (= v_3_rx_slot_13 v_2_rx_slot_13)))
 (let (($x297333 (= v_3_rx_slot_12 v_2_rx_slot_12)))
 (let (($x240618 (= v_3_rx_slot_11 v_2_rx_slot_11)))
 (let (($x109707 (= v_3_rx_slot_10 v_2_rx_slot_10)))
 (let (($x59879 (= v_3_rx_slot_09 v_2_rx_slot_09)))
 (let (($x148187 (= v_3_rx_slot_08 v_2_rx_slot_08)))
 (let (($x88671 (= v_3_rx_slot_07 v_2_rx_slot_07)))
 (let (($x153055 (= v_3_rx_slot_06 v_2_rx_slot_06)))
 (let (($x116271 (= v_3_rx_slot_05 v_2_rx_slot_05)))
 (let (($x346075 (= v_3_rx_slot_04 v_2_rx_slot_04)))
 (let (($x202834 (= v_3_rx_slot_03 v_2_rx_slot_03)))
 (let (($x14147 (= v_3_rx_slot_02 v_2_rx_slot_02)))
 (let (($x135973 (= v_3_rx_slot_01 v_2_rx_slot_01)))
 (let (($x29828 (= v_3_rx_slot_00 v_2_rx_slot_00)))
 (let (($x372237 (= v_3_rx_chunk v_2_rx_chunk)))
 (let (($x791262 (= v_3_take v_2_take)))
 (let (($x188645 (= v_3_snd_wl2 v_2_snd_wl2)))
 (let (($x66588 (= v_3_snd_wl1 v_2_snd_wl1)))
 (let (($x37208 (= v_3_snd_wnd v_2_snd_wnd)))
 (let (($x194423 (= v_3_rcv_buf v_2_rcv_buf)))
 (let (($x115438 (= v_3_rtx_buf v_2_rtx_buf)))
 (let (($x186031 (= v_3_snd_buf v_2_snd_buf)))
 (let (($x54092 (= v_3_local_window v_2_local_window)))
 (let (($x317010 (= v_3_msl_ms v_2_msl_ms)))
 (let (($x122220 (= v_3_user_timeout_ms v_2_user_timeout_ms)))
 (let (($x312741 (= v_3_active_open v_2_active_open)))
 (let (($x343672 (= v_3_tx_flags v_2_tx_flags)))
 (let (($x127867 (= v_3_tx_ack v_2_tx_ack)))
 (let (($x174491 (= v_3_tx_seq v_2_tx_seq)))
 (let (($x167348 (= v_3_rcv_nxt v_2_rcv_nxt)))
 (let (($x341990 (= v_3_snd_nxt v_2_snd_nxt)))
 (let (($x29514 (= v_3_snd_una v_2_snd_una)))
 (let (($x346061 (= v_3_irs v_2_irs)))
 (let (($x598634 (= v_3_iss v_2_iss)))
 (let (($x24585 (= 3 state_3)))
 (let (($x54643 (= state_2 3)))
 (and $x54643 active_2_rtx (= 1900 due_2_rtx) (or (not active_2_user) (<= due_2_rtx due_2_user)) (or (not active_2_time_wait) (<= due_2_rtx due_2_time_wait)) $x24585 $x598634 $x346061 $x29514 $x341990 $x167348 $x174491 $x127867 $x343672 (= v_3_rto_ms ?x31457) (= v_3_retries (ite $x36202 (+ 1 v_2_retries) v_2_retries)) $x312741 $x122220 $x317010 $x54092 $x186031 $x115438 $x194423 $x37208 $x66588 $x188645 $x791262 $x372237 $x29828 $x135973 $x14147 $x202834 $x346075 $x116271 $x153055 $x88671 $x148187 $x59879 $x109707 $x240618 $x297333 $x346842 $x284004 $x114876 $x313943 $x119967 $x119449 $x171778 $x115762 $x57917 $x395011 $x176223 $x108855 $x304352 $x253458 $x184472 $x66523 $x88491 $x140475 $x311433 $x15163 $x127198 $x87374 $x56503 $x92523 $x490628 $x95091 $x453851 $x135615 (= v_3_rtt_ambiguous $x208851) $x100963 $x343626 $x139110 $x138364 $x304377 $x75218 $x121863 $x108673 $x157899 $x139767 $x180571 $x83645 $x321343 $x64144 $x49687 $x11353 $x207480 $x32068 $x304700 $x122504 $x13986 $x395065 $x48041 $x47260 $x580853 $x296133 $x219193 (= v_3_tx_emit_count (ite $x36202 1 0)) $x290834 $x301838 (= v_3_tx_retransmitted $x36202) $x489570 $x281997 $x192245 (not (= $x36202 v_3_tx_waiting)) (= v_3_tx_syn_time ?x272753) v_3_tx_syn_pending (= v_3_syn_timeout_eligible $x36202) active_3_rtx $x304456 $x195028 (= due_3_rtx (+ 1900 (ite $x36202 ?x268174 (+ (- 1900) ?x272753 ?x31457)))) $x211203 $x306103)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
