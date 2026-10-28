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
(declare-fun v_0_persist_interval_ms () Int)
(declare-fun v_0_rto_ms () Int)
(declare-fun v_0_rttvar_ms () Real)
(declare-fun v_0_rtt_last_ms () Int)
(declare-fun v_0_rtt_start_ms () Int)
(declare-fun now_1 () Int)
(declare-fun v_0_rtt_ambiguous () Bool)
(declare-fun v_0_fin_sent () Bool)
(declare-fun v_0_local_window () Int)
(declare-fun v_0_rtt_active () Bool)
(declare-fun v_0_rtt_error_ms () Real)
(declare-fun v_0_srtt_ms () Real)
(declare-fun v_0_rtt_measured () Bool)
(declare-fun v_0_persist_active () Bool)
(declare-fun v_0_snd_wnd () Int)
(declare-fun input_0_net.ack_window () Int)
(declare-fun due_1_persist () Int)
(declare-fun due_1_delack () Int)
(declare-fun due_1_time_wait () Int)
(declare-fun due_1_user () Int)
(declare-fun due_1_rtx () Int)
(declare-fun active_1_persist () Bool)
(declare-fun v_0_fr_dupacks () Int)
(declare-fun v_0_fr_last_window () Int)
(declare-fun v_0_fr_window_valid () Bool)
(declare-fun v_0_fr_active () Bool)
(declare-fun v_0_idle_last_data_ms () Int)
(declare-fun v_0_cc_cwnd () Int)
(declare-fun v_0_cc_ca_credit () Int)
(declare-fun v_0_cc_ssthresh () Int)
(declare-fun v_0_lt_epoch_bytes () Int)
(declare-fun active_1_delack () Bool)
(declare-fun active_1_time_wait () Bool)
(declare-fun active_1_user () Bool)
(declare-fun active_1_rtx () Bool)
(declare-fun v_1_lt_loss_flight () Int)
(declare-fun v_1_lt_before_window () Int)
(declare-fun v_1_lt_before_flight () Int)
(declare-fun v_1_lt_before_cwnd () Int)
(declare-fun v_1_lt_before_bytes () Int)
(declare-fun v_0_lt_epoch_packets () Int)
(declare-fun v_1_lt_epoch_packets () Int)
(declare-fun v_1_lt_epoch_bytes () Int)
(declare-fun v_1_lt_take () Int)
(declare-fun v_1_lt_emitted () Bool)
(declare-fun v_1_lt_eligible () Bool)
(declare-fun v_0_idle_restart_count () Int)
(declare-fun v_1_idle_restart_count () Int)
(declare-fun v_1_idle_before_threshold () Int)
(declare-fun v_1_idle_before_rto () Int)
(declare-fun v_1_idle_before_cwnd () Int)
(declare-fun v_0_idle_data_valid () Bool)
(declare-fun v_1_idle_elapsed_ms () Int)
(declare-fun v_1_idle_restart () Bool)
(declare-fun v_0_take () Int)
(declare-fun v_1_idle_data_emitted () Bool)
(declare-fun v_1_idle_event_ms () Int)
(declare-fun v_1_idle_last_data_ms () Int)
(declare-fun v_1_idle_data_valid () Bool)
(declare-fun v_0_fr_entries () Int)
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
(declare-fun v_1_fr_was_active () Bool)
(declare-fun v_1_fr_last_window () Int)
(declare-fun v_1_fr_window_valid () Bool)
(declare-fun v_1_fr_dupacks () Int)
(declare-fun v_1_fr_active () Bool)
(declare-fun v_1_fr_before_window_valid () Bool)
(declare-fun v_1_fr_before_wire_window () Int)
(declare-fun v_1_fr_window_ignored () Bool)
(declare-fun v_0_cc_rto_15 () Bool)
(declare-fun v_1_cc_rto_15 () Bool)
(declare-fun v_0_cc_rto_14 () Bool)
(declare-fun v_1_cc_rto_14 () Bool)
(declare-fun v_0_cc_rto_13 () Bool)
(declare-fun v_1_cc_rto_13 () Bool)
(declare-fun v_0_cc_rto_12 () Bool)
(declare-fun v_1_cc_rto_12 () Bool)
(declare-fun v_0_cc_rto_11 () Bool)
(declare-fun v_1_cc_rto_11 () Bool)
(declare-fun v_0_cc_rto_10 () Bool)
(declare-fun v_1_cc_rto_10 () Bool)
(declare-fun v_0_cc_rto_09 () Bool)
(declare-fun v_1_cc_rto_09 () Bool)
(declare-fun v_0_cc_rto_08 () Bool)
(declare-fun v_1_cc_rto_08 () Bool)
(declare-fun v_0_cc_rto_07 () Bool)
(declare-fun v_1_cc_rto_07 () Bool)
(declare-fun v_0_cc_rto_06 () Bool)
(declare-fun v_1_cc_rto_06 () Bool)
(declare-fun v_0_cc_rto_05 () Bool)
(declare-fun v_1_cc_rto_05 () Bool)
(declare-fun v_0_cc_rto_04 () Bool)
(declare-fun v_1_cc_rto_04 () Bool)
(declare-fun v_0_cc_rto_03 () Bool)
(declare-fun v_1_cc_rto_03 () Bool)
(declare-fun v_0_cc_rto_02 () Bool)
(declare-fun v_1_cc_rto_02 () Bool)
(declare-fun v_0_cc_rto_01 () Bool)
(declare-fun v_1_cc_rto_01 () Bool)
(declare-fun v_0_cc_rto_00 () Bool)
(declare-fun v_1_cc_rto_00 () Bool)
(declare-fun v_1_cc_new_sent () Int)
(declare-fun v_1_cc_send_budget () Int)
(declare-fun v_1_cc_before_cwnd () Int)
(declare-fun v_1_cc_growth () Int)
(declare-fun v_0_cc_threshold_updates () Int)
(declare-fun v_1_cc_threshold_updates () Int)
(declare-fun v_1_cc_threshold_changed () Bool)
(declare-fun v_1_cc_loss () Bool)
(declare-fun v_1_cc_before_window () Int)
(declare-fun v_1_cc_before_persist () Bool)
(declare-fun v_1_cc_before_flight () Int)
(declare-fun v_1_cc_acked () Int)
(declare-fun v_1_cc_ca_credit () Int)
(declare-fun v_1_cc_ssthresh () Int)
(declare-fun v_1_cc_cwnd () Int)
(declare-fun v_0_cc_initial_threshold () Int)
(declare-fun v_1_cc_initial_threshold () Int)
(declare-fun v_0_cc_initial_window () Int)
(declare-fun v_1_cc_initial_window () Int)
(declare-fun v_0_persist_elapsed_ms () Int)
(declare-fun v_1_persist_elapsed_ms () Int)
(declare-fun v_0_persist_probes () Int)
(declare-fun v_1_persist_probes () Int)
(declare-fun v_0_persist_deadline_ms () Int)
(declare-fun v_1_persist_deadline_ms () Int)
(declare-fun v_0_persist_last_ms () Int)
(declare-fun v_1_persist_last_ms () Int)
(declare-fun v_0_persist_since_ms () Int)
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
(declare-fun v_0_ack_full_segments () Int)
(declare-fun v_1_ack_full_segments () Int)
(declare-fun v_0_ack_bytes () Int)
(declare-fun v_1_ack_bytes () Int)
(declare-fun v_0_ack_since_ms () Int)
(declare-fun v_1_ack_since_ms () Int)
(declare-fun v_0_ack_pending () Bool)
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
(declare-fun v_0_tx_fin_time () Int)
(declare-fun v_1_tx_fin_time () Int)
(declare-fun v_0_tx_time_15 () Int)
(declare-fun v_1_tx_time_15 () Int)
(declare-fun v_0_tx_time_14 () Int)
(declare-fun v_1_tx_time_14 () Int)
(declare-fun v_0_tx_time_13 () Int)
(declare-fun v_1_tx_time_13 () Int)
(declare-fun v_0_tx_time_12 () Int)
(declare-fun v_1_tx_time_12 () Int)
(declare-fun v_0_tx_time_11 () Int)
(declare-fun v_1_tx_time_11 () Int)
(declare-fun v_0_tx_time_10 () Int)
(declare-fun v_1_tx_time_10 () Int)
(declare-fun v_0_tx_time_09 () Int)
(declare-fun v_1_tx_time_09 () Int)
(declare-fun v_0_tx_time_08 () Int)
(declare-fun v_1_tx_time_08 () Int)
(declare-fun v_0_tx_time_07 () Int)
(declare-fun v_1_tx_time_07 () Int)
(declare-fun v_0_tx_time_06 () Int)
(declare-fun v_1_tx_time_06 () Int)
(declare-fun v_0_tx_time_05 () Int)
(declare-fun v_1_tx_time_05 () Int)
(declare-fun v_0_tx_time_04 () Int)
(declare-fun v_1_tx_time_04 () Int)
(declare-fun v_0_tx_time_03 () Int)
(declare-fun v_1_tx_time_03 () Int)
(declare-fun v_0_tx_time_02 () Int)
(declare-fun v_1_tx_time_02 () Int)
(declare-fun v_0_tx_time_01 () Int)
(declare-fun v_1_tx_time_01 () Int)
(declare-fun v_0_tx_time_00 () Int)
(declare-fun v_1_tx_time_00 () Int)
(declare-fun v_0_rto_base_ms () Int)
(declare-fun v_1_rto_base_ms () Int)
(declare-fun v_0_rtt_samples () Int)
(declare-fun v_1_rtt_samples () Int)
(declare-fun v_1_rtt_last_ms () Int)
(declare-fun v_1_rtt_sample_was_ambiguous () Bool)
(declare-fun v_1_rtt_sample_used () Bool)
(declare-fun v_0_rtt_remaining () Int)
(declare-fun v_1_rtt_start_new () Bool)
(declare-fun v_1_rtt_remaining () Int)
(declare-fun v_1_rtt_start_ms () Int)
(declare-fun v_0_rtt_sample_at_ms () Int)
(declare-fun v_1_rtt_sample_at_ms () Int)
(declare-fun v_1_rtt_ambiguous () Bool)
(declare-fun v_1_rtt_active () Bool)
(declare-fun v_0_rtt_previous_measured () Bool)
(declare-fun v_1_rtt_previous_measured () Bool)
(declare-fun v_1_rtt_measured () Bool)
(declare-fun v_0_rtt_previous_var () Real)
(declare-fun v_1_rtt_previous_var () Real)
(declare-fun v_0_rtt_previous_srtt () Real)
(declare-fun v_1_rtt_previous_srtt () Real)
(declare-fun v_1_rtt_error_ms () Real)
(declare-fun v_1_rttvar_ms () Real)
(declare-fun v_1_srtt_ms () Real)
(declare-fun v_0_rx_fin_consumed () Bool)
(declare-fun v_1_rx_fin_consumed () Bool)
(declare-fun v_0_rx_fin_done () Bool)
(declare-fun v_1_rx_fin_done () Bool)
(declare-fun v_0_rx_fin_offset () Int)
(declare-fun v_1_rx_fin_offset () Int)
(declare-fun v_0_rx_fin_pending () Bool)
(declare-fun v_1_rx_fin_pending () Bool)
(declare-fun v_1_fin_acknowledged () Bool)
(declare-fun v_1_fin_sent () Bool)
(declare-fun v_0_fin_requested () Bool)
(declare-fun v_1_fin_requested () Bool)
(declare-fun v_1_ack_window_update () Bool)
(declare-fun v_1_ack_advance () Bool)
(declare-fun v_1_ack_is_future () Bool)
(declare-fun v_1_ack_is_new () Bool)
(declare-fun v_1_ack_delta () Int)
(declare-fun v_1_seg_acceptable () Bool)
(declare-fun v_0_rx_acceptable () Bool)
(declare-fun v_1_rx_acceptable () Bool)
(declare-fun v_0_rx_advance () Int)
(declare-fun v_1_rx_advance () Int)
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
(declare-fun v_0_ack_delta () Int)
(declare-fun v_0_rtt_sample_was_ambiguous () Bool)
(declare-fun v_0_rtt_sample_used () Bool)
(declare-fun v_0_tx_retransmitted () Bool)
(declare-fun v_0_tx_waiting () Bool)
(declare-fun v_0_tx_syn_time () Int)
(declare-fun v_0_tx_syn_pending () Bool)
(declare-fun v_0_persist_probe_sent () Bool)
(declare-fun v_0_cc_acked () Int)
(declare-fun v_0_cc_growth () Int)
(declare-fun v_0_cc_send_budget () Int)
(declare-fun v_0_cc_new_sent () Int)
(declare-fun v_0_fr_emit_count () Int)
(declare-fun v_0_fr_before_retries () Int)
(declare-fun v_0_fr_before_rto () Int)
(declare-fun v_0_fr_entered () Bool)
(declare-fun v_0_fr_retransmitted () Bool)
(declare-fun v_0_fr_before_window_valid () Bool)
(declare-fun v_0_fr_before_wire_window () Int)
(declare-fun v_0_fr_window_ignored () Bool)
(declare-fun v_0_fr_exited () Bool)
(declare-fun v_0_idle_elapsed_ms () Int)
(declare-fun v_0_idle_event_ms () Int)
(declare-fun v_0_idle_data_emitted () Bool)
(declare-fun v_0_idle_before_threshold () Int)
(declare-fun v_0_idle_before_cwnd () Int)
(declare-fun v_0_idle_before_rto () Int)
(declare-fun v_0_idle_restart () Bool)
(declare-fun v_0_lt_loss_flight () Int)
(declare-fun v_0_lt_take () Int)
(declare-fun v_0_lt_before_flight () Int)
(declare-fun v_0_lt_before_cwnd () Int)
(declare-fun v_0_fr_duplicate () Bool)
(declare-fun v_0_lt_emitted () Bool)
(declare-fun v_0_lt_before_bytes () Int)
(declare-fun v_0_fr_before_flight () Int)
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
 true)
(assert
 true)
(assert
 (>= now_0 0))
(assert
 (let (($x218 (not active_0_rtx)))
 (or $x218 (>= due_0_rtx now_0))))
(assert
 (let (($x223 (not active_0_user)))
 (or $x223 (>= due_0_user now_0))))
(assert
 (let (($x228 (not active_0_time_wait)))
 (or $x228 (>= due_0_time_wait now_0))))
(assert
 (let (($x233 (not active_0_delack)))
 (or $x233 (>= due_0_delack now_0))))
(assert
 (let (($x238 (not active_0_persist)))
 (or $x238 (>= due_0_persist now_0))))
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
 (let (($x523 (not v_0_rtt_ambiguous)))
 (let ((?x520 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let ((?x332 (mod (+ input_0_net.ack_ack (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x521 (>= ?x332 ?x520)))
 (let ((?x341 (ite v_0_fin_sent 1 0)))
 (let ((?x348 (+ v_0_rtx_buf ?x341)))
 (let (($x370 (<= ?x332 ?x348)))
 (let (($x369 (<= 1 ?x332)))
 (let (($x327 (= input_0_net.ack_seq v_0_rcv_nxt)))
 (let ((?x311 (- 1)))
 (let ((?x323 (+ ?x311 v_0_local_window)))
 (let (($x325 (and (<= 1 v_0_local_window) (<= (mod (+ input_0_net.ack_seq (* ?x311 v_0_rcv_nxt)) 4294967296) ?x323))))
 (let (($x329 (or $x325 (and (= 0 v_0_local_window) $x327))))
 (let (($x524 (and v_0_rtt_active $x329 $x369 $x370 $x521 $x523)))
 (let ((?x538 (ite $x524 (+ now_1 (* ?x311 v_0_rtt_start_ms)) v_0_rtt_last_ms)))
 (let ((?x539 (to_real ?x538)))
 (let ((?x460 (/ 1.0 2.0)))
 (let ((?x552 (+ v_0_srtt_ms (* (- 1.0) ?x539))))
 (let ((?x559 (ite $x524 (ite (>= ?x552 0.0) ?x552 (+ (* (- 1.0) v_0_srtt_ms) ?x539)) v_0_rtt_error_ms)))
 (let ((?x550 (/ 1.0 4.0)))
 (let ((?x563 (ite v_0_rtt_measured (+ (* (/ 3.0 4.0) v_0_rttvar_ms) (* ?x550 ?x559)) (* ?x460 ?x539))))
 (let ((?x564 (ite $x524 ?x563 v_0_rttvar_ms)))
 (let ((?x526 (- 1.0)))
 (let ((?x542 (ite v_0_rtt_measured (+ (* (/ 7.0 8.0) v_0_srtt_ms) (* (/ 1.0 8.0) ?x539)) ?x539)))
 (let ((?x543 (ite $x524 ?x542 v_0_srtt_ms)))
 (let ((?x569 (+ (* ?x526 ?x543) (* ?x526 (ite (<= ?x564 ?x550) 1.0 (* 4.0 ?x564))))))
 (let ((?x570 (to_int ?x569)))
 (let ((?x574 (* ?x311 ?x570)))
 (let ((?x575 (ite (<= ?x570 (- 1000)) ?x574 1000)))
 (let ((?x577 (ite (<= 60000 ?x575) 60000 ?x575)))
 (let ((?x579 (ite $x524 ?x577 v_0_rto_ms)))
 (let (($x376 (not v_0_persist_active)))
 (let ((?x412 (ite (<= 0 v_0_rtx_buf) v_0_rtx_buf 0)))
 (let ((?x410 (ite (<= v_0_rtx_buf ?x332) 0 (+ v_0_rtx_buf (* ?x311 ?x332)))))
 (let (($x371 (and $x329 $x369 $x370)))
 (let ((?x415 (ite $x371 (ite (<= ?x410 ?x412) ?x410 ?x412) v_0_rtx_buf)))
 (let (($x419 (= 0 ?x415)))
 (let (($x420 (or v_0_persist_active $x419)))
 (let (($x418 (>= 1 ?x415)))
 (let (($x417 (<= 1 (+ ?x415 v_0_snd_buf))))
 (let (($x405 (and (not (and $x329 $x369 $x370 v_0_fin_sent (= ?x332 ?x348))) v_0_fin_sent)))
 (let (($x406 (not $x405)))
 (let (($x397 (not (<= 2147483648 (mod (+ input_0_net.ack_seq (* ?x311 v_0_snd_wl1)) 4294967296)))))
 (let (($x395 (not (<= (mod (+ input_0_net.ack_seq (* ?x311 v_0_snd_wl1)) 4294967296) 0))))
 (let (($x389 (not (<= 2147483648 (mod (+ input_0_net.ack_ack (* ?x311 v_0_snd_wl2)) 4294967296)))))
 (let (($x384 (= v_0_snd_wl1 input_0_net.ack_seq)))
 (let (($x400 (and $x329 $x370 (or (and $x384 $x389) (and $x395 $x397)))))
 (let ((?x401 (ite $x400 input_0_net.ack_window v_0_snd_wnd)))
 (let (($x402 (= 0 ?x401)))
 (let (($x1247 (and $x402 $x406 $x417 $x418 $x420 $x376)))
 (let ((?x1259 (ite $x1247 ?x579 v_0_persist_interval_ms)))
 (let ((?x1275 (+ now_1 ?x1259)))
 (let (($x1722 (= due_1_delack due_0_delack)))
 (let (($x1720 (= due_1_time_wait due_0_time_wait)))
 (let (($x1718 (= due_1_user due_0_user)))
 (let ((?x795 (ite (<= (- 999.0) ?x569) 1000 ?x574)))
 (let ((?x798 (ite $x524 (ite (<= 60000 ?x795) 60000 ?x795) v_0_rto_ms)))
 (let (($x1694 (and $x329 $x369 $x370 (<= 1 (+ ?x415 (ite $x405 1 0))))))
 (let (($x1692 (and (not (and $x329 $x369 $x370 (= 0 (+ ?x415 (ite $x405 1 0))))) active_0_rtx)))
 (let (($x421 (and $x402 $x406 $x417 $x418 $x420)))
 (let (($x446 (not $x421)))
 (let (($x1696 (and $x446 (or $x1692 $x1694))))
 (let (($x448 (<= 1 ?x415)))
 (let (($x1698 (and v_0_persist_active $x446 $x448 (not $x1696))))
 (let (($x1711 (= active_1_persist (and $x402 $x406 $x417 $x418 $x420 (or active_0_persist $x1247)))))
 (let ((?x500 (ite (<= ?x415 ?x401) ?x415 ?x401)))
 (let ((?x502 (ite (<= 4 ?x500) 4 ?x500)))
 (let ((?x372 (ite $x371 input_0_net.ack_ack v_0_snd_una)))
 (let (($x422 (= ?x372 v_0_snd_una)))
 (let ((?x427 (+ 1 v_0_fr_dupacks)))
 (let (($x383 (<= 1 input_0_net.ack_window)))
 (let (($x382 (= input_0_net.ack_window v_0_fr_last_window)))
 (let (($x380 (= input_0_net.ack_ack v_0_snd_una)))
 (let (($x379 (<= 1 v_0_snd_wnd)))
 (let (($x374 (<= 1 v_0_rtx_buf)))
 (let (($x425 (and $x374 $x376 v_0_fr_window_valid $x379 $x380 $x382 $x383)))
 (let ((?x428 (ite $x425 ?x427 v_0_fr_dupacks)))
 (let (($x438 (= ?x428 3)))
 (let (($x436 (not v_0_fr_active)))
 (let (($x439 (and $x374 $x376 v_0_fr_window_valid $x379 $x380 $x382 $x383 $x436 $x438 $x422)))
 (let ((?x503 (ite $x439 ?x502 0)))
 (let (($x504 (<= 1 ?x503)))
 (let (($x1215 (not $x504)))
 (let (($x508 (and (<= 0 ?x503) $x374 $x376 v_0_fr_window_valid $x379 $x380 $x382 $x383 $x436 $x438 $x422)))
 (let ((?x509 (ite $x508 ?x502 0)))
 (let ((?x506 (ite (<= ?x415 0) 0 ?x415)))
 (let ((?x511 (ite (<= ?x506 ?x509) ?x506 ?x509)))
 (let (($x512 (<= 1 ?x511)))
 (let (($x513 (and $x504 $x512)))
 (let ((?x517 (+ now_1 (* ?x311 (ite $x513 now_1 v_0_idle_last_data_ms)))))
 (let (($x580 (<= ?x517 ?x579)))
 (let ((?x449 (* ?x311 ?x415)))
 (let ((?x477 (+ v_0_rtx_buf ?x449)))
 (let ((?x478 (ite $x422 0 ?x477)))
 (let (($x483 (>= v_0_cc_cwnd v_0_cc_ssthresh)))
 (let ((?x490 (ite $x483 (ite (>= (+ v_0_cc_ca_credit ?x478) v_0_cc_cwnd) 4 0) (ite (>= 4 ?x478) ?x478 4))))
 (let ((?x491 (ite (or v_0_fr_active (not (and (<= 1 ?x478) $x376 $x379))) 0 ?x490)))
 (let ((?x466 (+ (* (- ?x460) (to_real v_0_rtx_buf)) (* ?x460 (to_real v_0_lt_epoch_bytes)))))
 (let ((?x457 (* ?x311 v_0_lt_epoch_bytes)))
 (let ((?x468 (+ v_0_rtx_buf ?x457 (to_int ?x466))))
 (let ((?x472 (ite $x439 (ite (<= 8 ?x468) ?x468 8) v_0_cc_ssthresh)))
 (let (($x423 (not $x422)))
 (let (($x440 (and v_0_fr_active $x423)))
 (let (($x474 (and $x374 $x376 v_0_fr_window_valid $x379 $x380 $x382 $x383 v_0_fr_active)))
 (let ((?x495 (ite $x474 (+ 4 v_0_cc_cwnd ?x491) (ite $x440 ?x472 (+ v_0_cc_cwnd ?x491)))))
 (let ((?x496 (ite $x439 (+ 12 ?x472) ?x495)))
 (let (($x498 (<= (- 7) (+ ?x496 ?x449))))
 (let ((?x450 (+ ?x401 ?x449)))
 (let (($x451 (<= 1 ?x450)))
 (let (($x447 (<= 1 v_0_snd_buf)))
 (let (($x444 (and (not (or $x419 $x421)) (or $x439 (and (not $x440) v_0_fr_active)))))
 (let (($x445 (not $x444)))
 (let ((?x429 (ite (or $x421 $x419 $x423) 0 ?x428)))
 (let (($x432 (>= 2 ?x429)))
 (let (($x430 (<= 1 ?x429)))
 (let (($x581 (and $x374 $x376 v_0_fr_window_valid $x379 $x380 $x382 $x383 $x430 $x432 $x445 $x406 $x446 $x447 $x448 $x451 $x498 $x580)))
 (let (($x790 (not $x581)))
 (let (($x1704 (= active_1_time_wait active_0_time_wait)))
 (let (($x1702 (= active_1_user active_0_user)))
 (let (($x1682 (= v_1_lt_before_window v_0_snd_wnd)))
 (let (($x1680 (= v_1_lt_before_flight v_0_rtx_buf)))
 (let (($x1678 (= v_1_lt_before_nxt v_0_snd_nxt)))
 (let (($x1677 (= v_1_lt_before_cwnd v_0_cc_cwnd)))
 (let (($x1675 (= v_1_lt_before_bytes v_0_lt_epoch_bytes)))
 (let ((?x1672 (+ (ite (or $x440 $x439 $x421 $x419 $x423) 0 v_0_lt_epoch_packets) (ite $x581 1 0))))
 (let ((?x585 (ite (<= ?x401 (+ 8 ?x496)) ?x450 (+ 8 ?x496 ?x449))))
 (let ((?x587 (ite (<= v_0_snd_buf ?x585) v_0_snd_buf ?x585)))
 (let ((?x589 (ite (<= 4 ?x587) 4 ?x587)))
 (let ((?x1661 (ite $x581 ?x589 0)))
 (let ((?x1666 (+ (ite (or $x440 $x439 $x421 $x419 $x423) 0 v_0_lt_epoch_bytes) ?x1661)))
 (let (($x1655 (= v_1_idle_restart_count v_0_idle_restart_count)))
 (let (($x1652 (= v_1_idle_before_threshold v_0_cc_ssthresh)))
 (let (($x1650 (= v_1_idle_before_rto v_0_rto_ms)))
 (let (($x1648 (= v_1_idle_before_cwnd v_0_cc_cwnd)))
 (let ((?x1645 (ite v_0_idle_data_valid (+ now_1 (* ?x311 v_0_idle_last_data_ms)) 0)))
 (let (($x1641 (not v_1_idle_restart)))
 (let ((?x591 (ite $x581 ?x589 v_0_take)))
 (let ((?x619 (ite (<= 0 ?x591) ?x591 0)))
 (let ((?x631 (ite (<= v_0_snd_buf 0) 0 v_0_snd_buf)))
 (let ((?x633 (ite (<= ?x631 ?x619) ?x631 ?x619)))
 (let (($x1623 (<= 1 ?x633)))
 (let (($x1629 (or $x513 $x1623)))
 (let (($x1636 (= v_1_idle_event_ms now_1)))
 (let (($x799 (<= ?x517 ?x798)))
 (let (($x1630 (and $x374 $x376 v_0_fr_window_valid $x379 $x380 $x382 $x383 $x430 $x432 $x445 $x406 $x446 $x447 $x448 $x451 $x498 $x799 $x1629)))
 (let (($x1634 (= v_1_idle_last_data_ms (ite (or $x1630 (and $x790 $x504 $x512)) now_1 v_0_idle_last_data_ms))))
 (let (($x1626 (ite $x581 (or v_0_idle_data_valid $x513 $x1623) (or v_0_idle_data_valid $x513))))
 (let (($x1603 (= v_1_fr_before_retries v_0_retries)))
 (let (($x1601 (= v_1_fr_before_rto v_0_rto_ms)))
 (let (($x1599 (= v_1_fr_before_flight v_0_rtx_buf)))
 (let (($x1597 (= v_1_fr_before_nxt v_0_snd_nxt)))
 (let (($x1596 (= v_1_fr_before_una v_0_snd_una)))
 (let (($x1595 (= v_1_fr_was_active v_0_fr_active)))
 (let (($x1593 (= v_1_fr_last_window input_0_net.ack_window)))
 (let (($x1586 (= v_1_fr_before_window_valid v_0_fr_window_valid)))
 (let (($x1584 (= v_1_fr_before_wire_window v_0_fr_last_window)))
 (let (($x1582 (not v_1_fr_window_ignored)))
 (let (($x1580 (= v_1_cc_rto_15 (and (not (>= 15 ?x415)) (or $x422 (= ?x477 0)) v_0_cc_rto_15))))
 (let (($x1338 (or $x422 (= ?x477 0))))
 (let (($x1575 (and (not (>= 14 ?x415)) (ite $x1338 v_0_cc_rto_14 (and (= ?x477 1) $x423 v_0_cc_rto_15)))))
 (let (($x1340 (= ?x477 1)))
 (let (($x1341 (and $x1340 $x423)))
 (let (($x1568 (ite $x1338 v_0_cc_rto_13 (ite $x1341 v_0_cc_rto_14 (and (= ?x477 2) $x423 v_0_cc_rto_15)))))
 (let (($x1343 (= ?x477 2)))
 (let (($x1344 (and $x1343 $x423)))
 (let (($x1560 (ite $x1341 v_0_cc_rto_13 (ite $x1344 v_0_cc_rto_14 (and (= ?x477 3) $x423 v_0_cc_rto_15)))))
 (let (($x1563 (= v_1_cc_rto_12 (and (not (>= 12 ?x415)) (ite $x1338 v_0_cc_rto_12 $x1560)))))
 (let (($x1346 (= ?x477 3)))
 (let (($x1347 (and $x1346 $x423)))
 (let (($x1551 (ite $x1344 v_0_cc_rto_13 (ite $x1347 v_0_cc_rto_14 (and (= ?x477 4) $x423 v_0_cc_rto_15)))))
 (let (($x1554 (and (not (>= 11 ?x415)) (ite $x1338 v_0_cc_rto_11 (ite $x1341 v_0_cc_rto_12 $x1551)))))
 (let (($x1349 (= ?x477 4)))
 (let (($x1350 (and $x1349 $x423)))
 (let (($x1541 (ite $x1347 v_0_cc_rto_13 (ite $x1350 v_0_cc_rto_14 (and (= ?x477 5) $x423 v_0_cc_rto_15)))))
 (let (($x1544 (ite $x1338 v_0_cc_rto_10 (ite $x1341 v_0_cc_rto_11 (ite $x1344 v_0_cc_rto_12 $x1541)))))
 (let (($x1352 (= ?x477 5)))
 (let (($x1353 (and $x1352 $x423)))
 (let (($x1530 (ite $x1350 v_0_cc_rto_13 (ite $x1353 v_0_cc_rto_14 (and (= ?x477 6) $x423 v_0_cc_rto_15)))))
 (let (($x1533 (ite $x1341 v_0_cc_rto_10 (ite $x1344 v_0_cc_rto_11 (ite $x1347 v_0_cc_rto_12 $x1530)))))
 (let (($x1536 (= v_1_cc_rto_09 (and (not (>= 9 ?x415)) (ite $x1338 v_0_cc_rto_09 $x1533)))))
 (let (($x1355 (= ?x477 6)))
 (let (($x1356 (and $x1355 $x423)))
 (let (($x1518 (ite $x1353 v_0_cc_rto_13 (ite $x1356 v_0_cc_rto_14 (and (= ?x477 7) $x423 v_0_cc_rto_15)))))
 (let (($x1521 (ite $x1344 v_0_cc_rto_10 (ite $x1347 v_0_cc_rto_11 (ite $x1350 v_0_cc_rto_12 $x1518)))))
 (let (($x1524 (and (not (>= 8 ?x415)) (ite $x1338 v_0_cc_rto_08 (ite $x1341 v_0_cc_rto_09 $x1521)))))
 (let (($x1358 (= ?x477 7)))
 (let (($x1359 (and $x1358 $x423)))
 (let (($x1505 (ite $x1356 v_0_cc_rto_13 (ite $x1359 v_0_cc_rto_14 (and (= ?x477 8) $x423 v_0_cc_rto_15)))))
 (let (($x1508 (ite $x1347 v_0_cc_rto_10 (ite $x1350 v_0_cc_rto_11 (ite $x1353 v_0_cc_rto_12 $x1505)))))
 (let (($x1511 (ite $x1338 v_0_cc_rto_07 (ite $x1341 v_0_cc_rto_08 (ite $x1344 v_0_cc_rto_09 $x1508)))))
 (let (($x1361 (= ?x477 8)))
 (let (($x1362 (and $x1361 $x423)))
 (let (($x1491 (ite $x1359 v_0_cc_rto_13 (ite $x1362 v_0_cc_rto_14 (and (= ?x477 9) $x423 v_0_cc_rto_15)))))
 (let (($x1494 (ite $x1350 v_0_cc_rto_10 (ite $x1353 v_0_cc_rto_11 (ite $x1356 v_0_cc_rto_12 $x1491)))))
 (let (($x1497 (ite $x1341 v_0_cc_rto_07 (ite $x1344 v_0_cc_rto_08 (ite $x1347 v_0_cc_rto_09 $x1494)))))
 (let (($x1500 (= v_1_cc_rto_06 (and (not (>= 6 ?x415)) (ite $x1338 v_0_cc_rto_06 $x1497)))))
 (let (($x1364 (= ?x477 9)))
 (let (($x1365 (and $x1364 $x423)))
 (let (($x1476 (ite $x1362 v_0_cc_rto_13 (ite $x1365 v_0_cc_rto_14 (and (= ?x477 10) $x423 v_0_cc_rto_15)))))
 (let (($x1479 (ite $x1353 v_0_cc_rto_10 (ite $x1356 v_0_cc_rto_11 (ite $x1359 v_0_cc_rto_12 $x1476)))))
 (let (($x1482 (ite $x1344 v_0_cc_rto_07 (ite $x1347 v_0_cc_rto_08 (ite $x1350 v_0_cc_rto_09 $x1479)))))
 (let (($x1485 (and (not (>= 5 ?x415)) (ite $x1338 v_0_cc_rto_05 (ite $x1341 v_0_cc_rto_06 $x1482)))))
 (let (($x1367 (= ?x477 10)))
 (let (($x1368 (and $x1367 $x423)))
 (let (($x1460 (ite $x1365 v_0_cc_rto_13 (ite $x1368 v_0_cc_rto_14 (and (= ?x477 11) $x423 v_0_cc_rto_15)))))
 (let (($x1463 (ite $x1356 v_0_cc_rto_10 (ite $x1359 v_0_cc_rto_11 (ite $x1362 v_0_cc_rto_12 $x1460)))))
 (let (($x1466 (ite $x1347 v_0_cc_rto_07 (ite $x1350 v_0_cc_rto_08 (ite $x1353 v_0_cc_rto_09 $x1463)))))
 (let (($x1469 (ite $x1338 v_0_cc_rto_04 (ite $x1341 v_0_cc_rto_05 (ite $x1344 v_0_cc_rto_06 $x1466)))))
 (let (($x1370 (= ?x477 11)))
 (let (($x1371 (and $x1370 $x423)))
 (let (($x1443 (ite $x1368 v_0_cc_rto_13 (ite $x1371 v_0_cc_rto_14 (and (= ?x477 12) $x423 v_0_cc_rto_15)))))
 (let (($x1446 (ite $x1359 v_0_cc_rto_10 (ite $x1362 v_0_cc_rto_11 (ite $x1365 v_0_cc_rto_12 $x1443)))))
 (let (($x1449 (ite $x1350 v_0_cc_rto_07 (ite $x1353 v_0_cc_rto_08 (ite $x1356 v_0_cc_rto_09 $x1446)))))
 (let (($x1452 (ite $x1341 v_0_cc_rto_04 (ite $x1344 v_0_cc_rto_05 (ite $x1347 v_0_cc_rto_06 $x1449)))))
 (let (($x1455 (= v_1_cc_rto_03 (and (not (>= 3 ?x415)) (ite $x1338 v_0_cc_rto_03 $x1452)))))
 (let (($x1373 (= ?x477 12)))
 (let (($x1374 (and $x1373 $x423)))
 (let (($x1425 (ite $x1371 v_0_cc_rto_13 (ite $x1374 v_0_cc_rto_14 (and (= ?x477 13) $x423 v_0_cc_rto_15)))))
 (let (($x1428 (ite $x1362 v_0_cc_rto_10 (ite $x1365 v_0_cc_rto_11 (ite $x1368 v_0_cc_rto_12 $x1425)))))
 (let (($x1431 (ite $x1353 v_0_cc_rto_07 (ite $x1356 v_0_cc_rto_08 (ite $x1359 v_0_cc_rto_09 $x1428)))))
 (let (($x1434 (ite $x1344 v_0_cc_rto_04 (ite $x1347 v_0_cc_rto_05 (ite $x1350 v_0_cc_rto_06 $x1431)))))
 (let (($x1437 (and (not (>= 2 ?x415)) (ite $x1338 v_0_cc_rto_02 (ite $x1341 v_0_cc_rto_03 $x1434)))))
 (let (($x1376 (= ?x477 13)))
 (let (($x1377 (and $x1376 $x423)))
 (let (($x1406 (ite $x1374 v_0_cc_rto_13 (ite $x1377 v_0_cc_rto_14 (and (= ?x477 14) $x423 v_0_cc_rto_15)))))
 (let (($x1409 (ite $x1365 v_0_cc_rto_10 (ite $x1368 v_0_cc_rto_11 (ite $x1371 v_0_cc_rto_12 $x1406)))))
 (let (($x1412 (ite $x1356 v_0_cc_rto_07 (ite $x1359 v_0_cc_rto_08 (ite $x1362 v_0_cc_rto_09 $x1409)))))
 (let (($x1415 (ite $x1347 v_0_cc_rto_04 (ite $x1350 v_0_cc_rto_05 (ite $x1353 v_0_cc_rto_06 $x1412)))))
 (let (($x1418 (ite $x1338 v_0_cc_rto_01 (ite $x1341 v_0_cc_rto_02 (ite $x1344 v_0_cc_rto_03 $x1415)))))
 (let (($x1385 (ite (and (= ?x477 14) $x423) v_0_cc_rto_14 (and (= ?x477 15) $x423 v_0_cc_rto_15))))
 (let (($x1388 (ite $x1371 v_0_cc_rto_11 (ite $x1374 v_0_cc_rto_12 (ite $x1377 v_0_cc_rto_13 $x1385)))))
 (let (($x1391 (ite $x1362 v_0_cc_rto_08 (ite $x1365 v_0_cc_rto_09 (ite $x1368 v_0_cc_rto_10 $x1388)))))
 (let (($x1394 (ite $x1353 v_0_cc_rto_05 (ite $x1356 v_0_cc_rto_06 (ite $x1359 v_0_cc_rto_07 $x1391)))))
 (let (($x1397 (ite $x1344 v_0_cc_rto_02 (ite $x1347 v_0_cc_rto_03 (ite $x1350 v_0_cc_rto_04 $x1394)))))
 (let (($x1400 (and (not (>= 0 ?x415)) (ite $x1338 v_0_cc_rto_00 (ite $x1341 v_0_cc_rto_01 $x1397)))))
 (let ((?x1329 (+ (ite (<= v_0_cc_cwnd v_0_snd_wnd) v_0_cc_cwnd v_0_snd_wnd) (* ?x311 v_0_rtx_buf))))
 (let (($x1324 (= v_1_cc_before_cwnd v_0_cc_cwnd)))
 (let (($x1320 (= v_1_cc_threshold_updates v_0_cc_threshold_updates)))
 (let (($x1317 (not v_1_cc_threshold_changed)))
 (let (($x1315 (not v_1_cc_loss)))
 (let (($x1313 (= v_1_cc_before_window v_0_snd_wnd)))
 (let (($x1311 (= v_1_cc_before_persist v_0_persist_active)))
 (let (($x1309 (= v_1_cc_before_una v_0_snd_una)))
 (let (($x1308 (= v_1_cc_before_flight v_0_rtx_buf)))
 (let ((?x485 (+ v_0_cc_ca_credit ?x478)))
 (let (($x480 (and (<= 1 ?x478) $x376 $x379)))
 (let ((?x1302 (ite $x480 (ite (and $x483 (not (>= ?x485 v_0_cc_cwnd))) ?x485 0) v_0_cc_ca_credit)))
 (let (($x1292 (= v_1_cc_initial_threshold v_0_cc_initial_threshold)))
 (let (($x1289 (= v_1_cc_initial_window v_0_cc_initial_window)))
 (let (($x1286 (= v_1_persist_elapsed_ms v_0_persist_elapsed_ms)))
 (let (($x1279 (= v_1_persist_deadline_ms (ite $x421 (ite $x1247 ?x1275 v_0_persist_deadline_ms) 0))))
 (let (($x1269 (= v_1_persist_since_ms (ite $x421 (ite $x1247 now_1 v_0_persist_since_ms) 0))))
 (let (($x1264 (= v_1_persist_previous_interval_ms v_0_persist_previous_interval_ms)))
 (let (($x1256 (not v_1_persist_probe_new)))
 (let (($x1254 (not v_1_persist_probe_sent)))
 (let (($x1252 (not v_1_persist_first)))
 (let (($x1250 (= v_1_persist_was_active v_0_persist_active)))
 (let (($x1241 (not v_1_ack_defer_now)))
 (let (($x1239 (not v_1_ack_defer_candidate)))
 (let (($x1237 (= v_1_ack_rmss v_0_ack_rmss)))
 (let (($x1234 (= v_1_ack_delay_ms v_0_ack_delay_ms)))
 (let (($x1231 (= v_1_ack_full_segments (ite (or $x581 $x504) 0 v_0_ack_full_segments))))
 (let (($x1213 (not v_1_syn_timeout_eligible)))
 (let (($x1211 (not v_1_tx_syn_pending)))
 (let (($x1209 (= v_1_tx_syn_time 0)))
 (let (($x1207 (not v_1_tx_waiting)))
 (let (($x1205 (= v_1_tx_is_fin v_0_tx_is_fin)))
 (let (($x1202 (= v_1_tx_previous_rto v_0_tx_previous_rto)))
 (let (($x1199 (= v_1_tx_elapsed v_0_tx_elapsed)))
 (let (($x1196 (not v_1_tx_retransmitted)))
 (let (($x1194 (= v_1_tx_max_previous v_0_tx_max_previous)))
 (let (($x1191 (= v_1_tx_eligible v_0_tx_eligible)))
 (let (($x1188 (= v_1_tx_emit_count v_0_tx_emit_count)))
 (let ((?x1179 (ite (or (>= 15 ?x415) (and $x329 $x369 $x370 (not (= 0 ?x332)))) 0 v_0_tx_time_15)))
 (let (($x1174 (or (and (>= 15 ?x415) (<= 16 (+ ?x415 ?x633))) (and $x504 (<= 16 ?x503)))))
 (let (($x1175 (and $x374 $x376 v_0_fr_window_valid $x379 $x380 $x382 $x383 $x430 $x432 $x445 $x406 $x446 $x447 $x448 $x451 $x498 $x799 $x1174)))
 (let (($x1181 (= v_1_tx_time_15 (ite (or $x1175 (and $x790 $x504 (<= 16 ?x503))) now_1 ?x1179))))
 (let (($x808 (and $x329 $x369 $x370 (not (= 0 ?x332)))))
 (let (($x1155 (>= 14 ?x415)))
 (let ((?x1164 (ite $x1155 0 (ite $x808 (ite (= 1 ?x332) v_0_tx_time_15 0) v_0_tx_time_14))))
 (let (($x1159 (and $x374 $x376 v_0_fr_window_valid $x379 $x380 $x382 $x383 $x430 $x432 $x445 $x406 $x446 $x447 $x448 $x451 $x498 $x799 (or (and $x504 (<= 15 ?x503)) (and $x1155 (<= 15 (+ ?x415 ?x633)))))))
 (let (($x1166 (= v_1_tx_time_14 (ite (or $x1159 (and $x790 $x504 (<= 15 ?x503))) now_1 ?x1164))))
 (let (($x809 (= 1 ?x332)))
 (let ((?x1148 (ite $x808 (ite $x809 v_0_tx_time_14 (ite (= 2 ?x332) v_0_tx_time_15 0)) v_0_tx_time_13)))
 (let (($x1139 (>= 13 ?x415)))
 (let (($x1144 (and $x374 $x376 v_0_fr_window_valid $x379 $x380 $x382 $x383 $x430 $x432 $x445 $x406 $x446 $x447 $x448 $x451 $x498 $x799 (or (and $x1139 (<= 14 (+ ?x415 ?x633))) (and $x504 (<= 14 ?x503))))))
 (let ((?x1150 (ite (or (and $x790 $x504 (<= 14 ?x503)) $x1144) now_1 (ite $x1139 0 ?x1148))))
 (let (($x811 (= 2 ?x332)))
 (let ((?x1131 (ite $x809 v_0_tx_time_13 (ite $x811 v_0_tx_time_14 (ite (= 3 ?x332) v_0_tx_time_15 0)))))
 (let (($x1123 (>= 12 ?x415)))
 (let (($x1127 (and $x374 $x376 v_0_fr_window_valid $x379 $x380 $x382 $x383 $x430 $x432 $x445 $x406 $x446 $x447 $x448 $x451 $x498 $x799 (or (and $x504 (<= 13 ?x503)) (and $x1123 (<= 13 (+ ?x415 ?x633)))))))
 (let ((?x1134 (ite (or (and $x790 $x504 (<= 13 ?x503)) $x1127) now_1 (ite $x1123 0 (ite $x808 ?x1131 v_0_tx_time_12)))))
 (let (($x813 (= 3 ?x332)))
 (let ((?x1113 (ite $x811 v_0_tx_time_13 (ite $x813 v_0_tx_time_14 (ite (= 4 ?x332) v_0_tx_time_15 0)))))
 (let (($x1105 (>= 11 ?x415)))
 (let ((?x1116 (ite $x1105 0 (ite $x808 (ite $x809 v_0_tx_time_12 ?x1113) v_0_tx_time_11))))
 (let (($x1109 (and $x374 $x376 v_0_fr_window_valid $x379 $x380 $x382 $x383 $x430 $x432 $x445 $x406 $x446 $x447 $x448 $x451 $x498 $x799 (or (and $x504 (<= 12 ?x503)) (and $x1105 (<= 12 (+ ?x415 ?x633)))))))
 (let (($x1118 (= v_1_tx_time_11 (ite (or (and $x790 $x504 (<= 12 ?x503)) $x1109) now_1 ?x1116))))
 (let (($x815 (= 4 ?x332)))
 (let ((?x1094 (ite $x813 v_0_tx_time_13 (ite $x815 v_0_tx_time_14 (ite (= 5 ?x332) v_0_tx_time_15 0)))))
 (let ((?x1097 (ite $x808 (ite $x809 v_0_tx_time_11 (ite $x811 v_0_tx_time_12 ?x1094)) v_0_tx_time_10)))
 (let (($x1083 (>= 10 ?x415)))
 (let (($x1089 (and $x374 $x376 v_0_fr_window_valid $x379 $x380 $x382 $x383 $x430 $x432 $x445 $x406 $x446 $x447 $x448 $x451 $x498 $x799 (or (and $x1083 (<= 11 (+ ?x415 ?x633))) (and $x504 (<= 11 ?x503))))))
 (let ((?x1099 (ite (or $x1089 (and $x790 $x504 (<= 11 ?x503))) now_1 (ite $x1083 0 ?x1097))))
 (let (($x818 (= 5 ?x332)))
 (let ((?x1074 (ite $x815 v_0_tx_time_13 (ite $x818 v_0_tx_time_14 (ite (= 6 ?x332) v_0_tx_time_15 0)))))
 (let ((?x1077 (ite $x809 v_0_tx_time_10 (ite $x811 v_0_tx_time_11 (ite $x813 v_0_tx_time_12 ?x1074)))))
 (let (($x1066 (>= 9 ?x415)))
 (let (($x1070 (and $x374 $x376 v_0_fr_window_valid $x379 $x380 $x382 $x383 $x430 $x432 $x445 $x406 $x446 $x447 $x448 $x451 $x498 $x799 (or (and $x504 (<= 10 ?x503)) (and $x1066 (<= 10 (+ ?x415 ?x633)))))))
 (let ((?x1080 (ite (or (and $x790 $x504 (<= 10 ?x503)) $x1070) now_1 (ite $x1066 0 (ite $x808 ?x1077 v_0_tx_time_09)))))
 (let (($x821 (= 6 ?x332)))
 (let ((?x1053 (ite $x818 v_0_tx_time_13 (ite $x821 v_0_tx_time_14 (ite (= 7 ?x332) v_0_tx_time_15 0)))))
 (let ((?x1056 (ite $x811 v_0_tx_time_10 (ite $x813 v_0_tx_time_11 (ite $x815 v_0_tx_time_12 ?x1053)))))
 (let (($x1044 (>= 8 ?x415)))
 (let ((?x1059 (ite $x1044 0 (ite $x808 (ite $x809 v_0_tx_time_09 ?x1056) v_0_tx_time_08))))
 (let (($x1048 (and $x374 $x376 v_0_fr_window_valid $x379 $x380 $x382 $x383 $x430 $x432 $x445 $x406 $x446 $x447 $x448 $x451 $x498 $x799 (or (and $x504 (<= 9 ?x503)) (and $x1044 (<= 9 (+ ?x415 ?x633)))))))
 (let (($x1061 (= v_1_tx_time_08 (ite (or $x1048 (and $x790 $x504 (<= 9 ?x503))) now_1 ?x1059))))
 (let (($x823 (= 7 ?x332)))
 (let ((?x1031 (ite $x821 v_0_tx_time_13 (ite $x823 v_0_tx_time_14 (ite (= 8 ?x332) v_0_tx_time_15 0)))))
 (let ((?x1034 (ite $x813 v_0_tx_time_10 (ite $x815 v_0_tx_time_11 (ite $x818 v_0_tx_time_12 ?x1031)))))
 (let ((?x1037 (ite $x808 (ite $x809 v_0_tx_time_08 (ite $x811 v_0_tx_time_09 ?x1034)) v_0_tx_time_07)))
 (let (($x1020 (>= 7 ?x415)))
 (let (($x1026 (and $x374 $x376 v_0_fr_window_valid $x379 $x380 $x382 $x383 $x430 $x432 $x445 $x406 $x446 $x447 $x448 $x451 $x498 $x799 (or (and $x1020 (<= 8 (+ ?x415 ?x633))) (and $x504 (<= 8 ?x503))))))
 (let ((?x1039 (ite (or $x1026 (and $x790 $x504 (<= 8 ?x503))) now_1 (ite $x1020 0 ?x1037))))
 (let (($x825 (= 8 ?x332)))
 (let ((?x1008 (ite $x823 v_0_tx_time_13 (ite $x825 v_0_tx_time_14 (ite (= 9 ?x332) v_0_tx_time_15 0)))))
 (let ((?x1011 (ite $x815 v_0_tx_time_10 (ite $x818 v_0_tx_time_11 (ite $x821 v_0_tx_time_12 ?x1008)))))
 (let ((?x1014 (ite $x809 v_0_tx_time_07 (ite $x811 v_0_tx_time_08 (ite $x813 v_0_tx_time_09 ?x1011)))))
 (let (($x999 (>= 6 ?x415)))
 (let (($x1004 (and $x374 $x376 v_0_fr_window_valid $x379 $x380 $x382 $x383 $x430 $x432 $x445 $x406 $x446 $x447 $x448 $x451 $x498 $x799 (or (and $x999 (<= 7 (+ ?x415 ?x633))) (and $x504 (<= 7 ?x503))))))
 (let ((?x1017 (ite (or (and $x790 $x504 (<= 7 ?x503)) $x1004) now_1 (ite $x999 0 (ite $x808 ?x1014 v_0_tx_time_06)))))
 (let (($x828 (= 9 ?x332)))
 (let ((?x984 (ite $x825 v_0_tx_time_13 (ite $x828 v_0_tx_time_14 (ite (= 10 ?x332) v_0_tx_time_15 0)))))
 (let ((?x987 (ite $x818 v_0_tx_time_10 (ite $x821 v_0_tx_time_11 (ite $x823 v_0_tx_time_12 ?x984)))))
 (let ((?x990 (ite $x811 v_0_tx_time_07 (ite $x813 v_0_tx_time_08 (ite $x815 v_0_tx_time_09 ?x987)))))
 (let (($x975 (>= 5 ?x415)))
 (let ((?x993 (ite $x975 0 (ite $x808 (ite $x809 v_0_tx_time_06 ?x990) v_0_tx_time_05))))
 (let (($x980 (and $x374 $x376 v_0_fr_window_valid $x379 $x380 $x382 $x383 $x430 $x432 $x445 $x406 $x446 $x447 $x448 $x451 $x498 $x799 (or (and $x975 (<= 6 (+ ?x415 ?x633))) (and $x504 (<= 6 ?x503))))))
 (let (($x995 (= v_1_tx_time_05 (ite (or (and $x790 $x504 (<= 6 ?x503)) $x980) now_1 ?x993))))
 (let (($x831 (= 10 ?x332)))
 (let ((?x959 (ite $x828 v_0_tx_time_13 (ite $x831 v_0_tx_time_14 (ite (= 11 ?x332) v_0_tx_time_15 0)))))
 (let ((?x962 (ite $x821 v_0_tx_time_10 (ite $x823 v_0_tx_time_11 (ite $x825 v_0_tx_time_12 ?x959)))))
 (let ((?x965 (ite $x813 v_0_tx_time_07 (ite $x815 v_0_tx_time_08 (ite $x818 v_0_tx_time_09 ?x962)))))
 (let ((?x968 (ite $x808 (ite $x809 v_0_tx_time_05 (ite $x811 v_0_tx_time_06 ?x965)) v_0_tx_time_04)))
 (let (($x950 (>= 4 ?x415)))
 (let (($x955 (and $x374 $x376 v_0_fr_window_valid $x379 $x380 $x382 $x383 $x430 $x432 $x445 $x406 $x446 $x447 $x448 $x451 $x498 $x799 (or (and $x950 (<= 5 (+ ?x415 ?x633))) (and $x504 (<= 5 ?x503))))))
 (let ((?x970 (ite (or (and $x790 $x504 (<= 5 ?x503)) $x955) now_1 (ite $x950 0 ?x968))))
 (let (($x834 (= 11 ?x332)))
 (let ((?x933 (ite $x831 v_0_tx_time_13 (ite $x834 v_0_tx_time_14 (ite (= 12 ?x332) v_0_tx_time_15 0)))))
 (let ((?x936 (ite $x823 v_0_tx_time_10 (ite $x825 v_0_tx_time_11 (ite $x828 v_0_tx_time_12 ?x933)))))
 (let ((?x939 (ite $x815 v_0_tx_time_07 (ite $x818 v_0_tx_time_08 (ite $x821 v_0_tx_time_09 ?x936)))))
 (let ((?x942 (ite $x809 v_0_tx_time_04 (ite $x811 v_0_tx_time_05 (ite $x813 v_0_tx_time_06 ?x939)))))
 (let (($x924 (>= 3 ?x415)))
 (let (($x928 (and $x374 $x376 v_0_fr_window_valid $x379 $x380 $x382 $x383 $x430 $x432 $x445 $x406 $x446 $x447 $x448 $x451 $x498 $x799 (or (and $x504 (<= 4 ?x503)) (and $x924 (<= 4 (+ ?x415 ?x633)))))))
 (let ((?x945 (ite (or $x928 (and $x790 $x504 (<= 4 ?x503))) now_1 (ite $x924 0 (ite $x808 ?x942 v_0_tx_time_03)))))
 (let (($x836 (= 12 ?x332)))
 (let ((?x906 (ite $x834 v_0_tx_time_13 (ite $x836 v_0_tx_time_14 (ite (= 13 ?x332) v_0_tx_time_15 0)))))
 (let ((?x909 (ite $x825 v_0_tx_time_10 (ite $x828 v_0_tx_time_11 (ite $x831 v_0_tx_time_12 ?x906)))))
 (let ((?x912 (ite $x818 v_0_tx_time_07 (ite $x821 v_0_tx_time_08 (ite $x823 v_0_tx_time_09 ?x909)))))
 (let ((?x915 (ite $x811 v_0_tx_time_04 (ite $x813 v_0_tx_time_05 (ite $x815 v_0_tx_time_06 ?x912)))))
 (let (($x897 (>= 2 ?x415)))
 (let ((?x918 (ite $x897 0 (ite $x808 (ite $x809 v_0_tx_time_03 ?x915) v_0_tx_time_02))))
 (let (($x902 (and $x374 $x376 v_0_fr_window_valid $x379 $x380 $x382 $x383 $x430 $x432 $x445 $x406 $x446 $x447 $x448 $x451 $x498 $x799 (or (and $x897 (<= 3 (+ ?x415 ?x633))) (and $x504 (<= 3 ?x503))))))
 (let (($x920 (= v_1_tx_time_02 (ite (or (and $x790 $x504 (<= 3 ?x503)) $x902) now_1 ?x918))))
 (let (($x839 (= 13 ?x332)))
 (let ((?x878 (ite $x836 v_0_tx_time_13 (ite $x839 v_0_tx_time_14 (ite (= 14 ?x332) v_0_tx_time_15 0)))))
 (let ((?x881 (ite $x828 v_0_tx_time_10 (ite $x831 v_0_tx_time_11 (ite $x834 v_0_tx_time_12 ?x878)))))
 (let ((?x884 (ite $x821 v_0_tx_time_07 (ite $x823 v_0_tx_time_08 (ite $x825 v_0_tx_time_09 ?x881)))))
 (let ((?x887 (ite $x813 v_0_tx_time_04 (ite $x815 v_0_tx_time_05 (ite $x818 v_0_tx_time_06 ?x884)))))
 (let ((?x890 (ite $x808 (ite $x809 v_0_tx_time_02 (ite $x811 v_0_tx_time_03 ?x887)) v_0_tx_time_01)))
 (let (($x874 (and $x374 $x376 v_0_fr_window_valid $x379 $x380 $x382 $x383 $x430 $x432 $x445 $x406 $x446 $x447 $x448 $x451 $x498 $x799 (or (and $x504 (<= 2 ?x503)) (and $x418 (<= 2 (+ ?x415 ?x633)))))))
 (let ((?x892 (ite (or (and $x790 $x504 (<= 2 ?x503)) $x874) now_1 (ite $x418 0 ?x890))))
 (let (($x842 (= 14 ?x332)))
 (let ((?x849 (ite $x839 v_0_tx_time_13 (ite $x842 v_0_tx_time_14 (ite (= 15 ?x332) v_0_tx_time_15 0)))))
 (let ((?x852 (ite $x831 v_0_tx_time_10 (ite $x834 v_0_tx_time_11 (ite $x836 v_0_tx_time_12 ?x849)))))
 (let ((?x855 (ite $x823 v_0_tx_time_07 (ite $x825 v_0_tx_time_08 (ite $x828 v_0_tx_time_09 ?x852)))))
 (let ((?x858 (ite $x815 v_0_tx_time_04 (ite $x818 v_0_tx_time_05 (ite $x821 v_0_tx_time_06 ?x855)))))
 (let ((?x861 (ite $x809 v_0_tx_time_01 (ite $x811 v_0_tx_time_02 (ite $x813 v_0_tx_time_03 ?x858)))))
 (let (($x800 (>= 0 ?x415)))
 (let (($x804 (and $x374 $x376 v_0_fr_window_valid $x379 $x380 $x382 $x383 $x430 $x432 $x445 $x406 $x446 $x447 $x448 $x451 $x498 $x799 (or (and $x800 (<= 1 (+ ?x415 ?x633))) $x504))))
 (let ((?x865 (ite (or (and $x790 $x504) $x804) now_1 (ite $x800 0 (ite $x808 ?x861 v_0_tx_time_00)))))
 (let (($x777 (= v_1_rtt_sample_was_ambiguous (and v_0_rtt_active v_0_rtt_ambiguous))))
 (let (($x725 (and v_0_rtt_active $x329 $x369 $x370 $x521)))
 (let (($x726 (not $x725)))
 (let (($x732 (and $x446 $x726 v_0_rtt_ambiguous)))
 (let ((?x408 (* ?x311 ?x332)))
 (let ((?x738 (+ ?x520 ?x408)))
 (let (($x741 (and v_0_rtt_active $x329 $x369 $x370 (not (<= v_0_rtt_remaining ?x738)))))
 (let ((?x743 (ite (or $x421 $x725) 0 (ite $x741 ?x738 v_0_rtt_remaining))))
 (let (($x747 (<= (+ (mod (+ v_0_rtt_end (* ?x311 ?x372)) 4294967296) (* ?x311 ?x743)) (+ ?x311 ?x511))))
 (let (($x750 (ite $x504 (or $x732 (and $x446 v_0_rtt_active $x726 $x747)) $x732)))
 (let (($x752 (and $x374 $x376 v_0_fr_window_valid $x379 $x380 $x382 $x383 $x430 $x432 $x445 $x406 $x446 $x447 $x448 $x451 $x498 $x580 (or (not (and $x446 v_0_rtt_active $x726)) $x750))))
 (let (($x767 (= v_1_rtt_end (ite $x752 (mod (+ v_0_snd_nxt ?x633) 4294967296) v_0_rtt_end))))
 (let (($x723 (= v_1_rtt_previous_measured (ite $x524 v_0_rtt_measured v_0_rtt_previous_measured))))
 (let (($x716 (= v_1_rtt_previous_var (ite $x524 v_0_rttvar_ms v_0_rtt_previous_var))))
 (let (($x712 (= v_1_rtt_previous_srtt (ite $x524 v_0_srtt_ms v_0_rtt_previous_srtt))))
 (let (($x702 (= v_1_rx_fin_consumed v_0_rx_fin_consumed)))
 (let (($x699 (= v_1_rx_fin_done v_0_rx_fin_done)))
 (let (($x696 (= v_1_rx_fin_offset v_0_rx_fin_offset)))
 (let (($x693 (= v_1_rx_fin_seq v_0_rx_fin_seq)))
 (let (($x692 (= v_1_rx_fin_pending v_0_rx_fin_pending)))
 (let (($x349 (= ?x332 ?x348)))
 (let (($x403 (and $x329 $x369 $x370 v_0_fin_sent $x349)))
 (let (($x687 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x684 (= v_1_fin_requested v_0_fin_requested)))
 (let (($x346 (and (>= ?x332 (+ 1 v_0_rtx_buf ?x341)) (>= 2147483647 ?x332))))
 (let (($x668 (= v_1_rx_acceptable v_0_rx_acceptable)))
 (let (($x665 (= v_1_rx_advance v_0_rx_advance)))
 (let (($x662 (= v_1_rx_slot_15 v_0_rx_slot_15)))
 (let (($x661 (= v_1_rx_slot_14 v_0_rx_slot_14)))
 (let (($x660 (= v_1_rx_slot_13 v_0_rx_slot_13)))
 (let (($x659 (= v_1_rx_slot_12 v_0_rx_slot_12)))
 (let (($x658 (= v_1_rx_slot_11 v_0_rx_slot_11)))
 (let (($x657 (= v_1_rx_slot_10 v_0_rx_slot_10)))
 (let (($x656 (= v_1_rx_slot_09 v_0_rx_slot_09)))
 (let (($x655 (= v_1_rx_slot_08 v_0_rx_slot_08)))
 (let (($x654 (= v_1_rx_slot_07 v_0_rx_slot_07)))
 (let (($x653 (= v_1_rx_slot_06 v_0_rx_slot_06)))
 (let (($x652 (= v_1_rx_slot_05 v_0_rx_slot_05)))
 (let (($x651 (= v_1_rx_slot_04 v_0_rx_slot_04)))
 (let (($x650 (= v_1_rx_slot_03 v_0_rx_slot_03)))
 (let (($x649 (= v_1_rx_slot_02 v_0_rx_slot_02)))
 (let (($x648 (= v_1_rx_slot_01 v_0_rx_slot_01)))
 (let (($x647 (= v_1_rx_slot_00 v_0_rx_slot_00)))
 (let (($x646 (= v_1_rx_chunk v_0_rx_chunk)))
 (let (($x637 (= v_1_rcv_buf v_0_rcv_buf)))
 (let ((?x625 (ite (<= 0 v_0_snd_buf) v_0_snd_buf 0)))
 (let ((?x623 (ite (<= v_0_snd_buf ?x619) 0 (+ v_0_snd_buf (* ?x311 ?x619)))))
 (let (($x629 (= v_1_snd_buf (ite $x581 (ite (<= ?x623 ?x625) ?x623 ?x625) v_0_snd_buf))))
 (let (($x617 (= v_1_local_window v_0_local_window)))
 (let (($x615 (= v_1_msl_ms v_0_msl_ms)))
 (let (($x612 (= v_1_user_timeout_ms v_0_user_timeout_ms)))
 (let (($x609 (= v_1_active_open v_0_active_open)))
 (let (($x606 (= v_1_retries v_0_retries)))
 (let (($x601 (= v_1_tx_flags v_0_tx_flags)))
 (let (($x598 (= v_1_tx_ack v_0_tx_ack)))
 (let (($x597 (= v_1_tx_seq v_0_tx_seq)))
 (let (($x596 (= v_1_rcv_nxt v_0_rcv_nxt)))
 (let (($x595 (= v_1_snd_nxt (ite $x581 (mod (+ v_0_snd_nxt ?x591) 4294967296) v_0_snd_nxt))))
 (let (($x368 (= v_1_irs v_0_irs)))
 (let (($x367 (= v_1_iss v_0_iss)))
 (let (($x339 (not (= (mod (+ input_0_net.ack_ack (* ?x311 v_0_snd_nxt)) 4294967296) 2147483648))))
 (let (($x317 (not (= (mod (+ v_0_rcv_nxt (* ?x311 input_0_net.ack_seq)) 4294967296) 2147483648))))
 (and (>= now_1 now_0) (<= 0 input_0_net.ack_window) (>= 65535 input_0_net.ack_window) $x317 $x329 (not (= ?x332 2147483648)) $x339 (not $x346) (not (and v_0_fin_sent $x349)) (or (not active_0_rtx) (not (<= due_0_rtx now_1))) (or (not active_0_user) (not (<= due_0_user now_1))) (or (not active_0_time_wait) (not (<= due_0_time_wait now_1))) (or (not active_0_delack) (not (<= due_0_delack now_1))) (or (not active_0_persist) (not (<= due_0_persist now_1))) $x367 $x368 (= v_1_snd_una ?x372) $x595 $x596 $x597 $x598 $x601 (= v_1_rto_ms ?x579) $x606 $x609 $x612 $x615 $x617 $x629 (= v_1_rtx_buf (ite $x581 (+ ?x415 ?x633) ?x415)) $x637 (= v_1_snd_wnd ?x401) (= v_1_snd_wl1 (ite $x400 input_0_net.ack_seq v_0_snd_wl1)) (= v_1_snd_wl2 (ite $x400 input_0_net.ack_ack v_0_snd_wl2)) (= v_1_take ?x591) $x646 $x647 $x648 $x649 $x650 $x651 $x652 $x653 $x654 $x655 $x656 $x657 $x658 $x659 $x660 $x661 $x662 $x665 $x668 (= v_1_seg_acceptable $x329) (= v_1_ack_delta ?x332) (= v_1_ack_is_new (and $x369 $x370)) (= v_1_ack_is_future $x346) (= v_1_ack_advance $x371) (= v_1_ack_window_update $x400) $x684 (= v_1_fin_sent $x405) $x687 (= v_1_fin_acknowledged $x403) $x692 $x693 $x696 $x699 $x702 (= v_1_srtt_ms ?x543) (= v_1_rttvar_ms ?x564) (= v_1_rtt_error_ms ?x559) $x712 $x716 (= v_1_rtt_measured (or v_0_rtt_measured $x524)) $x723 (= v_1_rtt_active (or (and $x446 v_0_rtt_active $x726) $x581)) (= v_1_rtt_ambiguous (ite $x581 (and (not $x752) $x750) $x750)) (= v_1_rtt_sample_at_ms (ite $x524 now_1 v_0_rtt_sample_at_ms)) (= v_1_rtt_start_ms (ite $x752 now_1 v_0_rtt_start_ms)) $x767 (= v_1_rtt_remaining (ite $x752 ?x633 ?x743)) (= v_1_rtt_start_new $x752) (= v_1_rtt_sample_used $x524) $x777 (= v_1_rtt_last_ms ?x538) (= v_1_rtt_samples (+ v_0_rtt_samples (ite $x524 1 0))) (= v_1_rto_base_ms (ite $x524 ?x577 v_0_rto_base_ms)) (= v_1_tx_time_00 ?x865) (= v_1_tx_time_01 ?x892) $x920 (= v_1_tx_time_03 ?x945) (= v_1_tx_time_04 ?x970) $x995 (= v_1_tx_time_06 ?x1017) (= v_1_tx_time_07 ?x1039) $x1061 (= v_1_tx_time_09 ?x1080) (= v_1_tx_time_10 ?x1099) $x1118 (= v_1_tx_time_12 ?x1134) (= v_1_tx_time_13 ?x1150) $x1166 $x1181 (= v_1_tx_fin_time (ite $x405 v_0_tx_fin_time 0)) $x1188 $x1191 $x1194 $x1196 $x1199 $x1202 $x1205 $x1207 $x1209 $x1211 $x1213 (= v_1_ack_pending (and $x790 $x1215 v_0_ack_pending)) (= v_1_ack_since_ms (ite (or $x581 $x504) 0 v_0_ack_since_ms)) (= v_1_ack_bytes (ite (or $x581 $x504) 0 v_0_ack_bytes)) $x1231 $x1234 $x1237 $x1239 $x1241 (= v_1_persist_active $x421) (= v_1_persist_eligible $x421) (= v_1_persist_start $x1247) $x1250 $x1252 $x1254 $x1256 (= v_1_persist_interval_ms (ite $x421 ?x1259 1000)) $x1264 $x1269 (= v_1_persist_last_ms (ite $x421 v_0_persist_last_ms 0)) $x1279 (= v_1_persist_probes (ite $x421 v_0_persist_probes 0)) $x1286 $x1289 $x1292 (= v_1_cc_cwnd ?x496) (= v_1_cc_ssthresh ?x472) (= v_1_cc_ca_credit (ite (or v_0_fr_active $x440 $x439) 0 ?x1302)) (= v_1_cc_acked ?x478) $x1308 $x1309 $x1311 $x1313 $x1315 $x1317 $x1320 (= v_1_cc_growth ?x491) $x1324 (= v_1_cc_send_budget (ite (<= 0 ?x1329) ?x1329 0)) (= 0 v_1_cc_new_sent) (= v_1_cc_rto_00 $x1400) (= v_1_cc_rto_01 (and (not $x418) $x1418)) (= v_1_cc_rto_02 $x1437) $x1455 (= v_1_cc_rto_04 (and (not $x950) $x1469)) (= v_1_cc_rto_05 $x1485) $x1500 (= v_1_cc_rto_07 (and (not $x1020) $x1511)) (= v_1_cc_rto_08 $x1524) $x1536 (= v_1_cc_rto_10 (and (not $x1083) $x1544)) (= v_1_cc_rto_11 $x1554) $x1563 (= v_1_cc_rto_13 (and (not $x1139) $x1568)) (= v_1_cc_rto_14 $x1575) $x1580 $x1582 $x1584 $x1586 (= v_1_fr_active $x444) (= v_1_fr_dupacks ?x429) v_1_fr_window_valid $x1593 $x1595 $x1596 $x1597 $x1599 $x1601 $x1603 (= v_1_fr_duplicate $x425) (= v_1_fr_entered $x439) (= v_1_fr_extra $x474) (= v_1_fr_exited $x440) (= v_1_fr_retransmitted $x504) (= v_1_fr_emit_count ?x503) (= v_1_fr_entries (+ v_0_fr_entries (ite $x439 1 0))) (= v_1_idle_data_valid $x1626) $x1634 $x1636 (= v_1_idle_data_emitted (ite $x581 $x1629 $x513)) $x1641 (= v_1_idle_elapsed_ms ?x1645) $x1648 $x1650 $x1652 $x1655 (= v_1_lt_eligible $x581) (= v_1_lt_emitted $x581) (= v_1_lt_take ?x1661) (= v_1_lt_epoch_bytes ?x1666) (= v_1_lt_epoch_packets ?x1672) $x1675 $x1677 $x1678 $x1680 $x1682 (= v_1_lt_loss_flight (+ v_0_rtx_buf ?x457)) (= active_1_rtx (or $x1696 $x1698)) $x1702 $x1704 (= active_1_delack (and $x790 $x1215 active_0_delack)) $x1711 (= due_1_rtx (ite (or $x1698 $x1694) (+ now_1 ?x798) due_0_rtx)) $x1718 $x1720 $x1722 (= due_1_persist (ite $x1247 ?x1275 due_0_persist)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
 (let ((?x1731 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1731)))
(assert
 (>= 16 v_0_rcv_buf))
(assert
 (and (<= 0 v_0_snd_wnd) (>= 65535 v_0_snd_wnd)))
(assert
 (= v_0_local_window (+ 16 (* (- 1) v_0_rcv_buf))))
(assert
 (>= 1 v_0_rx_slot_00))
(assert
 (let (($x1743 (= 0 v_0_rx_slot_00)))
 (let (($x1742 (not (>= v_0_rcv_buf 16))))
 (or $x1742 $x1743))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x1748 (= 0 v_0_rx_slot_01)))
 (let (($x1747 (not (>= v_0_rcv_buf 15))))
 (or $x1747 $x1748))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x1753 (= 0 v_0_rx_slot_02)))
 (let (($x1752 (not (>= v_0_rcv_buf 14))))
 (or $x1752 $x1753))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x1758 (= 0 v_0_rx_slot_03)))
 (let (($x1757 (not (>= v_0_rcv_buf 13))))
 (or $x1757 $x1758))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x1763 (= 0 v_0_rx_slot_04)))
 (let (($x1762 (not (>= v_0_rcv_buf 12))))
 (or $x1762 $x1763))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x1768 (= 0 v_0_rx_slot_05)))
 (let (($x1767 (not (>= v_0_rcv_buf 11))))
 (or $x1767 $x1768))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x1773 (= 0 v_0_rx_slot_06)))
 (let (($x1772 (not (>= v_0_rcv_buf 10))))
 (or $x1772 $x1773))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x1778 (= 0 v_0_rx_slot_07)))
 (let (($x1777 (not (>= v_0_rcv_buf 9))))
 (or $x1777 $x1778))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x1783 (= 0 v_0_rx_slot_08)))
 (let (($x1782 (not (>= v_0_rcv_buf 8))))
 (or $x1782 $x1783))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x1788 (= 0 v_0_rx_slot_09)))
 (let (($x1787 (not (>= v_0_rcv_buf 7))))
 (or $x1787 $x1788))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x1793 (= 0 v_0_rx_slot_10)))
 (let (($x1792 (not (>= v_0_rcv_buf 6))))
 (or $x1792 $x1793))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x1798 (= 0 v_0_rx_slot_11)))
 (let (($x1797 (not (>= v_0_rcv_buf 5))))
 (or $x1797 $x1798))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x1803 (= 0 v_0_rx_slot_12)))
 (let (($x1802 (not (>= v_0_rcv_buf 4))))
 (or $x1802 $x1803))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x1808 (= 0 v_0_rx_slot_13)))
 (let (($x1807 (not (>= v_0_rcv_buf 3))))
 (or $x1807 $x1808))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x1813 (= 0 v_0_rx_slot_14)))
 (let (($x1812 (not (>= v_0_rcv_buf 2))))
 (or $x1812 $x1813))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x1818 (= 0 v_0_rx_slot_15)))
 (let (($x1817 (not (>= v_0_rcv_buf 1))))
 (or $x1817 $x1818))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x1820 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x1820)))
(assert
 (and (<= 0 v_0_rx_advance) (>= 16 v_0_rx_advance)))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (and (<= 0 v_0_ack_delta) (>= 4294967295 v_0_ack_delta)))
(assert
 true)
(assert
 (let ((?x1832 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x1832)))
(assert
 (let (($x1839 (and v_0_fin_requested (= v_0_fin_seq (mod (+ v_0_snd_una v_0_rtx_buf) 4294967296)) (= 0 v_0_snd_buf))))
 (let (($x1834 (not v_0_fin_sent)))
 (or $x1834 $x1839))))
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
 (let (($x1843 (<= 1 v_0_rx_fin_offset)))
 (let (($x1841 (not v_0_rx_fin_done)))
 (let (($x1845 (and $x1841 $x1843 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window)))))
 (let (($x1842 (not v_0_rx_fin_pending)))
 (or $x1842 $x1845))))))
(assert
 (let (($x1848 (>= 15 v_0_rx_fin_offset)))
 (and (<= 0 v_0_rx_fin_offset) $x1848 (= v_0_rx_fin_pending (<= 1 v_0_rx_fin_offset)))))
(assert
 (let (($x1842 (not v_0_rx_fin_pending)))
 (or $x1842 (= v_0_rx_fin_seq (mod (+ v_0_rcv_nxt v_0_rx_fin_offset) 4294967296)))))
(assert
 (let (($x1841 (not v_0_rx_fin_done)))
 (or $x1841 (= v_0_rcv_nxt (mod (+ 1 v_0_rx_fin_seq) 4294967296)))))
(assert
 (let (($x1743 (= 0 v_0_rx_slot_00)))
 (or (not (and v_0_rx_fin_pending (>= 0 v_0_rx_fin_offset))) $x1743)))
(assert
 (let (($x1748 (= 0 v_0_rx_slot_01)))
 (or (not (and v_0_rx_fin_pending (>= 1 v_0_rx_fin_offset))) $x1748)))
(assert
 (let (($x1753 (= 0 v_0_rx_slot_02)))
 (or (not (and v_0_rx_fin_pending (>= 2 v_0_rx_fin_offset))) $x1753)))
(assert
 (let (($x1758 (= 0 v_0_rx_slot_03)))
 (or (not (and v_0_rx_fin_pending (>= 3 v_0_rx_fin_offset))) $x1758)))
(assert
 (let (($x1763 (= 0 v_0_rx_slot_04)))
 (or (not (and v_0_rx_fin_pending (>= 4 v_0_rx_fin_offset))) $x1763)))
(assert
 (let (($x1768 (= 0 v_0_rx_slot_05)))
 (or (not (and v_0_rx_fin_pending (>= 5 v_0_rx_fin_offset))) $x1768)))
(assert
 (let (($x1773 (= 0 v_0_rx_slot_06)))
 (or (not (and v_0_rx_fin_pending (>= 6 v_0_rx_fin_offset))) $x1773)))
(assert
 (let (($x1778 (= 0 v_0_rx_slot_07)))
 (or (not (and v_0_rx_fin_pending (>= 7 v_0_rx_fin_offset))) $x1778)))
(assert
 (let (($x1783 (= 0 v_0_rx_slot_08)))
 (or (not (and v_0_rx_fin_pending (>= 8 v_0_rx_fin_offset))) $x1783)))
(assert
 (let (($x1788 (= 0 v_0_rx_slot_09)))
 (or (not (and v_0_rx_fin_pending (>= 9 v_0_rx_fin_offset))) $x1788)))
(assert
 (let (($x1793 (= 0 v_0_rx_slot_10)))
 (or (not (and v_0_rx_fin_pending (>= 10 v_0_rx_fin_offset))) $x1793)))
(assert
 (let (($x1798 (= 0 v_0_rx_slot_11)))
 (or (not (and v_0_rx_fin_pending (>= 11 v_0_rx_fin_offset))) $x1798)))
(assert
 (let (($x1803 (= 0 v_0_rx_slot_12)))
 (or (not (and v_0_rx_fin_pending (>= 12 v_0_rx_fin_offset))) $x1803)))
(assert
 (let (($x1808 (= 0 v_0_rx_slot_13)))
 (or (not (and v_0_rx_fin_pending (>= 13 v_0_rx_fin_offset))) $x1808)))
(assert
 (let (($x1813 (= 0 v_0_rx_slot_14)))
 (or (not (and v_0_rx_fin_pending (>= 14 v_0_rx_fin_offset))) $x1813)))
(assert
 (let (($x1818 (= 0 v_0_rx_slot_15)))
 (or (not (and v_0_rx_fin_pending (>= 15 v_0_rx_fin_offset))) $x1818)))
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
 (and (<= 1000 v_0_rto_base_ms) (>= 60000 v_0_rto_base_ms) (>= v_0_rto_ms v_0_rto_base_ms) (>= 60000 v_0_rto_ms)))
(assert
 (let ((?x1936 (* 4.0 v_0_rttvar_ms)))
 (let ((?x526 (- 1.0)))
 (let ((?x555 (* ?x526 v_0_srtt_ms)))
 (let ((?x1939 (+ ?x555 (* ?x526 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x1936)))))
 (let ((?x1940 (to_int ?x1939)))
 (let ((?x311 (- 1)))
 (let ((?x1943 (ite (<= ?x1940 (- 1000)) (* ?x311 ?x1940) 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x1943) 60000 ?x1943) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x520 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x1958 (and (<= v_0_rtt_start_ms now_0) (<= 1 v_0_rtt_remaining) (>= 4 v_0_rtt_remaining) (>= ?x520 v_0_rtt_remaining) (<= ?x520 (mod (+ v_0_snd_nxt (* (- 1) v_0_snd_una)) 4294967296)))))
 (let (($x1950 (not v_0_rtt_active)))
 (or $x1950 $x1958)))))
(assert
 (let (($x1960 (= 0 v_0_rtt_remaining)))
 (or v_0_rtt_active $x1960)))
(assert
 true)
(assert
 (let (($x1967 (= v_0_rtt_last_ms (+ v_0_rtt_sample_at_ms (* (- 1) v_0_rtt_start_ms)))))
 (let (($x1965 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1963 (not v_0_rtt_sample_used)))
 (or $x1963 (and $x1965 v_0_rtt_measured $x1967))))))
(assert
 (and (<= 0 v_0_rtt_sample_at_ms) (<= v_0_rtt_sample_at_ms now_0)))
(assert
 (let ((?x1974 (to_real v_0_rtt_last_ms)))
 (let ((?x1988 (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x1974))))
 (let ((?x1976 (+ v_0_rtt_previous_srtt (* (- 1.0) ?x1974))))
 (let ((?x1980 (ite (>= ?x1976 0.0) ?x1976 (+ (* (- 1.0) v_0_rtt_previous_srtt) ?x1974))))
 (let ((?x550 (/ 1.0 4.0)))
 (let ((?x1984 (ite v_0_rtt_previous_measured (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* ?x550 ?x1980)) (* (/ 1.0 2.0) ?x1974))))
 (let (($x1991 (and (= v_0_rttvar_ms ?x1984) (= v_0_srtt_ms (ite v_0_rtt_previous_measured ?x1988 ?x1974)))))
 (let (($x1963 (not v_0_rtt_sample_used)))
 (or $x1963 $x1991))))))))))
(assert
 (and (<= 0 v_0_tx_time_00) (<= v_0_tx_time_00 now_0) (or (not (>= 0 v_0_rtx_buf)) (= 0 v_0_tx_time_00))))
(assert
 (and (<= 0 v_0_tx_time_01) (<= v_0_tx_time_01 now_0) (or (not (>= 1 v_0_rtx_buf)) (= 0 v_0_tx_time_01))))
(assert
 (and (<= 0 v_0_tx_time_02) (<= v_0_tx_time_02 now_0) (or (not (>= 2 v_0_rtx_buf)) (= 0 v_0_tx_time_02))))
(assert
 (and (<= 0 v_0_tx_time_03) (<= v_0_tx_time_03 now_0) (or (not (>= 3 v_0_rtx_buf)) (= 0 v_0_tx_time_03))))
(assert
 (and (<= 0 v_0_tx_time_04) (<= v_0_tx_time_04 now_0) (or (not (>= 4 v_0_rtx_buf)) (= 0 v_0_tx_time_04))))
(assert
 (and (<= 0 v_0_tx_time_05) (<= v_0_tx_time_05 now_0) (or (not (>= 5 v_0_rtx_buf)) (= 0 v_0_tx_time_05))))
(assert
 (and (<= 0 v_0_tx_time_06) (<= v_0_tx_time_06 now_0) (or (not (>= 6 v_0_rtx_buf)) (= 0 v_0_tx_time_06))))
(assert
 (and (<= 0 v_0_tx_time_07) (<= v_0_tx_time_07 now_0) (or (not (>= 7 v_0_rtx_buf)) (= 0 v_0_tx_time_07))))
(assert
 (and (<= 0 v_0_tx_time_08) (<= v_0_tx_time_08 now_0) (or (not (>= 8 v_0_rtx_buf)) (= 0 v_0_tx_time_08))))
(assert
 (and (<= 0 v_0_tx_time_09) (<= v_0_tx_time_09 now_0) (or (not (>= 9 v_0_rtx_buf)) (= 0 v_0_tx_time_09))))
(assert
 (and (<= 0 v_0_tx_time_10) (<= v_0_tx_time_10 now_0) (or (not (>= 10 v_0_rtx_buf)) (= 0 v_0_tx_time_10))))
(assert
 (and (<= 0 v_0_tx_time_11) (<= v_0_tx_time_11 now_0) (or (not (>= 11 v_0_rtx_buf)) (= 0 v_0_tx_time_11))))
(assert
 (and (<= 0 v_0_tx_time_12) (<= v_0_tx_time_12 now_0) (or (not (>= 12 v_0_rtx_buf)) (= 0 v_0_tx_time_12))))
(assert
 (and (<= 0 v_0_tx_time_13) (<= v_0_tx_time_13 now_0) (or (not (>= 13 v_0_rtx_buf)) (= 0 v_0_tx_time_13))))
(assert
 (and (<= 0 v_0_tx_time_14) (<= v_0_tx_time_14 now_0) (or (not (>= 14 v_0_rtx_buf)) (= 0 v_0_tx_time_14))))
(assert
 (and (<= 0 v_0_tx_time_15) (<= v_0_tx_time_15 now_0) (or (not (>= 15 v_0_rtx_buf)) (= 0 v_0_tx_time_15))))
(assert
 (and (<= 0 v_0_tx_fin_time) (<= v_0_tx_fin_time now_0)))
(assert
 (and (<= 0 v_0_tx_emit_count) (>= 4 v_0_tx_emit_count)))
(assert
 (and (<= 0 v_0_tx_eligible) (>= 4 v_0_tx_eligible)))
(assert
 (and (<= 0 v_0_tx_elapsed) (<= 0 v_0_tx_max_previous) (<= v_0_tx_max_previous now_0) (<= 1000 v_0_tx_previous_rto) (>= 60000 v_0_tx_previous_rto)))
(assert
 (let (($x2127 (and (>= v_0_tx_elapsed v_0_tx_previous_rto) (<= 1 v_0_tx_emit_count) (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x2121 (not v_0_tx_retransmitted)))
 (or $x2121 $x2127))))
(assert
 (let (($x2121 (not v_0_tx_retransmitted)))
 (or $x2121 (not v_0_tx_waiting))))
(assert
 (and (<= 0 v_0_tx_syn_time) (<= v_0_tx_syn_time now_0)))
(assert
 (not v_0_tx_syn_pending))
(assert
 (or v_0_tx_syn_pending (= 0 v_0_tx_syn_time)))
(assert
 true)
(assert
 (and (<= 1 v_0_ack_delay_ms) (>= 499 v_0_ack_delay_ms) (= 4 v_0_ack_rmss)))
(assert
 (= v_0_ack_pending active_0_delack))
(assert
 (and (<= 0 v_0_ack_bytes) (>= 7 v_0_ack_bytes) (<= 0 v_0_ack_full_segments) (>= 1 v_0_ack_full_segments)))
(assert
 (and (<= 0 v_0_ack_since_ms) (<= v_0_ack_since_ms now_0)))
(assert
 (let (($x2154 (not v_0_ack_pending)))
 (or $x2154 (and (<= 1 v_0_ack_bytes) (not v_0_rx_fin_done)))))
(assert
 (let (($x2161 (and (= 0 v_0_ack_bytes) (= 0 v_0_ack_full_segments) (= 0 v_0_ack_since_ms))))
 (or v_0_ack_pending $x2161)))
(assert
 (let (($x218 (not active_0_rtx)))
 (let (($x2002 (>= 1 v_0_rtx_buf)))
 (let (($x1834 (not v_0_fin_sent)))
 (let (($x2170 (and (= 0 v_0_snd_wnd) $x1834 (<= 1 (+ v_0_rtx_buf v_0_snd_buf)) $x2002 $x218)))
 (let (($x376 (not v_0_persist_active)))
 (let (($x2165 (and (<= 1 (+ v_0_rtx_buf (ite v_0_fin_sent 1 0))) $x376)))
 (let (($x2163 (= v_0_persist_active active_0_persist)))
 (and $x2163 (= active_0_rtx $x2165) (or $x376 $x2170))))))))))
(assert
 (let (($x376 (not v_0_persist_active)))
 (or $x376 (and (not v_0_rtt_active) (= 0 v_0_rtt_remaining)))))
(assert
 (and (<= 1000 v_0_persist_interval_ms) (>= 60000 v_0_persist_interval_ms) (<= 1000 v_0_persist_previous_interval_ms) (>= 60000 v_0_persist_previous_interval_ms) (<= 0 v_0_persist_probes) (<= 0 v_0_persist_elapsed_ms)))
(assert
 (and (<= 0 v_0_persist_since_ms) (<= v_0_persist_since_ms now_0) (<= 0 v_0_persist_last_ms) (<= v_0_persist_last_ms now_0) (<= 0 v_0_persist_deadline_ms)))
(assert
 (let (($x2188 (= 0 v_0_persist_probes)))
 (let ((?x2190 (+ (ite $x2188 v_0_persist_since_ms v_0_persist_last_ms) v_0_persist_interval_ms)))
 (let (($x376 (not v_0_persist_active)))
 (or $x376 (= v_0_persist_deadline_ms ?x2190))))))
(assert
 (let (($x2196 (= 1 v_0_rtx_buf)))
 (let (($x2194 (not v_0_persist_probe_sent)))
 (or $x2194 (and (>= v_0_persist_elapsed_ms v_0_persist_previous_interval_ms) $x2196)))))
(assert
 (let (($x2202 (= v_0_tx_time_00 v_0_persist_last_ms)))
 (let (($x2196 (= 1 v_0_rtx_buf)))
 (or (not (and v_0_persist_active (<= 1 v_0_persist_probes) $x2196)) $x2202))))
(assert
 (let (($x2188 (= 0 v_0_persist_probes)))
 (let (($x2207 (and (= 0 v_0_persist_since_ms) (= 0 v_0_persist_last_ms) (= 0 v_0_persist_deadline_ms) $x2188)))
 (or v_0_persist_active $x2207))))
(assert
 (and (<= 4 v_0_cc_initial_window) (>= 16 v_0_cc_initial_window) (<= 8 v_0_cc_initial_threshold)))
(assert
 (and (<= 4 v_0_cc_cwnd) (<= 8 v_0_cc_ssthresh) (<= 0 v_0_cc_ca_credit) (not (>= v_0_cc_ca_credit v_0_cc_cwnd)) (<= 0 v_0_cc_growth) (>= 4 v_0_cc_growth) (<= 0 v_0_cc_acked) (>= 16 v_0_cc_acked) (<= 0 v_0_cc_threshold_updates)))
(assert
 (and (<= 0 v_0_cc_new_sent) (<= v_0_cc_new_sent v_0_cc_send_budget)))
(assert
 (let (($x1996 (not (>= 0 v_0_rtx_buf))))
 (let (($x2231 (not v_0_cc_rto_00)))
 (or $x2231 $x1996))))
(assert
 (let (($x2002 (>= 1 v_0_rtx_buf)))
 (let (($x2003 (not $x2002)))
 (let (($x2233 (not v_0_cc_rto_01)))
 (or $x2233 $x2003)))))
(assert
 (let (($x2010 (not (>= 2 v_0_rtx_buf))))
 (let (($x2235 (not v_0_cc_rto_02)))
 (or $x2235 $x2010))))
(assert
 (let (($x2017 (not (>= 3 v_0_rtx_buf))))
 (let (($x2237 (not v_0_cc_rto_03)))
 (or $x2237 $x2017))))
(assert
 (let (($x2024 (not (>= 4 v_0_rtx_buf))))
 (let (($x2239 (not v_0_cc_rto_04)))
 (or $x2239 $x2024))))
(assert
 (let (($x2031 (not (>= 5 v_0_rtx_buf))))
 (let (($x2241 (not v_0_cc_rto_05)))
 (or $x2241 $x2031))))
(assert
 (let (($x2038 (not (>= 6 v_0_rtx_buf))))
 (let (($x2243 (not v_0_cc_rto_06)))
 (or $x2243 $x2038))))
(assert
 (let (($x2045 (not (>= 7 v_0_rtx_buf))))
 (let (($x2245 (not v_0_cc_rto_07)))
 (or $x2245 $x2045))))
(assert
 (let (($x2052 (not (>= 8 v_0_rtx_buf))))
 (let (($x2247 (not v_0_cc_rto_08)))
 (or $x2247 $x2052))))
(assert
 (let (($x2059 (not (>= 9 v_0_rtx_buf))))
 (let (($x2249 (not v_0_cc_rto_09)))
 (or $x2249 $x2059))))
(assert
 (let (($x2066 (not (>= 10 v_0_rtx_buf))))
 (let (($x2251 (not v_0_cc_rto_10)))
 (or $x2251 $x2066))))
(assert
 (let (($x2073 (not (>= 11 v_0_rtx_buf))))
 (let (($x2253 (not v_0_cc_rto_11)))
 (or $x2253 $x2073))))
(assert
 (let (($x2080 (not (>= 12 v_0_rtx_buf))))
 (let (($x2255 (not v_0_cc_rto_12)))
 (or $x2255 $x2080))))
(assert
 (let (($x2087 (not (>= 13 v_0_rtx_buf))))
 (let (($x2257 (not v_0_cc_rto_13)))
 (or $x2257 $x2087))))
(assert
 (let (($x2094 (not (>= 14 v_0_rtx_buf))))
 (let (($x2259 (not v_0_cc_rto_14)))
 (or $x2259 $x2094))))
(assert
 (let (($x2101 (not (>= 15 v_0_rtx_buf))))
 (let (($x2261 (not v_0_cc_rto_15)))
 (or $x2261 $x2101))))
(assert
 (and (<= 0 v_0_fr_dupacks) (<= 0 v_0_fr_entries) (<= 0 v_0_fr_emit_count) (>= 4 v_0_fr_emit_count) (<= 0 v_0_fr_last_window) (>= 65535 v_0_fr_last_window)))
(assert
 (let (($x376 (not v_0_persist_active)))
 (let (($x374 (<= 1 v_0_rtx_buf)))
 (let (($x436 (not v_0_fr_active)))
 (or $x436 (and (<= 3 v_0_fr_dupacks) $x374 $x376))))))
(assert
 (let (($x2121 (not v_0_tx_retransmitted)))
 (let (($x2283 (= v_0_retries v_0_fr_before_retries)))
 (let (($x2281 (= v_0_rto_ms v_0_fr_before_rto)))
 (let (($x2279 (= v_0_snd_nxt v_0_fr_before_nxt)))
 (let (($x2284 (and v_0_fr_entered (= 3 v_0_fr_dupacks) (<= 1 v_0_fr_emit_count) $x2279 $x2281 $x2283 $x2121)))
 (let (($x2275 (not v_0_fr_retransmitted)))
 (or $x2275 $x2284))))))))
(assert
 (let (($x2292 (and (= v_0_fr_last_window v_0_fr_before_wire_window) (= v_0_fr_window_valid v_0_fr_before_window_valid))))
 (or (not v_0_fr_window_ignored) $x2292)))
(assert
 (let (($x2294 (not v_0_fr_entered)))
 (or v_0_fr_retransmitted $x2294)))
(assert
 (let (($x2294 (not v_0_fr_entered)))
 (or $x2294 (= v_0_cc_cwnd (+ 12 v_0_cc_ssthresh)))))
(assert
 (let (($x2300 (not v_0_fr_exited)))
 (or $x2300 (and (= v_0_cc_cwnd v_0_cc_ssthresh) (= 0 v_0_cc_ca_credit)))))
(assert
 (and (<= 0 v_0_idle_last_data_ms) (<= v_0_idle_last_data_ms v_0_idle_event_ms) (<= v_0_idle_event_ms now_0) (<= 0 v_0_idle_elapsed_ms) (<= 0 v_0_idle_restart_count)))
(assert
 (or (not v_0_idle_data_emitted) (= v_0_idle_last_data_ms v_0_idle_event_ms)))
(assert
 (let (($x2302 (= 0 v_0_cc_ca_credit)))
 (let (($x2327 (= v_0_cc_ssthresh v_0_idle_before_threshold)))
 (let ((?x2324 (ite (<= v_0_cc_initial_window v_0_idle_before_cwnd) v_0_cc_initial_window v_0_idle_before_cwnd)))
 (let (($x2328 (and (not (>= v_0_idle_before_rto v_0_idle_elapsed_ms)) (= v_0_cc_cwnd ?x2324) $x2327 $x2302)))
 (let (($x2318 (not v_0_idle_restart)))
 (or $x2318 $x2328)))))))
(assert
 (and (<= 0 v_0_lt_epoch_bytes) (>= 8 v_0_lt_epoch_bytes) (<= v_0_lt_epoch_bytes v_0_rtx_buf) (<= 0 v_0_lt_epoch_packets) (>= 2 v_0_lt_epoch_packets) (<= v_0_lt_epoch_packets v_0_fr_dupacks) (>= v_0_lt_epoch_bytes v_0_lt_epoch_packets) (<= v_0_lt_epoch_bytes (* 4 v_0_lt_epoch_packets)) (<= 0 v_0_lt_loss_flight)))
(assert
 (let (($x2351 (= v_0_cc_cwnd v_0_lt_before_cwnd)))
 (let (($x1834 (not v_0_fin_sent)))
 (let (($x436 (not v_0_fr_active)))
 (let (($x2361 (and v_0_fr_duplicate (<= 1 v_0_fr_dupacks) (>= 2 v_0_fr_dupacks) $x436 $x1834 (<= 1 v_0_lt_take) (>= 4 v_0_lt_take) $x2351 (= v_0_rtx_buf (+ v_0_lt_before_flight v_0_lt_take)) (<= v_0_rtx_buf v_0_snd_wnd) (<= v_0_rtx_buf (+ 8 v_0_cc_cwnd)) (= v_0_snd_nxt (mod (+ v_0_lt_before_nxt v_0_lt_take) 4294967296)))))
 (let (($x2343 (not v_0_lt_emitted)))
 (or $x2343 $x2361)))))))
(assert
 (let (($x2367 (= v_0_lt_loss_flight (+ v_0_fr_before_flight (* (- 1) v_0_lt_before_bytes)))))
 (let (($x2294 (not v_0_fr_entered)))
 (or $x2294 $x2367))))
(assert
 (= 124 choice_0))
(assert
 (= 5 state_0))
(assert
 (= 5 state_1))
(assert
 (or (not (>= 1 v_1_rx_slot_09))))
(check-sat)
