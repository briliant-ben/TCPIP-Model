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
(declare-fun v_0_cb_emitted_total () Int)
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
(declare-fun v_1_svc_written_bytes () Int)
(declare-fun v_1_cb_emitted_total () Int)
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
 (let ((?x53353 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x53353)))
(assert
 (let (($x1098 (= 0 v_0_snd_buf)))
 (let ((?x53675 (mod (+ v_0_snd_una v_0_rtx_buf) 4294967296)))
 (let (($x53677 (= v_0_fin_seq ?x53675)))
 (let (($x1168 (not v_0_fin_sent)))
 (or $x1168 (and v_0_fin_requested $x53677 $x1098)))))))
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
 (let (($x53744 (<= 1 v_0_rx_fin_offset)))
 (let (($x1179 (not v_0_rx_fin_done)))
 (let (($x1174 (not v_0_rx_fin_pending)))
 (or $x1174 (and $x1179 $x53744 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window))))))))
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
 (let ((?x22975 (* (- 1) v_0_snd_una)))
 (let ((?x33620 (+ v_0_snd_nxt ?x22975)))
 (let ((?x63399 (mod ?x33620 4294967296)))
 (let ((?x36906 (+ v_0_rtt_end ?x22975)))
 (let ((?x52672 (mod ?x36906 4294967296)))
 (let (($x53777 (>= 4 v_0_rtt_remaining)))
 (let (($x53779 (<= 1 v_0_rtt_remaining)))
 (let (($x53703 (<= v_0_rtt_start_ms now_0)))
 (let (($x1199 (not v_0_rtt_active)))
 (or $x1199 (and $x53703 $x53779 $x53777 (>= ?x52672 v_0_rtt_remaining) (<= ?x52672 ?x63399)))))))))))))
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
 (let (($x1279 (not v_0_ack_pending)))
 (or $x1279 (and (<= 1 v_0_ack_bytes) (not v_0_rx_fin_done)))))
(assert
 (let (($x1280 (= 0 v_0_ack_since_ms)))
 (let (($x1282 (= 0 v_0_ack_full_segments)))
 (let (($x1281 (= 0 v_0_ack_bytes)))
 (or v_0_ack_pending (and $x1281 $x1282 $x1280))))))
(assert
 (let (($x1634 (not active_0_rtx)))
 (let (($x1832 (>= 1 v_0_rtx_buf)))
 (let (($x5318 (<= 1 (+ v_0_rtx_buf v_0_snd_buf))))
 (let (($x1168 (not v_0_fin_sent)))
 (let (($x5314 (= 0 v_0_snd_wnd)))
 (let (($x1297 (not v_0_persist_active)))
 (let ((?x10123 (ite v_0_fin_sent 1 0)))
 (let ((?x10124 (+ v_0_rtx_buf ?x10123)))
 (let (($x53684 (<= 1 ?x10124)))
 (let (($x41328 (= v_0_persist_active active_0_persist)))
 (and $x41328 (= active_0_rtx (and $x53684 $x1297)) (or $x1297 (and $x5314 $x1168 $x5318 $x1832 $x1634))))))))))))))
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
 (let (($x1297 (not v_0_persist_active)))
 (let (($x1807 (<= 1 v_0_rtx_buf)))
 (let (($x51465 (<= 3 v_0_fr_dupacks)))
 (let (($x1397 (not v_0_fr_active)))
 (or $x1397 (and $x51465 $x1807 $x1297)))))))
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
 (let ((?x23013 (* (- 1) v_0_rtt_start_ms)))
 (let ((?x36911 (+ now_1 ?x23013)))
 (let (($x1201 (not v_0_rtt_ambiguous)))
 (let ((?x22975 (* (- 1) v_0_snd_una)))
 (let ((?x36906 (+ v_0_rtt_end ?x22975)))
 (let ((?x52672 (mod ?x36906 4294967296)))
 (let ((?x39254 (+ input_0_net.fin_segment_ack ?x22975)))
 (let ((?x50337 (mod ?x39254 4294967296)))
 (let ((?x10123 (ite v_0_fin_sent 1 0)))
 (let ((?x10124 (+ v_0_rtx_buf ?x10123)))
 (let (($x49501 (<= ?x50337 ?x10124)))
 (let (($x50404 (<= 1 ?x50337)))
 (let ((?x28969 (+ (- 1) v_0_local_window)))
 (let (($x55596 (<= (mod (+ input_0_net.fin_segment_seq (* (- 1) v_0_rcv_nxt)) 4294967296) ?x28969)))
 (let (($x7305 (<= 1 v_0_local_window)))
 (let ((?x756 (* (- 1) v_0_rcv_nxt)))
 (let ((?x60113 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data ?x756) 4294967296)))
 (let (($x55109 (<= ?x60113 ?x28969)))
 (let (($x58039 (or (and $x7305 $x55109) (and $x7305 $x55596))))
 (let (($x46427 (and v_0_rtt_active $x58039 $x50404 $x49501 (>= ?x50337 ?x52672) $x1201)))
 (let ((?x43806 (to_real (ite $x46427 ?x36911 v_0_rtt_last_ms))))
 (let ((?x50259 (+ v_0_srtt_ms (* (- 1.0) ?x43806))))
 (let ((?x53137 (ite $x46427 (ite (>= ?x50259 0.0) ?x50259 (+ (* (- 1.0) v_0_srtt_ms) ?x43806)) v_0_rtt_error_ms)))
 (let ((?x23022 (* (/ 3.0 4.0) v_0_rttvar_ms)))
 (let ((?x56424 (ite $x46427 (ite v_0_rtt_measured (+ ?x23022 (* (/ 1.0 4.0) ?x53137)) (* (/ 1.0 2.0) ?x43806)) v_0_rttvar_ms)))
 (let ((?x43565 (ite v_0_rtt_measured (+ (* (/ 7.0 8.0) v_0_srtt_ms) (* (/ 1.0 8.0) ?x43806)) ?x43806)))
 (let ((?x57714 (+ (* (- 1.0) (ite $x46427 ?x43565 v_0_srtt_ms)) (* (- 1.0) (ite (<= ?x56424 (/ 1.0 4.0)) 1.0 (* 4.0 ?x56424))))))
 (let ((?x59914 (to_int ?x57714)))
 (let ((?x60267 (ite (<= ?x59914 (- 1000)) (* (- 1) ?x59914) 1000)))
 (let ((?x46933 (ite $x46427 (ite (<= 60000 ?x60267) 60000 ?x60267) v_0_rto_ms)))
 (let (($x46581 (<= ?x46933 0)))
 (let (($x63780 (and (not (and $x58039 $x50404 $x49501 v_0_fin_sent (= ?x50337 ?x10124))) v_0_fin_sent)))
 (let (($x37212 (<= 0 v_0_rtx_buf)))
 (let ((?x54097 (ite $x37212 v_0_rtx_buf 0)))
 (let ((?x63355 (ite (<= v_0_rtx_buf ?x50337) 0 (+ v_0_rtx_buf (* (- 1) ?x50337)))))
 (let ((?x46756 (ite (and $x58039 $x50404 $x49501) (ite (<= ?x63355 ?x54097) ?x63355 ?x54097) v_0_rtx_buf)))
 (let ((?x42713 (+ ?x46756 (ite $x63780 1 0))))
 (let (($x59290 (or (and $x58039 $x50404 $x49501 (<= 1 ?x42713)) (and (not (and $x58039 $x50404 $x49501 (= 0 ?x42713))) active_0_rtx))))
 (let (($x62412 (= ?x50337 ?x10124)))
 (let (($x1174 (not v_0_rx_fin_pending)))
 (let (($x1179 (not v_0_rx_fin_done)))
 (let (($x60402 (not (and (>= ?x50337 (+ 1 v_0_rtx_buf ?x10123)) (>= 2147483647 ?x50337)))))
 (let (($x62568 (and $x58039 $x60402 $x1179 $x1174 $x7305 $x55109)))
 (let ((?x55284 (ite $x62568 ?x60113 v_0_rx_fin_offset)))
 (let ((?x31794 (mod (+ 15 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31798 (+ input_0_net.fin_segment_data (* (- 1) ?x31794))))
 (let (($x41950 (<= input_0_net.fin_segment_data ?x31794)))
 (let (($x29551 (<= v_0_rcv_buf 0)))
 (let (($x1145 (= 0 v_0_rx_slot_15)))
 (let (($x54670 (and $x58039 $x60402 $x1179 $x1145 $x29551 (<= ?x31794 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x49609 (ite $x54670 (ite (or $x41950 (<= ?x31798 1)) (ite $x41950 0 ?x31798) 1) v_0_rx_slot_15)))
 (let (($x46596 (or (= ?x49609 0) (and (or v_0_rx_fin_pending $x62568) (>= 15 ?x55284)))))
 (let ((?x31767 (mod (+ 14 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31771 (+ input_0_net.fin_segment_data (* (- 1) ?x31767))))
 (let (($x60055 (<= input_0_net.fin_segment_data ?x31767)))
 (let (($x29516 (<= v_0_rcv_buf 1)))
 (let (($x1143 (= 0 v_0_rx_slot_14)))
 (let (($x57256 (and $x58039 $x60402 $x1179 $x1143 $x29516 (<= ?x31767 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x45542 (ite $x57256 (ite (or $x60055 (<= ?x31771 1)) (ite $x60055 0 ?x31771) 1) v_0_rx_slot_14)))
 (let (($x41515 (or (= ?x45542 0) (and (or v_0_rx_fin_pending $x62568) (>= 14 ?x55284)))))
 (let ((?x31741 (mod (+ 13 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31745 (+ input_0_net.fin_segment_data (* (- 1) ?x31741))))
 (let (($x51168 (<= input_0_net.fin_segment_data ?x31741)))
 (let (($x26354 (<= v_0_rcv_buf 2)))
 (let (($x1141 (= 0 v_0_rx_slot_13)))
 (let (($x43999 (and $x58039 $x60402 $x1179 $x1141 $x26354 (<= ?x31741 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x41624 (ite $x43999 (ite (or $x51168 (<= ?x31745 1)) (ite $x51168 0 ?x31745) 1) v_0_rx_slot_13)))
 (let (($x58404 (or (= ?x41624 0) (and (or v_0_rx_fin_pending $x62568) (>= 13 ?x55284)))))
 (let ((?x31721 (mod (+ 12 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31725 (+ input_0_net.fin_segment_data (* (- 1) ?x31721))))
 (let (($x46572 (<= input_0_net.fin_segment_data ?x31721)))
 (let (($x29454 (<= v_0_rcv_buf 3)))
 (let (($x1139 (= 0 v_0_rx_slot_12)))
 (let (($x63414 (and $x58039 $x60402 $x1179 $x1139 $x29454 (<= ?x31721 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x55955 (ite $x63414 (ite (or $x46572 (<= ?x31725 1)) (ite $x46572 0 ?x31725) 1) v_0_rx_slot_12)))
 (let (($x43023 (or (= ?x55955 0) (and (or v_0_rx_fin_pending $x62568) (>= 12 ?x55284)))))
 (let ((?x50687 (ite $x43023 12 (ite $x58404 13 (ite $x41515 14 (ite $x46596 15 16))))))
 (let ((?x31694 (mod (+ 11 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31698 (+ input_0_net.fin_segment_data (* (- 1) ?x31694))))
 (let (($x50729 (<= input_0_net.fin_segment_data ?x31694)))
 (let (($x29418 (<= v_0_rcv_buf 4)))
 (let (($x1137 (= 0 v_0_rx_slot_11)))
 (let (($x41697 (and $x58039 $x60402 $x1179 $x1137 $x29418 (<= ?x31694 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x46036 (ite $x41697 (ite (or $x50729 (<= ?x31698 1)) (ite $x50729 0 ?x31698) 1) v_0_rx_slot_11)))
 (let (($x55904 (or (= ?x46036 0) (and (or v_0_rx_fin_pending $x62568) (>= 11 ?x55284)))))
 (let ((?x31668 (mod (+ 10 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31672 (+ input_0_net.fin_segment_data (* (- 1) ?x31668))))
 (let (($x57808 (<= input_0_net.fin_segment_data ?x31668)))
 (let (($x29382 (<= v_0_rcv_buf 5)))
 (let (($x1135 (= 0 v_0_rx_slot_10)))
 (let (($x49079 (and $x58039 $x60402 $x1179 $x1135 $x29382 (<= ?x31668 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x63531 (ite $x49079 (ite (or $x57808 (<= ?x31672 1)) (ite $x57808 0 ?x31672) 1) v_0_rx_slot_10)))
 (let (($x47670 (or (= ?x63531 0) (and (or v_0_rx_fin_pending $x62568) (>= 10 ?x55284)))))
 (let ((?x31648 (mod (+ 9 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31652 (+ input_0_net.fin_segment_data (* (- 1) ?x31648))))
 (let (($x60008 (<= input_0_net.fin_segment_data ?x31648)))
 (let (($x29346 (<= v_0_rcv_buf 6)))
 (let (($x1133 (= 0 v_0_rx_slot_09)))
 (let (($x54781 (and $x58039 $x60402 $x1179 $x1133 $x29346 (<= ?x31648 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x59973 (ite $x54781 (ite (or $x60008 (<= ?x31652 1)) (ite $x60008 0 ?x31652) 1) v_0_rx_slot_09)))
 (let (($x62097 (or (= ?x59973 0) (and (or v_0_rx_fin_pending $x62568) (>= 9 ?x55284)))))
 (let ((?x31621 (mod (+ 8 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31625 (+ input_0_net.fin_segment_data (* (- 1) ?x31621))))
 (let (($x46387 (<= input_0_net.fin_segment_data ?x31621)))
 (let (($x29311 (<= v_0_rcv_buf 7)))
 (let (($x1131 (= 0 v_0_rx_slot_08)))
 (let (($x44157 (and $x58039 $x60402 $x1179 $x1131 $x29311 (<= ?x31621 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x49025 (ite $x44157 (ite (or $x46387 (<= ?x31625 1)) (ite $x46387 0 ?x31625) 1) v_0_rx_slot_08)))
 (let (($x41851 (or (= ?x49025 0) (and (or v_0_rx_fin_pending $x62568) (>= 8 ?x55284)))))
 (let ((?x43412 (ite $x41851 8 (ite $x62097 9 (ite $x47670 10 (ite $x55904 11 ?x50687))))))
 (let ((?x31595 (mod (+ 7 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31599 (+ input_0_net.fin_segment_data (* (- 1) ?x31595))))
 (let (($x49047 (<= input_0_net.fin_segment_data ?x31595)))
 (let (($x29275 (<= v_0_rcv_buf 8)))
 (let (($x1129 (= 0 v_0_rx_slot_07)))
 (let (($x48853 (and $x58039 $x60402 $x1179 $x1129 $x29275 (<= ?x31595 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x54627 (ite $x48853 (ite (or $x49047 (<= ?x31599 1)) (ite $x49047 0 ?x31599) 1) v_0_rx_slot_07)))
 (let (($x44294 (or (= ?x54627 0) (and (or v_0_rx_fin_pending $x62568) (>= 7 ?x55284)))))
 (let ((?x31574 (mod (+ 6 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31578 (+ input_0_net.fin_segment_data (* (- 1) ?x31574))))
 (let (($x43910 (<= input_0_net.fin_segment_data ?x31574)))
 (let (($x29238 (<= v_0_rcv_buf 9)))
 (let (($x1127 (= 0 v_0_rx_slot_06)))
 (let (($x57429 (and $x58039 $x60402 $x1179 $x1127 $x29238 (<= ?x31574 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x41799 (ite $x57429 (ite (or $x43910 (<= ?x31578 1)) (ite $x43910 0 ?x31578) 1) v_0_rx_slot_06)))
 (let (($x49471 (or (= ?x41799 0) (and (or v_0_rx_fin_pending $x62568) (>= 6 ?x55284)))))
 (let ((?x31543 (mod (+ 5 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31547 (+ input_0_net.fin_segment_data (* (- 1) ?x31543))))
 (let (($x52049 (<= input_0_net.fin_segment_data ?x31543)))
 (let (($x29202 (<= v_0_rcv_buf 10)))
 (let (($x1125 (= 0 v_0_rx_slot_05)))
 (let (($x43157 (and $x58039 $x60402 $x1179 $x1125 $x29202 (<= ?x31543 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x48085 (ite $x43157 (ite (or $x52049 (<= ?x31547 1)) (ite $x52049 0 ?x31547) 1) v_0_rx_slot_05)))
 (let (($x63359 (or (= ?x48085 0) (and (or v_0_rx_fin_pending $x62568) (>= 5 ?x55284)))))
 (let ((?x31514 (mod (+ 4 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31518 (+ input_0_net.fin_segment_data (* (- 1) ?x31514))))
 (let (($x52722 (<= input_0_net.fin_segment_data ?x31514)))
 (let (($x29166 (<= v_0_rcv_buf 11)))
 (let (($x1123 (= 0 v_0_rx_slot_04)))
 (let (($x55937 (and $x58039 $x60402 $x1179 $x1123 $x29166 (<= ?x31514 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x53901 (ite $x55937 (ite (or $x52722 (<= ?x31518 1)) (ite $x52722 0 ?x31518) 1) v_0_rx_slot_04)))
 (let (($x43195 (or (= ?x53901 0) (and (or v_0_rx_fin_pending $x62568) (>= 4 ?x55284)))))
 (let ((?x55491 (ite $x43195 4 (ite $x63359 5 (ite $x49471 6 (ite $x44294 7 ?x43412))))))
 (let ((?x31486 (mod (+ 3 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31490 (+ input_0_net.fin_segment_data (* (- 1) ?x31486))))
 (let (($x43358 (<= input_0_net.fin_segment_data ?x31486)))
 (let (($x29130 (<= v_0_rcv_buf 12)))
 (let (($x1121 (= 0 v_0_rx_slot_03)))
 (let (($x58731 (and $x58039 $x60402 $x1179 $x1121 $x29130 (<= ?x31486 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x59512 (ite $x58731 (ite (or $x43358 (<= ?x31490 1)) (ite $x43358 0 ?x31490) 1) v_0_rx_slot_03)))
 (let (($x48109 (or (= ?x59512 0) (and (or v_0_rx_fin_pending $x62568) (>= 3 ?x55284)))))
 (let ((?x31454 (mod (+ 2 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31458 (+ input_0_net.fin_segment_data (* (- 1) ?x31454))))
 (let (($x58825 (<= input_0_net.fin_segment_data ?x31454)))
 (let (($x29095 (<= v_0_rcv_buf 13)))
 (let (($x1119 (= 0 v_0_rx_slot_02)))
 (let (($x64179 (and $x58039 $x60402 $x1179 $x1119 $x29095 (<= ?x31454 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x41116 (ite $x64179 (ite (or $x58825 (<= ?x31458 1)) (ite $x58825 0 ?x31458) 1) v_0_rx_slot_02)))
 (let (($x51650 (or (= ?x41116 0) (and (or v_0_rx_fin_pending $x62568) (>= 2 ?x55284)))))
 (let ((?x31421 (mod (+ 1 v_0_rcv_nxt (* (- 1) input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x31425 (+ input_0_net.fin_segment_data (* (- 1) ?x31421))))
 (let (($x46057 (<= input_0_net.fin_segment_data ?x31421)))
 (let (($x29059 (<= v_0_rcv_buf 14)))
 (let (($x1117 (= 0 v_0_rx_slot_01)))
 (let (($x50690 (and $x58039 $x60402 $x1179 $x1117 $x29059 (<= ?x31421 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x55879 (ite $x50690 (ite (or $x46057 (<= ?x31425 1)) (ite $x46057 0 ?x31425) 1) v_0_rx_slot_01)))
 (let (($x44493 (or (= ?x55879 0) (and (or v_0_rx_fin_pending $x62568) (>= 1 ?x55284)))))
 (let ((?x31325 (* (- 1) input_0_net.fin_segment_seq)))
 (let ((?x31326 (+ v_0_rcv_nxt ?x31325)))
 (let ((?x31327 (mod ?x31326 4294967296)))
 (let ((?x31392 (+ input_0_net.fin_segment_data (* (- 1) ?x31327))))
 (let (($x60747 (<= input_0_net.fin_segment_data ?x31327)))
 (let (($x29024 (<= v_0_rcv_buf 15)))
 (let (($x1115 (= 0 v_0_rx_slot_00)))
 (let (($x49855 (and $x58039 $x60402 $x1179 $x1115 $x29024 (<= ?x31327 (+ (- 1) input_0_net.fin_segment_data)))))
 (let ((?x52438 (ite $x49855 (ite (or $x60747 (<= ?x31392 1)) (ite $x60747 0 ?x31392) 1) v_0_rx_slot_00)))
 (let (($x43472 (or (= ?x52438 0) (and (or v_0_rx_fin_pending $x62568) (>= 0 ?x55284)))))
 (let ((?x47186 (ite $x43472 0 (ite $x44493 1 (ite $x51650 2 (ite $x48109 3 ?x55491))))))
 (let (($x46500 (or v_0_rx_fin_pending $x62568)))
 (let (($x57026 (and $x46500 $x1179 (= 0 (ite $x46500 (+ ?x55284 (* (- 1) ?x47186)) ?x55284)) $x58039 $x50404 $x49501 v_0_fin_sent $x62412)))
 (let (($x43470 (or v_0_persist_active (= 0 ?x46756))))
 (let (($x58367 (>= 1 ?x46756)))
 (let (($x59883 (<= 1 (+ ?x46756 v_0_snd_buf))))
 (let (($x46251 (not $x63780)))
 (let (($x56107 (<= 2147483648 (mod (+ input_0_net.fin_segment_ack (* (- 1) v_0_snd_wl2)) 4294967296))))
 (let (($x15540 (= v_0_snd_wl1 input_0_net.fin_segment_seq)))
 (let ((?x23945 (* (- 1) v_0_snd_wl1)))
 (let ((?x39490 (+ input_0_net.fin_segment_seq ?x23945)))
 (let ((?x45943 (mod ?x39490 4294967296)))
 (let (($x49741 (or (and (not (<= ?x45943 0)) (not (<= 2147483648 ?x45943))) (and $x15540 (not $x56107)))))
 (let (($x41652 (= 0 (ite (and $x58039 $x49501 $x49741) input_0_net.fin_segment_window v_0_snd_wnd))))
 (let (($x52456 (not (and $x41652 $x46251 $x59883 $x58367 $x43470))))
 (let (($x36770 (not (<= due_0_persist now_1))))
 (let (($x1642 (not active_0_persist)))
 (let (($x41403 (or $x1642 $x36770)))
 (let (($x36768 (not (<= due_0_delack now_1))))
 (let (($x1640 (not active_0_delack)))
 (let (($x46442 (or $x1640 $x36768)))
 (let (($x36766 (not (<= due_0_time_wait now_1))))
 (let (($x1638 (not active_0_time_wait)))
 (let (($x54022 (or $x1638 $x36766)))
 (let (($x36764 (not (<= due_0_user now_1))))
 (let (($x1636 (not active_0_user)))
 (let (($x61242 (or $x1636 $x36764)))
 (let (($x36762 (not (<= due_0_rtx now_1))))
 (let (($x1634 (not active_0_rtx)))
 (let (($x50787 (or $x1634 $x36762)))
 (let (($x50507 (or (= 0 ?x50337) (and $x50404 (<= ?x50337 (mod (+ v_0_snd_nxt ?x22975) 4294967296))))))
 (let (($x51900 (not $x50507)))
 (let (($x1168 (not v_0_fin_sent)))
 (let (($x61460 (= (mod (+ input_0_net.fin_segment_ack (* (- 1) v_0_snd_nxt)) 4294967296) 2147483648)))
 (let (($x54901 (or (and (not (= ?x50337 2147483648)) (not $x61460)) (not $x58039))))
 (let (($x15493 (>= 65535 input_0_net.fin_segment_window)))
 (let (($x15491 (<= 0 input_0_net.fin_segment_window)))
 (let (($x31329 (not (= ?x31327 2147483648))))
 (let (($x15484 (>= 16 input_0_net.fin_segment_data)))
 (let (($x15482 (<= 0 input_0_net.fin_segment_data)))
 (let (($x1756 (>= now_1 now_0)))
 (let (($x56789 (and $x1756 $x15482 $x15484 $x31329 $x15491 $x15493 $x54901 $x1168 $x51900 $x50787 $x61242 $x54022 $x46442 $x41403 v_0_persist_active $x52456 (<= 1 ?x46756) (not (and $x52456 (not $x57026) $x59290)) $x46581)))
 (let (($x45272 (<= (+ v_1_cb_emitted_total v_1_snd_buf) v_1_svc_written_bytes)))
 (let (($x49740 (and $x45272 (or (not active_1_rtx) (>= due_1_rtx now_1)) (or (not active_1_user) (>= due_1_user now_1)) (or (not active_1_time_wait) (>= due_1_time_wait now_1)) (or (not active_1_delack) (>= due_1_delack now_1)) (or (not active_1_persist) (>= due_1_persist now_1)))))
 (let ((?x48948 (ite (and $x41652 $x46251 $x59883 $x58367 $x43470 (not v_0_persist_active)) ?x46933 v_0_persist_interval_ms)))
 (let (($x1297 (not v_0_persist_active)))
 (let (($x47303 (and $x1756 $x15482 $x15484 $x31329 $x15491 $x15493 $x54901 $x1168 $x51900 $x50787 $x61242 $x54022 $x46442 $x41403 $x41652 $x46251 $x59883 $x58367 $x43470 $x1297 (<= ?x48948 0))))
 (let (($x59649 (<= 1 ?x42713)))
 (let (($x46451 (and $x1756 $x15482 $x15484 $x31329 $x15491 $x15493 $x54901 $x1168 $x51900 $x50787 $x61242 $x54022 $x46442 $x41403 $x58039 $x50404 $x49501 $x59649 $x46581)))
 (or $x46451 $x47303 (not $x49740) $x56789))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 (= 176 choice_0))
(assert
 (= 5 state_0))
(assert
 (= 6 state_1))
(check-sat)
