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
 (let (($x17393 (= due_1_time_wait due_0_time_wait)))
 (let (($x299458 (= due_1_user 30000)))
 (let (($x219604 (= due_1_rtx 1000)))
 (let (($x298141 (not active_1_time_wait)))
 (let (($x26518 (not v_1_tx_waiting)))
 (let (($x37405 (not v_1_tx_is_fin)))
 (let (($x71451 (= v_1_tx_previous_rto 1000)))
 (let (($x20252 (= v_1_tx_elapsed 0)))
 (let (($x152140 (not v_1_tx_retransmitted)))
 (let (($x308061 (= v_1_tx_max_previous 0)))
 (let (($x148347 (= v_1_tx_eligible 0)))
 (let (($x14973 (= v_1_tx_emit_count 0)))
 (let (($x258044 (= v_1_tx_fin_time 0)))
 (let (($x155992 (= v_1_tx_time_15 0)))
 (let (($x58306 (= v_1_tx_time_14 0)))
 (let (($x44347 (= v_1_tx_time_13 0)))
 (let (($x171488 (= v_1_tx_time_12 0)))
 (let (($x307983 (= v_1_tx_time_11 0)))
 (let (($x138533 (= v_1_tx_time_10 0)))
 (let (($x307911 (= v_1_tx_time_09 0)))
 (let (($x51238 (= v_1_tx_time_08 0)))
 (let (($x33043 (= v_1_tx_time_07 0)))
 (let (($x177245 (= v_1_tx_time_06 0)))
 (let (($x290237 (= v_1_tx_time_05 0)))
 (let (($x298416 (= v_1_tx_time_04 0)))
 (let (($x298801 (= v_1_tx_time_03 0)))
 (let (($x6240 (= v_1_tx_time_02 0)))
 (let (($x158403 (= v_1_tx_time_01 0)))
 (let (($x84109 (= v_1_tx_time_00 0)))
 (let (($x308404 (= v_1_rto_base_ms 1000)))
 (let (($x228035 (= v_1_rtt_samples 0)))
 (let (($x316827 (= v_1_rtt_last_ms 0)))
 (let (($x301460 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x64200 (not v_1_rtt_sample_used)))
 (let (($x89994 (= v_1_rtt_remaining 1)))
 (let (($x308607 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x69888 (= v_1_rtt_start_ms 0)))
 (let (($x210061 (= v_1_rtt_sample_at_ms 0)))
 (let (($x41558 (not v_1_rtt_ambiguous)))
 (let (($x155642 (not v_1_rtt_previous_measured)))
 (let (($x314789 (not v_1_rtt_measured)))
 (let (($x312893 (= v_1_rtt_previous_var 0.0)))
 (let (($x4205 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x44639 (= v_1_rtt_error_ms 0.0)))
 (let (($x50662 (= v_1_rttvar_ms 0.0)))
 (let (($x319381 (= v_1_srtt_ms 0.0)))
 (let (($x14380 (not v_1_rx_fin_consumed)))
 (let (($x317649 (not v_1_rx_fin_done)))
 (let (($x209369 (= v_1_rx_fin_offset 0)))
 (let (($x308136 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x455876 (not v_1_rx_fin_pending)))
 (let (($x292884 (not v_1_fin_acknowledged)))
 (let (($x47754 (= v_1_fin_seq (_ bv0 32))))
 (let (($x298812 (not v_1_fin_sent)))
 (let (($x257678 (not v_1_fin_requested)))
 (let (($x113387 (not v_1_ack_window_update)))
 (let (($x173094 (not v_1_ack_advance)))
 (let (($x309230 (not v_1_ack_is_future)))
 (let (($x157539 (not v_1_ack_is_new)))
 (let (($x25500 (= v_1_ack_delta 0)))
 (let (($x304117 (not v_1_seg_acceptable)))
 (let (($x109705 (not v_1_rx_acceptable)))
 (let (($x17864 (= v_1_rx_advance 0)))
 (let (($x314622 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x315291 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x39919 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x12485 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x90427 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x293821 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x109686 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x297874 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x81853 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x309203 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x320532 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x8935 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x154059 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x40939 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x316469 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x301110 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x296925 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x344882 (= v_1_take 0)))
 (let (($x144742 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x175915 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x243885 (= v_1_snd_wnd 8)))
 (let (($x308239 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x44723 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x52477 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x166950 (= v_1_local_window 16)))
 (let (($x301044 (= v_1_msl_ms 60000)))
 (let (($x144414 (= v_1_user_timeout_ms 30000)))
 (let (($x300960 (= 0 v_1_retries)))
 (let (($x398914 (= 1000 v_1_rto_ms)))
 (let (($x33108 (= v_1_tx_flags "S")))
 (let (($x89406 (= v_1_tx_ack (_ bv0 32))))
 (let (($x307127 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x313297 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x88076 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x188494 (= v_1_snd_una (_ bv1000 32))))
 (let (($x64524 (= v_1_irs (_ bv0 32))))
 (let (($x95247 (= v_1_iss (_ bv1000 32))))
 (let (($x84963 (= 2 state_1)))
 (let (($x181259 (not active_0_time_wait)))
 (let (($x293287 (or $x181259 (not (<= due_0_time_wait 0)))))
 (let (($x294790 (not active_0_user)))
 (let (($x31674 (or $x294790 (not (<= due_0_user 0)))))
 (let (($x5353 (not active_0_rtx)))
 (let (($x37228 (or $x5353 (not (<= due_0_rtx 0)))))
 (let (($x36976 (= state_0 0)))
 (and $x36976 (>= 0 now_0) $x37228 $x31674 $x293287 $x84963 $x95247 $x64524 $x188494 $x88076 $x313297 $x307127 $x89406 $x33108 $x398914 $x300960 v_1_active_open $x144414 $x301044 $x166950 $x52477 $x44723 $x308239 $x243885 $x175915 $x144742 $x344882 $x296925 $x301110 $x316469 $x40939 $x154059 $x8935 $x320532 $x309203 $x81853 $x297874 $x109686 $x293821 $x90427 $x12485 $x39919 $x315291 $x314622 $x17864 $x109705 $x304117 $x25500 $x157539 $x309230 $x173094 $x113387 $x257678 $x298812 $x47754 $x292884 $x455876 $x308136 $x209369 $x317649 $x14380 $x319381 $x50662 $x44639 $x4205 $x312893 $x314789 $x155642 v_1_rtt_active $x41558 $x210061 $x69888 $x308607 $x89994 v_1_rtt_start_new $x64200 $x301460 $x316827 $x228035 $x308404 $x84109 $x158403 $x6240 $x298801 $x298416 $x290237 $x177245 $x33043 $x51238 $x307911 $x138533 $x307983 $x171488 $x44347 $x58306 $x155992 $x258044 $x14973 $x148347 $x308061 $x152140 $x20252 $x71451 $x37405 $x26518 active_1_rtx active_1_user $x298141 $x219604 $x299458 $x17393))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x44932 (= due_2_time_wait due_1_time_wait)))
 (let (($x137017 (= due_2_user due_1_user)))
 (let (($x85541 (= due_2_rtx (+ 1000 (ite (>= v_1_rto_ms 30000) 60000 (* 2 v_1_rto_ms))))))
 (let (($x160807 (= active_2_time_wait active_1_time_wait)))
 (let (($x70549 (= active_2_user active_1_user)))
 (let (($x155092 (not v_2_tx_waiting)))
 (let (($x121017 (= v_2_tx_is_fin v_1_tx_is_fin)))
 (let (($x155141 (= v_2_tx_previous_rto v_1_tx_previous_rto)))
 (let (($x164332 (= v_2_tx_elapsed v_1_tx_elapsed)))
 (let (($x153767 (not v_2_tx_retransmitted)))
 (let (($x305592 (= v_2_tx_max_previous v_1_tx_max_previous)))
 (let (($x173080 (= v_2_tx_eligible v_1_tx_eligible)))
 (let (($x310565 (= v_2_tx_emit_count v_1_tx_emit_count)))
 (let ((?x305439 (ite (and v_1_fin_sent (not v_1_fin_acknowledged)) v_1_tx_fin_time 0)))
 (let (($x235619 (= v_2_tx_fin_time ?x305439)))
 (let (($x31308 (= v_2_tx_time_15 (ite (>= 15 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_15))))
 (let (($x156161 (= v_2_tx_time_14 (ite (>= 14 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_14))))
 (let (($x154879 (= v_2_tx_time_13 (ite (>= 13 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_13))))
 (let (($x156379 (= v_2_tx_time_12 (ite (>= 12 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_12))))
 (let (($x395886 (= v_2_tx_time_11 (ite (>= 11 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_11))))
 (let (($x29434 (= v_2_tx_time_10 (ite (>= 10 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_10))))
 (let (($x77310 (= v_2_tx_time_09 (ite (>= 9 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_09))))
 (let (($x314696 (= v_2_tx_time_08 (ite (>= 8 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_08))))
 (let (($x52900 (= v_2_tx_time_07 (ite (>= 7 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_07))))
 (let (($x20191 (= v_2_tx_time_06 (ite (>= 6 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_06))))
 (let (($x147038 (= v_2_tx_time_05 (ite (>= 5 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_05))))
 (let (($x18414 (= v_2_tx_time_04 (ite (>= 4 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_04))))
 (let (($x102835 (= v_2_tx_time_03 (ite (>= 3 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_03))))
 (let (($x298577 (= v_2_tx_time_02 (ite (>= 2 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_02))))
 (let (($x215590 (= v_2_tx_time_01 (ite (>= 1 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_01))))
 (let (($x160963 (= v_2_tx_time_00 (ite (>= 0 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_00))))
 (let (($x308271 (= v_2_rto_base_ms v_1_rto_base_ms)))
 (let (($x301739 (= v_2_rtt_samples v_1_rtt_samples)))
 (let (($x290715 (= v_2_rtt_last_ms v_1_rtt_last_ms)))
 (let (($x270799 (not v_2_rtt_sample_was_ambiguous)))
 (let (($x26605 (not v_2_rtt_sample_used)))
 (let (($x305722 (not v_2_rtt_start_new)))
 (let (($x303010 (= v_2_rtt_remaining v_1_rtt_remaining)))
 (let (($x302535 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x119636 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let (($x195687 (= v_2_rtt_sample_at_ms v_1_rtt_sample_at_ms)))
 (let ((?x68081 (+ (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una))) (* (- 1) v_1_rtt_remaining))))
 (let (($x191881 (= v_2_rtt_ambiguous (or v_1_rtt_ambiguous (and v_1_rtt_active (<= ?x68081 0))))))
 (let (($x170580 (= v_2_rtt_active v_1_rtt_active)))
 (let (($x22537 (= v_2_rtt_previous_measured v_1_rtt_previous_measured)))
 (let (($x311895 (= v_2_rtt_measured v_1_rtt_measured)))
 (let (($x12484 (= v_2_rtt_previous_var v_1_rtt_previous_var)))
 (let (($x306405 (= v_2_rtt_previous_srtt v_1_rtt_previous_srtt)))
 (let (($x35741 (= v_2_rtt_error_ms v_1_rtt_error_ms)))
 (let (($x36382 (= v_2_rttvar_ms v_1_rttvar_ms)))
 (let (($x8723 (= v_2_srtt_ms v_1_srtt_ms)))
 (let (($x56430 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x168705 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x188980 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x300710 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x138797 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x319173 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x55023 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x71988 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x89509 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x158117 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x303582 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x297711 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x186096 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x61066 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x148832 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x26166 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x29728 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x309984 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x305140 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x214235 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x249564 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x10771 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x276712 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x304437 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x2927 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x92914 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x35816 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x103627 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x48912 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x316264 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x196984 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x292822 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x196851 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x305231 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x48573 (= v_2_take v_1_take)))
 (let (($x308326 (= v_2_snd_wl2 v_1_snd_wl2)))
 (let (($x17756 (= v_2_snd_wl1 v_1_snd_wl1)))
 (let (($x50915 (= v_2_snd_wnd v_1_snd_wnd)))
 (let (($x44508 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x2100 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x310258 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x307297 (= v_2_local_window v_1_local_window)))
 (let (($x359267 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x36112 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x191402 (= v_2_active_open v_1_active_open)))
 (let ((?x315998 (ite (>= v_1_rto_ms 30000) 60000 (* 2 v_1_rto_ms))))
 (let (($x48720 (= v_2_rto_ms ?x315998)))
 (let (($x294311 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x301556 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x102297 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x311812 (= v_2_rcv_nxt v_1_rcv_nxt)))
 (let (($x68883 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x25556 (= v_2_snd_una v_1_snd_una)))
 (let (($x308880 (= v_2_irs v_1_irs)))
 (let (($x315931 (= v_2_iss v_1_iss)))
 (let (($x239813 (= 2 state_2)))
 (let (($x103940 (= state_1 2)))
 (and $x103940 active_1_rtx (= 1000 due_1_rtx) (or (not active_1_user) (<= due_1_rtx due_1_user)) (or (not active_1_time_wait) (<= due_1_rtx due_1_time_wait)) $x239813 $x315931 $x308880 $x25556 $x68883 $x311812 $x102297 $x301556 $x294311 $x48720 (= v_2_retries (+ 1 v_1_retries)) $x191402 $x36112 $x359267 $x307297 $x310258 $x2100 $x44508 $x50915 $x17756 $x308326 $x48573 $x305231 $x196851 $x292822 $x196984 $x316264 $x48912 $x103627 $x35816 $x92914 $x2927 $x304437 $x276712 $x10771 $x249564 $x214235 $x305140 $x309984 $x29728 $x26166 $x148832 $x61066 $x186096 $x297711 $x303582 $x158117 $x89509 $x71988 $x55023 $x319173 $x138797 $x300710 $x188980 $x168705 $x56430 $x8723 $x36382 $x35741 $x306405 $x12484 $x311895 $x22537 $x170580 $x191881 $x195687 $x119636 $x302535 $x303010 $x305722 $x26605 $x270799 $x290715 $x301739 $x308271 $x160963 $x215590 $x298577 $x102835 $x18414 $x147038 $x20191 $x52900 $x314696 $x77310 $x29434 $x395886 $x156379 $x154879 $x156161 $x31308 $x235619 $x310565 $x173080 $x305592 $x153767 $x164332 $x155141 $x121017 $x155092 active_2_rtx $x70549 $x160807 $x85541 $x137017 $x44932))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 (let (($x159634 (= due_3_time_wait due_2_time_wait)))
 (let (($x4351 (= due_3_user due_2_user)))
 (let (($x211770 (= due_3_rtx due_2_rtx)))
 (let (($x52402 (= active_3_time_wait active_2_time_wait)))
 (let (($x298836 (not active_3_user)))
 (let (($x298456 (not active_3_rtx)))
 (let (($x8110 (not v_3_tx_waiting)))
 (let (($x132406 (= v_3_tx_is_fin v_2_tx_is_fin)))
 (let (($x135054 (= v_3_tx_previous_rto v_2_tx_previous_rto)))
 (let (($x18937 (= v_3_tx_elapsed v_2_tx_elapsed)))
 (let (($x61026 (not v_3_tx_retransmitted)))
 (let (($x196644 (= v_3_tx_max_previous v_2_tx_max_previous)))
 (let (($x147231 (= v_3_tx_eligible v_2_tx_eligible)))
 (let (($x40205 (= v_3_tx_emit_count v_2_tx_emit_count)))
 (let ((?x148134 (ite (and v_2_fin_sent (not v_2_fin_acknowledged)) v_2_tx_fin_time 0)))
 (let (($x268166 (= v_3_tx_fin_time ?x148134)))
 (let (($x211781 (= v_3_tx_time_15 (ite (>= 15 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_15))))
 (let (($x153201 (= v_3_tx_time_14 (ite (>= 14 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_14))))
 (let (($x13654 (= v_3_tx_time_13 (ite (>= 13 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_13))))
 (let (($x100647 (= v_3_tx_time_12 (ite (>= 12 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_12))))
 (let (($x307252 (= v_3_tx_time_11 (ite (>= 11 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_11))))
 (let (($x66661 (= v_3_tx_time_10 (ite (>= 10 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_10))))
 (let (($x9953 (= v_3_tx_time_09 (ite (>= 9 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_09))))
 (let (($x310033 (= v_3_tx_time_08 (ite (>= 8 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_08))))
 (let (($x57705 (= v_3_tx_time_07 (ite (>= 7 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_07))))
 (let (($x192551 (= v_3_tx_time_06 (ite (>= 6 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_06))))
 (let (($x2015 (= v_3_tx_time_05 (ite (>= 5 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_05))))
 (let (($x74960 (= v_3_tx_time_04 (ite (>= 4 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_04))))
 (let (($x12877 (= v_3_tx_time_03 (ite (>= 3 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_03))))
 (let (($x313218 (= v_3_tx_time_02 (ite (>= 2 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_02))))
 (let (($x9897 (= v_3_tx_time_01 (ite (>= 1 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_01))))
 (let (($x171010 (= v_3_tx_time_00 (ite (>= 0 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_00))))
 (let ((?x498052 (+ 1010 (* (- 1) v_2_rtt_start_ms))))
 (let (($x219989 (not v_2_rtt_ambiguous)))
 (let ((?x314872 (ubv_to_int (bvadd v_2_rtt_end (bvmul (_ bv4294967295 32) v_2_snd_una)))))
 (let ((?x290885 (ubv_to_int (bvadd (_ bv1001 32) (bvmul (_ bv4294967295 32) v_2_snd_una)))))
 (let (($x202229 (>= ?x290885 ?x314872)))
 (let (($x268467 (and v_2_rtt_active $x202229 $x219989)))
 (let ((?x32882 (ite $x268467 ?x498052 v_2_rtt_last_ms)))
 (let ((?x68026 (to_real ?x32882)))
 (let ((?x165727 (+ v_2_srtt_ms (* (- 1.0) ?x68026))))
 (let ((?x296747 (ite $x268467 (ite (>= ?x165727 0.0) ?x165727 (+ (* (- 1.0) v_2_srtt_ms) ?x68026)) v_2_rtt_error_ms)))
 (let ((?x314148 (* (/ 3.0 4.0) v_2_rttvar_ms)))
 (let ((?x3421 (ite $x268467 (ite v_2_rtt_measured (+ ?x314148 (* (/ 1.0 4.0) ?x296747)) (* (/ 1.0 2.0) ?x68026)) v_2_rttvar_ms)))
 (let ((?x25546 (ite v_2_rtt_measured (+ (* (/ 7.0 8.0) v_2_srtt_ms) (* (/ 1.0 8.0) ?x68026)) ?x68026)))
 (let ((?x308602 (ite $x268467 ?x25546 v_2_srtt_ms)))
 (let ((?x98902 (+ (* (- 1.0) ?x308602) (* (- 1.0) (ite (<= ?x3421 (/ 1.0 4.0)) 1.0 (* 4.0 ?x3421))))))
 (let ((?x28198 (to_int ?x98902)))
 (let ((?x2659 (ite (<= ?x28198 (- 1000)) (* (- 1) ?x28198) 1000)))
 (let (($x145591 (= v_3_rto_base_ms (ite $x268467 (ite (<= 60000 ?x2659) 60000 ?x2659) v_2_rto_base_ms))))
 (let (($x300327 (= v_3_rtt_sample_was_ambiguous (and v_2_rtt_active v_2_rtt_ambiguous))))
 (let (($x88695 (not v_3_rtt_start_new)))
 (let ((?x68118 (* (- 1) ?x290885)))
 (let ((?x307386 (+ ?x314872 ?x68118)))
 (let ((?x70093 (ite (and v_2_rtt_active (not (<= v_2_rtt_remaining ?x307386))) ?x307386 v_2_rtt_remaining)))
 (let (($x303011 (and v_2_rtt_active $x202229)))
 (let (($x149857 (= v_3_rtt_end v_2_rtt_end)))
 (let (($x302803 (= v_3_rtt_start_ms v_2_rtt_start_ms)))
 (let (($x40646 (= v_3_rtt_previous_measured (ite $x268467 v_2_rtt_measured v_2_rtt_previous_measured))))
 (let (($x263747 (= v_3_rtt_previous_var (ite $x268467 v_2_rttvar_ms v_2_rtt_previous_var))))
 (let (($x184404 (= v_3_rtt_previous_srtt (ite $x268467 v_2_srtt_ms v_2_rtt_previous_srtt))))
 (let (($x71235 (= v_3_rx_fin_consumed v_2_rx_fin_consumed)))
 (let (($x143534 (= v_3_rx_fin_done v_2_rx_fin_done)))
 (let (($x318119 (= v_3_rx_fin_offset v_2_rx_fin_offset)))
 (let (($x317816 (= v_3_rx_fin_seq v_2_rx_fin_seq)))
 (let (($x136098 (= v_3_rx_fin_pending v_2_rx_fin_pending)))
 (let (($x172171 (= v_3_fin_acknowledged v_2_fin_acknowledged)))
 (let (($x152332 (= v_3_fin_seq v_2_fin_seq)))
 (let (($x5629 (= v_3_fin_sent v_2_fin_sent)))
 (let (($x316528 (= v_3_fin_requested v_2_fin_requested)))
 (let (($x163698 (= v_3_ack_window_update v_2_ack_window_update)))
 (let (($x7132 (= v_3_ack_advance v_2_ack_advance)))
 (let (($x21215 (= v_3_ack_is_future v_2_ack_is_future)))
 (let (($x318432 (= v_3_ack_is_new v_2_ack_is_new)))
 (let (($x175077 (= v_3_ack_delta v_2_ack_delta)))
 (let (($x312021 (= v_3_seg_acceptable v_2_seg_acceptable)))
 (let (($x307868 (= v_3_rx_acceptable v_2_rx_acceptable)))
 (let (($x206633 (= v_3_rx_advance v_2_rx_advance)))
 (let (($x314245 (= v_3_rx_slot_15 v_2_rx_slot_15)))
 (let (($x130813 (= v_3_rx_slot_14 v_2_rx_slot_14)))
 (let (($x948 (= v_3_rx_slot_13 v_2_rx_slot_13)))
 (let (($x9449 (= v_3_rx_slot_12 v_2_rx_slot_12)))
 (let (($x45037 (= v_3_rx_slot_11 v_2_rx_slot_11)))
 (let (($x314535 (= v_3_rx_slot_10 v_2_rx_slot_10)))
 (let (($x26544 (= v_3_rx_slot_09 v_2_rx_slot_09)))
 (let (($x21339 (= v_3_rx_slot_08 v_2_rx_slot_08)))
 (let (($x35349 (= v_3_rx_slot_07 v_2_rx_slot_07)))
 (let (($x73664 (= v_3_rx_slot_06 v_2_rx_slot_06)))
 (let (($x318458 (= v_3_rx_slot_05 v_2_rx_slot_05)))
 (let (($x23504 (= v_3_rx_slot_04 v_2_rx_slot_04)))
 (let (($x171847 (= v_3_rx_slot_03 v_2_rx_slot_03)))
 (let (($x41607 (= v_3_rx_slot_02 v_2_rx_slot_02)))
 (let (($x21903 (= v_3_rx_slot_01 v_2_rx_slot_01)))
 (let (($x434535 (= v_3_rx_slot_00 v_2_rx_slot_00)))
 (let (($x7151 (= v_3_rx_chunk v_2_rx_chunk)))
 (let (($x28777 (= v_3_take v_2_take)))
 (let (($x201447 (= v_3_snd_wl2 (_ bv1001 32))))
 (let (($x303548 (= v_3_snd_wl1 (_ bv9000 32))))
 (let (($x163853 (= v_3_snd_wnd 16)))
 (let (($x126409 (= v_3_rcv_buf v_2_rcv_buf)))
 (let (($x318213 (= v_3_rtx_buf v_2_rtx_buf)))
 (let (($x145207 (= v_3_snd_buf v_2_snd_buf)))
 (let (($x75563 (= v_3_local_window v_2_local_window)))
 (let (($x74082 (= v_3_msl_ms v_2_msl_ms)))
 (let (($x306820 (= v_3_user_timeout_ms v_2_user_timeout_ms)))
 (let (($x83193 (= v_3_active_open v_2_active_open)))
 (let (($x52637 (= v_3_retries v_2_retries)))
 (let (($x51331 (= 3000 v_3_rto_ms)))
 (let (($x156474 (= v_3_tx_flags v_2_tx_flags)))
 (let (($x27468 (= v_3_tx_ack v_2_tx_ack)))
 (let (($x301037 (= v_3_tx_seq v_2_tx_seq)))
 (let (($x16848 (= v_3_rcv_nxt (_ bv9001 32))))
 (let (($x94566 (= v_3_snd_nxt v_2_snd_nxt)))
 (let (($x155204 (= v_3_snd_una (_ bv1001 32))))
 (let (($x48619 (= v_3_irs (_ bv9000 32))))
 (let (($x156253 (= v_3_iss v_2_iss)))
 (let (($x37110 (= 4 state_3)))
 (let (($x295228 (or (not active_2_time_wait) (not (<= due_2_time_wait 1010)))))
 (let (($x76378 (or (not active_2_user) (not (<= due_2_user 1010)))))
 (let (($x39174 (or (not active_2_rtx) (not (<= due_2_rtx 1010)))))
 (let (($x46436 (= 1 v_2_retries)))
 (let (($x70291 (= v_2_snd_nxt (_ bv1001 32))))
 (let (($x37954 (= state_2 2)))
 (and $x37954 $x70291 $x46436 $x39174 $x76378 $x295228 $x37110 $x156253 $x48619 $x155204 $x94566 $x16848 $x301037 $x27468 $x156474 $x51331 $x52637 $x83193 $x306820 $x74082 $x75563 $x145207 $x318213 $x126409 $x163853 $x303548 $x201447 $x28777 $x7151 $x434535 $x21903 $x41607 $x171847 $x23504 $x318458 $x73664 $x35349 $x21339 $x26544 $x314535 $x45037 $x9449 $x948 $x130813 $x314245 $x206633 $x307868 $x312021 $x175077 $x318432 $x21215 $x7132 $x163698 $x316528 $x5629 $x152332 $x172171 $x136098 $x317816 $x318119 $x143534 $x71235 (= v_3_srtt_ms ?x308602) (= v_3_rttvar_ms ?x3421) (= v_3_rtt_error_ms ?x296747) $x184404 $x263747 (= v_3_rtt_measured (or v_2_rtt_measured $x268467)) $x40646 (= v_3_rtt_active (and v_2_rtt_active (not $x303011))) (= v_3_rtt_ambiguous (and (not $x303011) v_2_rtt_ambiguous)) (= v_3_rtt_sample_at_ms (ite $x268467 1010 v_2_rtt_sample_at_ms)) $x302803 $x149857 (= v_3_rtt_remaining (ite $x303011 0 ?x70093)) $x88695 (= v_3_rtt_sample_used $x268467) $x300327 (= v_3_rtt_last_ms ?x32882) (= v_3_rtt_samples (+ v_2_rtt_samples (ite $x268467 1 0))) $x145591 $x171010 $x9897 $x313218 $x12877 $x74960 $x2015 $x192551 $x57705 $x310033 $x9953 $x66661 $x307252 $x100647 $x13654 $x153201 $x211781 $x268166 $x40205 $x147231 $x196644 $x61026 $x18937 $x135054 $x132406 $x8110 $x298456 $x298836 $x52402 $x211770 $x4351 $x159634)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
