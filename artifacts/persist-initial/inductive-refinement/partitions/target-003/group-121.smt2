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
 (let ((?x305 (mod (+ input_0_net.fin_segment_ack (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x727 (>= ?x305 ?x726)))
 (let ((?x338 (ite v_0_fin_sent 1 0)))
 (let ((?x339 (+ v_0_rtx_buf ?x338)))
 (let (($x340 (<= ?x305 ?x339)))
 (let (($x319 (<= 1 ?x305)))
 (let ((?x278 (- 1)))
 (let ((?x294 (+ ?x278 v_0_local_window)))
 (let (($x299 (<= (mod (+ input_0_net.fin_segment_seq (* ?x278 v_0_rcv_nxt)) 4294967296) ?x294)))
 (let (($x290 (<= 1 v_0_local_window)))
 (let ((?x291 (* ?x278 v_0_rcv_nxt)))
 (let ((?x293 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data ?x291) 4294967296)))
 (let (($x295 (<= ?x293 ?x294)))
 (let (($x301 (or (and $x290 $x295) (and $x290 $x299))))
 (let (($x730 (and v_0_rtt_active $x301 $x319 $x340 $x727 $x729)))
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
 (let (($x1510 (not v_0_persist_active)))
 (let ((?x813 (ite (<= 0 v_0_rtx_buf) v_0_rtx_buf 0)))
 (let ((?x811 (ite (<= v_0_rtx_buf ?x305) 0 (+ v_0_rtx_buf (* ?x278 ?x305)))))
 (let (($x685 (and $x301 $x319 $x340)))
 (let ((?x816 (ite $x685 (ite (<= ?x811 ?x813) ?x811 ?x813) v_0_rtx_buf)))
 (let (($x1161 (= 0 ?x816)))
 (let (($x1162 (or v_0_persist_active $x1161)))
 (let (($x1159 (>= 1 ?x816)))
 (let (($x1158 (<= 1 (+ ?x816 v_0_snd_buf))))
 (let (($x341 (= ?x305 ?x339)))
 (let (($x342 (and $x301 $x319 $x340 v_0_fin_sent $x341)))
 (let (($x343 (not $x342)))
 (let (($x1113 (and $x343 v_0_fin_sent)))
 (let (($x1156 (not $x1113)))
 (let (($x833 (<= 2147483648 (mod (+ input_0_net.fin_segment_ack (* ?x278 v_0_snd_wl2)) 4294967296))))
 (let (($x829 (= v_0_snd_wl1 input_0_net.fin_segment_seq)))
 (let ((?x823 (mod (+ input_0_net.fin_segment_seq (* ?x278 v_0_snd_wl1)) 4294967296)))
 (let (($x836 (or (and (not (<= ?x823 0)) (not (<= 2147483648 ?x823))) (and $x829 (not $x833)))))
 (let (($x837 (and $x301 $x340 $x836)))
 (let ((?x839 (ite $x837 input_0_net.fin_segment_window v_0_snd_wnd)))
 (let (($x1155 (= 0 ?x839)))
 (let (($x1511 (and $x1155 $x1156 $x1158 $x1159 $x1162 $x1510)))
 (let ((?x1523 (ite $x1511 ?x788 v_0_persist_interval_ms)))
 (let ((?x1539 (+ now_1 ?x1523)))
 (let (($x1599 (= due_1_delack due_0_delack)))
 (let ((?x1595 (+ now_1 (* 2 v_0_msl_ms))))
 (let (($x353 (not v_0_rx_fin_pending)))
 (let (($x352 (not v_0_rx_fin_done)))
 (let (($x349 (and (>= ?x305 (+ 1 v_0_rtx_buf ?x338)) (>= 2147483647 ?x305))))
 (let (($x350 (not $x349)))
 (let (($x354 (and $x301 $x350 $x352 $x353 $x290 $x295)))
 (let ((?x357 (ite $x354 ?x293 v_0_rx_fin_offset)))
 (let (($x355 (or v_0_rx_fin_pending $x354)))
 (let (($x657 (and $x355 (>= 15 ?x357))))
 (let ((?x644 (mod (+ 15 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x649 (+ input_0_net.fin_segment_data (* ?x278 ?x644))))
 (let (($x647 (<= input_0_net.fin_segment_data ?x644)))
 (let (($x642 (<= v_0_rcv_buf 0)))
 (let (($x641 (= 0 v_0_rx_slot_15)))
 (let (($x646 (and $x301 $x350 $x352 $x641 $x642 (<= ?x644 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x654 (ite $x646 (ite (or $x647 (<= ?x649 1)) (ite $x647 0 ?x649) 1) v_0_rx_slot_15)))
 (let (($x658 (or (= ?x654 0) $x657)))
 (let (($x639 (and $x355 (>= 14 ?x357))))
 (let ((?x626 (mod (+ 14 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x631 (+ input_0_net.fin_segment_data (* ?x278 ?x626))))
 (let (($x629 (<= input_0_net.fin_segment_data ?x626)))
 (let (($x624 (<= v_0_rcv_buf 1)))
 (let (($x623 (= 0 v_0_rx_slot_14)))
 (let (($x628 (and $x301 $x350 $x352 $x623 $x624 (<= ?x626 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x636 (ite $x628 (ite (or $x629 (<= ?x631 1)) (ite $x629 0 ?x631) 1) v_0_rx_slot_14)))
 (let (($x640 (or (= ?x636 0) $x639)))
 (let (($x621 (and $x355 (>= 13 ?x357))))
 (let ((?x608 (mod (+ 13 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x613 (+ input_0_net.fin_segment_data (* ?x278 ?x608))))
 (let (($x611 (<= input_0_net.fin_segment_data ?x608)))
 (let (($x606 (<= v_0_rcv_buf 2)))
 (let (($x605 (= 0 v_0_rx_slot_13)))
 (let (($x610 (and $x301 $x350 $x352 $x605 $x606 (<= ?x608 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x618 (ite $x610 (ite (or $x611 (<= ?x613 1)) (ite $x611 0 ?x613) 1) v_0_rx_slot_13)))
 (let (($x622 (or (= ?x618 0) $x621)))
 (let (($x603 (and $x355 (>= 12 ?x357))))
 (let ((?x590 (mod (+ 12 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x595 (+ input_0_net.fin_segment_data (* ?x278 ?x590))))
 (let (($x593 (<= input_0_net.fin_segment_data ?x590)))
 (let (($x588 (<= v_0_rcv_buf 3)))
 (let (($x587 (= 0 v_0_rx_slot_12)))
 (let (($x592 (and $x301 $x350 $x352 $x587 $x588 (<= ?x590 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x600 (ite $x592 (ite (or $x593 (<= ?x595 1)) (ite $x593 0 ?x595) 1) v_0_rx_slot_12)))
 (let (($x604 (or (= ?x600 0) $x603)))
 (let ((?x662 (ite $x604 12 (ite $x622 13 (ite $x640 14 (ite $x658 15 16))))))
 (let (($x585 (and $x355 (>= 11 ?x357))))
 (let ((?x572 (mod (+ 11 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x577 (+ input_0_net.fin_segment_data (* ?x278 ?x572))))
 (let (($x575 (<= input_0_net.fin_segment_data ?x572)))
 (let (($x570 (<= v_0_rcv_buf 4)))
 (let (($x569 (= 0 v_0_rx_slot_11)))
 (let (($x574 (and $x301 $x350 $x352 $x569 $x570 (<= ?x572 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x582 (ite $x574 (ite (or $x575 (<= ?x577 1)) (ite $x575 0 ?x577) 1) v_0_rx_slot_11)))
 (let (($x586 (or (= ?x582 0) $x585)))
 (let (($x567 (and $x355 (>= 10 ?x357))))
 (let ((?x554 (mod (+ 10 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x559 (+ input_0_net.fin_segment_data (* ?x278 ?x554))))
 (let (($x557 (<= input_0_net.fin_segment_data ?x554)))
 (let (($x552 (<= v_0_rcv_buf 5)))
 (let (($x551 (= 0 v_0_rx_slot_10)))
 (let (($x556 (and $x301 $x350 $x352 $x551 $x552 (<= ?x554 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x564 (ite $x556 (ite (or $x557 (<= ?x559 1)) (ite $x557 0 ?x559) 1) v_0_rx_slot_10)))
 (let (($x568 (or (= ?x564 0) $x567)))
 (let (($x549 (and $x355 (>= 9 ?x357))))
 (let ((?x536 (mod (+ 9 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x541 (+ input_0_net.fin_segment_data (* ?x278 ?x536))))
 (let (($x539 (<= input_0_net.fin_segment_data ?x536)))
 (let (($x534 (<= v_0_rcv_buf 6)))
 (let (($x533 (= 0 v_0_rx_slot_09)))
 (let (($x538 (and $x301 $x350 $x352 $x533 $x534 (<= ?x536 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x546 (ite $x538 (ite (or $x539 (<= ?x541 1)) (ite $x539 0 ?x541) 1) v_0_rx_slot_09)))
 (let (($x550 (or (= ?x546 0) $x549)))
 (let (($x531 (and $x355 (>= 8 ?x357))))
 (let ((?x518 (mod (+ 8 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x523 (+ input_0_net.fin_segment_data (* ?x278 ?x518))))
 (let (($x521 (<= input_0_net.fin_segment_data ?x518)))
 (let (($x516 (<= v_0_rcv_buf 7)))
 (let (($x515 (= 0 v_0_rx_slot_08)))
 (let (($x520 (and $x301 $x350 $x352 $x515 $x516 (<= ?x518 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x528 (ite $x520 (ite (or $x521 (<= ?x523 1)) (ite $x521 0 ?x523) 1) v_0_rx_slot_08)))
 (let (($x532 (or (= ?x528 0) $x531)))
 (let ((?x666 (ite $x532 8 (ite $x550 9 (ite $x568 10 (ite $x586 11 ?x662))))))
 (let (($x513 (and $x355 (>= 7 ?x357))))
 (let ((?x500 (mod (+ 7 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x505 (+ input_0_net.fin_segment_data (* ?x278 ?x500))))
 (let (($x503 (<= input_0_net.fin_segment_data ?x500)))
 (let (($x497 (<= v_0_rcv_buf 8)))
 (let (($x495 (= 0 v_0_rx_slot_07)))
 (let (($x502 (and $x301 $x350 $x352 $x495 $x497 (<= ?x500 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x510 (ite $x502 (ite (or $x503 (<= ?x505 1)) (ite $x503 0 ?x505) 1) v_0_rx_slot_07)))
 (let (($x514 (or (= ?x510 0) $x513)))
 (let (($x493 (and $x355 (>= 6 ?x357))))
 (let ((?x480 (mod (+ 6 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x485 (+ input_0_net.fin_segment_data (* ?x278 ?x480))))
 (let (($x483 (<= input_0_net.fin_segment_data ?x480)))
 (let (($x477 (<= v_0_rcv_buf 9)))
 (let (($x475 (= 0 v_0_rx_slot_06)))
 (let (($x482 (and $x301 $x350 $x352 $x475 $x477 (<= ?x480 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x490 (ite $x482 (ite (or $x483 (<= ?x485 1)) (ite $x483 0 ?x485) 1) v_0_rx_slot_06)))
 (let (($x494 (or (= ?x490 0) $x493)))
 (let (($x473 (and $x355 (>= 5 ?x357))))
 (let ((?x460 (mod (+ 5 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x465 (+ input_0_net.fin_segment_data (* ?x278 ?x460))))
 (let (($x463 (<= input_0_net.fin_segment_data ?x460)))
 (let (($x457 (<= v_0_rcv_buf 10)))
 (let (($x455 (= 0 v_0_rx_slot_05)))
 (let (($x462 (and $x301 $x350 $x352 $x455 $x457 (<= ?x460 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x470 (ite $x462 (ite (or $x463 (<= ?x465 1)) (ite $x463 0 ?x465) 1) v_0_rx_slot_05)))
 (let (($x474 (or (= ?x470 0) $x473)))
 (let (($x453 (and $x355 (>= 4 ?x357))))
 (let ((?x440 (mod (+ 4 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x445 (+ input_0_net.fin_segment_data (* ?x278 ?x440))))
 (let (($x443 (<= input_0_net.fin_segment_data ?x440)))
 (let (($x437 (<= v_0_rcv_buf 11)))
 (let (($x435 (= 0 v_0_rx_slot_04)))
 (let (($x442 (and $x301 $x350 $x352 $x435 $x437 (<= ?x440 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x450 (ite $x442 (ite (or $x443 (<= ?x445 1)) (ite $x443 0 ?x445) 1) v_0_rx_slot_04)))
 (let (($x454 (or (= ?x450 0) $x453)))
 (let ((?x670 (ite $x454 4 (ite $x474 5 (ite $x494 6 (ite $x514 7 ?x666))))))
 (let (($x433 (and $x355 (>= 3 ?x357))))
 (let ((?x420 (mod (+ 3 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x425 (+ input_0_net.fin_segment_data (* ?x278 ?x420))))
 (let (($x423 (<= input_0_net.fin_segment_data ?x420)))
 (let (($x417 (<= v_0_rcv_buf 12)))
 (let (($x415 (= 0 v_0_rx_slot_03)))
 (let (($x422 (and $x301 $x350 $x352 $x415 $x417 (<= ?x420 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x430 (ite $x422 (ite (or $x423 (<= ?x425 1)) (ite $x423 0 ?x425) 1) v_0_rx_slot_03)))
 (let (($x434 (or (= ?x430 0) $x433)))
 (let (($x413 (and $x355 (>= 2 ?x357))))
 (let ((?x400 (mod (+ 2 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x405 (+ input_0_net.fin_segment_data (* ?x278 ?x400))))
 (let (($x403 (<= input_0_net.fin_segment_data ?x400)))
 (let (($x397 (<= v_0_rcv_buf 13)))
 (let (($x395 (= 0 v_0_rx_slot_02)))
 (let (($x402 (and $x301 $x350 $x352 $x395 $x397 (<= ?x400 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x410 (ite $x402 (ite (or $x403 (<= ?x405 1)) (ite $x403 0 ?x405) 1) v_0_rx_slot_02)))
 (let (($x414 (or (= ?x410 0) $x413)))
 (let (($x393 (and $x355 (>= 1 ?x357))))
 (let ((?x380 (mod (+ 1 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x385 (+ input_0_net.fin_segment_data (* ?x278 ?x380))))
 (let (($x383 (<= input_0_net.fin_segment_data ?x380)))
 (let (($x378 (<= v_0_rcv_buf 14)))
 (let (($x376 (= 0 v_0_rx_slot_01)))
 (let (($x382 (and $x301 $x350 $x352 $x376 $x378 (<= ?x380 (+ ?x278 input_0_net.fin_segment_data)))))
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
 (let (($x363 (and $x301 $x350 $x352 $x358 $x360 (<= ?x281 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x371 (ite $x363 (ite (or $x364 (<= ?x366 1)) (ite $x364 0 ?x366) 1) v_0_rx_slot_00)))
 (let (($x375 (or (= ?x371 0) $x374)))
 (let ((?x674 (ite $x375 0 ?x673)))
 (let ((?x677 (ite $x355 (+ ?x357 (* ?x278 ?x674)) ?x357)))
 (let (($x678 (= 0 ?x677)))
 (let (($x681 (and $x355 $x352 $x678 $x301 $x319 $x340 v_0_fin_sent $x341)))
 (let (($x1592 (= due_1_user due_0_user)))
 (let ((?x1584 (ite (<= (- 999.0) ?x778) 1000 ?x783)))
 (let (($x1560 (and $x301 $x319 $x340 (<= 1 (+ ?x816 (ite $x1113 1 0))))))
 (let (($x1558 (and (not (and $x301 $x319 $x340 (= 0 (+ ?x816 (ite $x1113 1 0))))) active_0_rtx)))
 (let (($x682 (not $x681)))
 (let (($x1163 (and $x1155 $x1156 $x1158 $x1159 $x1162)))
 (let (($x1164 (not $x1163)))
 (let (($x1562 (and $x1164 $x682 (or $x1558 $x1560))))
 (let (($x1564 (and v_0_persist_active $x1164 (<= 1 ?x816) (not $x1562))))
 (let ((?x1589 (ite (or $x1560 $x1564) (+ now_1 (ite $x730 (ite (<= 60000 ?x1584) 60000 ?x1584) v_0_rto_ms)) due_0_rtx)))
 (let (($x1578 (= active_1_persist (and $x1155 $x1156 $x1158 $x1159 $x1162 (or active_0_persist $x1511)))))
 (let (($x1574 (not active_1_delack)))
 (let (($x1550 (= v_1_persist_elapsed_ms v_0_persist_elapsed_ms)))
 (let (($x1543 (= v_1_persist_deadline_ms (ite $x1163 (ite $x1511 ?x1539 v_0_persist_deadline_ms) 0))))
 (let (($x1533 (= v_1_persist_since_ms (ite $x1163 (ite $x1511 now_1 v_0_persist_since_ms) 0))))
 (let (($x1528 (= v_1_persist_previous_interval_ms v_0_persist_previous_interval_ms)))
 (let (($x1520 (not v_1_persist_probe_new)))
 (let (($x1518 (not v_1_persist_probe_sent)))
 (let (($x1516 (not v_1_persist_first)))
 (let (($x1514 (= v_1_persist_was_active v_0_persist_active)))
 (let (($x1504 (not v_1_ack_defer_now)))
 (let (($x1502 (not v_1_ack_defer_candidate)))
 (let (($x1500 (= v_1_ack_rmss v_0_ack_rmss)))
 (let (($x1497 (= v_1_ack_delay_ms v_0_ack_delay_ms)))
 (let (($x1494 (= v_1_ack_full_segments 0)))
 (let (($x1492 (= v_1_ack_bytes 0)))
 (let (($x1490 (= v_1_ack_since_ms 0)))
 (let (($x1488 (not v_1_ack_pending)))
 (let (($x1486 (not v_1_syn_timeout_eligible)))
 (let (($x1484 (not v_1_tx_syn_pending)))
 (let (($x1482 (= v_1_tx_syn_time 0)))
 (let (($x1480 (not v_1_tx_waiting)))
 (let (($x1478 (= v_1_tx_is_fin v_0_tx_is_fin)))
 (let (($x1475 (= v_1_tx_previous_rto v_0_tx_previous_rto)))
 (let (($x1472 (= v_1_tx_elapsed v_0_tx_elapsed)))
 (let (($x1469 (not v_1_tx_retransmitted)))
 (let (($x1467 (= v_1_tx_max_previous v_0_tx_max_previous)))
 (let (($x1464 (= v_1_tx_eligible v_0_tx_eligible)))
 (let (($x1461 (= v_1_tx_emit_count v_0_tx_emit_count)))
 (let ((?x1453 (ite (or (and $x301 $x319 $x340 (not (= 0 ?x305))) (>= 15 ?x816) $x1161) 0 v_0_tx_time_15)))
 (let (($x1212 (and $x301 $x319 $x340 (not (= 0 ?x305)))))
 (let ((?x1448 (ite (or (>= 14 ?x816) $x1161) 0 (ite $x1212 (ite (= 1 ?x305) v_0_tx_time_15 0) v_0_tx_time_14))))
 (let (($x1213 (= 1 ?x305)))
 (let ((?x1440 (ite $x1212 (ite $x1213 v_0_tx_time_14 (ite (= 2 ?x305) v_0_tx_time_15 0)) v_0_tx_time_13)))
 (let (($x1215 (= 2 ?x305)))
 (let ((?x1431 (ite $x1213 v_0_tx_time_13 (ite $x1215 v_0_tx_time_14 (ite (= 3 ?x305) v_0_tx_time_15 0)))))
 (let (($x1434 (= v_1_tx_time_12 (ite (or $x1161 (>= 12 ?x816)) 0 (ite $x1212 ?x1431 v_0_tx_time_12)))))
 (let (($x1217 (= 3 ?x305)))
 (let ((?x1421 (ite $x1215 v_0_tx_time_13 (ite $x1217 v_0_tx_time_14 (ite (= 4 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1424 (ite (or (>= 11 ?x816) $x1161) 0 (ite $x1212 (ite $x1213 v_0_tx_time_12 ?x1421) v_0_tx_time_11))))
 (let (($x1219 (= 4 ?x305)))
 (let ((?x1410 (ite $x1217 v_0_tx_time_13 (ite $x1219 v_0_tx_time_14 (ite (= 5 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1413 (ite $x1212 (ite $x1213 v_0_tx_time_11 (ite $x1215 v_0_tx_time_12 ?x1410)) v_0_tx_time_10)))
 (let (($x1221 (= 5 ?x305)))
 (let ((?x1398 (ite $x1219 v_0_tx_time_13 (ite $x1221 v_0_tx_time_14 (ite (= 6 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1401 (ite $x1213 v_0_tx_time_10 (ite $x1215 v_0_tx_time_11 (ite $x1217 v_0_tx_time_12 ?x1398)))))
 (let (($x1404 (= v_1_tx_time_09 (ite (or (>= 9 ?x816) $x1161) 0 (ite $x1212 ?x1401 v_0_tx_time_09)))))
 (let (($x1223 (= 6 ?x305)))
 (let ((?x1385 (ite $x1221 v_0_tx_time_13 (ite $x1223 v_0_tx_time_14 (ite (= 7 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1388 (ite $x1215 v_0_tx_time_10 (ite $x1217 v_0_tx_time_11 (ite $x1219 v_0_tx_time_12 ?x1385)))))
 (let ((?x1391 (ite (or (>= 8 ?x816) $x1161) 0 (ite $x1212 (ite $x1213 v_0_tx_time_09 ?x1388) v_0_tx_time_08))))
 (let (($x1225 (= 7 ?x305)))
 (let ((?x1371 (ite $x1223 v_0_tx_time_13 (ite $x1225 v_0_tx_time_14 (ite (= 8 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1374 (ite $x1217 v_0_tx_time_10 (ite $x1219 v_0_tx_time_11 (ite $x1221 v_0_tx_time_12 ?x1371)))))
 (let ((?x1377 (ite $x1212 (ite $x1213 v_0_tx_time_08 (ite $x1215 v_0_tx_time_09 ?x1374)) v_0_tx_time_07)))
 (let (($x1227 (= 8 ?x305)))
 (let ((?x1356 (ite $x1225 v_0_tx_time_13 (ite $x1227 v_0_tx_time_14 (ite (= 9 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1359 (ite $x1219 v_0_tx_time_10 (ite $x1221 v_0_tx_time_11 (ite $x1223 v_0_tx_time_12 ?x1356)))))
 (let ((?x1362 (ite $x1213 v_0_tx_time_07 (ite $x1215 v_0_tx_time_08 (ite $x1217 v_0_tx_time_09 ?x1359)))))
 (let (($x1365 (= v_1_tx_time_06 (ite (or (>= 6 ?x816) $x1161) 0 (ite $x1212 ?x1362 v_0_tx_time_06)))))
 (let (($x1229 (= 9 ?x305)))
 (let ((?x1340 (ite $x1227 v_0_tx_time_13 (ite $x1229 v_0_tx_time_14 (ite (= 10 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1343 (ite $x1221 v_0_tx_time_10 (ite $x1223 v_0_tx_time_11 (ite $x1225 v_0_tx_time_12 ?x1340)))))
 (let ((?x1346 (ite $x1215 v_0_tx_time_07 (ite $x1217 v_0_tx_time_08 (ite $x1219 v_0_tx_time_09 ?x1343)))))
 (let ((?x1349 (ite (or (>= 5 ?x816) $x1161) 0 (ite $x1212 (ite $x1213 v_0_tx_time_06 ?x1346) v_0_tx_time_05))))
 (let (($x1231 (= 10 ?x305)))
 (let ((?x1323 (ite $x1229 v_0_tx_time_13 (ite $x1231 v_0_tx_time_14 (ite (= 11 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1326 (ite $x1223 v_0_tx_time_10 (ite $x1225 v_0_tx_time_11 (ite $x1227 v_0_tx_time_12 ?x1323)))))
 (let ((?x1329 (ite $x1217 v_0_tx_time_07 (ite $x1219 v_0_tx_time_08 (ite $x1221 v_0_tx_time_09 ?x1326)))))
 (let ((?x1332 (ite $x1212 (ite $x1213 v_0_tx_time_05 (ite $x1215 v_0_tx_time_06 ?x1329)) v_0_tx_time_04)))
 (let (($x1233 (= 11 ?x305)))
 (let ((?x1305 (ite $x1231 v_0_tx_time_13 (ite $x1233 v_0_tx_time_14 (ite (= 12 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1308 (ite $x1225 v_0_tx_time_10 (ite $x1227 v_0_tx_time_11 (ite $x1229 v_0_tx_time_12 ?x1305)))))
 (let ((?x1311 (ite $x1219 v_0_tx_time_07 (ite $x1221 v_0_tx_time_08 (ite $x1223 v_0_tx_time_09 ?x1308)))))
 (let ((?x1314 (ite $x1213 v_0_tx_time_04 (ite $x1215 v_0_tx_time_05 (ite $x1217 v_0_tx_time_06 ?x1311)))))
 (let (($x1317 (= v_1_tx_time_03 (ite (or $x1161 (>= 3 ?x816)) 0 (ite $x1212 ?x1314 v_0_tx_time_03)))))
 (let (($x1235 (= 12 ?x305)))
 (let ((?x1286 (ite $x1233 v_0_tx_time_13 (ite $x1235 v_0_tx_time_14 (ite (= 13 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1289 (ite $x1227 v_0_tx_time_10 (ite $x1229 v_0_tx_time_11 (ite $x1231 v_0_tx_time_12 ?x1286)))))
 (let ((?x1292 (ite $x1221 v_0_tx_time_07 (ite $x1223 v_0_tx_time_08 (ite $x1225 v_0_tx_time_09 ?x1289)))))
 (let ((?x1295 (ite $x1215 v_0_tx_time_04 (ite $x1217 v_0_tx_time_05 (ite $x1219 v_0_tx_time_06 ?x1292)))))
 (let ((?x1298 (ite (or $x1161 (>= 2 ?x816)) 0 (ite $x1212 (ite $x1213 v_0_tx_time_03 ?x1295) v_0_tx_time_02))))
 (let (($x1237 (= 13 ?x305)))
 (let ((?x1266 (ite $x1235 v_0_tx_time_13 (ite $x1237 v_0_tx_time_14 (ite (= 14 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1269 (ite $x1229 v_0_tx_time_10 (ite $x1231 v_0_tx_time_11 (ite $x1233 v_0_tx_time_12 ?x1266)))))
 (let ((?x1272 (ite $x1223 v_0_tx_time_07 (ite $x1225 v_0_tx_time_08 (ite $x1227 v_0_tx_time_09 ?x1269)))))
 (let ((?x1275 (ite $x1217 v_0_tx_time_04 (ite $x1219 v_0_tx_time_05 (ite $x1221 v_0_tx_time_06 ?x1272)))))
 (let ((?x1278 (ite $x1212 (ite $x1213 v_0_tx_time_02 (ite $x1215 v_0_tx_time_03 ?x1275)) v_0_tx_time_01)))
 (let (($x1239 (= 14 ?x305)))
 (let ((?x1245 (ite $x1237 v_0_tx_time_13 (ite $x1239 v_0_tx_time_14 (ite (= 15 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1248 (ite $x1231 v_0_tx_time_10 (ite $x1233 v_0_tx_time_11 (ite $x1235 v_0_tx_time_12 ?x1245)))))
 (let ((?x1251 (ite $x1225 v_0_tx_time_07 (ite $x1227 v_0_tx_time_08 (ite $x1229 v_0_tx_time_09 ?x1248)))))
 (let ((?x1254 (ite $x1219 v_0_tx_time_04 (ite $x1221 v_0_tx_time_05 (ite $x1223 v_0_tx_time_06 ?x1251)))))
 (let ((?x1257 (ite $x1213 v_0_tx_time_01 (ite $x1215 v_0_tx_time_02 (ite $x1217 v_0_tx_time_03 ?x1254)))))
 (let (($x1261 (= v_1_tx_time_00 (ite (or (>= 0 ?x816) $x1161) 0 (ite $x1212 ?x1257 v_0_tx_time_00)))))
 (let (($x1195 (= v_1_rtt_sample_was_ambiguous (and v_0_rtt_active v_0_rtt_ambiguous))))
 (let (($x1190 (not v_1_rtt_start_new)))
 (let ((?x809 (* ?x278 ?x305)))
 (let ((?x1182 (+ ?x726 ?x809)))
 (let (($x1185 (and v_0_rtt_active $x301 $x319 $x340 (not (<= v_0_rtt_remaining ?x1182)))))
 (let ((?x1187 (ite (or (and v_0_rtt_active $x301 $x319 $x340 $x727) $x1163) 0 (ite $x1185 ?x1182 v_0_rtt_remaining))))
 (let (($x1178 (= v_1_rtt_end v_0_rtt_end)))
 (let (($x1177 (= v_1_rtt_start_ms v_0_rtt_start_ms)))
 (let (($x1165 (and v_0_rtt_active $x301 $x319 $x340 $x727)))
 (let (($x1166 (not $x1165)))
 (let (($x1153 (= v_1_rtt_previous_measured (ite $x730 v_0_rtt_measured v_0_rtt_previous_measured))))
 (let (($x1146 (= v_1_rtt_previous_var (ite $x730 v_0_rttvar_ms v_0_rtt_previous_var))))
 (let (($x1142 (= v_1_rtt_previous_srtt (ite $x730 v_0_srtt_ms v_0_rtt_previous_srtt))))
 (let ((?x1122 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data) 4294967296)))
 (let (($x1115 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x1111 (= v_1_fin_requested v_0_fin_requested)))
 (let ((?x1089 (ite (or (not (and $x375 (not $x657))) (and $x355 $x352 $x678)) 0 ?x654)))
 (let (($x905 (not $x657)))
 (let (($x709 (not $x375)))
 (let (($x874 (not $x414)))
 (let (($x872 (not $x434)))
 (let (($x870 (not $x454)))
 (let (($x868 (not $x474)))
 (let (($x866 (not $x494)))
 (let (($x864 (not $x514)))
 (let (($x862 (not $x532)))
 (let (($x860 (not $x550)))
 (let (($x858 (not $x568)))
 (let (($x856 (not $x586)))
 (let (($x854 (not $x604)))
 (let (($x852 (not $x622)))
 (let (($x850 (not $x640)))
 (let (($x849 (and false $x658)))
 (let (($x851 (and $x849 $x850)))
 (let (($x853 (and $x851 $x852)))
 (let (($x855 (and $x853 $x854)))
 (let (($x857 (and $x855 $x856)))
 (let (($x859 (and $x857 $x858)))
 (let (($x861 (and $x859 $x860)))
 (let (($x863 (and $x861 $x862)))
 (let (($x865 (and $x863 $x864)))
 (let (($x867 (and $x865 $x866)))
 (let (($x869 (and $x867 $x868)))
 (let (($x871 (and $x869 $x870)))
 (let (($x873 (and $x871 $x872)))
 (let (($x876 (or $x391 (and $x873 $x874) $x393)))
 (let ((?x703 (ite $x639 0 ?x636)))
 (let (($x679 (and $x355 $x352 $x678)))
 (let (($x1085 (= v_1_rx_slot_14 (ite $x679 0 (ite $x375 ?x703 (ite (and $x876 $x709 $x905) ?x654 0))))))
 (let (($x877 (and $x876 $x709)))
 (let ((?x1077 (ite $x877 ?x703 (ite (and (or $x873 $x414) (not $x394) $x709 $x905) ?x654 0))))
 (let ((?x702 (ite $x621 0 ?x618)))
 (let (($x879 (not $x394)))
 (let (($x878 (or $x873 $x414)))
 (let (($x880 (and $x878 $x879 $x709)))
 (let ((?x1070 (ite $x880 ?x703 (ite (and (or $x871 $x434) $x874 $x879 $x709 $x905) ?x654 0))))
 (let ((?x701 (ite $x603 0 ?x600)))
 (let (($x1074 (= v_1_rx_slot_12 (ite $x679 0 (ite $x375 ?x701 (ite $x877 ?x702 ?x1070))))))
 (let (($x881 (or $x871 $x434)))
 (let (($x882 (and $x881 $x874 $x879 $x709)))
 (let ((?x1062 (ite $x882 ?x703 (ite (and (or $x869 $x454) $x872 $x874 $x879 $x709 $x905) ?x654 0))))
 (let ((?x700 (ite $x585 0 ?x582)))
 (let (($x1067 (= v_1_rx_slot_11 (ite $x679 0 (ite $x375 ?x700 (ite $x877 ?x701 (ite $x880 ?x702 ?x1062)))))))
 (let (($x883 (or $x869 $x454)))
 (let (($x884 (and $x883 $x872 $x874 $x879 $x709)))
 (let ((?x1053 (ite $x884 ?x703 (ite (and (or $x867 $x474) $x870 $x872 $x874 $x879 $x709 $x905) ?x654 0))))
 (let ((?x699 (ite $x567 0 ?x564)))
 (let ((?x1058 (ite $x679 0 (ite $x375 ?x699 (ite $x877 ?x700 (ite $x880 ?x701 (ite $x882 ?x702 ?x1053)))))))
 (let ((?x1042 (ite (and (or $x865 $x494) $x868 $x870 $x872 $x874 $x879 $x709 $x905) ?x654 0)))
 (let (($x885 (or $x867 $x474)))
 (let (($x886 (and $x885 $x870 $x872 $x874 $x879 $x709)))
 (let ((?x1047 (ite $x877 ?x699 (ite $x880 ?x700 (ite $x882 ?x701 (ite $x884 ?x702 (ite $x886 ?x703 ?x1042)))))))
 (let ((?x698 (ite $x549 0 ?x546)))
 (let ((?x1031 (ite (and (or $x863 $x514) $x866 $x868 $x870 $x872 $x874 $x879 $x709 $x905) ?x654 0)))
 (let (($x887 (or $x865 $x494)))
 (let (($x888 (and $x887 $x868 $x870 $x872 $x874 $x879 $x709)))
 (let ((?x1036 (ite $x880 ?x699 (ite $x882 ?x700 (ite $x884 ?x701 (ite $x886 ?x702 (ite $x888 ?x703 ?x1031)))))))
 (let ((?x697 (ite $x531 0 ?x528)))
 (let (($x1040 (= v_1_rx_slot_08 (ite $x679 0 (ite $x375 ?x697 (ite $x877 ?x698 ?x1036))))))
 (let ((?x1019 (ite (and (or $x861 $x532) $x864 $x866 $x868 $x870 $x872 $x874 $x879 $x709 $x905) ?x654 0)))
 (let (($x889 (or $x863 $x514)))
 (let (($x890 (and $x889 $x866 $x868 $x870 $x872 $x874 $x879 $x709)))
 (let ((?x1024 (ite $x882 ?x699 (ite $x884 ?x700 (ite $x886 ?x701 (ite $x888 ?x702 (ite $x890 ?x703 ?x1019)))))))
 (let ((?x696 (ite $x513 0 ?x510)))
 (let (($x1029 (= v_1_rx_slot_07 (ite $x679 0 (ite $x375 ?x696 (ite $x877 ?x697 (ite $x880 ?x698 ?x1024)))))))
 (let (($x893 (or $x859 $x550)))
 (let ((?x1006 (ite (and $x893 $x862 $x864 $x866 $x868 $x870 $x872 $x874 $x879 $x709 $x905) ?x654 0)))
 (let (($x891 (or $x861 $x532)))
 (let (($x892 (and $x891 $x864 $x866 $x868 $x870 $x872 $x874 $x879 $x709)))
 (let ((?x1011 (ite $x884 ?x699 (ite $x886 ?x700 (ite $x888 ?x701 (ite $x890 ?x702 (ite $x892 ?x703 ?x1006)))))))
 (let ((?x695 (ite $x493 0 ?x490)))
 (let ((?x1016 (ite $x679 0 (ite $x375 ?x695 (ite $x877 ?x696 (ite $x880 ?x697 (ite $x882 ?x698 ?x1011)))))))
 (let (($x895 (or $x857 $x568)))
 (let ((?x992 (ite (and $x895 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x874 $x879 $x709 $x905) ?x654 0)))
 (let (($x894 (and $x893 $x862 $x864 $x866 $x868 $x870 $x872 $x874 $x879 $x709)))
 (let ((?x997 (ite $x886 ?x699 (ite $x888 ?x700 (ite $x890 ?x701 (ite $x892 ?x702 (ite $x894 ?x703 ?x992)))))))
 (let ((?x694 (ite $x473 0 ?x470)))
 (let ((?x1002 (ite $x375 ?x694 (ite $x877 ?x695 (ite $x880 ?x696 (ite $x882 ?x697 (ite $x884 ?x698 ?x997)))))))
 (let (($x897 (or $x855 $x586)))
 (let (($x976 (and $x897 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x874 $x879 $x709 $x905)))
 (let (($x896 (and $x895 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x874 $x879 $x709)))
 (let ((?x981 (ite $x890 ?x700 (ite $x892 ?x701 (ite $x894 ?x702 (ite $x896 ?x703 (ite $x976 ?x654 0)))))))
 (let ((?x986 (ite $x880 ?x695 (ite $x882 ?x696 (ite $x884 ?x697 (ite $x886 ?x698 (ite $x888 ?x699 ?x981)))))))
 (let ((?x693 (ite $x453 0 ?x450)))
 (let (($x990 (= v_1_rx_slot_04 (ite $x679 0 (ite $x375 ?x693 (ite $x877 ?x694 ?x986))))))
 (let (($x899 (or $x853 $x604)))
 (let (($x960 (and $x899 $x856 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x874 $x879 $x709 $x905)))
 (let (($x898 (and $x897 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x874 $x879 $x709)))
 (let ((?x965 (ite $x892 ?x700 (ite $x894 ?x701 (ite $x896 ?x702 (ite $x898 ?x703 (ite $x960 ?x654 0)))))))
 (let ((?x970 (ite $x882 ?x695 (ite $x884 ?x696 (ite $x886 ?x697 (ite $x888 ?x698 (ite $x890 ?x699 ?x965)))))))
 (let ((?x692 (ite $x433 0 ?x430)))
 (let (($x975 (= v_1_rx_slot_03 (ite $x679 0 (ite $x375 ?x692 (ite $x877 ?x693 (ite $x880 ?x694 ?x970)))))))
 (let (($x901 (or $x851 $x622)))
 (let (($x943 (and $x901 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x874 $x879 $x709 $x905)))
 (let (($x900 (and $x899 $x856 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x874 $x879 $x709)))
 (let ((?x948 (ite $x894 ?x700 (ite $x896 ?x701 (ite $x898 ?x702 (ite $x900 ?x703 (ite $x943 ?x654 0)))))))
 (let ((?x953 (ite $x884 ?x695 (ite $x886 ?x696 (ite $x888 ?x697 (ite $x890 ?x698 (ite $x892 ?x699 ?x948)))))))
 (let ((?x691 (ite $x413 0 ?x410)))
 (let ((?x958 (ite $x679 0 (ite $x375 ?x691 (ite $x877 ?x692 (ite $x880 ?x693 (ite $x882 ?x694 ?x953)))))))
 (let (($x903 (or $x849 $x640)))
 (let (($x925 (and $x903 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x874 $x879 $x709 $x905)))
 (let (($x902 (and $x901 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x874 $x879 $x709)))
 (let ((?x930 (ite $x896 ?x700 (ite $x898 ?x701 (ite $x900 ?x702 (ite $x902 ?x703 (ite $x925 ?x654 0)))))))
 (let ((?x935 (ite $x886 ?x695 (ite $x888 ?x696 (ite $x890 ?x697 (ite $x892 ?x698 (ite $x894 ?x699 ?x930)))))))
 (let ((?x690 (ite $x393 0 ?x390)))
 (let ((?x940 (ite $x375 ?x690 (ite $x877 ?x691 (ite $x880 ?x692 (ite $x882 ?x693 (ite $x884 ?x694 ?x935)))))))
 (let (($x906 (and $x658 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x874 $x879 $x709 $x905)))
 (let (($x904 (and $x903 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x874 $x879 $x709)))
 (let ((?x911 (ite $x898 ?x700 (ite $x900 ?x701 (ite $x902 ?x702 (ite $x904 ?x703 (ite $x906 ?x654 0)))))))
 (let ((?x916 (ite $x888 ?x695 (ite $x890 ?x696 (ite $x892 ?x697 (ite $x894 ?x698 (ite $x896 ?x699 ?x911)))))))
 (let ((?x921 (ite $x877 ?x690 (ite $x880 ?x691 (ite $x882 ?x692 (ite $x884 ?x693 (ite $x886 ?x694 ?x916)))))))
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
 (let (($x680 (not $x679)))
 (let (($x311 (= (mod (+ input_0_net.fin_segment_ack (* ?x278 v_0_snd_nxt)) 4294967296) 2147483648)))
 (and (>= now_1 now_0) (<= 0 input_0_net.fin_segment_data) (>= 16 input_0_net.fin_segment_data) (not (= ?x281 2147483648)) (<= 0 input_0_net.fin_segment_window) (>= 65535 input_0_net.fin_segment_window) (or (not $x301) (and (not (= ?x305 2147483648)) (not $x311))) v_0_fin_sent (not (= ?x305 (+ 1 v_0_rtx_buf))) $x319 (<= ?x305 (mod (+ v_0_snd_nxt (* ?x278 v_0_snd_una)) 4294967296)) (or (not active_0_rtx) (not (<= due_0_rtx now_1))) (or (not active_0_user) (not (<= due_0_user now_1))) (or (not active_0_time_wait) (not (<= due_0_time_wait now_1))) (or (not active_0_delack) (not (<= due_0_delack now_1))) (or (not active_0_persist) (not (<= due_0_persist now_1))) $x343 $x680 $x682 $x683 $x684 (= v_1_snd_una (ite $x685 input_0_net.fin_segment_ack v_0_snd_una)) $x688 $x717 $x718 $x719 $x722 (= v_1_rto_ms ?x788) $x792 $x795 $x798 $x801 (= v_1_local_window (+ 16 (* ?x278 v_0_rcv_buf) (* ?x278 ?x713))) $x807 (= v_1_rtx_buf ?x816) (= v_1_rcv_buf (+ v_0_rcv_buf ?x713)) (= v_1_snd_wnd ?x839) (= v_1_snd_wl1 (ite $x837 input_0_net.fin_segment_seq v_0_snd_wl1)) (= v_1_snd_wl2 (ite $x837 input_0_net.fin_segment_ack v_0_snd_wl2)) $x847 (= v_1_rx_chunk ?x713) (= v_1_rx_slot_00 (ite $x679 0 (ite $x375 ?x689 ?x921))) (= v_1_rx_slot_01 (ite $x679 0 ?x940)) (= v_1_rx_slot_02 ?x958) $x975 $x990 (= v_1_rx_slot_05 (ite $x679 0 ?x1002)) (= v_1_rx_slot_06 ?x1016) $x1029 $x1040 (= v_1_rx_slot_09 (ite $x679 0 (ite $x375 ?x698 ?x1047))) (= v_1_rx_slot_10 ?x1058) $x1067 $x1074 (= v_1_rx_slot_13 (ite $x679 0 (ite $x375 ?x702 ?x1077))) $x1085 (= v_1_rx_slot_15 ?x1089) (= v_1_rx_advance ?x674) (= v_1_rx_acceptable (and $x301 $x350 $x352)) (= v_1_seg_acceptable $x301) (= v_1_ack_delta ?x305) (= v_1_ack_is_new (and $x319 $x340)) (= v_1_ack_is_future $x349) (= v_1_ack_advance $x685) (= v_1_ack_window_update $x837) $x1111 (= v_1_fin_sent $x1113) $x1115 (= v_1_fin_acknowledged $x342) (= v_1_rx_fin_pending (and $x355 $x680)) (= v_1_rx_fin_seq (ite $x354 ?x1122 v_0_rx_fin_seq)) (= v_1_rx_fin_offset (ite $x679 0 ?x677)) (= v_1_rx_fin_done (or v_0_rx_fin_done $x679)) (= v_1_rx_fin_consumed $x679) (= v_1_srtt_ms ?x750) (= v_1_rttvar_ms ?x773) (= v_1_rtt_error_ms ?x766) $x1142 $x1146 (= v_1_rtt_measured (or v_0_rtt_measured $x730)) $x1153 (= v_1_rtt_active (and $x1164 v_0_rtt_active $x1166)) (= v_1_rtt_ambiguous (and $x1164 $x1166 v_0_rtt_ambiguous)) (= v_1_rtt_sample_at_ms (ite $x730 now_1 v_0_rtt_sample_at_ms)) $x1177 $x1178 (= v_1_rtt_remaining ?x1187) $x1190 (= v_1_rtt_sample_used $x730) $x1195 (= v_1_rtt_last_ms ?x745) (= v_1_rtt_samples (+ v_0_rtt_samples (ite $x730 1 0))) (= v_1_rto_base_ms (ite $x730 ?x786 v_0_rto_base_ms)) $x1261 (= v_1_tx_time_01 (ite (or $x1159 $x1161) 0 ?x1278)) (= v_1_tx_time_02 ?x1298) $x1317 (= v_1_tx_time_04 (ite (or (>= 4 ?x816) $x1161) 0 ?x1332)) (= v_1_tx_time_05 ?x1349) $x1365 (= v_1_tx_time_07 (ite (or (>= 7 ?x816) $x1161) 0 ?x1377)) (= v_1_tx_time_08 ?x1391) $x1404 (= v_1_tx_time_10 (ite (or (>= 10 ?x816) $x1161) 0 ?x1413)) (= v_1_tx_time_11 ?x1424) $x1434 (= v_1_tx_time_13 (ite (or (>= 13 ?x816) $x1161) 0 ?x1440)) (= v_1_tx_time_14 ?x1448) (= v_1_tx_time_15 ?x1453) (= v_1_tx_fin_time (ite $x1113 v_0_tx_fin_time 0)) $x1461 $x1464 $x1467 $x1469 $x1472 $x1475 $x1478 $x1480 $x1482 $x1484 $x1486 $x1488 $x1490 $x1492 $x1494 $x1497 $x1500 $x1502 $x1504 (= v_1_persist_active $x1163) (= v_1_persist_eligible $x1163) (= v_1_persist_start $x1511) $x1514 $x1516 $x1518 $x1520 (= v_1_persist_interval_ms (ite $x1163 ?x1523 1000)) $x1528 $x1533 (= v_1_persist_last_ms (ite $x1163 v_0_persist_last_ms 0)) $x1543 (= v_1_persist_probes (ite $x1163 v_0_persist_probes 0)) $x1550 (= active_1_rtx (or $x1564 $x1562)) (= active_1_user (and $x682 active_0_user)) (= active_1_time_wait (or active_0_time_wait $x681)) $x1574 $x1578 (= due_1_rtx ?x1589) $x1592 (= due_1_time_wait (ite $x681 ?x1595 due_0_time_wait)) $x1599 (= due_1_persist (ite $x1511 ?x1539 due_0_persist))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
 (let ((?x1608 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1608)))
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
 (let (($x1618 (not (>= v_0_rcv_buf 16))))
 (or $x1618 $x358))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x376 (= 0 v_0_rx_slot_01)))
 (let (($x1622 (not (>= v_0_rcv_buf 15))))
 (or $x1622 $x376))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x395 (= 0 v_0_rx_slot_02)))
 (let (($x1626 (not (>= v_0_rcv_buf 14))))
 (or $x1626 $x395))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x415 (= 0 v_0_rx_slot_03)))
 (let (($x1630 (not (>= v_0_rcv_buf 13))))
 (or $x1630 $x415))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x435 (= 0 v_0_rx_slot_04)))
 (let (($x1634 (not (>= v_0_rcv_buf 12))))
 (or $x1634 $x435))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x455 (= 0 v_0_rx_slot_05)))
 (let (($x1638 (not (>= v_0_rcv_buf 11))))
 (or $x1638 $x455))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x475 (= 0 v_0_rx_slot_06)))
 (let (($x1642 (not (>= v_0_rcv_buf 10))))
 (or $x1642 $x475))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x495 (= 0 v_0_rx_slot_07)))
 (let (($x1646 (not (>= v_0_rcv_buf 9))))
 (or $x1646 $x495))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x515 (= 0 v_0_rx_slot_08)))
 (let (($x1650 (not (>= v_0_rcv_buf 8))))
 (or $x1650 $x515))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x533 (= 0 v_0_rx_slot_09)))
 (let (($x1654 (not (>= v_0_rcv_buf 7))))
 (or $x1654 $x533))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x551 (= 0 v_0_rx_slot_10)))
 (let (($x1658 (not (>= v_0_rcv_buf 6))))
 (or $x1658 $x551))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x569 (= 0 v_0_rx_slot_11)))
 (let (($x1662 (not (>= v_0_rcv_buf 5))))
 (or $x1662 $x569))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x587 (= 0 v_0_rx_slot_12)))
 (let (($x1666 (not (>= v_0_rcv_buf 4))))
 (or $x1666 $x587))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x605 (= 0 v_0_rx_slot_13)))
 (let (($x1670 (not (>= v_0_rcv_buf 3))))
 (or $x1670 $x605))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x623 (= 0 v_0_rx_slot_14)))
 (let (($x1674 (not (>= v_0_rcv_buf 2))))
 (or $x1674 $x623))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x641 (= 0 v_0_rx_slot_15)))
 (let (($x1678 (not (>= v_0_rcv_buf 1))))
 (or $x1678 $x641))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x1680 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x1680)))
(assert
 (and (<= 0 v_0_rx_advance) (>= 16 v_0_rx_advance)))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (and (<= 0 v_0_ack_delta) (>= 4294967295 v_0_ack_delta)))
(assert
 true)
(assert
 (let ((?x1693 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x1693)))
(assert
 (let (($x1700 (and v_0_fin_requested (= v_0_fin_seq (mod (+ v_0_snd_una v_0_rtx_buf) 4294967296)) (= 0 v_0_snd_buf))))
 (let (($x1695 (not v_0_fin_sent)))
 (or $x1695 $x1700))))
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
 (let (($x1702 (<= 1 v_0_rx_fin_offset)))
 (let (($x352 (not v_0_rx_fin_done)))
 (let (($x1704 (and $x352 $x1702 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window)))))
 (let (($x353 (not v_0_rx_fin_pending)))
 (or $x353 $x1704))))))
(assert
 (let (($x1707 (>= 15 v_0_rx_fin_offset)))
 (and (<= 0 v_0_rx_fin_offset) $x1707 (= v_0_rx_fin_pending (<= 1 v_0_rx_fin_offset)))))
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
 (let ((?x1795 (* 4.0 v_0_rttvar_ms)))
 (let ((?x733 (- 1.0)))
 (let ((?x762 (* ?x733 v_0_srtt_ms)))
 (let ((?x1798 (+ ?x762 (* ?x733 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x1795)))))
 (let ((?x1799 (to_int ?x1798)))
 (let ((?x278 (- 1)))
 (let ((?x1802 (ite (<= ?x1799 (- 1000)) (* ?x278 ?x1799) 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x1802) 60000 ?x1802) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x321 (mod (+ v_0_snd_nxt (* (- 1) v_0_snd_una)) 4294967296)))
 (let ((?x726 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x1815 (and (<= v_0_rtt_start_ms now_0) (<= 1 v_0_rtt_remaining) (>= 4 v_0_rtt_remaining) (>= ?x726 v_0_rtt_remaining) (<= ?x726 ?x321))))
 (let (($x1809 (not v_0_rtt_active)))
 (or $x1809 $x1815))))))
(assert
 (let (($x1817 (= 0 v_0_rtt_remaining)))
 (or v_0_rtt_active $x1817)))
(assert
 true)
(assert
 (let (($x1824 (= v_0_rtt_last_ms (+ v_0_rtt_sample_at_ms (* (- 1) v_0_rtt_start_ms)))))
 (let (($x1822 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1820 (not v_0_rtt_sample_used)))
 (or $x1820 (and $x1822 v_0_rtt_measured $x1824))))))
(assert
 (and (<= 0 v_0_rtt_sample_at_ms) (<= v_0_rtt_sample_at_ms now_0)))
(assert
 (let ((?x1831 (to_real v_0_rtt_last_ms)))
 (let ((?x1845 (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x1831))))
 (let ((?x1833 (+ v_0_rtt_previous_srtt (* (- 1.0) ?x1831))))
 (let ((?x1837 (ite (>= ?x1833 0.0) ?x1833 (+ (* (- 1.0) v_0_rtt_previous_srtt) ?x1831))))
 (let ((?x757 (/ 1.0 4.0)))
 (let ((?x1841 (ite v_0_rtt_previous_measured (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* ?x757 ?x1837)) (* (/ 1.0 2.0) ?x1831))))
 (let (($x1848 (and (= v_0_rttvar_ms ?x1841) (= v_0_srtt_ms (ite v_0_rtt_previous_measured ?x1845 ?x1831)))))
 (let (($x1820 (not v_0_rtt_sample_used)))
 (or $x1820 $x1848))))))))))
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
 (let (($x1984 (and (>= v_0_tx_elapsed v_0_tx_previous_rto) (<= 1 v_0_tx_emit_count) (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x1978 (not v_0_tx_retransmitted)))
 (or $x1978 $x1984))))
(assert
 (let (($x1978 (not v_0_tx_retransmitted)))
 (or $x1978 (not v_0_tx_waiting))))
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
 (let (($x2015 (not v_0_ack_pending)))
 (or $x2015 (and (<= 1 v_0_ack_bytes) (not v_0_rx_fin_done)))))
(assert
 (let (($x2022 (and (= 0 v_0_ack_bytes) (= 0 v_0_ack_full_segments) (= 0 v_0_ack_since_ms))))
 (or v_0_ack_pending $x2022)))
(assert
 (let (($x186 (not active_0_rtx)))
 (let (($x1859 (>= 1 v_0_rtx_buf)))
 (let (($x1695 (not v_0_fin_sent)))
 (let (($x2031 (and (= 0 v_0_snd_wnd) $x1695 (<= 1 (+ v_0_rtx_buf v_0_snd_buf)) $x1859 $x186)))
 (let (($x1510 (not v_0_persist_active)))
 (let (($x2026 (and (<= 1 (+ v_0_rtx_buf (ite v_0_fin_sent 1 0))) $x1510)))
 (let (($x2024 (= v_0_persist_active active_0_persist)))
 (and $x2024 (= active_0_rtx $x2026) (or $x1510 $x2031))))))))))
(assert
 (let (($x1510 (not v_0_persist_active)))
 (or $x1510 (and (not v_0_rtt_active) (= 0 v_0_rtt_remaining)))))
(assert
 (and (<= 1000 v_0_persist_interval_ms) (>= 60000 v_0_persist_interval_ms) (<= 1000 v_0_persist_previous_interval_ms) (>= 60000 v_0_persist_previous_interval_ms) (<= 0 v_0_persist_probes) (<= 0 v_0_persist_elapsed_ms)))
(assert
 (and (<= 0 v_0_persist_since_ms) (<= v_0_persist_since_ms now_0) (<= 0 v_0_persist_last_ms) (<= v_0_persist_last_ms now_0) (<= 0 v_0_persist_deadline_ms)))
(assert
 (let (($x2049 (= 0 v_0_persist_probes)))
 (let ((?x2051 (+ (ite $x2049 v_0_persist_since_ms v_0_persist_last_ms) v_0_persist_interval_ms)))
 (let (($x1510 (not v_0_persist_active)))
 (or $x1510 (= v_0_persist_deadline_ms ?x2051))))))
(assert
 (let (($x2057 (= 1 v_0_rtx_buf)))
 (let (($x2055 (not v_0_persist_probe_sent)))
 (or $x2055 (and (>= v_0_persist_elapsed_ms v_0_persist_previous_interval_ms) $x2057)))))
(assert
 (let (($x2063 (= v_0_tx_time_00 v_0_persist_last_ms)))
 (let (($x2057 (= 1 v_0_rtx_buf)))
 (or (not (and v_0_persist_active (<= 1 v_0_persist_probes) $x2057)) $x2063))))
(assert
 (let (($x2049 (= 0 v_0_persist_probes)))
 (let (($x2068 (and (= 0 v_0_persist_since_ms) (= 0 v_0_persist_last_ms) (= 0 v_0_persist_deadline_ms) $x2049)))
 (or v_0_persist_active $x2068))))
(assert
 (= 178 choice_0))
(assert
 (= 5 state_0))
(assert
 (= 5 state_1))
(assert
 (or (not (<= v_1_tx_time_07 now_1))))
(check-sat)
