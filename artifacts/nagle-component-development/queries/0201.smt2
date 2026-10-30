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
(declare-fun now_1 () Int)
(declare-fun v_0_rtt_ambiguous () Bool)
(declare-fun input_0_net.fin_segment_window () Int)
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
(declare-fun v_1_nagle_first_bytes () Int)
(declare-fun v_1_nagle_before_disabled () Bool)
(declare-fun v_1_nagle_before_flight () Int)
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
 (let (($x53598 (>= due_0_rtx now_0)))
 (let (($x1648 (not active_0_rtx)))
 (or $x1648 $x53598))))
(assert
 (let (($x53611 (>= due_0_user now_0)))
 (let (($x1652 (not active_0_user)))
 (or $x1652 $x53611))))
(assert
 (let (($x53616 (>= due_0_time_wait now_0)))
 (let (($x1654 (not active_0_time_wait)))
 (or $x1654 $x53616))))
(assert
 (let (($x54009 (>= due_0_delack now_0)))
 (let (($x1656 (not active_0_delack)))
 (or $x1656 $x54009))))
(assert
 (let (($x42273 (>= due_0_persist now_0)))
 (let (($x1658 (not active_0_persist)))
 (or $x1658 $x42273))))
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
 (let ((?x1785 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1785)))
(assert
 (>= 16 v_0_rcv_buf))
(assert
 (let (($x44511 (>= 65535 v_0_snd_wnd)))
 (let (($x2922 (<= 0 v_0_snd_wnd)))
 (and $x2922 $x44511))))
(assert
 (let ((?x29143 (* (- 1) v_0_rcv_buf)))
 (let ((?x29144 (+ 16 ?x29143)))
 (= v_0_local_window ?x29144))))
(assert
 (>= 1 v_0_rx_slot_00))
(assert
 (let (($x1123 (= 0 v_0_rx_slot_00)))
 (let (($x49420 (not (>= v_0_rcv_buf 16))))
 (or $x49420 $x1123))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x1125 (= 0 v_0_rx_slot_01)))
 (let (($x49390 (not (>= v_0_rcv_buf 15))))
 (or $x49390 $x1125))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x1127 (= 0 v_0_rx_slot_02)))
 (let (($x49398 (not (>= v_0_rcv_buf 14))))
 (or $x49398 $x1127))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x1129 (= 0 v_0_rx_slot_03)))
 (let (($x49385 (not (>= v_0_rcv_buf 13))))
 (or $x49385 $x1129))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x1131 (= 0 v_0_rx_slot_04)))
 (let (($x49370 (not (>= v_0_rcv_buf 12))))
 (or $x49370 $x1131))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x1133 (= 0 v_0_rx_slot_05)))
 (let (($x49373 (not (>= v_0_rcv_buf 11))))
 (or $x49373 $x1133))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x1135 (= 0 v_0_rx_slot_06)))
 (let (($x49365 (not (>= v_0_rcv_buf 10))))
 (or $x49365 $x1135))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x1137 (= 0 v_0_rx_slot_07)))
 (let (($x49350 (not (>= v_0_rcv_buf 9))))
 (or $x49350 $x1137))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x1139 (= 0 v_0_rx_slot_08)))
 (let (($x49358 (not (>= v_0_rcv_buf 8))))
 (or $x49358 $x1139))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x1141 (= 0 v_0_rx_slot_09)))
 (let (($x49363 (not (>= v_0_rcv_buf 7))))
 (or $x49363 $x1141))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x1143 (= 0 v_0_rx_slot_10)))
 (let (($x49600 (not (>= v_0_rcv_buf 6))))
 (or $x49600 $x1143))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x1145 (= 0 v_0_rx_slot_11)))
 (let (($x49338 (not (>= v_0_rcv_buf 5))))
 (or $x49338 $x1145))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x1147 (= 0 v_0_rx_slot_12)))
 (let (($x49342 (not (>= v_0_rcv_buf 4))))
 (or $x49342 $x1147))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x1149 (= 0 v_0_rx_slot_13)))
 (let (($x49345 (not (>= v_0_rcv_buf 3))))
 (or $x49345 $x1149))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x1151 (= 0 v_0_rx_slot_14)))
 (let (($x49314 (not (>= v_0_rcv_buf 2))))
 (or $x49314 $x1151))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x1153 (= 0 v_0_rx_slot_15)))
 (let (($x49322 (not (>= v_0_rcv_buf 1))))
 (or $x49322 $x1153))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x49325 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x49325)))
(assert
 (let (($x44586 (>= 16 v_0_rx_advance)))
 (let (($x44584 (<= 0 v_0_rx_advance)))
 (and $x44584 $x44586))))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (let (($x44590 (>= 4294967295 v_0_ack_delta)))
 (let (($x44589 (<= 0 v_0_ack_delta)))
 (and $x44589 $x44590))))
(assert
 true)
(assert
 (let ((?x49274 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x49274)))
(assert
 (let (($x1106 (= 0 v_0_snd_buf)))
 (let ((?x49814 (mod (+ v_0_snd_una v_0_rtx_buf) 4294967296)))
 (let (($x51507 (= v_0_fin_seq ?x49814)))
 (let (($x1176 (not v_0_fin_sent)))
 (or $x1176 (and v_0_fin_requested $x51507 $x1106)))))))
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
 (let (($x53903 (<= 1 v_0_rx_fin_offset)))
 (let (($x1187 (not v_0_rx_fin_done)))
 (let (($x1182 (not v_0_rx_fin_pending)))
 (or $x1182 (and $x1187 $x53903 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window))))))))
(assert
 (let (($x53903 (<= 1 v_0_rx_fin_offset)))
 (let (($x53975 (= v_0_rx_fin_pending $x53903)))
 (let (($x14198 (>= 15 v_0_rx_fin_offset)))
 (let (($x53978 (<= 0 v_0_rx_fin_offset)))
 (and $x53978 $x14198 $x53975))))))
(assert
 (let ((?x53973 (mod (+ v_0_rcv_nxt v_0_rx_fin_offset) 4294967296)))
 (let (($x53974 (= v_0_rx_fin_seq ?x53973)))
 (let (($x1182 (not v_0_rx_fin_pending)))
 (or $x1182 $x53974)))))
(assert
 (let (($x1187 (not v_0_rx_fin_done)))
 (or $x1187 (= v_0_rcv_nxt (mod (+ 1 v_0_rx_fin_seq) 4294967296)))))
(assert
 (let (($x1123 (= 0 v_0_rx_slot_00)))
 (or (not (and v_0_rx_fin_pending (>= 0 v_0_rx_fin_offset))) $x1123)))
(assert
 (let (($x1125 (= 0 v_0_rx_slot_01)))
 (or (not (and v_0_rx_fin_pending (>= 1 v_0_rx_fin_offset))) $x1125)))
(assert
 (let (($x1127 (= 0 v_0_rx_slot_02)))
 (or (not (and v_0_rx_fin_pending (>= 2 v_0_rx_fin_offset))) $x1127)))
(assert
 (let (($x1129 (= 0 v_0_rx_slot_03)))
 (or (not (and v_0_rx_fin_pending (>= 3 v_0_rx_fin_offset))) $x1129)))
(assert
 (let (($x1131 (= 0 v_0_rx_slot_04)))
 (or (not (and v_0_rx_fin_pending (>= 4 v_0_rx_fin_offset))) $x1131)))
(assert
 (let (($x1133 (= 0 v_0_rx_slot_05)))
 (or (not (and v_0_rx_fin_pending (>= 5 v_0_rx_fin_offset))) $x1133)))
(assert
 (let (($x1135 (= 0 v_0_rx_slot_06)))
 (or (not (and v_0_rx_fin_pending (>= 6 v_0_rx_fin_offset))) $x1135)))
(assert
 (let (($x1137 (= 0 v_0_rx_slot_07)))
 (or (not (and v_0_rx_fin_pending (>= 7 v_0_rx_fin_offset))) $x1137)))
(assert
 (let (($x1139 (= 0 v_0_rx_slot_08)))
 (or (not (and v_0_rx_fin_pending (>= 8 v_0_rx_fin_offset))) $x1139)))
(assert
 (let (($x1141 (= 0 v_0_rx_slot_09)))
 (or (not (and v_0_rx_fin_pending (>= 9 v_0_rx_fin_offset))) $x1141)))
(assert
 (let (($x1143 (= 0 v_0_rx_slot_10)))
 (or (not (and v_0_rx_fin_pending (>= 10 v_0_rx_fin_offset))) $x1143)))
(assert
 (let (($x1145 (= 0 v_0_rx_slot_11)))
 (or (not (and v_0_rx_fin_pending (>= 11 v_0_rx_fin_offset))) $x1145)))
(assert
 (let (($x1147 (= 0 v_0_rx_slot_12)))
 (or (not (and v_0_rx_fin_pending (>= 12 v_0_rx_fin_offset))) $x1147)))
(assert
 (let (($x1149 (= 0 v_0_rx_slot_13)))
 (or (not (and v_0_rx_fin_pending (>= 13 v_0_rx_fin_offset))) $x1149)))
(assert
 (let (($x1151 (= 0 v_0_rx_slot_14)))
 (or (not (and v_0_rx_fin_pending (>= 14 v_0_rx_fin_offset))) $x1151)))
(assert
 (let (($x1153 (= 0 v_0_rx_slot_15)))
 (or (not (and v_0_rx_fin_pending (>= 15 v_0_rx_fin_offset))) $x1153)))
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
 (let (($x53874 (>= 60000 v_0_rto_ms)))
 (let (($x53953 (>= v_0_rto_ms v_0_rto_base_ms)))
 (let (($x53873 (>= 60000 v_0_rto_base_ms)))
 (let (($x53879 (<= 1000 v_0_rto_base_ms)))
 (and $x53879 $x53873 $x53953 $x53874))))))
(assert
 (let ((?x49159 (* 4.0 v_0_rttvar_ms)))
 (let ((?x49489 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x49159)))
 (let ((?x23109 (* (- 1.0) v_0_srtt_ms)))
 (let ((?x41352 (+ ?x23109 (* (- 1.0) ?x49489))))
 (let ((?x41353 (to_int ?x41352)))
 (let ((?x41354 (* (- 1) ?x41353)))
 (let ((?x44953 (ite (<= ?x41353 (- 1000)) ?x41354 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x44953) 60000 ?x44953) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x23056 (* (- 1) v_0_snd_una)))
 (let ((?x33815 (+ v_0_snd_nxt ?x23056)))
 (let ((?x55468 (mod ?x33815 4294967296)))
 (let ((?x37021 (+ v_0_rtt_end ?x23056)))
 (let ((?x65586 (mod ?x37021 4294967296)))
 (let (($x53938 (>= 4 v_0_rtt_remaining)))
 (let (($x53936 (<= 1 v_0_rtt_remaining)))
 (let (($x53939 (<= v_0_rtt_start_ms now_0)))
 (let (($x1207 (not v_0_rtt_active)))
 (or $x1207 (and $x53939 $x53936 $x53938 (>= ?x65586 v_0_rtt_remaining) (<= ?x65586 ?x55468)))))))))))))
(assert
 (let (($x1214 (= 0 v_0_rtt_remaining)))
 (or v_0_rtt_active $x1214)))
(assert
 true)
(assert
 (let ((?x23094 (* (- 1) v_0_rtt_start_ms)))
 (let ((?x49148 (+ v_0_rtt_sample_at_ms ?x23094)))
 (let (($x1223 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1221 (not v_0_rtt_sample_used)))
 (or $x1221 (and $x1223 v_0_rtt_measured (= v_0_rtt_last_ms ?x49148))))))))
(assert
 (let (($x53920 (<= v_0_rtt_sample_at_ms now_0)))
 (let (($x53923 (<= 0 v_0_rtt_sample_at_ms)))
 (and $x53923 $x53920))))
(assert
 (let ((?x53912 (to_real v_0_rtt_last_ms)))
 (let ((?x53144 (ite v_0_rtt_previous_measured (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x53912)) ?x53912)))
 (let ((?x50154 (* (- 1.0) v_0_rtt_previous_srtt)))
 (let ((?x50158 (+ ?x50154 ?x53912)))
 (let ((?x49567 (* (- 1.0) ?x53912)))
 (let ((?x49568 (+ v_0_rtt_previous_srtt ?x49567)))
 (let ((?x50165 (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* (/ 1.0 4.0) (ite (>= ?x49568 0.0) ?x49568 ?x50158)))))
 (let (($x53142 (= v_0_rttvar_ms (ite v_0_rtt_previous_measured ?x50165 (* (/ 1.0 2.0) ?x53912)))))
 (let (($x1221 (not v_0_rtt_sample_used)))
 (or $x1221 (and $x53142 (= v_0_srtt_ms ?x53144)))))))))))))
(assert
 (let (($x51219 (<= v_0_tx_time_00 now_0)))
 (let (($x9006 (<= 0 v_0_tx_time_00)))
 (and $x9006 $x51219 (or (not (>= 0 v_0_rtx_buf)) (= 0 v_0_tx_time_00))))))
(assert
 (let (($x51218 (<= v_0_tx_time_01 now_0)))
 (let (($x51213 (<= 0 v_0_tx_time_01)))
 (and $x51213 $x51218 (or (not (>= 1 v_0_rtx_buf)) (= 0 v_0_tx_time_01))))))
(assert
 (let (($x51201 (<= v_0_tx_time_02 now_0)))
 (let (($x51212 (<= 0 v_0_tx_time_02)))
 (and $x51212 $x51201 (or (not (>= 2 v_0_rtx_buf)) (= 0 v_0_tx_time_02))))))
(assert
 (let (($x51200 (<= v_0_tx_time_03 now_0)))
 (let (($x51195 (<= 0 v_0_tx_time_03)))
 (and $x51195 $x51200 (or (not (>= 3 v_0_rtx_buf)) (= 0 v_0_tx_time_03))))))
(assert
 (let (($x51183 (<= v_0_tx_time_04 now_0)))
 (let (($x51194 (<= 0 v_0_tx_time_04)))
 (and $x51194 $x51183 (or (not (>= 4 v_0_rtx_buf)) (= 0 v_0_tx_time_04))))))
(assert
 (let (($x51182 (<= v_0_tx_time_05 now_0)))
 (let (($x51177 (<= 0 v_0_tx_time_05)))
 (and $x51177 $x51182 (or (not (>= 5 v_0_rtx_buf)) (= 0 v_0_tx_time_05))))))
(assert
 (let (($x51165 (<= v_0_tx_time_06 now_0)))
 (let (($x51176 (<= 0 v_0_tx_time_06)))
 (and $x51176 $x51165 (or (not (>= 6 v_0_rtx_buf)) (= 0 v_0_tx_time_06))))))
(assert
 (let (($x51164 (<= v_0_tx_time_07 now_0)))
 (let (($x51159 (<= 0 v_0_tx_time_07)))
 (and $x51159 $x51164 (or (not (>= 7 v_0_rtx_buf)) (= 0 v_0_tx_time_07))))))
(assert
 (let (($x53904 (<= v_0_tx_time_08 now_0)))
 (let (($x51158 (<= 0 v_0_tx_time_08)))
 (and $x51158 $x53904 (or (not (>= 8 v_0_rtx_buf)) (= 0 v_0_tx_time_08))))))
(assert
 (let (($x53843 (<= v_0_tx_time_09 now_0)))
 (let (($x53841 (<= 0 v_0_tx_time_09)))
 (and $x53841 $x53843 (or (not (>= 9 v_0_rtx_buf)) (= 0 v_0_tx_time_09))))))
(assert
 (let (($x53840 (<= v_0_tx_time_10 now_0)))
 (let (($x53838 (<= 0 v_0_tx_time_10)))
 (and $x53838 $x53840 (or (not (>= 10 v_0_rtx_buf)) (= 0 v_0_tx_time_10))))))
(assert
 (let (($x45763 (<= v_0_tx_time_11 now_0)))
 (let (($x45761 (<= 0 v_0_tx_time_11)))
 (and $x45761 $x45763 (or (not (>= 11 v_0_rtx_buf)) (= 0 v_0_tx_time_11))))))
(assert
 (let (($x44999 (<= v_0_tx_time_12 now_0)))
 (let (($x44998 (<= 0 v_0_tx_time_12)))
 (and $x44998 $x44999 (or (not (>= 12 v_0_rtx_buf)) (= 0 v_0_tx_time_12))))))
(assert
 (let (($x41723 (<= v_0_tx_time_13 now_0)))
 (let (($x47241 (<= 0 v_0_tx_time_13)))
 (and $x47241 $x41723 (or (not (>= 13 v_0_rtx_buf)) (= 0 v_0_tx_time_13))))))
(assert
 (let (($x48761 (<= v_0_tx_time_14 now_0)))
 (let (($x48759 (<= 0 v_0_tx_time_14)))
 (and $x48759 $x48761 (or (not (>= 14 v_0_rtx_buf)) (= 0 v_0_tx_time_14))))))
(assert
 (let (($x48762 (<= v_0_tx_time_15 now_0)))
 (let (($x45001 (<= 0 v_0_tx_time_15)))
 (and $x45001 $x48762 (or (not (>= 15 v_0_rtx_buf)) (= 0 v_0_tx_time_15))))))
(assert
 (let (($x53828 (<= v_0_tx_fin_time now_0)))
 (let (($x53831 (<= 0 v_0_tx_fin_time)))
 (and $x53831 $x53828))))
(assert
 (let (($x46414 (>= 4 v_0_tx_emit_count)))
 (let (($x53827 (<= 0 v_0_tx_emit_count)))
 (and $x53827 $x46414))))
(assert
 (let (($x47301 (>= 4 v_0_tx_eligible)))
 (let (($x42144 (<= 0 v_0_tx_eligible)))
 (and $x42144 $x47301))))
(assert
 (let (($x41303 (>= 60000 v_0_tx_previous_rto)))
 (let (($x45925 (<= 1000 v_0_tx_previous_rto)))
 (let (($x49853 (<= v_0_tx_max_previous now_0)))
 (let (($x41725 (<= 0 v_0_tx_max_previous)))
 (let (($x47298 (<= 0 v_0_tx_elapsed)))
 (and $x47298 $x41725 $x49853 $x45925 $x41303)))))))
(assert
 (let (($x41310 (<= 1 v_0_tx_emit_count)))
 (let (($x41308 (>= v_0_tx_elapsed v_0_tx_previous_rto)))
 (let (($x46407 (and $x41308 $x41310 (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x1270 (not v_0_tx_retransmitted)))
 (or $x1270 $x46407))))))
(assert
 (let (($x1279 (not v_0_tx_waiting)))
 (let (($x1270 (not v_0_tx_retransmitted)))
 (or $x1270 $x1279))))
(assert
 (let (($x53823 (<= v_0_tx_syn_time now_0)))
 (let (($x45362 (<= 0 v_0_tx_syn_time)))
 (and $x45362 $x53823))))
(assert
 (not v_0_tx_syn_pending))
(assert
 (let (($x1280 (= 0 v_0_tx_syn_time)))
 (or v_0_tx_syn_pending $x1280)))
(assert
 true)
(assert
 (let (($x1297 (= 4 v_0_ack_rmss)))
 (let (($x53591 (>= 499 v_0_ack_delay_ms)))
 (let (($x42228 (<= 1 v_0_ack_delay_ms)))
 (and $x42228 $x53591 $x1297)))))
(assert
 (= v_0_ack_pending active_0_delack))
(assert
 (let (($x53806 (>= 1 v_0_ack_full_segments)))
 (let (($x53808 (<= 0 v_0_ack_full_segments)))
 (let (($x53812 (>= 7 v_0_ack_bytes)))
 (let (($x53814 (<= 0 v_0_ack_bytes)))
 (and $x53814 $x53812 $x53808 $x53806))))))
(assert
 (let (($x51296 (<= v_0_ack_since_ms now_0)))
 (let (($x51140 (<= 0 v_0_ack_since_ms)))
 (and $x51140 $x51296))))
(assert
 (let (($x1287 (not v_0_ack_pending)))
 (or $x1287 (and (<= 1 v_0_ack_bytes) (not v_0_rx_fin_done)))))
(assert
 (let (($x1288 (= 0 v_0_ack_since_ms)))
 (let (($x1290 (= 0 v_0_ack_full_segments)))
 (let (($x1289 (= 0 v_0_ack_bytes)))
 (or v_0_ack_pending (and $x1289 $x1290 $x1288))))))
(assert
 (let (($x1648 (not active_0_rtx)))
 (let (($x1849 (>= 1 v_0_rtx_buf)))
 (let (($x5344 (<= 1 (+ v_0_rtx_buf v_0_snd_buf))))
 (let (($x1176 (not v_0_fin_sent)))
 (let (($x5340 (= 0 v_0_snd_wnd)))
 (let (($x1305 (not v_0_persist_active)))
 (let ((?x10159 (ite v_0_fin_sent 1 0)))
 (let ((?x10160 (+ v_0_rtx_buf ?x10159)))
 (let (($x51312 (<= 1 ?x10160)))
 (let (($x51307 (= v_0_persist_active active_0_persist)))
 (and $x51307 (= active_0_rtx (and $x51312 $x1305)) (or $x1305 (and $x5340 $x1176 $x5344 $x1849 $x1648))))))))))))))
(assert
 (let (($x1305 (not v_0_persist_active)))
 (or $x1305 (and (not v_0_rtt_active) (= 0 v_0_rtt_remaining)))))
(assert
 (let (($x51248 (<= 0 v_0_persist_elapsed_ms)))
 (let (($x51243 (<= 0 v_0_persist_probes)))
 (let (($x51238 (>= 60000 v_0_persist_previous_interval_ms)))
 (let (($x51146 (<= 1000 v_0_persist_previous_interval_ms)))
 (let (($x53805 (>= 60000 v_0_persist_interval_ms)))
 (let (($x52886 (<= 1000 v_0_persist_interval_ms)))
 (and $x52886 $x53805 $x51146 $x51238 $x51243 $x51248))))))))
(assert
 (let (($x51258 (<= 0 v_0_persist_deadline_ms)))
 (let (($x51256 (<= v_0_persist_last_ms now_0)))
 (let (($x51254 (<= 0 v_0_persist_last_ms)))
 (let (($x51252 (<= v_0_persist_since_ms now_0)))
 (let (($x51250 (<= 0 v_0_persist_since_ms)))
 (and $x51250 $x51252 $x51254 $x51256 $x51258)))))))
(assert
 (let (($x1326 (= 0 v_0_persist_probes)))
 (let ((?x20927 (ite $x1326 v_0_persist_since_ms v_0_persist_last_ms)))
 (let (($x51261 (= v_0_persist_deadline_ms (+ ?x20927 v_0_persist_interval_ms))))
 (let (($x1305 (not v_0_persist_active)))
 (or $x1305 $x51261))))))
(assert
 (let (($x51265 (= 1 v_0_rtx_buf)))
 (let (($x51263 (>= v_0_persist_elapsed_ms v_0_persist_previous_interval_ms)))
 (let (($x1315 (not v_0_persist_probe_sent)))
 (or $x1315 (and $x51263 $x51265))))))
(assert
 (let (($x51199 (= v_0_tx_time_00 v_0_persist_last_ms)))
 (let (($x51265 (= 1 v_0_rtx_buf)))
 (let (($x51268 (<= 1 v_0_persist_probes)))
 (or (not (and v_0_persist_active $x51268 $x51265)) $x51199)))))
(assert
 (let (($x1326 (= 0 v_0_persist_probes)))
 (let (($x1323 (= 0 v_0_persist_deadline_ms)))
 (let (($x1321 (= 0 v_0_persist_last_ms)))
 (let (($x1320 (= 0 v_0_persist_since_ms)))
 (or v_0_persist_active (and $x1320 $x1321 $x1323 $x1326)))))))
(assert
 (let (($x46576 (<= 8 v_0_cc_initial_threshold)))
 (let (($x52927 (>= 16 v_0_cc_initial_window)))
 (let (($x50963 (<= 4 v_0_cc_initial_window)))
 (and $x50963 $x52927 $x46576)))))
(assert
 (let (($x53794 (<= 0 v_0_cc_threshold_updates)))
 (let (($x53797 (>= 16 v_0_cc_acked)))
 (let (($x53801 (<= 0 v_0_cc_acked)))
 (let (($x49102 (>= 4 v_0_cc_growth)))
 (let (($x50326 (<= 0 v_0_cc_growth)))
 (let (($x42427 (not (>= v_0_cc_ca_credit v_0_cc_cwnd))))
 (let (($x49751 (<= 0 v_0_cc_ca_credit)))
 (let (($x51645 (<= 8 v_0_cc_ssthresh)))
 (let (($x46523 (<= 4 v_0_cc_cwnd)))
 (and $x46523 $x51645 $x49751 $x42427 $x50326 $x49102 $x53801 $x53797 $x53794)))))))))))
(assert
 (let (($x53790 (<= v_0_cc_new_sent v_0_cc_send_budget)))
 (let (($x53796 (<= 0 v_0_cc_new_sent)))
 (and $x53796 $x53790))))
(assert
 (let (($x1847 (>= 0 v_0_rtx_buf)))
 (let (($x46031 (not $x1847)))
 (let (($x1365 (not v_0_cc_rto_00)))
 (or $x1365 $x46031)))))
(assert
 (let (($x1849 (>= 1 v_0_rtx_buf)))
 (let (($x46024 (not $x1849)))
 (let (($x1369 (not v_0_cc_rto_01)))
 (or $x1369 $x46024)))))
(assert
 (let (($x1852 (>= 2 v_0_rtx_buf)))
 (let (($x49234 (not $x1852)))
 (let (($x1371 (not v_0_cc_rto_02)))
 (or $x1371 $x49234)))))
(assert
 (let (($x1855 (>= 3 v_0_rtx_buf)))
 (let (($x48340 (not $x1855)))
 (let (($x1373 (not v_0_cc_rto_03)))
 (or $x1373 $x48340)))))
(assert
 (let (($x1857 (>= 4 v_0_rtx_buf)))
 (let (($x47154 (not $x1857)))
 (let (($x1375 (not v_0_cc_rto_04)))
 (or $x1375 $x47154)))))
(assert
 (let (($x1860 (>= 5 v_0_rtx_buf)))
 (let (($x47675 (not $x1860)))
 (let (($x1377 (not v_0_cc_rto_05)))
 (or $x1377 $x47675)))))
(assert
 (let (($x1863 (>= 6 v_0_rtx_buf)))
 (let (($x46009 (not $x1863)))
 (let (($x1379 (not v_0_cc_rto_06)))
 (or $x1379 $x46009)))))
(assert
 (let (($x1866 (>= 7 v_0_rtx_buf)))
 (let (($x42789 (not $x1866)))
 (let (($x1381 (not v_0_cc_rto_07)))
 (or $x1381 $x42789)))))
(assert
 (let (($x1868 (>= 8 v_0_rtx_buf)))
 (let (($x45683 (not $x1868)))
 (let (($x1383 (not v_0_cc_rto_08)))
 (or $x1383 $x45683)))))
(assert
 (let (($x1871 (>= 9 v_0_rtx_buf)))
 (let (($x47633 (not $x1871)))
 (let (($x1385 (not v_0_cc_rto_09)))
 (or $x1385 $x47633)))))
(assert
 (let (($x1874 (>= 10 v_0_rtx_buf)))
 (let (($x46324 (not $x1874)))
 (let (($x1387 (not v_0_cc_rto_10)))
 (or $x1387 $x46324)))))
(assert
 (let (($x1877 (>= 11 v_0_rtx_buf)))
 (let (($x45953 (not $x1877)))
 (let (($x1389 (not v_0_cc_rto_11)))
 (or $x1389 $x45953)))))
(assert
 (let (($x1880 (>= 12 v_0_rtx_buf)))
 (let (($x45919 (not $x1880)))
 (let (($x1391 (not v_0_cc_rto_12)))
 (or $x1391 $x45919)))))
(assert
 (let (($x1883 (>= 13 v_0_rtx_buf)))
 (let (($x47573 (not $x1883)))
 (let (($x1393 (not v_0_cc_rto_13)))
 (or $x1393 $x47573)))))
(assert
 (let (($x1886 (>= 14 v_0_rtx_buf)))
 (let (($x51627 (not $x1886)))
 (let (($x1395 (not v_0_cc_rto_14)))
 (or $x1395 $x51627)))))
(assert
 (let (($x1889 (>= 15 v_0_rtx_buf)))
 (let (($x45647 (not $x1889)))
 (let (($x1397 (not v_0_cc_rto_15)))
 (or $x1397 $x45647)))))
(assert
 (let (($x53769 (>= 65535 v_0_fr_last_window)))
 (let (($x53774 (<= 0 v_0_fr_last_window)))
 (let (($x53772 (>= 4 v_0_fr_emit_count)))
 (let (($x53777 (<= 0 v_0_fr_emit_count)))
 (let (($x53775 (<= 0 v_0_fr_entries)))
 (let (($x53780 (<= 0 v_0_fr_dupacks)))
 (and $x53780 $x53775 $x53777 $x53772 $x53774 $x53769))))))))
(assert
 (let (($x1305 (not v_0_persist_active)))
 (let (($x1824 (<= 1 v_0_rtx_buf)))
 (let (($x53771 (<= 3 v_0_fr_dupacks)))
 (let (($x1405 (not v_0_fr_active)))
 (or $x1405 (and $x53771 $x1824 $x1305)))))))
(assert
 (let (($x1270 (not v_0_tx_retransmitted)))
 (let (($x53754 (= v_0_retries v_0_fr_before_retries)))
 (let (($x53759 (= v_0_rto_ms v_0_fr_before_rto)))
 (let (($x53757 (= v_0_snd_nxt v_0_fr_before_nxt)))
 (let (($x53762 (<= 1 v_0_fr_emit_count)))
 (let (($x53760 (= 3 v_0_fr_dupacks)))
 (let (($x1433 (not v_0_fr_retransmitted)))
 (or $x1433 (and v_0_fr_entered $x53760 $x53762 $x53757 $x53759 $x53754 $x1270))))))))))
(assert
 (let (($x53753 (= v_0_fr_window_valid v_0_fr_before_window_valid)))
 (let (($x53751 (= v_0_fr_last_window v_0_fr_before_wire_window)))
 (let (($x1399 (not v_0_fr_window_ignored)))
 (or $x1399 (and $x53751 $x53753))))))
(assert
 (let (($x1427 (not v_0_fr_entered)))
 (or v_0_fr_retransmitted $x1427)))
(assert
 (let (($x1427 (not v_0_fr_entered)))
 (or $x1427 (= v_0_cc_cwnd (+ 12 v_0_cc_ssthresh)))))
(assert
 (let (($x1431 (not v_0_fr_exited)))
 (or $x1431 (and (= v_0_cc_cwnd v_0_cc_ssthresh) (= 0 v_0_cc_ca_credit)))))
(assert
 (let (($x53730 (<= 0 v_0_idle_restart_count)))
 (let (($x53733 (<= 0 v_0_idle_elapsed_ms)))
 (let (($x53736 (<= v_0_idle_event_ms now_0)))
 (let (($x53740 (<= v_0_idle_last_data_ms v_0_idle_event_ms)))
 (let (($x53738 (<= 0 v_0_idle_last_data_ms)))
 (and $x53738 $x53740 $x53736 $x53733 $x53730)))))))
(assert
 (let (($x53728 (= v_0_idle_last_data_ms v_0_idle_event_ms)))
 (let (($x1444 (not v_0_idle_data_emitted)))
 (or $x1444 $x53728))))
(assert
 (let (($x1337 (= 0 v_0_cc_ca_credit)))
 (let (($x53715 (= v_0_cc_ssthresh v_0_idle_before_threshold)))
 (let ((?x53723 (ite (<= v_0_cc_initial_window v_0_idle_before_cwnd) v_0_cc_initial_window v_0_idle_before_cwnd)))
 (let (($x53724 (= v_0_cc_cwnd ?x53723)))
 (let (($x53720 (not (>= v_0_idle_before_rto v_0_idle_elapsed_ms))))
 (let (($x1447 (not v_0_idle_restart)))
 (or $x1447 (and $x53720 $x53724 $x53715 $x1337)))))))))
(assert
 (let (($x53692 (<= 0 v_0_lt_loss_flight)))
 (let (($x53698 (>= v_0_lt_epoch_bytes v_0_lt_epoch_packets)))
 (let (($x53696 (<= v_0_lt_epoch_packets v_0_fr_dupacks)))
 (let (($x53705 (>= 2 v_0_lt_epoch_packets)))
 (let (($x53703 (<= 0 v_0_lt_epoch_packets)))
 (let (($x53712 (<= v_0_lt_epoch_bytes v_0_rtx_buf)))
 (let (($x53710 (>= 8 v_0_lt_epoch_bytes)))
 (let (($x53708 (<= 0 v_0_lt_epoch_bytes)))
 (and $x53708 $x53710 $x53712 $x53703 $x53705 $x53696 $x53698 (<= v_0_lt_epoch_bytes (* 4 v_0_lt_epoch_packets)) $x53692))))))))))
(assert
 (let (($x53661 (= v_0_snd_nxt (mod (+ v_0_lt_before_nxt v_0_lt_take) 4294967296))))
 (let (($x1956 (<= v_0_rtx_buf v_0_snd_wnd)))
 (let (($x53675 (= v_0_rtx_buf (+ v_0_lt_before_flight v_0_lt_take))))
 (let (($x53672 (= v_0_cc_cwnd v_0_lt_before_cwnd)))
 (let (($x53681 (>= 4 v_0_lt_take)))
 (let (($x53679 (<= 1 v_0_lt_take)))
 (let (($x1176 (not v_0_fin_sent)))
 (let (($x1405 (not v_0_fr_active)))
 (let (($x53686 (>= 2 v_0_fr_dupacks)))
 (let (($x53684 (<= 1 v_0_fr_dupacks)))
 (let (($x46566 (and v_0_fr_duplicate $x53684 $x53686 $x1405 $x1176 $x53679 $x53681 $x53672 $x53675 $x1956 (<= v_0_rtx_buf (+ 8 v_0_cc_cwnd)) $x53661)))
 (let (($x1461 (not v_0_lt_emitted)))
 (or $x1461 $x46566))))))))))))))
(assert
 (let ((?x47251 (* (- 1) v_0_lt_before_bytes)))
 (let ((?x47254 (+ v_0_fr_before_flight ?x47251)))
 (let (($x1427 (not v_0_fr_entered)))
 (or $x1427 (= v_0_lt_loss_flight ?x47254))))))
(assert
 (let (($x53651 (>= 4 v_0_choice_limit)))
 (let (($x53649 (<= 0 v_0_choice_limit)))
 (let (($x53658 (>= 4 v_0_choice_count)))
 (let (($x53656 (<= 0 v_0_choice_count)))
 (and $x53656 $x53658 $x53649 $x53651))))))
(assert
 (let (($x53626 (= v_0_rtx_buf (+ v_0_choice_before_flight v_0_choice_count))))
 (let (($x53634 (= v_0_snd_nxt (mod (+ v_0_choice_before_nxt v_0_choice_count) 4294967296))))
 (let (($x53639 (<= v_0_choice_count v_0_cc_send_budget)))
 (let (($x53637 (= v_0_cc_new_sent v_0_choice_count)))
 (let (($x53646 (= v_0_take v_0_choice_count)))
 (let (($x53644 (<= v_0_choice_count v_0_choice_limit)))
 (let (($x53642 (<= 1 v_0_choice_count)))
 (let (($x1479 (not v_0_choice_used)))
 (or $x1479 (and $x53642 $x53644 $x53646 $x53637 $x53639 $x53634 $x53626)))))))))))
(assert
 (let (($x49124 (>= 16 (+ v_0_sched_bytes v_0_snd_buf))))
 (let (($x53620 (<= v_0_sched_packets v_0_sched_bytes)))
 (let (($x53624 (<= 0 v_0_sched_packets)))
 (and $x53624 $x53620 (<= v_0_sched_bytes (* 4 v_0_sched_packets)) $x49124)))))
(assert
 (let (($x49150 (= 2 v_0_sched_cause)))
 (let (($x49132 (= 1 v_0_sched_cause)))
 (let (($x1489 (not v_0_sched_open)))
 (let (($x49130 (<= v_0_sched_at_ms now_0)))
 (let (($x49128 (<= 0 v_0_sched_at_ms)))
 (and $x49128 $x49130 (or $x1489 $x49132 $x49150))))))))
(assert
 (let (($x1479 (not v_0_choice_used)))
 (or $x1479 (and v_0_sched_open (= v_0_sched_at_ms v_0_idle_event_ms)))))
(assert
 (let ((?x46678 (+ v_0_svc_acked_bytes v_0_svc_abandoned_bytes v_0_snd_buf v_0_rtx_buf)))
 (let (($x49428 (<= 0 v_0_svc_abandoned_bytes)))
 (let (($x49426 (<= 0 v_0_svc_acked_bytes)))
 (let (($x49422 (<= 0 v_0_svc_written_bytes)))
 (and $x49422 $x49426 $x49428 (= v_0_svc_written_bytes ?x46678)))))))
(assert
 (let (($x53576 (<= 0 v_0_svc_drop_step)))
 (let (($x41898 (<= 0 v_0_svc_ack_step)))
 (let (($x53593 (<= 0 v_0_svc_accept_step)))
 (let (($x49439 (= v_0_svc_ack_step v_0_cc_acked)))
 (and $x49439 $x53593 $x41898 $x53576))))))
(assert
 (let (($x53424 (>= 1 v_0_cb_new_count)))
 (let (($x53398 (<= 0 v_0_cb_new_count)))
 (let ((?x53292 (+ v_0_cb_head v_0_cb_count)))
 (let ((?x47362 (+ (- 16) v_0_cb_head v_0_cb_count)))
 (let (($x53393 (<= 16 ?x53292)))
 (let (($x53289 (<= v_0_cb_count v_0_rtx_buf)))
 (let (($x53418 (<= 0 v_0_cb_count)))
 (let (($x53374 (not (<= 16 v_0_cb_tail))))
 (let (($x53570 (<= 0 v_0_cb_tail)))
 (let (($x53568 (not (<= 16 v_0_cb_head))))
 (let (($x53574 (<= 0 v_0_cb_head)))
 (and $x53574 $x53568 $x53570 $x53374 $x53418 $x53289 (= v_0_cb_tail (ite $x53393 ?x47362 ?x53292)) $x53398 $x53424)))))))))))))
(assert
 (let ((?x22687 (+ v_0_cb_length_00 v_0_cb_length_01 v_0_cb_length_02 v_0_cb_length_03 v_0_cb_length_04 v_0_cb_length_05 v_0_cb_length_06 v_0_cb_length_07 v_0_cb_length_08 v_0_cb_length_09 v_0_cb_length_10 v_0_cb_length_11 v_0_cb_length_12 v_0_cb_length_13 v_0_cb_length_14 v_0_cb_length_15)))
 (let (($x46710 (= v_0_cb_emitted_total (+ v_0_cb_acked_total v_0_cb_abandoned_total v_0_cb_live_total))))
 (let (($x53556 (<= 0 v_0_cb_drop_step)))
 (let (($x53479 (>= 19 v_0_cb_step_bytes)))
 (let (($x53558 (<= 0 v_0_cb_step_bytes)))
 (let (($x53478 (<= 0 v_0_cb_abandoned_total)))
 (let (($x53484 (<= v_0_cb_emitted_total v_0_svc_written_bytes)))
 (let (($x53563 (<= (+ v_0_cb_acked_total v_0_cb_partial_prefix) v_0_svc_acked_bytes)))
 (let (($x53498 (<= 0 v_0_cb_acked_total)))
 (let (($x53496 (<= 0 v_0_cb_emitted_total)))
 (and $x53496 $x53498 $x53563 $x53484 $x53478 $x53558 $x53479 $x53556 $x46710 (= v_0_cb_live_total ?x22687)))))))))))))
(assert
 (let (($x53458 (>= 3 v_0_cb_partial_prefix)))
 (let (($x53464 (<= 0 v_0_cb_partial_prefix)))
 (let ((?x22322 (* (- 1) v_0_rtx_buf)))
 (let ((?x47398 (+ v_0_cb_live_total ?x22322)))
 (and (= v_0_cb_partial_prefix ?x47398) $x53464 $x53458))))))
(assert
 (<= (+ v_0_cb_emitted_total v_0_snd_buf) v_0_svc_written_bytes))
(assert
 (let (($x53522 (= v_0_cb_end_00 (mod (+ v_0_cb_end_15 v_0_cb_length_00) 4294967296))))
 (let ((?x22430 (* (- 1) v_0_cb_head)))
 (let ((?x22433 (+ 16 ?x22430)))
 (let (($x2064 (>= 0 v_0_cb_head)))
 (let ((?x46748 (ite $x2064 ?x22430 ?x22433)))
 (let (($x46705 (>= ?x46748 v_0_cb_count)))
 (let (($x46750 (not $x46705)))
 (let ((?x46755 (mod (+ v_0_snd_una v_0_cb_length_00 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x53531 (not (>= v_0_cb_partial_prefix v_0_cb_length_00))))
 (let (($x46759 (or (not (and $x46750 (= 0 v_0_cb_head))) (and $x53531 (= v_0_cb_end_00 ?x46755)))))
 (let (($x46752 (or $x46705 (and (<= 1 v_0_cb_length_00) (>= 4 v_0_cb_length_00)))))
 (and $x46752 (or $x46750 (and (= 0 v_0_cb_length_00) (= 0 v_0_cb_end_00))) $x46759 (or (not (and $x46750 (<= 1 ?x46748))) $x53522))))))))))))))
(assert
 (let ((?x53507 (mod (+ v_0_cb_end_00 v_0_cb_length_01) 4294967296)))
 (let (($x53427 (= v_0_cb_end_01 ?x53507)))
 (let ((?x22430 (* (- 1) v_0_cb_head)))
 (let ((?x22448 (+ 17 ?x22430)))
 (let ((?x22447 (+ 1 ?x22430)))
 (let (($x2078 (>= 1 v_0_cb_head)))
 (let ((?x49806 (ite $x2078 ?x22447 ?x22448)))
 (let (($x46861 (>= ?x49806 v_0_cb_count)))
 (let (($x46862 (not $x46861)))
 (let ((?x46849 (mod (+ v_0_snd_una v_0_cb_length_01 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x53436 (not (>= v_0_cb_partial_prefix v_0_cb_length_01))))
 (let (($x46843 (or (not (and $x46862 (= 1 v_0_cb_head))) (and $x53436 (= v_0_cb_end_01 ?x46849)))))
 (let (($x46860 (or (and (<= 1 v_0_cb_length_01) (>= 4 v_0_cb_length_01)) $x46861)))
 (and $x46860 (or $x46862 (and (= 0 v_0_cb_length_01) (= 0 v_0_cb_end_01))) $x46843 (or (not (and $x46862 (<= 1 ?x49806))) $x53427))))))))))))))))
(assert
 (let ((?x48303 (mod (+ v_0_cb_end_01 v_0_cb_length_02) 4294967296)))
 (let (($x51862 (= v_0_cb_end_02 ?x48303)))
 (let ((?x22430 (* (- 1) v_0_cb_head)))
 (let ((?x22463 (+ 18 ?x22430)))
 (let ((?x22462 (+ 2 ?x22430)))
 (let (($x2091 (>= 2 v_0_cb_head)))
 (let ((?x46834 (ite $x2091 ?x22462 ?x22463)))
 (let (($x46836 (>= ?x46834 v_0_cb_count)))
 (let (($x46831 (not $x46836)))
 (let ((?x46824 (mod (+ v_0_snd_una v_0_cb_length_02 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x53491 (not (>= v_0_cb_partial_prefix v_0_cb_length_02))))
 (let (($x46818 (or (not (and $x46831 (= 2 v_0_cb_head))) (and $x53491 (= v_0_cb_end_02 ?x46824)))))
 (let (($x46828 (or (and (<= 1 v_0_cb_length_02) (>= 4 v_0_cb_length_02)) $x46836)))
 (and $x46828 (or $x46831 (and (= 0 v_0_cb_length_02) (= 0 v_0_cb_end_02))) $x46818 (or (not (and $x46831 (<= 1 ?x46834))) $x51862))))))))))))))))
(assert
 (let ((?x49809 (mod (+ v_0_cb_end_02 v_0_cb_length_03) 4294967296)))
 (let (($x49810 (= v_0_cb_end_03 ?x49809)))
 (let ((?x22430 (* (- 1) v_0_cb_head)))
 (let ((?x22478 (+ 19 ?x22430)))
 (let ((?x22475 (+ 3 ?x22430)))
 (let (($x2104 (>= 3 v_0_cb_head)))
 (let ((?x46808 (ite $x2104 ?x22475 ?x22478)))
 (let (($x46804 (>= ?x46808 v_0_cb_count)))
 (let (($x46806 (not $x46804)))
 (let ((?x46792 (mod (+ v_0_snd_una v_0_cb_length_03 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x45381 (not (>= v_0_cb_partial_prefix v_0_cb_length_03))))
 (let (($x46786 (or (not (and $x46806 (= 3 v_0_cb_head))) (and $x45381 (= v_0_cb_end_03 ?x46792)))))
 (let (($x46802 (or (and (<= 1 v_0_cb_length_03) (>= 4 v_0_cb_length_03)) $x46804)))
 (and $x46802 (or $x46806 (and (= 0 v_0_cb_length_03) (= 0 v_0_cb_end_03))) $x46786 (or (not (and $x46806 (<= 1 ?x46808))) $x49810))))))))))))))))
(assert
 (let ((?x45392 (mod (+ v_0_cb_end_03 v_0_cb_length_04) 4294967296)))
 (let (($x45393 (= v_0_cb_end_04 ?x45392)))
 (let ((?x22430 (* (- 1) v_0_cb_head)))
 (let ((?x22493 (+ 20 ?x22430)))
 (let ((?x22490 (+ 4 ?x22430)))
 (let (($x2117 (>= 4 v_0_cb_head)))
 (let ((?x46777 (ite $x2117 ?x22490 ?x22493)))
 (let (($x46778 (>= ?x46777 v_0_cb_count)))
 (let (($x46774 (not $x46778)))
 (let ((?x46745 (mod (+ v_0_snd_una v_0_cb_length_04 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x51586 (not (>= v_0_cb_partial_prefix v_0_cb_length_04))))
 (let (($x46766 (or (not (and $x46774 (= 4 v_0_cb_head))) (and $x51586 (= v_0_cb_end_04 ?x46745)))))
 (let (($x46771 (or (and (<= 1 v_0_cb_length_04) (>= 4 v_0_cb_length_04)) $x46778)))
 (and $x46771 (or $x46774 (and (= 0 v_0_cb_length_04) (= 0 v_0_cb_end_04))) $x46766 (or (not (and $x46774 (<= 1 ?x46777))) $x45393))))))))))))))))
(assert
 (let ((?x42342 (mod (+ v_0_cb_end_04 v_0_cb_length_05) 4294967296)))
 (let (($x42337 (= v_0_cb_end_05 ?x42342)))
 (let ((?x22430 (* (- 1) v_0_cb_head)))
 (let ((?x22508 (+ 21 ?x22430)))
 (let ((?x22505 (+ 5 ?x22430)))
 (let (($x2130 (>= 5 v_0_cb_head)))
 (let ((?x46693 (ite $x2130 ?x22505 ?x22508)))
 (let (($x46841 (>= ?x46693 v_0_cb_count)))
 (let (($x46691 (not $x46841)))
 (let ((?x46817 (mod (+ v_0_snd_una v_0_cb_length_05 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x42320 (not (>= v_0_cb_partial_prefix v_0_cb_length_05))))
 (let (($x46805 (or (not (and $x46691 (= 5 v_0_cb_head))) (and $x42320 (= v_0_cb_end_05 ?x46817)))))
 (let (($x46689 (or (and (<= 1 v_0_cb_length_05) (>= 4 v_0_cb_length_05)) $x46841)))
 (and $x46689 (or $x46691 (and (= 0 v_0_cb_length_05) (= 0 v_0_cb_end_05))) $x46805 (or (not (and $x46691 (<= 1 ?x46693))) $x42337))))))))))))))))
(assert
 (let ((?x42378 (mod (+ v_0_cb_end_05 v_0_cb_length_06) 4294967296)))
 (let (($x42379 (= v_0_cb_end_06 ?x42378)))
 (let ((?x22430 (* (- 1) v_0_cb_head)))
 (let ((?x22523 (+ 22 ?x22430)))
 (let ((?x22520 (+ 6 ?x22430)))
 (let (($x2143 (>= 6 v_0_cb_head)))
 (let ((?x46793 (ite $x2143 ?x22520 ?x22523)))
 (let (($x46675 (>= ?x46793 v_0_cb_count)))
 (let (($x42807 (not $x46675)))
 (let ((?x47271 (mod (+ v_0_snd_una v_0_cb_length_06 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x42363 (not (>= v_0_cb_partial_prefix v_0_cb_length_06))))
 (let (($x44851 (or (not (and $x42807 (= 6 v_0_cb_head))) (and $x42363 (= v_0_cb_end_06 ?x47271)))))
 (let (($x51053 (or (and (<= 1 v_0_cb_length_06) (>= 4 v_0_cb_length_06)) $x46675)))
 (and $x51053 (or $x42807 (and (= 0 v_0_cb_length_06) (= 0 v_0_cb_end_06))) $x44851 (or (not (and $x42807 (<= 1 ?x46793))) $x42379))))))))))))))))
(assert
 (let ((?x42412 (mod (+ v_0_cb_end_06 v_0_cb_length_07) 4294967296)))
 (let (($x42416 (= v_0_cb_end_07 ?x42412)))
 (let ((?x22430 (* (- 1) v_0_cb_head)))
 (let ((?x22538 (+ 23 ?x22430)))
 (let ((?x22535 (+ 7 ?x22430)))
 (let (($x2156 (>= 7 v_0_cb_head)))
 (let ((?x44947 (ite $x2156 ?x22535 ?x22538)))
 (let (($x42937 (>= ?x44947 v_0_cb_count)))
 (let (($x42938 (not $x42937)))
 (let ((?x44945 (mod (+ v_0_snd_una v_0_cb_length_07 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x42399 (not (>= v_0_cb_partial_prefix v_0_cb_length_07))))
 (let (($x47698 (or (not (and $x42938 (= 7 v_0_cb_head))) (and $x42399 (= v_0_cb_end_07 ?x44945)))))
 (let (($x42936 (or $x42937 (and (<= 1 v_0_cb_length_07) (>= 4 v_0_cb_length_07)))))
 (and $x42936 (or $x42938 (and (= 0 v_0_cb_length_07) (= 0 v_0_cb_end_07))) $x47698 (or (not (and $x42938 (<= 1 ?x44947))) $x42416))))))))))))))))
(assert
 (let ((?x42450 (mod (+ v_0_cb_end_07 v_0_cb_length_08) 4294967296)))
 (let (($x50756 (= v_0_cb_end_08 ?x42450)))
 (let ((?x22430 (* (- 1) v_0_cb_head)))
 (let ((?x22553 (+ 24 ?x22430)))
 (let ((?x22550 (+ 8 ?x22430)))
 (let (($x2169 (>= 8 v_0_cb_head)))
 (let ((?x47924 (ite $x2169 ?x22550 ?x22553)))
 (let (($x47925 (>= ?x47924 v_0_cb_count)))
 (let (($x42736 (not $x47925)))
 (let ((?x49716 (mod (+ v_0_snd_una v_0_cb_length_08 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x42604 (not (>= v_0_cb_partial_prefix v_0_cb_length_08))))
 (let (($x42515 (or (not (and $x42736 (= 8 v_0_cb_head))) (and $x42604 (= v_0_cb_end_08 ?x49716)))))
 (let (($x49966 (or (and (<= 1 v_0_cb_length_08) (>= 4 v_0_cb_length_08)) $x47925)))
 (and $x49966 (or $x42736 (and (= 0 v_0_cb_length_08) (= 0 v_0_cb_end_08))) $x42515 (or (not (and $x42736 (<= 1 ?x47924))) $x50756))))))))))))))))
(assert
 (let ((?x43345 (mod (+ v_0_cb_end_08 v_0_cb_length_09) 4294967296)))
 (let (($x43346 (= v_0_cb_end_09 ?x43345)))
 (let ((?x22430 (* (- 1) v_0_cb_head)))
 (let ((?x22568 (+ 25 ?x22430)))
 (let ((?x22565 (+ 9 ?x22430)))
 (let (($x2182 (>= 9 v_0_cb_head)))
 (let ((?x41361 (ite $x2182 ?x22565 ?x22568)))
 (let (($x45022 (>= ?x41361 v_0_cb_count)))
 (let (($x41359 (not $x45022)))
 (let ((?x47411 (mod (+ v_0_snd_una v_0_cb_length_09 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x47622 (not (>= v_0_cb_partial_prefix v_0_cb_length_09))))
 (let (($x51052 (or (not (and $x41359 (= 9 v_0_cb_head))) (and $x47622 (= v_0_cb_end_09 ?x47411)))))
 (let (($x47826 (or $x45022 (and (<= 1 v_0_cb_length_09) (>= 4 v_0_cb_length_09)))))
 (and $x47826 (or $x41359 (and (= 0 v_0_cb_length_09) (= 0 v_0_cb_end_09))) $x51052 (or (not (and $x41359 (<= 1 ?x41361))) $x43346))))))))))))))))
(assert
 (let ((?x53381 (mod (+ v_0_cb_end_09 v_0_cb_length_10) 4294967296)))
 (let (($x53382 (= v_0_cb_end_10 ?x53381)))
 (let ((?x22430 (* (- 1) v_0_cb_head)))
 (let ((?x22583 (+ 26 ?x22430)))
 (let ((?x22580 (+ 10 ?x22430)))
 (let (($x2195 (>= 10 v_0_cb_head)))
 (let ((?x51054 (ite $x2195 ?x22580 ?x22583)))
 (let (($x50841 (>= ?x51054 v_0_cb_count)))
 (let (($x47863 (not $x50841)))
 (let ((?x50813 (mod (+ v_0_snd_una v_0_cb_length_10 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x53400 (not (>= v_0_cb_partial_prefix v_0_cb_length_10))))
 (let (($x46669 (or (not (and $x47863 (= 10 v_0_cb_head))) (and $x53400 (= v_0_cb_end_10 ?x50813)))))
 (let (($x46673 (or (and (<= 1 v_0_cb_length_10) (>= 4 v_0_cb_length_10)) $x50841)))
 (and $x46673 (or $x47863 (and (= 0 v_0_cb_length_10) (= 0 v_0_cb_end_10))) $x46669 (or (not (and $x47863 (<= 1 ?x51054))) $x53382))))))))))))))))
(assert
 (let ((?x44687 (mod (+ v_0_cb_end_10 v_0_cb_length_11) 4294967296)))
 (let (($x44688 (= v_0_cb_end_11 ?x44687)))
 (let ((?x22430 (* (- 1) v_0_cb_head)))
 (let ((?x22598 (+ 27 ?x22430)))
 (let ((?x22595 (+ 11 ?x22430)))
 (let (($x2208 (>= 11 v_0_cb_head)))
 (let ((?x46657 (ite $x2208 ?x22595 ?x22598)))
 (let (($x46525 (>= ?x46657 v_0_cb_count)))
 (let (($x50953 (not $x46525)))
 (let ((?x50107 (mod (+ v_0_snd_una v_0_cb_length_11 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x44676 (not (>= v_0_cb_partial_prefix v_0_cb_length_11))))
 (let (($x46671 (or (not (and $x50953 (= 11 v_0_cb_head))) (and $x44676 (= v_0_cb_end_11 ?x50107)))))
 (let (($x50811 (or $x46525 (and (<= 1 v_0_cb_length_11) (>= 4 v_0_cb_length_11)))))
 (and $x50811 (or $x50953 (and (= 0 v_0_cb_length_11) (= 0 v_0_cb_end_11))) $x46671 (or (not (and $x50953 (<= 1 ?x46657))) $x44688))))))))))))))))
(assert
 (let ((?x53348 (mod (+ v_0_cb_end_11 v_0_cb_length_12) 4294967296)))
 (let (($x53349 (= v_0_cb_end_12 ?x53348)))
 (let ((?x22430 (* (- 1) v_0_cb_head)))
 (let ((?x22613 (+ 28 ?x22430)))
 (let ((?x22610 (+ 12 ?x22430)))
 (let (($x2221 (>= 12 v_0_cb_head)))
 (let ((?x47994 (ite $x2221 ?x22610 ?x22613)))
 (let (($x46658 (>= ?x47994 v_0_cb_count)))
 (let (($x48059 (not $x46658)))
 (let ((?x53818 (mod (+ v_0_snd_una v_0_cb_length_12 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x53360 (not (>= v_0_cb_partial_prefix v_0_cb_length_12))))
 (let (($x47736 (or (not (and $x48059 (= 12 v_0_cb_head))) (and $x53360 (= v_0_cb_end_12 ?x53818)))))
 (let (($x47157 (or $x46658 (and (<= 1 v_0_cb_length_12) (>= 4 v_0_cb_length_12)))))
 (and $x47157 (or $x48059 (and (= 0 v_0_cb_length_12) (= 0 v_0_cb_end_12))) $x47736 (or (not (and $x48059 (<= 1 ?x47994))) $x53349))))))))))))))))
(assert
 (let ((?x53314 (mod (+ v_0_cb_end_12 v_0_cb_length_13) 4294967296)))
 (let (($x53315 (= v_0_cb_end_13 ?x53314)))
 (let ((?x22430 (* (- 1) v_0_cb_head)))
 (let ((?x22628 (+ 29 ?x22430)))
 (let ((?x22625 (+ 13 ?x22430)))
 (let (($x2234 (>= 13 v_0_cb_head)))
 (let ((?x46185 (ite $x2234 ?x22625 ?x22628)))
 (let (($x41848 (>= ?x46185 v_0_cb_count)))
 (let (($x53270 (not $x41848)))
 (let ((?x41484 (mod (+ v_0_snd_una v_0_cb_length_13 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x53326 (not (>= v_0_cb_partial_prefix v_0_cb_length_13))))
 (let (($x50418 (or (not (and $x53270 (= 13 v_0_cb_head))) (and $x53326 (= v_0_cb_end_13 ?x41484)))))
 (let (($x42636 (or $x41848 (and (<= 1 v_0_cb_length_13) (>= 4 v_0_cb_length_13)))))
 (and $x42636 (or $x53270 (and (= 0 v_0_cb_length_13) (= 0 v_0_cb_end_13))) $x50418 (or (not (and $x53270 (<= 1 ?x46185))) $x53315))))))))))))))))
(assert
 (let ((?x53277 (mod (+ v_0_cb_end_13 v_0_cb_length_14) 4294967296)))
 (let (($x53276 (= v_0_cb_end_14 ?x53277)))
 (let ((?x22430 (* (- 1) v_0_cb_head)))
 (let ((?x22643 (+ 30 ?x22430)))
 (let ((?x22640 (+ 14 ?x22430)))
 (let (($x2247 (>= 14 v_0_cb_head)))
 (let ((?x50106 (ite $x2247 ?x22640 ?x22643)))
 (let (($x50113 (>= ?x50106 v_0_cb_count)))
 (let (($x47171 (not $x50113)))
 (let ((?x50114 (mod (+ v_0_snd_una v_0_cb_length_14 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x53301 (not (>= v_0_cb_partial_prefix v_0_cb_length_14))))
 (let (($x50122 (or (not (and $x47171 (= 14 v_0_cb_head))) (and $x53301 (= v_0_cb_end_14 ?x50114)))))
 (let (($x49154 (or $x50113 (and (<= 1 v_0_cb_length_14) (>= 4 v_0_cb_length_14)))))
 (and $x49154 (or $x47171 (and (= 0 v_0_cb_length_14) (= 0 v_0_cb_end_14))) $x50122 (or (not (and $x47171 (<= 1 ?x50106))) $x53276))))))))))))))))
(assert
 (let ((?x42786 (mod (+ v_0_cb_end_14 v_0_cb_length_15) 4294967296)))
 (let (($x41402 (= v_0_cb_end_15 ?x42786)))
 (let ((?x22430 (* (- 1) v_0_cb_head)))
 (let ((?x22658 (+ 31 ?x22430)))
 (let ((?x22655 (+ 15 ?x22430)))
 (let (($x2260 (>= 15 v_0_cb_head)))
 (let ((?x50400 (ite $x2260 ?x22655 ?x22658)))
 (let (($x50133 (>= ?x50400 v_0_cb_count)))
 (let (($x50129 (not $x50133)))
 (let ((?x50137 (mod (+ v_0_snd_una v_0_cb_length_15 (* (- 1) v_0_cb_partial_prefix)) 4294967296)))
 (let (($x41377 (not (>= v_0_cb_partial_prefix v_0_cb_length_15))))
 (let (($x50141 (or (not (and $x50129 (= 15 v_0_cb_head))) (and $x41377 (= v_0_cb_end_15 ?x50137)))))
 (let (($x50127 (or (and (<= 1 v_0_cb_length_15) (>= 4 v_0_cb_length_15)) $x50133)))
 (and $x50127 (or $x50129 (and (= 0 v_0_cb_length_15) (= 0 v_0_cb_end_15))) $x50141 (or (not (and $x50129 (<= 1 ?x50400))) $x41402))))))))))))))))
(assert
 (let (($x36699 (= 4 v_0_nagle_first_bytes)))
 (let (($x1645 (not v_0_nagle_before_disabled)))
 (let (($x36696 (<= 1 v_0_nagle_before_flight)))
 (let (($x36694 (<= 1 v_0_nagle_first_bytes)))
 (or (not (and $x36694 $x36696 $x1645)) $x36699))))))
(assert
 (let ((?x23094 (* (- 1) v_0_rtt_start_ms)))
 (let ((?x37024 (+ now_1 ?x23094)))
 (let (($x1209 (not v_0_rtt_ambiguous)))
 (let ((?x23056 (* (- 1) v_0_snd_una)))
 (let ((?x37021 (+ v_0_rtt_end ?x23056)))
 (let ((?x65586 (mod ?x37021 4294967296)))
 (let ((?x39372 (+ input_0_net.fin_segment_ack ?x23056)))
 (let ((?x42555 (mod ?x39372 4294967296)))
 (let ((?x10159 (ite v_0_fin_sent 1 0)))
 (let ((?x10160 (+ v_0_rtx_buf ?x10159)))
 (let (($x52053 (<= ?x42555 ?x10160)))
 (let (($x45334 (<= 1 ?x42555)))
 (let ((?x29092 (+ (- 1) v_0_local_window)))
 (let (($x65729 (<= (mod (+ input_0_net.fin_segment_seq (* (- 1) v_0_rcv_nxt)) 4294967296) ?x29092)))
 (let (($x7333 (<= 1 v_0_local_window)))
 (let ((?x993 (* (- 1) v_0_rcv_nxt)))
 (let ((?x46592 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data ?x993) 4294967296)))
 (let (($x63935 (<= ?x46592 ?x29092)))
 (let (($x54205 (or (and $x7333 $x63935) (and $x7333 $x65729))))
 (let (($x50524 (and v_0_rtt_active $x54205 $x45334 $x52053 (>= ?x42555 ?x65586) $x1209)))
 (let ((?x45485 (to_real (ite $x50524 ?x37024 v_0_rtt_last_ms))))
 (let ((?x50234 (+ v_0_srtt_ms (* (- 1.0) ?x45485))))
 (let ((?x66136 (ite $x50524 (ite (>= ?x50234 0.0) ?x50234 (+ (* (- 1.0) v_0_srtt_ms) ?x45485)) v_0_rtt_error_ms)))
 (let ((?x23103 (* (/ 3.0 4.0) v_0_rttvar_ms)))
 (let ((?x55422 (ite $x50524 (ite v_0_rtt_measured (+ ?x23103 (* (/ 1.0 4.0) ?x66136)) (* (/ 1.0 2.0) ?x45485)) v_0_rttvar_ms)))
 (let ((?x45587 (ite v_0_rtt_measured (+ (* (/ 7.0 8.0) v_0_srtt_ms) (* (/ 1.0 8.0) ?x45485)) ?x45485)))
 (let ((?x54831 (+ (* (- 1.0) (ite $x50524 ?x45587 v_0_srtt_ms)) (* (- 1.0) (ite (<= ?x55422 (/ 1.0 4.0)) 1.0 (* 4.0 ?x55422))))))
 (let ((?x41204 (to_int ?x54831)))
 (let ((?x57145 (ite (<= ?x41204 (- 1000)) (* (- 1) ?x41204) 1000)))
 (let ((?x58146 (ite $x50524 (ite (<= 60000 ?x57145) 60000 ?x57145) v_0_rto_ms)))
 (let (($x57338 (<= ?x58146 0)))
 (let (($x61673 (and (not (and $x54205 $x45334 $x52053 v_0_fin_sent (= ?x42555 ?x10160))) v_0_fin_sent)))
 (let (($x37325 (<= 0 v_0_rtx_buf)))
 (let ((?x61181 (ite $x37325 v_0_rtx_buf 0)))
 (let ((?x46936 (ite (<= v_0_rtx_buf ?x42555) 0 (+ v_0_rtx_buf (* (- 1) ?x42555)))))
 (let ((?x42949 (ite (and $x54205 $x45334 $x52053) (ite (<= ?x46936 ?x61181) ?x46936 ?x61181) v_0_rtx_buf)))
 (let ((?x62053 (+ ?x42949 (ite $x61673 1 0))))
 (let (($x57243 (<= 1 ?x62053)))
 (let (($x61581 (or (and (not (and $x54205 $x45334 $x52053 (= 0 ?x62053))) active_0_rtx) (and $x54205 $x45334 $x52053 $x57243))))
 (let (($x64612 (= ?x42555 ?x10160)))
 (let (($x1182 (not v_0_rx_fin_pending)))
 (let (($x1187 (not v_0_rx_fin_done)))
 (let (($x64863 (not (and (>= ?x42555 (+ 1 v_0_rtx_buf ?x10159)) (>= 2147483647 ?x42555)))))
 (let (($x54548 (and $x54205 $x64863 $x1187 $x1182 $x7333 $x63935)))
 (let ((?x58103 (ite $x54548 ?x46592 v_0_rx_fin_offset)))
 (let ((?x31912 (mod (+ 15 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31916 (+ input_0_net.fin_segment_data (* (- 1) ?x31912))))
 (let (($x64253 (<= input_0_net.fin_segment_data ?x31912)))
 (let (($x26502 (<= v_0_rcv_buf 0)))
 (let (($x1153 (= 0 v_0_rx_slot_15)))
 (let (($x50856 (and $x54205 $x64863 $x1187 $x1153 $x26502 (<= ?x31912 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x66196 (ite $x50856 (ite (or $x64253 (<= ?x31916 1)) (ite $x64253 0 ?x31916) 1) v_0_rx_slot_15)))
 (let (($x50360 (or (= ?x66196 0) (and (or v_0_rx_fin_pending $x54548) (>= 15 ?x58103)))))
 (let ((?x31886 (mod (+ 14 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31890 (+ input_0_net.fin_segment_data (* (- 1) ?x31886))))
 (let (($x50903 (<= input_0_net.fin_segment_data ?x31886)))
 (let (($x26446 (<= v_0_rcv_buf 1)))
 (let (($x1151 (= 0 v_0_rx_slot_14)))
 (let (($x61443 (and $x54205 $x64863 $x1187 $x1151 $x26446 (<= ?x31886 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x55823 (ite $x61443 (ite (or $x50903 (<= ?x31890 1)) (ite $x50903 0 ?x31890) 1) v_0_rx_slot_14)))
 (let (($x45115 (or (= ?x55823 0) (and (or v_0_rx_fin_pending $x54548) (>= 14 ?x58103)))))
 (let ((?x31866 (mod (+ 13 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31870 (+ input_0_net.fin_segment_data (* (- 1) ?x31866))))
 (let (($x47050 (<= input_0_net.fin_segment_data ?x31866)))
 (let (($x26392 (<= v_0_rcv_buf 2)))
 (let (($x1149 (= 0 v_0_rx_slot_13)))
 (let (($x54661 (and $x54205 $x64863 $x1187 $x1149 $x26392 (<= ?x31866 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x61267 (ite $x54661 (ite (or $x47050 (<= ?x31870 1)) (ite $x47050 0 ?x31870) 1) v_0_rx_slot_13)))
 (let (($x57442 (or (= ?x61267 0) (and (or v_0_rx_fin_pending $x54548) (>= 13 ?x58103)))))
 (let ((?x31839 (mod (+ 12 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31843 (+ input_0_net.fin_segment_data (* (- 1) ?x31839))))
 (let (($x46477 (<= input_0_net.fin_segment_data ?x31839)))
 (let (($x29577 (<= v_0_rcv_buf 3)))
 (let (($x1147 (= 0 v_0_rx_slot_12)))
 (let (($x65321 (and $x54205 $x64863 $x1187 $x1147 $x29577 (<= ?x31839 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x59166 (ite $x65321 (ite (or $x46477 (<= ?x31843 1)) (ite $x46477 0 ?x31843) 1) v_0_rx_slot_12)))
 (let (($x54522 (or (= ?x59166 0) (and (or v_0_rx_fin_pending $x54548) (>= 12 ?x58103)))))
 (let ((?x62931 (ite $x54522 12 (ite $x57442 13 (ite $x45115 14 (ite $x50360 15 16))))))
 (let ((?x31813 (mod (+ 11 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31817 (+ input_0_net.fin_segment_data (* (- 1) ?x31813))))
 (let (($x61566 (<= input_0_net.fin_segment_data ?x31813)))
 (let (($x29541 (<= v_0_rcv_buf 4)))
 (let (($x1145 (= 0 v_0_rx_slot_11)))
 (let (($x65450 (and $x54205 $x64863 $x1187 $x1145 $x29541 (<= ?x31813 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x65250 (ite $x65450 (ite (or $x61566 (<= ?x31817 1)) (ite $x61566 0 ?x31817) 1) v_0_rx_slot_11)))
 (let (($x57919 (or (= ?x65250 0) (and (or v_0_rx_fin_pending $x54548) (>= 11 ?x58103)))))
 (let ((?x31793 (mod (+ 10 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31797 (+ input_0_net.fin_segment_data (* (- 1) ?x31793))))
 (let (($x57205 (<= input_0_net.fin_segment_data ?x31793)))
 (let (($x29505 (<= v_0_rcv_buf 5)))
 (let (($x1143 (= 0 v_0_rx_slot_10)))
 (let (($x58661 (and $x54205 $x64863 $x1187 $x1143 $x29505 (<= ?x31793 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x55428 (ite $x58661 (ite (or $x57205 (<= ?x31797 1)) (ite $x57205 0 ?x31797) 1) v_0_rx_slot_10)))
 (let (($x43313 (or (= ?x55428 0) (and (or v_0_rx_fin_pending $x54548) (>= 10 ?x58103)))))
 (let ((?x31768 (mod (+ 9 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31772 (+ input_0_net.fin_segment_data (* (- 1) ?x31768))))
 (let (($x60758 (<= input_0_net.fin_segment_data ?x31768)))
 (let (($x29469 (<= v_0_rcv_buf 6)))
 (let (($x1141 (= 0 v_0_rx_slot_09)))
 (let (($x64005 (and $x54205 $x64863 $x1187 $x1141 $x29469 (<= ?x31768 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x58633 (ite $x64005 (ite (or $x60758 (<= ?x31772 1)) (ite $x60758 0 ?x31772) 1) v_0_rx_slot_09)))
 (let (($x63558 (or (= ?x58633 0) (and (or v_0_rx_fin_pending $x54548) (>= 9 ?x58103)))))
 (let ((?x31740 (mod (+ 8 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31744 (+ input_0_net.fin_segment_data (* (- 1) ?x31740))))
 (let (($x48799 (<= input_0_net.fin_segment_data ?x31740)))
 (let (($x29433 (<= v_0_rcv_buf 7)))
 (let (($x1139 (= 0 v_0_rx_slot_08)))
 (let (($x54709 (and $x54205 $x64863 $x1187 $x1139 $x29433 (<= ?x31740 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x57204 (ite $x54709 (ite (or $x48799 (<= ?x31744 1)) (ite $x48799 0 ?x31744) 1) v_0_rx_slot_08)))
 (let (($x55829 (or (= ?x57204 0) (and (or v_0_rx_fin_pending $x54548) (>= 8 ?x58103)))))
 (let ((?x50375 (ite $x55829 8 (ite $x63558 9 (ite $x43313 10 (ite $x57919 11 ?x62931))))))
 (let ((?x31709 (mod (+ 7 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31713 (+ input_0_net.fin_segment_data (* (- 1) ?x31709))))
 (let (($x45970 (<= input_0_net.fin_segment_data ?x31709)))
 (let (($x29397 (<= v_0_rcv_buf 8)))
 (let (($x1137 (= 0 v_0_rx_slot_07)))
 (let (($x46069 (and $x54205 $x64863 $x1187 $x1137 $x29397 (<= ?x31709 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x55990 (ite $x46069 (ite (or $x45970 (<= ?x31713 1)) (ite $x45970 0 ?x31713) 1) v_0_rx_slot_07)))
 (let (($x41970 (or (= ?x55990 0) (and (or v_0_rx_fin_pending $x54548) (>= 7 ?x58103)))))
 (let ((?x31682 (mod (+ 6 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31686 (+ input_0_net.fin_segment_data (* (- 1) ?x31682))))
 (let (($x42196 (<= input_0_net.fin_segment_data ?x31682)))
 (let (($x29361 (<= v_0_rcv_buf 9)))
 (let (($x1135 (= 0 v_0_rx_slot_06)))
 (let (($x50270 (and $x54205 $x64863 $x1187 $x1135 $x29361 (<= ?x31682 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x50875 (ite $x50270 (ite (or $x42196 (<= ?x31686 1)) (ite $x42196 0 ?x31686) 1) v_0_rx_slot_06)))
 (let (($x54985 (or (= ?x50875 0) (and (or v_0_rx_fin_pending $x54548) (>= 6 ?x58103)))))
 (let ((?x31651 (mod (+ 5 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31655 (+ input_0_net.fin_segment_data (* (- 1) ?x31651))))
 (let (($x44702 (<= input_0_net.fin_segment_data ?x31651)))
 (let (($x29325 (<= v_0_rcv_buf 10)))
 (let (($x1133 (= 0 v_0_rx_slot_05)))
 (let (($x63576 (and $x54205 $x64863 $x1187 $x1133 $x29325 (<= ?x31651 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x66585 (ite $x63576 (ite (or $x44702 (<= ?x31655 1)) (ite $x44702 0 ?x31655) 1) v_0_rx_slot_05)))
 (let (($x50422 (or (= ?x66585 0) (and (or v_0_rx_fin_pending $x54548) (>= 5 ?x58103)))))
 (let ((?x31619 (mod (+ 4 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31623 (+ input_0_net.fin_segment_data (* (- 1) ?x31619))))
 (let (($x57501 (<= input_0_net.fin_segment_data ?x31619)))
 (let (($x29289 (<= v_0_rcv_buf 11)))
 (let (($x1131 (= 0 v_0_rx_slot_04)))
 (let (($x65683 (and $x54205 $x64863 $x1187 $x1131 $x29289 (<= ?x31619 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x54154 (ite $x65683 (ite (or $x57501 (<= ?x31623 1)) (ite $x57501 0 ?x31623) 1) v_0_rx_slot_04)))
 (let (($x49620 (or (= ?x54154 0) (and (or v_0_rx_fin_pending $x54548) (>= 4 ?x58103)))))
 (let ((?x58185 (ite $x49620 4 (ite $x50422 5 (ite $x54985 6 (ite $x41970 7 ?x50375))))))
 (let ((?x31586 (mod (+ 3 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31590 (+ input_0_net.fin_segment_data (* (- 1) ?x31586))))
 (let (($x55073 (<= input_0_net.fin_segment_data ?x31586)))
 (let (($x29253 (<= v_0_rcv_buf 12)))
 (let (($x1129 (= 0 v_0_rx_slot_03)))
 (let (($x62320 (and $x54205 $x64863 $x1187 $x1129 $x29253 (<= ?x31586 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x44204 (ite $x62320 (ite (or $x55073 (<= ?x31590 1)) (ite $x55073 0 ?x31590) 1) v_0_rx_slot_03)))
 (let (($x57512 (or (= ?x44204 0) (and (or v_0_rx_fin_pending $x54548) (>= 3 ?x58103)))))
 (let ((?x31553 (mod (+ 2 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31557 (+ input_0_net.fin_segment_data (* (- 1) ?x31553))))
 (let (($x62068 (<= input_0_net.fin_segment_data ?x31553)))
 (let (($x29218 (<= v_0_rcv_buf 13)))
 (let (($x1127 (= 0 v_0_rx_slot_02)))
 (let (($x61328 (and $x54205 $x64863 $x1187 $x1127 $x29218 (<= ?x31553 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x62170 (ite $x61328 (ite (or $x62068 (<= ?x31557 1)) (ite $x62068 0 ?x31557) 1) v_0_rx_slot_02)))
 (let (($x54602 (or (= ?x62170 0) (and (or v_0_rx_fin_pending $x54548) (>= 2 ?x58103)))))
 (let ((?x31520 (mod (+ 1 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31524 (+ input_0_net.fin_segment_data (* (- 1) ?x31520))))
 (let (($x58551 (<= input_0_net.fin_segment_data ?x31520)))
 (let (($x29182 (<= v_0_rcv_buf 14)))
 (let (($x1125 (= 0 v_0_rx_slot_01)))
 (let (($x55433 (and $x54205 $x64863 $x1187 $x1125 $x29182 (<= ?x31520 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x57808 (ite $x55433 (ite (or $x58551 (<= ?x31524 1)) (ite $x58551 0 ?x31524) 1) v_0_rx_slot_01)))
 (let (($x62785 (or (= ?x57808 0) (and (or v_0_rx_fin_pending $x54548) (>= 1 ?x58103)))))
 (let ((?x31424 (* (- 1) input_0_net.fin_segment_seq)))
 (let ((?x31425 (+ v_0_rcv_nxt ?x31424)))
 (let ((?x31426 (mod ?x31425 4294967296)))
 (let ((?x31491 (+ input_0_net.fin_segment_data (* (- 1) ?x31426))))
 (let (($x66559 (<= input_0_net.fin_segment_data ?x31426)))
 (let (($x29147 (<= v_0_rcv_buf 15)))
 (let (($x1123 (= 0 v_0_rx_slot_00)))
 (let (($x45139 (and $x54205 $x64863 $x1187 $x1123 $x29147 (<= ?x31426 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x45717 (ite $x45139 (ite (or $x66559 (<= ?x31491 1)) (ite $x66559 0 ?x31491) 1) v_0_rx_slot_00)))
 (let (($x43940 (or (= ?x45717 0) (and (or v_0_rx_fin_pending $x54548) (>= 0 ?x58103)))))
 (let ((?x59666 (ite $x43940 0 (ite $x62785 1 (ite $x54602 2 (ite $x57512 3 ?x58185))))))
 (let (($x46008 (or v_0_rx_fin_pending $x54548)))
 (let (($x60598 (and $x46008 $x1187 (= 0 (ite $x46008 (+ ?x58103 (* (- 1) ?x59666)) ?x58103)) $x54205 $x45334 $x52053 v_0_fin_sent $x64612)))
 (let (($x47320 (or v_0_persist_active (= 0 ?x42949))))
 (let (($x58215 (>= 1 ?x42949)))
 (let (($x49055 (<= 1 (+ ?x42949 v_0_snd_buf))))
 (let (($x65102 (not $x61673)))
 (let ((?x23951 (* (- 1) v_0_snd_wl1)))
 (let ((?x39608 (+ input_0_net.fin_segment_seq ?x23951)))
 (let ((?x62526 (mod ?x39608 4294967296)))
 (let (($x53410 (<= 2147483648 (mod (+ input_0_net.fin_segment_ack (* (- 1) v_0_snd_wl2)) 4294967296))))
 (let (($x15593 (= v_0_snd_wl1 input_0_net.fin_segment_seq)))
 (let (($x55400 (or (and $x15593 (not $x53410)) (and (not (<= ?x62526 0)) (not (<= 2147483648 ?x62526))))))
 (let (($x52917 (= 0 (ite (and $x54205 $x52053 $x55400) input_0_net.fin_segment_window v_0_snd_wnd))))
 (let (($x60457 (not (and $x52917 $x65102 $x49055 $x58215 $x47320))))
 (let (($x36883 (not (<= due_0_persist now_1))))
 (let (($x1658 (not active_0_persist)))
 (let (($x41837 (or $x1658 $x36883)))
 (let (($x36881 (not (<= due_0_delack now_1))))
 (let (($x1656 (not active_0_delack)))
 (let (($x46991 (or $x1656 $x36881)))
 (let (($x36879 (not (<= due_0_time_wait now_1))))
 (let (($x1654 (not active_0_time_wait)))
 (let (($x54779 (or $x1654 $x36879)))
 (let (($x36877 (not (<= due_0_user now_1))))
 (let (($x1652 (not active_0_user)))
 (let (($x46543 (or $x1652 $x36877)))
 (let (($x36875 (not (<= due_0_rtx now_1))))
 (let (($x1648 (not active_0_rtx)))
 (let (($x54693 (or $x1648 $x36875)))
 (let ((?x33815 (+ v_0_snd_nxt ?x23056)))
 (let ((?x55468 (mod ?x33815 4294967296)))
 (let (($x51530 (<= ?x42555 ?x55468)))
 (let (($x1176 (not v_0_fin_sent)))
 (let (($x56359 (= (mod (+ input_0_net.fin_segment_ack (* (- 1) v_0_snd_nxt)) 4294967296) 2147483648)))
 (let (($x65011 (or (not $x54205) (and (not (= ?x42555 2147483648)) (not $x56359)))))
 (let (($x15546 (>= 65535 input_0_net.fin_segment_window)))
 (let (($x15544 (<= 0 input_0_net.fin_segment_window)))
 (let (($x31428 (not (= ?x31426 2147483648))))
 (let (($x15537 (>= 16 input_0_net.fin_segment_data)))
 (let (($x15535 (<= 0 input_0_net.fin_segment_data)))
 (let (($x1773 (>= now_1 now_0)))
 (let (($x50854 (and $x1773 $x15535 $x15537 $x31428 $x15544 $x15546 $x65011 $x1176 $x45334 $x51530 $x54693 $x46543 $x54779 $x46991 $x41837 v_0_persist_active $x60457 (<= 1 ?x42949) (not (and $x60457 (not $x60598) $x61581)) $x57338)))
 (let (($x48150 (and $x1773 $x15535 $x15537 $x31428 $x15544 $x15546 $x65011 $x1176 $x45334 $x51530 $x54693 $x46543 $x54779 $x46991 $x41837 $x54205 $x52053 $x57243 $x57338)))
 (let ((?x63114 (ite (and $x52917 $x65102 $x49055 $x58215 $x47320 (not v_0_persist_active)) ?x58146 v_0_persist_interval_ms)))
 (let (($x1305 (not v_0_persist_active)))
 (let (($x44412 (and $x1773 $x15535 $x15537 $x31428 $x15544 $x15546 $x65011 $x1176 $x45334 $x51530 $x54693 $x46543 $x54779 $x46991 $x41837 $x52917 $x65102 $x49055 $x58215 $x47320 $x1305 (<= ?x63114 0))))
 (let (($x52588 (= 4 v_1_nagle_first_bytes)))
 (let (($x52576 (not v_1_nagle_before_disabled)))
 (let (($x52564 (<= 1 v_1_nagle_before_flight)))
 (let (($x52703 (<= 1 v_1_nagle_first_bytes)))
 (let (($x42888 (and (or (not (and $x52703 $x52564 $x52576)) $x52588) (or (not active_1_rtx) (>= due_1_rtx now_1)) (or (not active_1_user) (>= due_1_user now_1)) (or (not active_1_time_wait) (>= due_1_time_wait now_1)) (or (not active_1_delack) (>= due_1_delack now_1)) (or (not active_1_persist) (>= due_1_persist now_1)))))
 (or (not $x42888) $x44412 $x48150 $x50854))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 (= 175 choice_0))
(assert
 (= 5 state_0))
(assert
 (= 10 state_1))
(check-sat)
