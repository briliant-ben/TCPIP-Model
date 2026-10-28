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
 (let (($x725 (not v_0_rtt_ambiguous)))
 (let ((?x722 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let ((?x305 (mod (+ input_0_net.fin_segment_ack (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x723 (>= ?x305 ?x722)))
 (let ((?x334 (ite v_0_fin_sent 1 0)))
 (let ((?x335 (+ v_0_rtx_buf ?x334)))
 (let (($x336 (<= ?x305 ?x335)))
 (let (($x333 (<= 1 ?x305)))
 (let ((?x278 (- 1)))
 (let ((?x294 (+ ?x278 v_0_local_window)))
 (let ((?x291 (* ?x278 v_0_rcv_nxt)))
 (let ((?x298 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data ?x291) 4294967296)))
 (let (($x299 (<= ?x298 ?x294)))
 (let (($x290 (<= 1 v_0_local_window)))
 (let (($x301 (or (and $x290 (<= (mod (+ input_0_net.fin_segment_seq ?x291) 4294967296) ?x294)) (and $x290 $x299))))
 (let (($x726 (and v_0_rtt_active $x301 $x333 $x336 $x723 $x725)))
 (let ((?x741 (ite $x726 (+ now_1 (* ?x278 v_0_rtt_start_ms)) v_0_rtt_last_ms)))
 (let ((?x742 (to_real ?x741)))
 (let ((?x766 (/ 1.0 2.0)))
 (let ((?x755 (+ v_0_srtt_ms (* (- 1.0) ?x742))))
 (let ((?x762 (ite $x726 (ite (>= ?x755 0.0) ?x755 (+ (* (- 1.0) v_0_srtt_ms) ?x742)) v_0_rtt_error_ms)))
 (let ((?x753 (/ 1.0 4.0)))
 (let ((?x768 (ite v_0_rtt_measured (+ (* (/ 3.0 4.0) v_0_rttvar_ms) (* ?x753 ?x762)) (* ?x766 ?x742))))
 (let ((?x769 (ite $x726 ?x768 v_0_rttvar_ms)))
 (let ((?x729 (- 1.0)))
 (let ((?x745 (ite v_0_rtt_measured (+ (* (/ 7.0 8.0) v_0_srtt_ms) (* (/ 1.0 8.0) ?x742)) ?x742)))
 (let ((?x746 (ite $x726 ?x745 v_0_srtt_ms)))
 (let ((?x774 (+ (* ?x729 ?x746) (* ?x729 (ite (<= ?x769 ?x753) 1.0 (* 4.0 ?x769))))))
 (let ((?x775 (to_int ?x774)))
 (let ((?x779 (* ?x278 ?x775)))
 (let ((?x780 (ite (<= ?x775 (- 1000)) ?x779 1000)))
 (let ((?x782 (ite (<= 60000 ?x780) 60000 ?x780)))
 (let ((?x784 (ite $x726 ?x782 v_0_rto_ms)))
 (let (($x1506 (not v_0_persist_active)))
 (let ((?x809 (ite (<= 0 v_0_rtx_buf) v_0_rtx_buf 0)))
 (let ((?x807 (ite (<= v_0_rtx_buf ?x305) 0 (+ v_0_rtx_buf (* ?x278 ?x305)))))
 (let (($x681 (and $x301 $x333 $x336)))
 (let ((?x812 (ite $x681 (ite (<= ?x807 ?x809) ?x807 ?x809) v_0_rtx_buf)))
 (let (($x1158 (= 0 ?x812)))
 (let (($x1159 (or v_0_persist_active $x1158)))
 (let (($x1156 (>= 1 ?x812)))
 (let (($x1155 (<= 1 (+ ?x812 v_0_snd_buf))))
 (let (($x337 (= ?x305 ?x335)))
 (let (($x338 (and $x301 $x333 $x336 v_0_fin_sent $x337)))
 (let (($x339 (not $x338)))
 (let (($x1110 (and $x339 v_0_fin_sent)))
 (let (($x1153 (not $x1110)))
 (let (($x829 (<= 2147483648 (mod (+ input_0_net.fin_segment_ack (* ?x278 v_0_snd_wl2)) 4294967296))))
 (let (($x825 (= v_0_snd_wl1 input_0_net.fin_segment_seq)))
 (let ((?x819 (mod (+ input_0_net.fin_segment_seq (* ?x278 v_0_snd_wl1)) 4294967296)))
 (let (($x832 (or (and (not (<= ?x819 0)) (not (<= 2147483648 ?x819))) (and $x825 (not $x829)))))
 (let (($x833 (and $x301 $x336 $x832)))
 (let ((?x835 (ite $x833 input_0_net.fin_segment_window v_0_snd_wnd)))
 (let (($x1152 (= 0 ?x835)))
 (let (($x1507 (and $x1152 $x1153 $x1155 $x1156 $x1159 $x1506)))
 (let ((?x1519 (ite $x1507 ?x784 v_0_persist_interval_ms)))
 (let ((?x1535 (+ now_1 ?x1519)))
 (let (($x1595 (= due_1_delack due_0_delack)))
 (let ((?x1591 (+ now_1 (* 2 v_0_msl_ms))))
 (let (($x349 (not v_0_rx_fin_pending)))
 (let (($x348 (not v_0_rx_fin_done)))
 (let (($x345 (and (>= ?x305 (+ 1 v_0_rtx_buf ?x334)) (>= 2147483647 ?x305))))
 (let (($x346 (not $x345)))
 (let (($x350 (and $x301 $x346 $x348 $x349 $x290 $x299)))
 (let ((?x353 (ite $x350 ?x298 v_0_rx_fin_offset)))
 (let (($x351 (or v_0_rx_fin_pending $x350)))
 (let (($x653 (and $x351 (>= 15 ?x353))))
 (let ((?x640 (mod (+ 15 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x645 (+ input_0_net.fin_segment_data (* ?x278 ?x640))))
 (let (($x643 (<= input_0_net.fin_segment_data ?x640)))
 (let (($x638 (<= v_0_rcv_buf 0)))
 (let (($x637 (= 0 v_0_rx_slot_15)))
 (let (($x642 (and $x301 $x346 $x348 $x637 $x638 (<= ?x640 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x650 (ite $x642 (ite (or $x643 (<= ?x645 1)) (ite $x643 0 ?x645) 1) v_0_rx_slot_15)))
 (let (($x654 (or (= ?x650 0) $x653)))
 (let (($x635 (and $x351 (>= 14 ?x353))))
 (let ((?x622 (mod (+ 14 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x627 (+ input_0_net.fin_segment_data (* ?x278 ?x622))))
 (let (($x625 (<= input_0_net.fin_segment_data ?x622)))
 (let (($x620 (<= v_0_rcv_buf 1)))
 (let (($x619 (= 0 v_0_rx_slot_14)))
 (let (($x624 (and $x301 $x346 $x348 $x619 $x620 (<= ?x622 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x632 (ite $x624 (ite (or $x625 (<= ?x627 1)) (ite $x625 0 ?x627) 1) v_0_rx_slot_14)))
 (let (($x636 (or (= ?x632 0) $x635)))
 (let (($x617 (and $x351 (>= 13 ?x353))))
 (let ((?x604 (mod (+ 13 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x609 (+ input_0_net.fin_segment_data (* ?x278 ?x604))))
 (let (($x607 (<= input_0_net.fin_segment_data ?x604)))
 (let (($x602 (<= v_0_rcv_buf 2)))
 (let (($x601 (= 0 v_0_rx_slot_13)))
 (let (($x606 (and $x301 $x346 $x348 $x601 $x602 (<= ?x604 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x614 (ite $x606 (ite (or $x607 (<= ?x609 1)) (ite $x607 0 ?x609) 1) v_0_rx_slot_13)))
 (let (($x618 (or (= ?x614 0) $x617)))
 (let (($x599 (and $x351 (>= 12 ?x353))))
 (let ((?x586 (mod (+ 12 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x591 (+ input_0_net.fin_segment_data (* ?x278 ?x586))))
 (let (($x589 (<= input_0_net.fin_segment_data ?x586)))
 (let (($x584 (<= v_0_rcv_buf 3)))
 (let (($x583 (= 0 v_0_rx_slot_12)))
 (let (($x588 (and $x301 $x346 $x348 $x583 $x584 (<= ?x586 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x596 (ite $x588 (ite (or $x589 (<= ?x591 1)) (ite $x589 0 ?x591) 1) v_0_rx_slot_12)))
 (let (($x600 (or (= ?x596 0) $x599)))
 (let ((?x658 (ite $x600 12 (ite $x618 13 (ite $x636 14 (ite $x654 15 16))))))
 (let (($x581 (and $x351 (>= 11 ?x353))))
 (let ((?x568 (mod (+ 11 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x573 (+ input_0_net.fin_segment_data (* ?x278 ?x568))))
 (let (($x571 (<= input_0_net.fin_segment_data ?x568)))
 (let (($x566 (<= v_0_rcv_buf 4)))
 (let (($x565 (= 0 v_0_rx_slot_11)))
 (let (($x570 (and $x301 $x346 $x348 $x565 $x566 (<= ?x568 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x578 (ite $x570 (ite (or $x571 (<= ?x573 1)) (ite $x571 0 ?x573) 1) v_0_rx_slot_11)))
 (let (($x582 (or (= ?x578 0) $x581)))
 (let (($x563 (and $x351 (>= 10 ?x353))))
 (let ((?x550 (mod (+ 10 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x555 (+ input_0_net.fin_segment_data (* ?x278 ?x550))))
 (let (($x553 (<= input_0_net.fin_segment_data ?x550)))
 (let (($x548 (<= v_0_rcv_buf 5)))
 (let (($x547 (= 0 v_0_rx_slot_10)))
 (let (($x552 (and $x301 $x346 $x348 $x547 $x548 (<= ?x550 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x560 (ite $x552 (ite (or $x553 (<= ?x555 1)) (ite $x553 0 ?x555) 1) v_0_rx_slot_10)))
 (let (($x564 (or (= ?x560 0) $x563)))
 (let (($x545 (and $x351 (>= 9 ?x353))))
 (let ((?x532 (mod (+ 9 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x537 (+ input_0_net.fin_segment_data (* ?x278 ?x532))))
 (let (($x535 (<= input_0_net.fin_segment_data ?x532)))
 (let (($x530 (<= v_0_rcv_buf 6)))
 (let (($x529 (= 0 v_0_rx_slot_09)))
 (let (($x534 (and $x301 $x346 $x348 $x529 $x530 (<= ?x532 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x542 (ite $x534 (ite (or $x535 (<= ?x537 1)) (ite $x535 0 ?x537) 1) v_0_rx_slot_09)))
 (let (($x546 (or (= ?x542 0) $x545)))
 (let (($x527 (and $x351 (>= 8 ?x353))))
 (let ((?x514 (mod (+ 8 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x519 (+ input_0_net.fin_segment_data (* ?x278 ?x514))))
 (let (($x517 (<= input_0_net.fin_segment_data ?x514)))
 (let (($x512 (<= v_0_rcv_buf 7)))
 (let (($x511 (= 0 v_0_rx_slot_08)))
 (let (($x516 (and $x301 $x346 $x348 $x511 $x512 (<= ?x514 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x524 (ite $x516 (ite (or $x517 (<= ?x519 1)) (ite $x517 0 ?x519) 1) v_0_rx_slot_08)))
 (let (($x528 (or (= ?x524 0) $x527)))
 (let ((?x662 (ite $x528 8 (ite $x546 9 (ite $x564 10 (ite $x582 11 ?x658))))))
 (let (($x509 (and $x351 (>= 7 ?x353))))
 (let ((?x496 (mod (+ 7 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x501 (+ input_0_net.fin_segment_data (* ?x278 ?x496))))
 (let (($x499 (<= input_0_net.fin_segment_data ?x496)))
 (let (($x493 (<= v_0_rcv_buf 8)))
 (let (($x491 (= 0 v_0_rx_slot_07)))
 (let (($x498 (and $x301 $x346 $x348 $x491 $x493 (<= ?x496 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x506 (ite $x498 (ite (or $x499 (<= ?x501 1)) (ite $x499 0 ?x501) 1) v_0_rx_slot_07)))
 (let (($x510 (or (= ?x506 0) $x509)))
 (let (($x489 (and $x351 (>= 6 ?x353))))
 (let ((?x476 (mod (+ 6 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x481 (+ input_0_net.fin_segment_data (* ?x278 ?x476))))
 (let (($x479 (<= input_0_net.fin_segment_data ?x476)))
 (let (($x473 (<= v_0_rcv_buf 9)))
 (let (($x471 (= 0 v_0_rx_slot_06)))
 (let (($x478 (and $x301 $x346 $x348 $x471 $x473 (<= ?x476 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x486 (ite $x478 (ite (or $x479 (<= ?x481 1)) (ite $x479 0 ?x481) 1) v_0_rx_slot_06)))
 (let (($x490 (or (= ?x486 0) $x489)))
 (let (($x469 (and $x351 (>= 5 ?x353))))
 (let ((?x456 (mod (+ 5 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x461 (+ input_0_net.fin_segment_data (* ?x278 ?x456))))
 (let (($x459 (<= input_0_net.fin_segment_data ?x456)))
 (let (($x453 (<= v_0_rcv_buf 10)))
 (let (($x451 (= 0 v_0_rx_slot_05)))
 (let (($x458 (and $x301 $x346 $x348 $x451 $x453 (<= ?x456 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x466 (ite $x458 (ite (or $x459 (<= ?x461 1)) (ite $x459 0 ?x461) 1) v_0_rx_slot_05)))
 (let (($x470 (or (= ?x466 0) $x469)))
 (let (($x449 (and $x351 (>= 4 ?x353))))
 (let ((?x436 (mod (+ 4 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x441 (+ input_0_net.fin_segment_data (* ?x278 ?x436))))
 (let (($x439 (<= input_0_net.fin_segment_data ?x436)))
 (let (($x433 (<= v_0_rcv_buf 11)))
 (let (($x431 (= 0 v_0_rx_slot_04)))
 (let (($x438 (and $x301 $x346 $x348 $x431 $x433 (<= ?x436 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x446 (ite $x438 (ite (or $x439 (<= ?x441 1)) (ite $x439 0 ?x441) 1) v_0_rx_slot_04)))
 (let (($x450 (or (= ?x446 0) $x449)))
 (let ((?x666 (ite $x450 4 (ite $x470 5 (ite $x490 6 (ite $x510 7 ?x662))))))
 (let (($x429 (and $x351 (>= 3 ?x353))))
 (let ((?x416 (mod (+ 3 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x421 (+ input_0_net.fin_segment_data (* ?x278 ?x416))))
 (let (($x419 (<= input_0_net.fin_segment_data ?x416)))
 (let (($x413 (<= v_0_rcv_buf 12)))
 (let (($x411 (= 0 v_0_rx_slot_03)))
 (let (($x418 (and $x301 $x346 $x348 $x411 $x413 (<= ?x416 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x426 (ite $x418 (ite (or $x419 (<= ?x421 1)) (ite $x419 0 ?x421) 1) v_0_rx_slot_03)))
 (let (($x430 (or (= ?x426 0) $x429)))
 (let (($x409 (and $x351 (>= 2 ?x353))))
 (let ((?x396 (mod (+ 2 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x401 (+ input_0_net.fin_segment_data (* ?x278 ?x396))))
 (let (($x399 (<= input_0_net.fin_segment_data ?x396)))
 (let (($x393 (<= v_0_rcv_buf 13)))
 (let (($x391 (= 0 v_0_rx_slot_02)))
 (let (($x398 (and $x301 $x346 $x348 $x391 $x393 (<= ?x396 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x406 (ite $x398 (ite (or $x399 (<= ?x401 1)) (ite $x399 0 ?x401) 1) v_0_rx_slot_02)))
 (let (($x410 (or (= ?x406 0) $x409)))
 (let (($x389 (and $x351 (>= 1 ?x353))))
 (let ((?x376 (mod (+ 1 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x381 (+ input_0_net.fin_segment_data (* ?x278 ?x376))))
 (let (($x379 (<= input_0_net.fin_segment_data ?x376)))
 (let (($x374 (<= v_0_rcv_buf 14)))
 (let (($x372 (= 0 v_0_rx_slot_01)))
 (let (($x378 (and $x301 $x346 $x348 $x372 $x374 (<= ?x376 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x386 (ite $x378 (ite (or $x379 (<= ?x381 1)) (ite $x379 0 ?x381) 1) v_0_rx_slot_01)))
 (let (($x387 (= ?x386 0)))
 (let (($x390 (or $x387 $x389)))
 (let ((?x669 (ite $x390 1 (ite $x410 2 (ite $x430 3 ?x666)))))
 (let (($x370 (and $x351 (>= 0 ?x353))))
 (let ((?x281 (mod (+ v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x362 (+ input_0_net.fin_segment_data (* ?x278 ?x281))))
 (let (($x360 (<= input_0_net.fin_segment_data ?x281)))
 (let (($x356 (<= v_0_rcv_buf 15)))
 (let (($x354 (= 0 v_0_rx_slot_00)))
 (let (($x359 (and $x301 $x346 $x348 $x354 $x356 (<= ?x281 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x367 (ite $x359 (ite (or $x360 (<= ?x362 1)) (ite $x360 0 ?x362) 1) v_0_rx_slot_00)))
 (let (($x368 (= ?x367 0)))
 (let (($x371 (or $x368 $x370)))
 (let ((?x670 (ite $x371 0 ?x669)))
 (let ((?x673 (ite $x351 (+ ?x353 (* ?x278 ?x670)) ?x353)))
 (let (($x674 (= 0 ?x673)))
 (let (($x677 (and $x351 $x348 $x674 $x301 $x333 $x336 v_0_fin_sent $x337)))
 (let (($x1588 (= due_1_user due_0_user)))
 (let ((?x1580 (ite (<= (- 999.0) ?x774) 1000 ?x779)))
 (let (($x1556 (and $x301 $x333 $x336 (<= 1 (+ ?x812 (ite $x1110 1 0))))))
 (let (($x1554 (and (not (and $x301 $x333 $x336 (= 0 (+ ?x812 (ite $x1110 1 0))))) active_0_rtx)))
 (let (($x678 (not $x677)))
 (let (($x1160 (and $x1152 $x1153 $x1155 $x1156 $x1159)))
 (let (($x1161 (not $x1160)))
 (let (($x1558 (and $x1161 $x678 (or $x1554 $x1556))))
 (let (($x1560 (and v_0_persist_active $x1161 (<= 1 ?x812) (not $x1558))))
 (let ((?x1585 (ite (or $x1560 $x1556) (+ now_1 (ite $x726 (ite (<= 60000 ?x1580) 60000 ?x1580) v_0_rto_ms)) due_0_rtx)))
 (let (($x1574 (= active_1_persist (and $x1152 $x1153 $x1155 $x1156 $x1159 (or active_0_persist $x1507)))))
 (let (($x1570 (not active_1_delack)))
 (let (($x1546 (= v_1_persist_elapsed_ms v_0_persist_elapsed_ms)))
 (let (($x1539 (= v_1_persist_deadline_ms (ite $x1160 (ite $x1507 ?x1535 v_0_persist_deadline_ms) 0))))
 (let (($x1529 (= v_1_persist_since_ms (ite $x1160 (ite $x1507 now_1 v_0_persist_since_ms) 0))))
 (let (($x1524 (= v_1_persist_previous_interval_ms v_0_persist_previous_interval_ms)))
 (let (($x1516 (not v_1_persist_probe_new)))
 (let (($x1514 (not v_1_persist_probe_sent)))
 (let (($x1512 (not v_1_persist_first)))
 (let (($x1510 (= v_1_persist_was_active v_0_persist_active)))
 (let (($x1500 (not v_1_ack_defer_now)))
 (let (($x1498 (not v_1_ack_defer_candidate)))
 (let (($x1496 (= v_1_ack_rmss v_0_ack_rmss)))
 (let (($x1493 (= v_1_ack_delay_ms v_0_ack_delay_ms)))
 (let (($x1490 (= v_1_ack_full_segments 0)))
 (let (($x1488 (= v_1_ack_bytes 0)))
 (let (($x1486 (= v_1_ack_since_ms 0)))
 (let (($x1484 (not v_1_ack_pending)))
 (let (($x1482 (not v_1_syn_timeout_eligible)))
 (let (($x1480 (not v_1_tx_syn_pending)))
 (let (($x1478 (= v_1_tx_syn_time 0)))
 (let (($x1476 (not v_1_tx_waiting)))
 (let (($x1474 (= v_1_tx_is_fin v_0_tx_is_fin)))
 (let (($x1471 (= v_1_tx_previous_rto v_0_tx_previous_rto)))
 (let (($x1468 (= v_1_tx_elapsed v_0_tx_elapsed)))
 (let (($x1465 (not v_1_tx_retransmitted)))
 (let (($x1463 (= v_1_tx_max_previous v_0_tx_max_previous)))
 (let (($x1460 (= v_1_tx_eligible v_0_tx_eligible)))
 (let (($x1457 (= v_1_tx_emit_count v_0_tx_emit_count)))
 (let ((?x1449 (ite (or (>= 15 ?x812) $x1158 (and $x301 $x333 $x336 (not (= 0 ?x305)))) 0 v_0_tx_time_15)))
 (let (($x1208 (and $x301 $x333 $x336 (not (= 0 ?x305)))))
 (let ((?x1444 (ite (or $x1158 (>= 14 ?x812)) 0 (ite $x1208 (ite (= 1 ?x305) v_0_tx_time_15 0) v_0_tx_time_14))))
 (let (($x1209 (= 1 ?x305)))
 (let ((?x1436 (ite $x1208 (ite $x1209 v_0_tx_time_14 (ite (= 2 ?x305) v_0_tx_time_15 0)) v_0_tx_time_13)))
 (let (($x1211 (= 2 ?x305)))
 (let ((?x1427 (ite $x1209 v_0_tx_time_13 (ite $x1211 v_0_tx_time_14 (ite (= 3 ?x305) v_0_tx_time_15 0)))))
 (let (($x1430 (= v_1_tx_time_12 (ite (or $x1158 (>= 12 ?x812)) 0 (ite $x1208 ?x1427 v_0_tx_time_12)))))
 (let (($x1213 (= 3 ?x305)))
 (let ((?x1417 (ite $x1211 v_0_tx_time_13 (ite $x1213 v_0_tx_time_14 (ite (= 4 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1420 (ite (or $x1158 (>= 11 ?x812)) 0 (ite $x1208 (ite $x1209 v_0_tx_time_12 ?x1417) v_0_tx_time_11))))
 (let (($x1215 (= 4 ?x305)))
 (let ((?x1406 (ite $x1213 v_0_tx_time_13 (ite $x1215 v_0_tx_time_14 (ite (= 5 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1409 (ite $x1208 (ite $x1209 v_0_tx_time_11 (ite $x1211 v_0_tx_time_12 ?x1406)) v_0_tx_time_10)))
 (let (($x1217 (= 5 ?x305)))
 (let ((?x1394 (ite $x1215 v_0_tx_time_13 (ite $x1217 v_0_tx_time_14 (ite (= 6 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1397 (ite $x1209 v_0_tx_time_10 (ite $x1211 v_0_tx_time_11 (ite $x1213 v_0_tx_time_12 ?x1394)))))
 (let (($x1400 (= v_1_tx_time_09 (ite (or $x1158 (>= 9 ?x812)) 0 (ite $x1208 ?x1397 v_0_tx_time_09)))))
 (let (($x1219 (= 6 ?x305)))
 (let ((?x1381 (ite $x1217 v_0_tx_time_13 (ite $x1219 v_0_tx_time_14 (ite (= 7 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1384 (ite $x1211 v_0_tx_time_10 (ite $x1213 v_0_tx_time_11 (ite $x1215 v_0_tx_time_12 ?x1381)))))
 (let ((?x1387 (ite (or $x1158 (>= 8 ?x812)) 0 (ite $x1208 (ite $x1209 v_0_tx_time_09 ?x1384) v_0_tx_time_08))))
 (let (($x1221 (= 7 ?x305)))
 (let ((?x1367 (ite $x1219 v_0_tx_time_13 (ite $x1221 v_0_tx_time_14 (ite (= 8 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1370 (ite $x1213 v_0_tx_time_10 (ite $x1215 v_0_tx_time_11 (ite $x1217 v_0_tx_time_12 ?x1367)))))
 (let ((?x1373 (ite $x1208 (ite $x1209 v_0_tx_time_08 (ite $x1211 v_0_tx_time_09 ?x1370)) v_0_tx_time_07)))
 (let (($x1223 (= 8 ?x305)))
 (let ((?x1352 (ite $x1221 v_0_tx_time_13 (ite $x1223 v_0_tx_time_14 (ite (= 9 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1355 (ite $x1215 v_0_tx_time_10 (ite $x1217 v_0_tx_time_11 (ite $x1219 v_0_tx_time_12 ?x1352)))))
 (let ((?x1358 (ite $x1209 v_0_tx_time_07 (ite $x1211 v_0_tx_time_08 (ite $x1213 v_0_tx_time_09 ?x1355)))))
 (let (($x1361 (= v_1_tx_time_06 (ite (or $x1158 (>= 6 ?x812)) 0 (ite $x1208 ?x1358 v_0_tx_time_06)))))
 (let (($x1225 (= 9 ?x305)))
 (let ((?x1336 (ite $x1223 v_0_tx_time_13 (ite $x1225 v_0_tx_time_14 (ite (= 10 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1339 (ite $x1217 v_0_tx_time_10 (ite $x1219 v_0_tx_time_11 (ite $x1221 v_0_tx_time_12 ?x1336)))))
 (let ((?x1342 (ite $x1211 v_0_tx_time_07 (ite $x1213 v_0_tx_time_08 (ite $x1215 v_0_tx_time_09 ?x1339)))))
 (let ((?x1345 (ite (or $x1158 (>= 5 ?x812)) 0 (ite $x1208 (ite $x1209 v_0_tx_time_06 ?x1342) v_0_tx_time_05))))
 (let (($x1227 (= 10 ?x305)))
 (let ((?x1319 (ite $x1225 v_0_tx_time_13 (ite $x1227 v_0_tx_time_14 (ite (= 11 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1322 (ite $x1219 v_0_tx_time_10 (ite $x1221 v_0_tx_time_11 (ite $x1223 v_0_tx_time_12 ?x1319)))))
 (let ((?x1325 (ite $x1213 v_0_tx_time_07 (ite $x1215 v_0_tx_time_08 (ite $x1217 v_0_tx_time_09 ?x1322)))))
 (let ((?x1328 (ite $x1208 (ite $x1209 v_0_tx_time_05 (ite $x1211 v_0_tx_time_06 ?x1325)) v_0_tx_time_04)))
 (let (($x1229 (= 11 ?x305)))
 (let ((?x1301 (ite $x1227 v_0_tx_time_13 (ite $x1229 v_0_tx_time_14 (ite (= 12 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1304 (ite $x1221 v_0_tx_time_10 (ite $x1223 v_0_tx_time_11 (ite $x1225 v_0_tx_time_12 ?x1301)))))
 (let ((?x1307 (ite $x1215 v_0_tx_time_07 (ite $x1217 v_0_tx_time_08 (ite $x1219 v_0_tx_time_09 ?x1304)))))
 (let ((?x1310 (ite $x1209 v_0_tx_time_04 (ite $x1211 v_0_tx_time_05 (ite $x1213 v_0_tx_time_06 ?x1307)))))
 (let (($x1313 (= v_1_tx_time_03 (ite (or $x1158 (>= 3 ?x812)) 0 (ite $x1208 ?x1310 v_0_tx_time_03)))))
 (let (($x1231 (= 12 ?x305)))
 (let ((?x1282 (ite $x1229 v_0_tx_time_13 (ite $x1231 v_0_tx_time_14 (ite (= 13 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1285 (ite $x1223 v_0_tx_time_10 (ite $x1225 v_0_tx_time_11 (ite $x1227 v_0_tx_time_12 ?x1282)))))
 (let ((?x1288 (ite $x1217 v_0_tx_time_07 (ite $x1219 v_0_tx_time_08 (ite $x1221 v_0_tx_time_09 ?x1285)))))
 (let ((?x1291 (ite $x1211 v_0_tx_time_04 (ite $x1213 v_0_tx_time_05 (ite $x1215 v_0_tx_time_06 ?x1288)))))
 (let ((?x1294 (ite (or $x1158 (>= 2 ?x812)) 0 (ite $x1208 (ite $x1209 v_0_tx_time_03 ?x1291) v_0_tx_time_02))))
 (let (($x1233 (= 13 ?x305)))
 (let ((?x1262 (ite $x1231 v_0_tx_time_13 (ite $x1233 v_0_tx_time_14 (ite (= 14 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1265 (ite $x1225 v_0_tx_time_10 (ite $x1227 v_0_tx_time_11 (ite $x1229 v_0_tx_time_12 ?x1262)))))
 (let ((?x1268 (ite $x1219 v_0_tx_time_07 (ite $x1221 v_0_tx_time_08 (ite $x1223 v_0_tx_time_09 ?x1265)))))
 (let ((?x1271 (ite $x1213 v_0_tx_time_04 (ite $x1215 v_0_tx_time_05 (ite $x1217 v_0_tx_time_06 ?x1268)))))
 (let ((?x1274 (ite $x1208 (ite $x1209 v_0_tx_time_02 (ite $x1211 v_0_tx_time_03 ?x1271)) v_0_tx_time_01)))
 (let (($x1235 (= 14 ?x305)))
 (let ((?x1241 (ite $x1233 v_0_tx_time_13 (ite $x1235 v_0_tx_time_14 (ite (= 15 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1244 (ite $x1227 v_0_tx_time_10 (ite $x1229 v_0_tx_time_11 (ite $x1231 v_0_tx_time_12 ?x1241)))))
 (let ((?x1247 (ite $x1221 v_0_tx_time_07 (ite $x1223 v_0_tx_time_08 (ite $x1225 v_0_tx_time_09 ?x1244)))))
 (let ((?x1250 (ite $x1215 v_0_tx_time_04 (ite $x1217 v_0_tx_time_05 (ite $x1219 v_0_tx_time_06 ?x1247)))))
 (let ((?x1253 (ite $x1209 v_0_tx_time_01 (ite $x1211 v_0_tx_time_02 (ite $x1213 v_0_tx_time_03 ?x1250)))))
 (let (($x1257 (= v_1_tx_time_00 (ite (or $x1158 (>= 0 ?x812)) 0 (ite $x1208 ?x1253 v_0_tx_time_00)))))
 (let (($x1192 (= v_1_rtt_sample_was_ambiguous (and v_0_rtt_active v_0_rtt_ambiguous))))
 (let (($x1187 (not v_1_rtt_start_new)))
 (let ((?x805 (* ?x278 ?x305)))
 (let ((?x1179 (+ ?x722 ?x805)))
 (let (($x1182 (and v_0_rtt_active $x301 $x333 $x336 (not (<= v_0_rtt_remaining ?x1179)))))
 (let ((?x1184 (ite (or $x1160 (and v_0_rtt_active $x301 $x333 $x336 $x723)) 0 (ite $x1182 ?x1179 v_0_rtt_remaining))))
 (let (($x1175 (= v_1_rtt_end v_0_rtt_end)))
 (let (($x1174 (= v_1_rtt_start_ms v_0_rtt_start_ms)))
 (let (($x1162 (and v_0_rtt_active $x301 $x333 $x336 $x723)))
 (let (($x1163 (not $x1162)))
 (let (($x1150 (= v_1_rtt_previous_measured (ite $x726 v_0_rtt_measured v_0_rtt_previous_measured))))
 (let (($x1143 (= v_1_rtt_previous_var (ite $x726 v_0_rttvar_ms v_0_rtt_previous_var))))
 (let (($x1139 (= v_1_rtt_previous_srtt (ite $x726 v_0_srtt_ms v_0_rtt_previous_srtt))))
 (let ((?x1119 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data) 4294967296)))
 (let (($x1112 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x1108 (= v_1_fin_requested v_0_fin_requested)))
 (let ((?x1086 (ite (or (not (and (or $x370 $x368) (not $x653))) (and $x351 $x348 $x674)) 0 ?x650)))
 (let (($x902 (not $x653)))
 (let (($x705 (not $x371)))
 (let (($x871 (not $x410)))
 (let (($x869 (not $x430)))
 (let (($x867 (not $x450)))
 (let (($x865 (not $x470)))
 (let (($x863 (not $x490)))
 (let (($x861 (not $x510)))
 (let (($x859 (not $x528)))
 (let (($x857 (not $x546)))
 (let (($x855 (not $x564)))
 (let (($x853 (not $x582)))
 (let (($x851 (not $x600)))
 (let (($x849 (not $x618)))
 (let (($x847 (not $x636)))
 (let (($x846 (and false $x654)))
 (let (($x848 (and $x846 $x847)))
 (let (($x850 (and $x848 $x849)))
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
 (let (($x873 (or $x387 $x389 (and $x870 $x871))))
 (let ((?x699 (ite $x635 0 ?x632)))
 (let (($x845 (or $x370 $x368)))
 (let (($x675 (and $x351 $x348 $x674)))
 (let (($x1082 (= v_1_rx_slot_14 (ite $x675 0 (ite $x845 ?x699 (ite (and $x873 $x705 $x902) ?x650 0))))))
 (let (($x874 (and $x873 $x705)))
 (let ((?x1074 (ite $x874 ?x699 (ite (and (or $x870 $x410) (not $x390) $x705 $x902) ?x650 0))))
 (let ((?x698 (ite $x617 0 ?x614)))
 (let (($x876 (not $x390)))
 (let (($x875 (or $x870 $x410)))
 (let (($x877 (and $x875 $x876 $x705)))
 (let ((?x1067 (ite $x877 ?x699 (ite (and (or $x868 $x430) $x871 $x876 $x705 $x902) ?x650 0))))
 (let ((?x697 (ite $x599 0 ?x596)))
 (let (($x1071 (= v_1_rx_slot_12 (ite $x675 0 (ite $x845 ?x697 (ite $x874 ?x698 ?x1067))))))
 (let (($x878 (or $x868 $x430)))
 (let (($x879 (and $x878 $x871 $x876 $x705)))
 (let ((?x1059 (ite $x879 ?x699 (ite (and (or $x866 $x450) $x869 $x871 $x876 $x705 $x902) ?x650 0))))
 (let ((?x696 (ite $x581 0 ?x578)))
 (let (($x1064 (= v_1_rx_slot_11 (ite $x675 0 (ite $x845 ?x696 (ite $x874 ?x697 (ite $x877 ?x698 ?x1059)))))))
 (let (($x880 (or $x866 $x450)))
 (let (($x881 (and $x880 $x869 $x871 $x876 $x705)))
 (let ((?x1050 (ite $x881 ?x699 (ite (and (or $x864 $x470) $x867 $x869 $x871 $x876 $x705 $x902) ?x650 0))))
 (let ((?x695 (ite $x563 0 ?x560)))
 (let ((?x1055 (ite $x675 0 (ite $x845 ?x695 (ite $x874 ?x696 (ite $x877 ?x697 (ite $x879 ?x698 ?x1050)))))))
 (let ((?x1039 (ite (and (or $x862 $x490) $x865 $x867 $x869 $x871 $x876 $x705 $x902) ?x650 0)))
 (let (($x882 (or $x864 $x470)))
 (let (($x883 (and $x882 $x867 $x869 $x871 $x876 $x705)))
 (let ((?x1044 (ite $x874 ?x695 (ite $x877 ?x696 (ite $x879 ?x697 (ite $x881 ?x698 (ite $x883 ?x699 ?x1039)))))))
 (let ((?x694 (ite $x545 0 ?x542)))
 (let ((?x1028 (ite (and (or $x860 $x510) $x863 $x865 $x867 $x869 $x871 $x876 $x705 $x902) ?x650 0)))
 (let (($x884 (or $x862 $x490)))
 (let (($x885 (and $x884 $x865 $x867 $x869 $x871 $x876 $x705)))
 (let ((?x1033 (ite $x877 ?x695 (ite $x879 ?x696 (ite $x881 ?x697 (ite $x883 ?x698 (ite $x885 ?x699 ?x1028)))))))
 (let ((?x693 (ite $x527 0 ?x524)))
 (let (($x1037 (= v_1_rx_slot_08 (ite $x675 0 (ite $x845 ?x693 (ite $x874 ?x694 ?x1033))))))
 (let ((?x1016 (ite (and (or $x858 $x528) $x861 $x863 $x865 $x867 $x869 $x871 $x876 $x705 $x902) ?x650 0)))
 (let (($x886 (or $x860 $x510)))
 (let (($x887 (and $x886 $x863 $x865 $x867 $x869 $x871 $x876 $x705)))
 (let ((?x1021 (ite $x879 ?x695 (ite $x881 ?x696 (ite $x883 ?x697 (ite $x885 ?x698 (ite $x887 ?x699 ?x1016)))))))
 (let ((?x692 (ite $x509 0 ?x506)))
 (let (($x1026 (= v_1_rx_slot_07 (ite $x675 0 (ite $x845 ?x692 (ite $x874 ?x693 (ite $x877 ?x694 ?x1021)))))))
 (let (($x890 (or $x856 $x546)))
 (let ((?x1003 (ite (and $x890 $x859 $x861 $x863 $x865 $x867 $x869 $x871 $x876 $x705 $x902) ?x650 0)))
 (let (($x888 (or $x858 $x528)))
 (let (($x889 (and $x888 $x861 $x863 $x865 $x867 $x869 $x871 $x876 $x705)))
 (let ((?x1008 (ite $x881 ?x695 (ite $x883 ?x696 (ite $x885 ?x697 (ite $x887 ?x698 (ite $x889 ?x699 ?x1003)))))))
 (let ((?x691 (ite $x489 0 ?x486)))
 (let ((?x1013 (ite $x675 0 (ite $x845 ?x691 (ite $x874 ?x692 (ite $x877 ?x693 (ite $x879 ?x694 ?x1008)))))))
 (let (($x892 (or $x854 $x564)))
 (let ((?x989 (ite (and $x892 $x857 $x859 $x861 $x863 $x865 $x867 $x869 $x871 $x876 $x705 $x902) ?x650 0)))
 (let (($x891 (and $x890 $x859 $x861 $x863 $x865 $x867 $x869 $x871 $x876 $x705)))
 (let ((?x994 (ite $x883 ?x695 (ite $x885 ?x696 (ite $x887 ?x697 (ite $x889 ?x698 (ite $x891 ?x699 ?x989)))))))
 (let ((?x690 (ite $x469 0 ?x466)))
 (let ((?x999 (ite $x845 ?x690 (ite $x874 ?x691 (ite $x877 ?x692 (ite $x879 ?x693 (ite $x881 ?x694 ?x994)))))))
 (let (($x894 (or $x852 $x582)))
 (let (($x973 (and $x894 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x869 $x871 $x876 $x705 $x902)))
 (let (($x893 (and $x892 $x857 $x859 $x861 $x863 $x865 $x867 $x869 $x871 $x876 $x705)))
 (let ((?x978 (ite $x887 ?x696 (ite $x889 ?x697 (ite $x891 ?x698 (ite $x893 ?x699 (ite $x973 ?x650 0)))))))
 (let ((?x983 (ite $x877 ?x691 (ite $x879 ?x692 (ite $x881 ?x693 (ite $x883 ?x694 (ite $x885 ?x695 ?x978)))))))
 (let ((?x689 (ite $x449 0 ?x446)))
 (let (($x987 (= v_1_rx_slot_04 (ite $x675 0 (ite $x845 ?x689 (ite $x874 ?x690 ?x983))))))
 (let (($x896 (or $x850 $x600)))
 (let (($x957 (and $x896 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x869 $x871 $x876 $x705 $x902)))
 (let (($x895 (and $x894 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x869 $x871 $x876 $x705)))
 (let ((?x962 (ite $x889 ?x696 (ite $x891 ?x697 (ite $x893 ?x698 (ite $x895 ?x699 (ite $x957 ?x650 0)))))))
 (let ((?x967 (ite $x879 ?x691 (ite $x881 ?x692 (ite $x883 ?x693 (ite $x885 ?x694 (ite $x887 ?x695 ?x962)))))))
 (let ((?x688 (ite $x429 0 ?x426)))
 (let (($x972 (= v_1_rx_slot_03 (ite $x675 0 (ite $x845 ?x688 (ite $x874 ?x689 (ite $x877 ?x690 ?x967)))))))
 (let (($x898 (or $x848 $x618)))
 (let (($x940 (and $x898 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x869 $x871 $x876 $x705 $x902)))
 (let (($x897 (and $x896 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x869 $x871 $x876 $x705)))
 (let ((?x945 (ite $x891 ?x696 (ite $x893 ?x697 (ite $x895 ?x698 (ite $x897 ?x699 (ite $x940 ?x650 0)))))))
 (let ((?x950 (ite $x881 ?x691 (ite $x883 ?x692 (ite $x885 ?x693 (ite $x887 ?x694 (ite $x889 ?x695 ?x945)))))))
 (let ((?x687 (ite $x409 0 ?x406)))
 (let ((?x955 (ite $x675 0 (ite $x845 ?x687 (ite $x874 ?x688 (ite $x877 ?x689 (ite $x879 ?x690 ?x950)))))))
 (let (($x900 (or $x846 $x636)))
 (let (($x922 (and $x900 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x869 $x871 $x876 $x705 $x902)))
 (let (($x899 (and $x898 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x869 $x871 $x876 $x705)))
 (let ((?x927 (ite $x893 ?x696 (ite $x895 ?x697 (ite $x897 ?x698 (ite $x899 ?x699 (ite $x922 ?x650 0)))))))
 (let ((?x932 (ite $x883 ?x691 (ite $x885 ?x692 (ite $x887 ?x693 (ite $x889 ?x694 (ite $x891 ?x695 ?x927)))))))
 (let ((?x686 (ite $x389 0 ?x386)))
 (let ((?x937 (ite $x845 ?x686 (ite $x874 ?x687 (ite $x877 ?x688 (ite $x879 ?x689 (ite $x881 ?x690 ?x932)))))))
 (let (($x903 (and $x654 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x869 $x871 $x876 $x705 $x902)))
 (let (($x901 (and $x900 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x869 $x871 $x876 $x705)))
 (let ((?x908 (ite $x895 ?x696 (ite $x897 ?x697 (ite $x899 ?x698 (ite $x901 ?x699 (ite $x903 ?x650 0)))))))
 (let ((?x913 (ite $x885 ?x691 (ite $x887 ?x692 (ite $x889 ?x693 (ite $x891 ?x694 (ite $x893 ?x695 ?x908)))))))
 (let ((?x918 (ite $x874 ?x686 (ite $x877 ?x687 (ite $x879 ?x688 (ite $x881 ?x689 (ite $x883 ?x690 ?x913)))))))
 (let ((?x685 (ite $x370 0 ?x367)))
 (let ((?x707 (ite (and (<= 0 ?x670) $x705) ?x669 0)))
 (let ((?x701 (+ ?x685 ?x686 ?x687 ?x688 ?x689 ?x690 ?x691 ?x692 ?x693 ?x694 ?x695 ?x696 ?x697 ?x698 ?x699 (ite $x653 0 ?x650))))
 (let ((?x703 (ite (<= ?x701 0) 0 ?x701)))
 (let ((?x709 (ite (<= ?x703 ?x707) ?x703 ?x707)))
 (let (($x843 (= v_1_take v_0_take)))
 (let (($x803 (= v_1_snd_buf v_0_snd_buf)))
 (let (($x797 (= v_1_msl_ms v_0_msl_ms)))
 (let (($x794 (= v_1_user_timeout_ms v_0_user_timeout_ms)))
 (let (($x791 (= v_1_active_open v_0_active_open)))
 (let (($x788 (= v_1_retries v_0_retries)))
 (let (($x718 (= v_1_tx_flags v_0_tx_flags)))
 (let (($x715 (= v_1_tx_ack v_0_tx_ack)))
 (let (($x714 (= v_1_tx_seq v_0_tx_seq)))
 (let (($x713 (= v_1_rcv_nxt (mod (+ v_0_rcv_nxt ?x709 (ite $x675 1 0)) 4294967296))))
 (let (($x684 (= v_1_snd_nxt v_0_snd_nxt)))
 (let (($x680 (= v_1_irs v_0_irs)))
 (let (($x679 (= v_1_iss v_0_iss)))
 (let (($x676 (not $x675)))
 (let (($x317 (= 0 ?x305)))
 (let (($x316 (not v_0_fin_sent)))
 (let (($x311 (= (mod (+ input_0_net.fin_segment_ack (* ?x278 v_0_snd_nxt)) 4294967296) 2147483648)))
 (and (>= now_1 now_0) (<= 0 input_0_net.fin_segment_data) (>= 16 input_0_net.fin_segment_data) (not (= ?x281 2147483648)) (<= 0 input_0_net.fin_segment_window) (>= 65535 input_0_net.fin_segment_window) (or (not $x301) (and (not (= ?x305 2147483648)) (not $x311))) $x316 $x317 (or (not active_0_rtx) (not (<= due_0_rtx now_1))) (or (not active_0_user) (not (<= due_0_user now_1))) (or (not active_0_time_wait) (not (<= due_0_time_wait now_1))) (or (not active_0_delack) (not (<= due_0_delack now_1))) (or (not active_0_persist) (not (<= due_0_persist now_1))) $x339 $x676 $x678 $x679 $x680 (= v_1_snd_una (ite $x681 input_0_net.fin_segment_ack v_0_snd_una)) $x684 $x713 $x714 $x715 $x718 (= v_1_rto_ms ?x784) $x788 $x791 $x794 $x797 (= v_1_local_window (+ 16 (* ?x278 v_0_rcv_buf) (* ?x278 ?x709))) $x803 (= v_1_rtx_buf ?x812) (= v_1_rcv_buf (+ v_0_rcv_buf ?x709)) (= v_1_snd_wnd ?x835) (= v_1_snd_wl1 (ite $x833 input_0_net.fin_segment_seq v_0_snd_wl1)) (= v_1_snd_wl2 (ite $x833 input_0_net.fin_segment_ack v_0_snd_wl2)) $x843 (= v_1_rx_chunk ?x709) (= v_1_rx_slot_00 (ite $x675 0 (ite $x845 ?x685 ?x918))) (= v_1_rx_slot_01 (ite $x675 0 ?x937)) (= v_1_rx_slot_02 ?x955) $x972 $x987 (= v_1_rx_slot_05 (ite $x675 0 ?x999)) (= v_1_rx_slot_06 ?x1013) $x1026 $x1037 (= v_1_rx_slot_09 (ite $x675 0 (ite $x845 ?x694 ?x1044))) (= v_1_rx_slot_10 ?x1055) $x1064 $x1071 (= v_1_rx_slot_13 (ite $x675 0 (ite $x845 ?x698 ?x1074))) $x1082 (= v_1_rx_slot_15 ?x1086) (= v_1_rx_advance ?x670) (= v_1_rx_acceptable (and $x301 $x346 $x348)) (= v_1_seg_acceptable $x301) (= v_1_ack_delta ?x305) (= v_1_ack_is_new (and $x333 $x336)) (= v_1_ack_is_future $x345) (= v_1_ack_advance $x681) (= v_1_ack_window_update $x833) $x1108 (= v_1_fin_sent $x1110) $x1112 (= v_1_fin_acknowledged $x338) (= v_1_rx_fin_pending (and $x351 $x676)) (= v_1_rx_fin_seq (ite $x350 ?x1119 v_0_rx_fin_seq)) (= v_1_rx_fin_offset (ite $x675 0 ?x673)) (= v_1_rx_fin_done (or v_0_rx_fin_done $x675)) (= v_1_rx_fin_consumed $x675) (= v_1_srtt_ms ?x746) (= v_1_rttvar_ms ?x769) (= v_1_rtt_error_ms ?x762) $x1139 $x1143 (= v_1_rtt_measured (or v_0_rtt_measured $x726)) $x1150 (= v_1_rtt_active (and $x1161 v_0_rtt_active $x1163)) (= v_1_rtt_ambiguous (and $x1161 $x1163 v_0_rtt_ambiguous)) (= v_1_rtt_sample_at_ms (ite $x726 now_1 v_0_rtt_sample_at_ms)) $x1174 $x1175 (= v_1_rtt_remaining ?x1184) $x1187 (= v_1_rtt_sample_used $x726) $x1192 (= v_1_rtt_last_ms ?x741) (= v_1_rtt_samples (+ v_0_rtt_samples (ite $x726 1 0))) (= v_1_rto_base_ms (ite $x726 ?x782 v_0_rto_base_ms)) $x1257 (= v_1_tx_time_01 (ite (or $x1158 $x1156) 0 ?x1274)) (= v_1_tx_time_02 ?x1294) $x1313 (= v_1_tx_time_04 (ite (or $x1158 (>= 4 ?x812)) 0 ?x1328)) (= v_1_tx_time_05 ?x1345) $x1361 (= v_1_tx_time_07 (ite (or $x1158 (>= 7 ?x812)) 0 ?x1373)) (= v_1_tx_time_08 ?x1387) $x1400 (= v_1_tx_time_10 (ite (or $x1158 (>= 10 ?x812)) 0 ?x1409)) (= v_1_tx_time_11 ?x1420) $x1430 (= v_1_tx_time_13 (ite (or $x1158 (>= 13 ?x812)) 0 ?x1436)) (= v_1_tx_time_14 ?x1444) (= v_1_tx_time_15 ?x1449) (= v_1_tx_fin_time (ite $x1110 v_0_tx_fin_time 0)) $x1457 $x1460 $x1463 $x1465 $x1468 $x1471 $x1474 $x1476 $x1478 $x1480 $x1482 $x1484 $x1486 $x1488 $x1490 $x1493 $x1496 $x1498 $x1500 (= v_1_persist_active $x1160) (= v_1_persist_eligible $x1160) (= v_1_persist_start $x1507) $x1510 $x1512 $x1514 $x1516 (= v_1_persist_interval_ms (ite $x1160 ?x1519 1000)) $x1524 $x1529 (= v_1_persist_last_ms (ite $x1160 v_0_persist_last_ms 0)) $x1539 (= v_1_persist_probes (ite $x1160 v_0_persist_probes 0)) $x1546 (= active_1_rtx (or $x1560 $x1558)) (= active_1_user (and $x678 active_0_user)) (= active_1_time_wait (or active_0_time_wait $x677)) $x1570 $x1574 (= due_1_rtx ?x1585) $x1588 (= due_1_time_wait (ite $x677 ?x1591 due_0_time_wait)) $x1595 (= due_1_persist (ite $x1507 ?x1535 due_0_persist)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
 (let ((?x1604 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1604)))
(assert
 (>= 16 v_0_rcv_buf))
(assert
 (and (<= 0 v_0_snd_wnd) (>= 65535 v_0_snd_wnd)))
(assert
 (= v_0_local_window (+ 16 (* (- 1) v_0_rcv_buf))))
(assert
 (>= 1 v_0_rx_slot_00))
(assert
 (let (($x354 (= 0 v_0_rx_slot_00)))
 (let (($x1614 (not (>= v_0_rcv_buf 16))))
 (or $x1614 $x354))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x372 (= 0 v_0_rx_slot_01)))
 (let (($x1618 (not (>= v_0_rcv_buf 15))))
 (or $x1618 $x372))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x391 (= 0 v_0_rx_slot_02)))
 (let (($x1622 (not (>= v_0_rcv_buf 14))))
 (or $x1622 $x391))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x411 (= 0 v_0_rx_slot_03)))
 (let (($x1626 (not (>= v_0_rcv_buf 13))))
 (or $x1626 $x411))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x431 (= 0 v_0_rx_slot_04)))
 (let (($x1630 (not (>= v_0_rcv_buf 12))))
 (or $x1630 $x431))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x451 (= 0 v_0_rx_slot_05)))
 (let (($x1634 (not (>= v_0_rcv_buf 11))))
 (or $x1634 $x451))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x471 (= 0 v_0_rx_slot_06)))
 (let (($x1638 (not (>= v_0_rcv_buf 10))))
 (or $x1638 $x471))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x491 (= 0 v_0_rx_slot_07)))
 (let (($x1642 (not (>= v_0_rcv_buf 9))))
 (or $x1642 $x491))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x511 (= 0 v_0_rx_slot_08)))
 (let (($x1646 (not (>= v_0_rcv_buf 8))))
 (or $x1646 $x511))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x529 (= 0 v_0_rx_slot_09)))
 (let (($x1650 (not (>= v_0_rcv_buf 7))))
 (or $x1650 $x529))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x547 (= 0 v_0_rx_slot_10)))
 (let (($x1654 (not (>= v_0_rcv_buf 6))))
 (or $x1654 $x547))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x565 (= 0 v_0_rx_slot_11)))
 (let (($x1658 (not (>= v_0_rcv_buf 5))))
 (or $x1658 $x565))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x583 (= 0 v_0_rx_slot_12)))
 (let (($x1662 (not (>= v_0_rcv_buf 4))))
 (or $x1662 $x583))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x601 (= 0 v_0_rx_slot_13)))
 (let (($x1666 (not (>= v_0_rcv_buf 3))))
 (or $x1666 $x601))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x619 (= 0 v_0_rx_slot_14)))
 (let (($x1670 (not (>= v_0_rcv_buf 2))))
 (or $x1670 $x619))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x637 (= 0 v_0_rx_slot_15)))
 (let (($x1674 (not (>= v_0_rcv_buf 1))))
 (or $x1674 $x637))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x1676 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x1676)))
(assert
 (and (<= 0 v_0_rx_advance) (>= 16 v_0_rx_advance)))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (and (<= 0 v_0_ack_delta) (>= 4294967295 v_0_ack_delta)))
(assert
 true)
(assert
 (let ((?x1689 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x1689)))
(assert
 (let (($x1695 (and v_0_fin_requested (= v_0_fin_seq (mod (+ v_0_snd_una v_0_rtx_buf) 4294967296)) (= 0 v_0_snd_buf))))
 (let (($x316 (not v_0_fin_sent)))
 (or $x316 $x1695))))
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
 (let (($x1697 (<= 1 v_0_rx_fin_offset)))
 (let (($x348 (not v_0_rx_fin_done)))
 (let (($x1699 (and $x348 $x1697 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window)))))
 (let (($x349 (not v_0_rx_fin_pending)))
 (or $x349 $x1699))))))
(assert
 (let (($x1702 (>= 15 v_0_rx_fin_offset)))
 (and (<= 0 v_0_rx_fin_offset) $x1702 (= v_0_rx_fin_pending (<= 1 v_0_rx_fin_offset)))))
(assert
 (let (($x349 (not v_0_rx_fin_pending)))
 (or $x349 (= v_0_rx_fin_seq (mod (+ v_0_rcv_nxt v_0_rx_fin_offset) 4294967296)))))
(assert
 (let (($x348 (not v_0_rx_fin_done)))
 (or $x348 (= v_0_rcv_nxt (mod (+ 1 v_0_rx_fin_seq) 4294967296)))))
(assert
 (let (($x354 (= 0 v_0_rx_slot_00)))
 (or (not (and v_0_rx_fin_pending (>= 0 v_0_rx_fin_offset))) $x354)))
(assert
 (let (($x372 (= 0 v_0_rx_slot_01)))
 (or (not (and v_0_rx_fin_pending (>= 1 v_0_rx_fin_offset))) $x372)))
(assert
 (let (($x391 (= 0 v_0_rx_slot_02)))
 (or (not (and v_0_rx_fin_pending (>= 2 v_0_rx_fin_offset))) $x391)))
(assert
 (let (($x411 (= 0 v_0_rx_slot_03)))
 (or (not (and v_0_rx_fin_pending (>= 3 v_0_rx_fin_offset))) $x411)))
(assert
 (let (($x431 (= 0 v_0_rx_slot_04)))
 (or (not (and v_0_rx_fin_pending (>= 4 v_0_rx_fin_offset))) $x431)))
(assert
 (let (($x451 (= 0 v_0_rx_slot_05)))
 (or (not (and v_0_rx_fin_pending (>= 5 v_0_rx_fin_offset))) $x451)))
(assert
 (let (($x471 (= 0 v_0_rx_slot_06)))
 (or (not (and v_0_rx_fin_pending (>= 6 v_0_rx_fin_offset))) $x471)))
(assert
 (let (($x491 (= 0 v_0_rx_slot_07)))
 (or (not (and v_0_rx_fin_pending (>= 7 v_0_rx_fin_offset))) $x491)))
(assert
 (let (($x511 (= 0 v_0_rx_slot_08)))
 (or (not (and v_0_rx_fin_pending (>= 8 v_0_rx_fin_offset))) $x511)))
(assert
 (let (($x529 (= 0 v_0_rx_slot_09)))
 (or (not (and v_0_rx_fin_pending (>= 9 v_0_rx_fin_offset))) $x529)))
(assert
 (let (($x547 (= 0 v_0_rx_slot_10)))
 (or (not (and v_0_rx_fin_pending (>= 10 v_0_rx_fin_offset))) $x547)))
(assert
 (let (($x565 (= 0 v_0_rx_slot_11)))
 (or (not (and v_0_rx_fin_pending (>= 11 v_0_rx_fin_offset))) $x565)))
(assert
 (let (($x583 (= 0 v_0_rx_slot_12)))
 (or (not (and v_0_rx_fin_pending (>= 12 v_0_rx_fin_offset))) $x583)))
(assert
 (let (($x601 (= 0 v_0_rx_slot_13)))
 (or (not (and v_0_rx_fin_pending (>= 13 v_0_rx_fin_offset))) $x601)))
(assert
 (let (($x619 (= 0 v_0_rx_slot_14)))
 (or (not (and v_0_rx_fin_pending (>= 14 v_0_rx_fin_offset))) $x619)))
(assert
 (let (($x637 (= 0 v_0_rx_slot_15)))
 (or (not (and v_0_rx_fin_pending (>= 15 v_0_rx_fin_offset))) $x637)))
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
 (let ((?x1790 (* 4.0 v_0_rttvar_ms)))
 (let ((?x729 (- 1.0)))
 (let ((?x758 (* ?x729 v_0_srtt_ms)))
 (let ((?x1793 (+ ?x758 (* ?x729 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x1790)))))
 (let ((?x1794 (to_int ?x1793)))
 (let ((?x278 (- 1)))
 (let ((?x1797 (ite (<= ?x1794 (- 1000)) (* ?x278 ?x1794) 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x1797) 60000 ?x1797) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x722 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x1812 (and (<= v_0_rtt_start_ms now_0) (<= 1 v_0_rtt_remaining) (>= 4 v_0_rtt_remaining) (>= ?x722 v_0_rtt_remaining) (<= ?x722 (mod (+ v_0_snd_nxt (* (- 1) v_0_snd_una)) 4294967296)))))
 (let (($x1804 (not v_0_rtt_active)))
 (or $x1804 $x1812)))))
(assert
 (let (($x1814 (= 0 v_0_rtt_remaining)))
 (or v_0_rtt_active $x1814)))
(assert
 true)
(assert
 (let (($x1821 (= v_0_rtt_last_ms (+ v_0_rtt_sample_at_ms (* (- 1) v_0_rtt_start_ms)))))
 (let (($x1819 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1817 (not v_0_rtt_sample_used)))
 (or $x1817 (and $x1819 v_0_rtt_measured $x1821))))))
(assert
 (and (<= 0 v_0_rtt_sample_at_ms) (<= v_0_rtt_sample_at_ms now_0)))
(assert
 (let ((?x1828 (to_real v_0_rtt_last_ms)))
 (let ((?x1842 (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x1828))))
 (let ((?x1830 (+ v_0_rtt_previous_srtt (* (- 1.0) ?x1828))))
 (let ((?x1834 (ite (>= ?x1830 0.0) ?x1830 (+ (* (- 1.0) v_0_rtt_previous_srtt) ?x1828))))
 (let ((?x753 (/ 1.0 4.0)))
 (let ((?x1838 (ite v_0_rtt_previous_measured (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* ?x753 ?x1834)) (* (/ 1.0 2.0) ?x1828))))
 (let (($x1845 (and (= v_0_rttvar_ms ?x1838) (= v_0_srtt_ms (ite v_0_rtt_previous_measured ?x1842 ?x1828)))))
 (let (($x1817 (not v_0_rtt_sample_used)))
 (or $x1817 $x1845))))))))))
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
 (let (($x1981 (and (>= v_0_tx_elapsed v_0_tx_previous_rto) (<= 1 v_0_tx_emit_count) (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x1975 (not v_0_tx_retransmitted)))
 (or $x1975 $x1981))))
(assert
 (let (($x1975 (not v_0_tx_retransmitted)))
 (or $x1975 (not v_0_tx_waiting))))
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
 (let (($x2012 (not v_0_ack_pending)))
 (or $x2012 (and (<= 1 v_0_ack_bytes) (not v_0_rx_fin_done)))))
(assert
 (let (($x2019 (and (= 0 v_0_ack_bytes) (= 0 v_0_ack_full_segments) (= 0 v_0_ack_since_ms))))
 (or v_0_ack_pending $x2019)))
(assert
 (let (($x186 (not active_0_rtx)))
 (let (($x1856 (>= 1 v_0_rtx_buf)))
 (let (($x316 (not v_0_fin_sent)))
 (let (($x2028 (and (= 0 v_0_snd_wnd) $x316 (<= 1 (+ v_0_rtx_buf v_0_snd_buf)) $x1856 $x186)))
 (let (($x1506 (not v_0_persist_active)))
 (let (($x2023 (and (<= 1 (+ v_0_rtx_buf (ite v_0_fin_sent 1 0))) $x1506)))
 (let (($x2021 (= v_0_persist_active active_0_persist)))
 (and $x2021 (= active_0_rtx $x2023) (or $x1506 $x2028))))))))))
(assert
 (let (($x1506 (not v_0_persist_active)))
 (or $x1506 (and (not v_0_rtt_active) (= 0 v_0_rtt_remaining)))))
(assert
 (and (<= 1000 v_0_persist_interval_ms) (>= 60000 v_0_persist_interval_ms) (<= 1000 v_0_persist_previous_interval_ms) (>= 60000 v_0_persist_previous_interval_ms) (<= 0 v_0_persist_probes) (<= 0 v_0_persist_elapsed_ms)))
(assert
 (and (<= 0 v_0_persist_since_ms) (<= v_0_persist_since_ms now_0) (<= 0 v_0_persist_last_ms) (<= v_0_persist_last_ms now_0) (<= 0 v_0_persist_deadline_ms)))
(assert
 (let (($x2046 (= 0 v_0_persist_probes)))
 (let ((?x2048 (+ (ite $x2046 v_0_persist_since_ms v_0_persist_last_ms) v_0_persist_interval_ms)))
 (let (($x1506 (not v_0_persist_active)))
 (or $x1506 (= v_0_persist_deadline_ms ?x2048))))))
(assert
 (let (($x2054 (= 1 v_0_rtx_buf)))
 (let (($x2052 (not v_0_persist_probe_sent)))
 (or $x2052 (and (>= v_0_persist_elapsed_ms v_0_persist_previous_interval_ms) $x2054)))))
(assert
 (let (($x2060 (= v_0_tx_time_00 v_0_persist_last_ms)))
 (let (($x2054 (= 1 v_0_rtx_buf)))
 (or (not (and v_0_persist_active (<= 1 v_0_persist_probes) $x2054)) $x2060))))
(assert
 (let (($x2046 (= 0 v_0_persist_probes)))
 (let (($x2065 (and (= 0 v_0_persist_since_ms) (= 0 v_0_persist_last_ms) (= 0 v_0_persist_deadline_ms) $x2046)))
 (or v_0_persist_active $x2065))))
(assert
 (= 174 choice_0))
(assert
 (= 5 state_0))
(assert
 (= 5 state_1))
(assert
 (or (not (= 4 v_1_ack_rmss))))
(check-sat)
