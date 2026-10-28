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
(declare-fun v_0_ack_delay_ms () Int)
(declare-fun now_1 () Int)
(declare-fun v_0_ack_rmss () Int)
(declare-fun v_0_ack_full_segments () Int)
(declare-fun v_0_ack_bytes () Int)
(declare-fun v_0_rx_fin_offset () Int)
(declare-fun v_0_rx_fin_pending () Bool)
(declare-fun v_0_rx_fin_done () Bool)
(declare-fun v_0_fin_sent () Bool)
(declare-fun v_0_local_window () Int)
(declare-fun due_1_delack () Int)
(declare-fun v_0_msl_ms () Int)
(declare-fun due_1_time_wait () Int)
(declare-fun due_1_user () Int)
(declare-fun v_0_rto_ms () Int)
(declare-fun v_0_rttvar_ms () Real)
(declare-fun v_0_rtt_last_ms () Int)
(declare-fun v_0_rtt_start_ms () Int)
(declare-fun v_0_rtt_ambiguous () Bool)
(declare-fun v_0_rtt_active () Bool)
(declare-fun v_0_rtt_error_ms () Real)
(declare-fun v_0_srtt_ms () Real)
(declare-fun v_0_rtt_measured () Bool)
(declare-fun due_1_rtx () Int)
(declare-fun active_1_delack () Bool)
(declare-fun active_1_time_wait () Bool)
(declare-fun active_1_user () Bool)
(declare-fun active_1_rtx () Bool)
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
(declare-fun v_0_snd_wnd () Int)
(declare-fun input_0_net.data_window () Int)
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
 (let ((?x1541 (+ now_1 v_0_ack_delay_ms)))
 (let (($x201 (not active_0_delack)))
 (let ((?x1476 (+ v_0_ack_full_segments (ite (= input_0_net.data_data v_0_ack_rmss) 1 0))))
 (let (($x1477 (>= 1 ?x1476)))
 (let ((?x1469 (+ v_0_ack_bytes input_0_net.data_data)))
 (let (($x1472 (<= ?x1469 (+ (- 1) (* 2 v_0_ack_rmss)))))
 (let (($x639 (>= 15 v_0_rx_fin_offset)))
 (let (($x640 (and v_0_rx_fin_pending $x639)))
 (let ((?x627 (mod (+ 15 v_0_rcv_nxt (* (- 1) input_0_net.data_seq)) 4294967296)))
 (let ((?x273 (- 1)))
 (let ((?x632 (+ input_0_net.data_data (* ?x273 ?x627))))
 (let (($x630 (<= input_0_net.data_data ?x627)))
 (let (($x625 (<= v_0_rcv_buf 0)))
 (let (($x624 (= 0 v_0_rx_slot_15)))
 (let (($x333 (not v_0_rx_fin_done)))
 (let ((?x301 (mod (+ input_0_net.data_ack (* ?x273 v_0_snd_una)) 4294967296)))
 (let (($x339 (and (>= ?x301 (+ 1 v_0_rtx_buf (ite v_0_fin_sent 1 0))) (>= 2147483647 ?x301))))
 (let (($x340 (not $x339)))
 (let ((?x290 (+ ?x273 v_0_local_window)))
 (let (($x285 (<= 1 v_0_local_window)))
 (let (($x296 (and $x285 (<= (mod (+ input_0_net.data_seq (* ?x273 v_0_rcv_nxt)) 4294967296) ?x290))))
 (let ((?x287 (* ?x273 v_0_rcv_nxt)))
 (let (($x291 (<= (mod (+ 4294967295 input_0_net.data_seq input_0_net.data_data ?x287) 4294967296) ?x290)))
 (let (($x297 (or (and $x285 $x291) $x296)))
 (let (($x629 (and $x297 $x340 $x333 $x624 $x625 (<= ?x627 (+ ?x273 input_0_net.data_data)))))
 (let ((?x637 (ite $x629 (ite (or $x630 (<= ?x632 1)) (ite $x630 0 ?x632) 1) v_0_rx_slot_15)))
 (let (($x641 (or (= ?x637 0) $x640)))
 (let ((?x611 (mod (+ 14 v_0_rcv_nxt (* ?x273 input_0_net.data_seq)) 4294967296)))
 (let ((?x616 (+ input_0_net.data_data (* ?x273 ?x611))))
 (let (($x614 (<= input_0_net.data_data ?x611)))
 (let (($x609 (<= v_0_rcv_buf 1)))
 (let (($x608 (= 0 v_0_rx_slot_14)))
 (let (($x613 (and $x297 $x340 $x333 $x608 $x609 (<= ?x611 (+ ?x273 input_0_net.data_data)))))
 (let ((?x621 (ite $x613 (ite (or $x614 (<= ?x616 1)) (ite $x614 0 ?x616) 1) v_0_rx_slot_14)))
 (let (($x607 (and v_0_rx_fin_pending (>= 14 v_0_rx_fin_offset))))
 (let (($x623 (or $x607 (= ?x621 0))))
 (let ((?x593 (mod (+ 13 v_0_rcv_nxt (* ?x273 input_0_net.data_seq)) 4294967296)))
 (let ((?x598 (+ input_0_net.data_data (* ?x273 ?x593))))
 (let (($x596 (<= input_0_net.data_data ?x593)))
 (let (($x591 (<= v_0_rcv_buf 2)))
 (let (($x590 (= 0 v_0_rx_slot_13)))
 (let (($x595 (and $x297 $x340 $x333 $x590 $x591 (<= ?x593 (+ ?x273 input_0_net.data_data)))))
 (let ((?x603 (ite $x595 (ite (or $x596 (<= ?x598 1)) (ite $x596 0 ?x598) 1) v_0_rx_slot_13)))
 (let (($x589 (and v_0_rx_fin_pending (>= 13 v_0_rx_fin_offset))))
 (let (($x605 (or $x589 (= ?x603 0))))
 (let (($x586 (and v_0_rx_fin_pending (>= 12 v_0_rx_fin_offset))))
 (let ((?x573 (mod (+ 12 v_0_rcv_nxt (* ?x273 input_0_net.data_seq)) 4294967296)))
 (let ((?x578 (+ input_0_net.data_data (* ?x273 ?x573))))
 (let (($x576 (<= input_0_net.data_data ?x573)))
 (let (($x571 (<= v_0_rcv_buf 3)))
 (let (($x570 (= 0 v_0_rx_slot_12)))
 (let (($x575 (and $x297 $x340 $x333 $x570 $x571 (<= ?x573 (+ ?x273 input_0_net.data_data)))))
 (let ((?x583 (ite $x575 (ite (or $x576 (<= ?x578 1)) (ite $x576 0 ?x578) 1) v_0_rx_slot_12)))
 (let (($x587 (or (= ?x583 0) $x586)))
 (let ((?x645 (ite $x587 12 (ite $x605 13 (ite $x623 14 (ite $x641 15 16))))))
 (let ((?x557 (mod (+ 11 v_0_rcv_nxt (* ?x273 input_0_net.data_seq)) 4294967296)))
 (let ((?x562 (+ input_0_net.data_data (* ?x273 ?x557))))
 (let (($x560 (<= input_0_net.data_data ?x557)))
 (let (($x555 (<= v_0_rcv_buf 4)))
 (let (($x554 (= 0 v_0_rx_slot_11)))
 (let (($x559 (and $x297 $x340 $x333 $x554 $x555 (<= ?x557 (+ ?x273 input_0_net.data_data)))))
 (let ((?x567 (ite $x559 (ite (or $x560 (<= ?x562 1)) (ite $x560 0 ?x562) 1) v_0_rx_slot_11)))
 (let (($x553 (and v_0_rx_fin_pending (>= 11 v_0_rx_fin_offset))))
 (let (($x569 (or $x553 (= ?x567 0))))
 (let (($x550 (and v_0_rx_fin_pending (>= 10 v_0_rx_fin_offset))))
 (let ((?x537 (mod (+ 10 v_0_rcv_nxt (* ?x273 input_0_net.data_seq)) 4294967296)))
 (let ((?x542 (+ input_0_net.data_data (* ?x273 ?x537))))
 (let (($x540 (<= input_0_net.data_data ?x537)))
 (let (($x535 (<= v_0_rcv_buf 5)))
 (let (($x534 (= 0 v_0_rx_slot_10)))
 (let (($x539 (and $x297 $x340 $x333 $x534 $x535 (<= ?x537 (+ ?x273 input_0_net.data_data)))))
 (let ((?x547 (ite $x539 (ite (or $x540 (<= ?x542 1)) (ite $x540 0 ?x542) 1) v_0_rx_slot_10)))
 (let (($x551 (or (= ?x547 0) $x550)))
 (let ((?x521 (mod (+ 9 v_0_rcv_nxt (* ?x273 input_0_net.data_seq)) 4294967296)))
 (let ((?x526 (+ input_0_net.data_data (* ?x273 ?x521))))
 (let (($x524 (<= input_0_net.data_data ?x521)))
 (let (($x519 (<= v_0_rcv_buf 6)))
 (let (($x518 (= 0 v_0_rx_slot_09)))
 (let (($x523 (and $x297 $x340 $x333 $x518 $x519 (<= ?x521 (+ ?x273 input_0_net.data_data)))))
 (let ((?x531 (ite $x523 (ite (or $x524 (<= ?x526 1)) (ite $x524 0 ?x526) 1) v_0_rx_slot_09)))
 (let (($x517 (and v_0_rx_fin_pending (>= 9 v_0_rx_fin_offset))))
 (let (($x533 (or $x517 (= ?x531 0))))
 (let ((?x503 (mod (+ 8 v_0_rcv_nxt (* ?x273 input_0_net.data_seq)) 4294967296)))
 (let ((?x508 (+ input_0_net.data_data (* ?x273 ?x503))))
 (let (($x506 (<= input_0_net.data_data ?x503)))
 (let (($x501 (<= v_0_rcv_buf 7)))
 (let (($x500 (= 0 v_0_rx_slot_08)))
 (let (($x505 (and $x297 $x340 $x333 $x500 $x501 (<= ?x503 (+ ?x273 input_0_net.data_data)))))
 (let ((?x513 (ite $x505 (ite (or $x506 (<= ?x508 1)) (ite $x506 0 ?x508) 1) v_0_rx_slot_08)))
 (let (($x499 (and v_0_rx_fin_pending (>= 8 v_0_rx_fin_offset))))
 (let (($x515 (or $x499 (= ?x513 0))))
 (let ((?x649 (ite $x515 8 (ite $x533 9 (ite $x551 10 (ite $x569 11 ?x645))))))
 (let ((?x485 (mod (+ 7 v_0_rcv_nxt (* ?x273 input_0_net.data_seq)) 4294967296)))
 (let ((?x490 (+ input_0_net.data_data (* ?x273 ?x485))))
 (let (($x488 (<= input_0_net.data_data ?x485)))
 (let (($x483 (<= v_0_rcv_buf 8)))
 (let (($x481 (= 0 v_0_rx_slot_07)))
 (let (($x487 (and $x297 $x340 $x333 $x481 $x483 (<= ?x485 (+ ?x273 input_0_net.data_data)))))
 (let ((?x495 (ite $x487 (ite (or $x488 (<= ?x490 1)) (ite $x488 0 ?x490) 1) v_0_rx_slot_07)))
 (let (($x480 (and v_0_rx_fin_pending (>= 7 v_0_rx_fin_offset))))
 (let (($x497 (or $x480 (= ?x495 0))))
 (let ((?x465 (mod (+ 6 v_0_rcv_nxt (* ?x273 input_0_net.data_seq)) 4294967296)))
 (let ((?x470 (+ input_0_net.data_data (* ?x273 ?x465))))
 (let (($x468 (<= input_0_net.data_data ?x465)))
 (let (($x463 (<= v_0_rcv_buf 9)))
 (let (($x461 (= 0 v_0_rx_slot_06)))
 (let (($x467 (and $x297 $x340 $x333 $x461 $x463 (<= ?x465 (+ ?x273 input_0_net.data_data)))))
 (let ((?x475 (ite $x467 (ite (or $x468 (<= ?x470 1)) (ite $x468 0 ?x470) 1) v_0_rx_slot_06)))
 (let (($x460 (and v_0_rx_fin_pending (>= 6 v_0_rx_fin_offset))))
 (let (($x477 (or $x460 (= ?x475 0))))
 (let (($x456 (and v_0_rx_fin_pending (>= 5 v_0_rx_fin_offset))))
 (let ((?x443 (mod (+ 5 v_0_rcv_nxt (* ?x273 input_0_net.data_seq)) 4294967296)))
 (let ((?x448 (+ input_0_net.data_data (* ?x273 ?x443))))
 (let (($x446 (<= input_0_net.data_data ?x443)))
 (let (($x440 (<= v_0_rcv_buf 10)))
 (let (($x438 (= 0 v_0_rx_slot_05)))
 (let (($x445 (and $x297 $x340 $x333 $x438 $x440 (<= ?x443 (+ ?x273 input_0_net.data_data)))))
 (let ((?x453 (ite $x445 (ite (or $x446 (<= ?x448 1)) (ite $x446 0 ?x448) 1) v_0_rx_slot_05)))
 (let (($x457 (or (= ?x453 0) $x456)))
 (let ((?x425 (mod (+ 4 v_0_rcv_nxt (* ?x273 input_0_net.data_seq)) 4294967296)))
 (let ((?x430 (+ input_0_net.data_data (* ?x273 ?x425))))
 (let (($x428 (<= input_0_net.data_data ?x425)))
 (let (($x423 (<= v_0_rcv_buf 11)))
 (let (($x421 (= 0 v_0_rx_slot_04)))
 (let (($x427 (and $x297 $x340 $x333 $x421 $x423 (<= ?x425 (+ ?x273 input_0_net.data_data)))))
 (let ((?x435 (ite $x427 (ite (or $x428 (<= ?x430 1)) (ite $x428 0 ?x430) 1) v_0_rx_slot_04)))
 (let (($x420 (and v_0_rx_fin_pending (>= 4 v_0_rx_fin_offset))))
 (let (($x437 (or $x420 (= ?x435 0))))
 (let ((?x653 (ite $x437 4 (ite $x457 5 (ite $x477 6 (ite $x497 7 ?x649))))))
 (let (($x416 (and v_0_rx_fin_pending (>= 3 v_0_rx_fin_offset))))
 (let ((?x403 (mod (+ 3 v_0_rcv_nxt (* ?x273 input_0_net.data_seq)) 4294967296)))
 (let ((?x408 (+ input_0_net.data_data (* ?x273 ?x403))))
 (let (($x406 (<= input_0_net.data_data ?x403)))
 (let (($x400 (<= v_0_rcv_buf 12)))
 (let (($x398 (= 0 v_0_rx_slot_03)))
 (let (($x405 (and $x297 $x340 $x333 $x398 $x400 (<= ?x403 (+ ?x273 input_0_net.data_data)))))
 (let ((?x413 (ite $x405 (ite (or $x406 (<= ?x408 1)) (ite $x406 0 ?x408) 1) v_0_rx_slot_03)))
 (let (($x417 (or (= ?x413 0) $x416)))
 (let (($x396 (and v_0_rx_fin_pending (>= 2 v_0_rx_fin_offset))))
 (let ((?x383 (mod (+ 2 v_0_rcv_nxt (* ?x273 input_0_net.data_seq)) 4294967296)))
 (let ((?x388 (+ input_0_net.data_data (* ?x273 ?x383))))
 (let (($x386 (<= input_0_net.data_data ?x383)))
 (let (($x380 (<= v_0_rcv_buf 13)))
 (let (($x378 (= 0 v_0_rx_slot_02)))
 (let (($x385 (and $x297 $x340 $x333 $x378 $x380 (<= ?x383 (+ ?x273 input_0_net.data_data)))))
 (let ((?x393 (ite $x385 (ite (or $x386 (<= ?x388 1)) (ite $x386 0 ?x388) 1) v_0_rx_slot_02)))
 (let (($x397 (or (= ?x393 0) $x396)))
 (let ((?x365 (mod (+ 1 v_0_rcv_nxt (* ?x273 input_0_net.data_seq)) 4294967296)))
 (let ((?x370 (+ input_0_net.data_data (* ?x273 ?x365))))
 (let (($x368 (<= input_0_net.data_data ?x365)))
 (let (($x363 (<= v_0_rcv_buf 14)))
 (let (($x361 (= 0 v_0_rx_slot_01)))
 (let (($x367 (and $x297 $x340 $x333 $x361 $x363 (<= ?x365 (+ ?x273 input_0_net.data_data)))))
 (let ((?x375 (ite $x367 (ite (or $x368 (<= ?x370 1)) (ite $x368 0 ?x370) 1) v_0_rx_slot_01)))
 (let (($x376 (= ?x375 0)))
 (let (($x360 (and v_0_rx_fin_pending (>= 1 v_0_rx_fin_offset))))
 (let (($x377 (or $x360 $x376)))
 (let ((?x656 (ite $x377 1 (ite $x397 2 (ite $x417 3 ?x653)))))
 (let (($x357 (and v_0_rx_fin_pending (>= 0 v_0_rx_fin_offset))))
 (let ((?x349 (+ input_0_net.data_data (* ?x273 (mod (+ v_0_rcv_nxt (* ?x273 input_0_net.data_seq)) 4294967296)))))
 (let ((?x276 (mod (+ v_0_rcv_nxt (* ?x273 input_0_net.data_seq)) 4294967296)))
 (let (($x347 (<= input_0_net.data_data ?x276)))
 (let (($x343 (<= v_0_rcv_buf 15)))
 (let (($x341 (= 0 v_0_rx_slot_00)))
 (let (($x346 (and $x297 $x340 $x333 $x341 $x343 (<= ?x276 (+ ?x273 input_0_net.data_data)))))
 (let ((?x354 (ite $x346 (ite (or $x347 (<= ?x349 1)) (ite $x347 0 ?x349) 1) v_0_rx_slot_00)))
 (let (($x358 (or (= ?x354 0) $x357)))
 (let (($x692 (not $x358)))
 (let ((?x694 (ite (and (<= 0 (ite $x358 0 ?x656)) $x692) ?x656 0)))
 (let ((?x686 (ite $x607 0 ?x621)))
 (let ((?x685 (ite $x589 0 ?x603)))
 (let ((?x684 (ite $x586 0 ?x583)))
 (let ((?x683 (ite $x553 0 ?x567)))
 (let ((?x682 (ite $x550 0 ?x547)))
 (let ((?x681 (ite $x517 0 ?x531)))
 (let ((?x680 (ite $x499 0 ?x513)))
 (let ((?x679 (ite $x480 0 ?x495)))
 (let ((?x678 (ite $x460 0 ?x475)))
 (let ((?x677 (ite $x456 0 ?x453)))
 (let ((?x676 (ite $x420 0 ?x435)))
 (let ((?x675 (ite $x416 0 ?x413)))
 (let ((?x674 (ite $x396 0 ?x393)))
 (let ((?x673 (ite $x360 0 ?x375)))
 (let ((?x672 (ite $x357 0 ?x354)))
 (let ((?x688 (+ ?x672 ?x673 ?x674 ?x675 ?x676 ?x677 ?x678 ?x679 ?x680 ?x681 ?x682 ?x683 ?x684 ?x685 ?x686 (ite $x640 0 ?x637))))
 (let ((?x690 (ite (<= ?x688 0) 0 ?x688)))
 (let ((?x696 (ite (<= ?x690 ?x694) ?x690 ?x694)))
 (let ((?x787 (* ?x273 ?x696)))
 (let ((?x786 (* ?x273 v_0_rcv_buf)))
 (let (($x1467 (<= (- 15) (+ ?x786 ?x787))))
 (let (($x1464 (= ?x696 input_0_net.data_data)))
 (let ((?x660 (ite v_0_rx_fin_pending (+ v_0_rx_fin_offset (* ?x273 (ite $x358 0 ?x656))) v_0_rx_fin_offset)))
 (let (($x661 (= 0 ?x660)))
 (let (($x662 (and v_0_rx_fin_pending $x333 $x661)))
 (let (($x663 (not $x662)))
 (let (($x1463 (not v_0_rx_fin_pending)))
 (let (($x1462 (<= input_0_net.data_data v_0_local_window)))
 (let (($x1461 (<= input_0_net.data_data v_0_ack_rmss)))
 (let (($x270 (<= 1 input_0_net.data_data)))
 (let (($x1459 (= input_0_net.data_seq v_0_rcv_nxt)))
 (let (($x1525 (and $x1459 $x270 $x1461 $x1462 $x1463 $x333 $x341 $x361 $x378 $x398 $x421 $x438 $x461 $x481 $x500 $x518 $x534 $x554 $x570 $x590 $x608 $x624 $x340 $x663 $x1464 $x1467 $x1472 $x1477 $x201)))
 (let ((?x1537 (+ now_1 (* 2 v_0_msl_ms))))
 (let ((?x325 (ite v_0_fin_sent 1 0)))
 (let ((?x326 (+ v_0_rtx_buf ?x325)))
 (let (($x328 (= ?x301 ?x326)))
 (let (($x327 (<= ?x301 ?x326)))
 (let (($x323 (<= 1 ?x301)))
 (let (($x664 (and v_0_rx_fin_pending $x333 $x661 $x297 $x323 $x327 v_0_fin_sent $x328)))
 (let (($x1534 (= due_1_user due_0_user)))
 (let (($x712 (not v_0_rtt_ambiguous)))
 (let ((?x709 (mod (+ v_0_rtt_end (* ?x273 v_0_snd_una)) 4294967296)))
 (let (($x710 (>= ?x301 ?x709)))
 (let (($x713 (and v_0_rtt_active $x297 $x323 $x327 $x710 $x712)))
 (let ((?x728 (ite $x713 (+ now_1 (* ?x273 v_0_rtt_start_ms)) v_0_rtt_last_ms)))
 (let ((?x729 (to_real ?x728)))
 (let ((?x753 (/ 1.0 2.0)))
 (let ((?x742 (+ v_0_srtt_ms (* (- 1.0) ?x729))))
 (let ((?x749 (ite $x713 (ite (>= ?x742 0.0) ?x742 (+ (* (- 1.0) v_0_srtt_ms) ?x729)) v_0_rtt_error_ms)))
 (let ((?x740 (/ 1.0 4.0)))
 (let ((?x755 (ite v_0_rtt_measured (+ (* (/ 3.0 4.0) v_0_rttvar_ms) (* ?x740 ?x749)) (* ?x753 ?x729))))
 (let ((?x756 (ite $x713 ?x755 v_0_rttvar_ms)))
 (let ((?x716 (- 1.0)))
 (let ((?x732 (ite v_0_rtt_measured (+ (* (/ 7.0 8.0) v_0_srtt_ms) (* (/ 1.0 8.0) ?x729)) ?x729)))
 (let ((?x733 (ite $x713 ?x732 v_0_srtt_ms)))
 (let ((?x761 (+ (* ?x716 ?x733) (* ?x716 (ite (<= ?x756 ?x740) 1.0 (* 4.0 ?x756))))))
 (let ((?x762 (to_int ?x761)))
 (let ((?x767 (ite (<= ?x762 (- 1000)) (* ?x273 ?x762) 1000)))
 (let ((?x769 (ite (<= 60000 ?x767) 60000 ?x767)))
 (let ((?x771 (ite $x713 ?x769 v_0_rto_ms)))
 (let (($x329 (and $x297 $x323 $x327 v_0_fin_sent $x328)))
 (let (($x330 (not $x329)))
 (let (($x1096 (and $x330 v_0_fin_sent)))
 (let ((?x796 (ite (<= 0 v_0_rtx_buf) v_0_rtx_buf 0)))
 (let ((?x794 (ite (<= v_0_rtx_buf ?x301) 0 (+ v_0_rtx_buf (* ?x273 ?x301)))))
 (let (($x668 (and $x297 $x323 $x327)))
 (let ((?x799 (ite $x668 (ite (<= ?x794 ?x796) ?x794 ?x796) v_0_rtx_buf)))
 (let ((?x1508 (+ ?x799 (ite $x1096 1 0))))
 (let (($x1510 (and $x297 $x323 $x327 (<= 1 ?x1508))))
 (let (($x1527 (and $x1459 $x270 $x1461 $x1462 $x1463 $x333 $x341 $x361 $x378 $x398 $x421 $x438 $x461 $x481 $x500 $x518 $x534 $x554 $x570 $x590 $x608 $x624 $x340 $x663 $x1464 $x1467 $x1472 $x1477 (or active_0_delack $x1525))))
 (let (($x1515 (or $x1510 (and (not (and $x297 $x323 $x327 (= 0 ?x1508))) active_0_rtx))))
 (let (($x665 (not $x664)))
 (let (($x1479 (and $x1459 $x270 $x1461 $x1462 $x1463 $x333 $x341 $x361 $x378 $x398 $x421 $x438 $x461 $x481 $x500 $x518 $x534 $x554 $x570 $x590 $x608 $x624 $x340 $x663 $x1464 $x1467 $x1472 $x1477)))
 (let (($x1502 (and $x1459 $x270 $x1461 $x1462 $x1463 $x333 $x341 $x361 $x378 $x398 $x421 $x438 $x461 $x481 $x500 $x518 $x534 $x554 $x570 $x590 $x608 $x624)))
 (let (($x1500 (= v_1_ack_rmss v_0_ack_rmss)))
 (let (($x1498 (= v_1_ack_delay_ms v_0_ack_delay_ms)))
 (let (($x1484 (not v_0_ack_pending)))
 (let (($x1485 (and $x1459 $x270 $x1461 $x1462 $x1463 $x333 $x341 $x361 $x378 $x398 $x421 $x438 $x461 $x481 $x500 $x518 $x534 $x554 $x570 $x590 $x608 $x624 $x340 $x663 $x1464 $x1467 $x1472 $x1477 $x1484)))
 (let (($x1489 (= v_1_ack_since_ms (ite $x1479 (ite $x1485 now_1 v_0_ack_since_ms) 0))))
 (let (($x1481 (and $x1459 $x270 $x1461 $x1462 $x1463 $x333 $x341 $x361 $x378 $x398 $x421 $x438 $x461 $x481 $x500 $x518 $x534 $x554 $x570 $x590 $x608 $x624 $x340 $x663 $x1464 $x1467 $x1472 $x1477 (or v_0_ack_pending $x1479))))
 (let (($x1457 (not v_1_syn_timeout_eligible)))
 (let (($x1455 (not v_1_tx_syn_pending)))
 (let (($x1453 (= v_1_tx_syn_time 0)))
 (let (($x1451 (not v_1_tx_waiting)))
 (let (($x1449 (= v_1_tx_is_fin v_0_tx_is_fin)))
 (let (($x1446 (= v_1_tx_previous_rto v_0_tx_previous_rto)))
 (let (($x1443 (= v_1_tx_elapsed v_0_tx_elapsed)))
 (let (($x1440 (not v_1_tx_retransmitted)))
 (let (($x1438 (= v_1_tx_max_previous v_0_tx_max_previous)))
 (let (($x1435 (= v_1_tx_eligible v_0_tx_eligible)))
 (let (($x1432 (= v_1_tx_emit_count v_0_tx_emit_count)))
 (let (($x1178 (= 0 ?x799)))
 (let (($x1182 (and $x297 $x323 $x327 (not (= 0 ?x301)))))
 (let (($x1425 (= v_1_tx_time_15 (ite (or $x1182 (>= 15 ?x799) $x1178) 0 v_0_tx_time_15))))
 (let ((?x1419 (ite (or (>= 14 ?x799) $x1178) 0 (ite $x1182 (ite (= 1 ?x301) v_0_tx_time_15 0) v_0_tx_time_14))))
 (let (($x1183 (= 1 ?x301)))
 (let ((?x1411 (ite $x1182 (ite $x1183 v_0_tx_time_14 (ite (= 2 ?x301) v_0_tx_time_15 0)) v_0_tx_time_13)))
 (let (($x1185 (= 2 ?x301)))
 (let ((?x1402 (ite $x1183 v_0_tx_time_13 (ite $x1185 v_0_tx_time_14 (ite (= 3 ?x301) v_0_tx_time_15 0)))))
 (let (($x1405 (= v_1_tx_time_12 (ite (or (>= 12 ?x799) $x1178) 0 (ite $x1182 ?x1402 v_0_tx_time_12)))))
 (let (($x1187 (= 3 ?x301)))
 (let ((?x1392 (ite $x1185 v_0_tx_time_13 (ite $x1187 v_0_tx_time_14 (ite (= 4 ?x301) v_0_tx_time_15 0)))))
 (let ((?x1395 (ite (or (>= 11 ?x799) $x1178) 0 (ite $x1182 (ite $x1183 v_0_tx_time_12 ?x1392) v_0_tx_time_11))))
 (let (($x1189 (= 4 ?x301)))
 (let ((?x1381 (ite $x1187 v_0_tx_time_13 (ite $x1189 v_0_tx_time_14 (ite (= 5 ?x301) v_0_tx_time_15 0)))))
 (let ((?x1384 (ite $x1182 (ite $x1183 v_0_tx_time_11 (ite $x1185 v_0_tx_time_12 ?x1381)) v_0_tx_time_10)))
 (let (($x1191 (= 5 ?x301)))
 (let ((?x1369 (ite $x1189 v_0_tx_time_13 (ite $x1191 v_0_tx_time_14 (ite (= 6 ?x301) v_0_tx_time_15 0)))))
 (let ((?x1372 (ite $x1183 v_0_tx_time_10 (ite $x1185 v_0_tx_time_11 (ite $x1187 v_0_tx_time_12 ?x1369)))))
 (let (($x1375 (= v_1_tx_time_09 (ite (or (>= 9 ?x799) $x1178) 0 (ite $x1182 ?x1372 v_0_tx_time_09)))))
 (let (($x1193 (= 6 ?x301)))
 (let ((?x1356 (ite $x1191 v_0_tx_time_13 (ite $x1193 v_0_tx_time_14 (ite (= 7 ?x301) v_0_tx_time_15 0)))))
 (let ((?x1359 (ite $x1185 v_0_tx_time_10 (ite $x1187 v_0_tx_time_11 (ite $x1189 v_0_tx_time_12 ?x1356)))))
 (let ((?x1362 (ite (or (>= 8 ?x799) $x1178) 0 (ite $x1182 (ite $x1183 v_0_tx_time_09 ?x1359) v_0_tx_time_08))))
 (let (($x1195 (= 7 ?x301)))
 (let ((?x1342 (ite $x1193 v_0_tx_time_13 (ite $x1195 v_0_tx_time_14 (ite (= 8 ?x301) v_0_tx_time_15 0)))))
 (let ((?x1345 (ite $x1187 v_0_tx_time_10 (ite $x1189 v_0_tx_time_11 (ite $x1191 v_0_tx_time_12 ?x1342)))))
 (let ((?x1348 (ite $x1182 (ite $x1183 v_0_tx_time_08 (ite $x1185 v_0_tx_time_09 ?x1345)) v_0_tx_time_07)))
 (let (($x1197 (= 8 ?x301)))
 (let ((?x1327 (ite $x1195 v_0_tx_time_13 (ite $x1197 v_0_tx_time_14 (ite (= 9 ?x301) v_0_tx_time_15 0)))))
 (let ((?x1330 (ite $x1189 v_0_tx_time_10 (ite $x1191 v_0_tx_time_11 (ite $x1193 v_0_tx_time_12 ?x1327)))))
 (let ((?x1333 (ite $x1183 v_0_tx_time_07 (ite $x1185 v_0_tx_time_08 (ite $x1187 v_0_tx_time_09 ?x1330)))))
 (let (($x1336 (= v_1_tx_time_06 (ite (or (>= 6 ?x799) $x1178) 0 (ite $x1182 ?x1333 v_0_tx_time_06)))))
 (let (($x1199 (= 9 ?x301)))
 (let ((?x1311 (ite $x1197 v_0_tx_time_13 (ite $x1199 v_0_tx_time_14 (ite (= 10 ?x301) v_0_tx_time_15 0)))))
 (let ((?x1314 (ite $x1191 v_0_tx_time_10 (ite $x1193 v_0_tx_time_11 (ite $x1195 v_0_tx_time_12 ?x1311)))))
 (let ((?x1317 (ite $x1185 v_0_tx_time_07 (ite $x1187 v_0_tx_time_08 (ite $x1189 v_0_tx_time_09 ?x1314)))))
 (let ((?x1320 (ite (or (>= 5 ?x799) $x1178) 0 (ite $x1182 (ite $x1183 v_0_tx_time_06 ?x1317) v_0_tx_time_05))))
 (let (($x1201 (= 10 ?x301)))
 (let ((?x1294 (ite $x1199 v_0_tx_time_13 (ite $x1201 v_0_tx_time_14 (ite (= 11 ?x301) v_0_tx_time_15 0)))))
 (let ((?x1297 (ite $x1193 v_0_tx_time_10 (ite $x1195 v_0_tx_time_11 (ite $x1197 v_0_tx_time_12 ?x1294)))))
 (let ((?x1300 (ite $x1187 v_0_tx_time_07 (ite $x1189 v_0_tx_time_08 (ite $x1191 v_0_tx_time_09 ?x1297)))))
 (let ((?x1303 (ite $x1182 (ite $x1183 v_0_tx_time_05 (ite $x1185 v_0_tx_time_06 ?x1300)) v_0_tx_time_04)))
 (let (($x1203 (= 11 ?x301)))
 (let ((?x1276 (ite $x1201 v_0_tx_time_13 (ite $x1203 v_0_tx_time_14 (ite (= 12 ?x301) v_0_tx_time_15 0)))))
 (let ((?x1279 (ite $x1195 v_0_tx_time_10 (ite $x1197 v_0_tx_time_11 (ite $x1199 v_0_tx_time_12 ?x1276)))))
 (let ((?x1282 (ite $x1189 v_0_tx_time_07 (ite $x1191 v_0_tx_time_08 (ite $x1193 v_0_tx_time_09 ?x1279)))))
 (let ((?x1285 (ite $x1183 v_0_tx_time_04 (ite $x1185 v_0_tx_time_05 (ite $x1187 v_0_tx_time_06 ?x1282)))))
 (let (($x1288 (= v_1_tx_time_03 (ite (or (>= 3 ?x799) $x1178) 0 (ite $x1182 ?x1285 v_0_tx_time_03)))))
 (let (($x1205 (= 12 ?x301)))
 (let ((?x1257 (ite $x1203 v_0_tx_time_13 (ite $x1205 v_0_tx_time_14 (ite (= 13 ?x301) v_0_tx_time_15 0)))))
 (let ((?x1260 (ite $x1197 v_0_tx_time_10 (ite $x1199 v_0_tx_time_11 (ite $x1201 v_0_tx_time_12 ?x1257)))))
 (let ((?x1263 (ite $x1191 v_0_tx_time_07 (ite $x1193 v_0_tx_time_08 (ite $x1195 v_0_tx_time_09 ?x1260)))))
 (let ((?x1266 (ite $x1185 v_0_tx_time_04 (ite $x1187 v_0_tx_time_05 (ite $x1189 v_0_tx_time_06 ?x1263)))))
 (let ((?x1269 (ite (or $x1178 (>= 2 ?x799)) 0 (ite $x1182 (ite $x1183 v_0_tx_time_03 ?x1266) v_0_tx_time_02))))
 (let (($x1207 (= 13 ?x301)))
 (let ((?x1237 (ite $x1205 v_0_tx_time_13 (ite $x1207 v_0_tx_time_14 (ite (= 14 ?x301) v_0_tx_time_15 0)))))
 (let ((?x1240 (ite $x1199 v_0_tx_time_10 (ite $x1201 v_0_tx_time_11 (ite $x1203 v_0_tx_time_12 ?x1237)))))
 (let ((?x1243 (ite $x1193 v_0_tx_time_07 (ite $x1195 v_0_tx_time_08 (ite $x1197 v_0_tx_time_09 ?x1240)))))
 (let ((?x1246 (ite $x1187 v_0_tx_time_04 (ite $x1189 v_0_tx_time_05 (ite $x1191 v_0_tx_time_06 ?x1243)))))
 (let ((?x1249 (ite $x1182 (ite $x1183 v_0_tx_time_02 (ite $x1185 v_0_tx_time_03 ?x1246)) v_0_tx_time_01)))
 (let (($x1209 (= 14 ?x301)))
 (let ((?x1215 (ite $x1207 v_0_tx_time_13 (ite $x1209 v_0_tx_time_14 (ite (= 15 ?x301) v_0_tx_time_15 0)))))
 (let ((?x1218 (ite $x1201 v_0_tx_time_10 (ite $x1203 v_0_tx_time_11 (ite $x1205 v_0_tx_time_12 ?x1215)))))
 (let ((?x1221 (ite $x1195 v_0_tx_time_07 (ite $x1197 v_0_tx_time_08 (ite $x1199 v_0_tx_time_09 ?x1218)))))
 (let ((?x1224 (ite $x1189 v_0_tx_time_04 (ite $x1191 v_0_tx_time_05 (ite $x1193 v_0_tx_time_06 ?x1221)))))
 (let ((?x1227 (ite $x1183 v_0_tx_time_01 (ite $x1185 v_0_tx_time_02 (ite $x1187 v_0_tx_time_03 ?x1224)))))
 (let (($x1231 (= v_1_tx_time_00 (ite (or (>= 0 ?x799) $x1178) 0 (ite $x1182 ?x1227 v_0_tx_time_00)))))
 (let (($x1164 (= v_1_rtt_sample_was_ambiguous (and v_0_rtt_active v_0_rtt_ambiguous))))
 (let (($x1159 (not v_1_rtt_start_new)))
 (let ((?x792 (* ?x273 ?x301)))
 (let ((?x1151 (+ ?x709 ?x792)))
 (let (($x1154 (and v_0_rtt_active $x297 $x323 $x327 (not (<= v_0_rtt_remaining ?x1151)))))
 (let (($x1135 (and v_0_rtt_active $x297 $x323 $x327 $x710)))
 (let (($x1157 (= v_1_rtt_remaining (ite $x1135 0 (ite $x1154 ?x1151 v_0_rtt_remaining)))))
 (let (($x1148 (= v_1_rtt_end v_0_rtt_end)))
 (let (($x1147 (= v_1_rtt_start_ms v_0_rtt_start_ms)))
 (let (($x1133 (= v_1_rtt_previous_measured (ite $x713 v_0_rtt_measured v_0_rtt_previous_measured))))
 (let (($x1126 (= v_1_rtt_previous_var (ite $x713 v_0_rttvar_ms v_0_rtt_previous_var))))
 (let (($x1122 (= v_1_rtt_previous_srtt (ite $x713 v_0_srtt_ms v_0_rtt_previous_srtt))))
 (let (($x1104 (= v_1_rx_fin_seq v_0_rx_fin_seq)))
 (let (($x1098 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x1094 (= v_1_fin_requested v_0_fin_requested)))
 (let ((?x813 (mod (+ input_0_net.data_seq (* ?x273 v_0_snd_wl1)) 4294967296)))
 (let (($x808 (<= 2147483648 (mod (+ input_0_net.data_ack (* ?x273 v_0_snd_wl2)) 4294967296))))
 (let (($x804 (= v_0_snd_wl1 input_0_net.data_seq)))
 (let (($x819 (or (and $x804 (not $x808)) (and (not (<= ?x813 0)) (not (<= 2147483648 ?x813))))))
 (let (($x820 (and $x297 $x327 $x819)))
 (let (($x1073 (= v_1_rx_slot_15 (ite (or (not (and $x358 (not $x640))) $x662) 0 ?x637))))
 (let (($x888 (not $x640)))
 (let (($x857 (not $x397)))
 (let (($x855 (not $x417)))
 (let (($x853 (not $x437)))
 (let (($x851 (not $x457)))
 (let (($x849 (not $x477)))
 (let (($x847 (not $x497)))
 (let (($x845 (not $x515)))
 (let (($x843 (not $x533)))
 (let (($x841 (not $x551)))
 (let (($x839 (not $x569)))
 (let (($x837 (not $x587)))
 (let (($x835 (not $x605)))
 (let (($x833 (not $x623)))
 (let (($x832 (and false $x641)))
 (let (($x834 (and $x832 $x833)))
 (let (($x836 (and $x834 $x835)))
 (let (($x838 (and $x836 $x837)))
 (let (($x840 (and $x838 $x839)))
 (let (($x842 (and $x840 $x841)))
 (let (($x844 (and $x842 $x843)))
 (let (($x846 (and $x844 $x845)))
 (let (($x848 (and $x846 $x847)))
 (let (($x850 (and $x848 $x849)))
 (let (($x852 (and $x850 $x851)))
 (let (($x854 (and $x852 $x853)))
 (let (($x856 (and $x854 $x855)))
 (let (($x859 (or $x360 $x376 (and $x856 $x857))))
 (let (($x1068 (= v_1_rx_slot_14 (ite $x662 0 (ite $x358 ?x686 (ite (and $x859 $x692 $x888) ?x637 0))))))
 (let (($x860 (and $x859 $x692)))
 (let ((?x1060 (ite $x860 ?x686 (ite (and (or $x856 $x397) (not $x377) $x692 $x888) ?x637 0))))
 (let (($x862 (not $x377)))
 (let (($x861 (or $x856 $x397)))
 (let (($x863 (and $x861 $x862 $x692)))
 (let ((?x1053 (ite $x863 ?x686 (ite (and (or $x854 $x417) $x857 $x862 $x692 $x888) ?x637 0))))
 (let (($x1057 (= v_1_rx_slot_12 (ite $x662 0 (ite $x358 ?x684 (ite $x860 ?x685 ?x1053))))))
 (let (($x864 (or $x854 $x417)))
 (let (($x865 (and $x864 $x857 $x862 $x692)))
 (let ((?x1045 (ite $x865 ?x686 (ite (and (or $x852 $x437) $x855 $x857 $x862 $x692 $x888) ?x637 0))))
 (let (($x1050 (= v_1_rx_slot_11 (ite $x662 0 (ite $x358 ?x683 (ite $x860 ?x684 (ite $x863 ?x685 ?x1045)))))))
 (let (($x866 (or $x852 $x437)))
 (let (($x867 (and $x866 $x855 $x857 $x862 $x692)))
 (let ((?x1036 (ite $x867 ?x686 (ite (and (or $x850 $x457) $x853 $x855 $x857 $x862 $x692 $x888) ?x637 0))))
 (let ((?x1041 (ite $x662 0 (ite $x358 ?x682 (ite $x860 ?x683 (ite $x863 ?x684 (ite $x865 ?x685 ?x1036)))))))
 (let ((?x1025 (ite (and (or $x848 $x477) $x851 $x853 $x855 $x857 $x862 $x692 $x888) ?x637 0)))
 (let (($x868 (or $x850 $x457)))
 (let (($x869 (and $x868 $x853 $x855 $x857 $x862 $x692)))
 (let ((?x1030 (ite $x860 ?x682 (ite $x863 ?x683 (ite $x865 ?x684 (ite $x867 ?x685 (ite $x869 ?x686 ?x1025)))))))
 (let ((?x1014 (ite (and (or $x846 $x497) $x849 $x851 $x853 $x855 $x857 $x862 $x692 $x888) ?x637 0)))
 (let (($x870 (or $x848 $x477)))
 (let (($x871 (and $x870 $x851 $x853 $x855 $x857 $x862 $x692)))
 (let ((?x1019 (ite $x863 ?x682 (ite $x865 ?x683 (ite $x867 ?x684 (ite $x869 ?x685 (ite $x871 ?x686 ?x1014)))))))
 (let (($x1023 (= v_1_rx_slot_08 (ite $x662 0 (ite $x358 ?x680 (ite $x860 ?x681 ?x1019))))))
 (let ((?x1002 (ite (and (or $x844 $x515) $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x692 $x888) ?x637 0)))
 (let (($x872 (or $x846 $x497)))
 (let (($x873 (and $x872 $x849 $x851 $x853 $x855 $x857 $x862 $x692)))
 (let ((?x1007 (ite $x865 ?x682 (ite $x867 ?x683 (ite $x869 ?x684 (ite $x871 ?x685 (ite $x873 ?x686 ?x1002)))))))
 (let (($x1012 (= v_1_rx_slot_07 (ite $x662 0 (ite $x358 ?x679 (ite $x860 ?x680 (ite $x863 ?x681 ?x1007)))))))
 (let (($x876 (or $x842 $x533)))
 (let ((?x989 (ite (and $x876 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x692 $x888) ?x637 0)))
 (let (($x874 (or $x844 $x515)))
 (let (($x875 (and $x874 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x692)))
 (let ((?x994 (ite $x867 ?x682 (ite $x869 ?x683 (ite $x871 ?x684 (ite $x873 ?x685 (ite $x875 ?x686 ?x989)))))))
 (let ((?x999 (ite $x662 0 (ite $x358 ?x678 (ite $x860 ?x679 (ite $x863 ?x680 (ite $x865 ?x681 ?x994)))))))
 (let (($x878 (or $x840 $x551)))
 (let ((?x975 (ite (and $x878 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x692 $x888) ?x637 0)))
 (let (($x877 (and $x876 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x692)))
 (let ((?x980 (ite $x869 ?x682 (ite $x871 ?x683 (ite $x873 ?x684 (ite $x875 ?x685 (ite $x877 ?x686 ?x975)))))))
 (let ((?x985 (ite $x358 ?x677 (ite $x860 ?x678 (ite $x863 ?x679 (ite $x865 ?x680 (ite $x867 ?x681 ?x980)))))))
 (let (($x880 (or $x838 $x569)))
 (let (($x959 (and $x880 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x692 $x888)))
 (let (($x879 (and $x878 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x692)))
 (let ((?x964 (ite $x873 ?x683 (ite $x875 ?x684 (ite $x877 ?x685 (ite $x879 ?x686 (ite $x959 ?x637 0)))))))
 (let ((?x969 (ite $x863 ?x678 (ite $x865 ?x679 (ite $x867 ?x680 (ite $x869 ?x681 (ite $x871 ?x682 ?x964)))))))
 (let (($x973 (= v_1_rx_slot_04 (ite $x662 0 (ite $x358 ?x676 (ite $x860 ?x677 ?x969))))))
 (let (($x882 (or $x836 $x587)))
 (let (($x943 (and $x882 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x692 $x888)))
 (let (($x881 (and $x880 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x692)))
 (let ((?x948 (ite $x875 ?x683 (ite $x877 ?x684 (ite $x879 ?x685 (ite $x881 ?x686 (ite $x943 ?x637 0)))))))
 (let ((?x953 (ite $x865 ?x678 (ite $x867 ?x679 (ite $x869 ?x680 (ite $x871 ?x681 (ite $x873 ?x682 ?x948)))))))
 (let (($x958 (= v_1_rx_slot_03 (ite $x662 0 (ite $x358 ?x675 (ite $x860 ?x676 (ite $x863 ?x677 ?x953)))))))
 (let (($x884 (or $x834 $x605)))
 (let (($x926 (and $x884 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x692 $x888)))
 (let (($x883 (and $x882 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x692)))
 (let ((?x931 (ite $x877 ?x683 (ite $x879 ?x684 (ite $x881 ?x685 (ite $x883 ?x686 (ite $x926 ?x637 0)))))))
 (let ((?x936 (ite $x867 ?x678 (ite $x869 ?x679 (ite $x871 ?x680 (ite $x873 ?x681 (ite $x875 ?x682 ?x931)))))))
 (let ((?x941 (ite $x662 0 (ite $x358 ?x674 (ite $x860 ?x675 (ite $x863 ?x676 (ite $x865 ?x677 ?x936)))))))
 (let (($x886 (or $x832 $x623)))
 (let (($x908 (and $x886 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x692 $x888)))
 (let (($x885 (and $x884 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x692)))
 (let ((?x913 (ite $x879 ?x683 (ite $x881 ?x684 (ite $x883 ?x685 (ite $x885 ?x686 (ite $x908 ?x637 0)))))))
 (let ((?x918 (ite $x869 ?x678 (ite $x871 ?x679 (ite $x873 ?x680 (ite $x875 ?x681 (ite $x877 ?x682 ?x913)))))))
 (let ((?x923 (ite $x358 ?x673 (ite $x860 ?x674 (ite $x863 ?x675 (ite $x865 ?x676 (ite $x867 ?x677 ?x918)))))))
 (let (($x889 (and $x641 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x692 $x888)))
 (let (($x887 (and $x886 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x692)))
 (let ((?x894 (ite $x881 ?x683 (ite $x883 ?x684 (ite $x885 ?x685 (ite $x887 ?x686 (ite $x889 ?x637 0)))))))
 (let ((?x899 (ite $x871 ?x678 (ite $x873 ?x679 (ite $x875 ?x680 (ite $x877 ?x681 (ite $x879 ?x682 ?x894)))))))
 (let ((?x904 (ite $x860 ?x673 (ite $x863 ?x674 (ite $x865 ?x675 (ite $x867 ?x676 (ite $x869 ?x677 ?x899)))))))
 (let (($x830 (= v_1_take v_0_take)))
 (let (($x790 (= v_1_snd_buf v_0_snd_buf)))
 (let (($x784 (= v_1_msl_ms v_0_msl_ms)))
 (let (($x781 (= v_1_user_timeout_ms v_0_user_timeout_ms)))
 (let (($x778 (= v_1_active_open v_0_active_open)))
 (let (($x775 (= v_1_retries v_0_retries)))
 (let (($x705 (= v_1_tx_flags v_0_tx_flags)))
 (let (($x702 (= v_1_tx_ack v_0_tx_ack)))
 (let (($x701 (= v_1_tx_seq v_0_tx_seq)))
 (let (($x700 (= v_1_rcv_nxt (mod (+ v_0_rcv_nxt ?x696 (ite $x662 1 0)) 4294967296))))
 (let (($x671 (= v_1_snd_nxt v_0_snd_nxt)))
 (let (($x667 (= v_1_irs v_0_irs)))
 (let (($x666 (= v_1_iss v_0_iss)))
 (let (($x308 (not (= (mod (+ input_0_net.data_ack (* ?x273 v_0_snd_nxt)) 4294967296) 2147483648))))
 (and (>= now_1 now_0) $x270 (>= 16 input_0_net.data_data) (not (= ?x276 2147483648)) (<= 0 input_0_net.data_window) (>= 65535 input_0_net.data_window) (or (not $x297) (and (not (= ?x301 2147483648)) $x308)) (or (not active_0_rtx) (not (<= due_0_rtx now_1))) (or (not active_0_user) (not (<= due_0_user now_1))) (or (not active_0_time_wait) (not (<= due_0_time_wait now_1))) (or $x201 (not (<= due_0_delack now_1))) $x330 $x663 $x665 $x666 $x667 (= v_1_snd_una (ite $x668 input_0_net.data_ack v_0_snd_una)) $x671 $x700 $x701 $x702 $x705 (= v_1_rto_ms ?x771) $x775 $x778 $x781 $x784 (= v_1_local_window (+ 16 ?x786 ?x787)) $x790 (= v_1_rtx_buf ?x799) (= v_1_rcv_buf (+ v_0_rcv_buf ?x696)) (= v_1_snd_wnd (ite $x820 input_0_net.data_window v_0_snd_wnd)) (= v_1_snd_wl1 (ite $x820 input_0_net.data_seq v_0_snd_wl1)) (= v_1_snd_wl2 (ite $x820 input_0_net.data_ack v_0_snd_wl2)) $x830 (= v_1_rx_chunk ?x696) (= v_1_rx_slot_00 (ite $x662 0 (ite $x358 ?x672 ?x904))) (= v_1_rx_slot_01 (ite $x662 0 ?x923)) (= v_1_rx_slot_02 ?x941) $x958 $x973 (= v_1_rx_slot_05 (ite $x662 0 ?x985)) (= v_1_rx_slot_06 ?x999) $x1012 $x1023 (= v_1_rx_slot_09 (ite $x662 0 (ite $x358 ?x681 ?x1030))) (= v_1_rx_slot_10 ?x1041) $x1050 $x1057 (= v_1_rx_slot_13 (ite $x662 0 (ite $x358 ?x685 ?x1060))) $x1068 $x1073 (= v_1_rx_advance (ite $x358 0 ?x656)) (= v_1_rx_acceptable (and $x297 $x340 $x333)) (= v_1_seg_acceptable $x297) (= v_1_ack_delta ?x301) (= v_1_ack_is_new (and $x323 $x327)) (= v_1_ack_is_future $x339) (= v_1_ack_advance $x668) (= v_1_ack_window_update $x820) $x1094 (= v_1_fin_sent $x1096) $x1098 (= v_1_fin_acknowledged $x329) (= v_1_rx_fin_pending (and v_0_rx_fin_pending $x663)) $x1104 (= v_1_rx_fin_offset (ite $x662 0 ?x660)) (= v_1_rx_fin_done (or v_0_rx_fin_done $x662)) (= v_1_rx_fin_consumed $x662) (= v_1_srtt_ms ?x733) (= v_1_rttvar_ms ?x756) (= v_1_rtt_error_ms ?x749) $x1122 $x1126 (= v_1_rtt_measured (or v_0_rtt_measured $x713)) $x1133 (= v_1_rtt_active (and v_0_rtt_active (not $x1135))) (= v_1_rtt_ambiguous (and (not $x1135) v_0_rtt_ambiguous)) (= v_1_rtt_sample_at_ms (ite $x713 now_1 v_0_rtt_sample_at_ms)) $x1147 $x1148 $x1157 $x1159 (= v_1_rtt_sample_used $x713) $x1164 (= v_1_rtt_last_ms ?x728) (= v_1_rtt_samples (+ v_0_rtt_samples (ite $x713 1 0))) (= v_1_rto_base_ms (ite $x713 ?x769 v_0_rto_base_ms)) $x1231 (= v_1_tx_time_01 (ite (or (>= 1 ?x799) $x1178) 0 ?x1249)) (= v_1_tx_time_02 ?x1269) $x1288 (= v_1_tx_time_04 (ite (or (>= 4 ?x799) $x1178) 0 ?x1303)) (= v_1_tx_time_05 ?x1320) $x1336 (= v_1_tx_time_07 (ite (or (>= 7 ?x799) $x1178) 0 ?x1348)) (= v_1_tx_time_08 ?x1362) $x1375 (= v_1_tx_time_10 (ite (or (>= 10 ?x799) $x1178) 0 ?x1384)) (= v_1_tx_time_11 ?x1395) $x1405 (= v_1_tx_time_13 (ite (or (>= 13 ?x799) $x1178) 0 ?x1411)) (= v_1_tx_time_14 ?x1419) $x1425 (= v_1_tx_fin_time (ite $x1096 v_0_tx_fin_time 0)) $x1432 $x1435 $x1438 $x1440 $x1443 $x1446 $x1449 $x1451 $x1453 $x1455 $x1457 (= v_1_ack_pending $x1481) $x1489 (= v_1_ack_bytes (ite $x1479 ?x1469 0)) (= v_1_ack_full_segments (ite $x1479 ?x1476 0)) $x1498 $x1500 (= v_1_ack_defer_candidate $x1502) (= v_1_ack_defer_now $x1479) (= active_1_rtx (and $x665 $x1515)) (= active_1_user (and $x665 active_0_user)) (= active_1_time_wait (or active_0_time_wait $x664)) (= active_1_delack $x1527) (= due_1_rtx (ite $x1510 (+ now_1 ?x771) due_0_rtx)) $x1534 (= due_1_time_wait (ite $x664 ?x1537 due_0_time_wait)) (= due_1_delack (ite $x1525 ?x1541 due_0_delack))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
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
 (let ((?x1549 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1549)))
(assert
 (>= 16 v_0_rcv_buf))
(assert
 (and (<= 0 v_0_snd_wnd) (>= 65535 v_0_snd_wnd)))
(assert
 (= v_0_local_window (+ 16 (* (- 1) v_0_rcv_buf))))
(assert
 (>= 1 v_0_rx_slot_00))
(assert
 (let (($x341 (= 0 v_0_rx_slot_00)))
 (let (($x1559 (not (>= v_0_rcv_buf 16))))
 (or $x1559 $x341))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x361 (= 0 v_0_rx_slot_01)))
 (let (($x1563 (not (>= v_0_rcv_buf 15))))
 (or $x1563 $x361))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x378 (= 0 v_0_rx_slot_02)))
 (let (($x1567 (not (>= v_0_rcv_buf 14))))
 (or $x1567 $x378))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x398 (= 0 v_0_rx_slot_03)))
 (let (($x1571 (not (>= v_0_rcv_buf 13))))
 (or $x1571 $x398))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x421 (= 0 v_0_rx_slot_04)))
 (let (($x1575 (not (>= v_0_rcv_buf 12))))
 (or $x1575 $x421))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x438 (= 0 v_0_rx_slot_05)))
 (let (($x1579 (not (>= v_0_rcv_buf 11))))
 (or $x1579 $x438))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x461 (= 0 v_0_rx_slot_06)))
 (let (($x1583 (not (>= v_0_rcv_buf 10))))
 (or $x1583 $x461))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x481 (= 0 v_0_rx_slot_07)))
 (let (($x1587 (not (>= v_0_rcv_buf 9))))
 (or $x1587 $x481))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x500 (= 0 v_0_rx_slot_08)))
 (let (($x1591 (not (>= v_0_rcv_buf 8))))
 (or $x1591 $x500))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x518 (= 0 v_0_rx_slot_09)))
 (let (($x1595 (not (>= v_0_rcv_buf 7))))
 (or $x1595 $x518))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x534 (= 0 v_0_rx_slot_10)))
 (let (($x1599 (not (>= v_0_rcv_buf 6))))
 (or $x1599 $x534))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x554 (= 0 v_0_rx_slot_11)))
 (let (($x1603 (not (>= v_0_rcv_buf 5))))
 (or $x1603 $x554))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x570 (= 0 v_0_rx_slot_12)))
 (let (($x1607 (not (>= v_0_rcv_buf 4))))
 (or $x1607 $x570))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x590 (= 0 v_0_rx_slot_13)))
 (let (($x1611 (not (>= v_0_rcv_buf 3))))
 (or $x1611 $x590))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x608 (= 0 v_0_rx_slot_14)))
 (let (($x1615 (not (>= v_0_rcv_buf 2))))
 (or $x1615 $x608))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x624 (= 0 v_0_rx_slot_15)))
 (let (($x1619 (not (>= v_0_rcv_buf 1))))
 (or $x1619 $x624))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x1621 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x1621)))
(assert
 (and (<= 0 v_0_rx_advance) (>= 16 v_0_rx_advance)))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (and (<= 0 v_0_ack_delta) (>= 4294967295 v_0_ack_delta)))
(assert
 true)
(assert
 (let ((?x1633 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x1633)))
(assert
 (= active_0_rtx (<= 1 (+ v_0_rtx_buf (ite v_0_fin_sent 1 0)))))
(assert
 (let (($x1642 (and v_0_fin_requested (= v_0_fin_seq (mod (+ v_0_snd_una v_0_rtx_buf) 4294967296)) (= 0 v_0_snd_buf))))
 (let (($x1637 (not v_0_fin_sent)))
 (or $x1637 $x1642))))
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
 (let (($x1644 (<= 1 v_0_rx_fin_offset)))
 (let (($x333 (not v_0_rx_fin_done)))
 (let (($x1646 (and $x333 $x1644 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window)))))
 (let (($x1463 (not v_0_rx_fin_pending)))
 (or $x1463 $x1646))))))
(assert
 (let (($x639 (>= 15 v_0_rx_fin_offset)))
 (and (<= 0 v_0_rx_fin_offset) $x639 (= v_0_rx_fin_pending (<= 1 v_0_rx_fin_offset)))))
(assert
 (let (($x1463 (not v_0_rx_fin_pending)))
 (or $x1463 (= v_0_rx_fin_seq (mod (+ v_0_rcv_nxt v_0_rx_fin_offset) 4294967296)))))
(assert
 (let (($x333 (not v_0_rx_fin_done)))
 (or $x333 (= v_0_rcv_nxt (mod (+ 1 v_0_rx_fin_seq) 4294967296)))))
(assert
 (let (($x341 (= 0 v_0_rx_slot_00)))
 (or (not (and v_0_rx_fin_pending (>= 0 v_0_rx_fin_offset))) $x341)))
(assert
 (let (($x361 (= 0 v_0_rx_slot_01)))
 (or (not (and v_0_rx_fin_pending (>= 1 v_0_rx_fin_offset))) $x361)))
(assert
 (let (($x378 (= 0 v_0_rx_slot_02)))
 (or (not (and v_0_rx_fin_pending (>= 2 v_0_rx_fin_offset))) $x378)))
(assert
 (let (($x398 (= 0 v_0_rx_slot_03)))
 (or (not (and v_0_rx_fin_pending (>= 3 v_0_rx_fin_offset))) $x398)))
(assert
 (let (($x421 (= 0 v_0_rx_slot_04)))
 (or (not (and v_0_rx_fin_pending (>= 4 v_0_rx_fin_offset))) $x421)))
(assert
 (let (($x438 (= 0 v_0_rx_slot_05)))
 (or (not (and v_0_rx_fin_pending (>= 5 v_0_rx_fin_offset))) $x438)))
(assert
 (let (($x461 (= 0 v_0_rx_slot_06)))
 (or (not (and v_0_rx_fin_pending (>= 6 v_0_rx_fin_offset))) $x461)))
(assert
 (let (($x481 (= 0 v_0_rx_slot_07)))
 (or (not (and v_0_rx_fin_pending (>= 7 v_0_rx_fin_offset))) $x481)))
(assert
 (let (($x500 (= 0 v_0_rx_slot_08)))
 (or (not (and v_0_rx_fin_pending (>= 8 v_0_rx_fin_offset))) $x500)))
(assert
 (let (($x518 (= 0 v_0_rx_slot_09)))
 (or (not (and v_0_rx_fin_pending (>= 9 v_0_rx_fin_offset))) $x518)))
(assert
 (let (($x534 (= 0 v_0_rx_slot_10)))
 (or (not (and v_0_rx_fin_pending (>= 10 v_0_rx_fin_offset))) $x534)))
(assert
 (let (($x554 (= 0 v_0_rx_slot_11)))
 (or (not (and v_0_rx_fin_pending (>= 11 v_0_rx_fin_offset))) $x554)))
(assert
 (let (($x570 (= 0 v_0_rx_slot_12)))
 (or (not (and v_0_rx_fin_pending (>= 12 v_0_rx_fin_offset))) $x570)))
(assert
 (let (($x590 (= 0 v_0_rx_slot_13)))
 (or (not (and v_0_rx_fin_pending (>= 13 v_0_rx_fin_offset))) $x590)))
(assert
 (let (($x608 (= 0 v_0_rx_slot_14)))
 (or (not (and v_0_rx_fin_pending (>= 14 v_0_rx_fin_offset))) $x608)))
(assert
 (let (($x624 (= 0 v_0_rx_slot_15)))
 (let (($x639 (>= 15 v_0_rx_fin_offset)))
 (let (($x640 (and v_0_rx_fin_pending $x639)))
 (let (($x888 (not $x640)))
 (or $x888 $x624))))))
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
 (let ((?x1704 (* 4.0 v_0_rttvar_ms)))
 (let ((?x716 (- 1.0)))
 (let ((?x745 (* ?x716 v_0_srtt_ms)))
 (let ((?x1707 (+ ?x745 (* ?x716 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x1704)))))
 (let ((?x1708 (to_int ?x1707)))
 (let ((?x273 (- 1)))
 (let ((?x1711 (ite (<= ?x1708 (- 1000)) (* ?x273 ?x1708) 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x1711) 60000 ?x1711) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x709 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x1726 (and (<= v_0_rtt_start_ms now_0) (<= 1 v_0_rtt_remaining) (>= 4 v_0_rtt_remaining) (>= ?x709 v_0_rtt_remaining) (<= ?x709 (mod (+ v_0_snd_nxt (* (- 1) v_0_snd_una)) 4294967296)))))
 (let (($x1718 (not v_0_rtt_active)))
 (or $x1718 $x1726)))))
(assert
 (or v_0_rtt_active (= 0 v_0_rtt_remaining)))
(assert
 true)
(assert
 (let (($x1735 (= v_0_rtt_last_ms (+ v_0_rtt_sample_at_ms (* (- 1) v_0_rtt_start_ms)))))
 (let (($x1733 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1731 (not v_0_rtt_sample_used)))
 (or $x1731 (and $x1733 v_0_rtt_measured $x1735))))))
(assert
 (and (<= 0 v_0_rtt_sample_at_ms) (<= v_0_rtt_sample_at_ms now_0)))
(assert
 (let ((?x1742 (to_real v_0_rtt_last_ms)))
 (let ((?x1756 (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x1742))))
 (let ((?x1744 (+ v_0_rtt_previous_srtt (* (- 1.0) ?x1742))))
 (let ((?x1748 (ite (>= ?x1744 0.0) ?x1744 (+ (* (- 1.0) v_0_rtt_previous_srtt) ?x1742))))
 (let ((?x740 (/ 1.0 4.0)))
 (let ((?x1752 (ite v_0_rtt_previous_measured (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* ?x740 ?x1748)) (* (/ 1.0 2.0) ?x1742))))
 (let (($x1759 (and (= v_0_rttvar_ms ?x1752) (= v_0_srtt_ms (ite v_0_rtt_previous_measured ?x1756 ?x1742)))))
 (let (($x1731 (not v_0_rtt_sample_used)))
 (or $x1731 $x1759))))))))))
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
 (let (($x1895 (and (>= v_0_tx_elapsed v_0_tx_previous_rto) (<= 1 v_0_tx_emit_count) (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x1889 (not v_0_tx_retransmitted)))
 (or $x1889 $x1895))))
(assert
 (let (($x1889 (not v_0_tx_retransmitted)))
 (let (($x1898 (not v_0_tx_waiting)))
 (or $x1898 $x1889))))
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
 (let (($x1484 (not v_0_ack_pending)))
 (or $x1484 (and (<= 1 v_0_ack_bytes) (not v_0_rx_fin_done)))))
(assert
 (let (($x1928 (and (= 0 v_0_ack_bytes) (= 0 v_0_ack_full_segments) (= 0 v_0_ack_since_ms))))
 (or v_0_ack_pending $x1928)))
(assert
 (= 157 choice_0))
(assert
 (= 5 state_0))
(assert
 (= 5 state_1))
(assert
 (or (not (>= 4 v_1_tx_emit_count))))
(check-sat)
