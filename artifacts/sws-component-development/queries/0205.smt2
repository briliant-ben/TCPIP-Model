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
(declare-fun due_0_sws () Int)
(declare-fun active_0_sws () Bool)
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
(declare-fun v_0_rto_ms () Int)
(declare-fun v_0_retries () Int)
(declare-fun v_0_msl_ms () Int)
(declare-fun v_0_user_timeout_ms () Int)
(declare-fun v_0_snd_wnd () Int)
(declare-fun v_0_local_window () Int)
(declare-fun v_0_rx_advance () Int)
(declare-fun v_0_ack_delta () Int)
(declare-fun v_0_fin_sent () Bool)
(declare-fun v_0_fin_requested () Bool)
(declare-fun v_0_rx_fin_done () Bool)
(declare-fun v_0_rx_fin_offset () Int)
(declare-fun v_0_rx_fin_pending () Bool)
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
(declare-fun v_0_rtt_remaining () Int)
(declare-fun v_0_rtt_active () Bool)
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
(declare-fun v_0_tx_emit_count () Int)
(declare-fun v_0_tx_eligible () Int)
(declare-fun v_0_tx_previous_rto () Int)
(declare-fun v_0_tx_max_previous () Int)
(declare-fun v_0_tx_elapsed () Int)
(declare-fun v_0_tx_is_fin () Bool)
(declare-fun v_0_tx_retransmitted () Bool)
(declare-fun v_0_tx_waiting () Bool)
(declare-fun v_0_tx_syn_time () Int)
(declare-fun v_0_tx_syn_pending () Bool)
(declare-fun v_0_ack_rmss () Int)
(declare-fun v_0_ack_delay_ms () Int)
(declare-fun v_0_ack_pending () Bool)
(declare-fun v_0_ack_full_segments () Int)
(declare-fun v_0_ack_bytes () Int)
(declare-fun v_0_ack_since_ms () Int)
(declare-fun v_0_persist_active () Bool)
(declare-fun v_0_persist_elapsed_ms () Int)
(declare-fun v_0_persist_probes () Int)
(declare-fun v_0_persist_previous_interval_ms () Int)
(declare-fun v_0_persist_interval_ms () Int)
(declare-fun v_0_persist_deadline_ms () Int)
(declare-fun v_0_persist_last_ms () Int)
(declare-fun v_0_persist_since_ms () Int)
(declare-fun v_0_persist_probe_sent () Bool)
(declare-fun v_0_cc_initial_threshold () Int)
(declare-fun v_0_cc_initial_window () Int)
(declare-fun v_0_cc_threshold_updates () Int)
(declare-fun v_0_cc_acked () Int)
(declare-fun v_0_cc_growth () Int)
(declare-fun v_0_cc_cwnd () Int)
(declare-fun v_0_cc_ca_credit () Int)
(declare-fun v_0_cc_ssthresh () Int)
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
(declare-fun v_0_fr_last_window () Int)
(declare-fun v_0_fr_emit_count () Int)
(declare-fun v_0_fr_entries () Int)
(declare-fun v_0_fr_dupacks () Int)
(declare-fun v_0_fr_active () Bool)
(declare-fun v_0_fr_before_retries () Int)
(declare-fun v_0_fr_before_rto () Int)
(declare-fun v_0_fr_entered () Bool)
(declare-fun v_0_fr_retransmitted () Bool)
(declare-fun v_0_fr_before_window_valid () Bool)
(declare-fun v_0_fr_window_valid () Bool)
(declare-fun v_0_fr_before_wire_window () Int)
(declare-fun v_0_fr_window_ignored () Bool)
(declare-fun v_0_fr_exited () Bool)
(declare-fun v_0_idle_restart_count () Int)
(declare-fun v_0_idle_elapsed_ms () Int)
(declare-fun v_0_idle_event_ms () Int)
(declare-fun v_0_idle_last_data_ms () Int)
(declare-fun v_0_idle_data_emitted () Bool)
(declare-fun v_0_idle_before_threshold () Int)
(declare-fun v_0_idle_before_cwnd () Int)
(declare-fun v_0_idle_before_rto () Int)
(declare-fun v_0_idle_restart () Bool)
(declare-fun v_0_lt_loss_flight () Int)
(declare-fun v_0_lt_epoch_packets () Int)
(declare-fun v_0_lt_epoch_bytes () Int)
(declare-fun v_0_lt_take () Int)
(declare-fun v_0_lt_before_flight () Int)
(declare-fun v_0_lt_before_cwnd () Int)
(declare-fun v_0_fr_duplicate () Bool)
(declare-fun v_0_lt_emitted () Bool)
(declare-fun v_0_lt_before_bytes () Int)
(declare-fun v_0_fr_before_flight () Int)
(declare-fun v_0_choice_limit () Int)
(declare-fun v_0_choice_count () Int)
(declare-fun v_0_choice_before_flight () Int)
(declare-fun v_0_take () Int)
(declare-fun v_0_choice_used () Bool)
(declare-fun v_0_sched_bytes () Int)
(declare-fun v_0_sched_packets () Int)
(declare-fun v_0_sched_cause () Int)
(declare-fun v_0_sched_open () Bool)
(declare-fun v_0_sched_at_ms () Int)
(declare-fun v_0_svc_abandoned_bytes () Int)
(declare-fun v_0_svc_acked_bytes () Int)
(declare-fun v_0_svc_written_bytes () Int)
(declare-fun v_0_svc_drop_step () Int)
(declare-fun v_0_svc_ack_step () Int)
(declare-fun v_0_svc_accept_step () Int)
(declare-fun v_0_cb_new_count () Int)
(declare-fun v_0_cb_count () Int)
(declare-fun v_0_cb_head () Int)
(declare-fun v_0_cb_tail () Int)
(declare-fun v_0_cb_length_15 () Int)
(declare-fun v_0_cb_length_14 () Int)
(declare-fun v_0_cb_length_13 () Int)
(declare-fun v_0_cb_length_12 () Int)
(declare-fun v_0_cb_length_11 () Int)
(declare-fun v_0_cb_length_10 () Int)
(declare-fun v_0_cb_length_09 () Int)
(declare-fun v_0_cb_length_08 () Int)
(declare-fun v_0_cb_length_07 () Int)
(declare-fun v_0_cb_length_06 () Int)
(declare-fun v_0_cb_length_05 () Int)
(declare-fun v_0_cb_length_04 () Int)
(declare-fun v_0_cb_length_03 () Int)
(declare-fun v_0_cb_length_02 () Int)
(declare-fun v_0_cb_length_01 () Int)
(declare-fun v_0_cb_length_00 () Int)
(declare-fun v_0_cb_live_total () Int)
(declare-fun v_0_cb_abandoned_total () Int)
(declare-fun v_0_cb_acked_total () Int)
(declare-fun v_0_cb_emitted_total () Int)
(declare-fun v_0_cb_drop_step () Int)
(declare-fun v_0_cb_step_bytes () Int)
(declare-fun v_0_cb_partial_prefix () Int)
(declare-fun v_0_nagle_first_bytes () Int)
(declare-fun v_0_nagle_before_disabled () Bool)
(declare-fun v_0_nagle_before_flight () Int)
(declare-fun v_0_sws_decision_at_ms () Int)
(declare-fun v_0_sws_decision_deadline_ms () Int)
(declare-fun v_0_sws_override_ms () Int)
(declare-fun v_0_sws_decision_started_ms () Int)
(declare-fun v_0_sws_decision_ready () Bool)
(declare-fun v_0_sws_decision_queued () Int)
(declare-fun v_0_sws_decision_count () Int)
(declare-fun v_0_sws_decision_pushed () Int)
(declare-fun v_0_sws_decision_flight () Int)
(declare-fun v_0_sws_decision_disabled () Bool)
(declare-fun v_0_sws_decision_maximum () Int)
(declare-fun v_0_sws_decision_usable () Int)
(declare-fun v_0_sws_sent_count () Int)
(declare-fun v_0_sws_allowed_at_send () Bool)
(declare-fun v_0_sws_deadline_ms () Int)
(declare-fun v_0_sws_override_ready () Bool)
(declare-fun v_0_sws_started_ms () Int)
(declare-fun v_0_sws_active () Bool)
(declare-fun v_0_sws_requested () Bool)
(declare-fun v_0_sws_push_bytes () Int)
(declare-fun v_0_sws_previous_max () Int)
(declare-fun v_0_sws_max_window () Int)
(declare-fun now_1 () Int)
(declare-fun v_0_rtt_ambiguous () Bool)
(declare-fun input_0_net.fin_segment_window () Int)
(declare-fun due_1_sws () Int)
(declare-fun active_1_sws () Bool)
(declare-fun due_1_persist () Int)
(declare-fun active_1_persist () Bool)
(declare-fun due_1_delack () Int)
(declare-fun active_1_delack () Bool)
(declare-fun due_1_time_wait () Int)
(declare-fun active_1_time_wait () Bool)
(declare-fun due_1_user () Int)
(declare-fun active_1_user () Bool)
(declare-fun due_1_rtx () Int)
(declare-fun active_1_rtx () Bool)
(declare-fun v_1_sws_decision_at_ms () Int)
(declare-fun v_1_sws_decision_deadline_ms () Int)
(declare-fun v_1_sws_override_ms () Int)
(declare-fun v_1_sws_decision_started_ms () Int)
(declare-fun v_1_sws_decision_ready () Bool)
(declare-fun v_1_sws_decision_count () Int)
(declare-fun v_1_sws_decision_queued () Int)
(declare-fun v_1_sws_decision_pushed () Int)
(declare-fun v_1_sws_decision_flight () Int)
(declare-fun v_1_sws_decision_disabled () Bool)
(declare-fun v_1_sws_decision_maximum () Int)
(declare-fun v_1_sws_decision_usable () Int)
(declare-fun v_1_sws_sent_count () Int)
(declare-fun v_1_sws_allowed_at_send () Bool)
(declare-fun v_1_sws_deadline_ms () Int)
(declare-fun v_1_sws_override_ready () Bool)
(declare-fun v_1_sws_started_ms () Int)
(declare-fun v_1_sws_active () Bool)
(declare-fun v_1_sws_requested () Bool)
(declare-fun v_1_sws_push_bytes () Int)
(declare-fun v_1_sws_max_window () Int)
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
 (let (($x57843 (>= due_0_rtx now_0)))
 (let (($x1747 (not active_0_rtx)))
 (or $x1747 $x57843))))
(assert
 (let (($x57834 (>= due_0_user now_0)))
 (let (($x1749 (not active_0_user)))
 (or $x1749 $x57834))))
(assert
 (let (($x57830 (>= due_0_time_wait now_0)))
 (let (($x1751 (not active_0_time_wait)))
 (or $x1751 $x57830))))
(assert
 (let (($x57370 (>= due_0_delack now_0)))
 (let (($x1753 (not active_0_delack)))
 (or $x1753 $x57370))))
(assert
 (let (($x57362 (>= due_0_persist now_0)))
 (let (($x1755 (not active_0_persist)))
 (or $x1755 $x57362))))
(assert
 (let (($x57373 (>= due_0_sws now_0)))
 (let (($x1757 (not active_0_sws)))
 (or $x1757 $x57373))))
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
 false)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 active_0_user)
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
 (let ((?x1886 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1886)))
(assert
 (>= 16 v_0_rcv_buf))
(assert
 (let (($x57786 (>= 65535 v_0_snd_wnd)))
 (let (($x3091 (<= 0 v_0_snd_wnd)))
 (and $x3091 $x57786))))
(assert
 (let ((?x31784 (* (- 1) v_0_rcv_buf)))
 (let ((?x31785 (+ 16 ?x31784)))
 (= v_0_local_window ?x31785))))
(assert
 (>= 1 v_0_rx_slot_00))
(assert
 (let (($x1173 (= 0 v_0_rx_slot_00)))
 (let (($x44484 (not (>= v_0_rcv_buf 16))))
 (or $x44484 $x1173))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x1175 (= 0 v_0_rx_slot_01)))
 (let (($x44491 (not (>= v_0_rcv_buf 15))))
 (or $x44491 $x1175))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x1177 (= 0 v_0_rx_slot_02)))
 (let (($x46638 (not (>= v_0_rcv_buf 14))))
 (or $x46638 $x1177))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x1179 (= 0 v_0_rx_slot_03)))
 (let (($x46642 (not (>= v_0_rcv_buf 13))))
 (or $x46642 $x1179))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x1181 (= 0 v_0_rx_slot_04)))
 (let (($x52621 (not (>= v_0_rcv_buf 12))))
 (or $x52621 $x1181))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x1183 (= 0 v_0_rx_slot_05)))
 (let (($x52627 (not (>= v_0_rcv_buf 11))))
 (or $x52627 $x1183))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x1185 (= 0 v_0_rx_slot_06)))
 (let (($x52645 (not (>= v_0_rcv_buf 10))))
 (or $x52645 $x1185))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x1187 (= 0 v_0_rx_slot_07)))
 (let (($x53622 (not (>= v_0_rcv_buf 9))))
 (or $x53622 $x1187))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x1189 (= 0 v_0_rx_slot_08)))
 (let (($x56838 (not (>= v_0_rcv_buf 8))))
 (or $x56838 $x1189))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x1191 (= 0 v_0_rx_slot_09)))
 (let (($x56841 (not (>= v_0_rcv_buf 7))))
 (or $x56841 $x1191))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x1193 (= 0 v_0_rx_slot_10)))
 (let (($x50895 (not (>= v_0_rcv_buf 6))))
 (or $x50895 $x1193))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x1195 (= 0 v_0_rx_slot_11)))
 (let (($x44451 (not (>= v_0_rcv_buf 5))))
 (or $x44451 $x1195))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x1197 (= 0 v_0_rx_slot_12)))
 (let (($x48741 (not (>= v_0_rcv_buf 4))))
 (or $x48741 $x1197))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x1199 (= 0 v_0_rx_slot_13)))
 (let (($x53327 (not (>= v_0_rcv_buf 3))))
 (or $x53327 $x1199))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x1201 (= 0 v_0_rx_slot_14)))
 (let (($x53070 (not (>= v_0_rcv_buf 2))))
 (or $x53070 $x1201))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x1203 (= 0 v_0_rx_slot_15)))
 (let (($x53074 (not (>= v_0_rcv_buf 1))))
 (or $x53074 $x1203))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x53076 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x53076)))
(assert
 (let (($x57654 (>= 16 v_0_rx_advance)))
 (let (($x57733 (<= 0 v_0_rx_advance)))
 (and $x57733 $x57654))))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (let (($x57729 (>= 4294967295 v_0_ack_delta)))
 (let (($x57727 (<= 0 v_0_ack_delta)))
 (and $x57727 $x57729))))
(assert
 true)
(assert
 (let ((?x53652 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x53652)))
(assert
 (let (($x1156 (= 0 v_0_snd_buf)))
 (let ((?x57638 (mod (+ v_0_snd_una v_0_rtx_buf) 4294967296)))
 (let (($x57714 (= v_0_fin_seq ?x57638)))
 (let (($x1226 (not v_0_fin_sent)))
 (or $x1226 (and v_0_fin_requested $x57714 $x1156)))))))
(assert
 true)
(assert
 v_0_fin_requested)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 (not v_0_rx_fin_done))
(assert
 (let (($x57682 (<= 1 v_0_rx_fin_offset)))
 (let (($x1237 (not v_0_rx_fin_done)))
 (let (($x1232 (not v_0_rx_fin_pending)))
 (or $x1232 (and $x1237 $x57682 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window))))))))
(assert
 (let (($x57682 (<= 1 v_0_rx_fin_offset)))
 (let (($x50577 (= v_0_rx_fin_pending $x57682)))
 (let (($x15503 (>= 15 v_0_rx_fin_offset)))
 (let (($x50572 (<= 0 v_0_rx_fin_offset)))
 (and $x50572 $x15503 $x50577))))))
(assert
 (let ((?x50580 (mod (+ v_0_rcv_nxt v_0_rx_fin_offset) 4294967296)))
 (let (($x50582 (= v_0_rx_fin_seq ?x50580)))
 (let (($x1232 (not v_0_rx_fin_pending)))
 (or $x1232 $x50582)))))
(assert
 (let (($x1237 (not v_0_rx_fin_done)))
 (or $x1237 (= v_0_rcv_nxt (mod (+ 1 v_0_rx_fin_seq) 4294967296)))))
(assert
 (let (($x1173 (= 0 v_0_rx_slot_00)))
 (or (not (and v_0_rx_fin_pending (>= 0 v_0_rx_fin_offset))) $x1173)))
(assert
 (let (($x1175 (= 0 v_0_rx_slot_01)))
 (or (not (and v_0_rx_fin_pending (>= 1 v_0_rx_fin_offset))) $x1175)))
(assert
 (let (($x1177 (= 0 v_0_rx_slot_02)))
 (or (not (and v_0_rx_fin_pending (>= 2 v_0_rx_fin_offset))) $x1177)))
(assert
 (let (($x1179 (= 0 v_0_rx_slot_03)))
 (or (not (and v_0_rx_fin_pending (>= 3 v_0_rx_fin_offset))) $x1179)))
(assert
 (let (($x1181 (= 0 v_0_rx_slot_04)))
 (or (not (and v_0_rx_fin_pending (>= 4 v_0_rx_fin_offset))) $x1181)))
(assert
 (let (($x1183 (= 0 v_0_rx_slot_05)))
 (or (not (and v_0_rx_fin_pending (>= 5 v_0_rx_fin_offset))) $x1183)))
(assert
 (let (($x1185 (= 0 v_0_rx_slot_06)))
 (or (not (and v_0_rx_fin_pending (>= 6 v_0_rx_fin_offset))) $x1185)))
(assert
 (let (($x1187 (= 0 v_0_rx_slot_07)))
 (or (not (and v_0_rx_fin_pending (>= 7 v_0_rx_fin_offset))) $x1187)))
(assert
 (let (($x1189 (= 0 v_0_rx_slot_08)))
 (or (not (and v_0_rx_fin_pending (>= 8 v_0_rx_fin_offset))) $x1189)))
(assert
 (let (($x1191 (= 0 v_0_rx_slot_09)))
 (or (not (and v_0_rx_fin_pending (>= 9 v_0_rx_fin_offset))) $x1191)))
(assert
 (let (($x1193 (= 0 v_0_rx_slot_10)))
 (or (not (and v_0_rx_fin_pending (>= 10 v_0_rx_fin_offset))) $x1193)))
(assert
 (let (($x1195 (= 0 v_0_rx_slot_11)))
 (or (not (and v_0_rx_fin_pending (>= 11 v_0_rx_fin_offset))) $x1195)))
(assert
 (let (($x1197 (= 0 v_0_rx_slot_12)))
 (or (not (and v_0_rx_fin_pending (>= 12 v_0_rx_fin_offset))) $x1197)))
(assert
 (let (($x1199 (= 0 v_0_rx_slot_13)))
 (or (not (and v_0_rx_fin_pending (>= 13 v_0_rx_fin_offset))) $x1199)))
(assert
 (let (($x1201 (= 0 v_0_rx_slot_14)))
 (or (not (and v_0_rx_fin_pending (>= 14 v_0_rx_fin_offset))) $x1201)))
(assert
 (let (($x1203 (= 0 v_0_rx_slot_15)))
 (or (not (and v_0_rx_fin_pending (>= 15 v_0_rx_fin_offset))) $x1203)))
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
 (let (($x57679 (>= 60000 v_0_rto_ms)))
 (let (($x52604 (>= v_0_rto_ms v_0_rto_base_ms)))
 (let (($x52602 (>= 60000 v_0_rto_base_ms)))
 (let (($x50983 (<= 1000 v_0_rto_base_ms)))
 (and $x50983 $x52602 $x52604 $x57679))))))
(assert
 (let ((?x56767 (* 4.0 v_0_rttvar_ms)))
 (let ((?x50599 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x56767)))
 (let ((?x25374 (* (- 1.0) v_0_srtt_ms)))
 (let ((?x56765 (+ ?x25374 (* (- 1.0) ?x50599))))
 (let ((?x56766 (to_int ?x56765)))
 (let ((?x56762 (* (- 1) ?x56766)))
 (let ((?x47434 (ite (<= ?x56766 (- 1000)) ?x56762 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x47434) 60000 ?x47434) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x25321 (* (- 1) v_0_snd_una)))
 (let ((?x37599 (+ v_0_snd_nxt ?x25321)))
 (let ((?x58549 (mod ?x37599 4294967296)))
 (let ((?x40162 (+ v_0_rtt_end ?x25321)))
 (let ((?x67389 (mod ?x40162 4294967296)))
 (let (($x49201 (>= 4 v_0_rtt_remaining)))
 (let (($x45545 (<= 1 v_0_rtt_remaining)))
 (let (($x47879 (<= v_0_rtt_start_ms now_0)))
 (let (($x1257 (not v_0_rtt_active)))
 (or $x1257 (and $x47879 $x45545 $x49201 (>= ?x67389 v_0_rtt_remaining) (<= ?x67389 ?x58549)))))))))))))
(assert
 (let (($x1264 (= 0 v_0_rtt_remaining)))
 (or v_0_rtt_active $x1264)))
(assert
 true)
(assert
 (let ((?x25359 (* (- 1) v_0_rtt_start_ms)))
 (let ((?x54674 (+ v_0_rtt_sample_at_ms ?x25359)))
 (let (($x1273 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1271 (not v_0_rtt_sample_used)))
 (or $x1271 (and $x1273 v_0_rtt_measured (= v_0_rtt_last_ms ?x54674))))))))
(assert
 (let (($x45565 (<= v_0_rtt_sample_at_ms now_0)))
 (let (($x45563 (<= 0 v_0_rtt_sample_at_ms)))
 (and $x45563 $x45565))))
(assert
 (let ((?x45568 (to_real v_0_rtt_last_ms)))
 (let ((?x54722 (ite v_0_rtt_previous_measured (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x45568)) ?x45568)))
 (let ((?x54694 (* (- 1.0) v_0_rtt_previous_srtt)))
 (let ((?x54700 (+ ?x54694 ?x45568)))
 (let ((?x54687 (* (- 1.0) ?x45568)))
 (let ((?x54688 (+ v_0_rtt_previous_srtt ?x54687)))
 (let ((?x54706 (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* (/ 1.0 4.0) (ite (>= ?x54688 0.0) ?x54688 ?x54700)))))
 (let (($x54712 (= v_0_rttvar_ms (ite v_0_rtt_previous_measured ?x54706 (* (/ 1.0 2.0) ?x45568)))))
 (let (($x1271 (not v_0_rtt_sample_used)))
 (or $x1271 (and $x54712 (= v_0_srtt_ms ?x54722)))))))))))))
(assert
 (let (($x47908 (<= v_0_tx_time_00 now_0)))
 (let (($x9699 (<= 0 v_0_tx_time_00)))
 (and $x9699 $x47908 (or (not (>= 0 v_0_rtx_buf)) (= 0 v_0_tx_time_00))))))
(assert
 (let (($x47915 (<= v_0_tx_time_01 now_0)))
 (let (($x47910 (<= 0 v_0_tx_time_01)))
 (and $x47910 $x47915 (or (not (>= 1 v_0_rtx_buf)) (= 0 v_0_tx_time_01))))))
(assert
 (let (($x47923 (<= v_0_tx_time_02 now_0)))
 (let (($x47918 (<= 0 v_0_tx_time_02)))
 (and $x47918 $x47923 (or (not (>= 2 v_0_rtx_buf)) (= 0 v_0_tx_time_02))))))
(assert
 (let (($x47929 (<= v_0_tx_time_03 now_0)))
 (let (($x47927 (<= 0 v_0_tx_time_03)))
 (and $x47927 $x47929 (or (not (>= 3 v_0_rtx_buf)) (= 0 v_0_tx_time_03))))))
(assert
 (let (($x47937 (<= v_0_tx_time_04 now_0)))
 (let (($x47932 (<= 0 v_0_tx_time_04)))
 (and $x47932 $x47937 (or (not (>= 4 v_0_rtx_buf)) (= 0 v_0_tx_time_04))))))
(assert
 (let (($x47944 (<= v_0_tx_time_05 now_0)))
 (let (($x47942 (<= 0 v_0_tx_time_05)))
 (and $x47942 $x47944 (or (not (>= 5 v_0_rtx_buf)) (= 0 v_0_tx_time_05))))))
(assert
 (let (($x47951 (<= v_0_tx_time_06 now_0)))
 (let (($x47949 (<= 0 v_0_tx_time_06)))
 (and $x47949 $x47951 (or (not (>= 6 v_0_rtx_buf)) (= 0 v_0_tx_time_06))))))
(assert
 (let (($x47956 (<= v_0_tx_time_07 now_0)))
 (let (($x47954 (<= 0 v_0_tx_time_07)))
 (and $x47954 $x47956 (or (not (>= 7 v_0_rtx_buf)) (= 0 v_0_tx_time_07))))))
(assert
 (let (($x47965 (<= v_0_tx_time_08 now_0)))
 (let (($x47963 (<= 0 v_0_tx_time_08)))
 (and $x47963 $x47965 (or (not (>= 8 v_0_rtx_buf)) (= 0 v_0_tx_time_08))))))
(assert
 (let (($x47974 (<= v_0_tx_time_09 now_0)))
 (let (($x47968 (<= 0 v_0_tx_time_09)))
 (and $x47968 $x47974 (or (not (>= 9 v_0_rtx_buf)) (= 0 v_0_tx_time_09))))))
(assert
 (let (($x48134 (<= v_0_tx_time_10 now_0)))
 (let (($x47977 (<= 0 v_0_tx_time_10)))
 (and $x47977 $x48134 (or (not (>= 10 v_0_rtx_buf)) (= 0 v_0_tx_time_10))))))
(assert
 (let (($x47921 (<= v_0_tx_time_11 now_0)))
 (let (($x47919 (<= 0 v_0_tx_time_11)))
 (and $x47919 $x47921 (or (not (>= 11 v_0_rtx_buf)) (= 0 v_0_tx_time_11))))))
(assert
 (let (($x47994 (<= v_0_tx_time_12 now_0)))
 (let (($x47989 (<= 0 v_0_tx_time_12)))
 (and $x47989 $x47994 (or (not (>= 12 v_0_rtx_buf)) (= 0 v_0_tx_time_12))))))
(assert
 (let (($x47999 (<= v_0_tx_time_13 now_0)))
 (let (($x44507 (<= 0 v_0_tx_time_13)))
 (and $x44507 $x47999 (or (not (>= 13 v_0_rtx_buf)) (= 0 v_0_tx_time_13))))))
(assert
 (let (($x44930 (<= v_0_tx_time_14 now_0)))
 (let (($x45358 (<= 0 v_0_tx_time_14)))
 (and $x45358 $x44930 (or (not (>= 14 v_0_rtx_buf)) (= 0 v_0_tx_time_14))))))
(assert
 (let (($x55759 (<= v_0_tx_time_15 now_0)))
 (let (($x48010 (<= 0 v_0_tx_time_15)))
 (and $x48010 $x55759 (or (not (>= 15 v_0_rtx_buf)) (= 0 v_0_tx_time_15))))))
(assert
 (let (($x48397 (<= v_0_tx_fin_time now_0)))
 (let (($x48396 (<= 0 v_0_tx_fin_time)))
 (and $x48396 $x48397))))
(assert
 (let (($x48406 (>= 4 v_0_tx_emit_count)))
 (let (($x45027 (<= 0 v_0_tx_emit_count)))
 (and $x45027 $x48406))))
(assert
 (let (($x46065 (>= 4 v_0_tx_eligible)))
 (let (($x55188 (<= 0 v_0_tx_eligible)))
 (and $x55188 $x46065))))
(assert
 (let (($x49509 (>= 60000 v_0_tx_previous_rto)))
 (let (($x48399 (<= 1000 v_0_tx_previous_rto)))
 (let (($x45857 (<= v_0_tx_max_previous now_0)))
 (let (($x48186 (<= 0 v_0_tx_max_previous)))
 (let (($x51874 (<= 0 v_0_tx_elapsed)))
 (and $x51874 $x48186 $x45857 $x48399 $x49509)))))))
(assert
 (let (($x47873 (<= 1 v_0_tx_emit_count)))
 (let (($x47866 (>= v_0_tx_elapsed v_0_tx_previous_rto)))
 (let (($x48051 (and $x47866 $x47873 (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x1320 (not v_0_tx_retransmitted)))
 (or $x1320 $x48051))))))
(assert
 (let (($x1329 (not v_0_tx_waiting)))
 (let (($x1320 (not v_0_tx_retransmitted)))
 (or $x1320 $x1329))))
(assert
 (let (($x47891 (<= v_0_tx_syn_time now_0)))
 (let (($x47884 (<= 0 v_0_tx_syn_time)))
 (and $x47884 $x47891))))
(assert
 (not v_0_tx_syn_pending))
(assert
 (let (($x1330 (= 0 v_0_tx_syn_time)))
 (or v_0_tx_syn_pending $x1330)))
(assert
 true)
(assert
 (let (($x1347 (= 4 v_0_ack_rmss)))
 (let (($x51085 (>= 499 v_0_ack_delay_ms)))
 (let (($x48458 (<= 1 v_0_ack_delay_ms)))
 (and $x48458 $x51085 $x1347)))))
(assert
 (= v_0_ack_pending active_0_delack))
(assert
 (let (($x51121 (>= 1 v_0_ack_full_segments)))
 (let (($x53125 (<= 0 v_0_ack_full_segments)))
 (let (($x53856 (>= 7 v_0_ack_bytes)))
 (let (($x55073 (<= 0 v_0_ack_bytes)))
 (and $x55073 $x53856 $x53125 $x51121))))))
(assert
 (let (($x56285 (<= v_0_ack_since_ms now_0)))
 (let (($x48845 (<= 0 v_0_ack_since_ms)))
 (and $x48845 $x56285))))
(assert
 (let (($x1337 (not v_0_ack_pending)))
 (or $x1337 (and (<= 1 v_0_ack_bytes) (not v_0_rx_fin_done)))))
(assert
 (let (($x1338 (= 0 v_0_ack_since_ms)))
 (let (($x1340 (= 0 v_0_ack_full_segments)))
 (let (($x1339 (= 0 v_0_ack_bytes)))
 (or v_0_ack_pending (and $x1339 $x1340 $x1338))))))
(assert
 (let (($x1747 (not active_0_rtx)))
 (let (($x1950 (>= 1 v_0_rtx_buf)))
 (let (($x5707 (<= 1 (+ v_0_rtx_buf v_0_snd_buf))))
 (let (($x1226 (not v_0_fin_sent)))
 (let (($x5703 (= 0 v_0_snd_wnd)))
 (let (($x1355 (not v_0_persist_active)))
 (let ((?x11056 (ite v_0_fin_sent 1 0)))
 (let ((?x11057 (+ v_0_rtx_buf ?x11056)))
 (let (($x57602 (<= 1 ?x11057)))
 (let (($x57599 (= v_0_persist_active active_0_persist)))
 (and $x57599 (= active_0_rtx (and $x57602 $x1355)) (or $x1355 (and $x5703 $x1226 $x5707 $x1950 $x1747))))))))))))))
(assert
 (let (($x1355 (not v_0_persist_active)))
 (or $x1355 (and (not v_0_rtt_active) (= 0 v_0_rtt_remaining)))))
(assert
 (let (($x57575 (<= 0 v_0_persist_elapsed_ms)))
 (let (($x57577 (<= 0 v_0_persist_probes)))
 (let (($x57556 (>= 60000 v_0_persist_previous_interval_ms)))
 (let (($x57343 (<= 1000 v_0_persist_previous_interval_ms)))
 (let (($x45481 (>= 60000 v_0_persist_interval_ms)))
 (let (($x45479 (<= 1000 v_0_persist_interval_ms)))
 (and $x45479 $x45481 $x57343 $x57556 $x57577 $x57575))))))))
(assert
 (let (($x54635 (<= 0 v_0_persist_deadline_ms)))
 (let (($x57619 (<= v_0_persist_last_ms now_0)))
 (let (($x48721 (<= 0 v_0_persist_last_ms)))
 (let (($x57569 (<= v_0_persist_since_ms now_0)))
 (let (($x57571 (<= 0 v_0_persist_since_ms)))
 (and $x57571 $x57569 $x48721 $x57619 $x54635)))))))
(assert
 (let (($x1376 (= 0 v_0_persist_probes)))
 (let ((?x22884 (ite $x1376 v_0_persist_since_ms v_0_persist_last_ms)))
 (let (($x51303 (= v_0_persist_deadline_ms (+ ?x22884 v_0_persist_interval_ms))))
 (let (($x1355 (not v_0_persist_active)))
 (or $x1355 $x51303))))))
(assert
 (let (($x44888 (= 1 v_0_rtx_buf)))
 (let (($x55190 (>= v_0_persist_elapsed_ms v_0_persist_previous_interval_ms)))
 (let (($x1365 (not v_0_persist_probe_sent)))
 (or $x1365 (and $x55190 $x44888))))))
(assert
 (let (($x44511 (= v_0_tx_time_00 v_0_persist_last_ms)))
 (let (($x44888 (= 1 v_0_rtx_buf)))
 (let (($x44864 (<= 1 v_0_persist_probes)))
 (or (not (and v_0_persist_active $x44864 $x44888)) $x44511)))))
(assert
 (let (($x1376 (= 0 v_0_persist_probes)))
 (let (($x1373 (= 0 v_0_persist_deadline_ms)))
 (let (($x1371 (= 0 v_0_persist_last_ms)))
 (let (($x1370 (= 0 v_0_persist_since_ms)))
 (or v_0_persist_active (and $x1370 $x1371 $x1373 $x1376)))))))
(assert
 (let (($x57563 (<= 8 v_0_cc_initial_threshold)))
 (let (($x48778 (>= 16 v_0_cc_initial_window)))
 (let (($x48776 (<= 4 v_0_cc_initial_window)))
 (and $x48776 $x48778 $x57563)))))
(assert
 (let (($x57544 (<= 0 v_0_cc_threshold_updates)))
 (let (($x57549 (>= 16 v_0_cc_acked)))
 (let (($x57547 (<= 0 v_0_cc_acked)))
 (let (($x57552 (>= 4 v_0_cc_growth)))
 (let (($x57550 (<= 0 v_0_cc_growth)))
 (let (($x57555 (not (>= v_0_cc_ca_credit v_0_cc_cwnd))))
 (let (($x57482 (<= 0 v_0_cc_ca_credit)))
 (let (($x57558 (<= 8 v_0_cc_ssthresh)))
 (let (($x57561 (<= 4 v_0_cc_cwnd)))
 (and $x57561 $x57558 $x57482 $x57555 $x57550 $x57552 $x57547 $x57549 $x57544)))))))))))
(assert
 (let (($x57541 (<= v_0_cc_new_sent v_0_cc_send_budget)))
 (let (($x57546 (<= 0 v_0_cc_new_sent)))
 (and $x57546 $x57541))))
(assert
 (let (($x1948 (>= 0 v_0_rtx_buf)))
 (let (($x47680 (not $x1948)))
 (let (($x1415 (not v_0_cc_rto_00)))
 (or $x1415 $x47680)))))
(assert
 (let (($x1950 (>= 1 v_0_rtx_buf)))
 (let (($x47681 (not $x1950)))
 (let (($x1419 (not v_0_cc_rto_01)))
 (or $x1419 $x47681)))))
(assert
 (let (($x1953 (>= 2 v_0_rtx_buf)))
 (let (($x47678 (not $x1953)))
 (let (($x1421 (not v_0_cc_rto_02)))
 (or $x1421 $x47678)))))
(assert
 (let (($x1956 (>= 3 v_0_rtx_buf)))
 (let (($x47679 (not $x1956)))
 (let (($x1423 (not v_0_cc_rto_03)))
 (or $x1423 $x47679)))))
(assert
 (let (($x1958 (>= 4 v_0_rtx_buf)))
 (let (($x47676 (not $x1958)))
 (let (($x1425 (not v_0_cc_rto_04)))
 (or $x1425 $x47676)))))
(assert
 (let (($x1961 (>= 5 v_0_rtx_buf)))
 (let (($x47677 (not $x1961)))
 (let (($x1427 (not v_0_cc_rto_05)))
 (or $x1427 $x47677)))))
(assert
 (let (($x1964 (>= 6 v_0_rtx_buf)))
 (let (($x47674 (not $x1964)))
 (let (($x1429 (not v_0_cc_rto_06)))
 (or $x1429 $x47674)))))
(assert
 (let (($x1967 (>= 7 v_0_rtx_buf)))
 (let (($x47675 (not $x1967)))
 (let (($x1431 (not v_0_cc_rto_07)))
 (or $x1431 $x47675)))))
(assert
 (let (($x1969 (>= 8 v_0_rtx_buf)))
 (let (($x47672 (not $x1969)))
 (let (($x1433 (not v_0_cc_rto_08)))
 (or $x1433 $x47672)))))
(assert
 (let (($x1972 (>= 9 v_0_rtx_buf)))
 (let (($x47673 (not $x1972)))
 (let (($x1435 (not v_0_cc_rto_09)))
 (or $x1435 $x47673)))))
(assert
 (let (($x1975 (>= 10 v_0_rtx_buf)))
 (let (($x47670 (not $x1975)))
 (let (($x1437 (not v_0_cc_rto_10)))
 (or $x1437 $x47670)))))
(assert
 (let (($x1978 (>= 11 v_0_rtx_buf)))
 (let (($x47671 (not $x1978)))
 (let (($x1439 (not v_0_cc_rto_11)))
 (or $x1439 $x47671)))))
(assert
 (let (($x1981 (>= 12 v_0_rtx_buf)))
 (let (($x47668 (not $x1981)))
 (let (($x1441 (not v_0_cc_rto_12)))
 (or $x1441 $x47668)))))
(assert
 (let (($x1984 (>= 13 v_0_rtx_buf)))
 (let (($x47669 (not $x1984)))
 (let (($x1443 (not v_0_cc_rto_13)))
 (or $x1443 $x47669)))))
(assert
 (let (($x1987 (>= 14 v_0_rtx_buf)))
 (let (($x47666 (not $x1987)))
 (let (($x1445 (not v_0_cc_rto_14)))
 (or $x1445 $x47666)))))
(assert
 (let (($x1990 (>= 15 v_0_rtx_buf)))
 (let (($x47667 (not $x1990)))
 (let (($x1447 (not v_0_cc_rto_15)))
 (or $x1447 $x47667)))))
(assert
 (let (($x57520 (>= 65535 v_0_fr_last_window)))
 (let (($x57525 (<= 0 v_0_fr_last_window)))
 (let (($x57523 (>= 4 v_0_fr_emit_count)))
 (let (($x57528 (<= 0 v_0_fr_emit_count)))
 (let (($x57526 (<= 0 v_0_fr_entries)))
 (let (($x57531 (<= 0 v_0_fr_dupacks)))
 (and $x57531 $x57526 $x57528 $x57523 $x57525 $x57520))))))))
(assert
 (let (($x1355 (not v_0_persist_active)))
 (let (($x1925 (<= 1 v_0_rtx_buf)))
 (let (($x57522 (<= 3 v_0_fr_dupacks)))
 (let (($x1455 (not v_0_fr_active)))
 (or $x1455 (and $x57522 $x1925 $x1355)))))))
(assert
 (let (($x1320 (not v_0_tx_retransmitted)))
 (let (($x57505 (= v_0_retries v_0_fr_before_retries)))
 (let (($x57507 (= v_0_rto_ms v_0_fr_before_rto)))
 (let (($x57509 (= v_0_snd_nxt v_0_fr_before_nxt)))
 (let (($x57391 (<= 1 v_0_fr_emit_count)))
 (let (($x57512 (= 3 v_0_fr_dupacks)))
 (let (($x1483 (not v_0_fr_retransmitted)))
 (or $x1483 (and v_0_fr_entered $x57512 $x57391 $x57509 $x57507 $x57505 $x1320))))))))))
(assert
 (let (($x57495 (= v_0_fr_window_valid v_0_fr_before_window_valid)))
 (let (($x57498 (= v_0_fr_last_window v_0_fr_before_wire_window)))
 (let (($x1449 (not v_0_fr_window_ignored)))
 (or $x1449 (and $x57498 $x57495))))))
(assert
 (let (($x1477 (not v_0_fr_entered)))
 (or v_0_fr_retransmitted $x1477)))
(assert
 (let (($x1477 (not v_0_fr_entered)))
 (or $x1477 (= v_0_cc_cwnd (+ 12 v_0_cc_ssthresh)))))
(assert
 (let (($x1481 (not v_0_fr_exited)))
 (or $x1481 (and (= v_0_cc_cwnd v_0_cc_ssthresh) (= 0 v_0_cc_ca_credit)))))
(assert
 (let (($x57472 (<= 0 v_0_idle_restart_count)))
 (let (($x57481 (<= 0 v_0_idle_elapsed_ms)))
 (let (($x57479 (<= v_0_idle_event_ms now_0)))
 (let (($x57477 (<= v_0_idle_last_data_ms v_0_idle_event_ms)))
 (let (($x57486 (<= 0 v_0_idle_last_data_ms)))
 (and $x57486 $x57477 $x57479 $x57481 $x57472)))))))
(assert
 (let (($x57474 (= v_0_idle_last_data_ms v_0_idle_event_ms)))
 (let (($x1494 (not v_0_idle_data_emitted)))
 (or $x1494 $x57474))))
(assert
 (let (($x1387 (= 0 v_0_cc_ca_credit)))
 (let (($x57461 (= v_0_cc_ssthresh v_0_idle_before_threshold)))
 (let ((?x57469 (ite (<= v_0_cc_initial_window v_0_idle_before_cwnd) v_0_cc_initial_window v_0_idle_before_cwnd)))
 (let (($x57459 (= v_0_cc_cwnd ?x57469)))
 (let (($x57466 (not (>= v_0_idle_before_rto v_0_idle_elapsed_ms))))
 (let (($x1497 (not v_0_idle_restart)))
 (or $x1497 (and $x57466 $x57459 $x57461 $x1387)))))))))
(assert
 (let (($x57438 (<= 0 v_0_lt_loss_flight)))
 (let (($x57444 (>= v_0_lt_epoch_bytes v_0_lt_epoch_packets)))
 (let (($x57442 (<= v_0_lt_epoch_packets v_0_fr_dupacks)))
 (let (($x57451 (>= 2 v_0_lt_epoch_packets)))
 (let (($x57449 (<= 0 v_0_lt_epoch_packets)))
 (let (($x57447 (<= v_0_lt_epoch_bytes v_0_rtx_buf)))
 (let (($x57456 (>= 8 v_0_lt_epoch_bytes)))
 (let (($x57454 (<= 0 v_0_lt_epoch_bytes)))
 (and $x57454 $x57456 $x57447 $x57449 $x57451 $x57442 $x57444 (<= v_0_lt_epoch_bytes (* 4 v_0_lt_epoch_packets)) $x57438))))))))))
(assert
 (let (($x57407 (= v_0_snd_nxt (mod (+ v_0_lt_before_nxt v_0_lt_take) 4294967296))))
 (let (($x2057 (<= v_0_rtx_buf v_0_snd_wnd)))
 (let (($x57421 (= v_0_rtx_buf (+ v_0_lt_before_flight v_0_lt_take))))
 (let (($x57418 (= v_0_cc_cwnd v_0_lt_before_cwnd)))
 (let (($x57427 (>= 4 v_0_lt_take)))
 (let (($x57425 (<= 1 v_0_lt_take)))
 (let (($x1226 (not v_0_fin_sent)))
 (let (($x1455 (not v_0_fr_active)))
 (let (($x57432 (>= 2 v_0_fr_dupacks)))
 (let (($x57430 (<= 1 v_0_fr_dupacks)))
 (let (($x48442 (and v_0_fr_duplicate $x57430 $x57432 $x1455 $x1226 $x57425 $x57427 $x57418 $x57421 $x2057 (<= v_0_rtx_buf (+ 8 v_0_cc_cwnd)) $x57407)))
 (let (($x1511 (not v_0_lt_emitted)))
 (or $x1511 $x48442))))))))))))))
(assert
 (let ((?x52886 (* (- 1) v_0_lt_before_bytes)))
 (let ((?x52891 (+ v_0_fr_before_flight ?x52886)))
 (let (($x1477 (not v_0_fr_entered)))
 (or $x1477 (= v_0_lt_loss_flight ?x52891))))))
(assert
 (let (($x57388 (>= 4 v_0_choice_limit)))
 (let (($x57397 (<= 0 v_0_choice_limit)))
 (let (($x57395 (>= 4 v_0_choice_count)))
 (let (($x57402 (<= 0 v_0_choice_count)))
 (and $x57402 $x57395 $x57397 $x57388))))))
(assert
 (let (($x57327 (= v_0_rtx_buf (+ v_0_choice_before_flight v_0_choice_count))))
 (let (($x57345 (= v_0_snd_nxt (mod (+ v_0_choice_before_nxt v_0_choice_count) 4294967296))))
 (let (($x57367 (<= v_0_choice_count v_0_cc_send_budget)))
 (let (($x57381 (= v_0_cc_new_sent v_0_choice_count)))
 (let (($x57383 (= v_0_take v_0_choice_count)))
 (let (($x57387 (<= v_0_choice_count v_0_choice_limit)))
 (let (($x57390 (<= 1 v_0_choice_count)))
 (let (($x1529 (not v_0_choice_used)))
 (or $x1529 (and $x57390 $x57387 $x57383 $x57381 $x57367 $x57345 $x57327)))))))))))
(assert
 (let (($x57007 (>= 16 (+ v_0_sched_bytes v_0_snd_buf))))
 (let (($x57324 (<= v_0_sched_packets v_0_sched_bytes)))
 (let (($x57326 (<= 0 v_0_sched_packets)))
 (and $x57326 $x57324 (<= v_0_sched_bytes (* 4 v_0_sched_packets)) $x57007)))))
(assert
 (let (($x57292 (= 2 v_0_sched_cause)))
 (let (($x57121 (= 1 v_0_sched_cause)))
 (let (($x1539 (not v_0_sched_open)))
 (let (($x57088 (<= v_0_sched_at_ms now_0)))
 (let (($x57281 (<= 0 v_0_sched_at_ms)))
 (and $x57281 $x57088 (or $x1539 $x57121 $x57292))))))))
(assert
 (let (($x1529 (not v_0_choice_used)))
 (or $x1529 (and v_0_sched_open (= v_0_sched_at_ms v_0_idle_event_ms)))))
(assert
 (let ((?x48462 (+ v_0_svc_acked_bytes v_0_svc_abandoned_bytes v_0_snd_buf v_0_rtx_buf)))
 (let (($x57312 (<= 0 v_0_svc_abandoned_bytes)))
 (let (($x57317 (<= 0 v_0_svc_acked_bytes)))
 (let (($x57299 (<= 0 v_0_svc_written_bytes)))
 (and $x57299 $x57317 $x57312 (= v_0_svc_written_bytes ?x48462)))))))
(assert
 (let (($x57306 (<= 0 v_0_svc_drop_step)))
 (let (($x57304 (<= 0 v_0_svc_ack_step)))
 (let (($x57308 (<= 0 v_0_svc_accept_step)))
 (let (($x57309 (= v_0_svc_ack_step v_0_cc_acked)))
 (and $x57309 $x57308 $x57304 $x57306))))))
(assert
 (let (($x57276 (>= 1 v_0_cb_new_count)))
 (let (($x57212 (<= 0 v_0_cb_new_count)))
 (let ((?x57112 (+ v_0_cb_head v_0_cb_count)))
 (let ((?x52974 (+ (- 16) v_0_cb_head v_0_cb_count)))
 (let (($x57113 (<= 16 ?x57112)))
 (let (($x57109 (<= v_0_cb_count v_0_rtx_buf)))
 (let (($x57108 (<= 0 v_0_cb_count)))
 (let (($x57289 (not (<= 16 v_0_cb_tail))))
 (let (($x57286 (<= 0 v_0_cb_tail)))
 (let (($x57283 (not (<= 16 v_0_cb_head))))
 (let (($x57302 (<= 0 v_0_cb_head)))
 (and $x57302 $x57283 $x57286 $x57289 $x57108 $x57109 (= v_0_cb_tail (ite $x57113 ?x52974 ?x57112)) $x57212 $x57276)))))))))))))
(assert
 (let ((?x24929 (+ v_0_cb_length_00 v_0_cb_length_01 v_0_cb_length_02 v_0_cb_length_03 v_0_cb_length_04 v_0_cb_length_05 v_0_cb_length_06 v_0_cb_length_07 v_0_cb_length_08 v_0_cb_length_09 v_0_cb_length_10 v_0_cb_length_11 v_0_cb_length_12 v_0_cb_length_13 v_0_cb_length_14 v_0_cb_length_15)))
 (let (($x48508 (= v_0_cb_emitted_total (+ v_0_cb_acked_total v_0_cb_abandoned_total v_0_cb_live_total))))
 (let (($x57190 (<= 0 v_0_cb_drop_step)))
 (let (($x57269 (>= 19 v_0_cb_step_bytes)))
 (let (($x57189 (<= 0 v_0_cb_step_bytes)))
 (let (($x57195 (<= 0 v_0_cb_abandoned_total)))
 (let (($x57274 (<= v_0_cb_emitted_total v_0_svc_written_bytes)))
 (let (($x57272 (<= (+ v_0_cb_acked_total v_0_cb_partial_prefix) v_0_svc_acked_bytes)))
 (let (($x57199 (<= 0 v_0_cb_acked_total)))
 (let (($x57278 (<= 0 v_0_cb_emitted_total)))
 (and $x57278 $x57199 $x57272 $x57274 $x57195 $x57189 $x57269 $x57190 $x48508 (= v_0_cb_live_total ?x24929)))))))))))))
(assert
 (let (($x57175 (>= 3 v_0_cb_partial_prefix)))
 (let (($x57254 (<= 0 v_0_cb_partial_prefix)))
 (let ((?x24564 (* (- 1) v_0_rtx_buf)))
 (let ((?x56694 (+ v_0_cb_live_total ?x24564)))
 (and (= v_0_cb_partial_prefix ?x56694) $x57254 $x57175))))))
(assert
 (<= (+ v_0_cb_emitted_total v_0_snd_buf) v_0_svc_written_bytes))
(assert
 (let (($x57153 (= v_0_cb_end_00 (mod (+ v_0_cb_end_15 v_0_cb_length_00) 4294967296))))
 (let ((?x24672 (* (- 1) v_0_cb_head)))
 (let ((?x24675 (+ 16 ?x24672)))
 (let (($x2165 (>= 0 v_0_cb_head)))
 (let ((?x48501 (ite $x2165 ?x24672 ?x24675)))
 (let (($x48502 (>= ?x48501 v_0_cb_count)))
 (let (($x48499 (not $x48502)))
 (let ((?x48513 (mod (+ v_0_snd_una v_0_cb_length_00 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x57240 (not (>= v_0_cb_partial_prefix v_0_cb_length_00))))
 (let (($x48529 (or (not (and $x48499 (= 0 v_0_cb_head))) (and $x57240 (= v_0_cb_end_00 ?x48513)))))
 (let (($x48497 (or (and (<= 1 v_0_cb_length_00) (>= 4 v_0_cb_length_00)) $x48502)))
 (and $x48497 (or $x48499 (and (= 0 v_0_cb_length_00) (= 0 v_0_cb_end_00))) $x48529 (or (not (and $x48499 (<= 1 ?x48501))) $x57153))))))))))))))
(assert
 (let ((?x57136 (mod (+ v_0_cb_end_00 v_0_cb_length_01) 4294967296)))
 (let (($x57216 (= v_0_cb_end_01 ?x57136)))
 (let ((?x24672 (* (- 1) v_0_cb_head)))
 (let ((?x24690 (+ 17 ?x24672)))
 (let ((?x24689 (+ 1 ?x24672)))
 (let (($x2179 (>= 1 v_0_cb_head)))
 (let ((?x48523 (ite $x2179 ?x24689 ?x24690)))
 (let (($x48520 (>= ?x48523 v_0_cb_count)))
 (let (($x48521 (not $x48520)))
 (let ((?x48550 (mod (+ v_0_snd_una v_0_cb_length_01 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x57226 (not (>= v_0_cb_partial_prefix v_0_cb_length_01))))
 (let (($x48545 (or (not (and $x48521 (= 1 v_0_cb_head))) (and $x57226 (= v_0_cb_end_01 ?x48550)))))
 (let (($x48519 (or (and (<= 1 v_0_cb_length_01) (>= 4 v_0_cb_length_01)) $x48520)))
 (and $x48519 (or $x48521 (and (= 0 v_0_cb_length_01) (= 0 v_0_cb_end_01))) $x48545 (or (not (and $x48521 (<= 1 ?x48523))) $x57216))))))))))))))))
(assert
 (let ((?x45829 (mod (+ v_0_cb_end_01 v_0_cb_length_02) 4294967296)))
 (let (($x45830 (= v_0_cb_end_02 ?x45829)))
 (let ((?x24672 (* (- 1) v_0_cb_head)))
 (let ((?x24705 (+ 18 ?x24672)))
 (let ((?x24704 (+ 2 ?x24672)))
 (let (($x2192 (>= 2 v_0_cb_head)))
 (let ((?x48539 (ite $x2192 ?x24704 ?x24705)))
 (let (($x48540 (>= ?x48539 v_0_cb_count)))
 (let (($x48537 (not $x48540)))
 (let ((?x48490 (mod (+ v_0_snd_una v_0_cb_length_02 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x55133 (not (>= v_0_cb_partial_prefix v_0_cb_length_02))))
 (let (($x48563 (or (not (and $x48537 (= 2 v_0_cb_head))) (and $x55133 (= v_0_cb_end_02 ?x48490)))))
 (let (($x48535 (or (and (<= 1 v_0_cb_length_02) (>= 4 v_0_cb_length_02)) $x48540)))
 (and $x48535 (or $x48537 (and (= 0 v_0_cb_length_02) (= 0 v_0_cb_end_02))) $x48563 (or (not (and $x48537 (<= 1 ?x48539))) $x45830))))))))))))))))
(assert
 (let ((?x51153 (mod (+ v_0_cb_end_02 v_0_cb_length_03) 4294967296)))
 (let (($x51154 (= v_0_cb_end_03 ?x51153)))
 (let ((?x24672 (* (- 1) v_0_cb_head)))
 (let ((?x24720 (+ 19 ?x24672)))
 (let ((?x24717 (+ 3 ?x24672)))
 (let (($x2205 (>= 3 v_0_cb_head)))
 (let ((?x48557 (ite $x2205 ?x24717 ?x24720)))
 (let (($x48554 (>= ?x48557 v_0_cb_count)))
 (let (($x48555 (not $x48554)))
 (let ((?x48580 (mod (+ v_0_snd_una v_0_cb_length_03 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x57202 (not (>= v_0_cb_partial_prefix v_0_cb_length_03))))
 (let (($x48575 (or (not (and $x48555 (= 3 v_0_cb_head))) (and $x57202 (= v_0_cb_end_03 ?x48580)))))
 (let (($x48553 (or (and (<= 1 v_0_cb_length_03) (>= 4 v_0_cb_length_03)) $x48554)))
 (and $x48553 (or $x48555 (and (= 0 v_0_cb_length_03) (= 0 v_0_cb_end_03))) $x48575 (or (not (and $x48555 (<= 1 ?x48557))) $x51154))))))))))))))))
(assert
 (let ((?x45543 (mod (+ v_0_cb_end_03 v_0_cb_length_04) 4294967296)))
 (let (($x45578 (= v_0_cb_end_04 ?x45543)))
 (let ((?x24672 (* (- 1) v_0_cb_head)))
 (let ((?x24735 (+ 20 ?x24672)))
 (let ((?x24732 (+ 4 ?x24672)))
 (let (($x2218 (>= 4 v_0_cb_head)))
 (let ((?x48569 (ite $x2218 ?x24732 ?x24735)))
 (let (($x48570 (>= ?x48569 v_0_cb_count)))
 (let (($x48567 (not $x48570)))
 (let ((?x48594 (mod (+ v_0_snd_una v_0_cb_length_04 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x44544 (not (>= v_0_cb_partial_prefix v_0_cb_length_04))))
 (let (($x48589 (or (not (and $x48567 (= 4 v_0_cb_head))) (and $x44544 (= v_0_cb_end_04 ?x48594)))))
 (let (($x48486 (or (and (<= 1 v_0_cb_length_04) (>= 4 v_0_cb_length_04)) $x48570)))
 (and $x48486 (or $x48567 (and (= 0 v_0_cb_length_04) (= 0 v_0_cb_end_04))) $x48589 (or (not (and $x48567 (<= 1 ?x48569))) $x45578))))))))))))))))
(assert
 (let ((?x45597 (mod (+ v_0_cb_end_04 v_0_cb_length_05) 4294967296)))
 (let (($x45598 (= v_0_cb_end_05 ?x45597)))
 (let ((?x24672 (* (- 1) v_0_cb_head)))
 (let ((?x24750 (+ 21 ?x24672)))
 (let ((?x24747 (+ 5 ?x24672)))
 (let (($x2231 (>= 5 v_0_cb_head)))
 (let ((?x48583 (ite $x2231 ?x24747 ?x24750)))
 (let (($x48484 (>= ?x48583 v_0_cb_count)))
 (let (($x48485 (not $x48484)))
 (let ((?x48601 (mod (+ v_0_snd_una v_0_cb_length_05 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x45583 (not (>= v_0_cb_partial_prefix v_0_cb_length_05))))
 (let (($x48597 (or (not (and $x48485 (= 5 v_0_cb_head))) (and $x45583 (= v_0_cb_end_05 ?x48601)))))
 (let (($x48593 (or $x48484 (and (<= 1 v_0_cb_length_05) (>= 4 v_0_cb_length_05)))))
 (and $x48593 (or $x48485 (and (= 0 v_0_cb_length_05) (= 0 v_0_cb_end_05))) $x48597 (or (not (and $x48485 (<= 1 ?x48583))) $x45598))))))))))))))))
(assert
 (let ((?x45642 (mod (+ v_0_cb_end_05 v_0_cb_length_06) 4294967296)))
 (let (($x45644 (= v_0_cb_end_06 ?x45642)))
 (let ((?x24672 (* (- 1) v_0_cb_head)))
 (let ((?x24765 (+ 22 ?x24672)))
 (let ((?x24762 (+ 6 ?x24672)))
 (let (($x2244 (>= 6 v_0_cb_head)))
 (let ((?x48606 (ite $x2244 ?x24762 ?x24765)))
 (let (($x48482 (>= ?x48606 v_0_cb_count)))
 (let (($x51271 (not $x48482)))
 (let ((?x52889 (mod (+ v_0_snd_una v_0_cb_length_06 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x45619 (not (>= v_0_cb_partial_prefix v_0_cb_length_06))))
 (let (($x54767 (or (not (and $x51271 (= 6 v_0_cb_head))) (and $x45619 (= v_0_cb_end_06 ?x52889)))))
 (let (($x54469 (or (and (<= 1 v_0_cb_length_06) (>= 4 v_0_cb_length_06)) $x48482)))
 (and $x54469 (or $x51271 (and (= 0 v_0_cb_length_06) (= 0 v_0_cb_end_06))) $x54767 (or (not (and $x51271 (<= 1 ?x48606))) $x45644))))))))))))))))
(assert
 (let ((?x45675 (mod (+ v_0_cb_end_06 v_0_cb_length_07) 4294967296)))
 (let (($x45677 (= v_0_cb_end_07 ?x45675)))
 (let ((?x24672 (* (- 1) v_0_cb_head)))
 (let ((?x24780 (+ 23 ?x24672)))
 (let ((?x24777 (+ 7 ?x24672)))
 (let (($x2257 (>= 7 v_0_cb_head)))
 (let ((?x53479 (ite $x2257 ?x24777 ?x24780)))
 (let (($x51308 (>= ?x53479 v_0_cb_count)))
 (let (($x51309 (not $x51308)))
 (let ((?x46684 (mod (+ v_0_snd_una v_0_cb_length_07 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x45661 (not (>= v_0_cb_partial_prefix v_0_cb_length_07))))
 (let (($x46680 (or (not (and $x51309 (= 7 v_0_cb_head))) (and $x45661 (= v_0_cb_end_07 ?x46684)))))
 (let (($x51037 (or (and (<= 1 v_0_cb_length_07) (>= 4 v_0_cb_length_07)) $x51308)))
 (and $x51037 (or $x51309 (and (= 0 v_0_cb_length_07) (= 0 v_0_cb_end_07))) $x46680 (or (not (and $x51309 (<= 1 ?x53479))) $x45677))))))))))))))))
(assert
 (let ((?x51185 (mod (+ v_0_cb_end_07 v_0_cb_length_08) 4294967296)))
 (let (($x45701 (= v_0_cb_end_08 ?x51185)))
 (let ((?x24672 (* (- 1) v_0_cb_head)))
 (let ((?x24795 (+ 24 ?x24672)))
 (let ((?x24792 (+ 8 ?x24672)))
 (let (($x2270 (>= 8 v_0_cb_head)))
 (let ((?x53555 (ite $x2270 ?x24792 ?x24795)))
 (let (($x53556 (>= ?x53555 v_0_cb_count)))
 (let (($x48982 (not $x53556)))
 (let ((?x56704 (mod (+ v_0_snd_una v_0_cb_length_08 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x45695 (not (>= v_0_cb_partial_prefix v_0_cb_length_08))))
 (let (($x50697 (or (not (and $x48982 (= 8 v_0_cb_head))) (and $x45695 (= v_0_cb_end_08 ?x56704)))))
 (let (($x52349 (or $x53556 (and (<= 1 v_0_cb_length_08) (>= 4 v_0_cb_length_08)))))
 (and $x52349 (or $x48982 (and (= 0 v_0_cb_length_08) (= 0 v_0_cb_end_08))) $x50697 (or (not (and $x48982 (<= 1 ?x53555))) $x45701))))))))))))))))
(assert
 (let ((?x51230 (mod (+ v_0_cb_end_08 v_0_cb_length_09) 4294967296)))
 (let (($x51231 (= v_0_cb_end_09 ?x51230)))
 (let ((?x24672 (* (- 1) v_0_cb_head)))
 (let ((?x24810 (+ 25 ?x24672)))
 (let ((?x24807 (+ 9 ?x24672)))
 (let (($x2283 (>= 9 v_0_cb_head)))
 (let ((?x50460 (ite $x2283 ?x24807 ?x24810)))
 (let (($x50462 (>= ?x50460 v_0_cb_count)))
 (let (($x50463 (not $x50462)))
 (let ((?x50469 (mod (+ v_0_snd_una v_0_cb_length_09 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x53200 (not (>= v_0_cb_partial_prefix v_0_cb_length_09))))
 (let (($x54462 (or (not (and $x50463 (= 9 v_0_cb_head))) (and $x53200 (= v_0_cb_end_09 ?x50469)))))
 (let (($x47189 (or (and (<= 1 v_0_cb_length_09) (>= 4 v_0_cb_length_09)) $x50462)))
 (and $x47189 (or $x50463 (and (= 0 v_0_cb_length_09) (= 0 v_0_cb_end_09))) $x54462 (or (not (and $x50463 (<= 1 ?x50460))) $x51231))))))))))))))))
(assert
 (let ((?x57103 (mod (+ v_0_cb_end_09 v_0_cb_length_10) 4294967296)))
 (let (($x57104 (= v_0_cb_end_10 ?x57103)))
 (let ((?x24672 (* (- 1) v_0_cb_head)))
 (let ((?x24825 (+ 26 ?x24672)))
 (let ((?x24822 (+ 10 ?x24672)))
 (let (($x2296 (>= 10 v_0_cb_head)))
 (let ((?x54537 (ite $x2296 ?x24822 ?x24825)))
 (let (($x54318 (>= ?x54537 v_0_cb_count)))
 (let (($x50475 (not $x54318)))
 (let ((?x54550 (mod (+ v_0_snd_una v_0_cb_length_10 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x57123 (not (>= v_0_cb_partial_prefix v_0_cb_length_10))))
 (let (($x48615 (or (not (and $x50475 (= 10 v_0_cb_head))) (and $x57123 (= v_0_cb_end_10 ?x54550)))))
 (let (($x48620 (or (and (<= 1 v_0_cb_length_10) (>= 4 v_0_cb_length_10)) $x54318)))
 (and $x48620 (or $x50475 (and (= 0 v_0_cb_length_10) (= 0 v_0_cb_end_10))) $x48615 (or (not (and $x50475 (<= 1 ?x54537))) $x57104))))))))))))))))
(assert
 (let ((?x57079 (mod (+ v_0_cb_end_10 v_0_cb_length_11) 4294967296)))
 (let (($x57080 (= v_0_cb_end_11 ?x57079)))
 (let ((?x24672 (* (- 1) v_0_cb_head)))
 (let ((?x24840 (+ 27 ?x24672)))
 (let ((?x24837 (+ 11 ?x24672)))
 (let (($x2309 (>= 11 v_0_cb_head)))
 (let ((?x48480 (ite $x2309 ?x24837 ?x24840)))
 (let (($x48610 (>= ?x48480 v_0_cb_count)))
 (let (($x54473 (not $x48610)))
 (let ((?x52650 (mod (+ v_0_snd_una v_0_cb_length_11 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x46252 (not (>= v_0_cb_partial_prefix v_0_cb_length_11))))
 (let (($x48617 (or (not (and $x54473 (= 11 v_0_cb_head))) (and $x46252 (= v_0_cb_end_11 ?x52650)))))
 (let (($x54551 (or $x48610 (and (<= 1 v_0_cb_length_11) (>= 4 v_0_cb_length_11)))))
 (and $x54551 (or $x54473 (and (= 0 v_0_cb_length_11) (= 0 v_0_cb_end_11))) $x48617 (or (not (and $x54473 (<= 1 ?x48480))) $x57080))))))))))))))))
(assert
 (let ((?x57045 (mod (+ v_0_cb_end_11 v_0_cb_length_12) 4294967296)))
 (let (($x57046 (= v_0_cb_end_12 ?x57045)))
 (let ((?x24672 (* (- 1) v_0_cb_head)))
 (let ((?x24855 (+ 28 ?x24672)))
 (let ((?x24852 (+ 12 ?x24672)))
 (let (($x2322 (>= 12 v_0_cb_head)))
 (let ((?x50482 (ite $x2322 ?x24852 ?x24855)))
 (let (($x48481 (>= ?x50482 v_0_cb_count)))
 (let (($x44407 (not $x48481)))
 (let ((?x44410 (mod (+ v_0_snd_una v_0_cb_length_12 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x57057 (not (>= v_0_cb_partial_prefix v_0_cb_length_12))))
 (let (($x50494 (or (not (and $x44407 (= 12 v_0_cb_head))) (and $x57057 (= v_0_cb_end_12 ?x44410)))))
 (let (($x50492 (or $x48481 (and (<= 1 v_0_cb_length_12) (>= 4 v_0_cb_length_12)))))
 (and $x50492 (or $x44407 (and (= 0 v_0_cb_length_12) (= 0 v_0_cb_end_12))) $x50494 (or (not (and $x44407 (<= 1 ?x50482))) $x57046))))))))))))))))
(assert
 (let ((?x57019 (mod (+ v_0_cb_end_12 v_0_cb_length_13) 4294967296)))
 (let (($x57020 (= v_0_cb_end_13 ?x57019)))
 (let ((?x24672 (* (- 1) v_0_cb_head)))
 (let ((?x24870 (+ 29 ?x24672)))
 (let ((?x24867 (+ 13 ?x24672)))
 (let (($x2335 (>= 13 v_0_cb_head)))
 (let ((?x53615 (ite $x2335 ?x24867 ?x24870)))
 (let (($x52641 (>= ?x53615 v_0_cb_count)))
 (let (($x53626 (not $x52641)))
 (let ((?x53630 (mod (+ v_0_snd_una v_0_cb_length_13 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x57031 (not (>= v_0_cb_partial_prefix v_0_cb_length_13))))
 (let (($x53628 (or (not (and $x53626 (= 13 v_0_cb_head))) (and $x57031 (= v_0_cb_end_13 ?x53630)))))
 (let (($x53625 (or $x52641 (and (<= 1 v_0_cb_length_13) (>= 4 v_0_cb_length_13)))))
 (and $x53625 (or $x53626 (and (= 0 v_0_cb_length_13) (= 0 v_0_cb_end_13))) $x53628 (or (not (and $x53626 (<= 1 ?x53615))) $x57020))))))))))))))))
(assert
 (let ((?x46208 (mod (+ v_0_cb_end_13 v_0_cb_length_14) 4294967296)))
 (let (($x46209 (= v_0_cb_end_14 ?x46208)))
 (let ((?x24672 (* (- 1) v_0_cb_head)))
 (let ((?x24885 (+ 30 ?x24672)))
 (let ((?x24882 (+ 14 ?x24672)))
 (let (($x2348 (>= 14 v_0_cb_head)))
 (let ((?x53638 (ite $x2348 ?x24882 ?x24885)))
 (let (($x53635 (>= ?x53638 v_0_cb_count)))
 (let (($x53632 (not $x53635)))
 (let ((?x53639 (mod (+ v_0_snd_una v_0_cb_length_14 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x56990 (not (>= v_0_cb_partial_prefix v_0_cb_length_14))))
 (let (($x53656 (or (not (and $x53632 (= 14 v_0_cb_head))) (and $x56990 (= v_0_cb_end_14 ?x53639)))))
 (let (($x53641 (or $x53635 (and (<= 1 v_0_cb_length_14) (>= 4 v_0_cb_length_14)))))
 (and $x53641 (or $x53632 (and (= 0 v_0_cb_length_14) (= 0 v_0_cb_end_14))) $x53656 (or (not (and $x53632 (<= 1 ?x53638))) $x46209))))))))))))))))
(assert
 (let ((?x44597 (mod (+ v_0_cb_end_14 v_0_cb_length_15) 4294967296)))
 (let (($x44598 (= v_0_cb_end_15 ?x44597)))
 (let ((?x24672 (* (- 1) v_0_cb_head)))
 (let ((?x24900 (+ 31 ?x24672)))
 (let ((?x24897 (+ 15 ?x24672)))
 (let (($x2361 (>= 15 v_0_cb_head)))
 (let ((?x53868 (ite $x2361 ?x24897 ?x24900)))
 (let (($x46677 (>= ?x53868 v_0_cb_count)))
 (let (($x46678 (not $x46677)))
 (let ((?x53679 (mod (+ v_0_snd_una v_0_cb_length_15 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x51213 (not (>= v_0_cb_partial_prefix v_0_cb_length_15))))
 (let (($x53671 (or (not (and $x46678 (= 15 v_0_cb_head))) (and $x51213 (= v_0_cb_end_15 ?x53679)))))
 (let (($x53669 (or $x46677 (and (<= 1 v_0_cb_length_15) (>= 4 v_0_cb_length_15)))))
 (and $x53669 (or $x46678 (and (= 0 v_0_cb_length_15) (= 0 v_0_cb_end_15))) $x53671 (or (not (and $x46678 (<= 1 ?x53868))) $x44598))))))))))))))))
(assert
 (let (($x48826 (= 4 v_0_nagle_first_bytes)))
 (let (($x1695 (not v_0_nagle_before_disabled)))
 (let (($x48823 (<= 1 v_0_nagle_before_flight)))
 (let (($x44601 (<= 1 v_0_nagle_first_bytes)))
 (or (not (and $x44601 $x48823 $x1695)) $x48826))))))
(assert
 (let (($x48066 (>= 4 v_0_nagle_first_bytes)))
 (let (($x47946 (<= 0 v_0_nagle_first_bytes)))
 (let (($x46601 (>= 16 v_0_nagle_before_flight)))
 (let (($x51112 (<= 0 v_0_nagle_before_flight)))
 (and $x51112 $x46601 $x47946 $x48066))))))
(assert
 (let (($x39774 (<= v_0_sws_decision_at_ms now_0)))
 (let (($x39770 (<= v_0_sws_decision_deadline_ms v_0_sws_decision_at_ms)))
 (let (($x39768 (= v_0_sws_decision_deadline_ms (+ v_0_sws_decision_started_ms v_0_sws_override_ms))))
 (let (($x39765 (<= 0 v_0_sws_decision_started_ms)))
 (let (($x1746 (not v_0_sws_decision_ready)))
 (let (($x39753 (= v_0_sws_decision_count v_0_sws_decision_queued)))
 (let (($x39751 (= v_0_sws_decision_pushed v_0_sws_decision_queued)))
 (let (($x1721 (= 0 v_0_sws_decision_flight)))
 (let (($x53730 (or v_0_sws_decision_disabled $x1721)))
 (let (($x53728 (and $x53730 (>= (* 2 v_0_sws_decision_count) v_0_sws_decision_maximum))))
 (let (($x39746 (= 4 v_0_sws_decision_count)))
 (let (($x39744 (<= v_0_sws_decision_count v_0_sws_decision_usable)))
 (let (($x39742 (<= v_0_sws_decision_count v_0_sws_decision_queued)))
 (let (($x39740 (<= 1 v_0_sws_decision_count)))
 (let (($x39738 (= v_0_sws_decision_count v_0_sws_sent_count)))
 (let (($x53732 (and v_0_sws_allowed_at_send $x39738 $x39740 $x39742 $x39744 (or v_0_sws_decision_ready $x39746 $x53728 (and $x53730 $x39751 $x39753)))))
 (let (($x39734 (>= 4 v_0_sws_sent_count)))
 (let (($x39732 (<= 0 v_0_sws_sent_count)))
 (let (($x53738 (or v_0_sws_active v_0_sws_override_ready (and (= 0 v_0_sws_started_ms) (= 0 v_0_sws_deadline_ms)))))
 (let (($x39720 (= v_0_sws_deadline_ms (+ v_0_sws_started_ms v_0_sws_override_ms))))
 (let (($x39717 (<= v_0_sws_started_ms now_0)))
 (let (($x39715 (<= 0 v_0_sws_started_ms)))
 (let (($x2626 (<= 1 v_0_snd_buf)))
 (let (($x1226 (not v_0_fin_sent)))
 (let (($x39795 (or v_0_sws_active v_0_sws_override_ready)))
 (let (($x39803 (not $x39795)))
 (let (($x39796 (= v_0_sws_requested $x39795)))
 (let (($x39794 (not (and v_0_sws_active v_0_sws_override_ready))))
 (let (($x39703 (= v_0_sws_active active_0_sws)))
 (let (($x39701 (<= v_0_sws_push_bytes v_0_snd_buf)))
 (let (($x39699 (<= 0 v_0_sws_push_bytes)))
 (let (($x39692 (>= v_0_sws_max_window v_0_sws_previous_max)))
 (let (($x2622 (>= v_0_sws_max_window v_0_snd_wnd)))
 (let (($x39685 (>= 65535 v_0_sws_max_window)))
 (let (($x39683 (<= 0 v_0_sws_max_window)))
 (let (($x39681 (>= 1000 v_0_sws_override_ms)))
 (let (($x39679 (<= 100 v_0_sws_override_ms)))
 (and $x39679 $x39681 $x39683 $x39685 $x2622 $x39692 $x39699 $x39701 $x39703 $x39794 $x39796 (or $x39803 (and $x1226 $x2626 $x39715 $x39717 $x39720)) $x53738 (or (not v_0_sws_override_ready) (<= v_0_sws_deadline_ms now_0)) $x39732 $x39734 (or (not (<= 1 v_0_sws_sent_count)) $x53732) (or $x1746 (and $x39765 $x39768 $x39770)) $x39774)))))))))))))))))))))))))))))))))))))))
(assert
 (let ((?x25359 (* (- 1) v_0_rtt_start_ms)))
 (let ((?x40167 (+ now_1 ?x25359)))
 (let (($x1259 (not v_0_rtt_ambiguous)))
 (let ((?x25321 (* (- 1) v_0_snd_una)))
 (let ((?x40162 (+ v_0_rtt_end ?x25321)))
 (let ((?x67389 (mod ?x40162 4294967296)))
 (let ((?x42523 (+ input_0_net.fin_segment_ack ?x25321)))
 (let ((?x48394 (mod ?x42523 4294967296)))
 (let ((?x11056 (ite v_0_fin_sent 1 0)))
 (let ((?x11057 (+ v_0_rtx_buf ?x11056)))
 (let (($x44670 (<= ?x48394 ?x11057)))
 (let (($x61719 (<= 1 ?x48394)))
 (let ((?x31734 (+ (- 1) v_0_local_window)))
 (let ((?x881 (* (- 1) v_0_rcv_nxt)))
 (let ((?x55212 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data ?x881) 4294967296)))
 (let (($x65869 (<= ?x55212 ?x31734)))
 (let (($x7937 (<= 1 v_0_local_window)))
 (let (($x70766 (or (and $x7937 (<= (mod (+ input_0_net.fin_segment_seq ?x881) 4294967296) ?x31734)) (and $x7937 $x65869))))
 (let (($x64642 (and v_0_rtt_active $x70766 $x61719 $x44670 (>= ?x48394 ?x67389) $x1259)))
 (let ((?x48964 (to_real (ite $x64642 ?x40167 v_0_rtt_last_ms))))
 (let ((?x49471 (+ v_0_srtt_ms (* (- 1.0) ?x48964))))
 (let ((?x50067 (ite $x64642 (ite (>= ?x49471 0.0) ?x49471 (+ (* (- 1.0) v_0_srtt_ms) ?x48964)) v_0_rtt_error_ms)))
 (let ((?x25368 (* (/ 3.0 4.0) v_0_rttvar_ms)))
 (let ((?x45980 (ite $x64642 (ite v_0_rtt_measured (+ ?x25368 (* (/ 1.0 4.0) ?x50067)) (* (/ 1.0 2.0) ?x48964)) v_0_rttvar_ms)))
 (let ((?x68975 (ite v_0_rtt_measured (+ (* (/ 7.0 8.0) v_0_srtt_ms) (* (/ 1.0 8.0) ?x48964)) ?x48964)))
 (let ((?x49455 (+ (* (- 1.0) (ite $x64642 ?x68975 v_0_srtt_ms)) (* (- 1.0) (ite (<= ?x45980 (/ 1.0 4.0)) 1.0 (* 4.0 ?x45980))))))
 (let ((?x61331 (to_int ?x49455)))
 (let ((?x64344 (ite (<= ?x61331 (- 1000)) (* (- 1) ?x61331) 1000)))
 (let ((?x64931 (ite $x64642 (ite (<= 60000 ?x64344) 60000 ?x64344) v_0_rto_ms)))
 (let (($x60784 (<= ?x64931 0)))
 (let (($x57824 (not (and $x70766 $x61719 $x44670 v_0_fin_sent (= ?x48394 ?x11057)))))
 (let (($x53344 (and $x57824 v_0_fin_sent)))
 (let (($x40470 (<= 0 v_0_rtx_buf)))
 (let ((?x60621 (ite $x40470 v_0_rtx_buf 0)))
 (let ((?x45215 (ite (<= v_0_rtx_buf ?x48394) 0 (+ v_0_rtx_buf (* (- 1) ?x48394)))))
 (let ((?x69284 (ite (and $x70766 $x61719 $x44670) (ite (<= ?x45215 ?x60621) ?x45215 ?x60621) v_0_rtx_buf)))
 (let ((?x44423 (+ ?x69284 (ite $x53344 1 0))))
 (let (($x44620 (<= 1 ?x44423)))
 (let (($x59845 (or (and (not (and $x70766 $x61719 $x44670 (= 0 ?x44423))) active_0_rtx) (and $x70766 $x61719 $x44670 $x44620))))
 (let (($x53778 (= ?x48394 ?x11057)))
 (let (($x1232 (not v_0_rx_fin_pending)))
 (let (($x1237 (not v_0_rx_fin_done)))
 (let (($x68191 (not (and (>= ?x48394 (+ 1 v_0_rtx_buf ?x11056)) (>= 2147483647 ?x48394)))))
 (let (($x46428 (and $x70766 $x68191 $x1237 $x1232 $x7937 $x65869)))
 (let ((?x60587 (ite $x46428 ?x55212 v_0_rx_fin_offset)))
 (let ((?x34621 (mod (+ 15 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x34625 (+ input_0_net.fin_segment_data (* (- 1) ?x34621))))
 (let (($x47653 (<= input_0_net.fin_segment_data ?x34621)))
 (let (($x32307 (<= v_0_rcv_buf 0)))
 (let (($x1203 (= 0 v_0_rx_slot_15)))
 (let (($x47341 (and $x70766 $x68191 $x1237 $x1203 $x32307 (<= ?x34621 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x55150 (ite $x47341 (ite (or $x47653 (<= ?x34625 1)) (ite $x47653 0 ?x34625) 1) v_0_rx_slot_15)))
 (let (($x52331 (or (= ?x55150 0) (and (or v_0_rx_fin_pending $x46428) (>= 15 ?x60587)))))
 (let ((?x34588 (mod (+ 14 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x34592 (+ input_0_net.fin_segment_data (* (- 1) ?x34588))))
 (let (($x53837 (<= input_0_net.fin_segment_data ?x34588)))
 (let (($x32271 (<= v_0_rcv_buf 1)))
 (let (($x1201 (= 0 v_0_rx_slot_14)))
 (let (($x51975 (and $x70766 $x68191 $x1237 $x1201 $x32271 (<= ?x34588 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x66698 (ite $x51975 (ite (or $x53837 (<= ?x34592 1)) (ite $x53837 0 ?x34592) 1) v_0_rx_slot_14)))
 (let (($x62803 (or (= ?x66698 0) (and (or v_0_rx_fin_pending $x46428) (>= 14 ?x60587)))))
 (let ((?x34555 (mod (+ 13 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x34559 (+ input_0_net.fin_segment_data (* (- 1) ?x34555))))
 (let (($x48154 (<= input_0_net.fin_segment_data ?x34555)))
 (let (($x32235 (<= v_0_rcv_buf 2)))
 (let (($x1199 (= 0 v_0_rx_slot_13)))
 (let (($x45180 (and $x70766 $x68191 $x1237 $x1199 $x32235 (<= ?x34555 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x48792 (ite $x45180 (ite (or $x48154 (<= ?x34559 1)) (ite $x48154 0 ?x34559) 1) v_0_rx_slot_13)))
 (let (($x71250 (or (= ?x48792 0) (and (or v_0_rx_fin_pending $x46428) (>= 13 ?x60587)))))
 (let ((?x34524 (mod (+ 12 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x34528 (+ input_0_net.fin_segment_data (* (- 1) ?x34524))))
 (let (($x63893 (<= input_0_net.fin_segment_data ?x34524)))
 (let (($x32207 (<= v_0_rcv_buf 3)))
 (let (($x1197 (= 0 v_0_rx_slot_12)))
 (let (($x70712 (and $x70766 $x68191 $x1237 $x1197 $x32207 (<= ?x34524 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x52052 (ite $x70712 (ite (or $x63893 (<= ?x34528 1)) (ite $x63893 0 ?x34528) 1) v_0_rx_slot_12)))
 (let (($x65531 (or (= ?x52052 0) (and (or v_0_rx_fin_pending $x46428) (>= 12 ?x60587)))))
 (let ((?x58105 (ite $x65531 12 (ite $x71250 13 (ite $x62803 14 (ite $x52331 15 16))))))
 (let ((?x34491 (mod (+ 11 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x34495 (+ input_0_net.fin_segment_data (* (- 1) ?x34491))))
 (let (($x59076 (<= input_0_net.fin_segment_data ?x34491)))
 (let (($x32176 (<= v_0_rcv_buf 4)))
 (let (($x1195 (= 0 v_0_rx_slot_11)))
 (let (($x59263 (and $x70766 $x68191 $x1237 $x1195 $x32176 (<= ?x34491 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x65668 (ite $x59263 (ite (or $x59076 (<= ?x34495 1)) (ite $x59076 0 ?x34495) 1) v_0_rx_slot_11)))
 (let (($x44723 (or (= ?x65668 0) (and (or v_0_rx_fin_pending $x46428) (>= 11 ?x60587)))))
 (let ((?x34458 (mod (+ 10 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x34462 (+ input_0_net.fin_segment_data (* (- 1) ?x34458))))
 (let (($x65796 (<= input_0_net.fin_segment_data ?x34458)))
 (let (($x32141 (<= v_0_rcv_buf 5)))
 (let (($x1193 (= 0 v_0_rx_slot_10)))
 (let (($x53043 (and $x70766 $x68191 $x1237 $x1193 $x32141 (<= ?x34458 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x62073 (ite $x53043 (ite (or $x65796 (<= ?x34462 1)) (ite $x65796 0 ?x34462) 1) v_0_rx_slot_10)))
 (let (($x62555 (or (= ?x62073 0) (and (or v_0_rx_fin_pending $x46428) (>= 10 ?x60587)))))
 (let ((?x34425 (mod (+ 9 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x34429 (+ input_0_net.fin_segment_data (* (- 1) ?x34425))))
 (let (($x65477 (<= input_0_net.fin_segment_data ?x34425)))
 (let (($x32105 (<= v_0_rcv_buf 6)))
 (let (($x1191 (= 0 v_0_rx_slot_09)))
 (let (($x66718 (and $x70766 $x68191 $x1237 $x1191 $x32105 (<= ?x34425 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x46998 (ite $x66718 (ite (or $x65477 (<= ?x34429 1)) (ite $x65477 0 ?x34429) 1) v_0_rx_slot_09)))
 (let (($x58617 (or (= ?x46998 0) (and (or v_0_rx_fin_pending $x46428) (>= 9 ?x60587)))))
 (let ((?x34392 (mod (+ 8 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x34396 (+ input_0_net.fin_segment_data (* (- 1) ?x34392))))
 (let (($x66035 (<= input_0_net.fin_segment_data ?x34392)))
 (let (($x32075 (<= v_0_rcv_buf 7)))
 (let (($x1189 (= 0 v_0_rx_slot_08)))
 (let (($x57864 (and $x70766 $x68191 $x1237 $x1189 $x32075 (<= ?x34392 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x65741 (ite $x57864 (ite (or $x66035 (<= ?x34396 1)) (ite $x66035 0 ?x34396) 1) v_0_rx_slot_08)))
 (let (($x65510 (or (= ?x65741 0) (and (or v_0_rx_fin_pending $x46428) (>= 8 ?x60587)))))
 (let ((?x70361 (ite $x65510 8 (ite $x58617 9 (ite $x62555 10 (ite $x44723 11 ?x58105))))))
 (let ((?x34359 (mod (+ 7 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x34363 (+ input_0_net.fin_segment_data (* (- 1) ?x34359))))
 (let (($x51698 (<= input_0_net.fin_segment_data ?x34359)))
 (let (($x32039 (<= v_0_rcv_buf 8)))
 (let (($x1187 (= 0 v_0_rx_slot_07)))
 (let (($x71400 (and $x70766 $x68191 $x1237 $x1187 $x32039 (<= ?x34359 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x65312 (ite $x71400 (ite (or $x51698 (<= ?x34363 1)) (ite $x51698 0 ?x34363) 1) v_0_rx_slot_07)))
 (let (($x65560 (or (= ?x65312 0) (and (or v_0_rx_fin_pending $x46428) (>= 7 ?x60587)))))
 (let ((?x34326 (mod (+ 6 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x34330 (+ input_0_net.fin_segment_data (* (- 1) ?x34326))))
 (let (($x64428 (<= input_0_net.fin_segment_data ?x34326)))
 (let (($x32002 (<= v_0_rcv_buf 9)))
 (let (($x1185 (= 0 v_0_rx_slot_06)))
 (let (($x51776 (and $x70766 $x68191 $x1237 $x1185 $x32002 (<= ?x34326 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x58569 (ite $x51776 (ite (or $x64428 (<= ?x34330 1)) (ite $x64428 0 ?x34330) 1) v_0_rx_slot_06)))
 (let (($x53459 (or (= ?x58569 0) (and (or v_0_rx_fin_pending $x46428) (>= 6 ?x60587)))))
 (let ((?x34293 (mod (+ 5 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x34297 (+ input_0_net.fin_segment_data (* (- 1) ?x34293))))
 (let (($x52252 (<= input_0_net.fin_segment_data ?x34293)))
 (let (($x31966 (<= v_0_rcv_buf 10)))
 (let (($x1183 (= 0 v_0_rx_slot_05)))
 (let (($x58698 (and $x70766 $x68191 $x1237 $x1183 $x31966 (<= ?x34293 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x68560 (ite $x58698 (ite (or $x52252 (<= ?x34297 1)) (ite $x52252 0 ?x34297) 1) v_0_rx_slot_05)))
 (let (($x67306 (or (= ?x68560 0) (and (or v_0_rx_fin_pending $x46428) (>= 5 ?x60587)))))
 (let ((?x34261 (mod (+ 4 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x34265 (+ input_0_net.fin_segment_data (* (- 1) ?x34261))))
 (let (($x51093 (<= input_0_net.fin_segment_data ?x34261)))
 (let (($x31930 (<= v_0_rcv_buf 11)))
 (let (($x1181 (= 0 v_0_rx_slot_04)))
 (let (($x67322 (and $x70766 $x68191 $x1237 $x1181 $x31930 (<= ?x34261 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x67826 (ite $x67322 (ite (or $x51093 (<= ?x34265 1)) (ite $x51093 0 ?x34265) 1) v_0_rx_slot_04)))
 (let (($x66151 (or (= ?x67826 0) (and (or v_0_rx_fin_pending $x46428) (>= 4 ?x60587)))))
 (let ((?x69208 (ite $x66151 4 (ite $x67306 5 (ite $x53459 6 (ite $x65560 7 ?x70361))))))
 (let ((?x34228 (mod (+ 3 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x34232 (+ input_0_net.fin_segment_data (* (- 1) ?x34228))))
 (let (($x49875 (<= input_0_net.fin_segment_data ?x34228)))
 (let (($x31894 (<= v_0_rcv_buf 12)))
 (let (($x1179 (= 0 v_0_rx_slot_03)))
 (let (($x58219 (and $x70766 $x68191 $x1237 $x1179 $x31894 (<= ?x34228 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x61342 (ite $x58219 (ite (or $x49875 (<= ?x34232 1)) (ite $x49875 0 ?x34232) 1) v_0_rx_slot_03)))
 (let (($x64117 (or (= ?x61342 0) (and (or v_0_rx_fin_pending $x46428) (>= 3 ?x60587)))))
 (let ((?x34195 (mod (+ 2 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x34199 (+ input_0_net.fin_segment_data (* (- 1) ?x34195))))
 (let (($x53022 (<= input_0_net.fin_segment_data ?x34195)))
 (let (($x31859 (<= v_0_rcv_buf 13)))
 (let (($x1177 (= 0 v_0_rx_slot_02)))
 (let (($x48898 (and $x70766 $x68191 $x1237 $x1177 $x31859 (<= ?x34195 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x44856 (ite $x48898 (ite (or $x53022 (<= ?x34199 1)) (ite $x53022 0 ?x34199) 1) v_0_rx_slot_02)))
 (let (($x60296 (or (= ?x44856 0) (and (or v_0_rx_fin_pending $x46428) (>= 2 ?x60587)))))
 (let ((?x34162 (mod (+ 1 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x34166 (+ input_0_net.fin_segment_data (* (- 1) ?x34162))))
 (let (($x64341 (<= input_0_net.fin_segment_data ?x34162)))
 (let (($x31823 (<= v_0_rcv_buf 14)))
 (let (($x1175 (= 0 v_0_rx_slot_01)))
 (let (($x62203 (and $x70766 $x68191 $x1237 $x1175 $x31823 (<= ?x34162 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x71119 (ite $x62203 (ite (or $x64341 (<= ?x34166 1)) (ite $x64341 0 ?x34166) 1) v_0_rx_slot_01)))
 (let (($x45164 (or (= ?x71119 0) (and (or v_0_rx_fin_pending $x46428) (>= 1 ?x60587)))))
 (let ((?x34090 (* (- 1) input_0_net.fin_segment_seq)))
 (let ((?x34091 (+ v_0_rcv_nxt ?x34090)))
 (let ((?x25490 (mod ?x34091 4294967296)))
 (let ((?x34135 (+ input_0_net.fin_segment_data (* (- 1) ?x25490))))
 (let (($x47299 (<= input_0_net.fin_segment_data ?x25490)))
 (let (($x31788 (<= v_0_rcv_buf 15)))
 (let (($x1173 (= 0 v_0_rx_slot_00)))
 (let (($x59963 (and $x70766 $x68191 $x1237 $x1173 $x31788 (<= ?x25490 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x64099 (ite $x59963 (ite (or $x47299 (<= ?x34135 1)) (ite $x47299 0 ?x34135) 1) v_0_rx_slot_00)))
 (let (($x68838 (or (= ?x64099 0) (and (or v_0_rx_fin_pending $x46428) (>= 0 ?x60587)))))
 (let ((?x45823 (ite $x68838 0 (ite $x45164 1 (ite $x60296 2 (ite $x64117 3 ?x69208))))))
 (let (($x60433 (or v_0_rx_fin_pending $x46428)))
 (let (($x59572 (= 0 (ite $x60433 (+ ?x60587 (* (- 1) ?x45823)) ?x60587))))
 (let (($x69469 (not (and $x60433 $x1237 $x59572 $x70766 $x61719 $x44670 v_0_fin_sent $x53778))))
 (let (($x51514 (or v_0_persist_active (= 0 ?x69284))))
 (let (($x61053 (>= 1 ?x69284)))
 (let (($x65408 (<= 1 (+ ?x69284 v_0_snd_buf))))
 (let (($x58655 (not $x53344)))
 (let (($x54644 (<= 2147483648 (mod (+ input_0_net.fin_segment_ack (* (- 1) v_0_snd_wl2)) 4294967296))))
 (let (($x16946 (= v_0_snd_wl1 input_0_net.fin_segment_seq)))
 (let ((?x26378 (* (- 1) v_0_snd_wl1)))
 (let ((?x42759 (+ input_0_net.fin_segment_seq ?x26378)))
 (let ((?x59295 (mod ?x42759 4294967296)))
 (let (($x55515 (or (and (not (<= ?x59295 0)) (not (<= 2147483648 ?x59295))) (and $x16946 (not $x54644)))))
 (let (($x55896 (= 0 (ite (and $x70766 $x44670 $x55515) input_0_net.fin_segment_window v_0_snd_wnd))))
 (let (($x69463 (not (and $x55896 $x58655 $x65408 $x61053 $x51514))))
 (let (($x40026 (not (<= due_0_sws now_1))))
 (let (($x1757 (not active_0_sws)))
 (let (($x69924 (or $x1757 $x40026)))
 (let (($x40024 (not (<= due_0_persist now_1))))
 (let (($x1755 (not active_0_persist)))
 (let (($x45006 (or $x1755 $x40024)))
 (let (($x40022 (not (<= due_0_delack now_1))))
 (let (($x1753 (not active_0_delack)))
 (let (($x52798 (or $x1753 $x40022)))
 (let (($x40020 (not (<= due_0_time_wait now_1))))
 (let (($x1751 (not active_0_time_wait)))
 (let (($x61064 (or $x1751 $x40020)))
 (let (($x40018 (not (<= due_0_user now_1))))
 (let (($x1749 (not active_0_user)))
 (let (($x68392 (or $x1749 $x40018)))
 (let (($x40016 (not (<= due_0_rtx now_1))))
 (let (($x1747 (not active_0_rtx)))
 (let (($x68204 (or $x1747 $x40016)))
 (let (($x67317 (or (= 0 ?x48394) (and $x61719 (<= ?x48394 (mod (+ v_0_snd_nxt ?x25321) 4294967296))))))
 (let (($x58072 (not $x67317)))
 (let (($x1226 (not v_0_fin_sent)))
 (let (($x53690 (= (mod (+ input_0_net.fin_segment_ack (* (- 1) v_0_snd_nxt)) 4294967296) 2147483648)))
 (let (($x65314 (or (not $x70766) (and (not (= ?x48394 2147483648)) (not $x53690)))))
 (let (($x16899 (>= 65535 input_0_net.fin_segment_window)))
 (let (($x16897 (<= 0 input_0_net.fin_segment_window)))
 (let (($x34092 (not (= ?x25490 2147483648))))
 (let (($x16890 (>= 16 input_0_net.fin_segment_data)))
 (let (($x16888 (<= 0 input_0_net.fin_segment_data)))
 (let (($x1872 (>= now_1 now_0)))
 (let (($x70775 (and $x1872 $x16888 $x16890 $x34092 $x16897 $x16899 $x65314 $x1226 $x58072 $x68204 $x68392 $x61064 $x52798 $x45006 $x69924 v_0_persist_active $x69463 (<= 1 ?x69284) (not (and $x69463 $x69469 $x59845)) $x60784)))
 (let (($x56428 (<= v_1_sws_decision_at_ms now_1)))
 (let (($x56432 (<= v_1_sws_decision_deadline_ms v_1_sws_decision_at_ms)))
 (let (($x46237 (= v_1_sws_decision_deadline_ms (+ v_1_sws_decision_started_ms v_1_sws_override_ms))))
 (let (($x49802 (<= 0 v_1_sws_decision_started_ms)))
 (let (($x25010 (not v_1_sws_decision_ready)))
 (let (($x53577 (= 4 v_1_sws_decision_count)))
 (let (($x44607 (= v_1_sws_decision_count v_1_sws_decision_queued)))
 (let (($x49801 (= v_1_sws_decision_pushed v_1_sws_decision_queued)))
 (let (($x2957 (= 0 v_1_sws_decision_flight)))
 (let (($x53114 (or v_1_sws_decision_disabled $x2957)))
 (let (($x44789 (and $x53114 (>= (* 2 v_1_sws_decision_count) v_1_sws_decision_maximum))))
 (let (($x45039 (<= v_1_sws_decision_count v_1_sws_decision_usable)))
 (let (($x48820 (<= v_1_sws_decision_count v_1_sws_decision_queued)))
 (let (($x48818 (<= 1 v_1_sws_decision_count)))
 (let (($x44591 (= v_1_sws_decision_count v_1_sws_sent_count)))
 (let (($x50626 (and v_1_sws_allowed_at_send $x44591 $x48818 $x48820 $x45039 (or v_1_sws_decision_ready $x44789 (and $x53114 $x49801 $x44607) $x53577))))
 (let (($x44587 (>= 4 v_1_sws_sent_count)))
 (let (($x44585 (<= 0 v_1_sws_sent_count)))
 (let (($x55037 (or v_1_sws_active v_1_sws_override_ready (and (= 0 v_1_sws_started_ms) (= 0 v_1_sws_deadline_ms)))))
 (let (($x56166 (or v_1_sws_active v_1_sws_override_ready)))
 (let (($x56365 (not $x56166)))
 (let (($x56167 (= v_1_sws_requested $x56166)))
 (let (($x56165 (not (and v_1_sws_active v_1_sws_override_ready))))
 (let (($x44564 (= v_1_sws_active active_1_sws)))
 (let (($x44559 (<= v_1_sws_push_bytes v_1_snd_buf)))
 (let (($x55156 (<= 0 v_1_sws_push_bytes)))
 (let (($x48803 (= 0 v_1_sws_max_window)))
 (let (($x50966 (>= 65535 v_1_sws_max_window)))
 (let (($x53350 (<= 0 v_1_sws_max_window)))
 (let (($x55594 (>= 1000 v_1_sws_override_ms)))
 (let (($x48789 (<= 100 v_1_sws_override_ms)))
 (let (($x68955 (and $x48789 $x55594 $x53350 $x50966 $x48803 $x55156 $x44559 $x44564 $x56165 $x56167 $x56365 $x55037 (or (not v_1_sws_override_ready) (<= v_1_sws_deadline_ms now_1)) $x44585 $x44587 (or (not (<= 1 v_1_sws_sent_count)) $x50626) (or $x25010 (and $x49802 $x46237 $x56432)) $x56428 (or (not active_1_rtx) (>= due_1_rtx now_1)) (or (not active_1_user) (>= due_1_user now_1)) (or (not active_1_time_wait) (>= due_1_time_wait now_1)) (or (not active_1_delack) (>= due_1_delack now_1)) (or (not active_1_persist) (>= due_1_persist now_1)) (or (not active_1_sws) (>= due_1_sws now_1)))))
 (let (($x67894 (and $x1872 $x16888 $x16890 $x34092 $x16897 $x16899 $x65314 $x1226 $x58072 $x68204 $x68392 $x61064 $x52798 $x45006 $x69924 $x70766 $x61719 $x44670 $x44620 $x60784)))
 (let (($x2657 (<= v_0_sws_override_ms 0)))
 (let (($x2626 (<= 1 v_0_snd_buf)))
 (let (($x70222 (or (and $x60433 $x1237 $x59572) $x57824)))
 (let (($x53413 (and $x1872 $x16888 $x16890 $x34092 $x16897 $x16899 $x65314 $x1226 $x58072 $x68204 $x68392 $x61064 $x52798 $x45006 $x69924 $x69469 $x70222 $x58655 $x2626 v_0_sws_requested (not (and $x69469 $x70222 $x58655 $x2626 v_0_sws_active)) (not (and $x69469 $x70222 $x58655 $x2626 v_0_sws_override_ready)) $x2657)))
 (let ((?x59962 (ite (and $x55896 $x58655 $x65408 $x61053 $x51514 (not v_0_persist_active)) ?x64931 v_0_persist_interval_ms)))
 (let (($x1355 (not v_0_persist_active)))
 (let (($x48221 (and $x1872 $x16888 $x16890 $x34092 $x16897 $x16899 $x65314 $x1226 $x58072 $x68204 $x68392 $x61064 $x52798 $x45006 $x69924 $x55896 $x58655 $x65408 $x61053 $x51514 $x1355 (<= ?x59962 0))))
 (or $x48221 $x53413 $x67894 (not $x68955) $x70775))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 (= 176 choice_0))
(assert
 (= 5 state_0))
(assert
 (= 10 state_1))
(check-sat)
