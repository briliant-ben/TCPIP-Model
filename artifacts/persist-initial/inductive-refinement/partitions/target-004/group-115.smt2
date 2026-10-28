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
 (let (($x733 (not v_0_rtt_ambiguous)))
 (let ((?x730 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let ((?x291 (mod (+ input_0_net.fin_segment_ack (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x731 (>= ?x291 ?x730)))
 (let ((?x342 (ite v_0_fin_sent 1 0)))
 (let ((?x343 (+ v_0_rtx_buf ?x342)))
 (let (($x344 (<= ?x291 ?x343)))
 (let (($x320 (<= 1 ?x291)))
 (let ((?x278 (- 1)))
 (let ((?x305 (+ ?x278 v_0_local_window)))
 (let ((?x302 (* ?x278 v_0_rcv_nxt)))
 (let ((?x309 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data ?x302) 4294967296)))
 (let (($x310 (<= ?x309 ?x305)))
 (let (($x301 (<= 1 v_0_local_window)))
 (let (($x312 (or (and $x301 (<= (mod (+ input_0_net.fin_segment_seq ?x302) 4294967296) ?x305)) (and $x301 $x310))))
 (let (($x734 (and v_0_rtt_active $x312 $x320 $x344 $x731 $x733)))
 (let ((?x749 (ite $x734 (+ now_1 (* ?x278 v_0_rtt_start_ms)) v_0_rtt_last_ms)))
 (let ((?x750 (to_real ?x749)))
 (let ((?x774 (/ 1.0 2.0)))
 (let ((?x763 (+ v_0_srtt_ms (* (- 1.0) ?x750))))
 (let ((?x770 (ite $x734 (ite (>= ?x763 0.0) ?x763 (+ (* (- 1.0) v_0_srtt_ms) ?x750)) v_0_rtt_error_ms)))
 (let ((?x761 (/ 1.0 4.0)))
 (let ((?x776 (ite v_0_rtt_measured (+ (* (/ 3.0 4.0) v_0_rttvar_ms) (* ?x761 ?x770)) (* ?x774 ?x750))))
 (let ((?x777 (ite $x734 ?x776 v_0_rttvar_ms)))
 (let ((?x737 (- 1.0)))
 (let ((?x753 (ite v_0_rtt_measured (+ (* (/ 7.0 8.0) v_0_srtt_ms) (* (/ 1.0 8.0) ?x750)) ?x750)))
 (let ((?x754 (ite $x734 ?x753 v_0_srtt_ms)))
 (let ((?x782 (+ (* ?x737 ?x754) (* ?x737 (ite (<= ?x777 ?x761) 1.0 (* 4.0 ?x777))))))
 (let ((?x783 (to_int ?x782)))
 (let ((?x787 (* ?x278 ?x783)))
 (let ((?x788 (ite (<= ?x783 (- 1000)) ?x787 1000)))
 (let ((?x790 (ite (<= 60000 ?x788) 60000 ?x788)))
 (let ((?x792 (ite $x734 ?x790 v_0_rto_ms)))
 (let (($x1513 (not v_0_persist_active)))
 (let ((?x817 (ite (<= 0 v_0_rtx_buf) v_0_rtx_buf 0)))
 (let ((?x815 (ite (<= v_0_rtx_buf ?x291) 0 (+ v_0_rtx_buf (* ?x278 ?x291)))))
 (let (($x689 (and $x312 $x320 $x344)))
 (let ((?x820 (ite $x689 (ite (<= ?x815 ?x817) ?x815 ?x817) v_0_rtx_buf)))
 (let (($x1165 (= 0 ?x820)))
 (let (($x1166 (or v_0_persist_active $x1165)))
 (let (($x1163 (>= 1 ?x820)))
 (let (($x1162 (<= 1 (+ ?x820 v_0_snd_buf))))
 (let (($x345 (= ?x291 ?x343)))
 (let (($x346 (and $x312 $x320 $x344 v_0_fin_sent $x345)))
 (let (($x347 (not $x346)))
 (let (($x1117 (and $x347 v_0_fin_sent)))
 (let (($x1160 (not $x1117)))
 (let ((?x834 (mod (+ input_0_net.fin_segment_seq (* ?x278 v_0_snd_wl1)) 4294967296)))
 (let (($x829 (<= 2147483648 (mod (+ input_0_net.fin_segment_ack (* ?x278 v_0_snd_wl2)) 4294967296))))
 (let (($x825 (= v_0_snd_wl1 input_0_net.fin_segment_seq)))
 (let (($x840 (or (and $x825 (not $x829)) (and (not (<= ?x834 0)) (not (<= 2147483648 ?x834))))))
 (let (($x841 (and $x312 $x344 $x840)))
 (let ((?x843 (ite $x841 input_0_net.fin_segment_window v_0_snd_wnd)))
 (let (($x1159 (= 0 ?x843)))
 (let (($x1514 (and $x1159 $x1160 $x1162 $x1163 $x1166 $x1513)))
 (let ((?x1526 (ite $x1514 ?x792 v_0_persist_interval_ms)))
 (let ((?x1542 (+ now_1 ?x1526)))
 (let (($x1602 (= due_1_delack due_0_delack)))
 (let ((?x1598 (+ now_1 (* 2 v_0_msl_ms))))
 (let (($x357 (not v_0_rx_fin_pending)))
 (let (($x356 (not v_0_rx_fin_done)))
 (let (($x353 (and (>= ?x291 (+ 1 v_0_rtx_buf ?x342)) (>= 2147483647 ?x291))))
 (let (($x354 (not $x353)))
 (let (($x358 (and $x312 $x354 $x356 $x357 $x301 $x310)))
 (let ((?x361 (ite $x358 ?x309 v_0_rx_fin_offset)))
 (let (($x359 (or v_0_rx_fin_pending $x358)))
 (let (($x661 (and $x359 (>= 15 ?x361))))
 (let ((?x648 (mod (+ 15 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x653 (+ input_0_net.fin_segment_data (* ?x278 ?x648))))
 (let (($x651 (<= input_0_net.fin_segment_data ?x648)))
 (let (($x646 (<= v_0_rcv_buf 0)))
 (let (($x645 (= 0 v_0_rx_slot_15)))
 (let (($x650 (and $x312 $x354 $x356 $x645 $x646 (<= ?x648 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x658 (ite $x650 (ite (or $x651 (<= ?x653 1)) (ite $x651 0 ?x653) 1) v_0_rx_slot_15)))
 (let (($x662 (or (= ?x658 0) $x661)))
 (let (($x643 (and $x359 (>= 14 ?x361))))
 (let ((?x630 (mod (+ 14 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x635 (+ input_0_net.fin_segment_data (* ?x278 ?x630))))
 (let (($x633 (<= input_0_net.fin_segment_data ?x630)))
 (let (($x628 (<= v_0_rcv_buf 1)))
 (let (($x627 (= 0 v_0_rx_slot_14)))
 (let (($x632 (and $x312 $x354 $x356 $x627 $x628 (<= ?x630 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x640 (ite $x632 (ite (or $x633 (<= ?x635 1)) (ite $x633 0 ?x635) 1) v_0_rx_slot_14)))
 (let (($x644 (or (= ?x640 0) $x643)))
 (let (($x625 (and $x359 (>= 13 ?x361))))
 (let ((?x612 (mod (+ 13 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x617 (+ input_0_net.fin_segment_data (* ?x278 ?x612))))
 (let (($x615 (<= input_0_net.fin_segment_data ?x612)))
 (let (($x610 (<= v_0_rcv_buf 2)))
 (let (($x609 (= 0 v_0_rx_slot_13)))
 (let (($x614 (and $x312 $x354 $x356 $x609 $x610 (<= ?x612 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x622 (ite $x614 (ite (or $x615 (<= ?x617 1)) (ite $x615 0 ?x617) 1) v_0_rx_slot_13)))
 (let (($x626 (or (= ?x622 0) $x625)))
 (let (($x607 (and $x359 (>= 12 ?x361))))
 (let ((?x594 (mod (+ 12 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x599 (+ input_0_net.fin_segment_data (* ?x278 ?x594))))
 (let (($x597 (<= input_0_net.fin_segment_data ?x594)))
 (let (($x592 (<= v_0_rcv_buf 3)))
 (let (($x591 (= 0 v_0_rx_slot_12)))
 (let (($x596 (and $x312 $x354 $x356 $x591 $x592 (<= ?x594 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x604 (ite $x596 (ite (or $x597 (<= ?x599 1)) (ite $x597 0 ?x599) 1) v_0_rx_slot_12)))
 (let (($x608 (or (= ?x604 0) $x607)))
 (let ((?x666 (ite $x608 12 (ite $x626 13 (ite $x644 14 (ite $x662 15 16))))))
 (let (($x589 (and $x359 (>= 11 ?x361))))
 (let ((?x576 (mod (+ 11 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x581 (+ input_0_net.fin_segment_data (* ?x278 ?x576))))
 (let (($x579 (<= input_0_net.fin_segment_data ?x576)))
 (let (($x574 (<= v_0_rcv_buf 4)))
 (let (($x573 (= 0 v_0_rx_slot_11)))
 (let (($x578 (and $x312 $x354 $x356 $x573 $x574 (<= ?x576 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x586 (ite $x578 (ite (or $x579 (<= ?x581 1)) (ite $x579 0 ?x581) 1) v_0_rx_slot_11)))
 (let (($x590 (or (= ?x586 0) $x589)))
 (let (($x571 (and $x359 (>= 10 ?x361))))
 (let ((?x558 (mod (+ 10 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x563 (+ input_0_net.fin_segment_data (* ?x278 ?x558))))
 (let (($x561 (<= input_0_net.fin_segment_data ?x558)))
 (let (($x556 (<= v_0_rcv_buf 5)))
 (let (($x555 (= 0 v_0_rx_slot_10)))
 (let (($x560 (and $x312 $x354 $x356 $x555 $x556 (<= ?x558 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x568 (ite $x560 (ite (or $x561 (<= ?x563 1)) (ite $x561 0 ?x563) 1) v_0_rx_slot_10)))
 (let (($x572 (or (= ?x568 0) $x571)))
 (let (($x553 (and $x359 (>= 9 ?x361))))
 (let ((?x540 (mod (+ 9 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x545 (+ input_0_net.fin_segment_data (* ?x278 ?x540))))
 (let (($x543 (<= input_0_net.fin_segment_data ?x540)))
 (let (($x538 (<= v_0_rcv_buf 6)))
 (let (($x537 (= 0 v_0_rx_slot_09)))
 (let (($x542 (and $x312 $x354 $x356 $x537 $x538 (<= ?x540 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x550 (ite $x542 (ite (or $x543 (<= ?x545 1)) (ite $x543 0 ?x545) 1) v_0_rx_slot_09)))
 (let (($x554 (or (= ?x550 0) $x553)))
 (let (($x535 (and $x359 (>= 8 ?x361))))
 (let ((?x522 (mod (+ 8 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x527 (+ input_0_net.fin_segment_data (* ?x278 ?x522))))
 (let (($x525 (<= input_0_net.fin_segment_data ?x522)))
 (let (($x520 (<= v_0_rcv_buf 7)))
 (let (($x519 (= 0 v_0_rx_slot_08)))
 (let (($x524 (and $x312 $x354 $x356 $x519 $x520 (<= ?x522 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x532 (ite $x524 (ite (or $x525 (<= ?x527 1)) (ite $x525 0 ?x527) 1) v_0_rx_slot_08)))
 (let (($x536 (or (= ?x532 0) $x535)))
 (let ((?x670 (ite $x536 8 (ite $x554 9 (ite $x572 10 (ite $x590 11 ?x666))))))
 (let (($x517 (and $x359 (>= 7 ?x361))))
 (let ((?x504 (mod (+ 7 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x509 (+ input_0_net.fin_segment_data (* ?x278 ?x504))))
 (let (($x507 (<= input_0_net.fin_segment_data ?x504)))
 (let (($x501 (<= v_0_rcv_buf 8)))
 (let (($x499 (= 0 v_0_rx_slot_07)))
 (let (($x506 (and $x312 $x354 $x356 $x499 $x501 (<= ?x504 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x514 (ite $x506 (ite (or $x507 (<= ?x509 1)) (ite $x507 0 ?x509) 1) v_0_rx_slot_07)))
 (let (($x518 (or (= ?x514 0) $x517)))
 (let (($x497 (and $x359 (>= 6 ?x361))))
 (let ((?x484 (mod (+ 6 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x489 (+ input_0_net.fin_segment_data (* ?x278 ?x484))))
 (let (($x487 (<= input_0_net.fin_segment_data ?x484)))
 (let (($x481 (<= v_0_rcv_buf 9)))
 (let (($x479 (= 0 v_0_rx_slot_06)))
 (let (($x486 (and $x312 $x354 $x356 $x479 $x481 (<= ?x484 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x494 (ite $x486 (ite (or $x487 (<= ?x489 1)) (ite $x487 0 ?x489) 1) v_0_rx_slot_06)))
 (let (($x498 (or (= ?x494 0) $x497)))
 (let (($x477 (and $x359 (>= 5 ?x361))))
 (let ((?x464 (mod (+ 5 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x469 (+ input_0_net.fin_segment_data (* ?x278 ?x464))))
 (let (($x467 (<= input_0_net.fin_segment_data ?x464)))
 (let (($x461 (<= v_0_rcv_buf 10)))
 (let (($x459 (= 0 v_0_rx_slot_05)))
 (let (($x466 (and $x312 $x354 $x356 $x459 $x461 (<= ?x464 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x474 (ite $x466 (ite (or $x467 (<= ?x469 1)) (ite $x467 0 ?x469) 1) v_0_rx_slot_05)))
 (let (($x478 (or (= ?x474 0) $x477)))
 (let (($x457 (and $x359 (>= 4 ?x361))))
 (let ((?x444 (mod (+ 4 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x449 (+ input_0_net.fin_segment_data (* ?x278 ?x444))))
 (let (($x447 (<= input_0_net.fin_segment_data ?x444)))
 (let (($x441 (<= v_0_rcv_buf 11)))
 (let (($x439 (= 0 v_0_rx_slot_04)))
 (let (($x446 (and $x312 $x354 $x356 $x439 $x441 (<= ?x444 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x454 (ite $x446 (ite (or $x447 (<= ?x449 1)) (ite $x447 0 ?x449) 1) v_0_rx_slot_04)))
 (let (($x458 (or (= ?x454 0) $x457)))
 (let ((?x674 (ite $x458 4 (ite $x478 5 (ite $x498 6 (ite $x518 7 ?x670))))))
 (let (($x437 (and $x359 (>= 3 ?x361))))
 (let ((?x424 (mod (+ 3 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x429 (+ input_0_net.fin_segment_data (* ?x278 ?x424))))
 (let (($x427 (<= input_0_net.fin_segment_data ?x424)))
 (let (($x421 (<= v_0_rcv_buf 12)))
 (let (($x419 (= 0 v_0_rx_slot_03)))
 (let (($x426 (and $x312 $x354 $x356 $x419 $x421 (<= ?x424 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x434 (ite $x426 (ite (or $x427 (<= ?x429 1)) (ite $x427 0 ?x429) 1) v_0_rx_slot_03)))
 (let (($x438 (or (= ?x434 0) $x437)))
 (let (($x417 (and $x359 (>= 2 ?x361))))
 (let ((?x404 (mod (+ 2 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x409 (+ input_0_net.fin_segment_data (* ?x278 ?x404))))
 (let (($x407 (<= input_0_net.fin_segment_data ?x404)))
 (let (($x401 (<= v_0_rcv_buf 13)))
 (let (($x399 (= 0 v_0_rx_slot_02)))
 (let (($x406 (and $x312 $x354 $x356 $x399 $x401 (<= ?x404 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x414 (ite $x406 (ite (or $x407 (<= ?x409 1)) (ite $x407 0 ?x409) 1) v_0_rx_slot_02)))
 (let (($x418 (or (= ?x414 0) $x417)))
 (let (($x397 (and $x359 (>= 1 ?x361))))
 (let ((?x384 (mod (+ 1 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x389 (+ input_0_net.fin_segment_data (* ?x278 ?x384))))
 (let (($x387 (<= input_0_net.fin_segment_data ?x384)))
 (let (($x382 (<= v_0_rcv_buf 14)))
 (let (($x380 (= 0 v_0_rx_slot_01)))
 (let (($x386 (and $x312 $x354 $x356 $x380 $x382 (<= ?x384 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x394 (ite $x386 (ite (or $x387 (<= ?x389 1)) (ite $x387 0 ?x389) 1) v_0_rx_slot_01)))
 (let (($x395 (= ?x394 0)))
 (let (($x398 (or $x395 $x397)))
 (let ((?x677 (ite $x398 1 (ite $x418 2 (ite $x438 3 ?x674)))))
 (let (($x378 (and $x359 (>= 0 ?x361))))
 (let ((?x281 (mod (+ v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x370 (+ input_0_net.fin_segment_data (* ?x278 ?x281))))
 (let (($x368 (<= input_0_net.fin_segment_data ?x281)))
 (let (($x364 (<= v_0_rcv_buf 15)))
 (let (($x362 (= 0 v_0_rx_slot_00)))
 (let (($x367 (and $x312 $x354 $x356 $x362 $x364 (<= ?x281 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x375 (ite $x367 (ite (or $x368 (<= ?x370 1)) (ite $x368 0 ?x370) 1) v_0_rx_slot_00)))
 (let (($x379 (or (= ?x375 0) $x378)))
 (let ((?x678 (ite $x379 0 ?x677)))
 (let ((?x681 (ite $x359 (+ ?x361 (* ?x278 ?x678)) ?x361)))
 (let (($x682 (= 0 ?x681)))
 (let (($x685 (and $x359 $x356 $x682 $x312 $x320 $x344 v_0_fin_sent $x345)))
 (let (($x1595 (= due_1_user due_0_user)))
 (let ((?x1587 (ite (<= (- 999.0) ?x782) 1000 ?x787)))
 (let (($x1562 (and (not (and $x312 $x320 $x344 (= 0 (+ ?x820 (ite $x1117 1 0))))) active_0_rtx)))
 (let (($x1558 (and $x312 $x320 $x344 (<= 1 (+ ?x820 (ite $x1117 1 0))))))
 (let (($x686 (not $x685)))
 (let (($x1167 (and $x1159 $x1160 $x1162 $x1163 $x1166)))
 (let (($x1168 (not $x1167)))
 (let (($x1564 (and $x1168 $x686 (or $x1558 $x1562))))
 (let (($x1567 (and v_0_persist_active $x1168 (<= 1 ?x820) (not $x1564))))
 (let ((?x1592 (ite (or $x1558 $x1567) (+ now_1 (ite $x734 (ite (<= 60000 ?x1587) 60000 ?x1587) v_0_rto_ms)) due_0_rtx)))
 (let (($x1581 (= active_1_persist (and $x1159 $x1160 $x1162 $x1163 $x1166 (or active_0_persist $x1514)))))
 (let (($x1577 (not active_1_delack)))
 (let (($x1553 (= v_1_persist_elapsed_ms v_0_persist_elapsed_ms)))
 (let (($x1546 (= v_1_persist_deadline_ms (ite $x1167 (ite $x1514 ?x1542 v_0_persist_deadline_ms) 0))))
 (let (($x1536 (= v_1_persist_since_ms (ite $x1167 (ite $x1514 now_1 v_0_persist_since_ms) 0))))
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
 (let ((?x1456 (ite (or $x1165 (>= 15 ?x820) (and $x312 $x320 $x344 (not (= 0 ?x291)))) 0 v_0_tx_time_15)))
 (let (($x1215 (and $x312 $x320 $x344 (not (= 0 ?x291)))))
 (let ((?x1451 (ite (or (>= 14 ?x820) $x1165) 0 (ite $x1215 (ite (= 1 ?x291) v_0_tx_time_15 0) v_0_tx_time_14))))
 (let (($x1216 (= 1 ?x291)))
 (let ((?x1443 (ite $x1215 (ite $x1216 v_0_tx_time_14 (ite (= 2 ?x291) v_0_tx_time_15 0)) v_0_tx_time_13)))
 (let (($x1218 (= 2 ?x291)))
 (let ((?x1434 (ite $x1216 v_0_tx_time_13 (ite $x1218 v_0_tx_time_14 (ite (= 3 ?x291) v_0_tx_time_15 0)))))
 (let (($x1437 (= v_1_tx_time_12 (ite (or $x1165 (>= 12 ?x820)) 0 (ite $x1215 ?x1434 v_0_tx_time_12)))))
 (let (($x1220 (= 3 ?x291)))
 (let ((?x1424 (ite $x1218 v_0_tx_time_13 (ite $x1220 v_0_tx_time_14 (ite (= 4 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1427 (ite (or (>= 11 ?x820) $x1165) 0 (ite $x1215 (ite $x1216 v_0_tx_time_12 ?x1424) v_0_tx_time_11))))
 (let (($x1222 (= 4 ?x291)))
 (let ((?x1413 (ite $x1220 v_0_tx_time_13 (ite $x1222 v_0_tx_time_14 (ite (= 5 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1416 (ite $x1215 (ite $x1216 v_0_tx_time_11 (ite $x1218 v_0_tx_time_12 ?x1413)) v_0_tx_time_10)))
 (let (($x1224 (= 5 ?x291)))
 (let ((?x1401 (ite $x1222 v_0_tx_time_13 (ite $x1224 v_0_tx_time_14 (ite (= 6 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1404 (ite $x1216 v_0_tx_time_10 (ite $x1218 v_0_tx_time_11 (ite $x1220 v_0_tx_time_12 ?x1401)))))
 (let (($x1407 (= v_1_tx_time_09 (ite (or $x1165 (>= 9 ?x820)) 0 (ite $x1215 ?x1404 v_0_tx_time_09)))))
 (let (($x1226 (= 6 ?x291)))
 (let ((?x1388 (ite $x1224 v_0_tx_time_13 (ite $x1226 v_0_tx_time_14 (ite (= 7 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1391 (ite $x1218 v_0_tx_time_10 (ite $x1220 v_0_tx_time_11 (ite $x1222 v_0_tx_time_12 ?x1388)))))
 (let ((?x1394 (ite (or (>= 8 ?x820) $x1165) 0 (ite $x1215 (ite $x1216 v_0_tx_time_09 ?x1391) v_0_tx_time_08))))
 (let (($x1228 (= 7 ?x291)))
 (let ((?x1374 (ite $x1226 v_0_tx_time_13 (ite $x1228 v_0_tx_time_14 (ite (= 8 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1377 (ite $x1220 v_0_tx_time_10 (ite $x1222 v_0_tx_time_11 (ite $x1224 v_0_tx_time_12 ?x1374)))))
 (let ((?x1380 (ite $x1215 (ite $x1216 v_0_tx_time_08 (ite $x1218 v_0_tx_time_09 ?x1377)) v_0_tx_time_07)))
 (let (($x1230 (= 8 ?x291)))
 (let ((?x1359 (ite $x1228 v_0_tx_time_13 (ite $x1230 v_0_tx_time_14 (ite (= 9 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1362 (ite $x1222 v_0_tx_time_10 (ite $x1224 v_0_tx_time_11 (ite $x1226 v_0_tx_time_12 ?x1359)))))
 (let ((?x1365 (ite $x1216 v_0_tx_time_07 (ite $x1218 v_0_tx_time_08 (ite $x1220 v_0_tx_time_09 ?x1362)))))
 (let (($x1368 (= v_1_tx_time_06 (ite (or $x1165 (>= 6 ?x820)) 0 (ite $x1215 ?x1365 v_0_tx_time_06)))))
 (let (($x1232 (= 9 ?x291)))
 (let ((?x1343 (ite $x1230 v_0_tx_time_13 (ite $x1232 v_0_tx_time_14 (ite (= 10 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1346 (ite $x1224 v_0_tx_time_10 (ite $x1226 v_0_tx_time_11 (ite $x1228 v_0_tx_time_12 ?x1343)))))
 (let ((?x1349 (ite $x1218 v_0_tx_time_07 (ite $x1220 v_0_tx_time_08 (ite $x1222 v_0_tx_time_09 ?x1346)))))
 (let ((?x1352 (ite (or (>= 5 ?x820) $x1165) 0 (ite $x1215 (ite $x1216 v_0_tx_time_06 ?x1349) v_0_tx_time_05))))
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
 (let (($x1320 (= v_1_tx_time_03 (ite (or $x1165 (>= 3 ?x820)) 0 (ite $x1215 ?x1317 v_0_tx_time_03)))))
 (let (($x1238 (= 12 ?x291)))
 (let ((?x1289 (ite $x1236 v_0_tx_time_13 (ite $x1238 v_0_tx_time_14 (ite (= 13 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1292 (ite $x1230 v_0_tx_time_10 (ite $x1232 v_0_tx_time_11 (ite $x1234 v_0_tx_time_12 ?x1289)))))
 (let ((?x1295 (ite $x1224 v_0_tx_time_07 (ite $x1226 v_0_tx_time_08 (ite $x1228 v_0_tx_time_09 ?x1292)))))
 (let ((?x1298 (ite $x1218 v_0_tx_time_04 (ite $x1220 v_0_tx_time_05 (ite $x1222 v_0_tx_time_06 ?x1295)))))
 (let ((?x1301 (ite (or $x1165 (>= 2 ?x820)) 0 (ite $x1215 (ite $x1216 v_0_tx_time_03 ?x1298) v_0_tx_time_02))))
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
 (let (($x1264 (= v_1_tx_time_00 (ite (or (>= 0 ?x820) $x1165) 0 (ite $x1215 ?x1260 v_0_tx_time_00)))))
 (let (($x1199 (= v_1_rtt_sample_was_ambiguous (and v_0_rtt_active v_0_rtt_ambiguous))))
 (let (($x1194 (not v_1_rtt_start_new)))
 (let ((?x813 (* ?x278 ?x291)))
 (let ((?x1186 (+ ?x730 ?x813)))
 (let (($x1189 (and v_0_rtt_active $x312 $x320 $x344 (not (<= v_0_rtt_remaining ?x1186)))))
 (let ((?x1191 (ite (or $x1167 (and v_0_rtt_active $x312 $x320 $x344 $x731)) 0 (ite $x1189 ?x1186 v_0_rtt_remaining))))
 (let (($x1182 (= v_1_rtt_end v_0_rtt_end)))
 (let (($x1181 (= v_1_rtt_start_ms v_0_rtt_start_ms)))
 (let (($x1169 (and v_0_rtt_active $x312 $x320 $x344 $x731)))
 (let (($x1170 (not $x1169)))
 (let (($x1157 (= v_1_rtt_previous_measured (ite $x734 v_0_rtt_measured v_0_rtt_previous_measured))))
 (let (($x1150 (= v_1_rtt_previous_var (ite $x734 v_0_rttvar_ms v_0_rtt_previous_var))))
 (let (($x1146 (= v_1_rtt_previous_srtt (ite $x734 v_0_srtt_ms v_0_rtt_previous_srtt))))
 (let ((?x1126 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data) 4294967296)))
 (let (($x1119 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x1115 (= v_1_fin_requested v_0_fin_requested)))
 (let ((?x1093 (ite (or (and $x359 $x356 $x682) (not (and $x379 (not $x661)))) 0 ?x658)))
 (let (($x909 (not $x661)))
 (let (($x713 (not $x379)))
 (let (($x878 (not $x418)))
 (let (($x876 (not $x438)))
 (let (($x874 (not $x458)))
 (let (($x872 (not $x478)))
 (let (($x870 (not $x498)))
 (let (($x868 (not $x518)))
 (let (($x866 (not $x536)))
 (let (($x864 (not $x554)))
 (let (($x862 (not $x572)))
 (let (($x860 (not $x590)))
 (let (($x858 (not $x608)))
 (let (($x856 (not $x626)))
 (let (($x854 (not $x644)))
 (let (($x853 (and false $x662)))
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
 (let (($x875 (and $x873 $x874)))
 (let (($x877 (and $x875 $x876)))
 (let (($x880 (or $x397 (and $x877 $x878) $x395)))
 (let ((?x707 (ite $x643 0 ?x640)))
 (let (($x683 (and $x359 $x356 $x682)))
 (let (($x1089 (= v_1_rx_slot_14 (ite $x683 0 (ite $x379 ?x707 (ite (and $x880 $x713 $x909) ?x658 0))))))
 (let (($x881 (and $x880 $x713)))
 (let ((?x1081 (ite $x881 ?x707 (ite (and (or $x877 $x418) (not $x398) $x713 $x909) ?x658 0))))
 (let ((?x706 (ite $x625 0 ?x622)))
 (let (($x883 (not $x398)))
 (let (($x882 (or $x877 $x418)))
 (let (($x884 (and $x882 $x883 $x713)))
 (let ((?x1074 (ite $x884 ?x707 (ite (and (or $x875 $x438) $x878 $x883 $x713 $x909) ?x658 0))))
 (let ((?x705 (ite $x607 0 ?x604)))
 (let (($x1078 (= v_1_rx_slot_12 (ite $x683 0 (ite $x379 ?x705 (ite $x881 ?x706 ?x1074))))))
 (let (($x885 (or $x875 $x438)))
 (let (($x886 (and $x885 $x878 $x883 $x713)))
 (let ((?x1066 (ite $x886 ?x707 (ite (and (or $x873 $x458) $x876 $x878 $x883 $x713 $x909) ?x658 0))))
 (let ((?x704 (ite $x589 0 ?x586)))
 (let (($x1071 (= v_1_rx_slot_11 (ite $x683 0 (ite $x379 ?x704 (ite $x881 ?x705 (ite $x884 ?x706 ?x1066)))))))
 (let (($x887 (or $x873 $x458)))
 (let (($x888 (and $x887 $x876 $x878 $x883 $x713)))
 (let ((?x1057 (ite $x888 ?x707 (ite (and (or $x871 $x478) $x874 $x876 $x878 $x883 $x713 $x909) ?x658 0))))
 (let ((?x703 (ite $x571 0 ?x568)))
 (let ((?x1062 (ite $x683 0 (ite $x379 ?x703 (ite $x881 ?x704 (ite $x884 ?x705 (ite $x886 ?x706 ?x1057)))))))
 (let ((?x1046 (ite (and (or $x869 $x498) $x872 $x874 $x876 $x878 $x883 $x713 $x909) ?x658 0)))
 (let (($x889 (or $x871 $x478)))
 (let (($x890 (and $x889 $x874 $x876 $x878 $x883 $x713)))
 (let ((?x1051 (ite $x881 ?x703 (ite $x884 ?x704 (ite $x886 ?x705 (ite $x888 ?x706 (ite $x890 ?x707 ?x1046)))))))
 (let ((?x702 (ite $x553 0 ?x550)))
 (let ((?x1035 (ite (and (or $x867 $x518) $x870 $x872 $x874 $x876 $x878 $x883 $x713 $x909) ?x658 0)))
 (let (($x891 (or $x869 $x498)))
 (let (($x892 (and $x891 $x872 $x874 $x876 $x878 $x883 $x713)))
 (let ((?x1040 (ite $x884 ?x703 (ite $x886 ?x704 (ite $x888 ?x705 (ite $x890 ?x706 (ite $x892 ?x707 ?x1035)))))))
 (let ((?x701 (ite $x535 0 ?x532)))
 (let (($x1044 (= v_1_rx_slot_08 (ite $x683 0 (ite $x379 ?x701 (ite $x881 ?x702 ?x1040))))))
 (let ((?x1023 (ite (and (or $x865 $x536) $x868 $x870 $x872 $x874 $x876 $x878 $x883 $x713 $x909) ?x658 0)))
 (let (($x893 (or $x867 $x518)))
 (let (($x894 (and $x893 $x870 $x872 $x874 $x876 $x878 $x883 $x713)))
 (let ((?x1028 (ite $x886 ?x703 (ite $x888 ?x704 (ite $x890 ?x705 (ite $x892 ?x706 (ite $x894 ?x707 ?x1023)))))))
 (let ((?x700 (ite $x517 0 ?x514)))
 (let (($x1033 (= v_1_rx_slot_07 (ite $x683 0 (ite $x379 ?x700 (ite $x881 ?x701 (ite $x884 ?x702 ?x1028)))))))
 (let (($x897 (or $x863 $x554)))
 (let ((?x1010 (ite (and $x897 $x866 $x868 $x870 $x872 $x874 $x876 $x878 $x883 $x713 $x909) ?x658 0)))
 (let (($x895 (or $x865 $x536)))
 (let (($x896 (and $x895 $x868 $x870 $x872 $x874 $x876 $x878 $x883 $x713)))
 (let ((?x1015 (ite $x888 ?x703 (ite $x890 ?x704 (ite $x892 ?x705 (ite $x894 ?x706 (ite $x896 ?x707 ?x1010)))))))
 (let ((?x699 (ite $x497 0 ?x494)))
 (let ((?x1020 (ite $x683 0 (ite $x379 ?x699 (ite $x881 ?x700 (ite $x884 ?x701 (ite $x886 ?x702 ?x1015)))))))
 (let (($x899 (or $x861 $x572)))
 (let ((?x996 (ite (and $x899 $x864 $x866 $x868 $x870 $x872 $x874 $x876 $x878 $x883 $x713 $x909) ?x658 0)))
 (let (($x898 (and $x897 $x866 $x868 $x870 $x872 $x874 $x876 $x878 $x883 $x713)))
 (let ((?x1001 (ite $x890 ?x703 (ite $x892 ?x704 (ite $x894 ?x705 (ite $x896 ?x706 (ite $x898 ?x707 ?x996)))))))
 (let ((?x698 (ite $x477 0 ?x474)))
 (let ((?x1006 (ite $x379 ?x698 (ite $x881 ?x699 (ite $x884 ?x700 (ite $x886 ?x701 (ite $x888 ?x702 ?x1001)))))))
 (let (($x901 (or $x859 $x590)))
 (let (($x980 (and $x901 $x862 $x864 $x866 $x868 $x870 $x872 $x874 $x876 $x878 $x883 $x713 $x909)))
 (let (($x900 (and $x899 $x864 $x866 $x868 $x870 $x872 $x874 $x876 $x878 $x883 $x713)))
 (let ((?x985 (ite $x894 ?x704 (ite $x896 ?x705 (ite $x898 ?x706 (ite $x900 ?x707 (ite $x980 ?x658 0)))))))
 (let ((?x990 (ite $x884 ?x699 (ite $x886 ?x700 (ite $x888 ?x701 (ite $x890 ?x702 (ite $x892 ?x703 ?x985)))))))
 (let ((?x697 (ite $x457 0 ?x454)))
 (let (($x994 (= v_1_rx_slot_04 (ite $x683 0 (ite $x379 ?x697 (ite $x881 ?x698 ?x990))))))
 (let (($x903 (or $x857 $x608)))
 (let (($x964 (and $x903 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x874 $x876 $x878 $x883 $x713 $x909)))
 (let (($x902 (and $x901 $x862 $x864 $x866 $x868 $x870 $x872 $x874 $x876 $x878 $x883 $x713)))
 (let ((?x969 (ite $x896 ?x704 (ite $x898 ?x705 (ite $x900 ?x706 (ite $x902 ?x707 (ite $x964 ?x658 0)))))))
 (let ((?x974 (ite $x886 ?x699 (ite $x888 ?x700 (ite $x890 ?x701 (ite $x892 ?x702 (ite $x894 ?x703 ?x969)))))))
 (let ((?x696 (ite $x437 0 ?x434)))
 (let (($x979 (= v_1_rx_slot_03 (ite $x683 0 (ite $x379 ?x696 (ite $x881 ?x697 (ite $x884 ?x698 ?x974)))))))
 (let (($x905 (or $x855 $x626)))
 (let (($x947 (and $x905 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x874 $x876 $x878 $x883 $x713 $x909)))
 (let (($x904 (and $x903 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x874 $x876 $x878 $x883 $x713)))
 (let ((?x952 (ite $x898 ?x704 (ite $x900 ?x705 (ite $x902 ?x706 (ite $x904 ?x707 (ite $x947 ?x658 0)))))))
 (let ((?x957 (ite $x888 ?x699 (ite $x890 ?x700 (ite $x892 ?x701 (ite $x894 ?x702 (ite $x896 ?x703 ?x952)))))))
 (let ((?x695 (ite $x417 0 ?x414)))
 (let ((?x962 (ite $x683 0 (ite $x379 ?x695 (ite $x881 ?x696 (ite $x884 ?x697 (ite $x886 ?x698 ?x957)))))))
 (let (($x907 (or $x853 $x644)))
 (let (($x929 (and $x907 $x856 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x874 $x876 $x878 $x883 $x713 $x909)))
 (let (($x906 (and $x905 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x874 $x876 $x878 $x883 $x713)))
 (let ((?x934 (ite $x900 ?x704 (ite $x902 ?x705 (ite $x904 ?x706 (ite $x906 ?x707 (ite $x929 ?x658 0)))))))
 (let ((?x939 (ite $x890 ?x699 (ite $x892 ?x700 (ite $x894 ?x701 (ite $x896 ?x702 (ite $x898 ?x703 ?x934)))))))
 (let ((?x694 (ite $x397 0 ?x394)))
 (let ((?x944 (ite $x379 ?x694 (ite $x881 ?x695 (ite $x884 ?x696 (ite $x886 ?x697 (ite $x888 ?x698 ?x939)))))))
 (let (($x910 (and $x662 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x874 $x876 $x878 $x883 $x713 $x909)))
 (let (($x908 (and $x907 $x856 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x874 $x876 $x878 $x883 $x713)))
 (let ((?x915 (ite $x902 ?x704 (ite $x904 ?x705 (ite $x906 ?x706 (ite $x908 ?x707 (ite $x910 ?x658 0)))))))
 (let ((?x920 (ite $x892 ?x699 (ite $x894 ?x700 (ite $x896 ?x701 (ite $x898 ?x702 (ite $x900 ?x703 ?x915)))))))
 (let ((?x925 (ite $x881 ?x694 (ite $x884 ?x695 (ite $x886 ?x696 (ite $x888 ?x697 (ite $x890 ?x698 ?x920)))))))
 (let ((?x693 (ite $x378 0 ?x375)))
 (let ((?x715 (ite (and (<= 0 ?x678) $x713) ?x677 0)))
 (let ((?x709 (+ ?x693 ?x694 ?x695 ?x696 ?x697 ?x698 ?x699 ?x700 ?x701 ?x702 ?x703 ?x704 ?x705 ?x706 ?x707 (ite $x661 0 ?x658))))
 (let ((?x711 (ite (<= ?x709 0) 0 ?x709)))
 (let ((?x717 (ite (<= ?x711 ?x715) ?x711 ?x715)))
 (let (($x851 (= v_1_take v_0_take)))
 (let (($x811 (= v_1_snd_buf v_0_snd_buf)))
 (let (($x805 (= v_1_msl_ms v_0_msl_ms)))
 (let (($x802 (= v_1_user_timeout_ms v_0_user_timeout_ms)))
 (let (($x799 (= v_1_active_open v_0_active_open)))
 (let (($x796 (= v_1_retries v_0_retries)))
 (let (($x726 (= v_1_tx_flags v_0_tx_flags)))
 (let (($x723 (= v_1_tx_ack v_0_tx_ack)))
 (let (($x722 (= v_1_tx_seq v_0_tx_seq)))
 (let (($x721 (= v_1_rcv_nxt (mod (+ v_0_rcv_nxt ?x717 (ite $x683 1 0)) 4294967296))))
 (let (($x692 (= v_1_snd_nxt v_0_snd_nxt)))
 (let (($x688 (= v_1_irs v_0_irs)))
 (let (($x687 (= v_1_iss v_0_iss)))
 (let (($x684 (not $x683)))
 (let (($x324 (and $x320 (<= ?x291 (mod (+ v_0_snd_nxt (* ?x278 v_0_snd_una)) 4294967296)))))
 (let (($x319 (= 0 ?x291)))
 (let (($x297 (= (mod (+ input_0_net.fin_segment_ack (* ?x278 v_0_snd_nxt)) 4294967296) 2147483648)))
 (and (>= now_1 now_0) (<= 0 input_0_net.fin_segment_data) (>= 16 input_0_net.fin_segment_data) (not (= ?x281 2147483648)) (<= 0 input_0_net.fin_segment_window) (>= 65535 input_0_net.fin_segment_window) (or (and (not (= ?x291 2147483648)) (not $x297)) (not $x312)) v_0_fin_sent (not (= ?x291 (+ 1 v_0_rtx_buf))) (not (or $x319 $x324)) (or (not active_0_rtx) (not (<= due_0_rtx now_1))) (or (not active_0_user) (not (<= due_0_user now_1))) (or (not active_0_time_wait) (not (<= due_0_time_wait now_1))) (or (not active_0_delack) (not (<= due_0_delack now_1))) (or (not active_0_persist) (not (<= due_0_persist now_1))) $x347 $x684 $x686 $x687 $x688 (= v_1_snd_una (ite $x689 input_0_net.fin_segment_ack v_0_snd_una)) $x692 $x721 $x722 $x723 $x726 (= v_1_rto_ms ?x792) $x796 $x799 $x802 $x805 (= v_1_local_window (+ 16 (* ?x278 v_0_rcv_buf) (* ?x278 ?x717))) $x811 (= v_1_rtx_buf ?x820) (= v_1_rcv_buf (+ v_0_rcv_buf ?x717)) (= v_1_snd_wnd ?x843) (= v_1_snd_wl1 (ite $x841 input_0_net.fin_segment_seq v_0_snd_wl1)) (= v_1_snd_wl2 (ite $x841 input_0_net.fin_segment_ack v_0_snd_wl2)) $x851 (= v_1_rx_chunk ?x717) (= v_1_rx_slot_00 (ite $x683 0 (ite $x379 ?x693 ?x925))) (= v_1_rx_slot_01 (ite $x683 0 ?x944)) (= v_1_rx_slot_02 ?x962) $x979 $x994 (= v_1_rx_slot_05 (ite $x683 0 ?x1006)) (= v_1_rx_slot_06 ?x1020) $x1033 $x1044 (= v_1_rx_slot_09 (ite $x683 0 (ite $x379 ?x702 ?x1051))) (= v_1_rx_slot_10 ?x1062) $x1071 $x1078 (= v_1_rx_slot_13 (ite $x683 0 (ite $x379 ?x706 ?x1081))) $x1089 (= v_1_rx_slot_15 ?x1093) (= v_1_rx_advance ?x678) (= v_1_rx_acceptable (and $x312 $x354 $x356)) (= v_1_seg_acceptable $x312) (= v_1_ack_delta ?x291) (= v_1_ack_is_new (and $x320 $x344)) (= v_1_ack_is_future $x353) (= v_1_ack_advance $x689) (= v_1_ack_window_update $x841) $x1115 (= v_1_fin_sent $x1117) $x1119 (= v_1_fin_acknowledged $x346) (= v_1_rx_fin_pending (and $x359 $x684)) (= v_1_rx_fin_seq (ite $x358 ?x1126 v_0_rx_fin_seq)) (= v_1_rx_fin_offset (ite $x683 0 ?x681)) (= v_1_rx_fin_done (or v_0_rx_fin_done $x683)) (= v_1_rx_fin_consumed $x683) (= v_1_srtt_ms ?x754) (= v_1_rttvar_ms ?x777) (= v_1_rtt_error_ms ?x770) $x1146 $x1150 (= v_1_rtt_measured (or v_0_rtt_measured $x734)) $x1157 (= v_1_rtt_active (and $x1168 v_0_rtt_active $x1170)) (= v_1_rtt_ambiguous (and $x1168 $x1170 v_0_rtt_ambiguous)) (= v_1_rtt_sample_at_ms (ite $x734 now_1 v_0_rtt_sample_at_ms)) $x1181 $x1182 (= v_1_rtt_remaining ?x1191) $x1194 (= v_1_rtt_sample_used $x734) $x1199 (= v_1_rtt_last_ms ?x749) (= v_1_rtt_samples (+ v_0_rtt_samples (ite $x734 1 0))) (= v_1_rto_base_ms (ite $x734 ?x790 v_0_rto_base_ms)) $x1264 (= v_1_tx_time_01 (ite (or $x1163 $x1165) 0 ?x1281)) (= v_1_tx_time_02 ?x1301) $x1320 (= v_1_tx_time_04 (ite (or $x1165 (>= 4 ?x820)) 0 ?x1335)) (= v_1_tx_time_05 ?x1352) $x1368 (= v_1_tx_time_07 (ite (or $x1165 (>= 7 ?x820)) 0 ?x1380)) (= v_1_tx_time_08 ?x1394) $x1407 (= v_1_tx_time_10 (ite (or $x1165 (>= 10 ?x820)) 0 ?x1416)) (= v_1_tx_time_11 ?x1427) $x1437 (= v_1_tx_time_13 (ite (or $x1165 (>= 13 ?x820)) 0 ?x1443)) (= v_1_tx_time_14 ?x1451) (= v_1_tx_time_15 ?x1456) (= v_1_tx_fin_time (ite $x1117 v_0_tx_fin_time 0)) $x1464 $x1467 $x1470 $x1472 $x1475 $x1478 $x1481 $x1483 $x1485 $x1487 $x1489 $x1491 $x1493 $x1495 $x1497 $x1500 $x1503 $x1505 $x1507 (= v_1_persist_active $x1167) (= v_1_persist_eligible $x1167) (= v_1_persist_start $x1514) $x1517 $x1519 $x1521 $x1523 (= v_1_persist_interval_ms (ite $x1167 ?x1526 1000)) $x1531 $x1536 (= v_1_persist_last_ms (ite $x1167 v_0_persist_last_ms 0)) $x1546 (= v_1_persist_probes (ite $x1167 v_0_persist_probes 0)) $x1553 (= active_1_rtx (or $x1564 $x1567)) (= active_1_user (and $x686 active_0_user)) (= active_1_time_wait (or active_0_time_wait $x685)) $x1577 $x1581 (= due_1_rtx ?x1592) $x1595 (= due_1_time_wait (ite $x685 ?x1598 due_0_time_wait)) $x1602 (= due_1_persist (ite $x1514 ?x1542 due_0_persist)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
 (let (($x362 (= 0 v_0_rx_slot_00)))
 (let (($x1621 (not (>= v_0_rcv_buf 16))))
 (or $x1621 $x362))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x380 (= 0 v_0_rx_slot_01)))
 (let (($x1625 (not (>= v_0_rcv_buf 15))))
 (or $x1625 $x380))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x399 (= 0 v_0_rx_slot_02)))
 (let (($x1629 (not (>= v_0_rcv_buf 14))))
 (or $x1629 $x399))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x419 (= 0 v_0_rx_slot_03)))
 (let (($x1633 (not (>= v_0_rcv_buf 13))))
 (or $x1633 $x419))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x439 (= 0 v_0_rx_slot_04)))
 (let (($x1637 (not (>= v_0_rcv_buf 12))))
 (or $x1637 $x439))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x459 (= 0 v_0_rx_slot_05)))
 (let (($x1641 (not (>= v_0_rcv_buf 11))))
 (or $x1641 $x459))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x479 (= 0 v_0_rx_slot_06)))
 (let (($x1645 (not (>= v_0_rcv_buf 10))))
 (or $x1645 $x479))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x499 (= 0 v_0_rx_slot_07)))
 (let (($x1649 (not (>= v_0_rcv_buf 9))))
 (or $x1649 $x499))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x519 (= 0 v_0_rx_slot_08)))
 (let (($x1653 (not (>= v_0_rcv_buf 8))))
 (or $x1653 $x519))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x537 (= 0 v_0_rx_slot_09)))
 (let (($x1657 (not (>= v_0_rcv_buf 7))))
 (or $x1657 $x537))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x555 (= 0 v_0_rx_slot_10)))
 (let (($x1661 (not (>= v_0_rcv_buf 6))))
 (or $x1661 $x555))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x573 (= 0 v_0_rx_slot_11)))
 (let (($x1665 (not (>= v_0_rcv_buf 5))))
 (or $x1665 $x573))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x591 (= 0 v_0_rx_slot_12)))
 (let (($x1669 (not (>= v_0_rcv_buf 4))))
 (or $x1669 $x591))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x609 (= 0 v_0_rx_slot_13)))
 (let (($x1673 (not (>= v_0_rcv_buf 3))))
 (or $x1673 $x609))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x627 (= 0 v_0_rx_slot_14)))
 (let (($x1677 (not (>= v_0_rcv_buf 2))))
 (or $x1677 $x627))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x645 (= 0 v_0_rx_slot_15)))
 (let (($x1681 (not (>= v_0_rcv_buf 1))))
 (or $x1681 $x645))))
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
 (let (($x356 (not v_0_rx_fin_done)))
 (let (($x1707 (and $x356 $x1705 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window)))))
 (let (($x357 (not v_0_rx_fin_pending)))
 (or $x357 $x1707))))))
(assert
 (let (($x1710 (>= 15 v_0_rx_fin_offset)))
 (and (<= 0 v_0_rx_fin_offset) $x1710 (= v_0_rx_fin_pending (<= 1 v_0_rx_fin_offset)))))
(assert
 (let (($x357 (not v_0_rx_fin_pending)))
 (or $x357 (= v_0_rx_fin_seq (mod (+ v_0_rcv_nxt v_0_rx_fin_offset) 4294967296)))))
(assert
 (let (($x356 (not v_0_rx_fin_done)))
 (or $x356 (= v_0_rcv_nxt (mod (+ 1 v_0_rx_fin_seq) 4294967296)))))
(assert
 (let (($x362 (= 0 v_0_rx_slot_00)))
 (or (not (and v_0_rx_fin_pending (>= 0 v_0_rx_fin_offset))) $x362)))
(assert
 (let (($x380 (= 0 v_0_rx_slot_01)))
 (or (not (and v_0_rx_fin_pending (>= 1 v_0_rx_fin_offset))) $x380)))
(assert
 (let (($x399 (= 0 v_0_rx_slot_02)))
 (or (not (and v_0_rx_fin_pending (>= 2 v_0_rx_fin_offset))) $x399)))
(assert
 (let (($x419 (= 0 v_0_rx_slot_03)))
 (or (not (and v_0_rx_fin_pending (>= 3 v_0_rx_fin_offset))) $x419)))
(assert
 (let (($x439 (= 0 v_0_rx_slot_04)))
 (or (not (and v_0_rx_fin_pending (>= 4 v_0_rx_fin_offset))) $x439)))
(assert
 (let (($x459 (= 0 v_0_rx_slot_05)))
 (or (not (and v_0_rx_fin_pending (>= 5 v_0_rx_fin_offset))) $x459)))
(assert
 (let (($x479 (= 0 v_0_rx_slot_06)))
 (or (not (and v_0_rx_fin_pending (>= 6 v_0_rx_fin_offset))) $x479)))
(assert
 (let (($x499 (= 0 v_0_rx_slot_07)))
 (or (not (and v_0_rx_fin_pending (>= 7 v_0_rx_fin_offset))) $x499)))
(assert
 (let (($x519 (= 0 v_0_rx_slot_08)))
 (or (not (and v_0_rx_fin_pending (>= 8 v_0_rx_fin_offset))) $x519)))
(assert
 (let (($x537 (= 0 v_0_rx_slot_09)))
 (or (not (and v_0_rx_fin_pending (>= 9 v_0_rx_fin_offset))) $x537)))
(assert
 (let (($x555 (= 0 v_0_rx_slot_10)))
 (or (not (and v_0_rx_fin_pending (>= 10 v_0_rx_fin_offset))) $x555)))
(assert
 (let (($x573 (= 0 v_0_rx_slot_11)))
 (or (not (and v_0_rx_fin_pending (>= 11 v_0_rx_fin_offset))) $x573)))
(assert
 (let (($x591 (= 0 v_0_rx_slot_12)))
 (or (not (and v_0_rx_fin_pending (>= 12 v_0_rx_fin_offset))) $x591)))
(assert
 (let (($x609 (= 0 v_0_rx_slot_13)))
 (or (not (and v_0_rx_fin_pending (>= 13 v_0_rx_fin_offset))) $x609)))
(assert
 (let (($x627 (= 0 v_0_rx_slot_14)))
 (or (not (and v_0_rx_fin_pending (>= 14 v_0_rx_fin_offset))) $x627)))
(assert
 (let (($x645 (= 0 v_0_rx_slot_15)))
 (or (not (and v_0_rx_fin_pending (>= 15 v_0_rx_fin_offset))) $x645)))
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
 (let ((?x737 (- 1.0)))
 (let ((?x766 (* ?x737 v_0_srtt_ms)))
 (let ((?x1801 (+ ?x766 (* ?x737 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x1798)))))
 (let ((?x1802 (to_int ?x1801)))
 (let ((?x278 (- 1)))
 (let ((?x1805 (ite (<= ?x1802 (- 1000)) (* ?x278 ?x1802) 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x1805) 60000 ?x1805) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x322 (mod (+ v_0_snd_nxt (* (- 1) v_0_snd_una)) 4294967296)))
 (let ((?x730 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x1818 (and (<= v_0_rtt_start_ms now_0) (<= 1 v_0_rtt_remaining) (>= 4 v_0_rtt_remaining) (>= ?x730 v_0_rtt_remaining) (<= ?x730 ?x322))))
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
 (let ((?x761 (/ 1.0 4.0)))
 (let ((?x1844 (ite v_0_rtt_previous_measured (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* ?x761 ?x1840)) (* (/ 1.0 2.0) ?x1834))))
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
 (= 179 choice_0))
(assert
 (= 5 state_0))
(assert
 (= 5 state_1))
(assert
 (or (not (or (not (>= 5 v_1_rtx_buf)) (= 0 v_1_tx_time_05)))))
(check-sat)
