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
(declare-fun v_0_rx_fin_offset () Int)
(declare-fun v_0_rx_fin_pending () Bool)
(declare-fun v_0_rx_fin_done () Bool)
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
(declare-fun v_0_msl_ms () Int)
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
 (let (($x718 (not v_0_rtt_ambiguous)))
 (let ((?x715 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let ((?x291 (mod (+ input_0_net.fin_segment_ack (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x716 (>= ?x291 ?x715)))
 (let ((?x332 (ite v_0_fin_sent 1 0)))
 (let ((?x672 (+ v_0_rtx_buf ?x332)))
 (let (($x673 (<= ?x291 ?x672)))
 (let (($x671 (<= 1 ?x291)))
 (let ((?x278 (- 1)))
 (let ((?x305 (+ ?x278 v_0_local_window)))
 (let (($x310 (<= (mod (+ input_0_net.fin_segment_seq (* ?x278 v_0_rcv_nxt)) 4294967296) ?x305)))
 (let (($x301 (<= 1 v_0_local_window)))
 (let ((?x302 (* ?x278 v_0_rcv_nxt)))
 (let ((?x304 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data ?x302) 4294967296)))
 (let (($x306 (<= ?x304 ?x305)))
 (let (($x312 (or (and $x301 $x306) (and $x301 $x310))))
 (let (($x719 (and v_0_rtt_active $x312 $x671 $x673 $x716 $x718)))
 (let ((?x734 (ite $x719 (+ now_1 (* ?x278 v_0_rtt_start_ms)) v_0_rtt_last_ms)))
 (let ((?x735 (to_real ?x734)))
 (let ((?x759 (/ 1.0 2.0)))
 (let ((?x748 (+ v_0_srtt_ms (* (- 1.0) ?x735))))
 (let ((?x755 (ite $x719 (ite (>= ?x748 0.0) ?x748 (+ (* (- 1.0) v_0_srtt_ms) ?x735)) v_0_rtt_error_ms)))
 (let ((?x746 (/ 1.0 4.0)))
 (let ((?x761 (ite v_0_rtt_measured (+ (* (/ 3.0 4.0) v_0_rttvar_ms) (* ?x746 ?x755)) (* ?x759 ?x735))))
 (let ((?x762 (ite $x719 ?x761 v_0_rttvar_ms)))
 (let ((?x722 (- 1.0)))
 (let ((?x738 (ite v_0_rtt_measured (+ (* (/ 7.0 8.0) v_0_srtt_ms) (* (/ 1.0 8.0) ?x735)) ?x735)))
 (let ((?x739 (ite $x719 ?x738 v_0_srtt_ms)))
 (let ((?x767 (+ (* ?x722 ?x739) (* ?x722 (ite (<= ?x762 ?x746) 1.0 (* 4.0 ?x762))))))
 (let ((?x768 (to_int ?x767)))
 (let ((?x772 (* ?x278 ?x768)))
 (let ((?x773 (ite (<= ?x768 (- 1000)) ?x772 1000)))
 (let ((?x775 (ite (<= 60000 ?x773) 60000 ?x773)))
 (let ((?x777 (ite $x719 ?x775 v_0_rto_ms)))
 (let (($x1502 (not v_0_persist_active)))
 (let ((?x802 (ite (<= 0 v_0_rtx_buf) v_0_rtx_buf 0)))
 (let ((?x800 (ite (<= v_0_rtx_buf ?x291) 0 (+ v_0_rtx_buf (* ?x278 ?x291)))))
 (let (($x674 (and $x312 $x671 $x673)))
 (let ((?x805 (ite $x674 (ite (<= ?x800 ?x802) ?x800 ?x802) v_0_rtx_buf)))
 (let (($x1153 (= 0 ?x805)))
 (let (($x1154 (or v_0_persist_active $x1153)))
 (let (($x1151 (>= 1 ?x805)))
 (let (($x1150 (<= 1 (+ ?x805 v_0_snd_buf))))
 (let (($x1105 (and (not (and $x312 $x671 $x673 v_0_fin_sent (= ?x291 ?x672))) v_0_fin_sent)))
 (let (($x1148 (not $x1105)))
 (let ((?x819 (mod (+ input_0_net.fin_segment_seq (* ?x278 v_0_snd_wl1)) 4294967296)))
 (let (($x814 (<= 2147483648 (mod (+ input_0_net.fin_segment_ack (* ?x278 v_0_snd_wl2)) 4294967296))))
 (let (($x810 (= v_0_snd_wl1 input_0_net.fin_segment_seq)))
 (let (($x825 (or (and $x810 (not $x814)) (and (not (<= ?x819 0)) (not (<= 2147483648 ?x819))))))
 (let (($x826 (and $x312 $x673 $x825)))
 (let ((?x828 (ite $x826 input_0_net.fin_segment_window v_0_snd_wnd)))
 (let (($x1147 (= 0 ?x828)))
 (let (($x1503 (and $x1147 $x1148 $x1150 $x1151 $x1154 $x1502)))
 (let ((?x1515 (ite $x1503 ?x777 v_0_persist_interval_ms)))
 (let ((?x1531 (+ now_1 ?x1515)))
 (let (($x1586 (= due_1_delack due_0_delack)))
 (let (($x1584 (= due_1_time_wait due_0_time_wait)))
 (let (($x1582 (= due_1_user due_0_user)))
 (let ((?x1574 (ite (<= (- 999.0) ?x767) 1000 ?x772)))
 (let (($x1551 (and $x312 $x671 $x673 (<= 1 (+ ?x805 (ite $x1105 1 0))))))
 (let (($x1549 (and (not (and $x312 $x671 $x673 (= 0 (+ ?x805 (ite $x1105 1 0))))) active_0_rtx)))
 (let (($x1155 (and $x1147 $x1148 $x1150 $x1151 $x1154)))
 (let (($x1156 (not $x1155)))
 (let (($x1553 (and $x1156 (or $x1549 $x1551))))
 (let (($x1556 (and v_0_persist_active $x1156 (<= 1 ?x805) (not $x1553))))
 (let ((?x1579 (ite (or $x1551 $x1556) (+ now_1 (ite $x719 (ite (<= 60000 ?x1574) 60000 ?x1574) v_0_rto_ms)) due_0_rtx)))
 (let (($x1568 (= active_1_persist (and $x1147 $x1148 $x1150 $x1151 $x1154 (or active_0_persist $x1503)))))
 (let (($x1564 (not active_1_delack)))
 (let (($x1562 (= active_1_time_wait active_0_time_wait)))
 (let (($x1560 (= active_1_user active_0_user)))
 (let (($x1542 (= v_1_persist_elapsed_ms v_0_persist_elapsed_ms)))
 (let (($x1535 (= v_1_persist_deadline_ms (ite $x1155 (ite $x1503 ?x1531 v_0_persist_deadline_ms) 0))))
 (let (($x1525 (= v_1_persist_since_ms (ite $x1155 (ite $x1503 now_1 v_0_persist_since_ms) 0))))
 (let (($x1520 (= v_1_persist_previous_interval_ms v_0_persist_previous_interval_ms)))
 (let (($x1512 (not v_1_persist_probe_new)))
 (let (($x1510 (not v_1_persist_probe_sent)))
 (let (($x1508 (not v_1_persist_first)))
 (let (($x1506 (= v_1_persist_was_active v_0_persist_active)))
 (let (($x1496 (not v_1_ack_defer_now)))
 (let (($x1494 (not v_1_ack_defer_candidate)))
 (let (($x1492 (= v_1_ack_rmss v_0_ack_rmss)))
 (let (($x1489 (= v_1_ack_delay_ms v_0_ack_delay_ms)))
 (let (($x1486 (= v_1_ack_full_segments 0)))
 (let (($x1484 (= v_1_ack_bytes 0)))
 (let (($x1482 (= v_1_ack_since_ms 0)))
 (let (($x1480 (not v_1_ack_pending)))
 (let (($x1478 (not v_1_syn_timeout_eligible)))
 (let (($x1476 (not v_1_tx_syn_pending)))
 (let (($x1474 (= v_1_tx_syn_time 0)))
 (let (($x1472 (not v_1_tx_waiting)))
 (let (($x1470 (= v_1_tx_is_fin v_0_tx_is_fin)))
 (let (($x1467 (= v_1_tx_previous_rto v_0_tx_previous_rto)))
 (let (($x1464 (= v_1_tx_elapsed v_0_tx_elapsed)))
 (let (($x1461 (not v_1_tx_retransmitted)))
 (let (($x1459 (= v_1_tx_max_previous v_0_tx_max_previous)))
 (let (($x1456 (= v_1_tx_eligible v_0_tx_eligible)))
 (let (($x1453 (= v_1_tx_emit_count v_0_tx_emit_count)))
 (let ((?x1445 (ite (or $x1153 (and $x312 $x671 $x673 (not (= 0 ?x291))) (>= 15 ?x805)) 0 v_0_tx_time_15)))
 (let (($x1204 (and $x312 $x671 $x673 (not (= 0 ?x291)))))
 (let ((?x1440 (ite (or $x1153 (>= 14 ?x805)) 0 (ite $x1204 (ite (= 1 ?x291) v_0_tx_time_15 0) v_0_tx_time_14))))
 (let (($x1205 (= 1 ?x291)))
 (let ((?x1432 (ite $x1204 (ite $x1205 v_0_tx_time_14 (ite (= 2 ?x291) v_0_tx_time_15 0)) v_0_tx_time_13)))
 (let (($x1207 (= 2 ?x291)))
 (let ((?x1423 (ite $x1205 v_0_tx_time_13 (ite $x1207 v_0_tx_time_14 (ite (= 3 ?x291) v_0_tx_time_15 0)))))
 (let (($x1426 (= v_1_tx_time_12 (ite (or $x1153 (>= 12 ?x805)) 0 (ite $x1204 ?x1423 v_0_tx_time_12)))))
 (let (($x1209 (= 3 ?x291)))
 (let ((?x1413 (ite $x1207 v_0_tx_time_13 (ite $x1209 v_0_tx_time_14 (ite (= 4 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1416 (ite (or $x1153 (>= 11 ?x805)) 0 (ite $x1204 (ite $x1205 v_0_tx_time_12 ?x1413) v_0_tx_time_11))))
 (let (($x1211 (= 4 ?x291)))
 (let ((?x1402 (ite $x1209 v_0_tx_time_13 (ite $x1211 v_0_tx_time_14 (ite (= 5 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1405 (ite $x1204 (ite $x1205 v_0_tx_time_11 (ite $x1207 v_0_tx_time_12 ?x1402)) v_0_tx_time_10)))
 (let (($x1213 (= 5 ?x291)))
 (let ((?x1390 (ite $x1211 v_0_tx_time_13 (ite $x1213 v_0_tx_time_14 (ite (= 6 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1393 (ite $x1205 v_0_tx_time_10 (ite $x1207 v_0_tx_time_11 (ite $x1209 v_0_tx_time_12 ?x1390)))))
 (let (($x1396 (= v_1_tx_time_09 (ite (or (>= 9 ?x805) $x1153) 0 (ite $x1204 ?x1393 v_0_tx_time_09)))))
 (let (($x1215 (= 6 ?x291)))
 (let ((?x1377 (ite $x1213 v_0_tx_time_13 (ite $x1215 v_0_tx_time_14 (ite (= 7 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1380 (ite $x1207 v_0_tx_time_10 (ite $x1209 v_0_tx_time_11 (ite $x1211 v_0_tx_time_12 ?x1377)))))
 (let ((?x1383 (ite (or $x1153 (>= 8 ?x805)) 0 (ite $x1204 (ite $x1205 v_0_tx_time_09 ?x1380) v_0_tx_time_08))))
 (let (($x1217 (= 7 ?x291)))
 (let ((?x1363 (ite $x1215 v_0_tx_time_13 (ite $x1217 v_0_tx_time_14 (ite (= 8 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1366 (ite $x1209 v_0_tx_time_10 (ite $x1211 v_0_tx_time_11 (ite $x1213 v_0_tx_time_12 ?x1363)))))
 (let ((?x1369 (ite $x1204 (ite $x1205 v_0_tx_time_08 (ite $x1207 v_0_tx_time_09 ?x1366)) v_0_tx_time_07)))
 (let (($x1219 (= 8 ?x291)))
 (let ((?x1348 (ite $x1217 v_0_tx_time_13 (ite $x1219 v_0_tx_time_14 (ite (= 9 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1351 (ite $x1211 v_0_tx_time_10 (ite $x1213 v_0_tx_time_11 (ite $x1215 v_0_tx_time_12 ?x1348)))))
 (let ((?x1354 (ite $x1205 v_0_tx_time_07 (ite $x1207 v_0_tx_time_08 (ite $x1209 v_0_tx_time_09 ?x1351)))))
 (let (($x1357 (= v_1_tx_time_06 (ite (or $x1153 (>= 6 ?x805)) 0 (ite $x1204 ?x1354 v_0_tx_time_06)))))
 (let (($x1221 (= 9 ?x291)))
 (let ((?x1332 (ite $x1219 v_0_tx_time_13 (ite $x1221 v_0_tx_time_14 (ite (= 10 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1335 (ite $x1213 v_0_tx_time_10 (ite $x1215 v_0_tx_time_11 (ite $x1217 v_0_tx_time_12 ?x1332)))))
 (let ((?x1338 (ite $x1207 v_0_tx_time_07 (ite $x1209 v_0_tx_time_08 (ite $x1211 v_0_tx_time_09 ?x1335)))))
 (let ((?x1341 (ite (or $x1153 (>= 5 ?x805)) 0 (ite $x1204 (ite $x1205 v_0_tx_time_06 ?x1338) v_0_tx_time_05))))
 (let (($x1223 (= 10 ?x291)))
 (let ((?x1315 (ite $x1221 v_0_tx_time_13 (ite $x1223 v_0_tx_time_14 (ite (= 11 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1318 (ite $x1215 v_0_tx_time_10 (ite $x1217 v_0_tx_time_11 (ite $x1219 v_0_tx_time_12 ?x1315)))))
 (let ((?x1321 (ite $x1209 v_0_tx_time_07 (ite $x1211 v_0_tx_time_08 (ite $x1213 v_0_tx_time_09 ?x1318)))))
 (let ((?x1324 (ite $x1204 (ite $x1205 v_0_tx_time_05 (ite $x1207 v_0_tx_time_06 ?x1321)) v_0_tx_time_04)))
 (let (($x1225 (= 11 ?x291)))
 (let ((?x1297 (ite $x1223 v_0_tx_time_13 (ite $x1225 v_0_tx_time_14 (ite (= 12 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1300 (ite $x1217 v_0_tx_time_10 (ite $x1219 v_0_tx_time_11 (ite $x1221 v_0_tx_time_12 ?x1297)))))
 (let ((?x1303 (ite $x1211 v_0_tx_time_07 (ite $x1213 v_0_tx_time_08 (ite $x1215 v_0_tx_time_09 ?x1300)))))
 (let ((?x1306 (ite $x1205 v_0_tx_time_04 (ite $x1207 v_0_tx_time_05 (ite $x1209 v_0_tx_time_06 ?x1303)))))
 (let (($x1309 (= v_1_tx_time_03 (ite (or $x1153 (>= 3 ?x805)) 0 (ite $x1204 ?x1306 v_0_tx_time_03)))))
 (let (($x1227 (= 12 ?x291)))
 (let ((?x1278 (ite $x1225 v_0_tx_time_13 (ite $x1227 v_0_tx_time_14 (ite (= 13 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1281 (ite $x1219 v_0_tx_time_10 (ite $x1221 v_0_tx_time_11 (ite $x1223 v_0_tx_time_12 ?x1278)))))
 (let ((?x1284 (ite $x1213 v_0_tx_time_07 (ite $x1215 v_0_tx_time_08 (ite $x1217 v_0_tx_time_09 ?x1281)))))
 (let ((?x1287 (ite $x1207 v_0_tx_time_04 (ite $x1209 v_0_tx_time_05 (ite $x1211 v_0_tx_time_06 ?x1284)))))
 (let ((?x1290 (ite (or (>= 2 ?x805) $x1153) 0 (ite $x1204 (ite $x1205 v_0_tx_time_03 ?x1287) v_0_tx_time_02))))
 (let (($x1229 (= 13 ?x291)))
 (let ((?x1258 (ite $x1227 v_0_tx_time_13 (ite $x1229 v_0_tx_time_14 (ite (= 14 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1261 (ite $x1221 v_0_tx_time_10 (ite $x1223 v_0_tx_time_11 (ite $x1225 v_0_tx_time_12 ?x1258)))))
 (let ((?x1264 (ite $x1215 v_0_tx_time_07 (ite $x1217 v_0_tx_time_08 (ite $x1219 v_0_tx_time_09 ?x1261)))))
 (let ((?x1267 (ite $x1209 v_0_tx_time_04 (ite $x1211 v_0_tx_time_05 (ite $x1213 v_0_tx_time_06 ?x1264)))))
 (let ((?x1270 (ite $x1204 (ite $x1205 v_0_tx_time_02 (ite $x1207 v_0_tx_time_03 ?x1267)) v_0_tx_time_01)))
 (let (($x1231 (= 14 ?x291)))
 (let ((?x1237 (ite $x1229 v_0_tx_time_13 (ite $x1231 v_0_tx_time_14 (ite (= 15 ?x291) v_0_tx_time_15 0)))))
 (let ((?x1240 (ite $x1223 v_0_tx_time_10 (ite $x1225 v_0_tx_time_11 (ite $x1227 v_0_tx_time_12 ?x1237)))))
 (let ((?x1243 (ite $x1217 v_0_tx_time_07 (ite $x1219 v_0_tx_time_08 (ite $x1221 v_0_tx_time_09 ?x1240)))))
 (let ((?x1246 (ite $x1211 v_0_tx_time_04 (ite $x1213 v_0_tx_time_05 (ite $x1215 v_0_tx_time_06 ?x1243)))))
 (let ((?x1249 (ite $x1205 v_0_tx_time_01 (ite $x1207 v_0_tx_time_02 (ite $x1209 v_0_tx_time_03 ?x1246)))))
 (let (($x1253 (= v_1_tx_time_00 (ite (or (>= 0 ?x805) $x1153) 0 (ite $x1204 ?x1249 v_0_tx_time_00)))))
 (let (($x1187 (= v_1_rtt_sample_was_ambiguous (and v_0_rtt_active v_0_rtt_ambiguous))))
 (let (($x1182 (not v_1_rtt_start_new)))
 (let ((?x798 (* ?x278 ?x291)))
 (let ((?x1174 (+ ?x715 ?x798)))
 (let (($x1177 (and v_0_rtt_active $x312 $x671 $x673 (not (<= v_0_rtt_remaining ?x1174)))))
 (let ((?x1179 (ite (or $x1155 (and v_0_rtt_active $x312 $x671 $x673 $x716)) 0 (ite $x1177 ?x1174 v_0_rtt_remaining))))
 (let (($x1170 (= v_1_rtt_end v_0_rtt_end)))
 (let (($x1169 (= v_1_rtt_start_ms v_0_rtt_start_ms)))
 (let (($x1157 (and v_0_rtt_active $x312 $x671 $x673 $x716)))
 (let (($x1158 (not $x1157)))
 (let (($x1145 (= v_1_rtt_previous_measured (ite $x719 v_0_rtt_measured v_0_rtt_previous_measured))))
 (let (($x1138 (= v_1_rtt_previous_var (ite $x719 v_0_rttvar_ms v_0_rtt_previous_var))))
 (let (($x1134 (= v_1_rtt_previous_srtt (ite $x719 v_0_srtt_ms v_0_rtt_previous_srtt))))
 (let (($x341 (not v_0_rx_fin_pending)))
 (let (($x340 (not v_0_rx_fin_done)))
 (let (($x337 (and (>= ?x291 (+ 1 v_0_rtx_buf ?x332)) (>= 2147483647 ?x291))))
 (let (($x338 (not $x337)))
 (let (($x342 (and $x312 $x338 $x340 $x341 $x301 $x306)))
 (let ((?x345 (ite $x342 ?x304 v_0_rx_fin_offset)))
 (let (($x343 (or v_0_rx_fin_pending $x342)))
 (let (($x645 (and $x343 (>= 15 ?x345))))
 (let ((?x632 (mod (+ 15 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x637 (+ input_0_net.fin_segment_data (* ?x278 ?x632))))
 (let (($x635 (<= input_0_net.fin_segment_data ?x632)))
 (let (($x630 (<= v_0_rcv_buf 0)))
 (let (($x629 (= 0 v_0_rx_slot_15)))
 (let (($x634 (and $x312 $x338 $x340 $x629 $x630 (<= ?x632 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x642 (ite $x634 (ite (or $x635 (<= ?x637 1)) (ite $x635 0 ?x637) 1) v_0_rx_slot_15)))
 (let (($x646 (or (= ?x642 0) $x645)))
 (let (($x627 (and $x343 (>= 14 ?x345))))
 (let ((?x614 (mod (+ 14 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x619 (+ input_0_net.fin_segment_data (* ?x278 ?x614))))
 (let (($x617 (<= input_0_net.fin_segment_data ?x614)))
 (let (($x612 (<= v_0_rcv_buf 1)))
 (let (($x611 (= 0 v_0_rx_slot_14)))
 (let (($x616 (and $x312 $x338 $x340 $x611 $x612 (<= ?x614 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x624 (ite $x616 (ite (or $x617 (<= ?x619 1)) (ite $x617 0 ?x619) 1) v_0_rx_slot_14)))
 (let (($x628 (or (= ?x624 0) $x627)))
 (let (($x609 (and $x343 (>= 13 ?x345))))
 (let ((?x596 (mod (+ 13 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x601 (+ input_0_net.fin_segment_data (* ?x278 ?x596))))
 (let (($x599 (<= input_0_net.fin_segment_data ?x596)))
 (let (($x594 (<= v_0_rcv_buf 2)))
 (let (($x593 (= 0 v_0_rx_slot_13)))
 (let (($x598 (and $x312 $x338 $x340 $x593 $x594 (<= ?x596 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x606 (ite $x598 (ite (or $x599 (<= ?x601 1)) (ite $x599 0 ?x601) 1) v_0_rx_slot_13)))
 (let (($x610 (or (= ?x606 0) $x609)))
 (let (($x591 (and $x343 (>= 12 ?x345))))
 (let ((?x578 (mod (+ 12 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x583 (+ input_0_net.fin_segment_data (* ?x278 ?x578))))
 (let (($x581 (<= input_0_net.fin_segment_data ?x578)))
 (let (($x576 (<= v_0_rcv_buf 3)))
 (let (($x575 (= 0 v_0_rx_slot_12)))
 (let (($x580 (and $x312 $x338 $x340 $x575 $x576 (<= ?x578 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x588 (ite $x580 (ite (or $x581 (<= ?x583 1)) (ite $x581 0 ?x583) 1) v_0_rx_slot_12)))
 (let (($x592 (or (= ?x588 0) $x591)))
 (let ((?x650 (ite $x592 12 (ite $x610 13 (ite $x628 14 (ite $x646 15 16))))))
 (let (($x573 (and $x343 (>= 11 ?x345))))
 (let ((?x560 (mod (+ 11 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x565 (+ input_0_net.fin_segment_data (* ?x278 ?x560))))
 (let (($x563 (<= input_0_net.fin_segment_data ?x560)))
 (let (($x558 (<= v_0_rcv_buf 4)))
 (let (($x557 (= 0 v_0_rx_slot_11)))
 (let (($x562 (and $x312 $x338 $x340 $x557 $x558 (<= ?x560 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x570 (ite $x562 (ite (or $x563 (<= ?x565 1)) (ite $x563 0 ?x565) 1) v_0_rx_slot_11)))
 (let (($x574 (or (= ?x570 0) $x573)))
 (let (($x555 (and $x343 (>= 10 ?x345))))
 (let ((?x542 (mod (+ 10 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x547 (+ input_0_net.fin_segment_data (* ?x278 ?x542))))
 (let (($x545 (<= input_0_net.fin_segment_data ?x542)))
 (let (($x540 (<= v_0_rcv_buf 5)))
 (let (($x539 (= 0 v_0_rx_slot_10)))
 (let (($x544 (and $x312 $x338 $x340 $x539 $x540 (<= ?x542 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x552 (ite $x544 (ite (or $x545 (<= ?x547 1)) (ite $x545 0 ?x547) 1) v_0_rx_slot_10)))
 (let (($x556 (or (= ?x552 0) $x555)))
 (let (($x537 (and $x343 (>= 9 ?x345))))
 (let ((?x524 (mod (+ 9 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x529 (+ input_0_net.fin_segment_data (* ?x278 ?x524))))
 (let (($x527 (<= input_0_net.fin_segment_data ?x524)))
 (let (($x522 (<= v_0_rcv_buf 6)))
 (let (($x521 (= 0 v_0_rx_slot_09)))
 (let (($x526 (and $x312 $x338 $x340 $x521 $x522 (<= ?x524 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x534 (ite $x526 (ite (or $x527 (<= ?x529 1)) (ite $x527 0 ?x529) 1) v_0_rx_slot_09)))
 (let (($x538 (or (= ?x534 0) $x537)))
 (let (($x519 (and $x343 (>= 8 ?x345))))
 (let ((?x506 (mod (+ 8 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x511 (+ input_0_net.fin_segment_data (* ?x278 ?x506))))
 (let (($x509 (<= input_0_net.fin_segment_data ?x506)))
 (let (($x504 (<= v_0_rcv_buf 7)))
 (let (($x503 (= 0 v_0_rx_slot_08)))
 (let (($x508 (and $x312 $x338 $x340 $x503 $x504 (<= ?x506 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x516 (ite $x508 (ite (or $x509 (<= ?x511 1)) (ite $x509 0 ?x511) 1) v_0_rx_slot_08)))
 (let (($x520 (or (= ?x516 0) $x519)))
 (let ((?x654 (ite $x520 8 (ite $x538 9 (ite $x556 10 (ite $x574 11 ?x650))))))
 (let (($x501 (and $x343 (>= 7 ?x345))))
 (let ((?x488 (mod (+ 7 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x493 (+ input_0_net.fin_segment_data (* ?x278 ?x488))))
 (let (($x491 (<= input_0_net.fin_segment_data ?x488)))
 (let (($x485 (<= v_0_rcv_buf 8)))
 (let (($x483 (= 0 v_0_rx_slot_07)))
 (let (($x490 (and $x312 $x338 $x340 $x483 $x485 (<= ?x488 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x498 (ite $x490 (ite (or $x491 (<= ?x493 1)) (ite $x491 0 ?x493) 1) v_0_rx_slot_07)))
 (let (($x502 (or (= ?x498 0) $x501)))
 (let (($x481 (and $x343 (>= 6 ?x345))))
 (let ((?x468 (mod (+ 6 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x473 (+ input_0_net.fin_segment_data (* ?x278 ?x468))))
 (let (($x471 (<= input_0_net.fin_segment_data ?x468)))
 (let (($x465 (<= v_0_rcv_buf 9)))
 (let (($x463 (= 0 v_0_rx_slot_06)))
 (let (($x470 (and $x312 $x338 $x340 $x463 $x465 (<= ?x468 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x478 (ite $x470 (ite (or $x471 (<= ?x473 1)) (ite $x471 0 ?x473) 1) v_0_rx_slot_06)))
 (let (($x482 (or (= ?x478 0) $x481)))
 (let (($x461 (and $x343 (>= 5 ?x345))))
 (let ((?x448 (mod (+ 5 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x453 (+ input_0_net.fin_segment_data (* ?x278 ?x448))))
 (let (($x451 (<= input_0_net.fin_segment_data ?x448)))
 (let (($x445 (<= v_0_rcv_buf 10)))
 (let (($x443 (= 0 v_0_rx_slot_05)))
 (let (($x450 (and $x312 $x338 $x340 $x443 $x445 (<= ?x448 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x458 (ite $x450 (ite (or $x451 (<= ?x453 1)) (ite $x451 0 ?x453) 1) v_0_rx_slot_05)))
 (let (($x462 (or (= ?x458 0) $x461)))
 (let (($x441 (and $x343 (>= 4 ?x345))))
 (let ((?x428 (mod (+ 4 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x433 (+ input_0_net.fin_segment_data (* ?x278 ?x428))))
 (let (($x431 (<= input_0_net.fin_segment_data ?x428)))
 (let (($x425 (<= v_0_rcv_buf 11)))
 (let (($x423 (= 0 v_0_rx_slot_04)))
 (let (($x430 (and $x312 $x338 $x340 $x423 $x425 (<= ?x428 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x438 (ite $x430 (ite (or $x431 (<= ?x433 1)) (ite $x431 0 ?x433) 1) v_0_rx_slot_04)))
 (let (($x442 (or (= ?x438 0) $x441)))
 (let ((?x658 (ite $x442 4 (ite $x462 5 (ite $x482 6 (ite $x502 7 ?x654))))))
 (let (($x421 (and $x343 (>= 3 ?x345))))
 (let ((?x408 (mod (+ 3 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x413 (+ input_0_net.fin_segment_data (* ?x278 ?x408))))
 (let (($x411 (<= input_0_net.fin_segment_data ?x408)))
 (let (($x405 (<= v_0_rcv_buf 12)))
 (let (($x403 (= 0 v_0_rx_slot_03)))
 (let (($x410 (and $x312 $x338 $x340 $x403 $x405 (<= ?x408 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x418 (ite $x410 (ite (or $x411 (<= ?x413 1)) (ite $x411 0 ?x413) 1) v_0_rx_slot_03)))
 (let (($x422 (or (= ?x418 0) $x421)))
 (let (($x401 (and $x343 (>= 2 ?x345))))
 (let ((?x388 (mod (+ 2 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x393 (+ input_0_net.fin_segment_data (* ?x278 ?x388))))
 (let (($x391 (<= input_0_net.fin_segment_data ?x388)))
 (let (($x385 (<= v_0_rcv_buf 13)))
 (let (($x383 (= 0 v_0_rx_slot_02)))
 (let (($x390 (and $x312 $x338 $x340 $x383 $x385 (<= ?x388 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x398 (ite $x390 (ite (or $x391 (<= ?x393 1)) (ite $x391 0 ?x393) 1) v_0_rx_slot_02)))
 (let (($x402 (or (= ?x398 0) $x401)))
 (let (($x381 (and $x343 (>= 1 ?x345))))
 (let ((?x368 (mod (+ 1 v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x373 (+ input_0_net.fin_segment_data (* ?x278 ?x368))))
 (let (($x371 (<= input_0_net.fin_segment_data ?x368)))
 (let (($x366 (<= v_0_rcv_buf 14)))
 (let (($x364 (= 0 v_0_rx_slot_01)))
 (let (($x370 (and $x312 $x338 $x340 $x364 $x366 (<= ?x368 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x378 (ite $x370 (ite (or $x371 (<= ?x373 1)) (ite $x371 0 ?x373) 1) v_0_rx_slot_01)))
 (let (($x379 (= ?x378 0)))
 (let (($x382 (or $x379 $x381)))
 (let ((?x661 (ite $x382 1 (ite $x402 2 (ite $x422 3 ?x658)))))
 (let (($x362 (and $x343 (>= 0 ?x345))))
 (let ((?x281 (mod (+ v_0_rcv_nxt (* ?x278 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x354 (+ input_0_net.fin_segment_data (* ?x278 ?x281))))
 (let (($x352 (<= input_0_net.fin_segment_data ?x281)))
 (let (($x348 (<= v_0_rcv_buf 15)))
 (let (($x346 (= 0 v_0_rx_slot_00)))
 (let (($x351 (and $x312 $x338 $x340 $x346 $x348 (<= ?x281 (+ ?x278 input_0_net.fin_segment_data)))))
 (let ((?x359 (ite $x351 (ite (or $x352 (<= ?x354 1)) (ite $x352 0 ?x354) 1) v_0_rx_slot_00)))
 (let (($x363 (or (= ?x359 0) $x362)))
 (let ((?x662 (ite $x363 0 ?x661)))
 (let ((?x665 (ite $x343 (+ ?x345 (* ?x278 ?x662)) ?x345)))
 (let (($x667 (and $x343 $x340 (= 0 ?x665))))
 (let ((?x1114 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data) 4294967296)))
 (let (($x1103 (and $x312 $x671 $x673 v_0_fin_sent (= ?x291 ?x672))))
 (let (($x1107 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x1100 (= v_1_fin_requested v_0_fin_requested)))
 (let (($x1079 (= v_1_rx_slot_15 (ite (or $x667 (not (and $x363 (not $x645)))) 0 ?x642))))
 (let (($x894 (not $x645)))
 (let (($x698 (not $x363)))
 (let (($x863 (not $x402)))
 (let (($x861 (not $x422)))
 (let (($x859 (not $x442)))
 (let (($x857 (not $x462)))
 (let (($x855 (not $x482)))
 (let (($x853 (not $x502)))
 (let (($x851 (not $x520)))
 (let (($x849 (not $x538)))
 (let (($x847 (not $x556)))
 (let (($x845 (not $x574)))
 (let (($x843 (not $x592)))
 (let (($x841 (not $x610)))
 (let (($x839 (not $x628)))
 (let (($x838 (and false $x646)))
 (let (($x840 (and $x838 $x839)))
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
 (let (($x865 (or (and $x862 $x863) $x379 $x381)))
 (let ((?x692 (ite $x627 0 ?x624)))
 (let (($x1074 (= v_1_rx_slot_14 (ite $x667 0 (ite $x363 ?x692 (ite (and $x865 $x698 $x894) ?x642 0))))))
 (let (($x866 (and $x865 $x698)))
 (let ((?x1066 (ite $x866 ?x692 (ite (and (or $x862 $x402) (not $x382) $x698 $x894) ?x642 0))))
 (let ((?x691 (ite $x609 0 ?x606)))
 (let (($x868 (not $x382)))
 (let (($x867 (or $x862 $x402)))
 (let (($x869 (and $x867 $x868 $x698)))
 (let ((?x1059 (ite $x869 ?x692 (ite (and (or $x860 $x422) $x863 $x868 $x698 $x894) ?x642 0))))
 (let ((?x690 (ite $x591 0 ?x588)))
 (let (($x1063 (= v_1_rx_slot_12 (ite $x667 0 (ite $x363 ?x690 (ite $x866 ?x691 ?x1059))))))
 (let (($x870 (or $x860 $x422)))
 (let (($x871 (and $x870 $x863 $x868 $x698)))
 (let ((?x1051 (ite $x871 ?x692 (ite (and (or $x858 $x442) $x861 $x863 $x868 $x698 $x894) ?x642 0))))
 (let ((?x689 (ite $x573 0 ?x570)))
 (let (($x1056 (= v_1_rx_slot_11 (ite $x667 0 (ite $x363 ?x689 (ite $x866 ?x690 (ite $x869 ?x691 ?x1051)))))))
 (let (($x872 (or $x858 $x442)))
 (let (($x873 (and $x872 $x861 $x863 $x868 $x698)))
 (let ((?x1042 (ite $x873 ?x692 (ite (and (or $x856 $x462) $x859 $x861 $x863 $x868 $x698 $x894) ?x642 0))))
 (let ((?x688 (ite $x555 0 ?x552)))
 (let ((?x1047 (ite $x667 0 (ite $x363 ?x688 (ite $x866 ?x689 (ite $x869 ?x690 (ite $x871 ?x691 ?x1042)))))))
 (let ((?x1031 (ite (and (or $x854 $x482) $x857 $x859 $x861 $x863 $x868 $x698 $x894) ?x642 0)))
 (let (($x874 (or $x856 $x462)))
 (let (($x875 (and $x874 $x859 $x861 $x863 $x868 $x698)))
 (let ((?x1036 (ite $x866 ?x688 (ite $x869 ?x689 (ite $x871 ?x690 (ite $x873 ?x691 (ite $x875 ?x692 ?x1031)))))))
 (let ((?x687 (ite $x537 0 ?x534)))
 (let ((?x1020 (ite (and (or $x852 $x502) $x855 $x857 $x859 $x861 $x863 $x868 $x698 $x894) ?x642 0)))
 (let (($x876 (or $x854 $x482)))
 (let (($x877 (and $x876 $x857 $x859 $x861 $x863 $x868 $x698)))
 (let ((?x1025 (ite $x869 ?x688 (ite $x871 ?x689 (ite $x873 ?x690 (ite $x875 ?x691 (ite $x877 ?x692 ?x1020)))))))
 (let ((?x686 (ite $x519 0 ?x516)))
 (let (($x1029 (= v_1_rx_slot_08 (ite $x667 0 (ite $x363 ?x686 (ite $x866 ?x687 ?x1025))))))
 (let ((?x1008 (ite (and (or $x850 $x520) $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x698 $x894) ?x642 0)))
 (let (($x878 (or $x852 $x502)))
 (let (($x879 (and $x878 $x855 $x857 $x859 $x861 $x863 $x868 $x698)))
 (let ((?x1013 (ite $x871 ?x688 (ite $x873 ?x689 (ite $x875 ?x690 (ite $x877 ?x691 (ite $x879 ?x692 ?x1008)))))))
 (let ((?x685 (ite $x501 0 ?x498)))
 (let (($x1018 (= v_1_rx_slot_07 (ite $x667 0 (ite $x363 ?x685 (ite $x866 ?x686 (ite $x869 ?x687 ?x1013)))))))
 (let (($x882 (or $x848 $x538)))
 (let ((?x995 (ite (and $x882 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x698 $x894) ?x642 0)))
 (let (($x880 (or $x850 $x520)))
 (let (($x881 (and $x880 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x698)))
 (let ((?x1000 (ite $x873 ?x688 (ite $x875 ?x689 (ite $x877 ?x690 (ite $x879 ?x691 (ite $x881 ?x692 ?x995)))))))
 (let ((?x684 (ite $x481 0 ?x478)))
 (let ((?x1005 (ite $x667 0 (ite $x363 ?x684 (ite $x866 ?x685 (ite $x869 ?x686 (ite $x871 ?x687 ?x1000)))))))
 (let (($x884 (or $x846 $x556)))
 (let ((?x981 (ite (and $x884 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x698 $x894) ?x642 0)))
 (let (($x883 (and $x882 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x698)))
 (let ((?x986 (ite $x875 ?x688 (ite $x877 ?x689 (ite $x879 ?x690 (ite $x881 ?x691 (ite $x883 ?x692 ?x981)))))))
 (let ((?x683 (ite $x461 0 ?x458)))
 (let ((?x991 (ite $x363 ?x683 (ite $x866 ?x684 (ite $x869 ?x685 (ite $x871 ?x686 (ite $x873 ?x687 ?x986)))))))
 (let (($x886 (or $x844 $x574)))
 (let (($x965 (and $x886 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x698 $x894)))
 (let (($x885 (and $x884 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x698)))
 (let ((?x970 (ite $x879 ?x689 (ite $x881 ?x690 (ite $x883 ?x691 (ite $x885 ?x692 (ite $x965 ?x642 0)))))))
 (let ((?x975 (ite $x869 ?x684 (ite $x871 ?x685 (ite $x873 ?x686 (ite $x875 ?x687 (ite $x877 ?x688 ?x970)))))))
 (let ((?x682 (ite $x441 0 ?x438)))
 (let (($x979 (= v_1_rx_slot_04 (ite $x667 0 (ite $x363 ?x682 (ite $x866 ?x683 ?x975))))))
 (let (($x888 (or $x842 $x592)))
 (let (($x949 (and $x888 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x698 $x894)))
 (let (($x887 (and $x886 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x698)))
 (let ((?x954 (ite $x881 ?x689 (ite $x883 ?x690 (ite $x885 ?x691 (ite $x887 ?x692 (ite $x949 ?x642 0)))))))
 (let ((?x959 (ite $x871 ?x684 (ite $x873 ?x685 (ite $x875 ?x686 (ite $x877 ?x687 (ite $x879 ?x688 ?x954)))))))
 (let ((?x681 (ite $x421 0 ?x418)))
 (let (($x964 (= v_1_rx_slot_03 (ite $x667 0 (ite $x363 ?x681 (ite $x866 ?x682 (ite $x869 ?x683 ?x959)))))))
 (let (($x890 (or $x840 $x610)))
 (let (($x932 (and $x890 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x698 $x894)))
 (let (($x889 (and $x888 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x698)))
 (let ((?x937 (ite $x883 ?x689 (ite $x885 ?x690 (ite $x887 ?x691 (ite $x889 ?x692 (ite $x932 ?x642 0)))))))
 (let ((?x942 (ite $x873 ?x684 (ite $x875 ?x685 (ite $x877 ?x686 (ite $x879 ?x687 (ite $x881 ?x688 ?x937)))))))
 (let ((?x680 (ite $x401 0 ?x398)))
 (let ((?x947 (ite $x667 0 (ite $x363 ?x680 (ite $x866 ?x681 (ite $x869 ?x682 (ite $x871 ?x683 ?x942)))))))
 (let (($x892 (or $x838 $x628)))
 (let (($x914 (and $x892 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x698 $x894)))
 (let (($x891 (and $x890 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x698)))
 (let ((?x919 (ite $x885 ?x689 (ite $x887 ?x690 (ite $x889 ?x691 (ite $x891 ?x692 (ite $x914 ?x642 0)))))))
 (let ((?x924 (ite $x875 ?x684 (ite $x877 ?x685 (ite $x879 ?x686 (ite $x881 ?x687 (ite $x883 ?x688 ?x919)))))))
 (let ((?x679 (ite $x381 0 ?x378)))
 (let ((?x929 (ite $x363 ?x679 (ite $x866 ?x680 (ite $x869 ?x681 (ite $x871 ?x682 (ite $x873 ?x683 ?x924)))))))
 (let (($x895 (and $x646 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x698 $x894)))
 (let (($x893 (and $x892 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x698)))
 (let ((?x900 (ite $x887 ?x689 (ite $x889 ?x690 (ite $x891 ?x691 (ite $x893 ?x692 (ite $x895 ?x642 0)))))))
 (let ((?x905 (ite $x877 ?x684 (ite $x879 ?x685 (ite $x881 ?x686 (ite $x883 ?x687 (ite $x885 ?x688 ?x900)))))))
 (let ((?x910 (ite $x866 ?x679 (ite $x869 ?x680 (ite $x871 ?x681 (ite $x873 ?x682 (ite $x875 ?x683 ?x905)))))))
 (let ((?x678 (ite $x362 0 ?x359)))
 (let ((?x700 (ite (and (<= 0 ?x662) $x698) ?x661 0)))
 (let ((?x694 (+ ?x678 ?x679 ?x680 ?x681 ?x682 ?x683 ?x684 ?x685 ?x686 ?x687 ?x688 ?x689 ?x690 ?x691 ?x692 (ite $x645 0 ?x642))))
 (let ((?x696 (ite (<= ?x694 0) 0 ?x694)))
 (let ((?x702 (ite (<= ?x696 ?x700) ?x696 ?x700)))
 (let (($x836 (= v_1_take v_0_take)))
 (let (($x796 (= v_1_snd_buf v_0_snd_buf)))
 (let (($x790 (= v_1_msl_ms v_0_msl_ms)))
 (let (($x787 (= v_1_user_timeout_ms v_0_user_timeout_ms)))
 (let (($x784 (= v_1_active_open v_0_active_open)))
 (let (($x781 (= v_1_retries v_0_retries)))
 (let (($x711 (= v_1_tx_flags v_0_tx_flags)))
 (let (($x708 (= v_1_tx_ack v_0_tx_ack)))
 (let (($x707 (= v_1_tx_seq v_0_tx_seq)))
 (let (($x706 (= v_1_rcv_nxt (mod (+ v_0_rcv_nxt ?x702 (ite $x667 1 0)) 4294967296))))
 (let (($x677 (= v_1_snd_nxt v_0_snd_nxt)))
 (let (($x670 (= v_1_irs v_0_irs)))
 (let (($x669 (= v_1_iss v_0_iss)))
 (let (($x668 (not $x667)))
 (let (($x297 (= (mod (+ input_0_net.fin_segment_ack (* ?x278 v_0_snd_nxt)) 4294967296) 2147483648)))
 (and (>= now_1 now_0) (<= 0 input_0_net.fin_segment_data) (>= 16 input_0_net.fin_segment_data) (not (= ?x281 2147483648)) (<= 0 input_0_net.fin_segment_window) (>= 65535 input_0_net.fin_segment_window) (or (and (not (= ?x291 2147483648)) (not $x297)) (not $x312)) (or (not active_0_rtx) (not (<= due_0_rtx now_1))) (or (not active_0_user) (not (<= due_0_user now_1))) (or (not active_0_time_wait) (not (<= due_0_time_wait now_1))) (or (not active_0_delack) (not (<= due_0_delack now_1))) (or (not active_0_persist) (not (<= due_0_persist now_1))) $x668 $x669 $x670 (= v_1_snd_una (ite $x674 input_0_net.fin_segment_ack v_0_snd_una)) $x677 $x706 $x707 $x708 $x711 (= v_1_rto_ms ?x777) $x781 $x784 $x787 $x790 (= v_1_local_window (+ 16 (* ?x278 v_0_rcv_buf) (* ?x278 ?x702))) $x796 (= v_1_rtx_buf ?x805) (= v_1_rcv_buf (+ v_0_rcv_buf ?x702)) (= v_1_snd_wnd ?x828) (= v_1_snd_wl1 (ite $x826 input_0_net.fin_segment_seq v_0_snd_wl1)) (= v_1_snd_wl2 (ite $x826 input_0_net.fin_segment_ack v_0_snd_wl2)) $x836 (= v_1_rx_chunk ?x702) (= v_1_rx_slot_00 (ite $x667 0 (ite $x363 ?x678 ?x910))) (= v_1_rx_slot_01 (ite $x667 0 ?x929)) (= v_1_rx_slot_02 ?x947) $x964 $x979 (= v_1_rx_slot_05 (ite $x667 0 ?x991)) (= v_1_rx_slot_06 ?x1005) $x1018 $x1029 (= v_1_rx_slot_09 (ite $x667 0 (ite $x363 ?x687 ?x1036))) (= v_1_rx_slot_10 ?x1047) $x1056 $x1063 (= v_1_rx_slot_13 (ite $x667 0 (ite $x363 ?x691 ?x1066))) $x1074 $x1079 (= v_1_rx_advance ?x662) (= v_1_rx_acceptable (and $x312 $x338 $x340)) (= v_1_seg_acceptable $x312) (= v_1_ack_delta ?x291) (= v_1_ack_is_new (and $x671 $x673)) (= v_1_ack_is_future $x337) (= v_1_ack_advance $x674) (= v_1_ack_window_update $x826) $x1100 (= v_1_fin_sent $x1105) $x1107 (= v_1_fin_acknowledged $x1103) (= v_1_rx_fin_pending (and $x343 $x668)) (= v_1_rx_fin_seq (ite $x342 ?x1114 v_0_rx_fin_seq)) (= v_1_rx_fin_offset (ite $x667 0 ?x665)) (= v_1_rx_fin_done (or v_0_rx_fin_done $x667)) (= v_1_rx_fin_consumed $x667) (= v_1_srtt_ms ?x739) (= v_1_rttvar_ms ?x762) (= v_1_rtt_error_ms ?x755) $x1134 $x1138 (= v_1_rtt_measured (or v_0_rtt_measured $x719)) $x1145 (= v_1_rtt_active (and $x1156 v_0_rtt_active $x1158)) (= v_1_rtt_ambiguous (and $x1156 $x1158 v_0_rtt_ambiguous)) (= v_1_rtt_sample_at_ms (ite $x719 now_1 v_0_rtt_sample_at_ms)) $x1169 $x1170 (= v_1_rtt_remaining ?x1179) $x1182 (= v_1_rtt_sample_used $x719) $x1187 (= v_1_rtt_last_ms ?x734) (= v_1_rtt_samples (+ v_0_rtt_samples (ite $x719 1 0))) (= v_1_rto_base_ms (ite $x719 ?x775 v_0_rto_base_ms)) $x1253 (= v_1_tx_time_01 (ite (or $x1151 $x1153) 0 ?x1270)) (= v_1_tx_time_02 ?x1290) $x1309 (= v_1_tx_time_04 (ite (or $x1153 (>= 4 ?x805)) 0 ?x1324)) (= v_1_tx_time_05 ?x1341) $x1357 (= v_1_tx_time_07 (ite (or (>= 7 ?x805) $x1153) 0 ?x1369)) (= v_1_tx_time_08 ?x1383) $x1396 (= v_1_tx_time_10 (ite (or $x1153 (>= 10 ?x805)) 0 ?x1405)) (= v_1_tx_time_11 ?x1416) $x1426 (= v_1_tx_time_13 (ite (or $x1153 (>= 13 ?x805)) 0 ?x1432)) (= v_1_tx_time_14 ?x1440) (= v_1_tx_time_15 ?x1445) (= v_1_tx_fin_time (ite $x1105 v_0_tx_fin_time 0)) $x1453 $x1456 $x1459 $x1461 $x1464 $x1467 $x1470 $x1472 $x1474 $x1476 $x1478 $x1480 $x1482 $x1484 $x1486 $x1489 $x1492 $x1494 $x1496 (= v_1_persist_active $x1155) (= v_1_persist_eligible $x1155) (= v_1_persist_start $x1503) $x1506 $x1508 $x1510 $x1512 (= v_1_persist_interval_ms (ite $x1155 ?x1515 1000)) $x1520 $x1525 (= v_1_persist_last_ms (ite $x1155 v_0_persist_last_ms 0)) $x1535 (= v_1_persist_probes (ite $x1155 v_0_persist_probes 0)) $x1542 (= active_1_rtx (or $x1553 $x1556)) $x1560 $x1562 $x1564 $x1568 (= due_1_rtx ?x1579) $x1582 $x1584 $x1586 (= due_1_persist (ite $x1503 ?x1531 due_0_persist)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
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
 (not active_0_user))
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
 (let ((?x1595 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1595)))
(assert
 (>= 16 v_0_rcv_buf))
(assert
 (and (<= 0 v_0_snd_wnd) (>= 65535 v_0_snd_wnd)))
(assert
 (= v_0_local_window (+ 16 (* (- 1) v_0_rcv_buf))))
(assert
 (>= 1 v_0_rx_slot_00))
(assert
 (let (($x346 (= 0 v_0_rx_slot_00)))
 (let (($x1605 (not (>= v_0_rcv_buf 16))))
 (or $x1605 $x346))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x364 (= 0 v_0_rx_slot_01)))
 (let (($x1609 (not (>= v_0_rcv_buf 15))))
 (or $x1609 $x364))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x383 (= 0 v_0_rx_slot_02)))
 (let (($x1613 (not (>= v_0_rcv_buf 14))))
 (or $x1613 $x383))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x403 (= 0 v_0_rx_slot_03)))
 (let (($x1617 (not (>= v_0_rcv_buf 13))))
 (or $x1617 $x403))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x423 (= 0 v_0_rx_slot_04)))
 (let (($x1621 (not (>= v_0_rcv_buf 12))))
 (or $x1621 $x423))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x443 (= 0 v_0_rx_slot_05)))
 (let (($x1625 (not (>= v_0_rcv_buf 11))))
 (or $x1625 $x443))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x463 (= 0 v_0_rx_slot_06)))
 (let (($x1629 (not (>= v_0_rcv_buf 10))))
 (or $x1629 $x463))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x483 (= 0 v_0_rx_slot_07)))
 (let (($x1633 (not (>= v_0_rcv_buf 9))))
 (or $x1633 $x483))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x503 (= 0 v_0_rx_slot_08)))
 (let (($x1637 (not (>= v_0_rcv_buf 8))))
 (or $x1637 $x503))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x521 (= 0 v_0_rx_slot_09)))
 (let (($x1641 (not (>= v_0_rcv_buf 7))))
 (or $x1641 $x521))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x539 (= 0 v_0_rx_slot_10)))
 (let (($x1645 (not (>= v_0_rcv_buf 6))))
 (or $x1645 $x539))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x557 (= 0 v_0_rx_slot_11)))
 (let (($x1649 (not (>= v_0_rcv_buf 5))))
 (or $x1649 $x557))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x575 (= 0 v_0_rx_slot_12)))
 (let (($x1653 (not (>= v_0_rcv_buf 4))))
 (or $x1653 $x575))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x593 (= 0 v_0_rx_slot_13)))
 (let (($x1657 (not (>= v_0_rcv_buf 3))))
 (or $x1657 $x593))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x611 (= 0 v_0_rx_slot_14)))
 (let (($x1661 (not (>= v_0_rcv_buf 2))))
 (or $x1661 $x611))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x629 (= 0 v_0_rx_slot_15)))
 (let (($x1665 (not (>= v_0_rcv_buf 1))))
 (or $x1665 $x629))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x1667 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x1667)))
(assert
 (and (<= 0 v_0_rx_advance) (>= 16 v_0_rx_advance)))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (and (<= 0 v_0_ack_delta) (>= 4294967295 v_0_ack_delta)))
(assert
 true)
(assert
 (let ((?x1680 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x1680)))
(assert
 (not v_0_fin_sent))
(assert
 (not v_0_fin_requested))
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
 (not v_0_rx_fin_done))
(assert
 (let (($x1684 (<= 1 v_0_rx_fin_offset)))
 (let (($x340 (not v_0_rx_fin_done)))
 (let (($x1686 (and $x340 $x1684 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window)))))
 (let (($x341 (not v_0_rx_fin_pending)))
 (or $x341 $x1686))))))
(assert
 (let (($x1689 (>= 15 v_0_rx_fin_offset)))
 (and (<= 0 v_0_rx_fin_offset) $x1689 (= v_0_rx_fin_pending (<= 1 v_0_rx_fin_offset)))))
(assert
 (let (($x341 (not v_0_rx_fin_pending)))
 (or $x341 (= v_0_rx_fin_seq (mod (+ v_0_rcv_nxt v_0_rx_fin_offset) 4294967296)))))
(assert
 (let (($x340 (not v_0_rx_fin_done)))
 (or $x340 (= v_0_rcv_nxt (mod (+ 1 v_0_rx_fin_seq) 4294967296)))))
(assert
 (let (($x346 (= 0 v_0_rx_slot_00)))
 (or (not (and v_0_rx_fin_pending (>= 0 v_0_rx_fin_offset))) $x346)))
(assert
 (let (($x364 (= 0 v_0_rx_slot_01)))
 (or (not (and v_0_rx_fin_pending (>= 1 v_0_rx_fin_offset))) $x364)))
(assert
 (let (($x383 (= 0 v_0_rx_slot_02)))
 (or (not (and v_0_rx_fin_pending (>= 2 v_0_rx_fin_offset))) $x383)))
(assert
 (let (($x403 (= 0 v_0_rx_slot_03)))
 (or (not (and v_0_rx_fin_pending (>= 3 v_0_rx_fin_offset))) $x403)))
(assert
 (let (($x423 (= 0 v_0_rx_slot_04)))
 (or (not (and v_0_rx_fin_pending (>= 4 v_0_rx_fin_offset))) $x423)))
(assert
 (let (($x443 (= 0 v_0_rx_slot_05)))
 (or (not (and v_0_rx_fin_pending (>= 5 v_0_rx_fin_offset))) $x443)))
(assert
 (let (($x463 (= 0 v_0_rx_slot_06)))
 (or (not (and v_0_rx_fin_pending (>= 6 v_0_rx_fin_offset))) $x463)))
(assert
 (let (($x483 (= 0 v_0_rx_slot_07)))
 (or (not (and v_0_rx_fin_pending (>= 7 v_0_rx_fin_offset))) $x483)))
(assert
 (let (($x503 (= 0 v_0_rx_slot_08)))
 (or (not (and v_0_rx_fin_pending (>= 8 v_0_rx_fin_offset))) $x503)))
(assert
 (let (($x521 (= 0 v_0_rx_slot_09)))
 (or (not (and v_0_rx_fin_pending (>= 9 v_0_rx_fin_offset))) $x521)))
(assert
 (let (($x539 (= 0 v_0_rx_slot_10)))
 (or (not (and v_0_rx_fin_pending (>= 10 v_0_rx_fin_offset))) $x539)))
(assert
 (let (($x557 (= 0 v_0_rx_slot_11)))
 (or (not (and v_0_rx_fin_pending (>= 11 v_0_rx_fin_offset))) $x557)))
(assert
 (let (($x575 (= 0 v_0_rx_slot_12)))
 (or (not (and v_0_rx_fin_pending (>= 12 v_0_rx_fin_offset))) $x575)))
(assert
 (let (($x593 (= 0 v_0_rx_slot_13)))
 (or (not (and v_0_rx_fin_pending (>= 13 v_0_rx_fin_offset))) $x593)))
(assert
 (let (($x611 (= 0 v_0_rx_slot_14)))
 (or (not (and v_0_rx_fin_pending (>= 14 v_0_rx_fin_offset))) $x611)))
(assert
 (let (($x629 (= 0 v_0_rx_slot_15)))
 (or (not (and v_0_rx_fin_pending (>= 15 v_0_rx_fin_offset))) $x629)))
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
 (let ((?x1777 (* 4.0 v_0_rttvar_ms)))
 (let ((?x722 (- 1.0)))
 (let ((?x751 (* ?x722 v_0_srtt_ms)))
 (let ((?x1780 (+ ?x751 (* ?x722 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x1777)))))
 (let ((?x1781 (to_int ?x1780)))
 (let ((?x278 (- 1)))
 (let ((?x1784 (ite (<= ?x1781 (- 1000)) (* ?x278 ?x1781) 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x1784) 60000 ?x1784) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x715 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x1799 (and (<= v_0_rtt_start_ms now_0) (<= 1 v_0_rtt_remaining) (>= 4 v_0_rtt_remaining) (>= ?x715 v_0_rtt_remaining) (<= ?x715 (mod (+ v_0_snd_nxt (* (- 1) v_0_snd_una)) 4294967296)))))
 (let (($x1791 (not v_0_rtt_active)))
 (or $x1791 $x1799)))))
(assert
 (let (($x1801 (= 0 v_0_rtt_remaining)))
 (or v_0_rtt_active $x1801)))
(assert
 true)
(assert
 (let (($x1808 (= v_0_rtt_last_ms (+ v_0_rtt_sample_at_ms (* (- 1) v_0_rtt_start_ms)))))
 (let (($x1806 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1804 (not v_0_rtt_sample_used)))
 (or $x1804 (and $x1806 v_0_rtt_measured $x1808))))))
(assert
 (and (<= 0 v_0_rtt_sample_at_ms) (<= v_0_rtt_sample_at_ms now_0)))
(assert
 (let ((?x1815 (to_real v_0_rtt_last_ms)))
 (let ((?x1829 (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x1815))))
 (let ((?x1817 (+ v_0_rtt_previous_srtt (* (- 1.0) ?x1815))))
 (let ((?x1821 (ite (>= ?x1817 0.0) ?x1817 (+ (* (- 1.0) v_0_rtt_previous_srtt) ?x1815))))
 (let ((?x746 (/ 1.0 4.0)))
 (let ((?x1825 (ite v_0_rtt_previous_measured (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* ?x746 ?x1821)) (* (/ 1.0 2.0) ?x1815))))
 (let (($x1832 (and (= v_0_rttvar_ms ?x1825) (= v_0_srtt_ms (ite v_0_rtt_previous_measured ?x1829 ?x1815)))))
 (let (($x1804 (not v_0_rtt_sample_used)))
 (or $x1804 $x1832))))))))))
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
 (let (($x1968 (and (>= v_0_tx_elapsed v_0_tx_previous_rto) (<= 1 v_0_tx_emit_count) (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x1962 (not v_0_tx_retransmitted)))
 (or $x1962 $x1968))))
(assert
 (let (($x1962 (not v_0_tx_retransmitted)))
 (or $x1962 (not v_0_tx_waiting))))
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
 (let (($x1999 (not v_0_ack_pending)))
 (or $x1999 (and (<= 1 v_0_ack_bytes) (not v_0_rx_fin_done)))))
(assert
 (let (($x2006 (and (= 0 v_0_ack_bytes) (= 0 v_0_ack_full_segments) (= 0 v_0_ack_since_ms))))
 (or v_0_ack_pending $x2006)))
(assert
 (let (($x186 (not active_0_rtx)))
 (let (($x1843 (>= 1 v_0_rtx_buf)))
 (let (($x1682 (not v_0_fin_sent)))
 (let (($x2015 (and (= 0 v_0_snd_wnd) $x1682 (<= 1 (+ v_0_rtx_buf v_0_snd_buf)) $x1843 $x186)))
 (let (($x1502 (not v_0_persist_active)))
 (let (($x2010 (and (<= 1 (+ v_0_rtx_buf (ite v_0_fin_sent 1 0))) $x1502)))
 (let (($x2008 (= v_0_persist_active active_0_persist)))
 (and $x2008 (= active_0_rtx $x2010) (or $x1502 $x2015))))))))))
(assert
 (let (($x1502 (not v_0_persist_active)))
 (or $x1502 (and (not v_0_rtt_active) (= 0 v_0_rtt_remaining)))))
(assert
 (and (<= 1000 v_0_persist_interval_ms) (>= 60000 v_0_persist_interval_ms) (<= 1000 v_0_persist_previous_interval_ms) (>= 60000 v_0_persist_previous_interval_ms) (<= 0 v_0_persist_probes) (<= 0 v_0_persist_elapsed_ms)))
(assert
 (and (<= 0 v_0_persist_since_ms) (<= v_0_persist_since_ms now_0) (<= 0 v_0_persist_last_ms) (<= v_0_persist_last_ms now_0) (<= 0 v_0_persist_deadline_ms)))
(assert
 (let (($x2033 (= 0 v_0_persist_probes)))
 (let ((?x2035 (+ (ite $x2033 v_0_persist_since_ms v_0_persist_last_ms) v_0_persist_interval_ms)))
 (let (($x1502 (not v_0_persist_active)))
 (or $x1502 (= v_0_persist_deadline_ms ?x2035))))))
(assert
 (let (($x2041 (= 1 v_0_rtx_buf)))
 (let (($x2039 (not v_0_persist_probe_sent)))
 (or $x2039 (and (>= v_0_persist_elapsed_ms v_0_persist_previous_interval_ms) $x2041)))))
(assert
 (let (($x2047 (= v_0_tx_time_00 v_0_persist_last_ms)))
 (let (($x2041 (= 1 v_0_rtx_buf)))
 (or (not (and v_0_persist_active (<= 1 v_0_persist_probes) $x2041)) $x2047))))
(assert
 (let (($x2033 (= 0 v_0_persist_probes)))
 (let (($x2052 (and (= 0 v_0_persist_since_ms) (= 0 v_0_persist_last_ms) (= 0 v_0_persist_deadline_ms) $x2033)))
 (or v_0_persist_active $x2052))))
(assert
 (= 155 choice_0))
(assert
 (= 4 state_0))
(assert
 (= 4 state_1))
(assert
 (let (($x2065 (or (not (and v_1_rx_fin_pending (>= 7 v_1_rx_fin_offset))) (= 0 v_1_rx_slot_07))))
(or (not $x2065))))
(check-sat)
