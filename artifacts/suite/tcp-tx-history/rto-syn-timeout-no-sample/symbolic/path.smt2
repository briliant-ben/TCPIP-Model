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
 (let (($x202832 (= due_1_time_wait due_0_time_wait)))
 (let (($x11521 (= due_1_user 30000)))
 (let (($x220935 (= due_1_rtx 1000)))
 (let (($x314545 (not active_1_time_wait)))
 (let (($x362862 (not v_1_tx_waiting)))
 (let (($x377602 (not v_1_tx_is_fin)))
 (let (($x127224 (= v_1_tx_previous_rto 1000)))
 (let (($x75526 (= v_1_tx_elapsed 0)))
 (let (($x162488 (not v_1_tx_retransmitted)))
 (let (($x352612 (= v_1_tx_max_previous 0)))
 (let (($x374691 (= v_1_tx_eligible 0)))
 (let (($x338456 (= v_1_tx_emit_count 0)))
 (let (($x84160 (= v_1_tx_fin_time 0)))
 (let (($x166849 (= v_1_tx_time_15 0)))
 (let (($x173248 (= v_1_tx_time_14 0)))
 (let (($x326836 (= v_1_tx_time_13 0)))
 (let (($x336744 (= v_1_tx_time_12 0)))
 (let (($x308723 (= v_1_tx_time_11 0)))
 (let (($x340887 (= v_1_tx_time_10 0)))
 (let (($x375472 (= v_1_tx_time_09 0)))
 (let (($x372096 (= v_1_tx_time_08 0)))
 (let (($x56614 (= v_1_tx_time_07 0)))
 (let (($x159017 (= v_1_tx_time_06 0)))
 (let (($x6476 (= v_1_tx_time_05 0)))
 (let (($x129884 (= v_1_tx_time_04 0)))
 (let (($x181678 (= v_1_tx_time_03 0)))
 (let (($x183112 (= v_1_tx_time_02 0)))
 (let (($x471513 (= v_1_tx_time_01 0)))
 (let (($x374834 (= v_1_tx_time_00 0)))
 (let (($x308608 (= v_1_rto_base_ms 1000)))
 (let (($x360771 (= v_1_rtt_samples 0)))
 (let (($x317286 (= v_1_rtt_last_ms 0)))
 (let (($x221826 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x139946 (not v_1_rtt_sample_used)))
 (let (($x139652 (= v_1_rtt_remaining 1)))
 (let (($x186155 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x31455 (= v_1_rtt_start_ms 0)))
 (let (($x131587 (= v_1_rtt_sample_at_ms 0)))
 (let (($x284182 (not v_1_rtt_ambiguous)))
 (let (($x338871 (not v_1_rtt_previous_measured)))
 (let (($x83914 (not v_1_rtt_measured)))
 (let (($x303435 (= v_1_rtt_previous_var 0.0)))
 (let (($x379847 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x231226 (= v_1_rtt_error_ms 0.0)))
 (let (($x129250 (= v_1_rttvar_ms 0.0)))
 (let (($x365250 (= v_1_srtt_ms 0.0)))
 (let (($x154972 (not v_1_rx_fin_consumed)))
 (let (($x21797 (not v_1_rx_fin_done)))
 (let (($x362298 (= v_1_rx_fin_offset 0)))
 (let (($x377290 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x386070 (not v_1_rx_fin_pending)))
 (let (($x393111 (not v_1_fin_acknowledged)))
 (let (($x226204 (= v_1_fin_seq (_ bv0 32))))
 (let (($x361117 (not v_1_fin_sent)))
 (let (($x53402 (not v_1_fin_requested)))
 (let (($x2055 (not v_1_ack_window_update)))
 (let (($x5131 (not v_1_ack_advance)))
 (let (($x24383 (not v_1_ack_is_future)))
 (let (($x168453 (not v_1_ack_is_new)))
 (let (($x377579 (= v_1_ack_delta 0)))
 (let (($x11371 (not v_1_seg_acceptable)))
 (let (($x338742 (not v_1_rx_acceptable)))
 (let (($x159819 (= v_1_rx_advance 0)))
 (let (($x69131 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x175022 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x329446 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x325556 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x365417 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x52871 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x161225 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x339259 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x377585 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x377026 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x136752 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x404266 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x60448 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x206916 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x160084 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x188946 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x287804 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x93437 (= v_1_take 0)))
 (let (($x281287 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x67480 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x364998 (= v_1_snd_wnd 8)))
 (let (($x369773 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x437594 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x42585 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x69228 (= v_1_local_window 16)))
 (let (($x158161 (= v_1_msl_ms 60000)))
 (let (($x356420 (= v_1_user_timeout_ms 30000)))
 (let (($x349116 (= 0 v_1_retries)))
 (let (($x77464 (= 1000 v_1_rto_ms)))
 (let (($x413887 (= v_1_tx_flags "S")))
 (let (($x306412 (= v_1_tx_ack (_ bv0 32))))
 (let (($x126662 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x131177 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x173286 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x287100 (= v_1_snd_una (_ bv1000 32))))
 (let (($x38532 (= v_1_irs (_ bv0 32))))
 (let (($x58760 (= v_1_iss (_ bv1000 32))))
 (let (($x359875 (= 2 state_1)))
 (let (($x377525 (not active_0_time_wait)))
 (let (($x341117 (or $x377525 (not (<= due_0_time_wait 0)))))
 (let (($x312101 (not active_0_user)))
 (let (($x218786 (or $x312101 (not (<= due_0_user 0)))))
 (let (($x33247 (not active_0_rtx)))
 (let (($x128346 (or $x33247 (not (<= due_0_rtx 0)))))
 (let (($x281518 (= state_0 0)))
 (and $x281518 (>= 0 now_0) $x128346 $x218786 $x341117 $x359875 $x58760 $x38532 $x287100 $x173286 $x131177 $x126662 $x306412 $x413887 $x77464 $x349116 v_1_active_open $x356420 $x158161 $x69228 $x42585 $x437594 $x369773 $x364998 $x67480 $x281287 $x93437 $x287804 $x188946 $x160084 $x206916 $x60448 $x404266 $x136752 $x377026 $x377585 $x339259 $x161225 $x52871 $x365417 $x325556 $x329446 $x175022 $x69131 $x159819 $x338742 $x11371 $x377579 $x168453 $x24383 $x5131 $x2055 $x53402 $x361117 $x226204 $x393111 $x386070 $x377290 $x362298 $x21797 $x154972 $x365250 $x129250 $x231226 $x379847 $x303435 $x83914 $x338871 v_1_rtt_active $x284182 $x131587 $x31455 $x186155 $x139652 v_1_rtt_start_new $x139946 $x221826 $x317286 $x360771 $x308608 $x374834 $x471513 $x183112 $x181678 $x129884 $x6476 $x159017 $x56614 $x372096 $x375472 $x340887 $x308723 $x336744 $x326836 $x173248 $x166849 $x84160 $x338456 $x374691 $x352612 $x162488 $x75526 $x127224 $x377602 $x362862 active_1_rtx active_1_user $x314545 $x220935 $x11521 $x202832))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x331160 (= due_2_time_wait due_1_time_wait)))
 (let (($x14879 (= due_2_user due_1_user)))
 (let (($x361846 (= due_2_rtx (+ 1000 (ite (>= v_1_rto_ms 30000) 60000 (* 2 v_1_rto_ms))))))
 (let (($x247412 (= active_2_time_wait active_1_time_wait)))
 (let (($x255589 (= active_2_user active_1_user)))
 (let (($x358858 (not v_2_tx_waiting)))
 (let (($x121296 (= v_2_tx_is_fin v_1_tx_is_fin)))
 (let (($x177732 (= v_2_tx_previous_rto v_1_tx_previous_rto)))
 (let (($x3119 (= v_2_tx_elapsed v_1_tx_elapsed)))
 (let (($x156621 (not v_2_tx_retransmitted)))
 (let (($x127946 (= v_2_tx_max_previous v_1_tx_max_previous)))
 (let (($x157316 (= v_2_tx_eligible v_1_tx_eligible)))
 (let (($x167484 (= v_2_tx_emit_count v_1_tx_emit_count)))
 (let ((?x393051 (ite (and v_1_fin_sent (not v_1_fin_acknowledged)) v_1_tx_fin_time 0)))
 (let (($x102317 (= v_2_tx_fin_time ?x393051)))
 (let (($x10365 (= v_2_tx_time_15 (ite (>= 15 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_15))))
 (let (($x359281 (= v_2_tx_time_14 (ite (>= 14 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_14))))
 (let (($x359675 (= v_2_tx_time_13 (ite (>= 13 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_13))))
 (let (($x159483 (= v_2_tx_time_12 (ite (>= 12 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_12))))
 (let (($x221118 (= v_2_tx_time_11 (ite (>= 11 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_11))))
 (let (($x316606 (= v_2_tx_time_10 (ite (>= 10 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_10))))
 (let (($x301765 (= v_2_tx_time_09 (ite (>= 9 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_09))))
 (let (($x135234 (= v_2_tx_time_08 (ite (>= 8 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_08))))
 (let (($x120628 (= v_2_tx_time_07 (ite (>= 7 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_07))))
 (let (($x336966 (= v_2_tx_time_06 (ite (>= 6 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_06))))
 (let (($x352899 (= v_2_tx_time_05 (ite (>= 5 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_05))))
 (let (($x182467 (= v_2_tx_time_04 (ite (>= 4 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_04))))
 (let (($x383441 (= v_2_tx_time_03 (ite (>= 3 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_03))))
 (let (($x141720 (= v_2_tx_time_02 (ite (>= 2 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_02))))
 (let (($x25139 (= v_2_tx_time_01 (ite (>= 1 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_01))))
 (let (($x241820 (= v_2_tx_time_00 (ite (>= 0 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_00))))
 (let (($x356197 (= v_2_rto_base_ms v_1_rto_base_ms)))
 (let (($x377289 (= v_2_rtt_samples v_1_rtt_samples)))
 (let (($x236508 (= v_2_rtt_last_ms v_1_rtt_last_ms)))
 (let (($x319872 (not v_2_rtt_sample_was_ambiguous)))
 (let (($x486800 (not v_2_rtt_sample_used)))
 (let (($x382205 (not v_2_rtt_start_new)))
 (let (($x130111 (= v_2_rtt_remaining v_1_rtt_remaining)))
 (let (($x371769 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x69846 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let (($x61466 (= v_2_rtt_sample_at_ms v_1_rtt_sample_at_ms)))
 (let ((?x352949 (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let (($x9011 (and v_1_rtt_active (<= (+ ?x352949 (* (- 1) v_1_rtt_remaining)) 0))))
 (let (($x77053 (= v_2_rtt_active v_1_rtt_active)))
 (let (($x359879 (= v_2_rtt_previous_measured v_1_rtt_previous_measured)))
 (let (($x131424 (= v_2_rtt_measured v_1_rtt_measured)))
 (let (($x382005 (= v_2_rtt_previous_var v_1_rtt_previous_var)))
 (let (($x332963 (= v_2_rtt_previous_srtt v_1_rtt_previous_srtt)))
 (let (($x163688 (= v_2_rtt_error_ms v_1_rtt_error_ms)))
 (let (($x71676 (= v_2_rttvar_ms v_1_rttvar_ms)))
 (let (($x330032 (= v_2_srtt_ms v_1_srtt_ms)))
 (let (($x370458 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x72486 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x146395 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x136941 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x178097 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x164341 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x354467 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x161836 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x381094 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x179393 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x19667 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x287308 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x178460 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x176714 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x332590 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x45831 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x74447 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x128880 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x394053 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x393931 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x44747 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x130732 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x312425 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x374641 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x164669 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x348437 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x42991 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x143723 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x127440 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x391066 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x132338 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x29827 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x344544 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x366062 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x313874 (= v_2_take v_1_take)))
 (let (($x362335 (= v_2_snd_wl2 v_1_snd_wl2)))
 (let (($x26103 (= v_2_snd_wl1 v_1_snd_wl1)))
 (let (($x371883 (= v_2_snd_wnd v_1_snd_wnd)))
 (let (($x356427 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x137755 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x138261 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x127802 (= v_2_local_window v_1_local_window)))
 (let (($x351331 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x286964 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x340426 (= v_2_active_open v_1_active_open)))
 (let ((?x95432 (ite (>= v_1_rto_ms 30000) 60000 (* 2 v_1_rto_ms))))
 (let (($x15229 (= v_2_rto_ms ?x95432)))
 (let (($x26074 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x138822 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x372590 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x333033 (= v_2_rcv_nxt v_1_rcv_nxt)))
 (let (($x55546 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x91402 (= v_2_snd_una v_1_snd_una)))
 (let (($x438214 (= v_2_irs v_1_irs)))
 (let (($x17082 (= v_2_iss v_1_iss)))
 (let (($x128965 (= 2 state_2)))
 (let (($x153545 (= state_1 2)))
 (and $x153545 active_1_rtx (= 1000 due_1_rtx) (or (not active_1_user) (<= due_1_rtx due_1_user)) (or (not active_1_time_wait) (<= due_1_rtx due_1_time_wait)) $x128965 $x17082 $x438214 $x91402 $x55546 $x333033 $x372590 $x138822 $x26074 $x15229 (= v_2_retries (+ 1 v_1_retries)) $x340426 $x286964 $x351331 $x127802 $x138261 $x137755 $x356427 $x371883 $x26103 $x362335 $x313874 $x366062 $x344544 $x29827 $x132338 $x391066 $x127440 $x143723 $x42991 $x348437 $x164669 $x374641 $x312425 $x130732 $x44747 $x393931 $x394053 $x128880 $x74447 $x45831 $x332590 $x176714 $x178460 $x287308 $x19667 $x179393 $x381094 $x161836 $x354467 $x164341 $x178097 $x136941 $x146395 $x72486 $x370458 $x330032 $x71676 $x163688 $x332963 $x382005 $x131424 $x359879 $x77053 (= v_2_rtt_ambiguous (or $x9011 v_1_rtt_ambiguous)) $x61466 $x69846 $x371769 $x130111 $x382205 $x486800 $x319872 $x236508 $x377289 $x356197 $x241820 $x25139 $x141720 $x383441 $x182467 $x352899 $x336966 $x120628 $x135234 $x301765 $x316606 $x221118 $x159483 $x359675 $x359281 $x10365 $x102317 $x167484 $x157316 $x127946 $x156621 $x3119 $x177732 $x121296 $x358858 active_2_rtx $x255589 $x247412 $x361846 $x14879 $x331160))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 (let (($x390608 (= due_3_time_wait due_2_time_wait)))
 (let (($x22227 (= due_3_user due_2_user)))
 (let (($x342596 (= due_3_rtx due_2_rtx)))
 (let (($x184373 (= active_3_time_wait active_2_time_wait)))
 (let (($x373574 (not active_3_user)))
 (let (($x31207 (not active_3_rtx)))
 (let (($x31152 (not v_3_tx_waiting)))
 (let (($x71383 (= v_3_tx_is_fin v_2_tx_is_fin)))
 (let (($x32607 (= v_3_tx_previous_rto v_2_tx_previous_rto)))
 (let (($x129447 (= v_3_tx_elapsed v_2_tx_elapsed)))
 (let (($x300270 (not v_3_tx_retransmitted)))
 (let (($x176945 (= v_3_tx_max_previous v_2_tx_max_previous)))
 (let (($x376081 (= v_3_tx_eligible v_2_tx_eligible)))
 (let (($x1233 (= v_3_tx_emit_count v_2_tx_emit_count)))
 (let ((?x363572 (ite (and v_2_fin_sent (not v_2_fin_acknowledged)) v_2_tx_fin_time 0)))
 (let (($x375375 (= v_3_tx_fin_time ?x363572)))
 (let (($x359170 (= v_3_tx_time_15 (ite (>= 15 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_15))))
 (let (($x143035 (= v_3_tx_time_14 (ite (>= 14 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_14))))
 (let (($x301527 (= v_3_tx_time_13 (ite (>= 13 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_13))))
 (let (($x33473 (= v_3_tx_time_12 (ite (>= 12 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_12))))
 (let (($x43618 (= v_3_tx_time_11 (ite (>= 11 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_11))))
 (let (($x121741 (= v_3_tx_time_10 (ite (>= 10 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_10))))
 (let (($x313535 (= v_3_tx_time_09 (ite (>= 9 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_09))))
 (let (($x361068 (= v_3_tx_time_08 (ite (>= 8 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_08))))
 (let (($x266298 (= v_3_tx_time_07 (ite (>= 7 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_07))))
 (let (($x12753 (= v_3_tx_time_06 (ite (>= 6 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_06))))
 (let (($x361269 (= v_3_tx_time_05 (ite (>= 5 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_05))))
 (let (($x70684 (= v_3_tx_time_04 (ite (>= 4 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_04))))
 (let (($x96485 (= v_3_tx_time_03 (ite (>= 3 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_03))))
 (let (($x189829 (= v_3_tx_time_02 (ite (>= 2 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_02))))
 (let (($x55947 (= v_3_tx_time_01 (ite (>= 1 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_01))))
 (let (($x77419 (= v_3_tx_time_00 (ite (>= 0 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_00))))
 (let ((?x8567 (+ 1010 (* (- 1) v_2_rtt_start_ms))))
 (let (($x59955 (not v_2_rtt_ambiguous)))
 (let ((?x248226 (ubv_to_int (bvadd v_2_rtt_end (bvmul (_ bv4294967295 32) v_2_snd_una)))))
 (let ((?x380771 (ubv_to_int (bvadd (_ bv1001 32) (bvmul (_ bv4294967295 32) v_2_snd_una)))))
 (let (($x365391 (>= ?x380771 ?x248226)))
 (let (($x406040 (and v_2_rtt_active $x365391 $x59955)))
 (let ((?x362790 (ite $x406040 ?x8567 v_2_rtt_last_ms)))
 (let ((?x40870 (to_real ?x362790)))
 (let ((?x307545 (+ v_2_srtt_ms (* (- 1.0) ?x40870))))
 (let ((?x38268 (ite $x406040 (ite (>= ?x307545 0.0) ?x307545 (+ (* (- 1.0) v_2_srtt_ms) ?x40870)) v_2_rtt_error_ms)))
 (let ((?x438798 (* (/ 3.0 4.0) v_2_rttvar_ms)))
 (let ((?x118014 (ite $x406040 (ite v_2_rtt_measured (+ ?x438798 (* (/ 1.0 4.0) ?x38268)) (* (/ 1.0 2.0) ?x40870)) v_2_rttvar_ms)))
 (let ((?x210019 (ite v_2_rtt_measured (+ (* (/ 7.0 8.0) v_2_srtt_ms) (* (/ 1.0 8.0) ?x40870)) ?x40870)))
 (let ((?x359608 (ite $x406040 ?x210019 v_2_srtt_ms)))
 (let ((?x175901 (+ (* (- 1.0) ?x359608) (* (- 1.0) (ite (<= ?x118014 (/ 1.0 4.0)) 1.0 (* 4.0 ?x118014))))))
 (let ((?x372851 (to_int ?x175901)))
 (let ((?x8727 (ite (<= ?x372851 (- 1000)) (* (- 1) ?x372851) 1000)))
 (let (($x243080 (= v_3_rto_base_ms (ite $x406040 (ite (<= 60000 ?x8727) 60000 ?x8727) v_2_rto_base_ms))))
 (let (($x302932 (= v_3_rtt_sample_was_ambiguous (and v_2_rtt_active v_2_rtt_ambiguous))))
 (let (($x126530 (not v_3_rtt_start_new)))
 (let ((?x133084 (* (- 1) ?x380771)))
 (let ((?x32912 (+ ?x248226 ?x133084)))
 (let ((?x370992 (ite (and v_2_rtt_active (not (<= v_2_rtt_remaining ?x32912))) ?x32912 v_2_rtt_remaining)))
 (let (($x441036 (and v_2_rtt_active $x365391)))
 (let (($x45206 (= v_3_rtt_end v_2_rtt_end)))
 (let (($x246210 (= v_3_rtt_start_ms v_2_rtt_start_ms)))
 (let (($x163683 (= v_3_rtt_previous_measured (ite $x406040 v_2_rtt_measured v_2_rtt_previous_measured))))
 (let (($x344566 (= v_3_rtt_previous_var (ite $x406040 v_2_rttvar_ms v_2_rtt_previous_var))))
 (let (($x330448 (= v_3_rtt_previous_srtt (ite $x406040 v_2_srtt_ms v_2_rtt_previous_srtt))))
 (let (($x238367 (= v_3_rx_fin_consumed v_2_rx_fin_consumed)))
 (let (($x281526 (= v_3_rx_fin_done v_2_rx_fin_done)))
 (let (($x60990 (= v_3_rx_fin_offset v_2_rx_fin_offset)))
 (let (($x371986 (= v_3_rx_fin_seq v_2_rx_fin_seq)))
 (let (($x240030 (= v_3_rx_fin_pending v_2_rx_fin_pending)))
 (let (($x33213 (= v_3_fin_acknowledged v_2_fin_acknowledged)))
 (let (($x80195 (= v_3_fin_seq v_2_fin_seq)))
 (let (($x76188 (= v_3_fin_sent v_2_fin_sent)))
 (let (($x166351 (= v_3_fin_requested v_2_fin_requested)))
 (let (($x19781 (= v_3_ack_window_update v_2_ack_window_update)))
 (let (($x7430 (= v_3_ack_advance v_2_ack_advance)))
 (let (($x31869 (= v_3_ack_is_future v_2_ack_is_future)))
 (let (($x140742 (= v_3_ack_is_new v_2_ack_is_new)))
 (let (($x383200 (= v_3_ack_delta v_2_ack_delta)))
 (let (($x375295 (= v_3_seg_acceptable v_2_seg_acceptable)))
 (let (($x372989 (= v_3_rx_acceptable v_2_rx_acceptable)))
 (let (($x361381 (= v_3_rx_advance v_2_rx_advance)))
 (let (($x379383 (= v_3_rx_slot_15 v_2_rx_slot_15)))
 (let (($x369735 (= v_3_rx_slot_14 v_2_rx_slot_14)))
 (let (($x329011 (= v_3_rx_slot_13 v_2_rx_slot_13)))
 (let (($x244149 (= v_3_rx_slot_12 v_2_rx_slot_12)))
 (let (($x377747 (= v_3_rx_slot_11 v_2_rx_slot_11)))
 (let (($x130917 (= v_3_rx_slot_10 v_2_rx_slot_10)))
 (let (($x372327 (= v_3_rx_slot_09 v_2_rx_slot_09)))
 (let (($x136015 (= v_3_rx_slot_08 v_2_rx_slot_08)))
 (let (($x70087 (= v_3_rx_slot_07 v_2_rx_slot_07)))
 (let (($x5497 (= v_3_rx_slot_06 v_2_rx_slot_06)))
 (let (($x24718 (= v_3_rx_slot_05 v_2_rx_slot_05)))
 (let (($x59421 (= v_3_rx_slot_04 v_2_rx_slot_04)))
 (let (($x436984 (= v_3_rx_slot_03 v_2_rx_slot_03)))
 (let (($x91201 (= v_3_rx_slot_02 v_2_rx_slot_02)))
 (let (($x62859 (= v_3_rx_slot_01 v_2_rx_slot_01)))
 (let (($x374950 (= v_3_rx_slot_00 v_2_rx_slot_00)))
 (let (($x56206 (= v_3_rx_chunk v_2_rx_chunk)))
 (let (($x160211 (= v_3_take v_2_take)))
 (let (($x285206 (= v_3_snd_wl2 (_ bv1001 32))))
 (let (($x63726 (= v_3_snd_wl1 (_ bv9000 32))))
 (let (($x50608 (= v_3_snd_wnd 16)))
 (let (($x15190 (= v_3_rcv_buf v_2_rcv_buf)))
 (let (($x252996 (= v_3_rtx_buf v_2_rtx_buf)))
 (let (($x439912 (= v_3_snd_buf v_2_snd_buf)))
 (let (($x338586 (= v_3_local_window v_2_local_window)))
 (let (($x374855 (= v_3_msl_ms v_2_msl_ms)))
 (let (($x39939 (= v_3_user_timeout_ms v_2_user_timeout_ms)))
 (let (($x371649 (= v_3_active_open v_2_active_open)))
 (let (($x381729 (= v_3_retries v_2_retries)))
 (let (($x341350 (= 3000 v_3_rto_ms)))
 (let (($x311922 (= v_3_tx_flags v_2_tx_flags)))
 (let (($x371109 (= v_3_tx_ack v_2_tx_ack)))
 (let (($x131108 (= v_3_tx_seq v_2_tx_seq)))
 (let (($x371848 (= v_3_rcv_nxt (_ bv9001 32))))
 (let (($x138386 (= v_3_snd_nxt v_2_snd_nxt)))
 (let (($x43075 (= v_3_snd_una (_ bv1001 32))))
 (let (($x155905 (= v_3_irs (_ bv9000 32))))
 (let (($x374198 (= v_3_iss v_2_iss)))
 (let (($x78984 (= 4 state_3)))
 (let (($x43002 (or (not active_2_time_wait) (not (<= due_2_time_wait 1010)))))
 (let (($x361745 (or (not active_2_user) (not (<= due_2_user 1010)))))
 (let (($x35573 (or (not active_2_rtx) (not (<= due_2_rtx 1010)))))
 (let (($x318427 (= 1 v_2_retries)))
 (let (($x357311 (= v_2_snd_nxt (_ bv1001 32))))
 (let (($x365617 (= state_2 2)))
 (and $x365617 $x357311 $x318427 $x35573 $x361745 $x43002 $x78984 $x374198 $x155905 $x43075 $x138386 $x371848 $x131108 $x371109 $x311922 $x341350 $x381729 $x371649 $x39939 $x374855 $x338586 $x439912 $x252996 $x15190 $x50608 $x63726 $x285206 $x160211 $x56206 $x374950 $x62859 $x91201 $x436984 $x59421 $x24718 $x5497 $x70087 $x136015 $x372327 $x130917 $x377747 $x244149 $x329011 $x369735 $x379383 $x361381 $x372989 $x375295 $x383200 $x140742 $x31869 $x7430 $x19781 $x166351 $x76188 $x80195 $x33213 $x240030 $x371986 $x60990 $x281526 $x238367 (= v_3_srtt_ms ?x359608) (= v_3_rttvar_ms ?x118014) (= v_3_rtt_error_ms ?x38268) $x330448 $x344566 (= v_3_rtt_measured (or v_2_rtt_measured $x406040)) $x163683 (= v_3_rtt_active (and v_2_rtt_active (not $x441036))) (= v_3_rtt_ambiguous (and (not $x441036) v_2_rtt_ambiguous)) (= v_3_rtt_sample_at_ms (ite $x406040 1010 v_2_rtt_sample_at_ms)) $x246210 $x45206 (= v_3_rtt_remaining (ite $x441036 0 ?x370992)) $x126530 (= v_3_rtt_sample_used $x406040) $x302932 (= v_3_rtt_last_ms ?x362790) (= v_3_rtt_samples (+ v_2_rtt_samples (ite $x406040 1 0))) $x243080 $x77419 $x55947 $x189829 $x96485 $x70684 $x361269 $x12753 $x266298 $x361068 $x313535 $x121741 $x43618 $x33473 $x301527 $x143035 $x359170 $x375375 $x1233 $x376081 $x176945 $x300270 $x129447 $x32607 $x71383 $x31152 $x31207 $x373574 $x184373 $x342596 $x22227 $x390608)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
