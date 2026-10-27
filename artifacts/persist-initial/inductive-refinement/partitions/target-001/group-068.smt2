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
(declare-fun input_0_net.data_window () Int)
(declare-fun due_1_persist () Int)
(declare-fun v_0_ack_delay_ms () Int)
(declare-fun v_0_ack_rmss () Int)
(declare-fun v_0_ack_full_segments () Int)
(declare-fun v_0_ack_bytes () Int)
(declare-fun v_0_rx_fin_done () Bool)
(declare-fun v_0_rx_fin_offset () Int)
(declare-fun v_0_rx_fin_pending () Bool)
(declare-fun due_1_delack () Int)
(declare-fun v_0_msl_ms () Int)
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
(declare-fun v_1_ack_rmss () Int)
(declare-fun v_1_ack_delay_ms () Int)
(declare-fun v_1_ack_full_segments () Int)
(declare-fun v_1_ack_bytes () Int)
(declare-fun v_0_ack_since_ms () Int)
(declare-fun v_0_ack_pending () Bool)
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
 (let (($x720 (not v_0_rtt_ambiguous)))
 (let ((?x717 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let ((?x291 (mod (+ input_0_net.data_ack (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x718 (>= ?x291 ?x717)))
 (let ((?x333 (ite v_0_fin_sent 1 0)))
 (let ((?x334 (+ v_0_rtx_buf ?x333)))
 (let (($x335 (<= ?x291 ?x334)))
 (let (($x331 (<= 1 ?x291)))
 (let ((?x278 (- 1)))
 (let ((?x306 (+ ?x278 v_0_local_window)))
 (let (($x301 (<= 1 v_0_local_window)))
 (let (($x312 (and $x301 (<= (mod (+ input_0_net.data_seq (* ?x278 v_0_rcv_nxt)) 4294967296) ?x306))))
 (let ((?x303 (* ?x278 v_0_rcv_nxt)))
 (let (($x307 (<= (mod (+ 4294967295 input_0_net.data_seq input_0_net.data_data ?x303) 4294967296) ?x306)))
 (let (($x313 (or (and $x301 $x307) $x312)))
 (let (($x721 (and v_0_rtt_active $x313 $x331 $x335 $x718 $x720)))
 (let ((?x736 (ite $x721 (+ now_1 (* ?x278 v_0_rtt_start_ms)) v_0_rtt_last_ms)))
 (let ((?x737 (to_real ?x736)))
 (let ((?x761 (/ 1.0 2.0)))
 (let ((?x750 (+ v_0_srtt_ms (* (- 1.0) ?x737))))
 (let ((?x757 (ite $x721 (ite (>= ?x750 0.0) ?x750 (+ (* (- 1.0) v_0_srtt_ms) ?x737)) v_0_rtt_error_ms)))
 (let ((?x748 (/ 1.0 4.0)))
 (let ((?x763 (ite v_0_rtt_measured (+ (* (/ 3.0 4.0) v_0_rttvar_ms) (* ?x748 ?x757)) (* ?x761 ?x737))))
 (let ((?x764 (ite $x721 ?x763 v_0_rttvar_ms)))
 (let ((?x724 (- 1.0)))
 (let ((?x740 (ite v_0_rtt_measured (+ (* (/ 7.0 8.0) v_0_srtt_ms) (* (/ 1.0 8.0) ?x737)) ?x737)))
 (let ((?x741 (ite $x721 ?x740 v_0_srtt_ms)))
 (let ((?x769 (+ (* ?x724 ?x741) (* ?x724 (ite (<= ?x764 ?x748) 1.0 (* 4.0 ?x764))))))
 (let ((?x770 (to_int ?x769)))
 (let ((?x774 (* ?x278 ?x770)))
 (let ((?x775 (ite (<= ?x770 (- 1000)) ?x774 1000)))
 (let ((?x777 (ite (<= 60000 ?x775) 60000 ?x775)))
 (let ((?x779 (ite $x721 ?x777 v_0_rto_ms)))
 (let (($x1528 (not v_0_persist_active)))
 (let ((?x804 (ite (<= 0 v_0_rtx_buf) v_0_rtx_buf 0)))
 (let ((?x802 (ite (<= v_0_rtx_buf ?x291) 0 (+ v_0_rtx_buf (* ?x278 ?x291)))))
 (let (($x676 (and $x313 $x331 $x335)))
 (let ((?x807 (ite $x676 (ite (<= ?x802 ?x804) ?x802 ?x804) v_0_rtx_buf)))
 (let (($x1149 (= 0 ?x807)))
 (let (($x1150 (or v_0_persist_active $x1149)))
 (let (($x1147 (>= 1 ?x807)))
 (let (($x1146 (<= 1 (+ ?x807 v_0_snd_buf))))
 (let (($x336 (= ?x291 ?x334)))
 (let (($x337 (and $x313 $x331 $x335 v_0_fin_sent $x336)))
 (let (($x338 (not $x337)))
 (let (($x1104 (and $x338 v_0_fin_sent)))
 (let (($x1144 (not $x1104)))
 (let (($x824 (<= 2147483648 (mod (+ input_0_net.data_ack (* ?x278 v_0_snd_wl2)) 4294967296))))
 (let (($x820 (= v_0_snd_wl1 input_0_net.data_seq)))
 (let ((?x814 (mod (+ input_0_net.data_seq (* ?x278 v_0_snd_wl1)) 4294967296)))
 (let (($x827 (or (and (not (<= ?x814 0)) (not (<= 2147483648 ?x814))) (and $x820 (not $x824)))))
 (let (($x828 (and $x313 $x335 $x827)))
 (let ((?x830 (ite $x828 input_0_net.data_window v_0_snd_wnd)))
 (let (($x1143 (= 0 ?x830)))
 (let (($x1529 (and $x1143 $x1144 $x1146 $x1147 $x1150 $x1528)))
 (let ((?x1541 (ite $x1529 ?x779 v_0_persist_interval_ms)))
 (let ((?x1557 (+ now_1 ?x1541)))
 (let ((?x1620 (+ now_1 v_0_ack_delay_ms)))
 (let (($x201 (not active_0_delack)))
 (let ((?x1493 (+ v_0_ack_full_segments (ite (= input_0_net.data_data v_0_ack_rmss) 1 0))))
 (let (($x1494 (>= 1 ?x1493)))
 (let ((?x1486 (+ v_0_ack_bytes input_0_net.data_data)))
 (let (($x1489 (<= ?x1486 (+ ?x278 (* 2 v_0_ack_rmss)))))
 (let ((?x637 (mod (+ 15 v_0_rcv_nxt (* ?x278 input_0_net.data_seq)) 4294967296)))
 (let ((?x642 (+ input_0_net.data_data (* ?x278 ?x637))))
 (let (($x640 (<= input_0_net.data_data ?x637)))
 (let (($x635 (<= v_0_rcv_buf 0)))
 (let (($x634 (= 0 v_0_rx_slot_15)))
 (let (($x341 (not v_0_rx_fin_done)))
 (let (($x349 (and (>= ?x291 (+ 1 v_0_rtx_buf ?x333)) (>= 2147483647 ?x291))))
 (let (($x350 (not $x349)))
 (let (($x639 (and $x313 $x350 $x341 $x634 $x635 (<= ?x637 (+ ?x278 input_0_net.data_data)))))
 (let ((?x647 (ite $x639 (ite (or $x640 (<= ?x642 1)) (ite $x640 0 ?x642) 1) v_0_rx_slot_15)))
 (let (($x632 (>= 15 v_0_rx_fin_offset)))
 (let (($x633 (and v_0_rx_fin_pending $x632)))
 (let (($x649 (or $x633 (= ?x647 0))))
 (let ((?x619 (mod (+ 14 v_0_rcv_nxt (* ?x278 input_0_net.data_seq)) 4294967296)))
 (let ((?x624 (+ input_0_net.data_data (* ?x278 ?x619))))
 (let (($x622 (<= input_0_net.data_data ?x619)))
 (let (($x617 (<= v_0_rcv_buf 1)))
 (let (($x616 (= 0 v_0_rx_slot_14)))
 (let (($x621 (and $x313 $x350 $x341 $x616 $x617 (<= ?x619 (+ ?x278 input_0_net.data_data)))))
 (let ((?x629 (ite $x621 (ite (or $x622 (<= ?x624 1)) (ite $x622 0 ?x624) 1) v_0_rx_slot_14)))
 (let (($x615 (and v_0_rx_fin_pending (>= 14 v_0_rx_fin_offset))))
 (let (($x631 (or $x615 (= ?x629 0))))
 (let (($x612 (and v_0_rx_fin_pending (>= 13 v_0_rx_fin_offset))))
 (let ((?x599 (mod (+ 13 v_0_rcv_nxt (* ?x278 input_0_net.data_seq)) 4294967296)))
 (let ((?x604 (+ input_0_net.data_data (* ?x278 ?x599))))
 (let (($x602 (<= input_0_net.data_data ?x599)))
 (let (($x597 (<= v_0_rcv_buf 2)))
 (let (($x596 (= 0 v_0_rx_slot_13)))
 (let (($x601 (and $x313 $x350 $x341 $x596 $x597 (<= ?x599 (+ ?x278 input_0_net.data_data)))))
 (let ((?x609 (ite $x601 (ite (or $x602 (<= ?x604 1)) (ite $x602 0 ?x604) 1) v_0_rx_slot_13)))
 (let (($x613 (or (= ?x609 0) $x612)))
 (let (($x594 (and v_0_rx_fin_pending (>= 12 v_0_rx_fin_offset))))
 (let ((?x581 (mod (+ 12 v_0_rcv_nxt (* ?x278 input_0_net.data_seq)) 4294967296)))
 (let ((?x586 (+ input_0_net.data_data (* ?x278 ?x581))))
 (let (($x584 (<= input_0_net.data_data ?x581)))
 (let (($x579 (<= v_0_rcv_buf 3)))
 (let (($x578 (= 0 v_0_rx_slot_12)))
 (let (($x583 (and $x313 $x350 $x341 $x578 $x579 (<= ?x581 (+ ?x278 input_0_net.data_data)))))
 (let ((?x591 (ite $x583 (ite (or $x584 (<= ?x586 1)) (ite $x584 0 ?x586) 1) v_0_rx_slot_12)))
 (let (($x595 (or (= ?x591 0) $x594)))
 (let ((?x653 (ite $x595 12 (ite $x613 13 (ite $x631 14 (ite $x649 15 16))))))
 (let ((?x565 (mod (+ 11 v_0_rcv_nxt (* ?x278 input_0_net.data_seq)) 4294967296)))
 (let ((?x570 (+ input_0_net.data_data (* ?x278 ?x565))))
 (let (($x568 (<= input_0_net.data_data ?x565)))
 (let (($x563 (<= v_0_rcv_buf 4)))
 (let (($x562 (= 0 v_0_rx_slot_11)))
 (let (($x567 (and $x313 $x350 $x341 $x562 $x563 (<= ?x565 (+ ?x278 input_0_net.data_data)))))
 (let ((?x575 (ite $x567 (ite (or $x568 (<= ?x570 1)) (ite $x568 0 ?x570) 1) v_0_rx_slot_11)))
 (let (($x561 (and v_0_rx_fin_pending (>= 11 v_0_rx_fin_offset))))
 (let (($x577 (or $x561 (= ?x575 0))))
 (let (($x558 (and v_0_rx_fin_pending (>= 10 v_0_rx_fin_offset))))
 (let ((?x545 (mod (+ 10 v_0_rcv_nxt (* ?x278 input_0_net.data_seq)) 4294967296)))
 (let ((?x550 (+ input_0_net.data_data (* ?x278 ?x545))))
 (let (($x548 (<= input_0_net.data_data ?x545)))
 (let (($x543 (<= v_0_rcv_buf 5)))
 (let (($x542 (= 0 v_0_rx_slot_10)))
 (let (($x547 (and $x313 $x350 $x341 $x542 $x543 (<= ?x545 (+ ?x278 input_0_net.data_data)))))
 (let ((?x555 (ite $x547 (ite (or $x548 (<= ?x550 1)) (ite $x548 0 ?x550) 1) v_0_rx_slot_10)))
 (let (($x559 (or (= ?x555 0) $x558)))
 (let (($x540 (and v_0_rx_fin_pending (>= 9 v_0_rx_fin_offset))))
 (let ((?x527 (mod (+ 9 v_0_rcv_nxt (* ?x278 input_0_net.data_seq)) 4294967296)))
 (let ((?x532 (+ input_0_net.data_data (* ?x278 ?x527))))
 (let (($x530 (<= input_0_net.data_data ?x527)))
 (let (($x525 (<= v_0_rcv_buf 6)))
 (let (($x524 (= 0 v_0_rx_slot_09)))
 (let (($x529 (and $x313 $x350 $x341 $x524 $x525 (<= ?x527 (+ ?x278 input_0_net.data_data)))))
 (let ((?x537 (ite $x529 (ite (or $x530 (<= ?x532 1)) (ite $x530 0 ?x532) 1) v_0_rx_slot_09)))
 (let (($x541 (or (= ?x537 0) $x540)))
 (let (($x522 (and v_0_rx_fin_pending (>= 8 v_0_rx_fin_offset))))
 (let ((?x509 (mod (+ 8 v_0_rcv_nxt (* ?x278 input_0_net.data_seq)) 4294967296)))
 (let ((?x514 (+ input_0_net.data_data (* ?x278 ?x509))))
 (let (($x512 (<= input_0_net.data_data ?x509)))
 (let (($x507 (<= v_0_rcv_buf 7)))
 (let (($x506 (= 0 v_0_rx_slot_08)))
 (let (($x511 (and $x313 $x350 $x341 $x506 $x507 (<= ?x509 (+ ?x278 input_0_net.data_data)))))
 (let ((?x519 (ite $x511 (ite (or $x512 (<= ?x514 1)) (ite $x512 0 ?x514) 1) v_0_rx_slot_08)))
 (let (($x523 (or (= ?x519 0) $x522)))
 (let ((?x657 (ite $x523 8 (ite $x541 9 (ite $x559 10 (ite $x577 11 ?x653))))))
 (let (($x504 (and v_0_rx_fin_pending (>= 7 v_0_rx_fin_offset))))
 (let ((?x491 (mod (+ 7 v_0_rcv_nxt (* ?x278 input_0_net.data_seq)) 4294967296)))
 (let ((?x496 (+ input_0_net.data_data (* ?x278 ?x491))))
 (let (($x494 (<= input_0_net.data_data ?x491)))
 (let (($x488 (<= v_0_rcv_buf 8)))
 (let (($x486 (= 0 v_0_rx_slot_07)))
 (let (($x493 (and $x313 $x350 $x341 $x486 $x488 (<= ?x491 (+ ?x278 input_0_net.data_data)))))
 (let ((?x501 (ite $x493 (ite (or $x494 (<= ?x496 1)) (ite $x494 0 ?x496) 1) v_0_rx_slot_07)))
 (let (($x505 (or (= ?x501 0) $x504)))
 (let (($x484 (and v_0_rx_fin_pending (>= 6 v_0_rx_fin_offset))))
 (let ((?x471 (mod (+ 6 v_0_rcv_nxt (* ?x278 input_0_net.data_seq)) 4294967296)))
 (let ((?x476 (+ input_0_net.data_data (* ?x278 ?x471))))
 (let (($x474 (<= input_0_net.data_data ?x471)))
 (let (($x468 (<= v_0_rcv_buf 9)))
 (let (($x466 (= 0 v_0_rx_slot_06)))
 (let (($x473 (and $x313 $x350 $x341 $x466 $x468 (<= ?x471 (+ ?x278 input_0_net.data_data)))))
 (let ((?x481 (ite $x473 (ite (or $x474 (<= ?x476 1)) (ite $x474 0 ?x476) 1) v_0_rx_slot_06)))
 (let (($x485 (or (= ?x481 0) $x484)))
 (let (($x464 (and v_0_rx_fin_pending (>= 5 v_0_rx_fin_offset))))
 (let ((?x451 (mod (+ 5 v_0_rcv_nxt (* ?x278 input_0_net.data_seq)) 4294967296)))
 (let ((?x456 (+ input_0_net.data_data (* ?x278 ?x451))))
 (let (($x454 (<= input_0_net.data_data ?x451)))
 (let (($x448 (<= v_0_rcv_buf 10)))
 (let (($x446 (= 0 v_0_rx_slot_05)))
 (let (($x453 (and $x313 $x350 $x341 $x446 $x448 (<= ?x451 (+ ?x278 input_0_net.data_data)))))
 (let ((?x461 (ite $x453 (ite (or $x454 (<= ?x456 1)) (ite $x454 0 ?x456) 1) v_0_rx_slot_05)))
 (let (($x465 (or (= ?x461 0) $x464)))
 (let (($x444 (and v_0_rx_fin_pending (>= 4 v_0_rx_fin_offset))))
 (let ((?x431 (mod (+ 4 v_0_rcv_nxt (* ?x278 input_0_net.data_seq)) 4294967296)))
 (let ((?x436 (+ input_0_net.data_data (* ?x278 ?x431))))
 (let (($x434 (<= input_0_net.data_data ?x431)))
 (let (($x428 (<= v_0_rcv_buf 11)))
 (let (($x426 (= 0 v_0_rx_slot_04)))
 (let (($x433 (and $x313 $x350 $x341 $x426 $x428 (<= ?x431 (+ ?x278 input_0_net.data_data)))))
 (let ((?x441 (ite $x433 (ite (or $x434 (<= ?x436 1)) (ite $x434 0 ?x436) 1) v_0_rx_slot_04)))
 (let (($x445 (or (= ?x441 0) $x444)))
 (let ((?x661 (ite $x445 4 (ite $x465 5 (ite $x485 6 (ite $x505 7 ?x657))))))
 (let ((?x413 (mod (+ 3 v_0_rcv_nxt (* ?x278 input_0_net.data_seq)) 4294967296)))
 (let ((?x418 (+ input_0_net.data_data (* ?x278 ?x413))))
 (let (($x416 (<= input_0_net.data_data ?x413)))
 (let (($x411 (<= v_0_rcv_buf 12)))
 (let (($x409 (= 0 v_0_rx_slot_03)))
 (let (($x415 (and $x313 $x350 $x341 $x409 $x411 (<= ?x413 (+ ?x278 input_0_net.data_data)))))
 (let ((?x423 (ite $x415 (ite (or $x416 (<= ?x418 1)) (ite $x416 0 ?x418) 1) v_0_rx_slot_03)))
 (let (($x408 (and v_0_rx_fin_pending (>= 3 v_0_rx_fin_offset))))
 (let (($x425 (or $x408 (= ?x423 0))))
 (let ((?x393 (mod (+ 2 v_0_rcv_nxt (* ?x278 input_0_net.data_seq)) 4294967296)))
 (let ((?x398 (+ input_0_net.data_data (* ?x278 ?x393))))
 (let (($x396 (<= input_0_net.data_data ?x393)))
 (let (($x391 (<= v_0_rcv_buf 13)))
 (let (($x389 (= 0 v_0_rx_slot_02)))
 (let (($x395 (and $x313 $x350 $x341 $x389 $x391 (<= ?x393 (+ ?x278 input_0_net.data_data)))))
 (let ((?x403 (ite $x395 (ite (or $x396 (<= ?x398 1)) (ite $x396 0 ?x398) 1) v_0_rx_slot_02)))
 (let (($x388 (and v_0_rx_fin_pending (>= 2 v_0_rx_fin_offset))))
 (let (($x405 (or $x388 (= ?x403 0))))
 (let (($x384 (and v_0_rx_fin_pending (>= 1 v_0_rx_fin_offset))))
 (let ((?x371 (mod (+ 1 v_0_rcv_nxt (* ?x278 input_0_net.data_seq)) 4294967296)))
 (let ((?x376 (+ input_0_net.data_data (* ?x278 ?x371))))
 (let (($x374 (<= input_0_net.data_data ?x371)))
 (let (($x369 (<= v_0_rcv_buf 14)))
 (let (($x367 (= 0 v_0_rx_slot_01)))
 (let (($x373 (and $x313 $x350 $x341 $x367 $x369 (<= ?x371 (+ ?x278 input_0_net.data_data)))))
 (let ((?x381 (ite $x373 (ite (or $x374 (<= ?x376 1)) (ite $x374 0 ?x376) 1) v_0_rx_slot_01)))
 (let (($x382 (= ?x381 0)))
 (let (($x385 (or $x382 $x384)))
 (let ((?x664 (ite $x385 1 (ite $x405 2 (ite $x425 3 ?x661)))))
 (let ((?x359 (+ input_0_net.data_data (* ?x278 (mod (+ v_0_rcv_nxt (* ?x278 input_0_net.data_seq)) 4294967296)))))
 (let ((?x281 (mod (+ v_0_rcv_nxt (* ?x278 input_0_net.data_seq)) 4294967296)))
 (let (($x357 (<= input_0_net.data_data ?x281)))
 (let (($x353 (<= v_0_rcv_buf 15)))
 (let (($x351 (= 0 v_0_rx_slot_00)))
 (let (($x356 (and $x313 $x350 $x341 $x351 $x353 (<= ?x281 (+ ?x278 input_0_net.data_data)))))
 (let ((?x364 (ite $x356 (ite (or $x357 (<= ?x359 1)) (ite $x357 0 ?x359) 1) v_0_rx_slot_00)))
 (let (($x344 (and v_0_rx_fin_pending (>= 0 v_0_rx_fin_offset))))
 (let (($x366 (or $x344 (= ?x364 0))))
 (let (($x700 (not $x366)))
 (let ((?x702 (ite (and (<= 0 (ite $x366 0 ?x664)) $x700) ?x664 0)))
 (let ((?x694 (ite $x615 0 ?x629)))
 (let ((?x693 (ite $x612 0 ?x609)))
 (let ((?x692 (ite $x594 0 ?x591)))
 (let ((?x691 (ite $x561 0 ?x575)))
 (let ((?x690 (ite $x558 0 ?x555)))
 (let ((?x689 (ite $x540 0 ?x537)))
 (let ((?x688 (ite $x522 0 ?x519)))
 (let ((?x687 (ite $x504 0 ?x501)))
 (let ((?x686 (ite $x484 0 ?x481)))
 (let ((?x685 (ite $x464 0 ?x461)))
 (let ((?x684 (ite $x444 0 ?x441)))
 (let ((?x683 (ite $x408 0 ?x423)))
 (let ((?x682 (ite $x388 0 ?x403)))
 (let ((?x681 (ite $x384 0 ?x381)))
 (let ((?x680 (ite $x344 0 ?x364)))
 (let ((?x696 (+ ?x680 ?x681 ?x682 ?x683 ?x684 ?x685 ?x686 ?x687 ?x688 ?x689 ?x690 ?x691 ?x692 ?x693 ?x694 (ite $x633 0 ?x647))))
 (let ((?x698 (ite (<= ?x696 0) 0 ?x696)))
 (let ((?x704 (ite (<= ?x698 ?x702) ?x698 ?x702)))
 (let ((?x795 (* ?x278 ?x704)))
 (let ((?x794 (* ?x278 v_0_rcv_buf)))
 (let (($x1484 (<= (- 15) (+ ?x794 ?x795))))
 (let (($x1481 (= ?x704 input_0_net.data_data)))
 (let ((?x668 (ite v_0_rx_fin_pending (+ v_0_rx_fin_offset (* ?x278 (ite $x366 0 ?x664))) v_0_rx_fin_offset)))
 (let (($x669 (= 0 ?x668)))
 (let (($x670 (and v_0_rx_fin_pending $x341 $x669)))
 (let (($x671 (not $x670)))
 (let (($x1480 (not v_0_rx_fin_pending)))
 (let (($x1479 (<= input_0_net.data_data v_0_local_window)))
 (let (($x1478 (<= input_0_net.data_data v_0_ack_rmss)))
 (let (($x275 (<= 1 input_0_net.data_data)))
 (let (($x1476 (= input_0_net.data_seq v_0_rcv_nxt)))
 (let (($x1592 (and $x1476 $x275 $x1478 $x1479 $x1480 $x341 $x351 $x367 $x389 $x409 $x426 $x446 $x466 $x486 $x506 $x524 $x542 $x562 $x578 $x596 $x616 $x634 $x350 $x671 $x1481 $x1484 $x1489 $x1494 $x201)))
 (let ((?x1616 (+ now_1 (* 2 v_0_msl_ms))))
 (let (($x672 (and v_0_rx_fin_pending $x341 $x669 $x313 $x331 $x335 v_0_fin_sent $x336)))
 (let (($x1613 (= due_1_user due_0_user)))
 (let ((?x1605 (ite (<= (- 999.0) ?x769) 1000 ?x774)))
 (let (($x1577 (and $x313 $x331 $x335 (<= 1 (+ ?x807 (ite $x1104 1 0))))))
 (let (($x1575 (and (not (and $x313 $x331 $x335 (= 0 (+ ?x807 (ite $x1104 1 0))))) active_0_rtx)))
 (let (($x673 (not $x672)))
 (let (($x1151 (and $x1143 $x1144 $x1146 $x1147 $x1150)))
 (let (($x1152 (not $x1151)))
 (let (($x1579 (and $x1152 $x673 (or $x1575 $x1577))))
 (let (($x1582 (and v_0_persist_active $x1152 (<= 1 ?x807) (not $x1579))))
 (let ((?x1610 (ite (or $x1582 $x1577) (+ now_1 (ite $x721 (ite (<= 60000 ?x1605) 60000 ?x1605) v_0_rto_ms)) due_0_rtx)))
 (let (($x1599 (= active_1_persist (and $x1143 $x1144 $x1146 $x1147 $x1150 (or active_0_persist $x1529)))))
 (let (($x1594 (and $x1476 $x275 $x1478 $x1479 $x1480 $x341 $x351 $x367 $x389 $x409 $x426 $x446 $x466 $x486 $x506 $x524 $x542 $x562 $x578 $x596 $x616 $x634 $x350 $x671 $x1481 $x1484 $x1489 $x1494 (or active_0_delack $x1592))))
 (let (($x1568 (= v_1_persist_elapsed_ms v_0_persist_elapsed_ms)))
 (let (($x1561 (= v_1_persist_deadline_ms (ite $x1151 (ite $x1529 ?x1557 v_0_persist_deadline_ms) 0))))
 (let (($x1551 (= v_1_persist_since_ms (ite $x1151 (ite $x1529 now_1 v_0_persist_since_ms) 0))))
 (let (($x1546 (= v_1_persist_previous_interval_ms v_0_persist_previous_interval_ms)))
 (let (($x1538 (not v_1_persist_probe_new)))
 (let (($x1536 (not v_1_persist_probe_sent)))
 (let (($x1534 (not v_1_persist_first)))
 (let (($x1532 (= v_1_persist_was_active v_0_persist_active)))
 (let (($x1496 (and $x1476 $x275 $x1478 $x1479 $x1480 $x341 $x351 $x367 $x389 $x409 $x426 $x446 $x466 $x486 $x506 $x524 $x542 $x562 $x578 $x596 $x616 $x634 $x350 $x671 $x1481 $x1484 $x1489 $x1494)))
 (let (($x1519 (and $x1476 $x275 $x1478 $x1479 $x1480 $x341 $x351 $x367 $x389 $x409 $x426 $x446 $x466 $x486 $x506 $x524 $x542 $x562 $x578 $x596 $x616 $x634)))
 (let (($x1517 (= v_1_ack_rmss v_0_ack_rmss)))
 (let (($x1515 (= v_1_ack_delay_ms v_0_ack_delay_ms)))
 (let (($x1501 (not v_0_ack_pending)))
 (let (($x1502 (and $x1476 $x275 $x1478 $x1479 $x1480 $x341 $x351 $x367 $x389 $x409 $x426 $x446 $x466 $x486 $x506 $x524 $x542 $x562 $x578 $x596 $x616 $x634 $x350 $x671 $x1481 $x1484 $x1489 $x1494 $x1501)))
 (let (($x1506 (= v_1_ack_since_ms (ite $x1496 (ite $x1502 now_1 v_0_ack_since_ms) 0))))
 (let (($x1498 (and $x1476 $x275 $x1478 $x1479 $x1480 $x341 $x351 $x367 $x389 $x409 $x426 $x446 $x466 $x486 $x506 $x524 $x542 $x562 $x578 $x596 $x616 $x634 $x350 $x671 $x1481 $x1484 $x1489 $x1494 (or v_0_ack_pending $x1496))))
 (let (($x1474 (not v_1_syn_timeout_eligible)))
 (let (($x1472 (not v_1_tx_syn_pending)))
 (let (($x1470 (= v_1_tx_syn_time 0)))
 (let (($x1468 (not v_1_tx_waiting)))
 (let (($x1466 (= v_1_tx_is_fin v_0_tx_is_fin)))
 (let (($x1463 (= v_1_tx_previous_rto v_0_tx_previous_rto)))
 (let (($x1460 (= v_1_tx_elapsed v_0_tx_elapsed)))
 (let (($x1457 (not v_1_tx_retransmitted)))
 (let (($x1455 (= v_1_tx_max_previous v_0_tx_max_previous)))
 (let (($x1452 (= v_1_tx_eligible v_0_tx_eligible)))
 (let (($x1449 (= v_1_tx_emit_count v_0_tx_emit_count)))
 (let ((?x1441 (ite (or (>= 15 ?x807) (and $x313 $x331 $x335 (not (= 0 ?x291))) $x1149) 0 v_0_tx_time_15)))
 (let (($x1200 (and $x313 $x331 $x335 (not (= 0 ?x291)))))
 (let ((?x1436 (ite (or (>= 14 ?x807) $x1149) 0 (ite $x1200 (ite (= 1 ?x291) v_0_tx_time_15 0) v_0_tx_time_14))))
 (let (($x1201 (= 1 ?x291)))
 (let ((?x1428 (ite $x1200 (ite $x1201 v_0_tx_time_14 (ite (= 2 ?x291) v_0_tx_time_15 0)) v_0_tx_time_13)))
 (let (($x1203 (= 2 ?x291)))
 (let ((?x1419 (ite $x1201 v_0_tx_time_13 (ite $x1203 v_0_tx_time_14 (ite (= 3 ?x291) v_0_tx_time_15 0)))))
 (let (($x1422 (= v_1_tx_time_12 (ite (or (>= 12 ?x807) $x1149) 0 (ite $x1200 ?x1419 v_0_tx_time_12)))))
 (let (($x1205 (= 3 ?x291)))
 (let ((?x1409 (ite $x1203 v_0_tx_time_13 (ite $x1205 v_0_tx_time_14 (ite (= 4 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1412 (ite (or (>= 11 ?x807) $x1149) 0 (ite $x1200 (ite $x1201 v_0_tx_time_12 ?x1409) v_0_tx_time_11))))
 (let (($x1207 (= 4 ?x291)))
 (let ((?x1398 (ite $x1205 v_0_tx_time_13 (ite $x1207 v_0_tx_time_14 (ite (= 5 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1401 (ite $x1200 (ite $x1201 v_0_tx_time_11 (ite $x1203 v_0_tx_time_12 ?x1398)) v_0_tx_time_10)))
 (let (($x1209 (= 5 ?x291)))
 (let ((?x1386 (ite $x1207 v_0_tx_time_13 (ite $x1209 v_0_tx_time_14 (ite (= 6 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1389 (ite $x1201 v_0_tx_time_10 (ite $x1203 v_0_tx_time_11 (ite $x1205 v_0_tx_time_12 ?x1386)))))
 (let (($x1392 (= v_1_tx_time_09 (ite (or (>= 9 ?x807) $x1149) 0 (ite $x1200 ?x1389 v_0_tx_time_09)))))
 (let (($x1211 (= 6 ?x291)))
 (let ((?x1373 (ite $x1209 v_0_tx_time_13 (ite $x1211 v_0_tx_time_14 (ite (= 7 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1376 (ite $x1203 v_0_tx_time_10 (ite $x1205 v_0_tx_time_11 (ite $x1207 v_0_tx_time_12 ?x1373)))))
 (let ((?x1379 (ite (or (>= 8 ?x807) $x1149) 0 (ite $x1200 (ite $x1201 v_0_tx_time_09 ?x1376) v_0_tx_time_08))))
 (let (($x1213 (= 7 ?x291)))
 (let ((?x1359 (ite $x1211 v_0_tx_time_13 (ite $x1213 v_0_tx_time_14 (ite (= 8 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1362 (ite $x1205 v_0_tx_time_10 (ite $x1207 v_0_tx_time_11 (ite $x1209 v_0_tx_time_12 ?x1359)))))
 (let ((?x1365 (ite $x1200 (ite $x1201 v_0_tx_time_08 (ite $x1203 v_0_tx_time_09 ?x1362)) v_0_tx_time_07)))
 (let (($x1215 (= 8 ?x291)))
 (let ((?x1344 (ite $x1213 v_0_tx_time_13 (ite $x1215 v_0_tx_time_14 (ite (= 9 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1347 (ite $x1207 v_0_tx_time_10 (ite $x1209 v_0_tx_time_11 (ite $x1211 v_0_tx_time_12 ?x1344)))))
 (let ((?x1350 (ite $x1201 v_0_tx_time_07 (ite $x1203 v_0_tx_time_08 (ite $x1205 v_0_tx_time_09 ?x1347)))))
 (let (($x1353 (= v_1_tx_time_06 (ite (or (>= 6 ?x807) $x1149) 0 (ite $x1200 ?x1350 v_0_tx_time_06)))))
 (let (($x1217 (= 9 ?x291)))
 (let ((?x1328 (ite $x1215 v_0_tx_time_13 (ite $x1217 v_0_tx_time_14 (ite (= 10 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1331 (ite $x1209 v_0_tx_time_10 (ite $x1211 v_0_tx_time_11 (ite $x1213 v_0_tx_time_12 ?x1328)))))
 (let ((?x1334 (ite $x1203 v_0_tx_time_07 (ite $x1205 v_0_tx_time_08 (ite $x1207 v_0_tx_time_09 ?x1331)))))
 (let ((?x1337 (ite (or (>= 5 ?x807) $x1149) 0 (ite $x1200 (ite $x1201 v_0_tx_time_06 ?x1334) v_0_tx_time_05))))
 (let (($x1219 (= 10 ?x291)))
 (let ((?x1311 (ite $x1217 v_0_tx_time_13 (ite $x1219 v_0_tx_time_14 (ite (= 11 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1314 (ite $x1211 v_0_tx_time_10 (ite $x1213 v_0_tx_time_11 (ite $x1215 v_0_tx_time_12 ?x1311)))))
 (let ((?x1317 (ite $x1205 v_0_tx_time_07 (ite $x1207 v_0_tx_time_08 (ite $x1209 v_0_tx_time_09 ?x1314)))))
 (let ((?x1320 (ite $x1200 (ite $x1201 v_0_tx_time_05 (ite $x1203 v_0_tx_time_06 ?x1317)) v_0_tx_time_04)))
 (let (($x1221 (= 11 ?x291)))
 (let ((?x1293 (ite $x1219 v_0_tx_time_13 (ite $x1221 v_0_tx_time_14 (ite (= 12 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1296 (ite $x1213 v_0_tx_time_10 (ite $x1215 v_0_tx_time_11 (ite $x1217 v_0_tx_time_12 ?x1293)))))
 (let ((?x1299 (ite $x1207 v_0_tx_time_07 (ite $x1209 v_0_tx_time_08 (ite $x1211 v_0_tx_time_09 ?x1296)))))
 (let ((?x1302 (ite $x1201 v_0_tx_time_04 (ite $x1203 v_0_tx_time_05 (ite $x1205 v_0_tx_time_06 ?x1299)))))
 (let (($x1305 (= v_1_tx_time_03 (ite (or $x1149 (>= 3 ?x807)) 0 (ite $x1200 ?x1302 v_0_tx_time_03)))))
 (let (($x1223 (= 12 ?x291)))
 (let ((?x1274 (ite $x1221 v_0_tx_time_13 (ite $x1223 v_0_tx_time_14 (ite (= 13 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1277 (ite $x1215 v_0_tx_time_10 (ite $x1217 v_0_tx_time_11 (ite $x1219 v_0_tx_time_12 ?x1274)))))
 (let ((?x1280 (ite $x1209 v_0_tx_time_07 (ite $x1211 v_0_tx_time_08 (ite $x1213 v_0_tx_time_09 ?x1277)))))
 (let ((?x1283 (ite $x1203 v_0_tx_time_04 (ite $x1205 v_0_tx_time_05 (ite $x1207 v_0_tx_time_06 ?x1280)))))
 (let ((?x1286 (ite (or $x1149 (>= 2 ?x807)) 0 (ite $x1200 (ite $x1201 v_0_tx_time_03 ?x1283) v_0_tx_time_02))))
 (let (($x1225 (= 13 ?x291)))
 (let ((?x1254 (ite $x1223 v_0_tx_time_13 (ite $x1225 v_0_tx_time_14 (ite (= 14 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1257 (ite $x1217 v_0_tx_time_10 (ite $x1219 v_0_tx_time_11 (ite $x1221 v_0_tx_time_12 ?x1254)))))
 (let ((?x1260 (ite $x1211 v_0_tx_time_07 (ite $x1213 v_0_tx_time_08 (ite $x1215 v_0_tx_time_09 ?x1257)))))
 (let ((?x1263 (ite $x1205 v_0_tx_time_04 (ite $x1207 v_0_tx_time_05 (ite $x1209 v_0_tx_time_06 ?x1260)))))
 (let ((?x1266 (ite $x1200 (ite $x1201 v_0_tx_time_02 (ite $x1203 v_0_tx_time_03 ?x1263)) v_0_tx_time_01)))
 (let (($x1227 (= 14 ?x291)))
 (let ((?x1233 (ite $x1225 v_0_tx_time_13 (ite $x1227 v_0_tx_time_14 (ite (= 15 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1236 (ite $x1219 v_0_tx_time_10 (ite $x1221 v_0_tx_time_11 (ite $x1223 v_0_tx_time_12 ?x1233)))))
 (let ((?x1239 (ite $x1213 v_0_tx_time_07 (ite $x1215 v_0_tx_time_08 (ite $x1217 v_0_tx_time_09 ?x1236)))))
 (let ((?x1242 (ite $x1207 v_0_tx_time_04 (ite $x1209 v_0_tx_time_05 (ite $x1211 v_0_tx_time_06 ?x1239)))))
 (let ((?x1245 (ite $x1201 v_0_tx_time_01 (ite $x1203 v_0_tx_time_02 (ite $x1205 v_0_tx_time_03 ?x1242)))))
 (let (($x1249 (= v_1_tx_time_00 (ite (or (>= 0 ?x807) $x1149) 0 (ite $x1200 ?x1245 v_0_tx_time_00)))))
 (let (($x1183 (= v_1_rtt_sample_was_ambiguous (and v_0_rtt_active v_0_rtt_ambiguous))))
 (let (($x1178 (not v_1_rtt_start_new)))
 (let ((?x800 (* ?x278 ?x291)))
 (let ((?x1170 (+ ?x717 ?x800)))
 (let (($x1173 (and v_0_rtt_active $x313 $x331 $x335 (not (<= v_0_rtt_remaining ?x1170)))))
 (let ((?x1175 (ite (or (and v_0_rtt_active $x313 $x331 $x335 $x718) $x1151) 0 (ite $x1173 ?x1170 v_0_rtt_remaining))))
 (let (($x1166 (= v_1_rtt_end v_0_rtt_end)))
 (let (($x1165 (= v_1_rtt_start_ms v_0_rtt_start_ms)))
 (let (($x1153 (and v_0_rtt_active $x313 $x331 $x335 $x718)))
 (let (($x1154 (not $x1153)))
 (let (($x1141 (= v_1_rtt_previous_measured (ite $x721 v_0_rtt_measured v_0_rtt_previous_measured))))
 (let (($x1134 (= v_1_rtt_previous_var (ite $x721 v_0_rttvar_ms v_0_rtt_previous_var))))
 (let (($x1130 (= v_1_rtt_previous_srtt (ite $x721 v_0_srtt_ms v_0_rtt_previous_srtt))))
 (let (($x1112 (= v_1_rx_fin_seq v_0_rx_fin_seq)))
 (let (($x1106 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x1102 (= v_1_fin_requested v_0_fin_requested)))
 (let (($x1081 (= v_1_rx_slot_15 (ite (or (not (and $x366 (not $x633))) $x670) 0 ?x647))))
 (let (($x896 (not $x633)))
 (let (($x865 (not $x405)))
 (let (($x863 (not $x425)))
 (let (($x861 (not $x445)))
 (let (($x859 (not $x465)))
 (let (($x857 (not $x485)))
 (let (($x855 (not $x505)))
 (let (($x853 (not $x523)))
 (let (($x851 (not $x541)))
 (let (($x849 (not $x559)))
 (let (($x847 (not $x577)))
 (let (($x845 (not $x595)))
 (let (($x843 (not $x613)))
 (let (($x841 (not $x631)))
 (let (($x840 (and false $x649)))
 (let (($x842 (and $x840 $x841)))
 (let (($x844 (and $x842 $x843)))
 (let (($x846 (and $x844 $x845)))
 (let (($x848 (and $x846 $x847)))
 (let (($x850 (and $x848 $x849)))
 (let (($x852 (and $x850 $x851)))
 (let (($x854 (and $x852 $x853)))
 (let (($x856 (and $x854 $x855)))
 (let (($x858 (and $x856 $x857)))
 (let (($x860 (and $x858 $x859)))
 (let (($x862 (and $x860 $x861)))
 (let (($x864 (and $x862 $x863)))
 (let (($x867 (or $x382 $x384 (and $x864 $x865))))
 (let (($x1076 (= v_1_rx_slot_14 (ite $x670 0 (ite $x366 ?x694 (ite (and $x867 $x700 $x896) ?x647 0))))))
 (let (($x868 (and $x867 $x700)))
 (let ((?x1068 (ite $x868 ?x694 (ite (and (or $x864 $x405) (not $x385) $x700 $x896) ?x647 0))))
 (let (($x870 (not $x385)))
 (let (($x869 (or $x864 $x405)))
 (let (($x871 (and $x869 $x870 $x700)))
 (let ((?x1061 (ite $x871 ?x694 (ite (and (or $x862 $x425) $x865 $x870 $x700 $x896) ?x647 0))))
 (let (($x1065 (= v_1_rx_slot_12 (ite $x670 0 (ite $x366 ?x692 (ite $x868 ?x693 ?x1061))))))
 (let (($x872 (or $x862 $x425)))
 (let (($x873 (and $x872 $x865 $x870 $x700)))
 (let ((?x1053 (ite $x873 ?x694 (ite (and (or $x860 $x445) $x863 $x865 $x870 $x700 $x896) ?x647 0))))
 (let (($x1058 (= v_1_rx_slot_11 (ite $x670 0 (ite $x366 ?x691 (ite $x868 ?x692 (ite $x871 ?x693 ?x1053)))))))
 (let (($x874 (or $x860 $x445)))
 (let (($x875 (and $x874 $x863 $x865 $x870 $x700)))
 (let ((?x1044 (ite $x875 ?x694 (ite (and (or $x858 $x465) $x861 $x863 $x865 $x870 $x700 $x896) ?x647 0))))
 (let ((?x1049 (ite $x670 0 (ite $x366 ?x690 (ite $x868 ?x691 (ite $x871 ?x692 (ite $x873 ?x693 ?x1044)))))))
 (let ((?x1033 (ite (and (or $x856 $x485) $x859 $x861 $x863 $x865 $x870 $x700 $x896) ?x647 0)))
 (let (($x876 (or $x858 $x465)))
 (let (($x877 (and $x876 $x861 $x863 $x865 $x870 $x700)))
 (let ((?x1038 (ite $x868 ?x690 (ite $x871 ?x691 (ite $x873 ?x692 (ite $x875 ?x693 (ite $x877 ?x694 ?x1033)))))))
 (let ((?x1022 (ite (and (or $x854 $x505) $x857 $x859 $x861 $x863 $x865 $x870 $x700 $x896) ?x647 0)))
 (let (($x878 (or $x856 $x485)))
 (let (($x879 (and $x878 $x859 $x861 $x863 $x865 $x870 $x700)))
 (let ((?x1027 (ite $x871 ?x690 (ite $x873 ?x691 (ite $x875 ?x692 (ite $x877 ?x693 (ite $x879 ?x694 ?x1022)))))))
 (let (($x1031 (= v_1_rx_slot_08 (ite $x670 0 (ite $x366 ?x688 (ite $x868 ?x689 ?x1027))))))
 (let ((?x1010 (ite (and (or $x852 $x523) $x855 $x857 $x859 $x861 $x863 $x865 $x870 $x700 $x896) ?x647 0)))
 (let (($x880 (or $x854 $x505)))
 (let (($x881 (and $x880 $x857 $x859 $x861 $x863 $x865 $x870 $x700)))
 (let ((?x1015 (ite $x873 ?x690 (ite $x875 ?x691 (ite $x877 ?x692 (ite $x879 ?x693 (ite $x881 ?x694 ?x1010)))))))
 (let (($x1020 (= v_1_rx_slot_07 (ite $x670 0 (ite $x366 ?x687 (ite $x868 ?x688 (ite $x871 ?x689 ?x1015)))))))
 (let (($x884 (or $x850 $x541)))
 (let ((?x997 (ite (and $x884 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x870 $x700 $x896) ?x647 0)))
 (let (($x882 (or $x852 $x523)))
 (let (($x883 (and $x882 $x855 $x857 $x859 $x861 $x863 $x865 $x870 $x700)))
 (let ((?x1002 (ite $x875 ?x690 (ite $x877 ?x691 (ite $x879 ?x692 (ite $x881 ?x693 (ite $x883 ?x694 ?x997)))))))
 (let ((?x1007 (ite $x670 0 (ite $x366 ?x686 (ite $x868 ?x687 (ite $x871 ?x688 (ite $x873 ?x689 ?x1002)))))))
 (let (($x886 (or $x848 $x559)))
 (let ((?x983 (ite (and $x886 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x870 $x700 $x896) ?x647 0)))
 (let (($x885 (and $x884 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x870 $x700)))
 (let ((?x988 (ite $x877 ?x690 (ite $x879 ?x691 (ite $x881 ?x692 (ite $x883 ?x693 (ite $x885 ?x694 ?x983)))))))
 (let ((?x993 (ite $x366 ?x685 (ite $x868 ?x686 (ite $x871 ?x687 (ite $x873 ?x688 (ite $x875 ?x689 ?x988)))))))
 (let (($x888 (or $x846 $x577)))
 (let (($x967 (and $x888 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x870 $x700 $x896)))
 (let (($x887 (and $x886 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x870 $x700)))
 (let ((?x972 (ite $x881 ?x691 (ite $x883 ?x692 (ite $x885 ?x693 (ite $x887 ?x694 (ite $x967 ?x647 0)))))))
 (let ((?x977 (ite $x871 ?x686 (ite $x873 ?x687 (ite $x875 ?x688 (ite $x877 ?x689 (ite $x879 ?x690 ?x972)))))))
 (let (($x981 (= v_1_rx_slot_04 (ite $x670 0 (ite $x366 ?x684 (ite $x868 ?x685 ?x977))))))
 (let (($x890 (or $x844 $x595)))
 (let (($x951 (and $x890 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x870 $x700 $x896)))
 (let (($x889 (and $x888 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x870 $x700)))
 (let ((?x956 (ite $x883 ?x691 (ite $x885 ?x692 (ite $x887 ?x693 (ite $x889 ?x694 (ite $x951 ?x647 0)))))))
 (let ((?x961 (ite $x873 ?x686 (ite $x875 ?x687 (ite $x877 ?x688 (ite $x879 ?x689 (ite $x881 ?x690 ?x956)))))))
 (let (($x966 (= v_1_rx_slot_03 (ite $x670 0 (ite $x366 ?x683 (ite $x868 ?x684 (ite $x871 ?x685 ?x961)))))))
 (let (($x892 (or $x842 $x613)))
 (let (($x934 (and $x892 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x870 $x700 $x896)))
 (let (($x891 (and $x890 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x870 $x700)))
 (let ((?x939 (ite $x885 ?x691 (ite $x887 ?x692 (ite $x889 ?x693 (ite $x891 ?x694 (ite $x934 ?x647 0)))))))
 (let ((?x944 (ite $x875 ?x686 (ite $x877 ?x687 (ite $x879 ?x688 (ite $x881 ?x689 (ite $x883 ?x690 ?x939)))))))
 (let ((?x949 (ite $x670 0 (ite $x366 ?x682 (ite $x868 ?x683 (ite $x871 ?x684 (ite $x873 ?x685 ?x944)))))))
 (let (($x894 (or $x840 $x631)))
 (let (($x916 (and $x894 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x870 $x700 $x896)))
 (let (($x893 (and $x892 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x870 $x700)))
 (let ((?x921 (ite $x887 ?x691 (ite $x889 ?x692 (ite $x891 ?x693 (ite $x893 ?x694 (ite $x916 ?x647 0)))))))
 (let ((?x926 (ite $x877 ?x686 (ite $x879 ?x687 (ite $x881 ?x688 (ite $x883 ?x689 (ite $x885 ?x690 ?x921)))))))
 (let ((?x931 (ite $x366 ?x681 (ite $x868 ?x682 (ite $x871 ?x683 (ite $x873 ?x684 (ite $x875 ?x685 ?x926)))))))
 (let (($x897 (and $x649 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x870 $x700 $x896)))
 (let (($x895 (and $x894 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x870 $x700)))
 (let ((?x902 (ite $x889 ?x691 (ite $x891 ?x692 (ite $x893 ?x693 (ite $x895 ?x694 (ite $x897 ?x647 0)))))))
 (let ((?x907 (ite $x879 ?x686 (ite $x881 ?x687 (ite $x883 ?x688 (ite $x885 ?x689 (ite $x887 ?x690 ?x902)))))))
 (let ((?x912 (ite $x868 ?x681 (ite $x871 ?x682 (ite $x873 ?x683 (ite $x875 ?x684 (ite $x877 ?x685 ?x907)))))))
 (let (($x838 (= v_1_take v_0_take)))
 (let (($x798 (= v_1_snd_buf v_0_snd_buf)))
 (let (($x792 (= v_1_msl_ms v_0_msl_ms)))
 (let (($x789 (= v_1_user_timeout_ms v_0_user_timeout_ms)))
 (let (($x786 (= v_1_active_open v_0_active_open)))
 (let (($x783 (= v_1_retries v_0_retries)))
 (let (($x713 (= v_1_tx_flags v_0_tx_flags)))
 (let (($x710 (= v_1_tx_ack v_0_tx_ack)))
 (let (($x709 (= v_1_tx_seq v_0_tx_seq)))
 (let (($x708 (= v_1_rcv_nxt (mod (+ v_0_rcv_nxt ?x704 (ite $x670 1 0)) 4294967296))))
 (let (($x679 (= v_1_snd_nxt v_0_snd_nxt)))
 (let (($x675 (= v_1_irs v_0_irs)))
 (let (($x674 (= v_1_iss v_0_iss)))
 (let (($x298 (not (= (mod (+ input_0_net.data_ack (* ?x278 v_0_snd_nxt)) 4294967296) 2147483648))))
 (and (>= now_1 now_0) $x275 (>= 16 input_0_net.data_data) (not (= ?x281 2147483648)) (<= 0 input_0_net.data_window) (>= 65535 input_0_net.data_window) (or (and (not (= ?x291 2147483648)) $x298) (not $x313)) (or (not active_0_rtx) (not (<= due_0_rtx now_1))) (or (not active_0_user) (not (<= due_0_user now_1))) (or (not active_0_time_wait) (not (<= due_0_time_wait now_1))) (or $x201 (not (<= due_0_delack now_1))) (or (not active_0_persist) (not (<= due_0_persist now_1))) $x338 $x671 $x673 $x674 $x675 (= v_1_snd_una (ite $x676 input_0_net.data_ack v_0_snd_una)) $x679 $x708 $x709 $x710 $x713 (= v_1_rto_ms ?x779) $x783 $x786 $x789 $x792 (= v_1_local_window (+ 16 ?x794 ?x795)) $x798 (= v_1_rtx_buf ?x807) (= v_1_rcv_buf (+ v_0_rcv_buf ?x704)) (= v_1_snd_wnd ?x830) (= v_1_snd_wl1 (ite $x828 input_0_net.data_seq v_0_snd_wl1)) (= v_1_snd_wl2 (ite $x828 input_0_net.data_ack v_0_snd_wl2)) $x838 (= v_1_rx_chunk ?x704) (= v_1_rx_slot_00 (ite $x670 0 (ite $x366 ?x680 ?x912))) (= v_1_rx_slot_01 (ite $x670 0 ?x931)) (= v_1_rx_slot_02 ?x949) $x966 $x981 (= v_1_rx_slot_05 (ite $x670 0 ?x993)) (= v_1_rx_slot_06 ?x1007) $x1020 $x1031 (= v_1_rx_slot_09 (ite $x670 0 (ite $x366 ?x689 ?x1038))) (= v_1_rx_slot_10 ?x1049) $x1058 $x1065 (= v_1_rx_slot_13 (ite $x670 0 (ite $x366 ?x693 ?x1068))) $x1076 $x1081 (= v_1_rx_advance (ite $x366 0 ?x664)) (= v_1_rx_acceptable (and $x313 $x350 $x341)) (= v_1_seg_acceptable $x313) (= v_1_ack_delta ?x291) (= v_1_ack_is_new (and $x331 $x335)) (= v_1_ack_is_future $x349) (= v_1_ack_advance $x676) (= v_1_ack_window_update $x828) $x1102 (= v_1_fin_sent $x1104) $x1106 (= v_1_fin_acknowledged $x337) (= v_1_rx_fin_pending (and v_0_rx_fin_pending $x671)) $x1112 (= v_1_rx_fin_offset (ite $x670 0 ?x668)) (= v_1_rx_fin_done (or v_0_rx_fin_done $x670)) (= v_1_rx_fin_consumed $x670) (= v_1_srtt_ms ?x741) (= v_1_rttvar_ms ?x764) (= v_1_rtt_error_ms ?x757) $x1130 $x1134 (= v_1_rtt_measured (or v_0_rtt_measured $x721)) $x1141 (= v_1_rtt_active (and $x1152 v_0_rtt_active $x1154)) (= v_1_rtt_ambiguous (and $x1152 $x1154 v_0_rtt_ambiguous)) (= v_1_rtt_sample_at_ms (ite $x721 now_1 v_0_rtt_sample_at_ms)) $x1165 $x1166 (= v_1_rtt_remaining ?x1175) $x1178 (= v_1_rtt_sample_used $x721) $x1183 (= v_1_rtt_last_ms ?x736) (= v_1_rtt_samples (+ v_0_rtt_samples (ite $x721 1 0))) (= v_1_rto_base_ms (ite $x721 ?x777 v_0_rto_base_ms)) $x1249 (= v_1_tx_time_01 (ite (or $x1149 $x1147) 0 ?x1266)) (= v_1_tx_time_02 ?x1286) $x1305 (= v_1_tx_time_04 (ite (or (>= 4 ?x807) $x1149) 0 ?x1320)) (= v_1_tx_time_05 ?x1337) $x1353 (= v_1_tx_time_07 (ite (or (>= 7 ?x807) $x1149) 0 ?x1365)) (= v_1_tx_time_08 ?x1379) $x1392 (= v_1_tx_time_10 (ite (or (>= 10 ?x807) $x1149) 0 ?x1401)) (= v_1_tx_time_11 ?x1412) $x1422 (= v_1_tx_time_13 (ite (or $x1149 (>= 13 ?x807)) 0 ?x1428)) (= v_1_tx_time_14 ?x1436) (= v_1_tx_time_15 ?x1441) (= v_1_tx_fin_time (ite $x1104 v_0_tx_fin_time 0)) $x1449 $x1452 $x1455 $x1457 $x1460 $x1463 $x1466 $x1468 $x1470 $x1472 $x1474 (= v_1_ack_pending $x1498) $x1506 (= v_1_ack_bytes (ite $x1496 ?x1486 0)) (= v_1_ack_full_segments (ite $x1496 ?x1493 0)) $x1515 $x1517 (= v_1_ack_defer_candidate $x1519) (= v_1_ack_defer_now $x1496) (= v_1_persist_active $x1151) (= v_1_persist_eligible $x1151) (= v_1_persist_start $x1529) $x1532 $x1534 $x1536 $x1538 (= v_1_persist_interval_ms (ite $x1151 ?x1541 1000)) $x1546 $x1551 (= v_1_persist_last_ms (ite $x1151 v_0_persist_last_ms 0)) $x1561 (= v_1_persist_probes (ite $x1151 v_0_persist_probes 0)) $x1568 (= active_1_rtx (or $x1579 $x1582)) (= active_1_user (and $x673 active_0_user)) (= active_1_time_wait (or active_0_time_wait $x672)) (= active_1_delack $x1594) $x1599 (= due_1_rtx ?x1610) $x1613 (= due_1_time_wait (ite $x672 ?x1616 due_0_time_wait)) (= due_1_delack (ite $x1592 ?x1620 due_0_delack)) (= due_1_persist (ite $x1529 ?x1557 due_0_persist))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
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
 (let ((?x1631 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1631)))
(assert
 (>= 16 v_0_rcv_buf))
(assert
 (and (<= 0 v_0_snd_wnd) (>= 65535 v_0_snd_wnd)))
(assert
 (= v_0_local_window (+ 16 (* (- 1) v_0_rcv_buf))))
(assert
 (>= 1 v_0_rx_slot_00))
(assert
 (let (($x351 (= 0 v_0_rx_slot_00)))
 (let (($x1641 (not (>= v_0_rcv_buf 16))))
 (or $x1641 $x351))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x367 (= 0 v_0_rx_slot_01)))
 (let (($x1645 (not (>= v_0_rcv_buf 15))))
 (or $x1645 $x367))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x389 (= 0 v_0_rx_slot_02)))
 (let (($x1649 (not (>= v_0_rcv_buf 14))))
 (or $x1649 $x389))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x409 (= 0 v_0_rx_slot_03)))
 (let (($x1653 (not (>= v_0_rcv_buf 13))))
 (or $x1653 $x409))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x426 (= 0 v_0_rx_slot_04)))
 (let (($x1657 (not (>= v_0_rcv_buf 12))))
 (or $x1657 $x426))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x446 (= 0 v_0_rx_slot_05)))
 (let (($x1661 (not (>= v_0_rcv_buf 11))))
 (or $x1661 $x446))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x466 (= 0 v_0_rx_slot_06)))
 (let (($x1665 (not (>= v_0_rcv_buf 10))))
 (or $x1665 $x466))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x486 (= 0 v_0_rx_slot_07)))
 (let (($x1669 (not (>= v_0_rcv_buf 9))))
 (or $x1669 $x486))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x506 (= 0 v_0_rx_slot_08)))
 (let (($x1673 (not (>= v_0_rcv_buf 8))))
 (or $x1673 $x506))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x524 (= 0 v_0_rx_slot_09)))
 (let (($x1677 (not (>= v_0_rcv_buf 7))))
 (or $x1677 $x524))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x542 (= 0 v_0_rx_slot_10)))
 (let (($x1681 (not (>= v_0_rcv_buf 6))))
 (or $x1681 $x542))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x562 (= 0 v_0_rx_slot_11)))
 (let (($x1685 (not (>= v_0_rcv_buf 5))))
 (or $x1685 $x562))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x578 (= 0 v_0_rx_slot_12)))
 (let (($x1689 (not (>= v_0_rcv_buf 4))))
 (or $x1689 $x578))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x596 (= 0 v_0_rx_slot_13)))
 (let (($x1693 (not (>= v_0_rcv_buf 3))))
 (or $x1693 $x596))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x616 (= 0 v_0_rx_slot_14)))
 (let (($x1697 (not (>= v_0_rcv_buf 2))))
 (or $x1697 $x616))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x634 (= 0 v_0_rx_slot_15)))
 (let (($x1701 (not (>= v_0_rcv_buf 1))))
 (or $x1701 $x634))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x1703 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x1703)))
(assert
 (and (<= 0 v_0_rx_advance) (>= 16 v_0_rx_advance)))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (and (<= 0 v_0_ack_delta) (>= 4294967295 v_0_ack_delta)))
(assert
 true)
(assert
 (let ((?x1715 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x1715)))
(assert
 (let (($x1722 (and v_0_fin_requested (= v_0_fin_seq (mod (+ v_0_snd_una v_0_rtx_buf) 4294967296)) (= 0 v_0_snd_buf))))
 (let (($x1717 (not v_0_fin_sent)))
 (or $x1717 $x1722))))
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
 (let (($x1724 (<= 1 v_0_rx_fin_offset)))
 (let (($x341 (not v_0_rx_fin_done)))
 (let (($x1726 (and $x341 $x1724 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window)))))
 (let (($x1480 (not v_0_rx_fin_pending)))
 (or $x1480 $x1726))))))
(assert
 (let (($x632 (>= 15 v_0_rx_fin_offset)))
 (and (<= 0 v_0_rx_fin_offset) $x632 (= v_0_rx_fin_pending (<= 1 v_0_rx_fin_offset)))))
(assert
 (let (($x1480 (not v_0_rx_fin_pending)))
 (or $x1480 (= v_0_rx_fin_seq (mod (+ v_0_rcv_nxt v_0_rx_fin_offset) 4294967296)))))
(assert
 (let (($x341 (not v_0_rx_fin_done)))
 (or $x341 (= v_0_rcv_nxt (mod (+ 1 v_0_rx_fin_seq) 4294967296)))))
(assert
 (let (($x351 (= 0 v_0_rx_slot_00)))
 (or (not (and v_0_rx_fin_pending (>= 0 v_0_rx_fin_offset))) $x351)))
(assert
 (let (($x367 (= 0 v_0_rx_slot_01)))
 (or (not (and v_0_rx_fin_pending (>= 1 v_0_rx_fin_offset))) $x367)))
(assert
 (let (($x389 (= 0 v_0_rx_slot_02)))
 (or (not (and v_0_rx_fin_pending (>= 2 v_0_rx_fin_offset))) $x389)))
(assert
 (let (($x409 (= 0 v_0_rx_slot_03)))
 (or (not (and v_0_rx_fin_pending (>= 3 v_0_rx_fin_offset))) $x409)))
(assert
 (let (($x426 (= 0 v_0_rx_slot_04)))
 (or (not (and v_0_rx_fin_pending (>= 4 v_0_rx_fin_offset))) $x426)))
(assert
 (let (($x446 (= 0 v_0_rx_slot_05)))
 (or (not (and v_0_rx_fin_pending (>= 5 v_0_rx_fin_offset))) $x446)))
(assert
 (let (($x466 (= 0 v_0_rx_slot_06)))
 (or (not (and v_0_rx_fin_pending (>= 6 v_0_rx_fin_offset))) $x466)))
(assert
 (let (($x486 (= 0 v_0_rx_slot_07)))
 (or (not (and v_0_rx_fin_pending (>= 7 v_0_rx_fin_offset))) $x486)))
(assert
 (let (($x506 (= 0 v_0_rx_slot_08)))
 (or (not (and v_0_rx_fin_pending (>= 8 v_0_rx_fin_offset))) $x506)))
(assert
 (let (($x524 (= 0 v_0_rx_slot_09)))
 (or (not (and v_0_rx_fin_pending (>= 9 v_0_rx_fin_offset))) $x524)))
(assert
 (let (($x542 (= 0 v_0_rx_slot_10)))
 (or (not (and v_0_rx_fin_pending (>= 10 v_0_rx_fin_offset))) $x542)))
(assert
 (let (($x562 (= 0 v_0_rx_slot_11)))
 (or (not (and v_0_rx_fin_pending (>= 11 v_0_rx_fin_offset))) $x562)))
(assert
 (let (($x578 (= 0 v_0_rx_slot_12)))
 (or (not (and v_0_rx_fin_pending (>= 12 v_0_rx_fin_offset))) $x578)))
(assert
 (let (($x596 (= 0 v_0_rx_slot_13)))
 (or (not (and v_0_rx_fin_pending (>= 13 v_0_rx_fin_offset))) $x596)))
(assert
 (let (($x616 (= 0 v_0_rx_slot_14)))
 (or (not (and v_0_rx_fin_pending (>= 14 v_0_rx_fin_offset))) $x616)))
(assert
 (let (($x634 (= 0 v_0_rx_slot_15)))
 (let (($x632 (>= 15 v_0_rx_fin_offset)))
 (let (($x633 (and v_0_rx_fin_pending $x632)))
 (let (($x896 (not $x633)))
 (or $x896 $x634))))))
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
 (let ((?x1784 (* 4.0 v_0_rttvar_ms)))
 (let ((?x724 (- 1.0)))
 (let ((?x753 (* ?x724 v_0_srtt_ms)))
 (let ((?x1787 (+ ?x753 (* ?x724 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x1784)))))
 (let ((?x1788 (to_int ?x1787)))
 (let ((?x278 (- 1)))
 (let ((?x1791 (ite (<= ?x1788 (- 1000)) (* ?x278 ?x1788) 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x1791) 60000 ?x1791) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x717 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x1806 (and (<= v_0_rtt_start_ms now_0) (<= 1 v_0_rtt_remaining) (>= 4 v_0_rtt_remaining) (>= ?x717 v_0_rtt_remaining) (<= ?x717 (mod (+ v_0_snd_nxt (* (- 1) v_0_snd_una)) 4294967296)))))
 (let (($x1798 (not v_0_rtt_active)))
 (or $x1798 $x1806)))))
(assert
 (let (($x1808 (= 0 v_0_rtt_remaining)))
 (or v_0_rtt_active $x1808)))
(assert
 true)
(assert
 (let (($x1815 (= v_0_rtt_last_ms (+ v_0_rtt_sample_at_ms (* (- 1) v_0_rtt_start_ms)))))
 (let (($x1813 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1811 (not v_0_rtt_sample_used)))
 (or $x1811 (and $x1813 v_0_rtt_measured $x1815))))))
(assert
 (and (<= 0 v_0_rtt_sample_at_ms) (<= v_0_rtt_sample_at_ms now_0)))
(assert
 (let ((?x1822 (to_real v_0_rtt_last_ms)))
 (let ((?x1836 (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x1822))))
 (let ((?x1824 (+ v_0_rtt_previous_srtt (* (- 1.0) ?x1822))))
 (let ((?x1828 (ite (>= ?x1824 0.0) ?x1824 (+ (* (- 1.0) v_0_rtt_previous_srtt) ?x1822))))
 (let ((?x748 (/ 1.0 4.0)))
 (let ((?x1832 (ite v_0_rtt_previous_measured (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* ?x748 ?x1828)) (* (/ 1.0 2.0) ?x1822))))
 (let (($x1839 (and (= v_0_rttvar_ms ?x1832) (= v_0_srtt_ms (ite v_0_rtt_previous_measured ?x1836 ?x1822)))))
 (let (($x1811 (not v_0_rtt_sample_used)))
 (or $x1811 $x1839))))))))))
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
 (let (($x1975 (and (>= v_0_tx_elapsed v_0_tx_previous_rto) (<= 1 v_0_tx_emit_count) (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x1969 (not v_0_tx_retransmitted)))
 (or $x1969 $x1975))))
(assert
 (let (($x1969 (not v_0_tx_retransmitted)))
 (or $x1969 (not v_0_tx_waiting))))
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
 (let (($x1501 (not v_0_ack_pending)))
 (or $x1501 (and (<= 1 v_0_ack_bytes) (not v_0_rx_fin_done)))))
(assert
 (let (($x2008 (and (= 0 v_0_ack_bytes) (= 0 v_0_ack_full_segments) (= 0 v_0_ack_since_ms))))
 (or v_0_ack_pending $x2008)))
(assert
 (let (($x186 (not active_0_rtx)))
 (let (($x1850 (>= 1 v_0_rtx_buf)))
 (let (($x1717 (not v_0_fin_sent)))
 (let (($x2017 (and (= 0 v_0_snd_wnd) $x1717 (<= 1 (+ v_0_rtx_buf v_0_snd_buf)) $x1850 $x186)))
 (let (($x1528 (not v_0_persist_active)))
 (let (($x2012 (and (<= 1 (+ v_0_rtx_buf (ite v_0_fin_sent 1 0))) $x1528)))
 (let (($x2010 (= v_0_persist_active active_0_persist)))
 (and $x2010 (= active_0_rtx $x2012) (or $x1528 $x2017))))))))))
(assert
 (let (($x1528 (not v_0_persist_active)))
 (or $x1528 (and (not v_0_rtt_active) (= 0 v_0_rtt_remaining)))))
(assert
 (and (<= 1000 v_0_persist_interval_ms) (>= 60000 v_0_persist_interval_ms) (<= 1000 v_0_persist_previous_interval_ms) (>= 60000 v_0_persist_previous_interval_ms) (<= 0 v_0_persist_probes) (<= 0 v_0_persist_elapsed_ms)))
(assert
 (and (<= 0 v_0_persist_since_ms) (<= v_0_persist_since_ms now_0) (<= 0 v_0_persist_last_ms) (<= v_0_persist_last_ms now_0) (<= 0 v_0_persist_deadline_ms)))
(assert
 (let (($x2035 (= 0 v_0_persist_probes)))
 (let ((?x2037 (+ (ite $x2035 v_0_persist_since_ms v_0_persist_last_ms) v_0_persist_interval_ms)))
 (let (($x1528 (not v_0_persist_active)))
 (or $x1528 (= v_0_persist_deadline_ms ?x2037))))))
(assert
 (let (($x2043 (= 1 v_0_rtx_buf)))
 (let (($x2041 (not v_0_persist_probe_sent)))
 (or $x2041 (and (>= v_0_persist_elapsed_ms v_0_persist_previous_interval_ms) $x2043)))))
(assert
 (let (($x2049 (= v_0_tx_time_00 v_0_persist_last_ms)))
 (let (($x2043 (= 1 v_0_rtx_buf)))
 (or (not (and v_0_persist_active (<= 1 v_0_persist_probes) $x2043)) $x2049))))
(assert
 (let (($x2035 (= 0 v_0_persist_probes)))
 (let (($x2054 (and (= 0 v_0_persist_since_ms) (= 0 v_0_persist_last_ms) (= 0 v_0_persist_deadline_ms) $x2035)))
 (or v_0_persist_active $x2054))))
(assert
 (= 157 choice_0))
(assert
 (= 5 state_0))
(assert
 (= 5 state_1))
(assert
 (let (($x2067 (or (not (and v_1_rx_fin_pending (>= 4 v_1_rx_fin_offset))) (= 0 v_1_rx_slot_04))))
(or (not $x2067))))
(check-sat)
