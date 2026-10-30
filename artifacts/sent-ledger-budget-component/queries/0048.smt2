; benchmark generated from python API
(set-info :status unknown)
(declare-fun v_0_snd_buf () Int)
(declare-fun v_0_rtx_buf () Int)
(declare-fun v_0_rcv_buf () Int)
(declare-fun v_0_rx_chunk () Int)
(declare-fun v_0_rx_slot_00 () Int)
(declare-fun v_0_rx_slot_01 () Int)
(declare-fun v_0_rx_slot_02 () Int)
(declare-fun v_0_rx_slot_03 () Int)
(declare-fun v_0_rx_slot_04 () Int)
(declare-fun v_0_rx_slot_05 () Int)
(declare-fun v_0_rx_slot_06 () Int)
(declare-fun v_0_rx_slot_07 () Int)
(declare-fun v_0_rx_slot_08 () Int)
(declare-fun v_0_rx_slot_09 () Int)
(declare-fun v_0_rx_slot_10 () Int)
(declare-fun v_0_rx_slot_11 () Int)
(declare-fun v_0_rx_slot_12 () Int)
(declare-fun v_0_rx_slot_13 () Int)
(declare-fun v_0_rx_slot_14 () Int)
(declare-fun v_0_rx_slot_15 () Int)
(declare-fun v_1_snd_buf () Int)
(declare-fun v_1_rtx_buf () Int)
(declare-fun v_1_rcv_buf () Int)
(declare-fun v_1_rx_chunk () Int)
(declare-fun v_1_rx_slot_00 () Int)
(declare-fun v_1_rx_slot_01 () Int)
(declare-fun v_1_rx_slot_02 () Int)
(declare-fun v_1_rx_slot_03 () Int)
(declare-fun v_1_rx_slot_04 () Int)
(declare-fun v_1_rx_slot_05 () Int)
(declare-fun v_1_rx_slot_06 () Int)
(declare-fun v_1_rx_slot_07 () Int)
(declare-fun v_1_rx_slot_08 () Int)
(declare-fun v_1_rx_slot_09 () Int)
(declare-fun v_1_rx_slot_10 () Int)
(declare-fun v_1_rx_slot_11 () Int)
(declare-fun v_1_rx_slot_12 () Int)
(declare-fun v_1_rx_slot_13 () Int)
(declare-fun v_1_rx_slot_14 () Int)
(declare-fun v_1_rx_slot_15 () Int)
(declare-fun v_0_iss () Int)
(declare-fun v_0_irs () Int)
(declare-fun v_0_snd_una () Int)
(declare-fun v_0_snd_nxt () Int)
(declare-fun v_0_rcv_nxt () Int)
(declare-fun v_0_tx_seq () Int)
(declare-fun v_0_tx_ack () Int)
(declare-fun v_0_snd_wl1 () Int)
(declare-fun v_0_snd_wl2 () Int)
(declare-fun v_0_fin_seq () Int)
(declare-fun v_0_rx_fin_seq () Int)
(declare-fun v_0_rtt_end () Int)
(declare-fun v_0_cc_before_una () Int)
(declare-fun v_0_fr_before_una () Int)
(declare-fun v_0_fr_before_nxt () Int)
(declare-fun v_0_lt_before_nxt () Int)
(declare-fun v_0_choice_before_nxt () Int)
(declare-fun v_0_cb_before_nxt () Int)
(declare-fun v_0_cb_append_end () Int)
(declare-fun v_0_cb_end_00 () Int)
(declare-fun v_0_cb_end_01 () Int)
(declare-fun v_0_cb_end_02 () Int)
(declare-fun v_0_cb_end_03 () Int)
(declare-fun v_0_cb_end_04 () Int)
(declare-fun v_0_cb_end_05 () Int)
(declare-fun v_0_cb_end_06 () Int)
(declare-fun v_0_cb_end_07 () Int)
(declare-fun v_0_cb_end_08 () Int)
(declare-fun v_0_cb_end_09 () Int)
(declare-fun v_0_cb_end_10 () Int)
(declare-fun v_0_cb_end_11 () Int)
(declare-fun v_0_cb_end_12 () Int)
(declare-fun v_0_cb_end_13 () Int)
(declare-fun v_0_cb_end_14 () Int)
(declare-fun v_0_cb_end_15 () Int)
(declare-fun v_1_iss () Int)
(declare-fun v_1_irs () Int)
(declare-fun v_1_snd_una () Int)
(declare-fun v_1_snd_nxt () Int)
(declare-fun v_1_rcv_nxt () Int)
(declare-fun v_1_tx_seq () Int)
(declare-fun v_1_tx_ack () Int)
(declare-fun v_1_snd_wl1 () Int)
(declare-fun v_1_snd_wl2 () Int)
(declare-fun v_1_fin_seq () Int)
(declare-fun v_1_rx_fin_seq () Int)
(declare-fun v_1_rtt_end () Int)
(declare-fun v_1_cc_before_una () Int)
(declare-fun v_1_fr_before_una () Int)
(declare-fun v_1_fr_before_nxt () Int)
(declare-fun v_1_lt_before_nxt () Int)
(declare-fun v_1_choice_before_nxt () Int)
(declare-fun v_1_cb_before_nxt () Int)
(declare-fun v_1_cb_append_end () Int)
(declare-fun v_1_cb_end_00 () Int)
(declare-fun v_1_cb_end_01 () Int)
(declare-fun v_1_cb_end_02 () Int)
(declare-fun v_1_cb_end_03 () Int)
(declare-fun v_1_cb_end_04 () Int)
(declare-fun v_1_cb_end_05 () Int)
(declare-fun v_1_cb_end_06 () Int)
(declare-fun v_1_cb_end_07 () Int)
(declare-fun v_1_cb_end_08 () Int)
(declare-fun v_1_cb_end_09 () Int)
(declare-fun v_1_cb_end_10 () Int)
(declare-fun v_1_cb_end_11 () Int)
(declare-fun v_1_cb_end_12 () Int)
(declare-fun v_1_cb_end_13 () Int)
(declare-fun v_1_cb_end_14 () Int)
(declare-fun v_1_cb_end_15 () Int)
(declare-fun now_0 () Int)
(declare-fun due_0_rtx () Int)
(declare-fun active_0_rtx () Bool)
(declare-fun due_0_user () Int)
(declare-fun active_0_user () Bool)
(declare-fun due_0_time_wait () Int)
(declare-fun active_0_time_wait () Bool)
(declare-fun due_0_delack () Int)
(declare-fun active_0_delack () Bool)
(declare-fun due_0_persist () Int)
(declare-fun active_0_persist () Bool)
(declare-fun input_0_app.send_data () Int)
(declare-fun input_0_net.data_data () Int)
(declare-fun input_0_net.fin_segment_data () Int)
(declare-fun input_0_net.syn_seq () Int)
(declare-fun input_0_net.synack_seq () Int)
(declare-fun input_0_net.synack_ack () Int)
(declare-fun input_0_net.ack_seq () Int)
(declare-fun input_0_net.ack_ack () Int)
(declare-fun input_0_net.fin_seq () Int)
(declare-fun input_0_net.fin_ack () Int)
(declare-fun input_0_net.rst_seq () Int)
(declare-fun input_0_net.rstack_seq () Int)
(declare-fun input_0_net.rstack_ack () Int)
(declare-fun input_0_net.data_seq () Int)
(declare-fun input_0_net.data_ack () Int)
(declare-fun input_0_net.fin_segment_seq () Int)
(declare-fun input_0_net.fin_segment_ack () Int)
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
(declare-fun v_1_cb_done_15 () Bool)
(declare-fun v_0_cb_length_15 () Int)
(declare-fun v_1_cb_length_15 () Int)
(declare-fun v_1_cb_done_14 () Bool)
(declare-fun v_0_cb_length_14 () Int)
(declare-fun v_1_cb_length_14 () Int)
(declare-fun v_1_cb_done_13 () Bool)
(declare-fun v_0_cb_length_13 () Int)
(declare-fun v_1_cb_length_13 () Int)
(declare-fun v_1_cb_done_12 () Bool)
(declare-fun v_0_cb_length_12 () Int)
(declare-fun v_1_cb_length_12 () Int)
(declare-fun v_1_cb_done_11 () Bool)
(declare-fun v_0_cb_length_11 () Int)
(declare-fun v_1_cb_length_11 () Int)
(declare-fun v_1_cb_done_10 () Bool)
(declare-fun v_0_cb_length_10 () Int)
(declare-fun v_1_cb_length_10 () Int)
(declare-fun v_1_cb_done_09 () Bool)
(declare-fun v_0_cb_length_09 () Int)
(declare-fun v_1_cb_length_09 () Int)
(declare-fun v_1_cb_done_08 () Bool)
(declare-fun v_0_cb_length_08 () Int)
(declare-fun v_1_cb_length_08 () Int)
(declare-fun v_1_cb_done_07 () Bool)
(declare-fun v_0_cb_length_07 () Int)
(declare-fun v_1_cb_length_07 () Int)
(declare-fun v_1_cb_done_06 () Bool)
(declare-fun v_0_cb_length_06 () Int)
(declare-fun v_1_cb_length_06 () Int)
(declare-fun v_1_cb_done_05 () Bool)
(declare-fun v_0_cb_length_05 () Int)
(declare-fun v_1_cb_length_05 () Int)
(declare-fun v_1_cb_done_04 () Bool)
(declare-fun v_0_cb_length_04 () Int)
(declare-fun v_1_cb_length_04 () Int)
(declare-fun v_1_cb_done_03 () Bool)
(declare-fun v_0_cb_length_03 () Int)
(declare-fun v_1_cb_length_03 () Int)
(declare-fun v_1_cb_done_02 () Bool)
(declare-fun v_0_cb_length_02 () Int)
(declare-fun v_1_cb_length_02 () Int)
(declare-fun v_1_cb_done_01 () Bool)
(declare-fun v_0_cb_length_01 () Int)
(declare-fun v_1_cb_length_01 () Int)
(declare-fun v_1_cb_done_00 () Bool)
(declare-fun v_0_cb_length_00 () Int)
(declare-fun v_1_cb_length_00 () Int)
(declare-fun v_1_cb_is_new () Bool)
(declare-fun v_1_cb_drop_step () Int)
(declare-fun v_0_cb_abandoned_total () Int)
(declare-fun v_1_cb_abandoned_total () Int)
(declare-fun v_0_cb_acked_total () Int)
(declare-fun v_1_cb_acked_total () Int)
(declare-fun v_0_cb_emitted_total () Int)
(declare-fun v_1_cb_emitted_total () Int)
(declare-fun v_1_cb_partial_prefix () Int)
(declare-fun v_1_cb_live_total () Int)
(declare-fun v_1_cb_step_bytes () Int)
(declare-fun v_1_cb_retired_count () Int)
(declare-fun v_1_cb_append_length () Int)
(declare-fun v_1_cb_new_count () Int)
(declare-fun v_0_cb_count () Int)
(declare-fun v_1_cb_count () Int)
(declare-fun v_0_cb_tail () Int)
(declare-fun v_1_cb_tail () Int)
(declare-fun v_0_cb_head () Int)
(declare-fun v_1_cb_head () Int)
(declare-fun v_0_svc_abandoned_bytes () Int)
(declare-fun v_1_svc_abandoned_bytes () Int)
(declare-fun v_0_svc_acked_bytes () Int)
(declare-fun v_1_svc_acked_bytes () Int)
(declare-fun v_0_svc_written_bytes () Int)
(declare-fun v_1_svc_written_bytes () Int)
(declare-fun v_1_svc_drop_step () Int)
(declare-fun v_1_svc_ack_step () Int)
(declare-fun v_1_svc_accept_step () Int)
(declare-fun v_1_svc_before_total () Int)
(declare-fun v_1_sched_packets () Int)
(declare-fun v_1_sched_bytes () Int)
(declare-fun v_1_sched_cause () Int)
(declare-fun v_0_sched_at_ms () Int)
(declare-fun v_1_sched_at_ms () Int)
(declare-fun v_1_sched_open () Bool)
(declare-fun v_0_choice_before_flight () Int)
(declare-fun v_1_choice_before_flight () Int)
(declare-fun v_0_choice_limit () Int)
(declare-fun v_1_choice_limit () Int)
(declare-fun v_0_choice_count () Int)
(declare-fun v_1_choice_count () Int)
(declare-fun v_1_choice_used () Bool)
(declare-fun v_0_lt_epoch_bytes () Int)
(declare-fun v_1_lt_loss_flight () Int)
(declare-fun v_0_snd_wnd () Int)
(declare-fun v_1_lt_before_window () Int)
(declare-fun v_1_lt_before_flight () Int)
(declare-fun v_0_cc_cwnd () Int)
(declare-fun v_1_lt_before_cwnd () Int)
(declare-fun v_1_lt_before_bytes () Int)
(declare-fun v_1_lt_epoch_packets () Int)
(declare-fun v_1_lt_epoch_bytes () Int)
(declare-fun v_1_lt_take () Int)
(declare-fun v_1_lt_emitted () Bool)
(declare-fun v_1_lt_eligible () Bool)
(declare-fun v_1_idle_restart_count () Int)
(declare-fun v_0_cc_ssthresh () Int)
(declare-fun v_1_idle_before_threshold () Int)
(declare-fun v_0_rto_ms () Int)
(declare-fun v_1_idle_before_rto () Int)
(declare-fun v_1_idle_before_cwnd () Int)
(declare-fun v_0_idle_last_data_ms () Int)
(declare-fun now_1 () Int)
(declare-fun v_0_idle_data_valid () Bool)
(declare-fun v_1_idle_elapsed_ms () Int)
(declare-fun v_1_idle_restart () Bool)
(declare-fun v_1_idle_data_emitted () Bool)
(declare-fun v_1_idle_event_ms () Int)
(declare-fun v_1_idle_last_data_ms () Int)
(declare-fun v_1_idle_data_valid () Bool)
(declare-fun v_1_fr_entries () Int)
(declare-fun v_1_fr_emit_count () Int)
(declare-fun v_1_fr_retransmitted () Bool)
(declare-fun v_1_fr_exited () Bool)
(declare-fun v_1_fr_extra () Bool)
(declare-fun v_1_fr_entered () Bool)
(declare-fun v_1_fr_duplicate () Bool)
(declare-fun v_0_retries () Int)
(declare-fun v_1_fr_before_retries () Int)
(declare-fun v_1_fr_before_rto () Int)
(declare-fun v_1_fr_before_flight () Int)
(declare-fun v_0_fr_active () Bool)
(declare-fun v_1_fr_was_active () Bool)
(declare-fun v_0_fr_last_window () Int)
(declare-fun v_1_fr_last_window () Int)
(declare-fun v_1_fr_window_valid () Bool)
(declare-fun v_1_fr_dupacks () Int)
(declare-fun v_1_fr_active () Bool)
(declare-fun v_0_fr_window_valid () Bool)
(declare-fun v_1_fr_before_window_valid () Bool)
(declare-fun v_1_fr_before_wire_window () Int)
(declare-fun v_1_fr_window_ignored () Bool)
(declare-fun v_1_cc_rto_15 () Bool)
(declare-fun v_1_cc_rto_14 () Bool)
(declare-fun v_1_cc_rto_13 () Bool)
(declare-fun v_1_cc_rto_12 () Bool)
(declare-fun v_1_cc_rto_11 () Bool)
(declare-fun v_1_cc_rto_10 () Bool)
(declare-fun v_1_cc_rto_09 () Bool)
(declare-fun v_1_cc_rto_08 () Bool)
(declare-fun v_1_cc_rto_07 () Bool)
(declare-fun v_1_cc_rto_06 () Bool)
(declare-fun v_1_cc_rto_05 () Bool)
(declare-fun v_1_cc_rto_04 () Bool)
(declare-fun v_1_cc_rto_03 () Bool)
(declare-fun v_1_cc_rto_02 () Bool)
(declare-fun v_1_cc_rto_01 () Bool)
(declare-fun v_1_cc_rto_00 () Bool)
(declare-fun v_1_cc_new_sent () Int)
(declare-fun v_1_cc_send_budget () Int)
(declare-fun v_1_cc_before_cwnd () Int)
(declare-fun v_1_cc_growth () Int)
(declare-fun v_1_cc_threshold_updates () Int)
(declare-fun v_1_cc_threshold_changed () Bool)
(declare-fun v_1_cc_loss () Bool)
(declare-fun v_1_cc_before_window () Int)
(declare-fun v_0_persist_active () Bool)
(declare-fun v_1_cc_before_persist () Bool)
(declare-fun v_1_cc_before_flight () Int)
(declare-fun v_1_cc_acked () Int)
(declare-fun v_1_cc_ca_credit () Int)
(declare-fun v_0_cc_initial_threshold () Int)
(declare-fun v_1_cc_ssthresh () Int)
(declare-fun v_0_cc_initial_window () Int)
(declare-fun v_1_cc_cwnd () Int)
(declare-fun v_1_cc_initial_threshold () Int)
(declare-fun v_1_cc_initial_window () Int)
(declare-fun v_0_persist_elapsed_ms () Int)
(declare-fun v_1_persist_elapsed_ms () Int)
(declare-fun v_1_persist_probes () Int)
(declare-fun v_1_persist_deadline_ms () Int)
(declare-fun v_1_persist_last_ms () Int)
(declare-fun v_1_persist_since_ms () Int)
(declare-fun v_0_persist_previous_interval_ms () Int)
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
(declare-fun v_0_ack_rmss () Int)
(declare-fun v_1_ack_rmss () Int)
(declare-fun v_0_ack_delay_ms () Int)
(declare-fun v_1_ack_delay_ms () Int)
(declare-fun v_1_ack_full_segments () Int)
(declare-fun v_1_ack_bytes () Int)
(declare-fun v_1_ack_since_ms () Int)
(declare-fun v_1_ack_pending () Bool)
(declare-fun v_1_syn_timeout_eligible () Bool)
(declare-fun v_1_tx_syn_pending () Bool)
(declare-fun v_1_tx_syn_time () Int)
(declare-fun v_1_tx_waiting () Bool)
(declare-fun v_0_tx_is_fin () Bool)
(declare-fun v_1_tx_is_fin () Bool)
(declare-fun v_0_tx_previous_rto () Int)
(declare-fun v_1_tx_previous_rto () Int)
(declare-fun v_0_tx_elapsed () Int)
(declare-fun v_1_tx_elapsed () Int)
(declare-fun v_1_tx_retransmitted () Bool)
(declare-fun v_0_tx_max_previous () Int)
(declare-fun v_1_tx_max_previous () Int)
(declare-fun v_0_tx_eligible () Int)
(declare-fun v_1_tx_eligible () Int)
(declare-fun v_0_tx_emit_count () Int)
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
(declare-fun v_1_rx_fin_pending () Bool)
(declare-fun v_0_fin_acknowledged () Bool)
(declare-fun v_1_fin_acknowledged () Bool)
(declare-fun v_1_fin_sent () Bool)
(declare-fun v_1_fin_requested () Bool)
(declare-fun v_0_ack_window_update () Bool)
(declare-fun v_1_ack_window_update () Bool)
(declare-fun v_0_ack_advance () Bool)
(declare-fun v_1_ack_advance () Bool)
(declare-fun v_0_ack_is_future () Bool)
(declare-fun v_1_ack_is_future () Bool)
(declare-fun v_0_ack_is_new () Bool)
(declare-fun v_1_ack_is_new () Bool)
(declare-fun v_0_ack_delta () Int)
(declare-fun v_1_ack_delta () Int)
(declare-fun v_0_seg_acceptable () Bool)
(declare-fun v_1_seg_acceptable () Bool)
(declare-fun v_0_rx_acceptable () Bool)
(declare-fun v_1_rx_acceptable () Bool)
(declare-fun v_0_rx_advance () Int)
(declare-fun v_1_rx_advance () Int)
(declare-fun v_0_take () Int)
(declare-fun v_1_take () Int)
(declare-fun v_1_snd_wnd () Int)
(declare-fun v_1_local_window () Int)
(declare-fun v_0_msl_ms () Int)
(declare-fun v_1_msl_ms () Int)
(declare-fun v_0_user_timeout_ms () Int)
(declare-fun v_1_user_timeout_ms () Int)
(declare-fun v_0_active_open () Bool)
(declare-fun v_1_active_open () Bool)
(declare-fun v_1_retries () Int)
(declare-fun v_1_rto_ms () Int)
(declare-fun v_0_tx_flags () String)
(declare-fun v_1_tx_flags () String)
(declare-fun v_0_local_window () Int)
(declare-fun v_0_fin_sent () Bool)
(declare-fun v_0_fin_requested () Bool)
(declare-fun v_0_rx_fin_done () Bool)
(declare-fun v_0_rx_fin_pending () Bool)
(declare-fun v_0_rx_fin_offset () Int)
(declare-fun v_0_srtt_ms () Real)
(declare-fun v_0_rttvar_ms () Real)
(declare-fun v_0_rtt_error_ms () Real)
(declare-fun v_0_rtt_previous_srtt () Real)
(declare-fun v_0_rtt_previous_var () Real)
(declare-fun v_0_rtt_start_ms () Int)
(declare-fun v_0_rtt_last_ms () Int)
(declare-fun v_0_rtt_samples () Int)
(declare-fun v_0_rto_base_ms () Int)
(declare-fun v_0_rtt_measured () Bool)
(declare-fun v_0_rtt_active () Bool)
(declare-fun v_0_rtt_remaining () Int)
(declare-fun v_0_rtt_sample_at_ms () Int)
(declare-fun v_0_rtt_sample_was_ambiguous () Bool)
(declare-fun v_0_rtt_sample_used () Bool)
(declare-fun v_0_rtt_previous_measured () Bool)
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
(declare-fun v_0_tx_retransmitted () Bool)
(declare-fun v_0_tx_waiting () Bool)
(declare-fun v_0_tx_syn_time () Int)
(declare-fun v_0_tx_syn_pending () Bool)
(declare-fun v_0_ack_pending () Bool)
(declare-fun v_0_ack_full_segments () Int)
(declare-fun v_0_ack_bytes () Int)
(declare-fun v_0_ack_since_ms () Int)
(declare-fun v_0_persist_probes () Int)
(declare-fun v_0_persist_interval_ms () Int)
(declare-fun v_0_persist_deadline_ms () Int)
(declare-fun v_0_persist_last_ms () Int)
(declare-fun v_0_persist_since_ms () Int)
(declare-fun v_0_persist_probe_sent () Bool)
(declare-fun v_0_cc_threshold_updates () Int)
(declare-fun v_0_cc_acked () Int)
(declare-fun v_0_cc_growth () Int)
(declare-fun v_0_cc_ca_credit () Int)
(declare-fun v_0_cc_send_budget () Int)
(declare-fun v_0_cc_new_sent () Int)
(declare-fun v_0_cc_rto_00 () Bool)
(declare-fun v_0_cc_rto_01 () Bool)
(declare-fun v_0_cc_rto_02 () Bool)
(declare-fun v_0_cc_rto_03 () Bool)
(declare-fun v_0_cc_rto_04 () Bool)
(declare-fun v_0_cc_rto_05 () Bool)
(declare-fun v_0_cc_rto_06 () Bool)
(declare-fun v_0_cc_rto_07 () Bool)
(declare-fun v_0_cc_rto_08 () Bool)
(declare-fun v_0_cc_rto_09 () Bool)
(declare-fun v_0_cc_rto_10 () Bool)
(declare-fun v_0_cc_rto_11 () Bool)
(declare-fun v_0_cc_rto_12 () Bool)
(declare-fun v_0_cc_rto_13 () Bool)
(declare-fun v_0_cc_rto_14 () Bool)
(declare-fun v_0_cc_rto_15 () Bool)
(declare-fun v_0_fr_emit_count () Int)
(declare-fun v_0_fr_entries () Int)
(declare-fun v_0_fr_dupacks () Int)
(declare-fun v_0_fr_before_retries () Int)
(declare-fun v_0_fr_before_rto () Int)
(declare-fun v_0_fr_entered () Bool)
(declare-fun v_0_fr_retransmitted () Bool)
(declare-fun v_0_fr_before_window_valid () Bool)
(declare-fun v_0_fr_before_wire_window () Int)
(declare-fun v_0_fr_window_ignored () Bool)
(declare-fun v_0_fr_exited () Bool)
(declare-fun v_0_idle_restart_count () Int)
(declare-fun v_0_idle_elapsed_ms () Int)
(declare-fun v_0_idle_event_ms () Int)
(declare-fun v_0_idle_data_emitted () Bool)
(declare-fun v_0_idle_before_threshold () Int)
(declare-fun v_0_idle_before_cwnd () Int)
(declare-fun v_0_idle_before_rto () Int)
(declare-fun v_0_idle_restart () Bool)
(declare-fun v_0_lt_loss_flight () Int)
(declare-fun v_0_lt_epoch_packets () Int)
(declare-fun v_0_lt_take () Int)
(declare-fun v_0_lt_before_flight () Int)
(declare-fun v_0_lt_before_cwnd () Int)
(declare-fun v_0_fr_duplicate () Bool)
(declare-fun v_0_lt_emitted () Bool)
(declare-fun v_0_lt_before_bytes () Int)
(declare-fun v_0_fr_before_flight () Int)
(declare-fun v_0_choice_used () Bool)
(declare-fun v_0_sched_bytes () Int)
(declare-fun v_0_sched_packets () Int)
(declare-fun v_0_sched_cause () Int)
(declare-fun v_0_sched_open () Bool)
(declare-fun v_0_svc_drop_step () Int)
(declare-fun v_0_svc_ack_step () Int)
(declare-fun v_0_svc_accept_step () Int)
(declare-fun choice_0 () Int)
(declare-fun state_0 () Int)
(declare-fun state_1 () Int)
(assert
 (>= v_0_snd_buf 0))
(assert
 (>= v_0_rtx_buf 0))
(assert
 (>= v_0_rcv_buf 0))
(assert
 (>= v_0_rx_chunk 0))
(assert
 (>= v_0_rx_slot_00 0))
(assert
 (>= v_0_rx_slot_01 0))
(assert
 (>= v_0_rx_slot_02 0))
(assert
 (>= v_0_rx_slot_03 0))
(assert
 (>= v_0_rx_slot_04 0))
(assert
 (>= v_0_rx_slot_05 0))
(assert
 (>= v_0_rx_slot_06 0))
(assert
 (>= v_0_rx_slot_07 0))
(assert
 (>= v_0_rx_slot_08 0))
(assert
 (>= v_0_rx_slot_09 0))
(assert
 (>= v_0_rx_slot_10 0))
(assert
 (>= v_0_rx_slot_11 0))
(assert
 (>= v_0_rx_slot_12 0))
(assert
 (>= v_0_rx_slot_13 0))
(assert
 (>= v_0_rx_slot_14 0))
(assert
 (>= v_0_rx_slot_15 0))
(assert
 (>= v_1_snd_buf 0))
(assert
 (>= v_1_rtx_buf 0))
(assert
 (>= v_1_rcv_buf 0))
(assert
 (>= v_1_rx_chunk 0))
(assert
 (>= v_1_rx_slot_00 0))
(assert
 (>= v_1_rx_slot_01 0))
(assert
 (>= v_1_rx_slot_02 0))
(assert
 (>= v_1_rx_slot_03 0))
(assert
 (>= v_1_rx_slot_04 0))
(assert
 (>= v_1_rx_slot_05 0))
(assert
 (>= v_1_rx_slot_06 0))
(assert
 (>= v_1_rx_slot_07 0))
(assert
 (>= v_1_rx_slot_08 0))
(assert
 (>= v_1_rx_slot_09 0))
(assert
 (>= v_1_rx_slot_10 0))
(assert
 (>= v_1_rx_slot_11 0))
(assert
 (>= v_1_rx_slot_12 0))
(assert
 (>= v_1_rx_slot_13 0))
(assert
 (>= v_1_rx_slot_14 0))
(assert
 (>= v_1_rx_slot_15 0))
(assert
 (>= v_0_iss 0))
(assert
 (not (<= 4294967296 v_0_iss)))
(assert
 (>= v_0_irs 0))
(assert
 (not (<= 4294967296 v_0_irs)))
(assert
 (>= v_0_snd_una 0))
(assert
 (not (<= 4294967296 v_0_snd_una)))
(assert
 (>= v_0_snd_nxt 0))
(assert
 (not (<= 4294967296 v_0_snd_nxt)))
(assert
 (>= v_0_rcv_nxt 0))
(assert
 (not (<= 4294967296 v_0_rcv_nxt)))
(assert
 (>= v_0_tx_seq 0))
(assert
 (not (<= 4294967296 v_0_tx_seq)))
(assert
 (>= v_0_tx_ack 0))
(assert
 (not (<= 4294967296 v_0_tx_ack)))
(assert
 (>= v_0_snd_wl1 0))
(assert
 (not (<= 4294967296 v_0_snd_wl1)))
(assert
 (>= v_0_snd_wl2 0))
(assert
 (not (<= 4294967296 v_0_snd_wl2)))
(assert
 (>= v_0_fin_seq 0))
(assert
 (not (<= 4294967296 v_0_fin_seq)))
(assert
 (>= v_0_rx_fin_seq 0))
(assert
 (not (<= 4294967296 v_0_rx_fin_seq)))
(assert
 (>= v_0_rtt_end 0))
(assert
 (not (<= 4294967296 v_0_rtt_end)))
(assert
 (>= v_0_cc_before_una 0))
(assert
 (not (<= 4294967296 v_0_cc_before_una)))
(assert
 (>= v_0_fr_before_una 0))
(assert
 (not (<= 4294967296 v_0_fr_before_una)))
(assert
 (>= v_0_fr_before_nxt 0))
(assert
 (not (<= 4294967296 v_0_fr_before_nxt)))
(assert
 (>= v_0_lt_before_nxt 0))
(assert
 (not (<= 4294967296 v_0_lt_before_nxt)))
(assert
 (>= v_0_choice_before_nxt 0))
(assert
 (not (<= 4294967296 v_0_choice_before_nxt)))
(assert
 (>= v_0_cb_before_nxt 0))
(assert
 (not (<= 4294967296 v_0_cb_before_nxt)))
(assert
 (>= v_0_cb_append_end 0))
(assert
 (not (<= 4294967296 v_0_cb_append_end)))
(assert
 (>= v_0_cb_end_00 0))
(assert
 (not (<= 4294967296 v_0_cb_end_00)))
(assert
 (>= v_0_cb_end_01 0))
(assert
 (not (<= 4294967296 v_0_cb_end_01)))
(assert
 (>= v_0_cb_end_02 0))
(assert
 (not (<= 4294967296 v_0_cb_end_02)))
(assert
 (>= v_0_cb_end_03 0))
(assert
 (not (<= 4294967296 v_0_cb_end_03)))
(assert
 (>= v_0_cb_end_04 0))
(assert
 (not (<= 4294967296 v_0_cb_end_04)))
(assert
 (>= v_0_cb_end_05 0))
(assert
 (not (<= 4294967296 v_0_cb_end_05)))
(assert
 (>= v_0_cb_end_06 0))
(assert
 (not (<= 4294967296 v_0_cb_end_06)))
(assert
 (>= v_0_cb_end_07 0))
(assert
 (not (<= 4294967296 v_0_cb_end_07)))
(assert
 (>= v_0_cb_end_08 0))
(assert
 (not (<= 4294967296 v_0_cb_end_08)))
(assert
 (>= v_0_cb_end_09 0))
(assert
 (not (<= 4294967296 v_0_cb_end_09)))
(assert
 (>= v_0_cb_end_10 0))
(assert
 (not (<= 4294967296 v_0_cb_end_10)))
(assert
 (>= v_0_cb_end_11 0))
(assert
 (not (<= 4294967296 v_0_cb_end_11)))
(assert
 (>= v_0_cb_end_12 0))
(assert
 (not (<= 4294967296 v_0_cb_end_12)))
(assert
 (>= v_0_cb_end_13 0))
(assert
 (not (<= 4294967296 v_0_cb_end_13)))
(assert
 (>= v_0_cb_end_14 0))
(assert
 (not (<= 4294967296 v_0_cb_end_14)))
(assert
 (>= v_0_cb_end_15 0))
(assert
 (not (<= 4294967296 v_0_cb_end_15)))
(assert
 (>= v_1_iss 0))
(assert
 (not (<= 4294967296 v_1_iss)))
(assert
 (>= v_1_irs 0))
(assert
 (not (<= 4294967296 v_1_irs)))
(assert
 (>= v_1_snd_una 0))
(assert
 (not (<= 4294967296 v_1_snd_una)))
(assert
 (>= v_1_snd_nxt 0))
(assert
 (not (<= 4294967296 v_1_snd_nxt)))
(assert
 (>= v_1_rcv_nxt 0))
(assert
 (not (<= 4294967296 v_1_rcv_nxt)))
(assert
 (>= v_1_tx_seq 0))
(assert
 (not (<= 4294967296 v_1_tx_seq)))
(assert
 (>= v_1_tx_ack 0))
(assert
 (not (<= 4294967296 v_1_tx_ack)))
(assert
 (>= v_1_snd_wl1 0))
(assert
 (not (<= 4294967296 v_1_snd_wl1)))
(assert
 (>= v_1_snd_wl2 0))
(assert
 (not (<= 4294967296 v_1_snd_wl2)))
(assert
 (>= v_1_fin_seq 0))
(assert
 (not (<= 4294967296 v_1_fin_seq)))
(assert
 (>= v_1_rx_fin_seq 0))
(assert
 (not (<= 4294967296 v_1_rx_fin_seq)))
(assert
 (>= v_1_rtt_end 0))
(assert
 (not (<= 4294967296 v_1_rtt_end)))
(assert
 (>= v_1_cc_before_una 0))
(assert
 (not (<= 4294967296 v_1_cc_before_una)))
(assert
 (>= v_1_fr_before_una 0))
(assert
 (not (<= 4294967296 v_1_fr_before_una)))
(assert
 (>= v_1_fr_before_nxt 0))
(assert
 (not (<= 4294967296 v_1_fr_before_nxt)))
(assert
 (>= v_1_lt_before_nxt 0))
(assert
 (not (<= 4294967296 v_1_lt_before_nxt)))
(assert
 (>= v_1_choice_before_nxt 0))
(assert
 (not (<= 4294967296 v_1_choice_before_nxt)))
(assert
 (>= v_1_cb_before_nxt 0))
(assert
 (not (<= 4294967296 v_1_cb_before_nxt)))
(assert
 (>= v_1_cb_append_end 0))
(assert
 (not (<= 4294967296 v_1_cb_append_end)))
(assert
 (>= v_1_cb_end_00 0))
(assert
 (not (<= 4294967296 v_1_cb_end_00)))
(assert
 (>= v_1_cb_end_01 0))
(assert
 (not (<= 4294967296 v_1_cb_end_01)))
(assert
 (>= v_1_cb_end_02 0))
(assert
 (not (<= 4294967296 v_1_cb_end_02)))
(assert
 (>= v_1_cb_end_03 0))
(assert
 (not (<= 4294967296 v_1_cb_end_03)))
(assert
 (>= v_1_cb_end_04 0))
(assert
 (not (<= 4294967296 v_1_cb_end_04)))
(assert
 (>= v_1_cb_end_05 0))
(assert
 (not (<= 4294967296 v_1_cb_end_05)))
(assert
 (>= v_1_cb_end_06 0))
(assert
 (not (<= 4294967296 v_1_cb_end_06)))
(assert
 (>= v_1_cb_end_07 0))
(assert
 (not (<= 4294967296 v_1_cb_end_07)))
(assert
 (>= v_1_cb_end_08 0))
(assert
 (not (<= 4294967296 v_1_cb_end_08)))
(assert
 (>= v_1_cb_end_09 0))
(assert
 (not (<= 4294967296 v_1_cb_end_09)))
(assert
 (>= v_1_cb_end_10 0))
(assert
 (not (<= 4294967296 v_1_cb_end_10)))
(assert
 (>= v_1_cb_end_11 0))
(assert
 (not (<= 4294967296 v_1_cb_end_11)))
(assert
 (>= v_1_cb_end_12 0))
(assert
 (not (<= 4294967296 v_1_cb_end_12)))
(assert
 (>= v_1_cb_end_13 0))
(assert
 (not (<= 4294967296 v_1_cb_end_13)))
(assert
 (>= v_1_cb_end_14 0))
(assert
 (not (<= 4294967296 v_1_cb_end_14)))
(assert
 (>= v_1_cb_end_15 0))
(assert
 (not (<= 4294967296 v_1_cb_end_15)))
(assert
 true)
(assert
 true)
(assert
 (>= now_0 0))
(assert
 (let (($x53452 (>= due_0_rtx now_0)))
 (let (($x1634 (not active_0_rtx)))
 (or $x1634 $x53452))))
(assert
 (let (($x53465 (>= due_0_user now_0)))
 (let (($x1636 (not active_0_user)))
 (or $x1636 $x53465))))
(assert
 (let (($x53470 (>= due_0_time_wait now_0)))
 (let (($x1638 (not active_0_time_wait)))
 (or $x1638 $x53470))))
(assert
 (let (($x53861 (>= due_0_delack now_0)))
 (let (($x1640 (not active_0_delack)))
 (or $x1640 $x53861))))
(assert
 (let (($x42155 (>= due_0_persist now_0)))
 (let (($x1642 (not active_0_persist)))
 (or $x1642 $x42155))))
(assert
 (>= input_0_app.send_data 0))
(assert
 (>= input_0_net.data_data 0))
(assert
 (>= input_0_net.fin_segment_data 0))
(assert
 (>= input_0_net.syn_seq 0))
(assert
 (not (<= 4294967296 input_0_net.syn_seq)))
(assert
 (>= input_0_net.synack_seq 0))
(assert
 (not (<= 4294967296 input_0_net.synack_seq)))
(assert
 (>= input_0_net.synack_ack 0))
(assert
 (not (<= 4294967296 input_0_net.synack_ack)))
(assert
 (>= input_0_net.ack_seq 0))
(assert
 (not (<= 4294967296 input_0_net.ack_seq)))
(assert
 (>= input_0_net.ack_ack 0))
(assert
 (not (<= 4294967296 input_0_net.ack_ack)))
(assert
 (>= input_0_net.fin_seq 0))
(assert
 (not (<= 4294967296 input_0_net.fin_seq)))
(assert
 (>= input_0_net.fin_ack 0))
(assert
 (not (<= 4294967296 input_0_net.fin_ack)))
(assert
 (>= input_0_net.rst_seq 0))
(assert
 (not (<= 4294967296 input_0_net.rst_seq)))
(assert
 (>= input_0_net.rstack_seq 0))
(assert
 (not (<= 4294967296 input_0_net.rstack_seq)))
(assert
 (>= input_0_net.rstack_ack 0))
(assert
 (not (<= 4294967296 input_0_net.rstack_ack)))
(assert
 (>= input_0_net.data_seq 0))
(assert
 (not (<= 4294967296 input_0_net.data_seq)))
(assert
 (>= input_0_net.data_ack 0))
(assert
 (not (<= 4294967296 input_0_net.data_ack)))
(assert
 (>= input_0_net.fin_segment_seq 0))
(assert
 (not (<= 4294967296 input_0_net.fin_segment_seq)))
(assert
 (>= input_0_net.fin_segment_ack 0))
(assert
 (not (<= 4294967296 input_0_net.fin_segment_ack)))
(assert
 (let (($x7097 (= due_1_persist due_0_persist)))
 (let (($x2789 (= due_1_delack due_0_delack)))
 (let (($x2788 (= due_1_time_wait due_0_time_wait)))
 (let (($x3491 (= due_1_user due_0_user)))
 (let (($x7096 (= due_1_rtx due_0_rtx)))
 (let (($x22670 (not active_1_persist)))
 (let (($x22669 (not active_1_delack)))
 (let (($x3537 (= active_1_time_wait active_0_time_wait)))
 (let (($x3872 (= active_1_user active_0_user)))
 (let (($x7093 (= active_1_rtx active_0_rtx)))
 (let (($x22665 (not v_1_cb_done_15)))
 (let ((?x1768 (+ v_0_snd_buf v_0_rtx_buf)))
 (let ((?x55479 (ite (<= 0 ?x1768) ?x1768 0)))
 (let (($x54275 (<= 1 ?x55479)))
 (let (($x22664 (not v_1_cb_done_14)))
 (let (($x22663 (not v_1_cb_done_13)))
 (let (($x22662 (not v_1_cb_done_12)))
 (let (($x22661 (not v_1_cb_done_11)))
 (let (($x22660 (not v_1_cb_done_10)))
 (let (($x22659 (not v_1_cb_done_09)))
 (let (($x22658 (not v_1_cb_done_08)))
 (let (($x22657 (not v_1_cb_done_07)))
 (let (($x22656 (not v_1_cb_done_06)))
 (let (($x22655 (not v_1_cb_done_05)))
 (let (($x22654 (not v_1_cb_done_04)))
 (let (($x22653 (not v_1_cb_done_03)))
 (let (($x22652 (not v_1_cb_done_02)))
 (let (($x22651 (not v_1_cb_done_01)))
 (let (($x22650 (not v_1_cb_done_00)))
 (let (($x22649 (not v_1_cb_is_new)))
 (let (($x22648 (= v_1_cb_append_end 0)))
 (let (($x2730 (= v_1_cb_before_nxt v_0_snd_nxt)))
 (let ((?x22608 (+ v_0_cb_length_00 v_0_cb_length_01 v_0_cb_length_02 v_0_cb_length_03 v_0_cb_length_04 v_0_cb_length_05 v_0_cb_length_06 v_0_cb_length_07 v_0_cb_length_08 v_0_cb_length_09 v_0_cb_length_10 v_0_cb_length_11 v_0_cb_length_12 v_0_cb_length_13 v_0_cb_length_14 v_0_cb_length_15)))
 (let ((?x41104 (ite $x54275 ?x22608 0)))
 (let (($x22033 (= v_1_cb_acked_total v_0_cb_acked_total)))
 (let (($x22032 (= v_1_cb_emitted_total v_0_cb_emitted_total)))
 (let ((?x56164 (ite $x54275 0 v_0_cb_length_15)))
 (let ((?x59534 (ite $x54275 0 v_0_cb_length_14)))
 (let ((?x58029 (ite $x54275 0 v_0_cb_length_13)))
 (let ((?x48377 (ite $x54275 0 v_0_cb_length_12)))
 (let ((?x59873 (ite $x54275 0 v_0_cb_length_11)))
 (let ((?x44468 (ite $x54275 0 v_0_cb_length_10)))
 (let ((?x45921 (ite $x54275 0 v_0_cb_length_09)))
 (let ((?x58567 (ite $x54275 0 v_0_cb_length_08)))
 (let ((?x53005 (ite $x54275 0 v_0_cb_length_07)))
 (let ((?x44898 (ite $x54275 0 v_0_cb_length_06)))
 (let ((?x55157 (ite $x54275 0 v_0_cb_length_05)))
 (let ((?x43438 (ite $x54275 0 v_0_cb_length_04)))
 (let ((?x55989 (ite $x54275 0 v_0_cb_length_03)))
 (let ((?x45760 (ite $x54275 0 v_0_cb_length_02)))
 (let ((?x44222 (ite $x54275 0 v_0_cb_length_01)))
 (let ((?x59412 (ite $x54275 0 v_0_cb_length_00)))
 (let ((?x47937 (+ ?x59412 ?x44222 ?x45760 ?x55989 ?x43438 ?x55157 ?x44898 ?x53005 ?x58567 ?x45921 ?x44468 ?x59873 ?x48377 ?x58029 ?x59534 ?x56164)))
 (let (($x22607 (= v_1_cb_step_bytes 0)))
 (let (($x22606 (= v_1_cb_retired_count 0)))
 (let (($x22605 (= v_1_cb_append_length 0)))
 (let (($x22604 (= v_1_cb_new_count 0)))
 (let ((?x54599 (ite $x54275 0 v_0_cb_tail)))
 (let ((?x56070 (ite $x54275 0 (ite (<= 16 v_0_cb_head) (+ (- 16) v_0_cb_head) v_0_cb_head))))
 (let (($x22021 (= v_1_svc_acked_bytes v_0_svc_acked_bytes)))
 (let (($x22020 (= v_1_svc_written_bytes v_0_svc_written_bytes)))
 (let (($x2712 (= 0 v_1_svc_ack_step)))
 (let (($x2711 (= 0 v_1_svc_accept_step)))
 (let (($x2710 (= v_1_svc_before_total ?x1768)))
 (let (($x2709 (= 0 v_1_sched_packets)))
 (let (($x2708 (= 0 v_1_sched_bytes)))
 (let (($x2707 (= 0 v_1_sched_cause)))
 (let (($x2706 (= v_1_sched_at_ms v_0_sched_at_ms)))
 (let (($x22337 (not v_1_sched_open)))
 (let (($x2704 (= v_1_choice_before_flight v_0_choice_before_flight)))
 (let (($x2703 (= v_1_choice_before_nxt v_0_choice_before_nxt)))
 (let (($x2702 (= v_1_choice_limit v_0_choice_limit)))
 (let (($x2701 (= v_1_choice_count v_0_choice_count)))
 (let (($x22336 (not v_1_choice_used)))
 (let (($x2698 (= v_1_lt_before_window v_0_snd_wnd)))
 (let (($x2697 (= v_1_lt_before_flight v_0_rtx_buf)))
 (let (($x2696 (= v_1_lt_before_nxt v_0_snd_nxt)))
 (let (($x2695 (= v_1_lt_before_cwnd v_0_cc_cwnd)))
 (let (($x2694 (= v_1_lt_before_bytes v_0_lt_epoch_bytes)))
 (let (($x22330 (= v_1_lt_epoch_packets 0)))
 (let (($x22328 (= v_1_lt_epoch_bytes 0)))
 (let (($x2691 (= 0 v_1_lt_take)))
 (let (($x22327 (not v_1_lt_emitted)))
 (let (($x22325 (not v_1_lt_eligible)))
 (let (($x2688 (= 0 v_1_idle_restart_count)))
 (let (($x2687 (= v_1_idle_before_threshold v_0_cc_ssthresh)))
 (let (($x2686 (= v_1_idle_before_rto v_0_rto_ms)))
 (let (($x2685 (= v_1_idle_before_cwnd v_0_cc_cwnd)))
 (let ((?x22320 (* (- 1) v_0_idle_last_data_ms)))
 (let ((?x36773 (+ now_1 ?x22320)))
 (let (($x22319 (not v_1_idle_restart)))
 (let (($x22318 (not v_1_idle_data_emitted)))
 (let (($x2681 (= v_1_idle_event_ms now_1)))
 (let (($x7045 (= v_1_idle_last_data_ms v_0_idle_last_data_ms)))
 (let (($x22310 (not v_1_idle_data_valid)))
 (let (($x2678 (= 0 v_1_fr_entries)))
 (let (($x22309 (= v_1_fr_emit_count 0)))
 (let (($x22308 (not v_1_fr_retransmitted)))
 (let (($x22751 (not v_1_fr_exited)))
 (let (($x22306 (not v_1_fr_extra)))
 (let (($x22305 (not v_1_fr_entered)))
 (let (($x22304 (not v_1_fr_duplicate)))
 (let (($x2671 (= v_1_fr_before_retries v_0_retries)))
 (let (($x2670 (= v_1_fr_before_rto v_0_rto_ms)))
 (let (($x2669 (= v_1_fr_before_flight v_0_rtx_buf)))
 (let (($x2668 (= v_1_fr_before_nxt v_0_snd_nxt)))
 (let (($x2667 (= v_1_fr_before_una v_0_snd_una)))
 (let (($x2666 (= v_1_fr_was_active v_0_fr_active)))
 (let (($x2665 (= v_1_fr_last_window v_0_fr_last_window)))
 (let (($x22303 (not v_1_fr_window_valid)))
 (let (($x22302 (= v_1_fr_dupacks 0)))
 (let (($x22301 (not v_1_fr_active)))
 (let (($x2661 (= v_1_fr_before_window_valid v_0_fr_window_valid)))
 (let (($x2660 (= v_1_fr_before_wire_window v_0_fr_last_window)))
 (let (($x22300 (not v_1_fr_window_ignored)))
 (let (($x22750 (not v_1_cc_rto_15)))
 (let (($x22749 (not v_1_cc_rto_14)))
 (let (($x22748 (not v_1_cc_rto_13)))
 (let (($x22747 (not v_1_cc_rto_12)))
 (let (($x22746 (not v_1_cc_rto_11)))
 (let (($x22745 (not v_1_cc_rto_10)))
 (let (($x22744 (not v_1_cc_rto_09)))
 (let (($x22743 (not v_1_cc_rto_08)))
 (let (($x22742 (not v_1_cc_rto_07)))
 (let (($x22741 (not v_1_cc_rto_06)))
 (let (($x22740 (not v_1_cc_rto_05)))
 (let (($x22739 (not v_1_cc_rto_04)))
 (let (($x22738 (not v_1_cc_rto_03)))
 (let (($x22737 (not v_1_cc_rto_02)))
 (let (($x22736 (not v_1_cc_rto_01)))
 (let (($x22735 (not v_1_cc_rto_00)))
 (let (($x2642 (= 0 v_1_cc_new_sent)))
 (let ((?x22243 (* (- 1) v_0_rtx_buf)))
 (let ((?x48034 (+ (ite (<= v_0_cc_cwnd v_0_snd_wnd) v_0_cc_cwnd v_0_snd_wnd) ?x22243)))
 (let (($x22236 (= v_1_cc_before_cwnd v_0_cc_cwnd)))
 (let (($x2639 (= 0 v_1_cc_growth)))
 (let (($x2638 (= 0 v_1_cc_threshold_updates)))
 (let (($x22235 (not v_1_cc_threshold_changed)))
 (let (($x22233 (not v_1_cc_loss)))
 (let (($x2635 (= v_1_cc_before_window v_0_snd_wnd)))
 (let (($x2634 (= v_1_cc_before_persist v_0_persist_active)))
 (let (($x2633 (= v_1_cc_before_una v_0_snd_una)))
 (let (($x2632 (= v_1_cc_before_flight v_0_rtx_buf)))
 (let (($x2631 (= 0 v_1_cc_acked)))
 (let (($x22232 (= v_1_cc_ca_credit 0)))
 (let (($x22231 (= v_1_cc_ssthresh v_0_cc_initial_threshold)))
 (let (($x22734 (= v_1_cc_cwnd v_0_cc_initial_window)))
 (let (($x2627 (= v_1_cc_initial_threshold v_0_cc_initial_threshold)))
 (let (($x2626 (= v_1_cc_initial_window v_0_cc_initial_window)))
 (let (($x2625 (= v_1_persist_elapsed_ms v_0_persist_elapsed_ms)))
 (let (($x22227 (= v_1_persist_probes 0)))
 (let (($x22226 (= v_1_persist_deadline_ms 0)))
 (let (($x22225 (= v_1_persist_last_ms 0)))
 (let (($x22224 (= v_1_persist_since_ms 0)))
 (let (($x2620 (= v_1_persist_previous_interval_ms v_0_persist_previous_interval_ms)))
 (let (($x22223 (= v_1_persist_interval_ms 1000)))
 (let (($x22222 (not v_1_persist_probe_new)))
 (let (($x22221 (not v_1_persist_probe_sent)))
 (let (($x22220 (not v_1_persist_first)))
 (let (($x2615 (= v_1_persist_was_active v_0_persist_active)))
 (let (($x22219 (not v_1_persist_start)))
 (let (($x22218 (not v_1_persist_eligible)))
 (let (($x22217 (not v_1_persist_active)))
 (let (($x22216 (not v_1_ack_defer_now)))
 (let (($x22215 (not v_1_ack_defer_candidate)))
 (let (($x2609 (= v_1_ack_rmss v_0_ack_rmss)))
 (let (($x2608 (= v_1_ack_delay_ms v_0_ack_delay_ms)))
 (let (($x22214 (= v_1_ack_full_segments 0)))
 (let (($x22213 (= v_1_ack_bytes 0)))
 (let (($x22212 (= v_1_ack_since_ms 0)))
 (let (($x22211 (not v_1_ack_pending)))
 (let (($x22733 (not v_1_syn_timeout_eligible)))
 (let (($x22732 (not v_1_tx_syn_pending)))
 (let (($x22731 (= v_1_tx_syn_time 0)))
 (let (($x22209 (not v_1_tx_waiting)))
 (let (($x2599 (= v_1_tx_is_fin v_0_tx_is_fin)))
 (let (($x2598 (= v_1_tx_previous_rto v_0_tx_previous_rto)))
 (let (($x2597 (= v_1_tx_elapsed v_0_tx_elapsed)))
 (let (($x22208 (not v_1_tx_retransmitted)))
 (let (($x2595 (= v_1_tx_max_previous v_0_tx_max_previous)))
 (let (($x2594 (= v_1_tx_eligible v_0_tx_eligible)))
 (let (($x2593 (= v_1_tx_emit_count v_0_tx_emit_count)))
 (let (($x22730 (= v_1_tx_fin_time 0)))
 (let (($x22729 (= v_1_tx_time_15 0)))
 (let (($x22728 (= v_1_tx_time_14 0)))
 (let (($x22727 (= v_1_tx_time_13 0)))
 (let (($x22726 (= v_1_tx_time_12 0)))
 (let (($x22725 (= v_1_tx_time_11 0)))
 (let (($x22724 (= v_1_tx_time_10 0)))
 (let (($x22723 (= v_1_tx_time_09 0)))
 (let (($x22722 (= v_1_tx_time_08 0)))
 (let (($x22721 (= v_1_tx_time_07 0)))
 (let (($x22720 (= v_1_tx_time_06 0)))
 (let (($x22719 (= v_1_tx_time_05 0)))
 (let (($x22718 (= v_1_tx_time_04 0)))
 (let (($x22717 (= v_1_tx_time_03 0)))
 (let (($x22716 (= v_1_tx_time_02 0)))
 (let (($x22715 (= v_1_tx_time_01 0)))
 (let (($x22714 (= v_1_tx_time_00 0)))
 (let (($x22156 (= v_1_rto_base_ms 1000)))
 (let (($x22155 (= v_1_rtt_samples 0)))
 (let (($x22154 (= v_1_rtt_last_ms 0)))
 (let (($x22153 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x22152 (not v_1_rtt_sample_used)))
 (let (($x22713 (not v_1_rtt_start_new)))
 (let (($x22711 (= v_1_rtt_remaining 0)))
 (let (($x22710 (= v_1_rtt_end 0)))
 (let (($x22712 (= v_1_rtt_start_ms 0)))
 (let (($x22146 (= v_1_rtt_sample_at_ms 0)))
 (let (($x22148 (not v_1_rtt_ambiguous)))
 (let (($x22709 (not v_1_rtt_active)))
 (let (($x22144 (not v_1_rtt_previous_measured)))
 (let (($x22143 (not v_1_rtt_measured)))
 (let (($x22142 (= v_1_rtt_previous_var 0.0)))
 (let (($x22141 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x22140 (= v_1_rtt_error_ms 0.0)))
 (let (($x22139 (= v_1_rttvar_ms 0.0)))
 (let (($x22136 (= v_1_srtt_ms 0.0)))
 (let (($x22708 (not v_1_rx_fin_consumed)))
 (let (($x22706 (not v_1_rx_fin_done)))
 (let (($x3344 (= 0 v_1_rx_fin_offset)))
 (let (($x2553 (= v_1_rx_fin_seq v_0_rx_fin_seq)))
 (let (($x22705 (not v_1_rx_fin_pending)))
 (let (($x2551 (= v_1_fin_acknowledged v_0_fin_acknowledged)))
 (let (($x2550 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x22704 (not v_1_fin_sent)))
 (let (($x22683 (not v_1_fin_requested)))
 (let (($x2547 (= v_1_ack_window_update v_0_ack_window_update)))
 (let (($x2546 (= v_1_ack_advance v_0_ack_advance)))
 (let (($x2545 (= v_1_ack_is_future v_0_ack_is_future)))
 (let (($x2544 (= v_1_ack_is_new v_0_ack_is_new)))
 (let (($x2543 (= v_1_ack_delta v_0_ack_delta)))
 (let (($x2542 (= v_1_seg_acceptable v_0_seg_acceptable)))
 (let (($x2541 (= v_1_rx_acceptable v_0_rx_acceptable)))
 (let (($x2540 (= v_1_rx_advance v_0_rx_advance)))
 (let (($x3340 (= 0 v_1_rx_slot_15)))
 (let (($x3339 (= 0 v_1_rx_slot_14)))
 (let (($x3338 (= 0 v_1_rx_slot_13)))
 (let (($x3337 (= 0 v_1_rx_slot_12)))
 (let (($x3336 (= 0 v_1_rx_slot_11)))
 (let (($x3335 (= 0 v_1_rx_slot_10)))
 (let (($x3334 (= 0 v_1_rx_slot_09)))
 (let (($x3333 (= 0 v_1_rx_slot_08)))
 (let (($x3332 (= 0 v_1_rx_slot_07)))
 (let (($x3331 (= 0 v_1_rx_slot_06)))
 (let (($x3330 (= 0 v_1_rx_slot_05)))
 (let (($x3329 (= 0 v_1_rx_slot_04)))
 (let (($x3328 (= 0 v_1_rx_slot_03)))
 (let (($x3327 (= 0 v_1_rx_slot_02)))
 (let (($x3326 (= 0 v_1_rx_slot_01)))
 (let (($x3325 (= 0 v_1_rx_slot_00)))
 (let (($x2523 (= v_1_rx_chunk v_0_rx_chunk)))
 (let (($x2522 (= v_1_take v_0_take)))
 (let (($x2521 (= v_1_snd_wl2 v_0_snd_wl2)))
 (let (($x2520 (= v_1_snd_wl1 v_0_snd_wl1)))
 (let (($x2519 (= v_1_snd_wnd v_0_snd_wnd)))
 (let (($x3324 (= 0 v_1_rcv_buf)))
 (let (($x3323 (= 0 v_1_rtx_buf)))
 (let (($x3322 (= 0 v_1_snd_buf)))
 (let (($x3321 (= 16 v_1_local_window)))
 (let (($x2514 (= v_1_msl_ms v_0_msl_ms)))
 (let (($x2513 (= v_1_user_timeout_ms v_0_user_timeout_ms)))
 (let (($x3528 (= v_1_active_open v_0_active_open)))
 (let (($x3319 (= v_1_retries v_0_retries)))
 (let (($x3318 (= v_1_rto_ms v_0_rto_ms)))
 (let (($x3317 (= v_1_tx_flags v_0_tx_flags)))
 (let (($x3316 (= v_1_tx_ack v_0_tx_ack)))
 (let (($x3315 (= v_1_tx_seq v_0_tx_seq)))
 (let (($x2506 (= v_1_rcv_nxt v_0_rcv_nxt)))
 (let (($x3314 (= v_1_snd_nxt v_0_snd_nxt)))
 (let (($x3313 (= v_1_snd_una v_0_snd_una)))
 (let (($x2503 (= v_1_irs v_0_irs)))
 (let (($x2502 (= v_1_iss v_0_iss)))
 (let (($x1756 (>= now_1 now_0)))
 (and $x1756 (or (not active_0_rtx) (not (<= due_0_rtx now_1))) (or (not active_0_user) (not (<= due_0_user now_1))) (or (not active_0_time_wait) (not (<= due_0_time_wait now_1))) (or (not active_0_delack) (not (<= due_0_delack now_1))) (or (not active_0_persist) (not (<= due_0_persist now_1))) $x2502 $x2503 $x3313 $x3314 $x2506 $x3315 $x3316 $x3317 $x3318 $x3319 $x3528 $x2513 $x2514 $x3321 $x3322 $x3323 $x3324 $x2519 $x2520 $x2521 $x2522 $x2523 $x3325 $x3326 $x3327 $x3328 $x3329 $x3330 $x3331 $x3332 $x3333 $x3334 $x3335 $x3336 $x3337 $x3338 $x3339 $x3340 $x2540 $x2541 $x2542 $x2543 $x2544 $x2545 $x2546 $x2547 $x22683 $x22704 $x2550 $x2551 $x22705 $x2553 $x3344 $x22706 $x22708 $x22136 $x22139 $x22140 $x22141 $x22142 $x22143 $x22144 $x22709 $x22148 $x22146 $x22712 $x22710 $x22711 $x22713 $x22152 $x22153 $x22154 $x22155 $x22156 $x22714 $x22715 $x22716 $x22717 $x22718 $x22719 $x22720 $x22721 $x22722 $x22723 $x22724 $x22725 $x22726 $x22727 $x22728 $x22729 $x22730 $x2593 $x2594 $x2595 $x22208 $x2597 $x2598 $x2599 $x22209 $x22731 $x22732 $x22733 $x22211 $x22212 $x22213 $x22214 $x2608 $x2609 $x22215 $x22216 $x22217 $x22218 $x22219 $x2615 $x22220 $x22221 $x22222 $x22223 $x2620 $x22224 $x22225 $x22226 $x22227 $x2625 $x2626 $x2627 $x22734 $x22231 $x22232 $x2631 $x2632 $x2633 $x2634 $x2635 $x22233 $x22235 $x2638 $x2639 $x22236 (= v_1_cc_send_budget (ite (<= 0 ?x48034) ?x48034 0)) $x2642 $x22735 $x22736 $x22737 $x22738 $x22739 $x22740 $x22741 $x22742 $x22743 $x22744 $x22745 $x22746 $x22747 $x22748 $x22749 $x22750 $x22300 $x2660 $x2661 $x22301 $x22302 $x22303 $x2665 $x2666 $x2667 $x2668 $x2669 $x2670 $x2671 $x22304 $x22305 $x22306 $x22751 $x22308 $x22309 $x2678 $x22310 $x7045 $x2681 $x22318 $x22319 (= v_1_idle_elapsed_ms (ite v_0_idle_data_valid ?x36773 0)) $x2685 $x2686 $x2687 $x2688 $x22325 $x22327 $x2691 $x22328 $x22330 $x2694 $x2695 $x2696 $x2697 $x2698 (= v_1_lt_loss_flight (+ v_0_rtx_buf (* (- 1) v_0_lt_epoch_bytes))) $x22336 $x2701 $x2702 $x2703 $x2704 $x22337 $x2706 $x2707 $x2708 $x2709 $x2710 $x2711 $x2712 (= v_1_svc_drop_step ?x55479) $x22020 $x22021 (= v_1_svc_abandoned_bytes (+ v_0_svc_abandoned_bytes ?x55479)) (= v_1_cb_head ?x56070) (= v_1_cb_tail (ite (<= 16 ?x54599) (+ (- 16) ?x54599) ?x54599)) (= v_1_cb_count (ite $x54275 0 v_0_cb_count)) $x22604 $x22605 $x22606 $x22607 (= v_1_cb_live_total ?x47937) (= v_1_cb_partial_prefix ?x47937) $x22032 $x22033 (= v_1_cb_abandoned_total (+ v_0_cb_abandoned_total ?x41104)) (= v_1_cb_drop_step ?x41104) $x2730 $x22648 $x22649 (= v_1_cb_length_00 ?x59412) (= v_1_cb_end_00 (ite $x54275 0 v_0_cb_end_00)) $x22650 (= v_1_cb_length_01 ?x44222) (= v_1_cb_end_01 (ite $x54275 0 v_0_cb_end_01)) $x22651 (= v_1_cb_length_02 ?x45760) (= v_1_cb_end_02 (ite $x54275 0 v_0_cb_end_02)) $x22652 (= v_1_cb_length_03 ?x55989) (= v_1_cb_end_03 (ite $x54275 0 v_0_cb_end_03)) $x22653 (= v_1_cb_length_04 ?x43438) (= v_1_cb_end_04 (ite $x54275 0 v_0_cb_end_04)) $x22654 (= v_1_cb_length_05 ?x55157) (= v_1_cb_end_05 (ite $x54275 0 v_0_cb_end_05)) $x22655 (= v_1_cb_length_06 ?x44898) (= v_1_cb_end_06 (ite $x54275 0 v_0_cb_end_06)) $x22656 (= v_1_cb_length_07 ?x53005) (= v_1_cb_end_07 (ite $x54275 0 v_0_cb_end_07)) $x22657 (= v_1_cb_length_08 ?x58567) (= v_1_cb_end_08 (ite $x54275 0 v_0_cb_end_08)) $x22658 (= v_1_cb_length_09 ?x45921) (= v_1_cb_end_09 (ite $x54275 0 v_0_cb_end_09)) $x22659 (= v_1_cb_length_10 ?x44468) (= v_1_cb_end_10 (ite $x54275 0 v_0_cb_end_10)) $x22660 (= v_1_cb_length_11 ?x59873) (= v_1_cb_end_11 (ite $x54275 0 v_0_cb_end_11)) $x22661 (= v_1_cb_length_12 ?x48377) (= v_1_cb_end_12 (ite $x54275 0 v_0_cb_end_12)) $x22662 (= v_1_cb_length_13 ?x58029) (= v_1_cb_end_13 (ite $x54275 0 v_0_cb_end_13)) $x22663 (= v_1_cb_length_14 ?x59534) (= v_1_cb_end_14 (ite $x54275 0 v_0_cb_end_14)) $x22664 (= v_1_cb_length_15 ?x56164) (= v_1_cb_end_15 (ite $x54275 0 v_0_cb_end_15)) $x22665 $x7093 $x3872 $x3537 $x22669 $x22670 $x7096 $x3491 $x2788 $x2789 $x7097))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 (not active_0_rtx))
(assert
 (not active_0_user))
(assert
 (not active_0_time_wait))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 (<= 1000 v_0_rto_ms))
(assert
 (<= 0 v_0_retries))
(assert
 (<= 1 v_0_msl_ms))
(assert
 (<= 1 v_0_user_timeout_ms))
(assert
 true)
(assert
 (let ((?x1768 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1768)))
(assert
 (>= 16 v_0_rcv_buf))
(assert
 (let (($x44387 (>= 65535 v_0_snd_wnd)))
 (let (($x2901 (<= 0 v_0_snd_wnd)))
 (and $x2901 $x44387))))
(assert
 (let ((?x29020 (* (- 1) v_0_rcv_buf)))
 (let ((?x29021 (+ 16 ?x29020)))
 (= v_0_local_window ?x29021))))
(assert
 (>= 1 v_0_rx_slot_00))
(assert
 (let (($x1115 (= 0 v_0_rx_slot_00)))
 (let (($x49074 (not (>= v_0_rcv_buf 16))))
 (or $x49074 $x1115))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x1117 (= 0 v_0_rx_slot_01)))
 (let (($x49077 (not (>= v_0_rcv_buf 15))))
 (or $x49077 $x1117))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x1119 (= 0 v_0_rx_slot_02)))
 (let (($x49069 (not (>= v_0_rcv_buf 14))))
 (or $x49069 $x1119))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x1121 (= 0 v_0_rx_slot_03)))
 (let (($x49054 (not (>= v_0_rcv_buf 13))))
 (or $x49054 $x1121))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x1123 (= 0 v_0_rx_slot_04)))
 (let (($x49062 (not (>= v_0_rcv_buf 12))))
 (or $x49062 $x1123))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x1125 (= 0 v_0_rx_slot_05)))
 (let (($x49067 (not (>= v_0_rcv_buf 11))))
 (or $x49067 $x1125))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x1127 (= 0 v_0_rx_slot_06)))
 (let (($x49472 (not (>= v_0_rcv_buf 10))))
 (or $x49472 $x1127))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x1129 (= 0 v_0_rx_slot_07)))
 (let (($x49042 (not (>= v_0_rcv_buf 9))))
 (or $x49042 $x1129))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x1131 (= 0 v_0_rx_slot_08)))
 (let (($x49046 (not (>= v_0_rcv_buf 8))))
 (or $x49046 $x1131))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x1133 (= 0 v_0_rx_slot_09)))
 (let (($x49049 (not (>= v_0_rcv_buf 7))))
 (or $x49049 $x1133))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x1135 (= 0 v_0_rx_slot_10)))
 (let (($x49018 (not (>= v_0_rcv_buf 6))))
 (or $x49018 $x1135))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x1137 (= 0 v_0_rx_slot_11)))
 (let (($x49026 (not (>= v_0_rcv_buf 5))))
 (or $x49026 $x1137))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x1139 (= 0 v_0_rx_slot_12)))
 (let (($x49015 (not (>= v_0_rcv_buf 4))))
 (or $x49015 $x1139))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x1141 (= 0 v_0_rx_slot_13)))
 (let (($x53447 (not (>= v_0_rcv_buf 3))))
 (or $x53447 $x1141))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x1143 (= 0 v_0_rx_slot_14)))
 (let (($x53428 (not (>= v_0_rcv_buf 2))))
 (or $x53428 $x1143))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x1145 (= 0 v_0_rx_slot_15)))
 (let (($x53423 (not (>= v_0_rcv_buf 1))))
 (or $x53423 $x1145))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x53425 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x53425)))
(assert
 (let (($x44463 (>= 16 v_0_rx_advance)))
 (let (($x44461 (<= 0 v_0_rx_advance)))
 (and $x44461 $x44463))))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (let (($x44471 (>= 4294967295 v_0_ack_delta)))
 (let (($x44465 (<= 0 v_0_ack_delta)))
 (and $x44465 $x44471))))
(assert
 true)
(assert
 true)
(assert
 (not v_0_fin_sent))
(assert
 (not v_0_fin_requested))
(assert
 true)
(assert
 true)
(assert
 (let (($x1168 (not v_0_fin_sent)))
 (let (($x1100 (= 0 v_0_rtx_buf)))
 (let (($x1098 (= 0 v_0_snd_buf)))
 (and $x1098 $x1100 $x1168)))))
(assert
 (= 0 v_0_rcv_buf))
(assert
 (let (($x1145 (= 0 v_0_rx_slot_15)))
 (let (($x1143 (= 0 v_0_rx_slot_14)))
 (let (($x1141 (= 0 v_0_rx_slot_13)))
 (let (($x1139 (= 0 v_0_rx_slot_12)))
 (let (($x1137 (= 0 v_0_rx_slot_11)))
 (let (($x1135 (= 0 v_0_rx_slot_10)))
 (let (($x1133 (= 0 v_0_rx_slot_09)))
 (let (($x1131 (= 0 v_0_rx_slot_08)))
 (let (($x1129 (= 0 v_0_rx_slot_07)))
 (let (($x1127 (= 0 v_0_rx_slot_06)))
 (let (($x1125 (= 0 v_0_rx_slot_05)))
 (let (($x1123 (= 0 v_0_rx_slot_04)))
 (let (($x1121 (= 0 v_0_rx_slot_03)))
 (let (($x1119 (= 0 v_0_rx_slot_02)))
 (let (($x1117 (= 0 v_0_rx_slot_01)))
 (let (($x1115 (= 0 v_0_rx_slot_00)))
 (and $x1115 $x1117 $x1119 $x1121 $x1123 $x1125 $x1127 $x1129 $x1131 $x1133 $x1135 $x1137 $x1139 $x1141 $x1143 $x1145))))))))))))))))))
(assert
 (not v_0_rx_fin_done))
(assert
 (not v_0_rx_fin_pending))
(assert
 (let (($x53744 (<= 1 v_0_rx_fin_offset)))
 (let (($x53816 (= v_0_rx_fin_pending $x53744)))
 (let (($x14146 (>= 15 v_0_rx_fin_offset)))
 (let (($x53819 (<= 0 v_0_rx_fin_offset)))
 (and $x53819 $x14146 $x53816))))))
(assert
 (let ((?x53814 (mod (+ v_0_rcv_nxt v_0_rx_fin_offset) 4294967296)))
 (let (($x53815 (= v_0_rx_fin_seq ?x53814)))
 (let (($x1174 (not v_0_rx_fin_pending)))
 (or $x1174 $x53815)))))
(assert
 (let (($x1179 (not v_0_rx_fin_done)))
 (or $x1179 (= v_0_rcv_nxt (mod (+ 1 v_0_rx_fin_seq) 4294967296)))))
(assert
 (let (($x1115 (= 0 v_0_rx_slot_00)))
 (or (not (and v_0_rx_fin_pending (>= 0 v_0_rx_fin_offset))) $x1115)))
(assert
 (let (($x1117 (= 0 v_0_rx_slot_01)))
 (or (not (and v_0_rx_fin_pending (>= 1 v_0_rx_fin_offset))) $x1117)))
(assert
 (let (($x1119 (= 0 v_0_rx_slot_02)))
 (or (not (and v_0_rx_fin_pending (>= 2 v_0_rx_fin_offset))) $x1119)))
(assert
 (let (($x1121 (= 0 v_0_rx_slot_03)))
 (or (not (and v_0_rx_fin_pending (>= 3 v_0_rx_fin_offset))) $x1121)))
(assert
 (let (($x1123 (= 0 v_0_rx_slot_04)))
 (or (not (and v_0_rx_fin_pending (>= 4 v_0_rx_fin_offset))) $x1123)))
(assert
 (let (($x1125 (= 0 v_0_rx_slot_05)))
 (or (not (and v_0_rx_fin_pending (>= 5 v_0_rx_fin_offset))) $x1125)))
(assert
 (let (($x1127 (= 0 v_0_rx_slot_06)))
 (or (not (and v_0_rx_fin_pending (>= 6 v_0_rx_fin_offset))) $x1127)))
(assert
 (let (($x1129 (= 0 v_0_rx_slot_07)))
 (or (not (and v_0_rx_fin_pending (>= 7 v_0_rx_fin_offset))) $x1129)))
(assert
 (let (($x1131 (= 0 v_0_rx_slot_08)))
 (or (not (and v_0_rx_fin_pending (>= 8 v_0_rx_fin_offset))) $x1131)))
(assert
 (let (($x1133 (= 0 v_0_rx_slot_09)))
 (or (not (and v_0_rx_fin_pending (>= 9 v_0_rx_fin_offset))) $x1133)))
(assert
 (let (($x1135 (= 0 v_0_rx_slot_10)))
 (or (not (and v_0_rx_fin_pending (>= 10 v_0_rx_fin_offset))) $x1135)))
(assert
 (let (($x1137 (= 0 v_0_rx_slot_11)))
 (or (not (and v_0_rx_fin_pending (>= 11 v_0_rx_fin_offset))) $x1137)))
(assert
 (let (($x1139 (= 0 v_0_rx_slot_12)))
 (or (not (and v_0_rx_fin_pending (>= 12 v_0_rx_fin_offset))) $x1139)))
(assert
 (let (($x1141 (= 0 v_0_rx_slot_13)))
 (or (not (and v_0_rx_fin_pending (>= 13 v_0_rx_fin_offset))) $x1141)))
(assert
 (let (($x1143 (= 0 v_0_rx_slot_14)))
 (or (not (and v_0_rx_fin_pending (>= 14 v_0_rx_fin_offset))) $x1143)))
(assert
 (let (($x1145 (= 0 v_0_rx_slot_15)))
 (or (not (and v_0_rx_fin_pending (>= 15 v_0_rx_fin_offset))) $x1145)))
(assert
 (<= 0.0 v_0_srtt_ms))
(assert
 (<= 0.0 v_0_rttvar_ms))
(assert
 (<= 0.0 v_0_rtt_error_ms))
(assert
 (<= 0.0 v_0_rtt_previous_srtt))
(assert
 (<= 0.0 v_0_rtt_previous_var))
(assert
 (<= 0 v_0_rtt_start_ms))
(assert
 (<= 0 v_0_rtt_last_ms))
(assert
 (<= 0 v_0_rtt_samples))
(assert
 (let (($x53715 (>= 60000 v_0_rto_ms)))
 (let (($x53794 (>= v_0_rto_ms v_0_rto_base_ms)))
 (let (($x53714 (>= 60000 v_0_rto_base_ms)))
 (let (($x53720 (<= 1000 v_0_rto_base_ms)))
 (and $x53720 $x53714 $x53794 $x53715))))))
(assert
 (let ((?x53370 (* 4.0 v_0_rttvar_ms)))
 (let ((?x53291 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x53370)))
 (let ((?x23028 (* (- 1.0) v_0_srtt_ms)))
 (let ((?x53366 (+ ?x23028 (* (- 1.0) ?x53291))))
 (let ((?x53367 (to_int ?x53366)))
 (let ((?x53287 (* (- 1) ?x53367)))
 (let ((?x48254 (ite (<= ?x53367 (- 1000)) ?x53287 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x48254) 60000 ?x48254) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (not v_0_rtt_active))
(assert
 (let (($x1206 (= 0 v_0_rtt_remaining)))
 (or v_0_rtt_active $x1206)))
(assert
 true)
(assert
 (let ((?x23013 (* (- 1) v_0_rtt_start_ms)))
 (let ((?x44834 (+ v_0_rtt_sample_at_ms ?x23013)))
 (let (($x1215 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1213 (not v_0_rtt_sample_used)))
 (or $x1213 (and $x1215 v_0_rtt_measured (= v_0_rtt_last_ms ?x44834))))))))
(assert
 (let (($x51014 (<= v_0_rtt_sample_at_ms now_0)))
 (let (($x51011 (<= 0 v_0_rtt_sample_at_ms)))
 (and $x51011 $x51014))))
(assert
 (let ((?x51020 (to_real v_0_rtt_last_ms)))
 (let ((?x49300 (ite v_0_rtt_previous_measured (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x51020)) ?x51020)))
 (let ((?x44590 (* (- 1.0) v_0_rtt_previous_srtt)))
 (let ((?x42837 (+ ?x44590 ?x51020)))
 (let ((?x45627 (* (- 1.0) ?x51020)))
 (let ((?x51470 (+ v_0_rtt_previous_srtt ?x45627)))
 (let ((?x44836 (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* (/ 1.0 4.0) (ite (>= ?x51470 0.0) ?x51470 ?x42837)))))
 (let (($x53341 (= v_0_rttvar_ms (ite v_0_rtt_previous_measured ?x44836 (* (/ 1.0 2.0) ?x51020)))))
 (let (($x1213 (not v_0_rtt_sample_used)))
 (or $x1213 (and $x53341 (= v_0_srtt_ms ?x49300)))))))))))))
(assert
 (let (($x51057 (<= v_0_tx_time_00 now_0)))
 (let (($x8972 (<= 0 v_0_tx_time_00)))
 (and $x8972 $x51057 (or (not (>= 0 v_0_rtx_buf)) (= 0 v_0_tx_time_00))))))
(assert
 (let (($x51069 (<= v_0_tx_time_01 now_0)))
 (let (($x51064 (<= 0 v_0_tx_time_01)))
 (and $x51064 $x51069 (or (not (>= 1 v_0_rtx_buf)) (= 0 v_0_tx_time_01))))))
(assert
 (let (($x51081 (<= v_0_tx_time_02 now_0)))
 (let (($x51076 (<= 0 v_0_tx_time_02)))
 (and $x51076 $x51081 (or (not (>= 2 v_0_rtx_buf)) (= 0 v_0_tx_time_02))))))
(assert
 (let (($x51093 (<= v_0_tx_time_03 now_0)))
 (let (($x51088 (<= 0 v_0_tx_time_03)))
 (and $x51088 $x51093 (or (not (>= 3 v_0_rtx_buf)) (= 0 v_0_tx_time_03))))))
(assert
 (let (($x51105 (<= v_0_tx_time_04 now_0)))
 (let (($x51100 (<= 0 v_0_tx_time_04)))
 (and $x51100 $x51105 (or (not (>= 4 v_0_rtx_buf)) (= 0 v_0_tx_time_04))))))
(assert
 (let (($x51111 (<= v_0_tx_time_05 now_0)))
 (let (($x51109 (<= 0 v_0_tx_time_05)))
 (and $x51109 $x51111 (or (not (>= 5 v_0_rtx_buf)) (= 0 v_0_tx_time_05))))))
(assert
 (let (($x51117 (<= v_0_tx_time_06 now_0)))
 (let (($x51115 (<= 0 v_0_tx_time_06)))
 (and $x51115 $x51117 (or (not (>= 6 v_0_rtx_buf)) (= 0 v_0_tx_time_06))))))
(assert
 (let (($x51123 (<= v_0_tx_time_07 now_0)))
 (let (($x51121 (<= 0 v_0_tx_time_07)))
 (and $x51121 $x51123 (or (not (>= 7 v_0_rtx_buf)) (= 0 v_0_tx_time_07))))))
(assert
 (let (($x51519 (<= v_0_tx_time_08 now_0)))
 (let (($x51019 (<= 0 v_0_tx_time_08)))
 (and $x51019 $x51519 (or (not (>= 8 v_0_rtx_buf)) (= 0 v_0_tx_time_08))))))
(assert
 (let (($x53757 (<= v_0_tx_time_09 now_0)))
 (let (($x51031 (<= 0 v_0_tx_time_09)))
 (and $x51031 $x53757 (or (not (>= 9 v_0_rtx_buf)) (= 0 v_0_tx_time_09))))))
(assert
 (let (($x47276 (<= v_0_tx_time_10 now_0)))
 (let (($x51043 (<= 0 v_0_tx_time_10)))
 (and $x51043 $x47276 (or (not (>= 10 v_0_rtx_buf)) (= 0 v_0_tx_time_10))))))
(assert
 (let (($x41401 (<= v_0_tx_time_11 now_0)))
 (let (($x51055 (<= 0 v_0_tx_time_11)))
 (and $x51055 $x41401 (or (not (>= 11 v_0_rtx_buf)) (= 0 v_0_tx_time_11))))))
(assert
 (let (($x51066 (<= v_0_tx_time_12 now_0)))
 (let (($x51067 (<= 0 v_0_tx_time_12)))
 (and $x51067 $x51066 (or (not (>= 12 v_0_rtx_buf)) (= 0 v_0_tx_time_12))))))
(assert
 (let (($x42515 (<= v_0_tx_time_13 now_0)))
 (let (($x51079 (<= 0 v_0_tx_time_13)))
 (and $x51079 $x42515 (or (not (>= 13 v_0_rtx_buf)) (= 0 v_0_tx_time_13))))))
(assert
 (let (($x42518 (<= v_0_tx_time_14 now_0)))
 (let (($x51091 (<= 0 v_0_tx_time_14)))
 (and $x51091 $x42518 (or (not (>= 14 v_0_rtx_buf)) (= 0 v_0_tx_time_14))))))
(assert
 (let (($x42605 (<= v_0_tx_time_15 now_0)))
 (let (($x48614 (<= 0 v_0_tx_time_15)))
 (and $x48614 $x42605 (or (not (>= 15 v_0_rtx_buf)) (= 0 v_0_tx_time_15))))))
(assert
 (let (($x42670 (<= v_0_tx_fin_time now_0)))
 (let (($x49192 (<= 0 v_0_tx_fin_time)))
 (and $x49192 $x42670))))
(assert
 (let (($x41715 (>= 4 v_0_tx_emit_count)))
 (let (($x42673 (<= 0 v_0_tx_emit_count)))
 (and $x42673 $x41715))))
(assert
 (let (($x48106 (>= 4 v_0_tx_eligible)))
 (let (($x41717 (<= 0 v_0_tx_eligible)))
 (and $x41717 $x48106))))
(assert
 (let (($x45633 (>= 60000 v_0_tx_previous_rto)))
 (let (($x45631 (<= 1000 v_0_tx_previous_rto)))
 (let (($x45629 (<= v_0_tx_max_previous now_0)))
 (let (($x45319 (<= 0 v_0_tx_max_previous)))
 (let (($x45317 (<= 0 v_0_tx_elapsed)))
 (and $x45317 $x45319 $x45629 $x45631 $x45633)))))))
(assert
 (let (($x44483 (<= 1 v_0_tx_emit_count)))
 (let (($x47157 (>= v_0_tx_elapsed v_0_tx_previous_rto)))
 (let (($x48292 (and $x47157 $x44483 (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x1262 (not v_0_tx_retransmitted)))
 (or $x1262 $x48292))))))
(assert
 (let (($x1271 (not v_0_tx_waiting)))
 (let (($x1262 (not v_0_tx_retransmitted)))
 (or $x1262 $x1271))))
(assert
 (let (($x53122 (<= v_0_tx_syn_time now_0)))
 (let (($x47153 (<= 0 v_0_tx_syn_time)))
 (and $x47153 $x53122))))
(assert
 (not v_0_tx_syn_pending))
(assert
 (let (($x1272 (= 0 v_0_tx_syn_time)))
 (or v_0_tx_syn_pending $x1272)))
(assert
 true)
(assert
 (let (($x1289 (= 4 v_0_ack_rmss)))
 (let (($x50835 (>= 499 v_0_ack_delay_ms)))
 (let (($x51490 (<= 1 v_0_ack_delay_ms)))
 (and $x51490 $x50835 $x1289)))))
(assert
 (= v_0_ack_pending active_0_delack))
(assert
 (let (($x51721 (>= 1 v_0_ack_full_segments)))
 (let (($x51324 (<= 0 v_0_ack_full_segments)))
 (let (($x42711 (>= 7 v_0_ack_bytes)))
 (let (($x47714 (<= 0 v_0_ack_bytes)))
 (and $x47714 $x42711 $x51324 $x51721))))))
(assert
 (let (($x53687 (<= v_0_ack_since_ms now_0)))
 (let (($x53749 (<= 0 v_0_ack_since_ms)))
 (and $x53749 $x53687))))
(assert
 (not v_0_ack_pending))
(assert
 (let (($x1280 (= 0 v_0_ack_since_ms)))
 (let (($x1282 (= 0 v_0_ack_full_segments)))
 (let (($x1281 (= 0 v_0_ack_bytes)))
 (or v_0_ack_pending (and $x1281 $x1282 $x1280))))))
(assert
 (let (($x1297 (not v_0_persist_active)))
 (let (($x41328 (= v_0_persist_active active_0_persist)))
 (and $x41328 $x1297))))
(assert
 (let (($x1297 (not v_0_persist_active)))
 (or $x1297 (and (not v_0_rtt_active) (= 0 v_0_rtt_remaining)))))
(assert
 (let (($x53661 (<= 0 v_0_persist_elapsed_ms)))
 (let (($x53663 (<= 0 v_0_persist_probes)))
 (let (($x53664 (>= 60000 v_0_persist_previous_interval_ms)))
 (let (($x53665 (<= 1000 v_0_persist_previous_interval_ms)))
 (let (($x53667 (>= 60000 v_0_persist_interval_ms)))
 (let (($x53669 (<= 1000 v_0_persist_interval_ms)))
 (and $x53669 $x53667 $x53665 $x53664 $x53663 $x53661))))))))
(assert
 (let (($x49000 (<= 0 v_0_persist_deadline_ms)))
 (let (($x48988 (<= v_0_persist_last_ms now_0)))
 (let (($x48986 (<= 0 v_0_persist_last_ms)))
 (let (($x48984 (<= v_0_persist_since_ms now_0)))
 (let (($x48980 (<= 0 v_0_persist_since_ms)))
 (and $x48980 $x48984 $x48986 $x48988 $x49000)))))))
(assert
 (let (($x1318 (= 0 v_0_persist_probes)))
 (let ((?x20871 (ite $x1318 v_0_persist_since_ms v_0_persist_last_ms)))
 (let (($x49430 (= v_0_persist_deadline_ms (+ ?x20871 v_0_persist_interval_ms))))
 (let (($x1297 (not v_0_persist_active)))
 (or $x1297 $x49430))))))
(assert
 (let (($x49434 (= 1 v_0_rtx_buf)))
 (let (($x49432 (>= v_0_persist_elapsed_ms v_0_persist_previous_interval_ms)))
 (let (($x1307 (not v_0_persist_probe_sent)))
 (or $x1307 (and $x49432 $x49434))))))
(assert
 (let (($x49440 (= v_0_tx_time_00 v_0_persist_last_ms)))
 (let (($x49434 (= 1 v_0_rtx_buf)))
 (let (($x49437 (<= 1 v_0_persist_probes)))
 (or (not (and v_0_persist_active $x49437 $x49434)) $x49440)))))
(assert
 (let (($x1318 (= 0 v_0_persist_probes)))
 (let (($x1315 (= 0 v_0_persist_deadline_ms)))
 (let (($x1313 (= 0 v_0_persist_last_ms)))
 (let (($x1312 (= 0 v_0_persist_since_ms)))
 (or v_0_persist_active (and $x1312 $x1313 $x1315 $x1318)))))))
(assert
 (let (($x49415 (<= 8 v_0_cc_initial_threshold)))
 (let (($x50008 (>= 16 v_0_cc_initial_window)))
 (let (($x49980 (<= 4 v_0_cc_initial_window)))
 (and $x49980 $x50008 $x49415)))))
(assert
 (let (($x49367 (<= 0 v_0_cc_threshold_updates)))
 (let (($x49365 (>= 16 v_0_cc_acked)))
 (let (($x50326 (<= 0 v_0_cc_acked)))
 (let (($x50014 (>= 4 v_0_cc_growth)))
 (let (($x50011 (<= 0 v_0_cc_growth)))
 (let (($x50009 (not (>= v_0_cc_ca_credit v_0_cc_cwnd))))
 (let (($x49423 (<= 0 v_0_cc_ca_credit)))
 (let (($x49420 (<= 8 v_0_cc_ssthresh)))
 (let (($x49418 (<= 4 v_0_cc_cwnd)))
 (and $x49418 $x49420 $x49423 $x50009 $x50011 $x50014 $x50326 $x49365 $x49367)))))))))))
(assert
 (let (($x49371 (<= v_0_cc_new_sent v_0_cc_send_budget)))
 (let (($x49369 (<= 0 v_0_cc_new_sent)))
 (and $x49369 $x49371))))
(assert
 (let (($x1830 (>= 0 v_0_rtx_buf)))
 (let (($x48149 (not $x1830)))
 (let (($x1357 (not v_0_cc_rto_00)))
 (or $x1357 $x48149)))))
(assert
 (let (($x1832 (>= 1 v_0_rtx_buf)))
 (let (($x48152 (not $x1832)))
 (let (($x1361 (not v_0_cc_rto_01)))
 (or $x1361 $x48152)))))
(assert
 (let (($x1835 (>= 2 v_0_rtx_buf)))
 (let (($x48155 (not $x1835)))
 (let (($x1363 (not v_0_cc_rto_02)))
 (or $x1363 $x48155)))))
(assert
 (let (($x1838 (>= 3 v_0_rtx_buf)))
 (let (($x48161 (not $x1838)))
 (let (($x1365 (not v_0_cc_rto_03)))
 (or $x1365 $x48161)))))
(assert
 (let (($x1840 (>= 4 v_0_rtx_buf)))
 (let (($x43428 (not $x1840)))
 (let (($x1367 (not v_0_cc_rto_04)))
 (or $x1367 $x43428)))))
(assert
 (let (($x1843 (>= 5 v_0_rtx_buf)))
 (let (($x48035 (not $x1843)))
 (let (($x1369 (not v_0_cc_rto_05)))
 (or $x1369 $x48035)))))
(assert
 (let (($x1846 (>= 6 v_0_rtx_buf)))
 (let (($x48129 (not $x1846)))
 (let (($x1371 (not v_0_cc_rto_06)))
 (or $x1371 $x48129)))))
(assert
 (let (($x1849 (>= 7 v_0_rtx_buf)))
 (let (($x48132 (not $x1849)))
 (let (($x1373 (not v_0_cc_rto_07)))
 (or $x1373 $x48132)))))
(assert
 (let (($x1851 (>= 8 v_0_rtx_buf)))
 (let (($x48135 (not $x1851)))
 (let (($x1375 (not v_0_cc_rto_08)))
 (or $x1375 $x48135)))))
(assert
 (let (($x1854 (>= 9 v_0_rtx_buf)))
 (let (($x48139 (not $x1854)))
 (let (($x1377 (not v_0_cc_rto_09)))
 (or $x1377 $x48139)))))
(assert
 (let (($x1857 (>= 10 v_0_rtx_buf)))
 (let (($x48119 (not $x1857)))
 (let (($x1379 (not v_0_cc_rto_10)))
 (or $x1379 $x48119)))))
(assert
 (let (($x1860 (>= 11 v_0_rtx_buf)))
 (let (($x48108 (not $x1860)))
 (let (($x1381 (not v_0_cc_rto_11)))
 (or $x1381 $x48108)))))
(assert
 (let (($x1863 (>= 12 v_0_rtx_buf)))
 (let (($x48111 (not $x1863)))
 (let (($x1383 (not v_0_cc_rto_12)))
 (or $x1383 $x48111)))))
(assert
 (let (($x1866 (>= 13 v_0_rtx_buf)))
 (let (($x48114 (not $x1866)))
 (let (($x1385 (not v_0_cc_rto_13)))
 (or $x1385 $x48114)))))
(assert
 (let (($x1869 (>= 14 v_0_rtx_buf)))
 (let (($x48117 (not $x1869)))
 (let (($x1387 (not v_0_cc_rto_14)))
 (or $x1387 $x48117)))))
(assert
 (let (($x1872 (>= 15 v_0_rtx_buf)))
 (let (($x48123 (not $x1872)))
 (let (($x1389 (not v_0_cc_rto_15)))
 (or $x1389 $x48123)))))
(assert
 (let (($x49603 (>= 65535 v_0_fr_last_window)))
 (let (($x47803 (<= 0 v_0_fr_last_window)))
 (let (($x50974 (>= 4 v_0_fr_emit_count)))
 (let (($x50972 (<= 0 v_0_fr_emit_count)))
 (let (($x49395 (<= 0 v_0_fr_entries)))
 (let (($x50969 (<= 0 v_0_fr_dupacks)))
 (and $x50969 $x49395 $x50972 $x50974 $x47803 $x49603))))))))
(assert
 (not v_0_fr_active))
(assert
 (let (($x1262 (not v_0_tx_retransmitted)))
 (let (($x53649 (= v_0_retries v_0_fr_before_retries)))
 (let (($x53652 (= v_0_rto_ms v_0_fr_before_rto)))
 (let (($x53654 (= v_0_snd_nxt v_0_fr_before_nxt)))
 (let (($x44887 (<= 1 v_0_fr_emit_count)))
 (let (($x53657 (= 3 v_0_fr_dupacks)))
 (let (($x1425 (not v_0_fr_retransmitted)))
 (or $x1425 (and v_0_fr_entered $x53657 $x44887 $x53654 $x53652 $x53649 $x1262))))))))))
(assert
 (let (($x53567 (= v_0_fr_window_valid v_0_fr_before_window_valid)))
 (let (($x53645 (= v_0_fr_last_window v_0_fr_before_wire_window)))
 (let (($x1391 (not v_0_fr_window_ignored)))
 (or $x1391 (and $x53645 $x53567))))))
(assert
 (let (($x1419 (not v_0_fr_entered)))
 (or v_0_fr_retransmitted $x1419)))
(assert
 (let (($x1419 (not v_0_fr_entered)))
 (or $x1419 (= v_0_cc_cwnd (+ 12 v_0_cc_ssthresh)))))
(assert
 (let (($x1423 (not v_0_fr_exited)))
 (or $x1423 (and (= v_0_cc_cwnd v_0_cc_ssthresh) (= 0 v_0_cc_ca_credit)))))
(assert
 (let (($x53631 (<= 0 v_0_idle_restart_count)))
 (let (($x53629 (<= 0 v_0_idle_elapsed_ms)))
 (let (($x53634 (<= v_0_idle_event_ms now_0)))
 (let (($x53632 (<= v_0_idle_last_data_ms v_0_idle_event_ms)))
 (let (($x53637 (<= 0 v_0_idle_last_data_ms)))
 (and $x53637 $x53632 $x53634 $x53629 $x53631)))))))
(assert
 (let (($x53626 (= v_0_idle_last_data_ms v_0_idle_event_ms)))
 (let (($x1436 (not v_0_idle_data_emitted)))
 (or $x1436 $x53626))))
(assert
 (let (($x1329 (= 0 v_0_cc_ca_credit)))
 (let (($x53621 (= v_0_cc_ssthresh v_0_idle_before_threshold)))
 (let ((?x53625 (ite (<= v_0_cc_initial_window v_0_idle_before_cwnd) v_0_cc_initial_window v_0_idle_before_cwnd)))
 (let (($x53525 (= v_0_cc_cwnd ?x53625)))
 (let (($x53531 (not (>= v_0_idle_before_rto v_0_idle_elapsed_ms))))
 (let (($x1439 (not v_0_idle_restart)))
 (or $x1439 (and $x53531 $x53525 $x53621 $x1329)))))))))
(assert
 (let (($x53607 (<= 0 v_0_lt_loss_flight)))
 (let (($x53609 (>= v_0_lt_epoch_bytes v_0_lt_epoch_packets)))
 (let (($x53501 (<= v_0_lt_epoch_packets v_0_fr_dupacks)))
 (let (($x53612 (>= 2 v_0_lt_epoch_packets)))
 (let (($x53507 (<= 0 v_0_lt_epoch_packets)))
 (let (($x53615 (<= v_0_lt_epoch_bytes v_0_rtx_buf)))
 (let (($x53513 (>= 8 v_0_lt_epoch_bytes)))
 (let (($x53618 (<= 0 v_0_lt_epoch_bytes)))
 (and $x53618 $x53513 $x53615 $x53507 $x53612 $x53501 $x53609 (<= v_0_lt_epoch_bytes (* 4 v_0_lt_epoch_packets)) $x53607))))))))))
(assert
 (let (($x53574 (= v_0_snd_nxt (mod (+ v_0_lt_before_nxt v_0_lt_take) 4294967296))))
 (let (($x1939 (<= v_0_rtx_buf v_0_snd_wnd)))
 (let (($x53586 (= v_0_rtx_buf (+ v_0_lt_before_flight v_0_lt_take))))
 (let (($x53594 (= v_0_cc_cwnd v_0_lt_before_cwnd)))
 (let (($x53592 (>= 4 v_0_lt_take)))
 (let (($x53595 (<= 1 v_0_lt_take)))
 (let (($x1168 (not v_0_fin_sent)))
 (let (($x1397 (not v_0_fr_active)))
 (let (($x53599 (>= 2 v_0_fr_dupacks)))
 (let (($x53604 (<= 1 v_0_fr_dupacks)))
 (let (($x48411 (and v_0_fr_duplicate $x53604 $x53599 $x1397 $x1168 $x53595 $x53592 $x53594 $x53586 $x1939 (<= v_0_rtx_buf (+ 8 v_0_cc_cwnd)) $x53574)))
 (let (($x1453 (not v_0_lt_emitted)))
 (or $x1453 $x48411))))))))))))))
(assert
 (let ((?x45248 (* (- 1) v_0_lt_before_bytes)))
 (let ((?x45249 (+ v_0_fr_before_flight ?x45248)))
 (let (($x1419 (not v_0_fr_entered)))
 (or $x1419 (= v_0_lt_loss_flight ?x45249))))))
(assert
 (let (($x53564 (>= 4 v_0_choice_limit)))
 (let (($x53562 (<= 0 v_0_choice_limit)))
 (let (($x53571 (>= 4 v_0_choice_count)))
 (let (($x53569 (<= 0 v_0_choice_count)))
 (and $x53569 $x53571 $x53562 $x53564))))))
(assert
 (let (($x53548 (= v_0_rtx_buf (+ v_0_choice_before_flight v_0_choice_count))))
 (let (($x53545 (= v_0_snd_nxt (mod (+ v_0_choice_before_nxt v_0_choice_count) 4294967296))))
 (let (($x53552 (<= v_0_choice_count v_0_cc_send_budget)))
 (let (($x53550 (= v_0_cc_new_sent v_0_choice_count)))
 (let (($x53559 (= v_0_take v_0_choice_count)))
 (let (($x53557 (<= v_0_choice_count v_0_choice_limit)))
 (let (($x53566 (<= 1 v_0_choice_count)))
 (let (($x1471 (not v_0_choice_used)))
 (or $x1471 (and $x53566 $x53557 $x53559 $x53550 $x53552 $x53545 $x53548)))))))))))
(assert
 (let (($x53526 (>= 16 (+ v_0_sched_bytes v_0_snd_buf))))
 (let (($x53542 (<= v_0_sched_packets v_0_sched_bytes)))
 (let (($x53540 (<= 0 v_0_sched_packets)))
 (and $x53540 $x53542 (<= v_0_sched_bytes (* 4 v_0_sched_packets)) $x53526)))))
(assert
 (let (($x53523 (= 2 v_0_sched_cause)))
 (let (($x53521 (= 1 v_0_sched_cause)))
 (let (($x1481 (not v_0_sched_open)))
 (let (($x53530 (<= v_0_sched_at_ms now_0)))
 (let (($x53528 (<= 0 v_0_sched_at_ms)))
 (and $x53528 $x53530 (or $x1481 $x53521 $x53523))))))))
(assert
 (let (($x1471 (not v_0_choice_used)))
 (or $x1471 (and v_0_sched_open (= v_0_sched_at_ms v_0_idle_event_ms)))))
(assert
 (let ((?x48420 (+ v_0_svc_acked_bytes v_0_svc_abandoned_bytes v_0_snd_buf v_0_rtx_buf)))
 (let (($x53512 (<= 0 v_0_svc_abandoned_bytes)))
 (let (($x53510 (<= 0 v_0_svc_acked_bytes)))
 (let (($x53508 (<= 0 v_0_svc_written_bytes)))
 (and $x53508 $x53510 $x53512 (= v_0_svc_written_bytes ?x48420)))))))
(assert
 (let (($x53491 (<= 0 v_0_svc_drop_step)))
 (let (($x53500 (<= 0 v_0_svc_ack_step)))
 (let (($x53498 (<= 0 v_0_svc_accept_step)))
 (let (($x53496 (= v_0_svc_ack_step v_0_cc_acked)))
 (and $x53496 $x53498 $x53500 $x53491))))))
(assert
 (<= (+ v_0_cb_emitted_total v_0_snd_buf) v_0_svc_written_bytes))
(assert
 (let (($x45272 (<= (+ v_1_cb_emitted_total v_1_snd_buf) v_1_svc_written_bytes)))
 (let (($x49740 (and $x45272 (or (not active_1_rtx) (>= due_1_rtx now_1)) (or (not active_1_user) (>= due_1_user now_1)) (or (not active_1_time_wait) (>= due_1_time_wait now_1)) (or (not active_1_delack) (>= due_1_delack now_1)) (or (not active_1_persist) (>= due_1_persist now_1)))))
 (not $x49740))))
(assert
 (= 47 choice_0))
(assert
 (= 0 state_0))
(assert
 (= 0 state_1))
(check-sat)
