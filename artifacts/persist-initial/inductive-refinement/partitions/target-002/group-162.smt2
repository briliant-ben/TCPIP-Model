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
 (let (($x727 (not v_0_rtt_ambiguous)))
 (let ((?x724 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let ((?x305 (mod (+ input_0_net.fin_segment_ack (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x725 (>= ?x305 ?x724)))
 (let ((?x336 (ite v_0_fin_sent 1 0)))
 (let ((?x337 (+ v_0_rtx_buf ?x336)))
 (let (($x338 (<= ?x305 ?x337)))
 (let (($x335 (<= 1 ?x305)))
 (let ((?x278 (- 1)))
 (let ((?x294 (+ ?x278 v_0_local_window)))
 (let (($x299 (<= (mod (+ input_0_net.fin_segment_seq (* ?x278 v_0_rcv_nxt)) 4294967296) ?x294)))
 (let (($x290 (<= 1 v_0_local_window)))
 (let ((?x291 (* ?x278 v_0_rcv_nxt)))
 (let ((?x293 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data ?x291) 4294967296)))
 (let (($x295 (<= ?x293 ?x294)))
 (let (($x301 (or (and $x290 $x295) (and $x290 $x299))))
 (let (($x728 (and v_0_rtt_active $x301 $x335 $x338 $x725 $x727)))
 (let ((?x743 (ite $x728 (+ now_1 (* ?x278 v_0_rtt_start_ms)) v_0_rtt_last_ms)))
 (let ((?x744 (to_real ?x743)))
 (let ((?x768 (/ 1.0 2.0)))
 (let ((?x757 (+ v_0_srtt_ms (* (- 1.0) ?x744))))
 (let ((?x764 (ite $x728 (ite (>= ?x757 0.0) ?x757 (+ (* (- 1.0) v_0_srtt_ms) ?x744)) v_0_rtt_error_ms)))
 (let ((?x755 (/ 1.0 4.0)))
 (let ((?x770 (ite v_0_rtt_measured (+ (* (/ 3.0 4.0) v_0_rttvar_ms) (* ?x755 ?x764)) (* ?x768 ?x744))))
 (let ((?x771 (ite $x728 ?x770 v_0_rttvar_ms)))
 (let ((?x731 (- 1.0)))
 (let ((?x747 (ite v_0_rtt_measured (+ (* (/ 7.0 8.0) v_0_srtt_ms) (* (/ 1.0 8.0) ?x744)) ?x744)))
 (let ((?x748 (ite $x728 ?x747 v_0_srtt_ms)))
 (let ((?x776 (+ (* ?x731 ?x748) (* ?x731 (ite (<= ?x771 ?x755) 1.0 (* 4.0 ?x771))))))
 (let ((?x777 (to_int ?x776)))
 (let ((?x781 (* ?x278 ?x777)))
 (let ((?x782 (ite (<= ?x777 (- 1000)) ?x781 1000)))
 (let ((?x784 (ite (<= 60000 ?x782) 60000 ?x782)))
 (let ((?x786 (ite $x728 ?x784 v_0_rto_ms)))
 (let (($x1507 (not v_0_persist_active)))
 (let ((?x811 (ite (<= 0 v_0_rtx_buf) v_0_rtx_buf 0)))
 (let ((?x809 (ite (<= v_0_rtx_buf ?x305) 0 (+ v_0_rtx_buf (* ?x278 ?x305)))))
 (let (($x683 (and $x301 $x335 $x338)))
 (let ((?x814 (ite $x683 (ite (<= ?x809 ?x811) ?x809 ?x811) v_0_rtx_buf)))
 (let (($x1159 (= 0 ?x814)))
 (let (($x1160 (or v_0_persist_active $x1159)))
 (let (($x1157 (>= 1 ?x814)))
 (let (($x1156 (<= 1 (+ ?x814 v_0_snd_buf))))
 (let (($x339 (= ?x305 ?x337)))
 (let (($x340 (and $x301 $x335 $x338 v_0_fin_sent $x339)))
 (let (($x341 (not $x340)))
 (let (($x1111 (and $x341 v_0_fin_sent)))
 (let (($x1154 (not $x1111)))
 (let ((?x828 (mod (+ input_0_net.fin_segment_seq (* ?x278 v_0_snd_wl1)) 4294967296)))
 (let (($x823 (<= 2147483648 (mod (+ input_0_net.fin_segment_ack (* ?x278 v_0_snd_wl2)) 4294967296))))
 (let (($x819 (= v_0_snd_wl1 input_0_net.fin_segment_seq)))
 (let (($x834 (or (and $x819 (not $x823)) (and (not (<= ?x828 0)) (not (<= 2147483648 ?x828))))))
 (let (($x835 (and $x301 $x338 $x834)))
 (let ((?x837 (ite $x835 input_0_net.fin_segment_window v_0_snd_wnd)))
 (let (($x1153 (= 0 ?x837)))
 (let (($x1508 (and $x1153 $x1154 $x1156 $x1157 $x1160 $x1507)))
 (let ((?x1520 (ite $x1508 ?x786 v_0_persist_interval_ms)))
 (let ((?x1536 (+ now_1 ?x1520)))
 (let (($x1596 (= due_1_delack due_0_delack)))
 (let ((?x1592 (+ now_1 (* 2 v_0_msl_ms))))
 (let (($x351 (not v_0_rx_fin_pending)))
 (let (($x350 (not v_0_rx_fin_done)))
 (let (($x347 (and (>= ?x305 (+ 1 v_0_rtx_buf ?x336)) (>= 2147483647 ?x305))))
 (let (($x348 (not $x347)))
 (let (($x352 (and $x301 $x348 $x350 $x351 $x290 $x295)))
 (let ((?x355 (ite $x352 ?x293 v_0_rx_fin_offset)))
 (let (($x353 (or v_0_rx_fin_pending $x352)))
 (let (($x655 (and $x353 (>= 15 ?x355))))
 (let ((?x642 (mod (+ 15 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x647 (+ input_0_net.fin_segment_data (* ?x278 ?x642))))
 (let (($x645 (<= input_0_net.fin_segment_data ?x642)))
 (let (($x640 (<= v_0_rcv_buf 0)))
 (let (($x639 (= 0 v_0_rx_slot_15)))
 (let (($x644 (and $x301 $x348 $x350 $x639 $x640 (<= ?x642 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x652 (ite $x644 (ite (or $x645 (<= ?x647 1)) (ite $x645 0 ?x647) 1) v_0_rx_slot_15)))
 (let (($x656 (or (= ?x652 0) $x655)))
 (let (($x637 (and $x353 (>= 14 ?x355))))
 (let ((?x624 (mod (+ 14 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x629 (+ input_0_net.fin_segment_data (* ?x278 ?x624))))
 (let (($x627 (<= input_0_net.fin_segment_data ?x624)))
 (let (($x622 (<= v_0_rcv_buf 1)))
 (let (($x621 (= 0 v_0_rx_slot_14)))
 (let (($x626 (and $x301 $x348 $x350 $x621 $x622 (<= ?x624 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x634 (ite $x626 (ite (or $x627 (<= ?x629 1)) (ite $x627 0 ?x629) 1) v_0_rx_slot_14)))
 (let (($x638 (or (= ?x634 0) $x637)))
 (let (($x619 (and $x353 (>= 13 ?x355))))
 (let ((?x606 (mod (+ 13 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x611 (+ input_0_net.fin_segment_data (* ?x278 ?x606))))
 (let (($x609 (<= input_0_net.fin_segment_data ?x606)))
 (let (($x604 (<= v_0_rcv_buf 2)))
 (let (($x603 (= 0 v_0_rx_slot_13)))
 (let (($x608 (and $x301 $x348 $x350 $x603 $x604 (<= ?x606 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x616 (ite $x608 (ite (or $x609 (<= ?x611 1)) (ite $x609 0 ?x611) 1) v_0_rx_slot_13)))
 (let (($x620 (or (= ?x616 0) $x619)))
 (let (($x601 (and $x353 (>= 12 ?x355))))
 (let ((?x588 (mod (+ 12 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x593 (+ input_0_net.fin_segment_data (* ?x278 ?x588))))
 (let (($x591 (<= input_0_net.fin_segment_data ?x588)))
 (let (($x586 (<= v_0_rcv_buf 3)))
 (let (($x585 (= 0 v_0_rx_slot_12)))
 (let (($x590 (and $x301 $x348 $x350 $x585 $x586 (<= ?x588 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x598 (ite $x590 (ite (or $x591 (<= ?x593 1)) (ite $x591 0 ?x593) 1) v_0_rx_slot_12)))
 (let (($x602 (or (= ?x598 0) $x601)))
 (let ((?x660 (ite $x602 12 (ite $x620 13 (ite $x638 14 (ite $x656 15 16))))))
 (let (($x583 (and $x353 (>= 11 ?x355))))
 (let ((?x570 (mod (+ 11 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x575 (+ input_0_net.fin_segment_data (* ?x278 ?x570))))
 (let (($x573 (<= input_0_net.fin_segment_data ?x570)))
 (let (($x568 (<= v_0_rcv_buf 4)))
 (let (($x567 (= 0 v_0_rx_slot_11)))
 (let (($x572 (and $x301 $x348 $x350 $x567 $x568 (<= ?x570 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x580 (ite $x572 (ite (or $x573 (<= ?x575 1)) (ite $x573 0 ?x575) 1) v_0_rx_slot_11)))
 (let (($x584 (or (= ?x580 0) $x583)))
 (let (($x565 (and $x353 (>= 10 ?x355))))
 (let ((?x552 (mod (+ 10 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x557 (+ input_0_net.fin_segment_data (* ?x278 ?x552))))
 (let (($x555 (<= input_0_net.fin_segment_data ?x552)))
 (let (($x550 (<= v_0_rcv_buf 5)))
 (let (($x549 (= 0 v_0_rx_slot_10)))
 (let (($x554 (and $x301 $x348 $x350 $x549 $x550 (<= ?x552 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x562 (ite $x554 (ite (or $x555 (<= ?x557 1)) (ite $x555 0 ?x557) 1) v_0_rx_slot_10)))
 (let (($x566 (or (= ?x562 0) $x565)))
 (let (($x547 (and $x353 (>= 9 ?x355))))
 (let ((?x534 (mod (+ 9 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x539 (+ input_0_net.fin_segment_data (* ?x278 ?x534))))
 (let (($x537 (<= input_0_net.fin_segment_data ?x534)))
 (let (($x532 (<= v_0_rcv_buf 6)))
 (let (($x531 (= 0 v_0_rx_slot_09)))
 (let (($x536 (and $x301 $x348 $x350 $x531 $x532 (<= ?x534 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x544 (ite $x536 (ite (or $x537 (<= ?x539 1)) (ite $x537 0 ?x539) 1) v_0_rx_slot_09)))
 (let (($x548 (or (= ?x544 0) $x547)))
 (let (($x529 (and $x353 (>= 8 ?x355))))
 (let ((?x516 (mod (+ 8 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x521 (+ input_0_net.fin_segment_data (* ?x278 ?x516))))
 (let (($x519 (<= input_0_net.fin_segment_data ?x516)))
 (let (($x514 (<= v_0_rcv_buf 7)))
 (let (($x513 (= 0 v_0_rx_slot_08)))
 (let (($x518 (and $x301 $x348 $x350 $x513 $x514 (<= ?x516 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x526 (ite $x518 (ite (or $x519 (<= ?x521 1)) (ite $x519 0 ?x521) 1) v_0_rx_slot_08)))
 (let (($x530 (or (= ?x526 0) $x529)))
 (let ((?x664 (ite $x530 8 (ite $x548 9 (ite $x566 10 (ite $x584 11 ?x660))))))
 (let (($x511 (and $x353 (>= 7 ?x355))))
 (let ((?x498 (mod (+ 7 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x503 (+ input_0_net.fin_segment_data (* ?x278 ?x498))))
 (let (($x501 (<= input_0_net.fin_segment_data ?x498)))
 (let (($x495 (<= v_0_rcv_buf 8)))
 (let (($x493 (= 0 v_0_rx_slot_07)))
 (let (($x500 (and $x301 $x348 $x350 $x493 $x495 (<= ?x498 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x508 (ite $x500 (ite (or $x501 (<= ?x503 1)) (ite $x501 0 ?x503) 1) v_0_rx_slot_07)))
 (let (($x512 (or (= ?x508 0) $x511)))
 (let (($x491 (and $x353 (>= 6 ?x355))))
 (let ((?x478 (mod (+ 6 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x483 (+ input_0_net.fin_segment_data (* ?x278 ?x478))))
 (let (($x481 (<= input_0_net.fin_segment_data ?x478)))
 (let (($x475 (<= v_0_rcv_buf 9)))
 (let (($x473 (= 0 v_0_rx_slot_06)))
 (let (($x480 (and $x301 $x348 $x350 $x473 $x475 (<= ?x478 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x488 (ite $x480 (ite (or $x481 (<= ?x483 1)) (ite $x481 0 ?x483) 1) v_0_rx_slot_06)))
 (let (($x492 (or (= ?x488 0) $x491)))
 (let (($x471 (and $x353 (>= 5 ?x355))))
 (let ((?x458 (mod (+ 5 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x463 (+ input_0_net.fin_segment_data (* ?x278 ?x458))))
 (let (($x461 (<= input_0_net.fin_segment_data ?x458)))
 (let (($x455 (<= v_0_rcv_buf 10)))
 (let (($x453 (= 0 v_0_rx_slot_05)))
 (let (($x460 (and $x301 $x348 $x350 $x453 $x455 (<= ?x458 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x468 (ite $x460 (ite (or $x461 (<= ?x463 1)) (ite $x461 0 ?x463) 1) v_0_rx_slot_05)))
 (let (($x472 (or (= ?x468 0) $x471)))
 (let (($x451 (and $x353 (>= 4 ?x355))))
 (let ((?x438 (mod (+ 4 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x443 (+ input_0_net.fin_segment_data (* ?x278 ?x438))))
 (let (($x441 (<= input_0_net.fin_segment_data ?x438)))
 (let (($x435 (<= v_0_rcv_buf 11)))
 (let (($x433 (= 0 v_0_rx_slot_04)))
 (let (($x440 (and $x301 $x348 $x350 $x433 $x435 (<= ?x438 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x448 (ite $x440 (ite (or $x441 (<= ?x443 1)) (ite $x441 0 ?x443) 1) v_0_rx_slot_04)))
 (let (($x452 (or (= ?x448 0) $x451)))
 (let ((?x668 (ite $x452 4 (ite $x472 5 (ite $x492 6 (ite $x512 7 ?x664))))))
 (let (($x431 (and $x353 (>= 3 ?x355))))
 (let ((?x418 (mod (+ 3 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x423 (+ input_0_net.fin_segment_data (* ?x278 ?x418))))
 (let (($x421 (<= input_0_net.fin_segment_data ?x418)))
 (let (($x415 (<= v_0_rcv_buf 12)))
 (let (($x413 (= 0 v_0_rx_slot_03)))
 (let (($x420 (and $x301 $x348 $x350 $x413 $x415 (<= ?x418 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x428 (ite $x420 (ite (or $x421 (<= ?x423 1)) (ite $x421 0 ?x423) 1) v_0_rx_slot_03)))
 (let (($x432 (or (= ?x428 0) $x431)))
 (let (($x411 (and $x353 (>= 2 ?x355))))
 (let ((?x398 (mod (+ 2 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x403 (+ input_0_net.fin_segment_data (* ?x278 ?x398))))
 (let (($x401 (<= input_0_net.fin_segment_data ?x398)))
 (let (($x395 (<= v_0_rcv_buf 13)))
 (let (($x393 (= 0 v_0_rx_slot_02)))
 (let (($x400 (and $x301 $x348 $x350 $x393 $x395 (<= ?x398 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x408 (ite $x400 (ite (or $x401 (<= ?x403 1)) (ite $x401 0 ?x403) 1) v_0_rx_slot_02)))
 (let (($x412 (or (= ?x408 0) $x411)))
 (let (($x391 (and $x353 (>= 1 ?x355))))
 (let ((?x378 (mod (+ 1 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x383 (+ input_0_net.fin_segment_data (* ?x278 ?x378))))
 (let (($x381 (<= input_0_net.fin_segment_data ?x378)))
 (let (($x376 (<= v_0_rcv_buf 14)))
 (let (($x374 (= 0 v_0_rx_slot_01)))
 (let (($x380 (and $x301 $x348 $x350 $x374 $x376 (<= ?x378 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x388 (ite $x380 (ite (or $x381 (<= ?x383 1)) (ite $x381 0 ?x383) 1) v_0_rx_slot_01)))
 (let (($x389 (= ?x388 0)))
 (let (($x392 (or $x389 $x391)))
 (let ((?x671 (ite $x392 1 (ite $x412 2 (ite $x432 3 ?x668)))))
 (let (($x372 (and $x353 (>= 0 ?x355))))
 (let ((?x281 (mod (+ v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x364 (+ input_0_net.fin_segment_data (* ?x278 ?x281))))
 (let (($x362 (<= input_0_net.fin_segment_data ?x281)))
 (let (($x358 (<= v_0_rcv_buf 15)))
 (let (($x356 (= 0 v_0_rx_slot_00)))
 (let (($x361 (and $x301 $x348 $x350 $x356 $x358 (<= ?x281 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x369 (ite $x361 (ite (or $x362 (<= ?x364 1)) (ite $x362 0 ?x364) 1) v_0_rx_slot_00)))
 (let (($x373 (or (= ?x369 0) $x372)))
 (let ((?x672 (ite $x373 0 ?x671)))
 (let ((?x675 (ite $x353 (+ ?x355 (* ?x278 ?x672)) ?x355)))
 (let (($x676 (= 0 ?x675)))
 (let (($x679 (and $x353 $x350 $x676 $x301 $x335 $x338 v_0_fin_sent $x339)))
 (let (($x1589 (= due_1_user due_0_user)))
 (let ((?x1581 (ite (<= (- 999.0) ?x776) 1000 ?x781)))
 (let (($x1556 (and (not (and $x301 $x335 $x338 (= 0 (+ ?x814 (ite $x1111 1 0))))) active_0_rtx)))
 (let (($x1552 (and $x301 $x335 $x338 (<= 1 (+ ?x814 (ite $x1111 1 0))))))
 (let (($x680 (not $x679)))
 (let (($x1161 (and $x1153 $x1154 $x1156 $x1157 $x1160)))
 (let (($x1162 (not $x1161)))
 (let (($x1558 (and $x1162 $x680 (or $x1552 $x1556))))
 (let (($x1561 (and v_0_persist_active $x1162 (<= 1 ?x814) (not $x1558))))
 (let ((?x1586 (ite (or $x1552 $x1561) (+ now_1 (ite $x728 (ite (<= 60000 ?x1581) 60000 ?x1581) v_0_rto_ms)) due_0_rtx)))
 (let (($x1575 (= active_1_persist (and $x1153 $x1154 $x1156 $x1157 $x1160 (or active_0_persist $x1508)))))
 (let (($x1571 (not active_1_delack)))
 (let (($x1547 (= v_1_persist_elapsed_ms v_0_persist_elapsed_ms)))
 (let (($x1540 (= v_1_persist_deadline_ms (ite $x1161 (ite $x1508 ?x1536 v_0_persist_deadline_ms) 0))))
 (let (($x1530 (= v_1_persist_since_ms (ite $x1161 (ite $x1508 now_1 v_0_persist_since_ms) 0))))
 (let (($x1525 (= v_1_persist_previous_interval_ms v_0_persist_previous_interval_ms)))
 (let (($x1517 (not v_1_persist_probe_new)))
 (let (($x1515 (not v_1_persist_probe_sent)))
 (let (($x1513 (not v_1_persist_first)))
 (let (($x1511 (= v_1_persist_was_active v_0_persist_active)))
 (let (($x1501 (not v_1_ack_defer_now)))
 (let (($x1499 (not v_1_ack_defer_candidate)))
 (let (($x1497 (= v_1_ack_rmss v_0_ack_rmss)))
 (let (($x1494 (= v_1_ack_delay_ms v_0_ack_delay_ms)))
 (let (($x1491 (= v_1_ack_full_segments 0)))
 (let (($x1489 (= v_1_ack_bytes 0)))
 (let (($x1487 (= v_1_ack_since_ms 0)))
 (let (($x1485 (not v_1_ack_pending)))
 (let (($x1483 (not v_1_syn_timeout_eligible)))
 (let (($x1481 (not v_1_tx_syn_pending)))
 (let (($x1479 (= v_1_tx_syn_time 0)))
 (let (($x1477 (not v_1_tx_waiting)))
 (let (($x1475 (= v_1_tx_is_fin v_0_tx_is_fin)))
 (let (($x1472 (= v_1_tx_previous_rto v_0_tx_previous_rto)))
 (let (($x1469 (= v_1_tx_elapsed v_0_tx_elapsed)))
 (let (($x1466 (not v_1_tx_retransmitted)))
 (let (($x1464 (= v_1_tx_max_previous v_0_tx_max_previous)))
 (let (($x1461 (= v_1_tx_eligible v_0_tx_eligible)))
 (let (($x1458 (= v_1_tx_emit_count v_0_tx_emit_count)))
 (let ((?x1450 (ite (or $x1159 (and $x301 $x335 $x338 (not (= 0 ?x305))) (>= 15 ?x814)) 0 v_0_tx_time_15)))
 (let (($x1209 (and $x301 $x335 $x338 (not (= 0 ?x305)))))
 (let ((?x1445 (ite (or $x1159 (>= 14 ?x814)) 0 (ite $x1209 (ite (= 1 ?x305) v_0_tx_time_15 0) v_0_tx_time_14))))
 (let (($x1210 (= 1 ?x305)))
 (let ((?x1437 (ite $x1209 (ite $x1210 v_0_tx_time_14 (ite (= 2 ?x305) v_0_tx_time_15 0)) v_0_tx_time_13)))
 (let (($x1212 (= 2 ?x305)))
 (let ((?x1428 (ite $x1210 v_0_tx_time_13 (ite $x1212 v_0_tx_time_14 (ite (= 3 ?x305) v_0_tx_time_15 0)))))
 (let (($x1431 (= v_1_tx_time_12 (ite (or $x1159 (>= 12 ?x814)) 0 (ite $x1209 ?x1428 v_0_tx_time_12)))))
 (let (($x1214 (= 3 ?x305)))
 (let ((?x1418 (ite $x1212 v_0_tx_time_13 (ite $x1214 v_0_tx_time_14 (ite (= 4 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1421 (ite (or (>= 11 ?x814) $x1159) 0 (ite $x1209 (ite $x1210 v_0_tx_time_12 ?x1418) v_0_tx_time_11))))
 (let (($x1216 (= 4 ?x305)))
 (let ((?x1407 (ite $x1214 v_0_tx_time_13 (ite $x1216 v_0_tx_time_14 (ite (= 5 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1410 (ite $x1209 (ite $x1210 v_0_tx_time_11 (ite $x1212 v_0_tx_time_12 ?x1407)) v_0_tx_time_10)))
 (let (($x1218 (= 5 ?x305)))
 (let ((?x1395 (ite $x1216 v_0_tx_time_13 (ite $x1218 v_0_tx_time_14 (ite (= 6 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1398 (ite $x1210 v_0_tx_time_10 (ite $x1212 v_0_tx_time_11 (ite $x1214 v_0_tx_time_12 ?x1395)))))
 (let (($x1401 (= v_1_tx_time_09 (ite (or $x1159 (>= 9 ?x814)) 0 (ite $x1209 ?x1398 v_0_tx_time_09)))))
 (let (($x1220 (= 6 ?x305)))
 (let ((?x1382 (ite $x1218 v_0_tx_time_13 (ite $x1220 v_0_tx_time_14 (ite (= 7 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1385 (ite $x1212 v_0_tx_time_10 (ite $x1214 v_0_tx_time_11 (ite $x1216 v_0_tx_time_12 ?x1382)))))
 (let ((?x1388 (ite (or $x1159 (>= 8 ?x814)) 0 (ite $x1209 (ite $x1210 v_0_tx_time_09 ?x1385) v_0_tx_time_08))))
 (let (($x1222 (= 7 ?x305)))
 (let ((?x1368 (ite $x1220 v_0_tx_time_13 (ite $x1222 v_0_tx_time_14 (ite (= 8 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1371 (ite $x1214 v_0_tx_time_10 (ite $x1216 v_0_tx_time_11 (ite $x1218 v_0_tx_time_12 ?x1368)))))
 (let ((?x1374 (ite $x1209 (ite $x1210 v_0_tx_time_08 (ite $x1212 v_0_tx_time_09 ?x1371)) v_0_tx_time_07)))
 (let (($x1224 (= 8 ?x305)))
 (let ((?x1353 (ite $x1222 v_0_tx_time_13 (ite $x1224 v_0_tx_time_14 (ite (= 9 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1356 (ite $x1216 v_0_tx_time_10 (ite $x1218 v_0_tx_time_11 (ite $x1220 v_0_tx_time_12 ?x1353)))))
 (let ((?x1359 (ite $x1210 v_0_tx_time_07 (ite $x1212 v_0_tx_time_08 (ite $x1214 v_0_tx_time_09 ?x1356)))))
 (let (($x1362 (= v_1_tx_time_06 (ite (or $x1159 (>= 6 ?x814)) 0 (ite $x1209 ?x1359 v_0_tx_time_06)))))
 (let (($x1226 (= 9 ?x305)))
 (let ((?x1337 (ite $x1224 v_0_tx_time_13 (ite $x1226 v_0_tx_time_14 (ite (= 10 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1340 (ite $x1218 v_0_tx_time_10 (ite $x1220 v_0_tx_time_11 (ite $x1222 v_0_tx_time_12 ?x1337)))))
 (let ((?x1343 (ite $x1212 v_0_tx_time_07 (ite $x1214 v_0_tx_time_08 (ite $x1216 v_0_tx_time_09 ?x1340)))))
 (let ((?x1346 (ite (or $x1159 (>= 5 ?x814)) 0 (ite $x1209 (ite $x1210 v_0_tx_time_06 ?x1343) v_0_tx_time_05))))
 (let (($x1228 (= 10 ?x305)))
 (let ((?x1320 (ite $x1226 v_0_tx_time_13 (ite $x1228 v_0_tx_time_14 (ite (= 11 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1323 (ite $x1220 v_0_tx_time_10 (ite $x1222 v_0_tx_time_11 (ite $x1224 v_0_tx_time_12 ?x1320)))))
 (let ((?x1326 (ite $x1214 v_0_tx_time_07 (ite $x1216 v_0_tx_time_08 (ite $x1218 v_0_tx_time_09 ?x1323)))))
 (let ((?x1329 (ite $x1209 (ite $x1210 v_0_tx_time_05 (ite $x1212 v_0_tx_time_06 ?x1326)) v_0_tx_time_04)))
 (let (($x1230 (= 11 ?x305)))
 (let ((?x1302 (ite $x1228 v_0_tx_time_13 (ite $x1230 v_0_tx_time_14 (ite (= 12 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1305 (ite $x1222 v_0_tx_time_10 (ite $x1224 v_0_tx_time_11 (ite $x1226 v_0_tx_time_12 ?x1302)))))
 (let ((?x1308 (ite $x1216 v_0_tx_time_07 (ite $x1218 v_0_tx_time_08 (ite $x1220 v_0_tx_time_09 ?x1305)))))
 (let ((?x1311 (ite $x1210 v_0_tx_time_04 (ite $x1212 v_0_tx_time_05 (ite $x1214 v_0_tx_time_06 ?x1308)))))
 (let (($x1314 (= v_1_tx_time_03 (ite (or $x1159 (>= 3 ?x814)) 0 (ite $x1209 ?x1311 v_0_tx_time_03)))))
 (let (($x1232 (= 12 ?x305)))
 (let ((?x1283 (ite $x1230 v_0_tx_time_13 (ite $x1232 v_0_tx_time_14 (ite (= 13 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1286 (ite $x1224 v_0_tx_time_10 (ite $x1226 v_0_tx_time_11 (ite $x1228 v_0_tx_time_12 ?x1283)))))
 (let ((?x1289 (ite $x1218 v_0_tx_time_07 (ite $x1220 v_0_tx_time_08 (ite $x1222 v_0_tx_time_09 ?x1286)))))
 (let ((?x1292 (ite $x1212 v_0_tx_time_04 (ite $x1214 v_0_tx_time_05 (ite $x1216 v_0_tx_time_06 ?x1289)))))
 (let ((?x1295 (ite (or $x1159 (>= 2 ?x814)) 0 (ite $x1209 (ite $x1210 v_0_tx_time_03 ?x1292) v_0_tx_time_02))))
 (let (($x1234 (= 13 ?x305)))
 (let ((?x1263 (ite $x1232 v_0_tx_time_13 (ite $x1234 v_0_tx_time_14 (ite (= 14 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1266 (ite $x1226 v_0_tx_time_10 (ite $x1228 v_0_tx_time_11 (ite $x1230 v_0_tx_time_12 ?x1263)))))
 (let ((?x1269 (ite $x1220 v_0_tx_time_07 (ite $x1222 v_0_tx_time_08 (ite $x1224 v_0_tx_time_09 ?x1266)))))
 (let ((?x1272 (ite $x1214 v_0_tx_time_04 (ite $x1216 v_0_tx_time_05 (ite $x1218 v_0_tx_time_06 ?x1269)))))
 (let ((?x1275 (ite $x1209 (ite $x1210 v_0_tx_time_02 (ite $x1212 v_0_tx_time_03 ?x1272)) v_0_tx_time_01)))
 (let (($x1236 (= 14 ?x305)))
 (let ((?x1242 (ite $x1234 v_0_tx_time_13 (ite $x1236 v_0_tx_time_14 (ite (= 15 ?x305) v_0_tx_time_15 0)))))
 (let ((?x1245 (ite $x1228 v_0_tx_time_10 (ite $x1230 v_0_tx_time_11 (ite $x1232 v_0_tx_time_12 ?x1242)))))
 (let ((?x1248 (ite $x1222 v_0_tx_time_07 (ite $x1224 v_0_tx_time_08 (ite $x1226 v_0_tx_time_09 ?x1245)))))
 (let ((?x1251 (ite $x1216 v_0_tx_time_04 (ite $x1218 v_0_tx_time_05 (ite $x1220 v_0_tx_time_06 ?x1248)))))
 (let ((?x1254 (ite $x1210 v_0_tx_time_01 (ite $x1212 v_0_tx_time_02 (ite $x1214 v_0_tx_time_03 ?x1251)))))
 (let (($x1258 (= v_1_tx_time_00 (ite (or $x1159 (>= 0 ?x814)) 0 (ite $x1209 ?x1254 v_0_tx_time_00)))))
 (let (($x1193 (= v_1_rtt_sample_was_ambiguous (and v_0_rtt_active v_0_rtt_ambiguous))))
 (let (($x1188 (not v_1_rtt_start_new)))
 (let ((?x807 (* ?x278 ?x305)))
 (let ((?x1180 (+ ?x724 ?x807)))
 (let (($x1183 (and v_0_rtt_active $x301 $x335 $x338 (not (<= v_0_rtt_remaining ?x1180)))))
 (let ((?x1185 (ite (or $x1161 (and v_0_rtt_active $x301 $x335 $x338 $x725)) 0 (ite $x1183 ?x1180 v_0_rtt_remaining))))
 (let (($x1176 (= v_1_rtt_end v_0_rtt_end)))
 (let (($x1175 (= v_1_rtt_start_ms v_0_rtt_start_ms)))
 (let (($x1163 (and v_0_rtt_active $x301 $x335 $x338 $x725)))
 (let (($x1164 (not $x1163)))
 (let (($x1151 (= v_1_rtt_previous_measured (ite $x728 v_0_rtt_measured v_0_rtt_previous_measured))))
 (let (($x1144 (= v_1_rtt_previous_var (ite $x728 v_0_rttvar_ms v_0_rtt_previous_var))))
 (let (($x1140 (= v_1_rtt_previous_srtt (ite $x728 v_0_srtt_ms v_0_rtt_previous_srtt))))
 (let ((?x1120 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data) 4294967296)))
 (let (($x1113 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x1109 (= v_1_fin_requested v_0_fin_requested)))
 (let ((?x1087 (ite (or (and $x353 $x350 $x676) (not (and $x373 (not $x655)))) 0 ?x652)))
 (let (($x903 (not $x655)))
 (let (($x707 (not $x373)))
 (let (($x872 (not $x412)))
 (let (($x870 (not $x432)))
 (let (($x868 (not $x452)))
 (let (($x866 (not $x472)))
 (let (($x864 (not $x492)))
 (let (($x862 (not $x512)))
 (let (($x860 (not $x530)))
 (let (($x858 (not $x548)))
 (let (($x856 (not $x566)))
 (let (($x854 (not $x584)))
 (let (($x852 (not $x602)))
 (let (($x850 (not $x620)))
 (let (($x848 (not $x638)))
 (let (($x847 (and false $x656)))
 (let (($x849 (and $x847 $x848)))
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
 (let (($x874 (or $x391 (and $x871 $x872) $x389)))
 (let ((?x701 (ite $x637 0 ?x634)))
 (let (($x677 (and $x353 $x350 $x676)))
 (let (($x1083 (= v_1_rx_slot_14 (ite $x677 0 (ite $x373 ?x701 (ite (and $x874 $x707 $x903) ?x652 0))))))
 (let (($x875 (and $x874 $x707)))
 (let ((?x1075 (ite $x875 ?x701 (ite (and (or $x871 $x412) (not $x392) $x707 $x903) ?x652 0))))
 (let ((?x700 (ite $x619 0 ?x616)))
 (let (($x877 (not $x392)))
 (let (($x876 (or $x871 $x412)))
 (let (($x878 (and $x876 $x877 $x707)))
 (let ((?x1068 (ite $x878 ?x701 (ite (and (or $x869 $x432) $x872 $x877 $x707 $x903) ?x652 0))))
 (let ((?x699 (ite $x601 0 ?x598)))
 (let (($x1072 (= v_1_rx_slot_12 (ite $x677 0 (ite $x373 ?x699 (ite $x875 ?x700 ?x1068))))))
 (let (($x879 (or $x869 $x432)))
 (let (($x880 (and $x879 $x872 $x877 $x707)))
 (let ((?x1060 (ite $x880 ?x701 (ite (and (or $x867 $x452) $x870 $x872 $x877 $x707 $x903) ?x652 0))))
 (let ((?x698 (ite $x583 0 ?x580)))
 (let (($x1065 (= v_1_rx_slot_11 (ite $x677 0 (ite $x373 ?x698 (ite $x875 ?x699 (ite $x878 ?x700 ?x1060)))))))
 (let (($x881 (or $x867 $x452)))
 (let (($x882 (and $x881 $x870 $x872 $x877 $x707)))
 (let ((?x1051 (ite $x882 ?x701 (ite (and (or $x865 $x472) $x868 $x870 $x872 $x877 $x707 $x903) ?x652 0))))
 (let ((?x697 (ite $x565 0 ?x562)))
 (let ((?x1056 (ite $x677 0 (ite $x373 ?x697 (ite $x875 ?x698 (ite $x878 ?x699 (ite $x880 ?x700 ?x1051)))))))
 (let ((?x1040 (ite (and (or $x863 $x492) $x866 $x868 $x870 $x872 $x877 $x707 $x903) ?x652 0)))
 (let (($x883 (or $x865 $x472)))
 (let (($x884 (and $x883 $x868 $x870 $x872 $x877 $x707)))
 (let ((?x1045 (ite $x875 ?x697 (ite $x878 ?x698 (ite $x880 ?x699 (ite $x882 ?x700 (ite $x884 ?x701 ?x1040)))))))
 (let ((?x696 (ite $x547 0 ?x544)))
 (let ((?x1029 (ite (and (or $x861 $x512) $x864 $x866 $x868 $x870 $x872 $x877 $x707 $x903) ?x652 0)))
 (let (($x885 (or $x863 $x492)))
 (let (($x886 (and $x885 $x866 $x868 $x870 $x872 $x877 $x707)))
 (let ((?x1034 (ite $x878 ?x697 (ite $x880 ?x698 (ite $x882 ?x699 (ite $x884 ?x700 (ite $x886 ?x701 ?x1029)))))))
 (let ((?x695 (ite $x529 0 ?x526)))
 (let (($x1038 (= v_1_rx_slot_08 (ite $x677 0 (ite $x373 ?x695 (ite $x875 ?x696 ?x1034))))))
 (let ((?x1017 (ite (and (or $x859 $x530) $x862 $x864 $x866 $x868 $x870 $x872 $x877 $x707 $x903) ?x652 0)))
 (let (($x887 (or $x861 $x512)))
 (let (($x888 (and $x887 $x864 $x866 $x868 $x870 $x872 $x877 $x707)))
 (let ((?x1022 (ite $x880 ?x697 (ite $x882 ?x698 (ite $x884 ?x699 (ite $x886 ?x700 (ite $x888 ?x701 ?x1017)))))))
 (let ((?x694 (ite $x511 0 ?x508)))
 (let (($x1027 (= v_1_rx_slot_07 (ite $x677 0 (ite $x373 ?x694 (ite $x875 ?x695 (ite $x878 ?x696 ?x1022)))))))
 (let (($x891 (or $x857 $x548)))
 (let ((?x1004 (ite (and $x891 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x877 $x707 $x903) ?x652 0)))
 (let (($x889 (or $x859 $x530)))
 (let (($x890 (and $x889 $x862 $x864 $x866 $x868 $x870 $x872 $x877 $x707)))
 (let ((?x1009 (ite $x882 ?x697 (ite $x884 ?x698 (ite $x886 ?x699 (ite $x888 ?x700 (ite $x890 ?x701 ?x1004)))))))
 (let ((?x693 (ite $x491 0 ?x488)))
 (let ((?x1014 (ite $x677 0 (ite $x373 ?x693 (ite $x875 ?x694 (ite $x878 ?x695 (ite $x880 ?x696 ?x1009)))))))
 (let (($x893 (or $x855 $x566)))
 (let ((?x990 (ite (and $x893 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x877 $x707 $x903) ?x652 0)))
 (let (($x892 (and $x891 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x877 $x707)))
 (let ((?x995 (ite $x884 ?x697 (ite $x886 ?x698 (ite $x888 ?x699 (ite $x890 ?x700 (ite $x892 ?x701 ?x990)))))))
 (let ((?x692 (ite $x471 0 ?x468)))
 (let ((?x1000 (ite $x373 ?x692 (ite $x875 ?x693 (ite $x878 ?x694 (ite $x880 ?x695 (ite $x882 ?x696 ?x995)))))))
 (let (($x895 (or $x853 $x584)))
 (let (($x974 (and $x895 $x856 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x877 $x707 $x903)))
 (let (($x894 (and $x893 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x877 $x707)))
 (let ((?x979 (ite $x888 ?x698 (ite $x890 ?x699 (ite $x892 ?x700 (ite $x894 ?x701 (ite $x974 ?x652 0)))))))
 (let ((?x984 (ite $x878 ?x693 (ite $x880 ?x694 (ite $x882 ?x695 (ite $x884 ?x696 (ite $x886 ?x697 ?x979)))))))
 (let ((?x691 (ite $x451 0 ?x448)))
 (let (($x988 (= v_1_rx_slot_04 (ite $x677 0 (ite $x373 ?x691 (ite $x875 ?x692 ?x984))))))
 (let (($x897 (or $x851 $x602)))
 (let (($x958 (and $x897 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x877 $x707 $x903)))
 (let (($x896 (and $x895 $x856 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x877 $x707)))
 (let ((?x963 (ite $x890 ?x698 (ite $x892 ?x699 (ite $x894 ?x700 (ite $x896 ?x701 (ite $x958 ?x652 0)))))))
 (let ((?x968 (ite $x880 ?x693 (ite $x882 ?x694 (ite $x884 ?x695 (ite $x886 ?x696 (ite $x888 ?x697 ?x963)))))))
 (let ((?x690 (ite $x431 0 ?x428)))
 (let (($x973 (= v_1_rx_slot_03 (ite $x677 0 (ite $x373 ?x690 (ite $x875 ?x691 (ite $x878 ?x692 ?x968)))))))
 (let (($x899 (or $x849 $x620)))
 (let (($x941 (and $x899 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x877 $x707 $x903)))
 (let (($x898 (and $x897 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x877 $x707)))
 (let ((?x946 (ite $x892 ?x698 (ite $x894 ?x699 (ite $x896 ?x700 (ite $x898 ?x701 (ite $x941 ?x652 0)))))))
 (let ((?x951 (ite $x882 ?x693 (ite $x884 ?x694 (ite $x886 ?x695 (ite $x888 ?x696 (ite $x890 ?x697 ?x946)))))))
 (let ((?x689 (ite $x411 0 ?x408)))
 (let ((?x956 (ite $x677 0 (ite $x373 ?x689 (ite $x875 ?x690 (ite $x878 ?x691 (ite $x880 ?x692 ?x951)))))))
 (let (($x901 (or $x847 $x638)))
 (let (($x923 (and $x901 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x877 $x707 $x903)))
 (let (($x900 (and $x899 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x877 $x707)))
 (let ((?x928 (ite $x894 ?x698 (ite $x896 ?x699 (ite $x898 ?x700 (ite $x900 ?x701 (ite $x923 ?x652 0)))))))
 (let ((?x933 (ite $x884 ?x693 (ite $x886 ?x694 (ite $x888 ?x695 (ite $x890 ?x696 (ite $x892 ?x697 ?x928)))))))
 (let ((?x688 (ite $x391 0 ?x388)))
 (let ((?x938 (ite $x373 ?x688 (ite $x875 ?x689 (ite $x878 ?x690 (ite $x880 ?x691 (ite $x882 ?x692 ?x933)))))))
 (let (($x904 (and $x656 $x848 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x877 $x707 $x903)))
 (let (($x902 (and $x901 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x868 $x870 $x872 $x877 $x707)))
 (let ((?x909 (ite $x896 ?x698 (ite $x898 ?x699 (ite $x900 ?x700 (ite $x902 ?x701 (ite $x904 ?x652 0)))))))
 (let ((?x914 (ite $x886 ?x693 (ite $x888 ?x694 (ite $x890 ?x695 (ite $x892 ?x696 (ite $x894 ?x697 ?x909)))))))
 (let ((?x919 (ite $x875 ?x688 (ite $x878 ?x689 (ite $x880 ?x690 (ite $x882 ?x691 (ite $x884 ?x692 ?x914)))))))
 (let ((?x687 (ite $x372 0 ?x369)))
 (let ((?x709 (ite (and (<= 0 ?x672) $x707) ?x671 0)))
 (let ((?x703 (+ ?x687 ?x688 ?x689 ?x690 ?x691 ?x692 ?x693 ?x694 ?x695 ?x696 ?x697 ?x698 ?x699 ?x700 ?x701 (ite $x655 0 ?x652))))
 (let ((?x705 (ite (<= ?x703 0) 0 ?x703)))
 (let ((?x711 (ite (<= ?x705 ?x709) ?x705 ?x709)))
 (let (($x845 (= v_1_take v_0_take)))
 (let (($x805 (= v_1_snd_buf v_0_snd_buf)))
 (let (($x799 (= v_1_msl_ms v_0_msl_ms)))
 (let (($x796 (= v_1_user_timeout_ms v_0_user_timeout_ms)))
 (let (($x793 (= v_1_active_open v_0_active_open)))
 (let (($x790 (= v_1_retries v_0_retries)))
 (let (($x720 (= v_1_tx_flags v_0_tx_flags)))
 (let (($x717 (= v_1_tx_ack v_0_tx_ack)))
 (let (($x716 (= v_1_tx_seq v_0_tx_seq)))
 (let (($x715 (= v_1_rcv_nxt (mod (+ v_0_rcv_nxt ?x711 (ite $x677 1 0)) 4294967296))))
 (let (($x686 (= v_1_snd_nxt v_0_snd_nxt)))
 (let (($x682 (= v_1_irs v_0_irs)))
 (let (($x681 (= v_1_iss v_0_iss)))
 (let (($x678 (not $x677)))
 (let (($x319 (= 0 ?x305)))
 (let (($x311 (= (mod (+ input_0_net.fin_segment_ack (* ?x278 v_0_snd_nxt)) 4294967296) 2147483648)))
 (and (>= now_1 now_0) (<= 0 input_0_net.fin_segment_data) (>= 16 input_0_net.fin_segment_data) (not (= ?x281 2147483648)) (<= 0 input_0_net.fin_segment_window) (>= 65535 input_0_net.fin_segment_window) (or (not $x301) (and (not (= ?x305 2147483648)) (not $x311))) v_0_fin_sent (not (= ?x305 (+ 1 v_0_rtx_buf))) $x319 (or (not active_0_rtx) (not (<= due_0_rtx now_1))) (or (not active_0_user) (not (<= due_0_user now_1))) (or (not active_0_time_wait) (not (<= due_0_time_wait now_1))) (or (not active_0_delack) (not (<= due_0_delack now_1))) (or (not active_0_persist) (not (<= due_0_persist now_1))) $x341 $x678 $x680 $x681 $x682 (= v_1_snd_una (ite $x683 input_0_net.fin_segment_ack v_0_snd_una)) $x686 $x715 $x716 $x717 $x720 (= v_1_rto_ms ?x786) $x790 $x793 $x796 $x799 (= v_1_local_window (+ 16 (* ?x278 v_0_rcv_buf) (* ?x278 ?x711))) $x805 (= v_1_rtx_buf ?x814) (= v_1_rcv_buf (+ v_0_rcv_buf ?x711)) (= v_1_snd_wnd ?x837) (= v_1_snd_wl1 (ite $x835 input_0_net.fin_segment_seq v_0_snd_wl1)) (= v_1_snd_wl2 (ite $x835 input_0_net.fin_segment_ack v_0_snd_wl2)) $x845 (= v_1_rx_chunk ?x711) (= v_1_rx_slot_00 (ite $x677 0 (ite $x373 ?x687 ?x919))) (= v_1_rx_slot_01 (ite $x677 0 ?x938)) (= v_1_rx_slot_02 ?x956) $x973 $x988 (= v_1_rx_slot_05 (ite $x677 0 ?x1000)) (= v_1_rx_slot_06 ?x1014) $x1027 $x1038 (= v_1_rx_slot_09 (ite $x677 0 (ite $x373 ?x696 ?x1045))) (= v_1_rx_slot_10 ?x1056) $x1065 $x1072 (= v_1_rx_slot_13 (ite $x677 0 (ite $x373 ?x700 ?x1075))) $x1083 (= v_1_rx_slot_15 ?x1087) (= v_1_rx_advance ?x672) (= v_1_rx_acceptable (and $x301 $x348 $x350)) (= v_1_seg_acceptable $x301) (= v_1_ack_delta ?x305) (= v_1_ack_is_new (and $x335 $x338)) (= v_1_ack_is_future $x347) (= v_1_ack_advance $x683) (= v_1_ack_window_update $x835) $x1109 (= v_1_fin_sent $x1111) $x1113 (= v_1_fin_acknowledged $x340) (= v_1_rx_fin_pending (and $x353 $x678)) (= v_1_rx_fin_seq (ite $x352 ?x1120 v_0_rx_fin_seq)) (= v_1_rx_fin_offset (ite $x677 0 ?x675)) (= v_1_rx_fin_done (or v_0_rx_fin_done $x677)) (= v_1_rx_fin_consumed $x677) (= v_1_srtt_ms ?x748) (= v_1_rttvar_ms ?x771) (= v_1_rtt_error_ms ?x764) $x1140 $x1144 (= v_1_rtt_measured (or v_0_rtt_measured $x728)) $x1151 (= v_1_rtt_active (and $x1162 v_0_rtt_active $x1164)) (= v_1_rtt_ambiguous (and $x1162 $x1164 v_0_rtt_ambiguous)) (= v_1_rtt_sample_at_ms (ite $x728 now_1 v_0_rtt_sample_at_ms)) $x1175 $x1176 (= v_1_rtt_remaining ?x1185) $x1188 (= v_1_rtt_sample_used $x728) $x1193 (= v_1_rtt_last_ms ?x743) (= v_1_rtt_samples (+ v_0_rtt_samples (ite $x728 1 0))) (= v_1_rto_base_ms (ite $x728 ?x784 v_0_rto_base_ms)) $x1258 (= v_1_tx_time_01 (ite (or $x1159 $x1157) 0 ?x1275)) (= v_1_tx_time_02 ?x1295) $x1314 (= v_1_tx_time_04 (ite (or $x1159 (>= 4 ?x814)) 0 ?x1329)) (= v_1_tx_time_05 ?x1346) $x1362 (= v_1_tx_time_07 (ite (or $x1159 (>= 7 ?x814)) 0 ?x1374)) (= v_1_tx_time_08 ?x1388) $x1401 (= v_1_tx_time_10 (ite (or $x1159 (>= 10 ?x814)) 0 ?x1410)) (= v_1_tx_time_11 ?x1421) $x1431 (= v_1_tx_time_13 (ite (or $x1159 (>= 13 ?x814)) 0 ?x1437)) (= v_1_tx_time_14 ?x1445) (= v_1_tx_time_15 ?x1450) (= v_1_tx_fin_time (ite $x1111 v_0_tx_fin_time 0)) $x1458 $x1461 $x1464 $x1466 $x1469 $x1472 $x1475 $x1477 $x1479 $x1481 $x1483 $x1485 $x1487 $x1489 $x1491 $x1494 $x1497 $x1499 $x1501 (= v_1_persist_active $x1161) (= v_1_persist_eligible $x1161) (= v_1_persist_start $x1508) $x1511 $x1513 $x1515 $x1517 (= v_1_persist_interval_ms (ite $x1161 ?x1520 1000)) $x1525 $x1530 (= v_1_persist_last_ms (ite $x1161 v_0_persist_last_ms 0)) $x1540 (= v_1_persist_probes (ite $x1161 v_0_persist_probes 0)) $x1547 (= active_1_rtx (or $x1558 $x1561)) (= active_1_user (and $x680 active_0_user)) (= active_1_time_wait (or active_0_time_wait $x679)) $x1571 $x1575 (= due_1_rtx ?x1586) $x1589 (= due_1_time_wait (ite $x679 ?x1592 due_0_time_wait)) $x1596 (= due_1_persist (ite $x1508 ?x1536 due_0_persist)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
 (let ((?x1605 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1605)))
(assert
 (>= 16 v_0_rcv_buf))
(assert
 (and (<= 0 v_0_snd_wnd) (>= 65535 v_0_snd_wnd)))
(assert
 (= v_0_local_window (+ 16 (* (- 1) v_0_rcv_buf))))
(assert
 (>= 1 v_0_rx_slot_00))
(assert
 (let (($x356 (= 0 v_0_rx_slot_00)))
 (let (($x1615 (not (>= v_0_rcv_buf 16))))
 (or $x1615 $x356))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x374 (= 0 v_0_rx_slot_01)))
 (let (($x1619 (not (>= v_0_rcv_buf 15))))
 (or $x1619 $x374))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x393 (= 0 v_0_rx_slot_02)))
 (let (($x1623 (not (>= v_0_rcv_buf 14))))
 (or $x1623 $x393))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x413 (= 0 v_0_rx_slot_03)))
 (let (($x1627 (not (>= v_0_rcv_buf 13))))
 (or $x1627 $x413))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x433 (= 0 v_0_rx_slot_04)))
 (let (($x1631 (not (>= v_0_rcv_buf 12))))
 (or $x1631 $x433))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x453 (= 0 v_0_rx_slot_05)))
 (let (($x1635 (not (>= v_0_rcv_buf 11))))
 (or $x1635 $x453))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x473 (= 0 v_0_rx_slot_06)))
 (let (($x1639 (not (>= v_0_rcv_buf 10))))
 (or $x1639 $x473))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x493 (= 0 v_0_rx_slot_07)))
 (let (($x1643 (not (>= v_0_rcv_buf 9))))
 (or $x1643 $x493))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x513 (= 0 v_0_rx_slot_08)))
 (let (($x1647 (not (>= v_0_rcv_buf 8))))
 (or $x1647 $x513))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x531 (= 0 v_0_rx_slot_09)))
 (let (($x1651 (not (>= v_0_rcv_buf 7))))
 (or $x1651 $x531))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x549 (= 0 v_0_rx_slot_10)))
 (let (($x1655 (not (>= v_0_rcv_buf 6))))
 (or $x1655 $x549))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x567 (= 0 v_0_rx_slot_11)))
 (let (($x1659 (not (>= v_0_rcv_buf 5))))
 (or $x1659 $x567))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x585 (= 0 v_0_rx_slot_12)))
 (let (($x1663 (not (>= v_0_rcv_buf 4))))
 (or $x1663 $x585))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x603 (= 0 v_0_rx_slot_13)))
 (let (($x1667 (not (>= v_0_rcv_buf 3))))
 (or $x1667 $x603))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x621 (= 0 v_0_rx_slot_14)))
 (let (($x1671 (not (>= v_0_rcv_buf 2))))
 (or $x1671 $x621))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x639 (= 0 v_0_rx_slot_15)))
 (let (($x1675 (not (>= v_0_rcv_buf 1))))
 (or $x1675 $x639))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x1677 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x1677)))
(assert
 (and (<= 0 v_0_rx_advance) (>= 16 v_0_rx_advance)))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (and (<= 0 v_0_ack_delta) (>= 4294967295 v_0_ack_delta)))
(assert
 true)
(assert
 (let ((?x1690 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x1690)))
(assert
 (let (($x1697 (and v_0_fin_requested (= v_0_fin_seq (mod (+ v_0_snd_una v_0_rtx_buf) 4294967296)) (= 0 v_0_snd_buf))))
 (let (($x1692 (not v_0_fin_sent)))
 (or $x1692 $x1697))))
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
 (let (($x1699 (<= 1 v_0_rx_fin_offset)))
 (let (($x350 (not v_0_rx_fin_done)))
 (let (($x1701 (and $x350 $x1699 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window)))))
 (let (($x351 (not v_0_rx_fin_pending)))
 (or $x351 $x1701))))))
(assert
 (let (($x1704 (>= 15 v_0_rx_fin_offset)))
 (and (<= 0 v_0_rx_fin_offset) $x1704 (= v_0_rx_fin_pending (<= 1 v_0_rx_fin_offset)))))
(assert
 (let (($x351 (not v_0_rx_fin_pending)))
 (or $x351 (= v_0_rx_fin_seq (mod (+ v_0_rcv_nxt v_0_rx_fin_offset) 4294967296)))))
(assert
 (let (($x350 (not v_0_rx_fin_done)))
 (or $x350 (= v_0_rcv_nxt (mod (+ 1 v_0_rx_fin_seq) 4294967296)))))
(assert
 (let (($x356 (= 0 v_0_rx_slot_00)))
 (or (not (and v_0_rx_fin_pending (>= 0 v_0_rx_fin_offset))) $x356)))
(assert
 (let (($x374 (= 0 v_0_rx_slot_01)))
 (or (not (and v_0_rx_fin_pending (>= 1 v_0_rx_fin_offset))) $x374)))
(assert
 (let (($x393 (= 0 v_0_rx_slot_02)))
 (or (not (and v_0_rx_fin_pending (>= 2 v_0_rx_fin_offset))) $x393)))
(assert
 (let (($x413 (= 0 v_0_rx_slot_03)))
 (or (not (and v_0_rx_fin_pending (>= 3 v_0_rx_fin_offset))) $x413)))
(assert
 (let (($x433 (= 0 v_0_rx_slot_04)))
 (or (not (and v_0_rx_fin_pending (>= 4 v_0_rx_fin_offset))) $x433)))
(assert
 (let (($x453 (= 0 v_0_rx_slot_05)))
 (or (not (and v_0_rx_fin_pending (>= 5 v_0_rx_fin_offset))) $x453)))
(assert
 (let (($x473 (= 0 v_0_rx_slot_06)))
 (or (not (and v_0_rx_fin_pending (>= 6 v_0_rx_fin_offset))) $x473)))
(assert
 (let (($x493 (= 0 v_0_rx_slot_07)))
 (or (not (and v_0_rx_fin_pending (>= 7 v_0_rx_fin_offset))) $x493)))
(assert
 (let (($x513 (= 0 v_0_rx_slot_08)))
 (or (not (and v_0_rx_fin_pending (>= 8 v_0_rx_fin_offset))) $x513)))
(assert
 (let (($x531 (= 0 v_0_rx_slot_09)))
 (or (not (and v_0_rx_fin_pending (>= 9 v_0_rx_fin_offset))) $x531)))
(assert
 (let (($x549 (= 0 v_0_rx_slot_10)))
 (or (not (and v_0_rx_fin_pending (>= 10 v_0_rx_fin_offset))) $x549)))
(assert
 (let (($x567 (= 0 v_0_rx_slot_11)))
 (or (not (and v_0_rx_fin_pending (>= 11 v_0_rx_fin_offset))) $x567)))
(assert
 (let (($x585 (= 0 v_0_rx_slot_12)))
 (or (not (and v_0_rx_fin_pending (>= 12 v_0_rx_fin_offset))) $x585)))
(assert
 (let (($x603 (= 0 v_0_rx_slot_13)))
 (or (not (and v_0_rx_fin_pending (>= 13 v_0_rx_fin_offset))) $x603)))
(assert
 (let (($x621 (= 0 v_0_rx_slot_14)))
 (or (not (and v_0_rx_fin_pending (>= 14 v_0_rx_fin_offset))) $x621)))
(assert
 (let (($x639 (= 0 v_0_rx_slot_15)))
 (or (not (and v_0_rx_fin_pending (>= 15 v_0_rx_fin_offset))) $x639)))
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
 (let ((?x1792 (* 4.0 v_0_rttvar_ms)))
 (let ((?x731 (- 1.0)))
 (let ((?x760 (* ?x731 v_0_srtt_ms)))
 (let ((?x1795 (+ ?x760 (* ?x731 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x1792)))))
 (let ((?x1796 (to_int ?x1795)))
 (let ((?x278 (- 1)))
 (let ((?x1799 (ite (<= ?x1796 (- 1000)) (* ?x278 ?x1796) 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x1799) 60000 ?x1799) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x724 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x1814 (and (<= v_0_rtt_start_ms now_0) (<= 1 v_0_rtt_remaining) (>= 4 v_0_rtt_remaining) (>= ?x724 v_0_rtt_remaining) (<= ?x724 (mod (+ v_0_snd_nxt (* (- 1) v_0_snd_una)) 4294967296)))))
 (let (($x1806 (not v_0_rtt_active)))
 (or $x1806 $x1814)))))
(assert
 (let (($x1816 (= 0 v_0_rtt_remaining)))
 (or v_0_rtt_active $x1816)))
(assert
 true)
(assert
 (let (($x1823 (= v_0_rtt_last_ms (+ v_0_rtt_sample_at_ms (* (- 1) v_0_rtt_start_ms)))))
 (let (($x1821 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1819 (not v_0_rtt_sample_used)))
 (or $x1819 (and $x1821 v_0_rtt_measured $x1823))))))
(assert
 (and (<= 0 v_0_rtt_sample_at_ms) (<= v_0_rtt_sample_at_ms now_0)))
(assert
 (let ((?x1830 (to_real v_0_rtt_last_ms)))
 (let ((?x1844 (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x1830))))
 (let ((?x1832 (+ v_0_rtt_previous_srtt (* (- 1.0) ?x1830))))
 (let ((?x1836 (ite (>= ?x1832 0.0) ?x1832 (+ (* (- 1.0) v_0_rtt_previous_srtt) ?x1830))))
 (let ((?x755 (/ 1.0 4.0)))
 (let ((?x1840 (ite v_0_rtt_previous_measured (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* ?x755 ?x1836)) (* (/ 1.0 2.0) ?x1830))))
 (let (($x1847 (and (= v_0_rttvar_ms ?x1840) (= v_0_srtt_ms (ite v_0_rtt_previous_measured ?x1844 ?x1830)))))
 (let (($x1819 (not v_0_rtt_sample_used)))
 (or $x1819 $x1847))))))))))
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
 (let (($x1983 (and (>= v_0_tx_elapsed v_0_tx_previous_rto) (<= 1 v_0_tx_emit_count) (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x1977 (not v_0_tx_retransmitted)))
 (or $x1977 $x1983))))
(assert
 (let (($x1977 (not v_0_tx_retransmitted)))
 (or $x1977 (not v_0_tx_waiting))))
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
 (let (($x2014 (not v_0_ack_pending)))
 (or $x2014 (and (<= 1 v_0_ack_bytes) (not v_0_rx_fin_done)))))
(assert
 (let (($x2021 (and (= 0 v_0_ack_bytes) (= 0 v_0_ack_full_segments) (= 0 v_0_ack_since_ms))))
 (or v_0_ack_pending $x2021)))
(assert
 (let (($x186 (not active_0_rtx)))
 (let (($x1858 (>= 1 v_0_rtx_buf)))
 (let (($x1692 (not v_0_fin_sent)))
 (let (($x2030 (and (= 0 v_0_snd_wnd) $x1692 (<= 1 (+ v_0_rtx_buf v_0_snd_buf)) $x1858 $x186)))
 (let (($x1507 (not v_0_persist_active)))
 (let (($x2025 (and (<= 1 (+ v_0_rtx_buf (ite v_0_fin_sent 1 0))) $x1507)))
 (let (($x2023 (= v_0_persist_active active_0_persist)))
 (and $x2023 (= active_0_rtx $x2025) (or $x1507 $x2030))))))))))
(assert
 (let (($x1507 (not v_0_persist_active)))
 (or $x1507 (and (not v_0_rtt_active) (= 0 v_0_rtt_remaining)))))
(assert
 (and (<= 1000 v_0_persist_interval_ms) (>= 60000 v_0_persist_interval_ms) (<= 1000 v_0_persist_previous_interval_ms) (>= 60000 v_0_persist_previous_interval_ms) (<= 0 v_0_persist_probes) (<= 0 v_0_persist_elapsed_ms)))
(assert
 (and (<= 0 v_0_persist_since_ms) (<= v_0_persist_since_ms now_0) (<= 0 v_0_persist_last_ms) (<= v_0_persist_last_ms now_0) (<= 0 v_0_persist_deadline_ms)))
(assert
 (let (($x2048 (= 0 v_0_persist_probes)))
 (let ((?x2050 (+ (ite $x2048 v_0_persist_since_ms v_0_persist_last_ms) v_0_persist_interval_ms)))
 (let (($x1507 (not v_0_persist_active)))
 (or $x1507 (= v_0_persist_deadline_ms ?x2050))))))
(assert
 (let (($x2056 (= 1 v_0_rtx_buf)))
 (let (($x2054 (not v_0_persist_probe_sent)))
 (or $x2054 (and (>= v_0_persist_elapsed_ms v_0_persist_previous_interval_ms) $x2056)))))
(assert
 (let (($x2062 (= v_0_tx_time_00 v_0_persist_last_ms)))
 (let (($x2056 (= 1 v_0_rtx_buf)))
 (or (not (and v_0_persist_active (<= 1 v_0_persist_probes) $x2056)) $x2062))))
(assert
 (let (($x2048 (= 0 v_0_persist_probes)))
 (let (($x2067 (and (= 0 v_0_persist_since_ms) (= 0 v_0_persist_last_ms) (= 0 v_0_persist_deadline_ms) $x2048)))
 (or v_0_persist_active $x2067))))
(assert
 (= 177 choice_0))
(assert
 (= 5 state_0))
(assert
 (= 5 state_1))
(assert
 (or (not (or v_1_tx_syn_pending (= 0 v_1_tx_syn_time)))))
(check-sat)
