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
(declare-fun input_0_net.fin_segment_window () Int)
(declare-fun due_1_persist () Int)
(declare-fun due_1_delack () Int)
(declare-fun v_0_msl_ms () Int)
(declare-fun v_0_rx_fin_offset () Int)
(declare-fun v_0_rx_fin_pending () Bool)
(declare-fun v_0_rx_fin_done () Bool)
(declare-fun due_1_time_wait () Int)
(declare-fun due_1_user () Int)
(declare-fun due_1_rtx () Int)
(declare-fun active_1_persist () Bool)
(declare-fun active_1_delack () Bool)
(declare-fun active_1_time_wait () Bool)
(declare-fun active_1_user () Bool)
(declare-fun active_1_rtx () Bool)
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
(declare-fun v_1_rtt_start_new () Bool)
(declare-fun v_0_rtt_remaining () Int)
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
(declare-fun v_1_rx_fin_consumed () Bool)
(declare-fun v_1_rx_fin_done () Bool)
(declare-fun v_1_rx_fin_offset () Int)
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
(declare-fun v_1_rx_acceptable () Bool)
(declare-fun v_1_rx_advance () Int)
(declare-fun v_0_take () Int)
(declare-fun v_1_take () Int)
(declare-fun v_1_snd_wnd () Int)
(declare-fun v_1_local_window () Int)
(declare-fun v_1_msl_ms () Int)
(declare-fun v_0_user_timeout_ms () Int)
(declare-fun v_1_user_timeout_ms () Int)
(declare-fun v_0_active_open () Bool)
(declare-fun v_1_active_open () Bool)
(declare-fun v_0_retries () Int)
(declare-fun v_1_retries () Int)
(declare-fun v_1_rto_ms () Int)
(declare-fun v_0_tx_flags () String)
(declare-fun v_1_tx_flags () String)
(declare-fun v_0_rx_advance () Int)
(declare-fun v_0_ack_delta () Int)
(declare-fun v_0_rtt_sample_was_ambiguous () Bool)
(declare-fun v_0_rtt_sample_used () Bool)
(declare-fun v_0_tx_retransmitted () Bool)
(declare-fun v_0_tx_waiting () Bool)
(declare-fun v_0_tx_syn_time () Int)
(declare-fun v_0_tx_syn_pending () Bool)
(declare-fun v_0_ack_pending () Bool)
(declare-fun v_0_ack_full_segments () Int)
(declare-fun v_0_ack_bytes () Int)
(declare-fun v_0_ack_since_ms () Int)
(declare-fun v_0_persist_probe_sent () Bool)
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
 true)
(assert
 true)
(assert
 (>= now_0 0))
(assert
 (let (($x186 (not active_0_rtx)))
 (or $x186 (>= due_0_rtx now_0))))
(assert
 (let (($x191 (not active_0_user)))
 (or $x191 (>= due_0_user now_0))))
(assert
 (let (($x196 (not active_0_time_wait)))
 (or $x196 (>= due_0_time_wait now_0))))
(assert
 (let (($x201 (not active_0_delack)))
 (or $x201 (>= due_0_delack now_0))))
(assert
 (let (($x206 (not active_0_persist)))
 (or $x206 (>= due_0_persist now_0))))
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
 (let (($x729 (not v_0_rtt_ambiguous)))
 (let ((?x726 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let ((?x291 (mod (+ input_0_net.fin_segment_ack (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x727 (>= ?x291 ?x726)))
 (let ((?x338 (ite v_0_fin_sent 1 0)))
 (let ((?x339 (+ v_0_rtx_buf ?x338)))
 (let (($x340 (<= ?x291 ?x339)))
 (let (($x319 (<= 1 ?x291)))
 (let ((?x278 (- 1)))
 (let ((?x305 (+ ?x278 v_0_local_window)))
 (let (($x310 (<= (mod (+ input_0_net.fin_segment_seq (* ?x278 v_0_rcv_nxt)) 4294967296) ?x305)))
 (let (($x301 (<= 1 v_0_local_window)))
 (let ((?x302 (* ?x278 v_0_rcv_nxt)))
 (let ((?x304 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data ?x302) 4294967296)))
 (let (($x306 (<= ?x304 ?x305)))
 (let (($x312 (or (and $x301 $x306) (and $x301 $x310))))
 (let (($x730 (and v_0_rtt_active $x312 $x319 $x340 $x727 $x729)))
 (let ((?x745 (ite $x730 (+ now_1 (* ?x278 v_0_rtt_start_ms)) v_0_rtt_last_ms)))
 (let ((?x746 (to_real ?x745)))
 (let ((?x770 (/ 1.0 2.0)))
 (let ((?x759 (+ v_0_srtt_ms (* (- 1.0) ?x746))))
 (let ((?x766 (ite $x730 (ite (>= ?x759 0.0) ?x759 (+ (* (- 1.0) v_0_srtt_ms) ?x746)) v_0_rtt_error_ms)))
 (let ((?x757 (/ 1.0 4.0)))
 (let ((?x772 (ite v_0_rtt_measured (+ (* (/ 3.0 4.0) v_0_rttvar_ms) (* ?x757 ?x766)) (* ?x770 ?x746))))
 (let ((?x773 (ite $x730 ?x772 v_0_rttvar_ms)))
 (let ((?x733 (- 1.0)))
 (let ((?x749 (ite v_0_rtt_measured (+ (* (/ 7.0 8.0) v_0_srtt_ms) (* (/ 1.0 8.0) ?x746)) ?x746)))
 (let ((?x750 (ite $x730 ?x749 v_0_srtt_ms)))
 (let ((?x778 (+ (* ?x733 ?x750) (* ?x733 (ite (<= ?x773 ?x757) 1.0 (* 4.0 ?x773))))))
 (let ((?x779 (to_int ?x778)))
 (let ((?x783 (* ?x278 ?x779)))
 (let ((?x784 (ite (<= ?x779 (- 1000)) ?x783 1000)))
 (let ((?x786 (ite (<= 60000 ?x784) 60000 ?x784)))
 (let ((?x788 (ite $x730 ?x786 v_0_rto_ms)))
 (let (($x1513 (not v_0_persist_active)))
 (let ((?x813 (ite (<= 0 v_0_rtx_buf) v_0_rtx_buf 0)))
 (let ((?x811 (ite (<= v_0_rtx_buf ?x291) 0 (+ v_0_rtx_buf (* ?x278 ?x291)))))
 (let (($x685 (and $x312 $x319 $x340)))
 (let ((?x816 (ite $x685 (ite (<= ?x811 ?x813) ?x811 ?x813) v_0_rtx_buf)))
 (let (($x1164 (= 0 ?x816)))
 (let (($x1165 (or v_0_persist_active $x1164)))
 (let (($x1162 (>= 1 ?x816)))
 (let (($x1161 (<= 1 (+ ?x816 v_0_snd_buf))))
 (let (($x1115 (and (not (and $x312 $x319 $x340 v_0_fin_sent (= ?x291 ?x339))) v_0_fin_sent)))
 (let (($x1159 (not $x1115)))
 (let (($x833 (<= 2147483648 (mod (+ input_0_net.fin_segment_ack (* ?x278 v_0_snd_wl2)) 4294967296))))
 (let (($x829 (= v_0_snd_wl1 input_0_net.fin_segment_seq)))
 (let ((?x823 (mod (+ input_0_net.fin_segment_seq (* ?x278 v_0_snd_wl1)) 4294967296)))
 (let (($x836 (or (and (not (<= ?x823 0)) (not (<= 2147483648 ?x823))) (and $x829 (not $x833)))))
 (let (($x837 (and $x312 $x340 $x836)))
 (let ((?x839 (ite $x837 input_0_net.fin_segment_window v_0_snd_wnd)))
 (let (($x1158 (= 0 ?x839)))
 (let (($x1514 (and $x1158 $x1159 $x1161 $x1162 $x1165 $x1513)))
 (let ((?x1526 (ite $x1514 ?x788 v_0_persist_interval_ms)))
 (let ((?x1542 (+ now_1 ?x1526)))
 (let (($x1602 (= due_1_delack due_0_delack)))
 (let ((?x1598 (+ now_1 (* 2 v_0_msl_ms))))
 (let (($x341 (= ?x291 ?x339)))
 (let (($x353 (not v_0_rx_fin_pending)))
 (let (($x352 (not v_0_rx_fin_done)))
 (let (($x349 (and (>= ?x291 (+ 1 v_0_rtx_buf ?x338)) (>= 2147483647 ?x291))))
 (let (($x350 (not $x349)))
 (let (($x354 (and $x312 $x350 $x352 $x353 $x301 $x306)))
 (let ((?x357 (ite $x354 ?x304 v_0_rx_fin_offset)))
 (let (($x355 (or v_0_rx_fin_pending $x354)))
 (let (($x657 (and $x355 (>= 15 ?x357))))
 (let ((?x644 (mod (+ 15 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x649 (+ input_0_net.fin_segment_data (* ?x278 ?x644))))
 (let (($x647 (<= input_0_net.fin_segment_data ?x644)))
 (let (($x642 (<= v_0_rcv_buf 0)))
 (let (($x641 (= 0 v_0_rx_slot_15)))
 (let (($x646 (and $x312 $x350 $x352 $x641 $x642 (<= ?x644 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x654 (ite $x646 (ite (or $x647 (<= ?x649 1)) (ite $x647 0 ?x649) 1) v_0_rx_slot_15)))
 (let (($x658 (or (= ?x654 0) $x657)))
 (let (($x639 (and $x355 (>= 14 ?x357))))
 (let ((?x626 (mod (+ 14 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x631 (+ input_0_net.fin_segment_data (* ?x278 ?x626))))
 (let (($x629 (<= input_0_net.fin_segment_data ?x626)))
 (let (($x624 (<= v_0_rcv_buf 1)))
 (let (($x623 (= 0 v_0_rx_slot_14)))
 (let (($x628 (and $x312 $x350 $x352 $x623 $x624 (<= ?x626 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x636 (ite $x628 (ite (or $x629 (<= ?x631 1)) (ite $x629 0 ?x631) 1) v_0_rx_slot_14)))
 (let (($x640 (or (= ?x636 0) $x639)))
 (let (($x621 (and $x355 (>= 13 ?x357))))
 (let ((?x608 (mod (+ 13 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x613 (+ input_0_net.fin_segment_data (* ?x278 ?x608))))
 (let (($x611 (<= input_0_net.fin_segment_data ?x608)))
 (let (($x606 (<= v_0_rcv_buf 2)))
 (let (($x605 (= 0 v_0_rx_slot_13)))
 (let (($x610 (and $x312 $x350 $x352 $x605 $x606 (<= ?x608 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x618 (ite $x610 (ite (or $x611 (<= ?x613 1)) (ite $x611 0 ?x613) 1) v_0_rx_slot_13)))
 (let (($x622 (or (= ?x618 0) $x621)))
 (let (($x603 (and $x355 (>= 12 ?x357))))
 (let ((?x590 (mod (+ 12 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x595 (+ input_0_net.fin_segment_data (* ?x278 ?x590))))
 (let (($x593 (<= input_0_net.fin_segment_data ?x590)))
 (let (($x588 (<= v_0_rcv_buf 3)))
 (let (($x587 (= 0 v_0_rx_slot_12)))
 (let (($x592 (and $x312 $x350 $x352 $x587 $x588 (<= ?x590 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x600 (ite $x592 (ite (or $x593 (<= ?x595 1)) (ite $x593 0 ?x595) 1) v_0_rx_slot_12)))
 (let (($x604 (or (= ?x600 0) $x603)))
 (let ((?x662 (ite $x604 12 (ite $x622 13 (ite $x640 14 (ite $x658 15 16))))))
 (let (($x585 (and $x355 (>= 11 ?x357))))
 (let ((?x572 (mod (+ 11 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x577 (+ input_0_net.fin_segment_data (* ?x278 ?x572))))
 (let (($x575 (<= input_0_net.fin_segment_data ?x572)))
 (let (($x570 (<= v_0_rcv_buf 4)))
 (let (($x569 (= 0 v_0_rx_slot_11)))
 (let (($x574 (and $x312 $x350 $x352 $x569 $x570 (<= ?x572 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x582 (ite $x574 (ite (or $x575 (<= ?x577 1)) (ite $x575 0 ?x577) 1) v_0_rx_slot_11)))
 (let (($x586 (or (= ?x582 0) $x585)))
 (let (($x567 (and $x355 (>= 10 ?x357))))
 (let ((?x554 (mod (+ 10 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x559 (+ input_0_net.fin_segment_data (* ?x278 ?x554))))
 (let (($x557 (<= input_0_net.fin_segment_data ?x554)))
 (let (($x552 (<= v_0_rcv_buf 5)))
 (let (($x551 (= 0 v_0_rx_slot_10)))
 (let (($x556 (and $x312 $x350 $x352 $x551 $x552 (<= ?x554 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x564 (ite $x556 (ite (or $x557 (<= ?x559 1)) (ite $x557 0 ?x559) 1) v_0_rx_slot_10)))
 (let (($x568 (or (= ?x564 0) $x567)))
 (let (($x549 (and $x355 (>= 9 ?x357))))
 (let ((?x536 (mod (+ 9 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x541 (+ input_0_net.fin_segment_data (* ?x278 ?x536))))
 (let (($x539 (<= input_0_net.fin_segment_data ?x536)))
 (let (($x534 (<= v_0_rcv_buf 6)))
 (let (($x533 (= 0 v_0_rx_slot_09)))
 (let (($x538 (and $x312 $x350 $x352 $x533 $x534 (<= ?x536 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x546 (ite $x538 (ite (or $x539 (<= ?x541 1)) (ite $x539 0 ?x541) 1) v_0_rx_slot_09)))
 (let (($x550 (or (= ?x546 0) $x549)))
 (let (($x531 (and $x355 (>= 8 ?x357))))
 (let ((?x518 (mod (+ 8 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x523 (+ input_0_net.fin_segment_data (* ?x278 ?x518))))
 (let (($x521 (<= input_0_net.fin_segment_data ?x518)))
 (let (($x516 (<= v_0_rcv_buf 7)))
 (let (($x515 (= 0 v_0_rx_slot_08)))
 (let (($x520 (and $x312 $x350 $x352 $x515 $x516 (<= ?x518 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x528 (ite $x520 (ite (or $x521 (<= ?x523 1)) (ite $x521 0 ?x523) 1) v_0_rx_slot_08)))
 (let (($x532 (or (= ?x528 0) $x531)))
 (let ((?x666 (ite $x532 8 (ite $x550 9 (ite $x568 10 (ite $x586 11 ?x662))))))
 (let (($x513 (and $x355 (>= 7 ?x357))))
 (let ((?x500 (mod (+ 7 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x505 (+ input_0_net.fin_segment_data (* ?x278 ?x500))))
 (let (($x503 (<= input_0_net.fin_segment_data ?x500)))
 (let (($x497 (<= v_0_rcv_buf 8)))
 (let (($x495 (= 0 v_0_rx_slot_07)))
 (let (($x502 (and $x312 $x350 $x352 $x495 $x497 (<= ?x500 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x510 (ite $x502 (ite (or $x503 (<= ?x505 1)) (ite $x503 0 ?x505) 1) v_0_rx_slot_07)))
 (let (($x514 (or (= ?x510 0) $x513)))
 (let (($x493 (and $x355 (>= 6 ?x357))))
 (let ((?x480 (mod (+ 6 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x485 (+ input_0_net.fin_segment_data (* ?x278 ?x480))))
 (let (($x483 (<= input_0_net.fin_segment_data ?x480)))
 (let (($x477 (<= v_0_rcv_buf 9)))
 (let (($x475 (= 0 v_0_rx_slot_06)))
 (let (($x482 (and $x312 $x350 $x352 $x475 $x477 (<= ?x480 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x490 (ite $x482 (ite (or $x483 (<= ?x485 1)) (ite $x483 0 ?x485) 1) v_0_rx_slot_06)))
 (let (($x494 (or (= ?x490 0) $x493)))
 (let (($x473 (and $x355 (>= 5 ?x357))))
 (let ((?x460 (mod (+ 5 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x465 (+ input_0_net.fin_segment_data (* ?x278 ?x460))))
 (let (($x463 (<= input_0_net.fin_segment_data ?x460)))
 (let (($x457 (<= v_0_rcv_buf 10)))
 (let (($x455 (= 0 v_0_rx_slot_05)))
 (let (($x462 (and $x312 $x350 $x352 $x455 $x457 (<= ?x460 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x470 (ite $x462 (ite (or $x463 (<= ?x465 1)) (ite $x463 0 ?x465) 1) v_0_rx_slot_05)))
 (let (($x474 (or (= ?x470 0) $x473)))
 (let (($x453 (and $x355 (>= 4 ?x357))))
 (let ((?x440 (mod (+ 4 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x445 (+ input_0_net.fin_segment_data (* ?x278 ?x440))))
 (let (($x443 (<= input_0_net.fin_segment_data ?x440)))
 (let (($x437 (<= v_0_rcv_buf 11)))
 (let (($x435 (= 0 v_0_rx_slot_04)))
 (let (($x442 (and $x312 $x350 $x352 $x435 $x437 (<= ?x440 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x450 (ite $x442 (ite (or $x443 (<= ?x445 1)) (ite $x443 0 ?x445) 1) v_0_rx_slot_04)))
 (let (($x454 (or (= ?x450 0) $x453)))
 (let ((?x670 (ite $x454 4 (ite $x474 5 (ite $x494 6 (ite $x514 7 ?x666))))))
 (let (($x433 (and $x355 (>= 3 ?x357))))
 (let ((?x420 (mod (+ 3 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x425 (+ input_0_net.fin_segment_data (* ?x278 ?x420))))
 (let (($x423 (<= input_0_net.fin_segment_data ?x420)))
 (let (($x417 (<= v_0_rcv_buf 12)))
 (let (($x415 (= 0 v_0_rx_slot_03)))
 (let (($x422 (and $x312 $x350 $x352 $x415 $x417 (<= ?x420 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x430 (ite $x422 (ite (or $x423 (<= ?x425 1)) (ite $x423 0 ?x425) 1) v_0_rx_slot_03)))
 (let (($x434 (or (= ?x430 0) $x433)))
 (let (($x413 (and $x355 (>= 2 ?x357))))
 (let ((?x400 (mod (+ 2 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x405 (+ input_0_net.fin_segment_data (* ?x278 ?x400))))
 (let (($x403 (<= input_0_net.fin_segment_data ?x400)))
 (let (($x397 (<= v_0_rcv_buf 13)))
 (let (($x395 (= 0 v_0_rx_slot_02)))
 (let (($x402 (and $x312 $x350 $x352 $x395 $x397 (<= ?x400 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x410 (ite $x402 (ite (or $x403 (<= ?x405 1)) (ite $x403 0 ?x405) 1) v_0_rx_slot_02)))
 (let (($x414 (or (= ?x410 0) $x413)))
 (let (($x393 (and $x355 (>= 1 ?x357))))
 (let ((?x380 (mod (+ 1 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x385 (+ input_0_net.fin_segment_data (* ?x278 ?x380))))
 (let (($x383 (<= input_0_net.fin_segment_data ?x380)))
 (let (($x378 (<= v_0_rcv_buf 14)))
 (let (($x376 (= 0 v_0_rx_slot_01)))
 (let (($x382 (and $x312 $x350 $x352 $x376 $x378 (<= ?x380 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x390 (ite $x382 (ite (or $x383 (<= ?x385 1)) (ite $x383 0 ?x385) 1) v_0_rx_slot_01)))
 (let (($x391 (= ?x390 0)))
 (let (($x394 (or $x391 $x393)))
 (let ((?x673 (ite $x394 1 (ite $x414 2 (ite $x434 3 ?x670)))))
 (let (($x374 (and $x355 (>= 0 ?x357))))
 (let ((?x281 (mod (+ v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x366 (+ input_0_net.fin_segment_data (* ?x278 ?x281))))
 (let (($x364 (<= input_0_net.fin_segment_data ?x281)))
 (let (($x360 (<= v_0_rcv_buf 15)))
 (let (($x358 (= 0 v_0_rx_slot_00)))
 (let (($x363 (and $x312 $x350 $x352 $x358 $x360 (<= ?x281 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x371 (ite $x363 (ite (or $x364 (<= ?x366 1)) (ite $x364 0 ?x366) 1) v_0_rx_slot_00)))
 (let (($x372 (= ?x371 0)))
 (let (($x375 (or $x372 $x374)))
 (let ((?x674 (ite $x375 0 ?x673)))
 (let ((?x677 (ite $x355 (+ ?x357 (* ?x278 ?x674)) ?x357)))
 (let (($x678 (= 0 ?x677)))
 (let (($x681 (and $x355 $x352 $x678 $x312 $x319 $x340 v_0_fin_sent $x341)))
 (let (($x1595 (= due_1_user due_0_user)))
 (let ((?x1587 (ite (<= (- 999.0) ?x778) 1000 ?x783)))
 (let (($x1562 (and $x312 $x319 $x340 (<= 1 (+ ?x816 (ite $x1115 1 0))))))
 (let (($x1560 (and (not (and $x312 $x319 $x340 (= 0 (+ ?x816 (ite $x1115 1 0))))) active_0_rtx)))
 (let (($x682 (not $x681)))
 (let (($x1166 (and $x1158 $x1159 $x1161 $x1162 $x1165)))
 (let (($x1167 (not $x1166)))
 (let (($x1564 (and $x1167 $x682 (or $x1560 $x1562))))
 (let (($x1567 (and v_0_persist_active $x1167 (<= 1 ?x816) (not $x1564))))
 (let ((?x1592 (ite (or $x1562 $x1567) (+ now_1 (ite $x730 (ite (<= 60000 ?x1587) 60000 ?x1587) v_0_rto_ms)) due_0_rtx)))
 (let (($x1581 (= active_1_persist (and $x1158 $x1159 $x1161 $x1162 $x1165 (or active_0_persist $x1514)))))
 (let (($x1577 (not active_1_delack)))
 (let (($x1553 (= v_1_persist_elapsed_ms v_0_persist_elapsed_ms)))
 (let (($x1546 (= v_1_persist_deadline_ms (ite $x1166 (ite $x1514 ?x1542 v_0_persist_deadline_ms) 0))))
 (let (($x1536 (= v_1_persist_since_ms (ite $x1166 (ite $x1514 now_1 v_0_persist_since_ms) 0))))
 (let (($x1531 (= v_1_persist_previous_interval_ms v_0_persist_previous_interval_ms)))
 (let (($x1523 (not v_1_persist_probe_new)))
 (let (($x1521 (not v_1_persist_probe_sent)))
 (let (($x1519 (not v_1_persist_first)))
 (let (($x1517 (= v_1_persist_was_active v_0_persist_active)))
 (let (($x1507 (not v_1_ack_defer_now)))
 (let (($x1505 (not v_1_ack_defer_candidate)))
 (let (($x1503 (= v_1_ack_rmss v_0_ack_rmss)))
 (let (($x1500 (= v_1_ack_delay_ms v_0_ack_delay_ms)))
 (let (($x1497 (= v_1_ack_full_segments 0)))
 (let (($x1495 (= v_1_ack_bytes 0)))
 (let (($x1493 (= v_1_ack_since_ms 0)))
 (let (($x1491 (not v_1_ack_pending)))
 (let (($x1489 (not v_1_syn_timeout_eligible)))
 (let (($x1487 (not v_1_tx_syn_pending)))
 (let (($x1485 (= v_1_tx_syn_time 0)))
 (let (($x1483 (not v_1_tx_waiting)))
 (let (($x1481 (= v_1_tx_is_fin v_0_tx_is_fin)))
 (let (($x1478 (= v_1_tx_previous_rto v_0_tx_previous_rto)))
 (let (($x1475 (= v_1_tx_elapsed v_0_tx_elapsed)))
 (let (($x1472 (not v_1_tx_retransmitted)))
 (let (($x1470 (= v_1_tx_max_previous v_0_tx_max_previous)))
 (let (($x1467 (= v_1_tx_eligible v_0_tx_eligible)))
 (let (($x1464 (= v_1_tx_emit_count v_0_tx_emit_count)))
 (let ((?x1456 (ite (or $x1164 (and $x312 $x319 $x340 (not (= 0 ?x291))) (>= 15 ?x816)) 0 v_0_tx_time_15)))
 (let (($x1215 (and $x312 $x319 $x340 (not (= 0 ?x291)))))
 (let ((?x1451 (ite (or $x1164 (>= 14 ?x816)) 0 (ite $x1215 (ite (= 1 ?x291) v_0_tx_time_15 0) v_0_tx_time_14))))
 (let (($x1216 (= 1 ?x291)))
 (let ((?x1443 (ite $x1215 (ite $x1216 v_0_tx_time_14 (ite (= 2 ?x291) v_0_tx_time_15 0)) v_0_tx_time_13)))
 (let (($x1218 (= 2 ?x291)))
 (let ((?x1434 (ite $x1216 v_0_tx_time_13 (ite $x1218 v_0_tx_time_14 (ite (= 3 ?x291) v_0_tx_time_15 0)))))
 (let (($x1437 (= v_1_tx_time_12 (ite (or $x1164 (>= 12 ?x816)) 0 (ite $x1215 ?x1434 v_0_tx_time_12)))))
 (let (($x1220 (= 3 ?x291)))
 (let ((?x1424 (ite $x1218 v_0_tx_time_13 (ite $x1220 v_0_tx_time_14 (ite (= 4 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1427 (ite (or $x1164 (>= 11 ?x816)) 0 (ite $x1215 (ite $x1216 v_0_tx_time_12 ?x1424) v_0_tx_time_11))))
 (let (($x1222 (= 4 ?x291)))
 (let ((?x1413 (ite $x1220 v_0_tx_time_13 (ite $x1222 v_0_tx_time_14 (ite (= 5 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1416 (ite $x1215 (ite $x1216 v_0_tx_time_11 (ite $x1218 v_0_tx_time_12 ?x1413)) v_0_tx_time_10)))
 (let (($x1224 (= 5 ?x291)))
 (let ((?x1401 (ite $x1222 v_0_tx_time_13 (ite $x1224 v_0_tx_time_14 (ite (= 6 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1404 (ite $x1216 v_0_tx_time_10 (ite $x1218 v_0_tx_time_11 (ite $x1220 v_0_tx_time_12 ?x1401)))))
 (let (($x1407 (= v_1_tx_time_09 (ite (or (>= 9 ?x816) $x1164) 0 (ite $x1215 ?x1404 v_0_tx_time_09)))))
 (let (($x1226 (= 6 ?x291)))
 (let ((?x1388 (ite $x1224 v_0_tx_time_13 (ite $x1226 v_0_tx_time_14 (ite (= 7 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1391 (ite $x1218 v_0_tx_time_10 (ite $x1220 v_0_tx_time_11 (ite $x1222 v_0_tx_time_12 ?x1388)))))
 (let ((?x1394 (ite (or $x1164 (>= 8 ?x816)) 0 (ite $x1215 (ite $x1216 v_0_tx_time_09 ?x1391) v_0_tx_time_08))))
 (let (($x1228 (= 7 ?x291)))
 (let ((?x1374 (ite $x1226 v_0_tx_time_13 (ite $x1228 v_0_tx_time_14 (ite (= 8 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1377 (ite $x1220 v_0_tx_time_10 (ite $x1222 v_0_tx_time_11 (ite $x1224 v_0_tx_time_12 ?x1374)))))
 (let ((?x1380 (ite $x1215 (ite $x1216 v_0_tx_time_08 (ite $x1218 v_0_tx_time_09 ?x1377)) v_0_tx_time_07)))
 (let (($x1230 (= 8 ?x291)))
 (let ((?x1359 (ite $x1228 v_0_tx_time_13 (ite $x1230 v_0_tx_time_14 (ite (= 9 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1362 (ite $x1222 v_0_tx_time_10 (ite $x1224 v_0_tx_time_11 (ite $x1226 v_0_tx_time_12 ?x1359)))))
 (let ((?x1365 (ite $x1216 v_0_tx_time_07 (ite $x1218 v_0_tx_time_08 (ite $x1220 v_0_tx_time_09 ?x1362)))))
 (let (($x1368 (= v_1_tx_time_06 (ite (or $x1164 (>= 6 ?x816)) 0 (ite $x1215 ?x1365 v_0_tx_time_06)))))
 (let (($x1232 (= 9 ?x291)))
 (let ((?x1343 (ite $x1230 v_0_tx_time_13 (ite $x1232 v_0_tx_time_14 (ite (= 10 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1346 (ite $x1224 v_0_tx_time_10 (ite $x1226 v_0_tx_time_11 (ite $x1228 v_0_tx_time_12 ?x1343)))))
 (let ((?x1349 (ite $x1218 v_0_tx_time_07 (ite $x1220 v_0_tx_time_08 (ite $x1222 v_0_tx_time_09 ?x1346)))))
 (let ((?x1352 (ite (or $x1164 (>= 5 ?x816)) 0 (ite $x1215 (ite $x1216 v_0_tx_time_06 ?x1349) v_0_tx_time_05))))
 (let (($x1234 (= 10 ?x291)))
 (let ((?x1326 (ite $x1232 v_0_tx_time_13 (ite $x1234 v_0_tx_time_14 (ite (= 11 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1329 (ite $x1226 v_0_tx_time_10 (ite $x1228 v_0_tx_time_11 (ite $x1230 v_0_tx_time_12 ?x1326)))))
 (let ((?x1332 (ite $x1220 v_0_tx_time_07 (ite $x1222 v_0_tx_time_08 (ite $x1224 v_0_tx_time_09 ?x1329)))))
 (let ((?x1335 (ite $x1215 (ite $x1216 v_0_tx_time_05 (ite $x1218 v_0_tx_time_06 ?x1332)) v_0_tx_time_04)))
 (let (($x1236 (= 11 ?x291)))
 (let ((?x1308 (ite $x1234 v_0_tx_time_13 (ite $x1236 v_0_tx_time_14 (ite (= 12 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1311 (ite $x1228 v_0_tx_time_10 (ite $x1230 v_0_tx_time_11 (ite $x1232 v_0_tx_time_12 ?x1308)))))
 (let ((?x1314 (ite $x1222 v_0_tx_time_07 (ite $x1224 v_0_tx_time_08 (ite $x1226 v_0_tx_time_09 ?x1311)))))
 (let ((?x1317 (ite $x1216 v_0_tx_time_04 (ite $x1218 v_0_tx_time_05 (ite $x1220 v_0_tx_time_06 ?x1314)))))
 (let (($x1320 (= v_1_tx_time_03 (ite (or $x1164 (>= 3 ?x816)) 0 (ite $x1215 ?x1317 v_0_tx_time_03)))))
 (let (($x1238 (= 12 ?x291)))
 (let ((?x1289 (ite $x1236 v_0_tx_time_13 (ite $x1238 v_0_tx_time_14 (ite (= 13 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1292 (ite $x1230 v_0_tx_time_10 (ite $x1232 v_0_tx_time_11 (ite $x1234 v_0_tx_time_12 ?x1289)))))
 (let ((?x1295 (ite $x1224 v_0_tx_time_07 (ite $x1226 v_0_tx_time_08 (ite $x1228 v_0_tx_time_09 ?x1292)))))
 (let ((?x1298 (ite $x1218 v_0_tx_time_04 (ite $x1220 v_0_tx_time_05 (ite $x1222 v_0_tx_time_06 ?x1295)))))
 (let ((?x1301 (ite (or $x1164 (>= 2 ?x816)) 0 (ite $x1215 (ite $x1216 v_0_tx_time_03 ?x1298) v_0_tx_time_02))))
 (let (($x1240 (= 13 ?x291)))
 (let ((?x1269 (ite $x1238 v_0_tx_time_13 (ite $x1240 v_0_tx_time_14 (ite (= 14 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1272 (ite $x1232 v_0_tx_time_10 (ite $x1234 v_0_tx_time_11 (ite $x1236 v_0_tx_time_12 ?x1269)))))
 (let ((?x1275 (ite $x1226 v_0_tx_time_07 (ite $x1228 v_0_tx_time_08 (ite $x1230 v_0_tx_time_09 ?x1272)))))
 (let ((?x1278 (ite $x1220 v_0_tx_time_04 (ite $x1222 v_0_tx_time_05 (ite $x1224 v_0_tx_time_06 ?x1275)))))
 (let ((?x1281 (ite $x1215 (ite $x1216 v_0_tx_time_02 (ite $x1218 v_0_tx_time_03 ?x1278)) v_0_tx_time_01)))
 (let (($x1242 (= 14 ?x291)))
 (let ((?x1248 (ite $x1240 v_0_tx_time_13 (ite $x1242 v_0_tx_time_14 (ite (= 15 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1251 (ite $x1234 v_0_tx_time_10 (ite $x1236 v_0_tx_time_11 (ite $x1238 v_0_tx_time_12 ?x1248)))))
 (let ((?x1254 (ite $x1228 v_0_tx_time_07 (ite $x1230 v_0_tx_time_08 (ite $x1232 v_0_tx_time_09 ?x1251)))))
 (let ((?x1257 (ite $x1222 v_0_tx_time_04 (ite $x1224 v_0_tx_time_05 (ite $x1226 v_0_tx_time_06 ?x1254)))))
 (let ((?x1260 (ite $x1216 v_0_tx_time_01 (ite $x1218 v_0_tx_time_02 (ite $x1220 v_0_tx_time_03 ?x1257)))))
 (let (($x1264 (= v_1_tx_time_00 (ite (or (>= 0 ?x816) $x1164) 0 (ite $x1215 ?x1260 v_0_tx_time_00)))))
 (let (($x1198 (= v_1_rtt_sample_was_ambiguous (and v_0_rtt_active v_0_rtt_ambiguous))))
 (let (($x1193 (not v_1_rtt_start_new)))
 (let ((?x809 (* ?x278 ?x291)))
 (let ((?x1185 (+ ?x726 ?x809)))
 (let (($x1188 (and v_0_rtt_active $x312 $x319 $x340 (not (<= v_0_rtt_remaining ?x1185)))))
 (let ((?x1190 (ite (or $x1166 (and v_0_rtt_active $x312 $x319 $x340 $x727)) 0 (ite $x1188 ?x1185 v_0_rtt_remaining))))
 (let (($x1181 (= v_1_rtt_end v_0_rtt_end)))
 (let (($x1180 (= v_1_rtt_start_ms v_0_rtt_start_ms)))
 (let (($x1168 (and v_0_rtt_active $x312 $x319 $x340 $x727)))
 (let (($x1169 (not $x1168)))
 (let (($x1156 (= v_1_rtt_previous_measured (ite $x730 v_0_rtt_measured v_0_rtt_previous_measured))))
 (let (($x1149 (= v_1_rtt_previous_var (ite $x730 v_0_rttvar_ms v_0_rtt_previous_var))))
 (let (($x1145 (= v_1_rtt_previous_srtt (ite $x730 v_0_srtt_ms v_0_rtt_previous_srtt))))
 (let ((?x1125 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data) 4294967296)))
 (let (($x1117 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x1112 (= v_1_fin_requested v_0_fin_requested)))
 (let ((?x1090 (ite (or (and $x355 $x352 $x678) (not (and (or $x374 $x372) (not $x657)))) 0 ?x654)))
 (let (($x906 (not $x657)))
 (let (($x709 (not $x375)))
 (let (($x875 (not $x414)))
 (let (($x873 (not $x434)))
 (let (($x871 (not $x454)))
 (let (($x869 (not $x474)))
 (let (($x867 (not $x494)))
 (let (($x865 (not $x514)))
 (let (($x863 (not $x532)))
 (let (($x861 (not $x550)))
 (let (($x859 (not $x568)))
 (let (($x857 (not $x586)))
 (let (($x855 (not $x604)))
 (let (($x853 (not $x622)))
 (let (($x851 (not $x640)))
 (let (($x850 (and false $x658)))
 (let (($x852 (and $x850 $x851)))
 (let (($x854 (and $x852 $x853)))
 (let (($x856 (and $x854 $x855)))
 (let (($x858 (and $x856 $x857)))
 (let (($x860 (and $x858 $x859)))
 (let (($x862 (and $x860 $x861)))
 (let (($x864 (and $x862 $x863)))
 (let (($x866 (and $x864 $x865)))
 (let (($x868 (and $x866 $x867)))
 (let (($x870 (and $x868 $x869)))
 (let (($x872 (and $x870 $x871)))
 (let (($x874 (and $x872 $x873)))
 (let (($x877 (or $x391 (and $x874 $x875) $x393)))
 (let ((?x703 (ite $x639 0 ?x636)))
 (let (($x849 (or $x374 $x372)))
 (let (($x679 (and $x355 $x352 $x678)))
 (let (($x1086 (= v_1_rx_slot_14 (ite $x679 0 (ite $x849 ?x703 (ite (and $x877 $x709 $x906) ?x654 0))))))
 (let (($x878 (and $x877 $x709)))
 (let ((?x1078 (ite $x878 ?x703 (ite (and (or $x874 $x414) (not $x394) $x709 $x906) ?x654 0))))
 (let ((?x702 (ite $x621 0 ?x618)))
 (let (($x880 (not $x394)))
 (let (($x879 (or $x874 $x414)))
 (let (($x881 (and $x879 $x880 $x709)))
 (let ((?x1071 (ite $x881 ?x703 (ite (and (or $x872 $x434) $x875 $x880 $x709 $x906) ?x654 0))))
 (let ((?x701 (ite $x603 0 ?x600)))
 (let (($x1075 (= v_1_rx_slot_12 (ite $x679 0 (ite $x849 ?x701 (ite $x878 ?x702 ?x1071))))))
 (let (($x882 (or $x872 $x434)))
 (let (($x883 (and $x882 $x875 $x880 $x709)))
 (let ((?x1063 (ite $x883 ?x703 (ite (and (or $x870 $x454) $x873 $x875 $x880 $x709 $x906) ?x654 0))))
 (let ((?x700 (ite $x585 0 ?x582)))
 (let (($x1068 (= v_1_rx_slot_11 (ite $x679 0 (ite $x849 ?x700 (ite $x878 ?x701 (ite $x881 ?x702 ?x1063)))))))
 (let (($x884 (or $x870 $x454)))
 (let (($x885 (and $x884 $x873 $x875 $x880 $x709)))
 (let ((?x1054 (ite $x885 ?x703 (ite (and (or $x868 $x474) $x871 $x873 $x875 $x880 $x709 $x906) ?x654 0))))
 (let ((?x699 (ite $x567 0 ?x564)))
 (let ((?x1059 (ite $x679 0 (ite $x849 ?x699 (ite $x878 ?x700 (ite $x881 ?x701 (ite $x883 ?x702 ?x1054)))))))
 (let ((?x1043 (ite (and (or $x866 $x494) $x869 $x871 $x873 $x875 $x880 $x709 $x906) ?x654 0)))
 (let (($x886 (or $x868 $x474)))
 (let (($x887 (and $x886 $x871 $x873 $x875 $x880 $x709)))
 (let ((?x1048 (ite $x878 ?x699 (ite $x881 ?x700 (ite $x883 ?x701 (ite $x885 ?x702 (ite $x887 ?x703 ?x1043)))))))
 (let ((?x698 (ite $x549 0 ?x546)))
 (let ((?x1032 (ite (and (or $x864 $x514) $x867 $x869 $x871 $x873 $x875 $x880 $x709 $x906) ?x654 0)))
 (let (($x888 (or $x866 $x494)))
 (let (($x889 (and $x888 $x869 $x871 $x873 $x875 $x880 $x709)))
 (let ((?x1037 (ite $x881 ?x699 (ite $x883 ?x700 (ite $x885 ?x701 (ite $x887 ?x702 (ite $x889 ?x703 ?x1032)))))))
 (let ((?x697 (ite $x531 0 ?x528)))
 (let (($x1041 (= v_1_rx_slot_08 (ite $x679 0 (ite $x849 ?x697 (ite $x878 ?x698 ?x1037))))))
 (let ((?x1020 (ite (and (or $x862 $x532) $x865 $x867 $x869 $x871 $x873 $x875 $x880 $x709 $x906) ?x654 0)))
 (let (($x890 (or $x864 $x514)))
 (let (($x891 (and $x890 $x867 $x869 $x871 $x873 $x875 $x880 $x709)))
 (let ((?x1025 (ite $x883 ?x699 (ite $x885 ?x700 (ite $x887 ?x701 (ite $x889 ?x702 (ite $x891 ?x703 ?x1020)))))))
 (let ((?x696 (ite $x513 0 ?x510)))
 (let (($x1030 (= v_1_rx_slot_07 (ite $x679 0 (ite $x849 ?x696 (ite $x878 ?x697 (ite $x881 ?x698 ?x1025)))))))
 (let (($x894 (or $x860 $x550)))
 (let ((?x1007 (ite (and $x894 $x863 $x865 $x867 $x869 $x871 $x873 $x875 $x880 $x709 $x906) ?x654 0)))
 (let (($x892 (or $x862 $x532)))
 (let (($x893 (and $x892 $x865 $x867 $x869 $x871 $x873 $x875 $x880 $x709)))
 (let ((?x1012 (ite $x885 ?x699 (ite $x887 ?x700 (ite $x889 ?x701 (ite $x891 ?x702 (ite $x893 ?x703 ?x1007)))))))
 (let ((?x695 (ite $x493 0 ?x490)))
 (let ((?x1017 (ite $x679 0 (ite $x849 ?x695 (ite $x878 ?x696 (ite $x881 ?x697 (ite $x883 ?x698 ?x1012)))))))
 (let (($x896 (or $x858 $x568)))
 (let ((?x993 (ite (and $x896 $x861 $x863 $x865 $x867 $x869 $x871 $x873 $x875 $x880 $x709 $x906) ?x654 0)))
 (let (($x895 (and $x894 $x863 $x865 $x867 $x869 $x871 $x873 $x875 $x880 $x709)))
 (let ((?x998 (ite $x887 ?x699 (ite $x889 ?x700 (ite $x891 ?x701 (ite $x893 ?x702 (ite $x895 ?x703 ?x993)))))))
 (let ((?x694 (ite $x473 0 ?x470)))
 (let ((?x1003 (ite $x849 ?x694 (ite $x878 ?x695 (ite $x881 ?x696 (ite $x883 ?x697 (ite $x885 ?x698 ?x998)))))))
 (let (($x898 (or $x856 $x586)))
 (let (($x977 (and $x898 $x859 $x861 $x863 $x865 $x867 $x869 $x871 $x873 $x875 $x880 $x709 $x906)))
 (let (($x897 (and $x896 $x861 $x863 $x865 $x867 $x869 $x871 $x873 $x875 $x880 $x709)))
 (let ((?x982 (ite $x891 ?x700 (ite $x893 ?x701 (ite $x895 ?x702 (ite $x897 ?x703 (ite $x977 ?x654 0)))))))
 (let ((?x987 (ite $x881 ?x695 (ite $x883 ?x696 (ite $x885 ?x697 (ite $x887 ?x698 (ite $x889 ?x699 ?x982)))))))
 (let ((?x693 (ite $x453 0 ?x450)))
 (let (($x991 (= v_1_rx_slot_04 (ite $x679 0 (ite $x849 ?x693 (ite $x878 ?x694 ?x987))))))
 (let (($x900 (or $x854 $x604)))
 (let (($x961 (and $x900 $x857 $x859 $x861 $x863 $x865 $x867 $x869 $x871 $x873 $x875 $x880 $x709 $x906)))
 (let (($x899 (and $x898 $x859 $x861 $x863 $x865 $x867 $x869 $x871 $x873 $x875 $x880 $x709)))
 (let ((?x966 (ite $x893 ?x700 (ite $x895 ?x701 (ite $x897 ?x702 (ite $x899 ?x703 (ite $x961 ?x654 0)))))))
 (let ((?x971 (ite $x883 ?x695 (ite $x885 ?x696 (ite $x887 ?x697 (ite $x889 ?x698 (ite $x891 ?x699 ?x966)))))))
 (let ((?x692 (ite $x433 0 ?x430)))
 (let (($x976 (= v_1_rx_slot_03 (ite $x679 0 (ite $x849 ?x692 (ite $x878 ?x693 (ite $x881 ?x694 ?x971)))))))
 (let (($x902 (or $x852 $x622)))
 (let (($x944 (and $x902 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x869 $x871 $x873 $x875 $x880 $x709 $x906)))
 (let (($x901 (and $x900 $x857 $x859 $x861 $x863 $x865 $x867 $x869 $x871 $x873 $x875 $x880 $x709)))
 (let ((?x949 (ite $x895 ?x700 (ite $x897 ?x701 (ite $x899 ?x702 (ite $x901 ?x703 (ite $x944 ?x654 0)))))))
 (let ((?x954 (ite $x885 ?x695 (ite $x887 ?x696 (ite $x889 ?x697 (ite $x891 ?x698 (ite $x893 ?x699 ?x949)))))))
 (let ((?x691 (ite $x413 0 ?x410)))
 (let ((?x959 (ite $x679 0 (ite $x849 ?x691 (ite $x878 ?x692 (ite $x881 ?x693 (ite $x883 ?x694 ?x954)))))))
 (let (($x904 (or $x850 $x640)))
 (let (($x926 (and $x904 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x869 $x871 $x873 $x875 $x880 $x709 $x906)))
 (let (($x903 (and $x902 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x869 $x871 $x873 $x875 $x880 $x709)))
 (let ((?x931 (ite $x897 ?x700 (ite $x899 ?x701 (ite $x901 ?x702 (ite $x903 ?x703 (ite $x926 ?x654 0)))))))
 (let ((?x936 (ite $x887 ?x695 (ite $x889 ?x696 (ite $x891 ?x697 (ite $x893 ?x698 (ite $x895 ?x699 ?x931)))))))
 (let ((?x690 (ite $x393 0 ?x390)))
 (let ((?x941 (ite $x849 ?x690 (ite $x878 ?x691 (ite $x881 ?x692 (ite $x883 ?x693 (ite $x885 ?x694 ?x936)))))))
 (let (($x907 (and $x658 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x869 $x871 $x873 $x875 $x880 $x709 $x906)))
 (let (($x905 (and $x904 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x869 $x871 $x873 $x875 $x880 $x709)))
 (let ((?x912 (ite $x899 ?x700 (ite $x901 ?x701 (ite $x903 ?x702 (ite $x905 ?x703 (ite $x907 ?x654 0)))))))
 (let ((?x917 (ite $x889 ?x695 (ite $x891 ?x696 (ite $x893 ?x697 (ite $x895 ?x698 (ite $x897 ?x699 ?x912)))))))
 (let ((?x922 (ite $x878 ?x690 (ite $x881 ?x691 (ite $x883 ?x692 (ite $x885 ?x693 (ite $x887 ?x694 ?x917)))))))
 (let ((?x689 (ite $x374 0 ?x371)))
 (let ((?x711 (ite (and (<= 0 ?x674) $x709) ?x673 0)))
 (let ((?x705 (+ ?x689 ?x690 ?x691 ?x692 ?x693 ?x694 ?x695 ?x696 ?x697 ?x698 ?x699 ?x700 ?x701 ?x702 ?x703 (ite $x657 0 ?x654))))
 (let ((?x707 (ite (<= ?x705 0) 0 ?x705)))
 (let ((?x713 (ite (<= ?x707 ?x711) ?x707 ?x711)))
 (let (($x847 (= v_1_take v_0_take)))
 (let (($x807 (= v_1_snd_buf v_0_snd_buf)))
 (let (($x801 (= v_1_msl_ms v_0_msl_ms)))
 (let (($x798 (= v_1_user_timeout_ms v_0_user_timeout_ms)))
 (let (($x795 (= v_1_active_open v_0_active_open)))
 (let (($x792 (= v_1_retries v_0_retries)))
 (let (($x722 (= v_1_tx_flags v_0_tx_flags)))
 (let (($x719 (= v_1_tx_ack v_0_tx_ack)))
 (let (($x718 (= v_1_tx_seq v_0_tx_seq)))
 (let (($x717 (= v_1_rcv_nxt (mod (+ v_0_rcv_nxt ?x713 (ite $x679 1 0)) 4294967296))))
 (let (($x688 (= v_1_snd_nxt v_0_snd_nxt)))
 (let (($x684 (= v_1_irs v_0_irs)))
 (let (($x683 (= v_1_iss v_0_iss)))
 (let (($x297 (= (mod (+ input_0_net.fin_segment_ack (* ?x278 v_0_snd_nxt)) 4294967296) 2147483648)))
 (and (>= now_1 now_0) (<= 0 input_0_net.fin_segment_data) (>= 16 input_0_net.fin_segment_data) (not (= ?x281 2147483648)) (<= 0 input_0_net.fin_segment_window) (>= 65535 input_0_net.fin_segment_window) (or (and (not (= ?x291 2147483648)) (not $x297)) (not $x312)) v_0_fin_sent (not (= ?x291 (+ 1 v_0_rtx_buf))) $x319 (<= ?x291 (mod (+ v_0_snd_nxt (* ?x278 v_0_snd_una)) 4294967296)) (or (not active_0_rtx) (not (<= due_0_rtx now_1))) (or (not active_0_user) (not (<= due_0_user now_1))) (or (not active_0_time_wait) (not (<= due_0_time_wait now_1))) (or (not active_0_delack) (not (<= due_0_delack now_1))) (or (not active_0_persist) (not (<= due_0_persist now_1))) (or (and false (and $x312 $x319 $x340 v_0_fin_sent $x341)) $x679) $x682 $x683 $x684 (= v_1_snd_una (ite $x685 input_0_net.fin_segment_ack v_0_snd_una)) $x688 $x717 $x718 $x719 $x722 (= v_1_rto_ms ?x788) $x792 $x795 $x798 $x801 (= v_1_local_window (+ 16 (* ?x278 v_0_rcv_buf) (* ?x278 ?x713))) $x807 (= v_1_rtx_buf ?x816) (= v_1_rcv_buf (+ v_0_rcv_buf ?x713)) (= v_1_snd_wnd ?x839) (= v_1_snd_wl1 (ite $x837 input_0_net.fin_segment_seq v_0_snd_wl1)) (= v_1_snd_wl2 (ite $x837 input_0_net.fin_segment_ack v_0_snd_wl2)) $x847 (= v_1_rx_chunk ?x713) (= v_1_rx_slot_00 (ite $x679 0 (ite $x849 ?x689 ?x922))) (= v_1_rx_slot_01 (ite $x679 0 ?x941)) (= v_1_rx_slot_02 ?x959) $x976 $x991 (= v_1_rx_slot_05 (ite $x679 0 ?x1003)) (= v_1_rx_slot_06 ?x1017) $x1030 $x1041 (= v_1_rx_slot_09 (ite $x679 0 (ite $x849 ?x698 ?x1048))) (= v_1_rx_slot_10 ?x1059) $x1068 $x1075 (= v_1_rx_slot_13 (ite $x679 0 (ite $x849 ?x702 ?x1078))) $x1086 (= v_1_rx_slot_15 ?x1090) (= v_1_rx_advance ?x674) (= v_1_rx_acceptable (and $x312 $x350 $x352)) (= v_1_seg_acceptable $x312) (= v_1_ack_delta ?x291) (= v_1_ack_is_new (and $x319 $x340)) (= v_1_ack_is_future $x349) (= v_1_ack_advance $x685) (= v_1_ack_window_update $x837) $x1112 (= v_1_fin_sent $x1115) $x1117 (= v_1_fin_acknowledged (and $x312 $x319 $x340 v_0_fin_sent $x341)) (= v_1_rx_fin_pending (and $x355 (not $x679))) (= v_1_rx_fin_seq (ite $x354 ?x1125 v_0_rx_fin_seq)) (= v_1_rx_fin_offset (ite $x679 0 ?x677)) (= v_1_rx_fin_done (or v_0_rx_fin_done $x679)) (= v_1_rx_fin_consumed $x679) (= v_1_srtt_ms ?x750) (= v_1_rttvar_ms ?x773) (= v_1_rtt_error_ms ?x766) $x1145 $x1149 (= v_1_rtt_measured (or v_0_rtt_measured $x730)) $x1156 (= v_1_rtt_active (and $x1167 v_0_rtt_active $x1169)) (= v_1_rtt_ambiguous (and $x1167 $x1169 v_0_rtt_ambiguous)) (= v_1_rtt_sample_at_ms (ite $x730 now_1 v_0_rtt_sample_at_ms)) $x1180 $x1181 (= v_1_rtt_remaining ?x1190) $x1193 (= v_1_rtt_sample_used $x730) $x1198 (= v_1_rtt_last_ms ?x745) (= v_1_rtt_samples (+ v_0_rtt_samples (ite $x730 1 0))) (= v_1_rto_base_ms (ite $x730 ?x786 v_0_rto_base_ms)) $x1264 (= v_1_tx_time_01 (ite (or $x1164 $x1162) 0 ?x1281)) (= v_1_tx_time_02 ?x1301) $x1320 (= v_1_tx_time_04 (ite (or $x1164 (>= 4 ?x816)) 0 ?x1335)) (= v_1_tx_time_05 ?x1352) $x1368 (= v_1_tx_time_07 (ite (or $x1164 (>= 7 ?x816)) 0 ?x1380)) (= v_1_tx_time_08 ?x1394) $x1407 (= v_1_tx_time_10 (ite (or $x1164 (>= 10 ?x816)) 0 ?x1416)) (= v_1_tx_time_11 ?x1427) $x1437 (= v_1_tx_time_13 (ite (or $x1164 (>= 13 ?x816)) 0 ?x1443)) (= v_1_tx_time_14 ?x1451) (= v_1_tx_time_15 ?x1456) (= v_1_tx_fin_time (ite $x1115 v_0_tx_fin_time 0)) $x1464 $x1467 $x1470 $x1472 $x1475 $x1478 $x1481 $x1483 $x1485 $x1487 $x1489 $x1491 $x1493 $x1495 $x1497 $x1500 $x1503 $x1505 $x1507 (= v_1_persist_active $x1166) (= v_1_persist_eligible $x1166) (= v_1_persist_start $x1514) $x1517 $x1519 $x1521 $x1523 (= v_1_persist_interval_ms (ite $x1166 ?x1526 1000)) $x1531 $x1536 (= v_1_persist_last_ms (ite $x1166 v_0_persist_last_ms 0)) $x1546 (= v_1_persist_probes (ite $x1166 v_0_persist_probes 0)) $x1553 (= active_1_rtx (or $x1564 $x1567)) (= active_1_user (and $x682 active_0_user)) (= active_1_time_wait (or active_0_time_wait $x681)) $x1577 $x1581 (= due_1_rtx ?x1592) $x1595 (= due_1_time_wait (ite $x681 ?x1598 due_0_time_wait)) $x1602 (= due_1_persist (ite $x1514 ?x1542 due_0_persist)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
 (let ((?x1611 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1611)))
(assert
 (>= 16 v_0_rcv_buf))
(assert
 (and (<= 0 v_0_snd_wnd) (>= 65535 v_0_snd_wnd)))
(assert
 (= v_0_local_window (+ 16 (* (- 1) v_0_rcv_buf))))
(assert
 (>= 1 v_0_rx_slot_00))
(assert
 (let (($x358 (= 0 v_0_rx_slot_00)))
 (let (($x1621 (not (>= v_0_rcv_buf 16))))
 (or $x1621 $x358))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x376 (= 0 v_0_rx_slot_01)))
 (let (($x1625 (not (>= v_0_rcv_buf 15))))
 (or $x1625 $x376))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x395 (= 0 v_0_rx_slot_02)))
 (let (($x1629 (not (>= v_0_rcv_buf 14))))
 (or $x1629 $x395))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x415 (= 0 v_0_rx_slot_03)))
 (let (($x1633 (not (>= v_0_rcv_buf 13))))
 (or $x1633 $x415))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x435 (= 0 v_0_rx_slot_04)))
 (let (($x1637 (not (>= v_0_rcv_buf 12))))
 (or $x1637 $x435))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x455 (= 0 v_0_rx_slot_05)))
 (let (($x1641 (not (>= v_0_rcv_buf 11))))
 (or $x1641 $x455))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x475 (= 0 v_0_rx_slot_06)))
 (let (($x1645 (not (>= v_0_rcv_buf 10))))
 (or $x1645 $x475))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x495 (= 0 v_0_rx_slot_07)))
 (let (($x1649 (not (>= v_0_rcv_buf 9))))
 (or $x1649 $x495))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x515 (= 0 v_0_rx_slot_08)))
 (let (($x1653 (not (>= v_0_rcv_buf 8))))
 (or $x1653 $x515))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x533 (= 0 v_0_rx_slot_09)))
 (let (($x1657 (not (>= v_0_rcv_buf 7))))
 (or $x1657 $x533))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x551 (= 0 v_0_rx_slot_10)))
 (let (($x1661 (not (>= v_0_rcv_buf 6))))
 (or $x1661 $x551))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x569 (= 0 v_0_rx_slot_11)))
 (let (($x1665 (not (>= v_0_rcv_buf 5))))
 (or $x1665 $x569))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x587 (= 0 v_0_rx_slot_12)))
 (let (($x1669 (not (>= v_0_rcv_buf 4))))
 (or $x1669 $x587))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x605 (= 0 v_0_rx_slot_13)))
 (let (($x1673 (not (>= v_0_rcv_buf 3))))
 (or $x1673 $x605))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x623 (= 0 v_0_rx_slot_14)))
 (let (($x1677 (not (>= v_0_rcv_buf 2))))
 (or $x1677 $x623))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x641 (= 0 v_0_rx_slot_15)))
 (let (($x1681 (not (>= v_0_rcv_buf 1))))
 (or $x1681 $x641))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x1683 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x1683)))
(assert
 (and (<= 0 v_0_rx_advance) (>= 16 v_0_rx_advance)))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (and (<= 0 v_0_ack_delta) (>= 4294967295 v_0_ack_delta)))
(assert
 true)
(assert
 (let ((?x1696 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x1696)))
(assert
 (let (($x1703 (and v_0_fin_requested (= v_0_fin_seq (mod (+ v_0_snd_una v_0_rtx_buf) 4294967296)) (= 0 v_0_snd_buf))))
 (let (($x1698 (not v_0_fin_sent)))
 (or $x1698 $x1703))))
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
 (let (($x1705 (<= 1 v_0_rx_fin_offset)))
 (let (($x352 (not v_0_rx_fin_done)))
 (let (($x1707 (and $x352 $x1705 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window)))))
 (let (($x353 (not v_0_rx_fin_pending)))
 (or $x353 $x1707))))))
(assert
 (let (($x1710 (>= 15 v_0_rx_fin_offset)))
 (and (<= 0 v_0_rx_fin_offset) $x1710 (= v_0_rx_fin_pending (<= 1 v_0_rx_fin_offset)))))
(assert
 (let (($x353 (not v_0_rx_fin_pending)))
 (or $x353 (= v_0_rx_fin_seq (mod (+ v_0_rcv_nxt v_0_rx_fin_offset) 4294967296)))))
(assert
 (let (($x352 (not v_0_rx_fin_done)))
 (or $x352 (= v_0_rcv_nxt (mod (+ 1 v_0_rx_fin_seq) 4294967296)))))
(assert
 (let (($x358 (= 0 v_0_rx_slot_00)))
 (or (not (and v_0_rx_fin_pending (>= 0 v_0_rx_fin_offset))) $x358)))
(assert
 (let (($x376 (= 0 v_0_rx_slot_01)))
 (or (not (and v_0_rx_fin_pending (>= 1 v_0_rx_fin_offset))) $x376)))
(assert
 (let (($x395 (= 0 v_0_rx_slot_02)))
 (or (not (and v_0_rx_fin_pending (>= 2 v_0_rx_fin_offset))) $x395)))
(assert
 (let (($x415 (= 0 v_0_rx_slot_03)))
 (or (not (and v_0_rx_fin_pending (>= 3 v_0_rx_fin_offset))) $x415)))
(assert
 (let (($x435 (= 0 v_0_rx_slot_04)))
 (or (not (and v_0_rx_fin_pending (>= 4 v_0_rx_fin_offset))) $x435)))
(assert
 (let (($x455 (= 0 v_0_rx_slot_05)))
 (or (not (and v_0_rx_fin_pending (>= 5 v_0_rx_fin_offset))) $x455)))
(assert
 (let (($x475 (= 0 v_0_rx_slot_06)))
 (or (not (and v_0_rx_fin_pending (>= 6 v_0_rx_fin_offset))) $x475)))
(assert
 (let (($x495 (= 0 v_0_rx_slot_07)))
 (or (not (and v_0_rx_fin_pending (>= 7 v_0_rx_fin_offset))) $x495)))
(assert
 (let (($x515 (= 0 v_0_rx_slot_08)))
 (or (not (and v_0_rx_fin_pending (>= 8 v_0_rx_fin_offset))) $x515)))
(assert
 (let (($x533 (= 0 v_0_rx_slot_09)))
 (or (not (and v_0_rx_fin_pending (>= 9 v_0_rx_fin_offset))) $x533)))
(assert
 (let (($x551 (= 0 v_0_rx_slot_10)))
 (or (not (and v_0_rx_fin_pending (>= 10 v_0_rx_fin_offset))) $x551)))
(assert
 (let (($x569 (= 0 v_0_rx_slot_11)))
 (or (not (and v_0_rx_fin_pending (>= 11 v_0_rx_fin_offset))) $x569)))
(assert
 (let (($x587 (= 0 v_0_rx_slot_12)))
 (or (not (and v_0_rx_fin_pending (>= 12 v_0_rx_fin_offset))) $x587)))
(assert
 (let (($x605 (= 0 v_0_rx_slot_13)))
 (or (not (and v_0_rx_fin_pending (>= 13 v_0_rx_fin_offset))) $x605)))
(assert
 (let (($x623 (= 0 v_0_rx_slot_14)))
 (or (not (and v_0_rx_fin_pending (>= 14 v_0_rx_fin_offset))) $x623)))
(assert
 (let (($x641 (= 0 v_0_rx_slot_15)))
 (or (not (and v_0_rx_fin_pending (>= 15 v_0_rx_fin_offset))) $x641)))
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
 (let ((?x1798 (* 4.0 v_0_rttvar_ms)))
 (let ((?x733 (- 1.0)))
 (let ((?x762 (* ?x733 v_0_srtt_ms)))
 (let ((?x1801 (+ ?x762 (* ?x733 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x1798)))))
 (let ((?x1802 (to_int ?x1801)))
 (let ((?x278 (- 1)))
 (let ((?x1805 (ite (<= ?x1802 (- 1000)) (* ?x278 ?x1802) 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x1805) 60000 ?x1805) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x321 (mod (+ v_0_snd_nxt (* (- 1) v_0_snd_una)) 4294967296)))
 (let ((?x726 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x1818 (and (<= v_0_rtt_start_ms now_0) (<= 1 v_0_rtt_remaining) (>= 4 v_0_rtt_remaining) (>= ?x726 v_0_rtt_remaining) (<= ?x726 ?x321))))
 (let (($x1812 (not v_0_rtt_active)))
 (or $x1812 $x1818))))))
(assert
 (let (($x1820 (= 0 v_0_rtt_remaining)))
 (or v_0_rtt_active $x1820)))
(assert
 true)
(assert
 (let (($x1827 (= v_0_rtt_last_ms (+ v_0_rtt_sample_at_ms (* (- 1) v_0_rtt_start_ms)))))
 (let (($x1825 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1823 (not v_0_rtt_sample_used)))
 (or $x1823 (and $x1825 v_0_rtt_measured $x1827))))))
(assert
 (and (<= 0 v_0_rtt_sample_at_ms) (<= v_0_rtt_sample_at_ms now_0)))
(assert
 (let ((?x1834 (to_real v_0_rtt_last_ms)))
 (let ((?x1848 (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x1834))))
 (let ((?x1836 (+ v_0_rtt_previous_srtt (* (- 1.0) ?x1834))))
 (let ((?x1840 (ite (>= ?x1836 0.0) ?x1836 (+ (* (- 1.0) v_0_rtt_previous_srtt) ?x1834))))
 (let ((?x757 (/ 1.0 4.0)))
 (let ((?x1844 (ite v_0_rtt_previous_measured (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* ?x757 ?x1840)) (* (/ 1.0 2.0) ?x1834))))
 (let (($x1851 (and (= v_0_rttvar_ms ?x1844) (= v_0_srtt_ms (ite v_0_rtt_previous_measured ?x1848 ?x1834)))))
 (let (($x1823 (not v_0_rtt_sample_used)))
 (or $x1823 $x1851))))))))))
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
 (let (($x1987 (and (>= v_0_tx_elapsed v_0_tx_previous_rto) (<= 1 v_0_tx_emit_count) (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x1981 (not v_0_tx_retransmitted)))
 (or $x1981 $x1987))))
(assert
 (let (($x1981 (not v_0_tx_retransmitted)))
 (or $x1981 (not v_0_tx_waiting))))
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
 (let (($x2018 (not v_0_ack_pending)))
 (or $x2018 (and (<= 1 v_0_ack_bytes) (not v_0_rx_fin_done)))))
(assert
 (let (($x2025 (and (= 0 v_0_ack_bytes) (= 0 v_0_ack_full_segments) (= 0 v_0_ack_since_ms))))
 (or v_0_ack_pending $x2025)))
(assert
 (let (($x186 (not active_0_rtx)))
 (let (($x1862 (>= 1 v_0_rtx_buf)))
 (let (($x1698 (not v_0_fin_sent)))
 (let (($x2034 (and (= 0 v_0_snd_wnd) $x1698 (<= 1 (+ v_0_rtx_buf v_0_snd_buf)) $x1862 $x186)))
 (let (($x1513 (not v_0_persist_active)))
 (let (($x2029 (and (<= 1 (+ v_0_rtx_buf (ite v_0_fin_sent 1 0))) $x1513)))
 (let (($x2027 (= v_0_persist_active active_0_persist)))
 (and $x2027 (= active_0_rtx $x2029) (or $x1513 $x2034))))))))))
(assert
 (let (($x1513 (not v_0_persist_active)))
 (or $x1513 (and (not v_0_rtt_active) (= 0 v_0_rtt_remaining)))))
(assert
 (and (<= 1000 v_0_persist_interval_ms) (>= 60000 v_0_persist_interval_ms) (<= 1000 v_0_persist_previous_interval_ms) (>= 60000 v_0_persist_previous_interval_ms) (<= 0 v_0_persist_probes) (<= 0 v_0_persist_elapsed_ms)))
(assert
 (and (<= 0 v_0_persist_since_ms) (<= v_0_persist_since_ms now_0) (<= 0 v_0_persist_last_ms) (<= v_0_persist_last_ms now_0) (<= 0 v_0_persist_deadline_ms)))
(assert
 (let (($x2052 (= 0 v_0_persist_probes)))
 (let ((?x2054 (+ (ite $x2052 v_0_persist_since_ms v_0_persist_last_ms) v_0_persist_interval_ms)))
 (let (($x1513 (not v_0_persist_active)))
 (or $x1513 (= v_0_persist_deadline_ms ?x2054))))))
(assert
 (let (($x2060 (= 1 v_0_rtx_buf)))
 (let (($x2058 (not v_0_persist_probe_sent)))
 (or $x2058 (and (>= v_0_persist_elapsed_ms v_0_persist_previous_interval_ms) $x2060)))))
(assert
 (let (($x2066 (= v_0_tx_time_00 v_0_persist_last_ms)))
 (let (($x2060 (= 1 v_0_rtx_buf)))
 (or (not (and v_0_persist_active (<= 1 v_0_persist_probes) $x2060)) $x2066))))
(assert
 (let (($x2052 (= 0 v_0_persist_probes)))
 (let (($x2071 (and (= 0 v_0_persist_since_ms) (= 0 v_0_persist_last_ms) (= 0 v_0_persist_deadline_ms) $x2052)))
 (or v_0_persist_active $x2071))))
(assert
 (= 178 choice_0))
(assert
 (= 5 state_0))
(assert
 (= 8 state_1))
(assert
 (or (not (or (not (>= 13 v_1_rtx_buf)) (= 0 v_1_tx_time_13)))))
(check-sat)
