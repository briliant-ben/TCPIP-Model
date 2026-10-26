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
 (let (($x277896 (= due_1_time_wait due_0_time_wait)))
 (let (($x153391 (= due_1_user 30000)))
 (let (($x11577 (= due_1_rtx 1000)))
 (let (($x34317 (not active_1_time_wait)))
 (let (($x98055 (not v_1_tx_waiting)))
 (let (($x345349 (not v_1_tx_is_fin)))
 (let (($x321351 (= v_1_tx_previous_rto 1000)))
 (let (($x36704 (= v_1_tx_elapsed 0)))
 (let (($x55551 (not v_1_tx_retransmitted)))
 (let (($x173383 (= v_1_tx_max_previous 0)))
 (let (($x165207 (= v_1_tx_eligible 0)))
 (let (($x167477 (= v_1_tx_emit_count 0)))
 (let (($x318774 (= v_1_tx_fin_time 0)))
 (let (($x116297 (= v_1_tx_time_15 0)))
 (let (($x1458 (= v_1_tx_time_14 0)))
 (let (($x389386 (= v_1_tx_time_13 0)))
 (let (($x156539 (= v_1_tx_time_12 0)))
 (let (($x105165 (= v_1_tx_time_11 0)))
 (let (($x313051 (= v_1_tx_time_10 0)))
 (let (($x938493 (= v_1_tx_time_09 0)))
 (let (($x939488 (= v_1_tx_time_08 0)))
 (let (($x121784 (= v_1_tx_time_07 0)))
 (let (($x49888 (= v_1_tx_time_06 0)))
 (let (($x294559 (= v_1_tx_time_05 0)))
 (let (($x27140 (= v_1_tx_time_04 0)))
 (let (($x196953 (= v_1_tx_time_03 0)))
 (let (($x205854 (= v_1_tx_time_02 0)))
 (let (($x340656 (= v_1_tx_time_01 0)))
 (let (($x835007 (= v_1_tx_time_00 0)))
 (let (($x409349 (= v_1_rto_base_ms 1000)))
 (let (($x406898 (= v_1_rtt_samples 0)))
 (let (($x276520 (= v_1_rtt_last_ms 0)))
 (let (($x859244 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x247798 (not v_1_rtt_sample_used)))
 (let (($x765268 (= v_1_rtt_remaining 1)))
 (let (($x794232 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x161186 (= v_1_rtt_start_ms 0)))
 (let (($x278012 (not v_1_rtt_ambiguous)))
 (let (($x322696 (not v_1_rtt_previous_measured)))
 (let (($x726659 (not v_1_rtt_measured)))
 (let (($x105367 (= v_1_rtt_previous_var 0.0)))
 (let (($x73943 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x258440 (= v_1_rtt_error_ms 0.0)))
 (let (($x265937 (= v_1_rttvar_ms 0.0)))
 (let (($x200137 (= v_1_srtt_ms 0.0)))
 (let (($x69176 (not v_1_rx_fin_consumed)))
 (let (($x60880 (not v_1_rx_fin_done)))
 (let (($x64589 (= v_1_rx_fin_offset 0)))
 (let (($x819944 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x69697 (not v_1_rx_fin_pending)))
 (let (($x341867 (not v_1_fin_acknowledged)))
 (let (($x83738 (= v_1_fin_seq (_ bv0 32))))
 (let (($x131595 (not v_1_fin_sent)))
 (let (($x369552 (not v_1_fin_requested)))
 (let (($x267211 (not v_1_ack_window_update)))
 (let (($x839649 (not v_1_ack_advance)))
 (let (($x286814 (not v_1_ack_is_future)))
 (let (($x129488 (not v_1_ack_is_new)))
 (let (($x231105 (= v_1_ack_delta 0)))
 (let (($x184477 (not v_1_seg_acceptable)))
 (let (($x116565 (not v_1_rx_acceptable)))
 (let (($x53427 (= v_1_rx_advance 0)))
 (let (($x240610 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x88393 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x95111 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x147374 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x160121 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x82542 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x292860 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x118560 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x148062 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x145717 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x716271 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x144770 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x234038 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x111133 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x288349 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x119708 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x116829 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x282818 (= v_1_take 0)))
 (let (($x36355 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x35519 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x299651 (= v_1_snd_wnd 8)))
 (let (($x119354 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x292231 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x812120 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x186440 (= v_1_local_window 16)))
 (let (($x885235 (= v_1_msl_ms 60000)))
 (let (($x111086 (= v_1_user_timeout_ms 30000)))
 (let (($x54600 (= 0 v_1_retries)))
 (let (($x98262 (= 1000 v_1_rto_ms)))
 (let (($x238232 (= v_1_tx_flags "S")))
 (let (($x81489 (= v_1_tx_ack (_ bv0 32))))
 (let (($x290122 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x230437 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x313634 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x764880 (= v_1_snd_una (_ bv1000 32))))
 (let (($x702 (= v_1_irs (_ bv0 32))))
 (let (($x137396 (= v_1_iss (_ bv1000 32))))
 (let (($x783833 (= 2 state_1)))
 (let (($x220466 (not active_0_time_wait)))
 (let (($x310428 (or $x220466 (not (<= due_0_time_wait 0)))))
 (let (($x87394 (not active_0_user)))
 (let (($x352927 (or $x87394 (not (<= due_0_user 0)))))
 (let (($x563250 (not active_0_rtx)))
 (let (($x56820 (or $x563250 (not (<= due_0_rtx 0)))))
 (let (($x186400 (= state_0 0)))
 (and $x186400 (>= 0 now_0) $x56820 $x352927 $x310428 $x783833 $x137396 $x702 $x764880 $x313634 $x230437 $x290122 $x81489 $x238232 $x98262 $x54600 v_1_active_open $x111086 $x885235 $x186440 $x812120 $x292231 $x119354 $x299651 $x35519 $x36355 $x282818 $x116829 $x119708 $x288349 $x111133 $x234038 $x144770 $x716271 $x145717 $x148062 $x118560 $x292860 $x82542 $x160121 $x147374 $x95111 $x88393 $x240610 $x53427 $x116565 $x184477 $x231105 $x129488 $x286814 $x839649 $x267211 $x369552 $x131595 $x83738 $x341867 $x69697 $x819944 $x64589 $x60880 $x69176 $x200137 $x265937 $x258440 $x73943 $x105367 $x726659 $x322696 v_1_rtt_active $x278012 $x161186 $x794232 $x765268 v_1_rtt_start_new $x247798 $x859244 $x276520 $x406898 $x409349 $x835007 $x340656 $x205854 $x196953 $x27140 $x294559 $x49888 $x121784 $x939488 $x938493 $x313051 $x105165 $x156539 $x389386 $x1458 $x116297 $x318774 $x167477 $x165207 $x173383 $x55551 $x36704 $x321351 $x345349 $x98055 active_1_rtx active_1_user $x34317 $x11577 $x153391 $x277896)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 (let (($x78443 (= due_2_time_wait due_1_time_wait)))
 (let (($x93920 (= due_2_user due_1_user)))
 (let (($x384627 (= due_2_rtx (+ 1000 (ite (>= v_1_rto_ms 30000) 60000 (* 2 v_1_rto_ms))))))
 (let (($x87989 (= active_2_time_wait active_1_time_wait)))
 (let (($x143684 (= active_2_user active_1_user)))
 (let (($x163610 (not v_2_tx_waiting)))
 (let (($x36287 (= v_2_tx_is_fin v_1_tx_is_fin)))
 (let (($x980194 (= v_2_tx_previous_rto v_1_tx_previous_rto)))
 (let (($x241453 (= v_2_tx_elapsed v_1_tx_elapsed)))
 (let (($x80024 (not v_2_tx_retransmitted)))
 (let (($x16715 (= v_2_tx_max_previous v_1_tx_max_previous)))
 (let (($x119160 (= v_2_tx_eligible v_1_tx_eligible)))
 (let (($x793446 (= v_2_tx_emit_count v_1_tx_emit_count)))
 (let ((?x332986 (ite (and v_1_fin_sent (not v_1_fin_acknowledged)) v_1_tx_fin_time 0)))
 (let (($x382622 (= v_2_tx_fin_time ?x332986)))
 (let (($x102714 (= v_2_tx_time_15 (ite (>= 15 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_15))))
 (let (($x38276 (= v_2_tx_time_14 (ite (>= 14 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_14))))
 (let (($x22816 (= v_2_tx_time_13 (ite (>= 13 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_13))))
 (let (($x174756 (= v_2_tx_time_12 (ite (>= 12 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_12))))
 (let (($x172817 (= v_2_tx_time_11 (ite (>= 11 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_11))))
 (let (($x169812 (= v_2_tx_time_10 (ite (>= 10 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_10))))
 (let (($x137534 (= v_2_tx_time_09 (ite (>= 9 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_09))))
 (let (($x270059 (= v_2_tx_time_08 (ite (>= 8 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_08))))
 (let (($x113177 (= v_2_tx_time_07 (ite (>= 7 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_07))))
 (let (($x73300 (= v_2_tx_time_06 (ite (>= 6 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_06))))
 (let (($x32207 (= v_2_tx_time_05 (ite (>= 5 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_05))))
 (let (($x263456 (= v_2_tx_time_04 (ite (>= 4 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_04))))
 (let (($x263000 (= v_2_tx_time_03 (ite (>= 3 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_03))))
 (let (($x57332 (= v_2_tx_time_02 (ite (>= 2 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_02))))
 (let (($x296476 (= v_2_tx_time_01 (ite (>= 1 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_01))))
 (let (($x715496 (= v_2_tx_time_00 (ite (>= 0 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_00))))
 (let (($x702871 (= v_2_rto_base_ms v_1_rto_base_ms)))
 (let (($x215510 (= v_2_rtt_samples v_1_rtt_samples)))
 (let (($x312211 (= v_2_rtt_last_ms v_1_rtt_last_ms)))
 (let (($x31880 (not v_2_rtt_sample_was_ambiguous)))
 (let (($x860288 (not v_2_rtt_sample_used)))
 (let (($x181061 (not v_2_rtt_start_new)))
 (let (($x158267 (= v_2_rtt_remaining v_1_rtt_remaining)))
 (let (($x183174 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x305460 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let ((?x54974 (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let (($x846632 (and v_1_rtt_active (<= (+ ?x54974 (* (- 1) v_1_rtt_remaining)) 0))))
 (let (($x179574 (= v_2_rtt_active v_1_rtt_active)))
 (let (($x793324 (= v_2_rtt_previous_measured v_1_rtt_previous_measured)))
 (let (($x15527 (= v_2_rtt_measured v_1_rtt_measured)))
 (let (($x860575 (= v_2_rtt_previous_var v_1_rtt_previous_var)))
 (let (($x161052 (= v_2_rtt_previous_srtt v_1_rtt_previous_srtt)))
 (let (($x235632 (= v_2_rtt_error_ms v_1_rtt_error_ms)))
 (let (($x170831 (= v_2_rttvar_ms v_1_rttvar_ms)))
 (let (($x49557 (= v_2_srtt_ms v_1_srtt_ms)))
 (let (($x292129 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x787516 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x213908 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x132365 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x327655 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x944890 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x152669 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x50643 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x40404 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x276382 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x282616 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x213521 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x60610 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x88337 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x103524 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x243073 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x170080 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x122115 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x396359 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x47151 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x266570 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x88094 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x253645 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x310321 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x79111 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x302358 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x207039 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x302158 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x426977 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x300803 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x198947 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x254736 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x135010 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x287952 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x112842 (= v_2_take v_1_take)))
 (let (($x830570 (= v_2_snd_wl2 v_1_snd_wl2)))
 (let (($x386090 (= v_2_snd_wl1 v_1_snd_wl1)))
 (let (($x860573 (= v_2_snd_wnd v_1_snd_wnd)))
 (let (($x884983 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x861436 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x116611 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x185398 (= v_2_local_window v_1_local_window)))
 (let (($x170251 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x945621 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x86009 (= v_2_active_open v_1_active_open)))
 (let ((?x833559 (ite (>= v_1_rto_ms 30000) 60000 (* 2 v_1_rto_ms))))
 (let (($x293612 (= v_2_rto_ms ?x833559)))
 (let (($x264585 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x64194 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x124885 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x46337 (= v_2_rcv_nxt v_1_rcv_nxt)))
 (let (($x426160 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x285722 (= v_2_snd_una v_1_snd_una)))
 (let (($x266605 (= v_2_irs v_1_irs)))
 (let (($x422536 (= v_2_iss v_1_iss)))
 (let (($x333955 (= 2 state_2)))
 (let (($x80822 (= state_1 2)))
 (and $x80822 active_1_rtx (= 1000 due_1_rtx) (or (not active_1_user) (<= due_1_rtx due_1_user)) (or (not active_1_time_wait) (<= due_1_rtx due_1_time_wait)) $x333955 $x422536 $x266605 $x285722 $x426160 $x46337 $x124885 $x64194 $x264585 $x293612 (= v_2_retries (+ 1 v_1_retries)) $x86009 $x945621 $x170251 $x185398 $x116611 $x861436 $x884983 $x860573 $x386090 $x830570 $x112842 $x287952 $x135010 $x254736 $x198947 $x300803 $x426977 $x302158 $x207039 $x302358 $x79111 $x310321 $x253645 $x88094 $x266570 $x47151 $x396359 $x122115 $x170080 $x243073 $x103524 $x88337 $x60610 $x213521 $x282616 $x276382 $x40404 $x50643 $x152669 $x944890 $x327655 $x132365 $x213908 $x787516 $x292129 $x49557 $x170831 $x235632 $x161052 $x860575 $x15527 $x793324 $x179574 (= v_2_rtt_ambiguous (or v_1_rtt_ambiguous $x846632)) $x305460 $x183174 $x158267 $x181061 $x860288 $x31880 $x312211 $x215510 $x702871 $x715496 $x296476 $x57332 $x263000 $x263456 $x32207 $x73300 $x113177 $x270059 $x137534 $x169812 $x172817 $x174756 $x22816 $x38276 $x102714 $x382622 $x793446 $x119160 $x16715 $x80024 $x241453 $x980194 $x36287 $x163610 active_2_rtx $x143684 $x87989 $x384627 $x93920 $x78443)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x185755 (= due_3_time_wait due_2_time_wait)))
 (let (($x283809 (= due_3_user due_2_user)))
 (let (($x246344 (= due_3_rtx due_2_rtx)))
 (let (($x776445 (= active_3_time_wait active_2_time_wait)))
 (let (($x15732 (not active_3_user)))
 (let (($x70924 (not active_3_rtx)))
 (let (($x768530 (not v_3_tx_waiting)))
 (let (($x177849 (= v_3_tx_is_fin v_2_tx_is_fin)))
 (let (($x164536 (= v_3_tx_previous_rto v_2_tx_previous_rto)))
 (let (($x168776 (= v_3_tx_elapsed v_2_tx_elapsed)))
 (let (($x321442 (not v_3_tx_retransmitted)))
 (let (($x181064 (= v_3_tx_max_previous v_2_tx_max_previous)))
 (let (($x773698 (= v_3_tx_eligible v_2_tx_eligible)))
 (let (($x123469 (= v_3_tx_emit_count v_2_tx_emit_count)))
 (let ((?x112428 (ite (and v_2_fin_sent (not v_2_fin_acknowledged)) v_2_tx_fin_time 0)))
 (let (($x163609 (= v_3_tx_fin_time ?x112428)))
 (let (($x724476 (= v_3_tx_time_15 (ite (>= 15 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_15))))
 (let (($x247026 (= v_3_tx_time_14 (ite (>= 14 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_14))))
 (let (($x336086 (= v_3_tx_time_13 (ite (>= 13 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_13))))
 (let (($x45356 (= v_3_tx_time_12 (ite (>= 12 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_12))))
 (let (($x172445 (= v_3_tx_time_11 (ite (>= 11 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_11))))
 (let (($x231779 (= v_3_tx_time_10 (ite (>= 10 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_10))))
 (let (($x90013 (= v_3_tx_time_09 (ite (>= 9 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_09))))
 (let (($x208728 (= v_3_tx_time_08 (ite (>= 8 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_08))))
 (let (($x70775 (= v_3_tx_time_07 (ite (>= 7 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_07))))
 (let (($x879229 (= v_3_tx_time_06 (ite (>= 6 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_06))))
 (let (($x140829 (= v_3_tx_time_05 (ite (>= 5 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_05))))
 (let (($x236185 (= v_3_tx_time_04 (ite (>= 4 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_04))))
 (let (($x110424 (= v_3_tx_time_03 (ite (>= 3 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_03))))
 (let (($x230222 (= v_3_tx_time_02 (ite (>= 2 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_02))))
 (let (($x251513 (= v_3_tx_time_01 (ite (>= 1 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_01))))
 (let (($x244609 (= v_3_tx_time_00 (ite (>= 0 (seq.len v_2_rtx_buf)) 0 v_2_tx_time_00))))
 (let ((?x91030 (+ 1010 (* (- 1) v_2_rtt_start_ms))))
 (let (($x411952 (not v_2_rtt_ambiguous)))
 (let ((?x278043 (ubv_to_int (bvadd v_2_rtt_end (bvmul (_ bv4294967295 32) v_2_snd_una)))))
 (let ((?x943218 (ubv_to_int (bvadd (_ bv1001 32) (bvmul (_ bv4294967295 32) v_2_snd_una)))))
 (let (($x41565 (>= ?x943218 ?x278043)))
 (let (($x492276 (and v_2_rtt_active $x41565 $x411952)))
 (let ((?x845462 (ite $x492276 ?x91030 v_2_rtt_last_ms)))
 (let ((?x193497 (to_real ?x845462)))
 (let ((?x182432 (+ v_2_srtt_ms (* (- 1.0) ?x193497))))
 (let ((?x270522 (ite $x492276 (ite (>= ?x182432 0.0) ?x182432 (+ (* (- 1.0) v_2_srtt_ms) ?x193497)) v_2_rtt_error_ms)))
 (let ((?x264216 (* (/ 3.0 4.0) v_2_rttvar_ms)))
 (let ((?x77446 (ite $x492276 (ite v_2_rtt_measured (+ ?x264216 (* (/ 1.0 4.0) ?x270522)) (* (/ 1.0 2.0) ?x193497)) v_2_rttvar_ms)))
 (let ((?x813107 (ite v_2_rtt_measured (+ (* (/ 7.0 8.0) v_2_srtt_ms) (* (/ 1.0 8.0) ?x193497)) ?x193497)))
 (let ((?x847299 (ite $x492276 ?x813107 v_2_srtt_ms)))
 (let ((?x859294 (+ (* (- 1.0) ?x847299) (* (- 1.0) (ite (<= ?x77446 (/ 1.0 4.0)) 1.0 (* 4.0 ?x77446))))))
 (let ((?x213636 (to_int ?x859294)))
 (let ((?x278343 (ite (<= ?x213636 (- 1000)) (* (- 1) ?x213636) 1000)))
 (let (($x200843 (= v_3_rto_base_ms (ite $x492276 (ite (<= 60000 ?x278343) 60000 ?x278343) v_2_rto_base_ms))))
 (let (($x961493 (= v_3_rtt_sample_was_ambiguous (and v_2_rtt_active v_2_rtt_ambiguous))))
 (let (($x263852 (not v_3_rtt_start_new)))
 (let ((?x311711 (* (- 1) ?x943218)))
 (let ((?x318046 (+ ?x278043 ?x311711)))
 (let ((?x5025 (ite (and v_2_rtt_active (not (<= v_2_rtt_remaining ?x318046))) ?x318046 v_2_rtt_remaining)))
 (let (($x327666 (and v_2_rtt_active $x41565)))
 (let (($x11160 (= v_3_rtt_end v_2_rtt_end)))
 (let (($x23033 (= v_3_rtt_start_ms v_2_rtt_start_ms)))
 (let (($x206726 (= v_3_rtt_previous_measured (ite $x492276 v_2_rtt_measured v_2_rtt_previous_measured))))
 (let (($x1481 (= v_3_rtt_previous_var (ite $x492276 v_2_rttvar_ms v_2_rtt_previous_var))))
 (let (($x57906 (= v_3_rtt_previous_srtt (ite $x492276 v_2_srtt_ms v_2_rtt_previous_srtt))))
 (let (($x571909 (= v_3_rx_fin_consumed v_2_rx_fin_consumed)))
 (let (($x335786 (= v_3_rx_fin_done v_2_rx_fin_done)))
 (let (($x24256 (= v_3_rx_fin_offset v_2_rx_fin_offset)))
 (let (($x6653 (= v_3_rx_fin_seq v_2_rx_fin_seq)))
 (let (($x380677 (= v_3_rx_fin_pending v_2_rx_fin_pending)))
 (let (($x268488 (= v_3_fin_acknowledged v_2_fin_acknowledged)))
 (let (($x315226 (= v_3_fin_seq v_2_fin_seq)))
 (let (($x724829 (= v_3_fin_sent v_2_fin_sent)))
 (let (($x334816 (= v_3_fin_requested v_2_fin_requested)))
 (let (($x82884 (= v_3_ack_window_update v_2_ack_window_update)))
 (let (($x176882 (= v_3_ack_advance v_2_ack_advance)))
 (let (($x301521 (= v_3_ack_is_future v_2_ack_is_future)))
 (let (($x75409 (= v_3_ack_is_new v_2_ack_is_new)))
 (let (($x28478 (= v_3_ack_delta v_2_ack_delta)))
 (let (($x117233 (= v_3_seg_acceptable v_2_seg_acceptable)))
 (let (($x65600 (= v_3_rx_acceptable v_2_rx_acceptable)))
 (let (($x389029 (= v_3_rx_advance v_2_rx_advance)))
 (let (($x47149 (= v_3_rx_slot_15 v_2_rx_slot_15)))
 (let (($x253167 (= v_3_rx_slot_14 v_2_rx_slot_14)))
 (let (($x78956 (= v_3_rx_slot_13 v_2_rx_slot_13)))
 (let (($x277910 (= v_3_rx_slot_12 v_2_rx_slot_12)))
 (let (($x107217 (= v_3_rx_slot_11 v_2_rx_slot_11)))
 (let (($x164019 (= v_3_rx_slot_10 v_2_rx_slot_10)))
 (let (($x925591 (= v_3_rx_slot_09 v_2_rx_slot_09)))
 (let (($x153167 (= v_3_rx_slot_08 v_2_rx_slot_08)))
 (let (($x257862 (= v_3_rx_slot_07 v_2_rx_slot_07)))
 (let (($x129721 (= v_3_rx_slot_06 v_2_rx_slot_06)))
 (let (($x288403 (= v_3_rx_slot_05 v_2_rx_slot_05)))
 (let (($x111673 (= v_3_rx_slot_04 v_2_rx_slot_04)))
 (let (($x807084 (= v_3_rx_slot_03 v_2_rx_slot_03)))
 (let (($x92987 (= v_3_rx_slot_02 v_2_rx_slot_02)))
 (let (($x333128 (= v_3_rx_slot_01 v_2_rx_slot_01)))
 (let (($x214604 (= v_3_rx_slot_00 v_2_rx_slot_00)))
 (let (($x16941 (= v_3_rx_chunk v_2_rx_chunk)))
 (let (($x326027 (= v_3_take v_2_take)))
 (let (($x14150 (= v_3_snd_wl2 (_ bv1001 32))))
 (let (($x130539 (= v_3_snd_wl1 (_ bv9000 32))))
 (let (($x247385 (= v_3_snd_wnd 16)))
 (let (($x31597 (= v_3_rcv_buf v_2_rcv_buf)))
 (let (($x289334 (= v_3_rtx_buf v_2_rtx_buf)))
 (let (($x224472 (= v_3_snd_buf v_2_snd_buf)))
 (let (($x91889 (= v_3_local_window v_2_local_window)))
 (let (($x223334 (= v_3_msl_ms v_2_msl_ms)))
 (let (($x387049 (= v_3_user_timeout_ms v_2_user_timeout_ms)))
 (let (($x265604 (= v_3_active_open v_2_active_open)))
 (let (($x339213 (= v_3_retries v_2_retries)))
 (let (($x408903 (= 3000 v_3_rto_ms)))
 (let (($x722486 (= v_3_tx_flags v_2_tx_flags)))
 (let (($x144614 (= v_3_tx_ack v_2_tx_ack)))
 (let (($x154706 (= v_3_tx_seq v_2_tx_seq)))
 (let (($x113502 (= v_3_rcv_nxt (_ bv9001 32))))
 (let (($x309397 (= v_3_snd_nxt v_2_snd_nxt)))
 (let (($x40541 (= v_3_snd_una (_ bv1001 32))))
 (let (($x328471 (= v_3_irs (_ bv9000 32))))
 (let (($x260409 (= v_3_iss v_2_iss)))
 (let (($x207540 (= 4 state_3)))
 (let (($x194442 (or (not active_2_time_wait) (not (<= due_2_time_wait 1010)))))
 (let (($x209862 (or (not active_2_user) (not (<= due_2_user 1010)))))
 (let (($x3857 (or (not active_2_rtx) (not (<= due_2_rtx 1010)))))
 (let (($x73833 (= 1 v_2_retries)))
 (let (($x16790 (= v_2_snd_nxt (_ bv1001 32))))
 (let (($x232789 (= state_2 2)))
 (and $x232789 $x16790 $x73833 $x3857 $x209862 $x194442 $x207540 $x260409 $x328471 $x40541 $x309397 $x113502 $x154706 $x144614 $x722486 $x408903 $x339213 $x265604 $x387049 $x223334 $x91889 $x224472 $x289334 $x31597 $x247385 $x130539 $x14150 $x326027 $x16941 $x214604 $x333128 $x92987 $x807084 $x111673 $x288403 $x129721 $x257862 $x153167 $x925591 $x164019 $x107217 $x277910 $x78956 $x253167 $x47149 $x389029 $x65600 $x117233 $x28478 $x75409 $x301521 $x176882 $x82884 $x334816 $x724829 $x315226 $x268488 $x380677 $x6653 $x24256 $x335786 $x571909 (= v_3_srtt_ms ?x847299) (= v_3_rttvar_ms ?x77446) (= v_3_rtt_error_ms ?x270522) $x57906 $x1481 (= v_3_rtt_measured (or v_2_rtt_measured $x492276)) $x206726 (= v_3_rtt_active (and v_2_rtt_active (not $x327666))) (= v_3_rtt_ambiguous (and (not $x327666) v_2_rtt_ambiguous)) $x23033 $x11160 (= v_3_rtt_remaining (ite $x327666 0 ?x5025)) $x263852 (= v_3_rtt_sample_used $x492276) $x961493 (= v_3_rtt_last_ms ?x845462) (= v_3_rtt_samples (+ v_2_rtt_samples (ite $x492276 1 0))) $x200843 $x244609 $x251513 $x230222 $x110424 $x236185 $x140829 $x879229 $x70775 $x208728 $x90013 $x231779 $x172445 $x45356 $x336086 $x247026 $x724476 $x163609 $x123469 $x773698 $x181064 $x321442 $x168776 $x164536 $x177849 $x768530 $x70924 $x15732 $x776445 $x246344 $x283809 $x185755)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
