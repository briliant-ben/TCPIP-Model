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
(declare-fun v_0_msl_ms () Int)
(declare-fun now_1 () Int)
(declare-fun v_0_fin_sent () Bool)
(declare-fun v_0_local_window () Int)
(declare-fun v_0_rx_fin_offset () Int)
(declare-fun v_0_rx_fin_done () Bool)
(declare-fun v_0_rx_fin_pending () Bool)
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
(declare-fun active_1_time_wait () Bool)
(declare-fun active_1_user () Bool)
(declare-fun active_1_rtx () Bool)
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
 (let ((?x1470 (+ now_1 (* 2 v_0_msl_ms))))
 (let ((?x317 (ite v_0_fin_sent 1 0)))
 (let ((?x318 (+ v_0_rtx_buf ?x317)))
 (let ((?x296 (mod (+ input_0_net.data_ack (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x320 (= ?x296 ?x318)))
 (let (($x319 (<= ?x296 ?x318)))
 (let (($x315 (<= 1 ?x296)))
 (let ((?x268 (- 1)))
 (let ((?x285 (+ ?x268 v_0_local_window)))
 (let (($x280 (<= 1 v_0_local_window)))
 (let (($x291 (and $x280 (<= (mod (+ input_0_net.data_seq (* ?x268 v_0_rcv_nxt)) 4294967296) ?x285))))
 (let ((?x282 (* ?x268 v_0_rcv_nxt)))
 (let (($x286 (<= (mod (+ 4294967295 input_0_net.data_seq input_0_net.data_data ?x282) 4294967296) ?x285)))
 (let (($x292 (or (and $x280 $x286) $x291)))
 (let ((?x621 (mod (+ 15 v_0_rcv_nxt (* ?x268 input_0_net.data_seq)) 4294967296)))
 (let ((?x626 (+ input_0_net.data_data (* ?x268 ?x621))))
 (let (($x624 (<= input_0_net.data_data ?x621)))
 (let (($x619 (<= v_0_rcv_buf 0)))
 (let (($x618 (= 0 v_0_rx_slot_15)))
 (let (($x325 (not v_0_rx_fin_done)))
 (let (($x331 (and (>= ?x296 (+ 1 v_0_rtx_buf ?x317)) (>= 2147483647 ?x296))))
 (let (($x332 (not $x331)))
 (let (($x623 (and $x292 $x332 $x325 $x618 $x619 (<= ?x621 (+ ?x268 input_0_net.data_data)))))
 (let ((?x631 (ite $x623 (ite (or $x624 (<= ?x626 1)) (ite $x624 0 ?x626) 1) v_0_rx_slot_15)))
 (let (($x616 (>= 15 v_0_rx_fin_offset)))
 (let (($x617 (and v_0_rx_fin_pending $x616)))
 (let (($x633 (or $x617 (= ?x631 0))))
 (let ((?x603 (mod (+ 14 v_0_rcv_nxt (* ?x268 input_0_net.data_seq)) 4294967296)))
 (let ((?x608 (+ input_0_net.data_data (* ?x268 ?x603))))
 (let (($x606 (<= input_0_net.data_data ?x603)))
 (let (($x601 (<= v_0_rcv_buf 1)))
 (let (($x600 (= 0 v_0_rx_slot_14)))
 (let (($x605 (and $x292 $x332 $x325 $x600 $x601 (<= ?x603 (+ ?x268 input_0_net.data_data)))))
 (let ((?x613 (ite $x605 (ite (or $x606 (<= ?x608 1)) (ite $x606 0 ?x608) 1) v_0_rx_slot_14)))
 (let (($x599 (and v_0_rx_fin_pending (>= 14 v_0_rx_fin_offset))))
 (let (($x615 (or $x599 (= ?x613 0))))
 (let ((?x585 (mod (+ 13 v_0_rcv_nxt (* ?x268 input_0_net.data_seq)) 4294967296)))
 (let ((?x590 (+ input_0_net.data_data (* ?x268 ?x585))))
 (let (($x588 (<= input_0_net.data_data ?x585)))
 (let (($x583 (<= v_0_rcv_buf 2)))
 (let (($x582 (= 0 v_0_rx_slot_13)))
 (let (($x587 (and $x292 $x332 $x325 $x582 $x583 (<= ?x585 (+ ?x268 input_0_net.data_data)))))
 (let ((?x595 (ite $x587 (ite (or $x588 (<= ?x590 1)) (ite $x588 0 ?x590) 1) v_0_rx_slot_13)))
 (let (($x581 (and v_0_rx_fin_pending (>= 13 v_0_rx_fin_offset))))
 (let (($x597 (or $x581 (= ?x595 0))))
 (let (($x578 (and v_0_rx_fin_pending (>= 12 v_0_rx_fin_offset))))
 (let ((?x565 (mod (+ 12 v_0_rcv_nxt (* ?x268 input_0_net.data_seq)) 4294967296)))
 (let ((?x570 (+ input_0_net.data_data (* ?x268 ?x565))))
 (let (($x568 (<= input_0_net.data_data ?x565)))
 (let (($x563 (<= v_0_rcv_buf 3)))
 (let (($x562 (= 0 v_0_rx_slot_12)))
 (let (($x567 (and $x292 $x332 $x325 $x562 $x563 (<= ?x565 (+ ?x268 input_0_net.data_data)))))
 (let ((?x575 (ite $x567 (ite (or $x568 (<= ?x570 1)) (ite $x568 0 ?x570) 1) v_0_rx_slot_12)))
 (let (($x579 (or (= ?x575 0) $x578)))
 (let ((?x637 (ite $x579 12 (ite $x597 13 (ite $x615 14 (ite $x633 15 16))))))
 (let (($x560 (and v_0_rx_fin_pending (>= 11 v_0_rx_fin_offset))))
 (let ((?x547 (mod (+ 11 v_0_rcv_nxt (* ?x268 input_0_net.data_seq)) 4294967296)))
 (let ((?x552 (+ input_0_net.data_data (* ?x268 ?x547))))
 (let (($x550 (<= input_0_net.data_data ?x547)))
 (let (($x545 (<= v_0_rcv_buf 4)))
 (let (($x544 (= 0 v_0_rx_slot_11)))
 (let (($x549 (and $x292 $x332 $x325 $x544 $x545 (<= ?x547 (+ ?x268 input_0_net.data_data)))))
 (let ((?x557 (ite $x549 (ite (or $x550 (<= ?x552 1)) (ite $x550 0 ?x552) 1) v_0_rx_slot_11)))
 (let (($x561 (or (= ?x557 0) $x560)))
 (let ((?x531 (mod (+ 10 v_0_rcv_nxt (* ?x268 input_0_net.data_seq)) 4294967296)))
 (let ((?x536 (+ input_0_net.data_data (* ?x268 ?x531))))
 (let (($x534 (<= input_0_net.data_data ?x531)))
 (let (($x529 (<= v_0_rcv_buf 5)))
 (let (($x528 (= 0 v_0_rx_slot_10)))
 (let (($x533 (and $x292 $x332 $x325 $x528 $x529 (<= ?x531 (+ ?x268 input_0_net.data_data)))))
 (let ((?x541 (ite $x533 (ite (or $x534 (<= ?x536 1)) (ite $x534 0 ?x536) 1) v_0_rx_slot_10)))
 (let (($x527 (and v_0_rx_fin_pending (>= 10 v_0_rx_fin_offset))))
 (let (($x543 (or $x527 (= ?x541 0))))
 (let (($x524 (and v_0_rx_fin_pending (>= 9 v_0_rx_fin_offset))))
 (let ((?x511 (mod (+ 9 v_0_rcv_nxt (* ?x268 input_0_net.data_seq)) 4294967296)))
 (let ((?x516 (+ input_0_net.data_data (* ?x268 ?x511))))
 (let (($x514 (<= input_0_net.data_data ?x511)))
 (let (($x509 (<= v_0_rcv_buf 6)))
 (let (($x508 (= 0 v_0_rx_slot_09)))
 (let (($x513 (and $x292 $x332 $x325 $x508 $x509 (<= ?x511 (+ ?x268 input_0_net.data_data)))))
 (let ((?x521 (ite $x513 (ite (or $x514 (<= ?x516 1)) (ite $x514 0 ?x516) 1) v_0_rx_slot_09)))
 (let (($x525 (or (= ?x521 0) $x524)))
 (let (($x506 (and v_0_rx_fin_pending (>= 8 v_0_rx_fin_offset))))
 (let ((?x493 (mod (+ 8 v_0_rcv_nxt (* ?x268 input_0_net.data_seq)) 4294967296)))
 (let ((?x498 (+ input_0_net.data_data (* ?x268 ?x493))))
 (let (($x496 (<= input_0_net.data_data ?x493)))
 (let (($x491 (<= v_0_rcv_buf 7)))
 (let (($x490 (= 0 v_0_rx_slot_08)))
 (let (($x495 (and $x292 $x332 $x325 $x490 $x491 (<= ?x493 (+ ?x268 input_0_net.data_data)))))
 (let ((?x503 (ite $x495 (ite (or $x496 (<= ?x498 1)) (ite $x496 0 ?x498) 1) v_0_rx_slot_08)))
 (let (($x507 (or (= ?x503 0) $x506)))
 (let ((?x641 (ite $x507 8 (ite $x525 9 (ite $x543 10 (ite $x561 11 ?x637))))))
 (let ((?x477 (mod (+ 7 v_0_rcv_nxt (* ?x268 input_0_net.data_seq)) 4294967296)))
 (let ((?x482 (+ input_0_net.data_data (* ?x268 ?x477))))
 (let (($x480 (<= input_0_net.data_data ?x477)))
 (let (($x475 (<= v_0_rcv_buf 8)))
 (let (($x473 (= 0 v_0_rx_slot_07)))
 (let (($x479 (and $x292 $x332 $x325 $x473 $x475 (<= ?x477 (+ ?x268 input_0_net.data_data)))))
 (let ((?x487 (ite $x479 (ite (or $x480 (<= ?x482 1)) (ite $x480 0 ?x482) 1) v_0_rx_slot_07)))
 (let (($x472 (and v_0_rx_fin_pending (>= 7 v_0_rx_fin_offset))))
 (let (($x489 (or $x472 (= ?x487 0))))
 (let ((?x457 (mod (+ 6 v_0_rcv_nxt (* ?x268 input_0_net.data_seq)) 4294967296)))
 (let ((?x462 (+ input_0_net.data_data (* ?x268 ?x457))))
 (let (($x460 (<= input_0_net.data_data ?x457)))
 (let (($x455 (<= v_0_rcv_buf 9)))
 (let (($x453 (= 0 v_0_rx_slot_06)))
 (let (($x459 (and $x292 $x332 $x325 $x453 $x455 (<= ?x457 (+ ?x268 input_0_net.data_data)))))
 (let ((?x467 (ite $x459 (ite (or $x460 (<= ?x462 1)) (ite $x460 0 ?x462) 1) v_0_rx_slot_06)))
 (let (($x452 (and v_0_rx_fin_pending (>= 6 v_0_rx_fin_offset))))
 (let (($x469 (or $x452 (= ?x467 0))))
 (let ((?x437 (mod (+ 5 v_0_rcv_nxt (* ?x268 input_0_net.data_seq)) 4294967296)))
 (let ((?x442 (+ input_0_net.data_data (* ?x268 ?x437))))
 (let (($x440 (<= input_0_net.data_data ?x437)))
 (let (($x435 (<= v_0_rcv_buf 10)))
 (let (($x433 (= 0 v_0_rx_slot_05)))
 (let (($x439 (and $x292 $x332 $x325 $x433 $x435 (<= ?x437 (+ ?x268 input_0_net.data_data)))))
 (let ((?x447 (ite $x439 (ite (or $x440 (<= ?x442 1)) (ite $x440 0 ?x442) 1) v_0_rx_slot_05)))
 (let (($x432 (and v_0_rx_fin_pending (>= 5 v_0_rx_fin_offset))))
 (let (($x449 (or $x432 (= ?x447 0))))
 (let ((?x417 (mod (+ 4 v_0_rcv_nxt (* ?x268 input_0_net.data_seq)) 4294967296)))
 (let ((?x422 (+ input_0_net.data_data (* ?x268 ?x417))))
 (let (($x420 (<= input_0_net.data_data ?x417)))
 (let (($x415 (<= v_0_rcv_buf 11)))
 (let (($x413 (= 0 v_0_rx_slot_04)))
 (let (($x419 (and $x292 $x332 $x325 $x413 $x415 (<= ?x417 (+ ?x268 input_0_net.data_data)))))
 (let ((?x427 (ite $x419 (ite (or $x420 (<= ?x422 1)) (ite $x420 0 ?x422) 1) v_0_rx_slot_04)))
 (let (($x412 (and v_0_rx_fin_pending (>= 4 v_0_rx_fin_offset))))
 (let (($x429 (or $x412 (= ?x427 0))))
 (let ((?x645 (ite $x429 4 (ite $x449 5 (ite $x469 6 (ite $x489 7 ?x641))))))
 (let (($x408 (and v_0_rx_fin_pending (>= 3 v_0_rx_fin_offset))))
 (let ((?x395 (mod (+ 3 v_0_rcv_nxt (* ?x268 input_0_net.data_seq)) 4294967296)))
 (let ((?x400 (+ input_0_net.data_data (* ?x268 ?x395))))
 (let (($x398 (<= input_0_net.data_data ?x395)))
 (let (($x392 (<= v_0_rcv_buf 12)))
 (let (($x390 (= 0 v_0_rx_slot_03)))
 (let (($x397 (and $x292 $x332 $x325 $x390 $x392 (<= ?x395 (+ ?x268 input_0_net.data_data)))))
 (let ((?x405 (ite $x397 (ite (or $x398 (<= ?x400 1)) (ite $x398 0 ?x400) 1) v_0_rx_slot_03)))
 (let (($x409 (or (= ?x405 0) $x408)))
 (let ((?x377 (mod (+ 2 v_0_rcv_nxt (* ?x268 input_0_net.data_seq)) 4294967296)))
 (let ((?x382 (+ input_0_net.data_data (* ?x268 ?x377))))
 (let (($x380 (<= input_0_net.data_data ?x377)))
 (let (($x375 (<= v_0_rcv_buf 13)))
 (let (($x373 (= 0 v_0_rx_slot_02)))
 (let (($x379 (and $x292 $x332 $x325 $x373 $x375 (<= ?x377 (+ ?x268 input_0_net.data_data)))))
 (let ((?x387 (ite $x379 (ite (or $x380 (<= ?x382 1)) (ite $x380 0 ?x382) 1) v_0_rx_slot_02)))
 (let (($x372 (and v_0_rx_fin_pending (>= 2 v_0_rx_fin_offset))))
 (let (($x389 (or $x372 (= ?x387 0))))
 (let ((?x357 (mod (+ 1 v_0_rcv_nxt (* ?x268 input_0_net.data_seq)) 4294967296)))
 (let ((?x362 (+ input_0_net.data_data (* ?x268 ?x357))))
 (let (($x360 (<= input_0_net.data_data ?x357)))
 (let (($x355 (<= v_0_rcv_buf 14)))
 (let (($x353 (= 0 v_0_rx_slot_01)))
 (let (($x359 (and $x292 $x332 $x325 $x353 $x355 (<= ?x357 (+ ?x268 input_0_net.data_data)))))
 (let ((?x367 (ite $x359 (ite (or $x360 (<= ?x362 1)) (ite $x360 0 ?x362) 1) v_0_rx_slot_01)))
 (let (($x368 (= ?x367 0)))
 (let (($x352 (and v_0_rx_fin_pending (>= 1 v_0_rx_fin_offset))))
 (let (($x369 (or $x352 $x368)))
 (let ((?x648 (ite $x369 1 (ite $x389 2 (ite $x409 3 ?x645)))))
 (let (($x349 (and v_0_rx_fin_pending (>= 0 v_0_rx_fin_offset))))
 (let ((?x341 (+ input_0_net.data_data (* ?x268 (mod (+ v_0_rcv_nxt (* ?x268 input_0_net.data_seq)) 4294967296)))))
 (let ((?x271 (mod (+ v_0_rcv_nxt (* ?x268 input_0_net.data_seq)) 4294967296)))
 (let (($x339 (<= input_0_net.data_data ?x271)))
 (let (($x335 (<= v_0_rcv_buf 15)))
 (let (($x333 (= 0 v_0_rx_slot_00)))
 (let (($x338 (and $x292 $x332 $x325 $x333 $x335 (<= ?x271 (+ ?x268 input_0_net.data_data)))))
 (let ((?x346 (ite $x338 (ite (or $x339 (<= ?x341 1)) (ite $x339 0 ?x341) 1) v_0_rx_slot_00)))
 (let (($x350 (or (= ?x346 0) $x349)))
 (let ((?x649 (ite $x350 0 ?x648)))
 (let ((?x652 (ite v_0_rx_fin_pending (+ v_0_rx_fin_offset (* ?x268 ?x649)) v_0_rx_fin_offset)))
 (let (($x653 (= 0 ?x652)))
 (let (($x656 (and v_0_rx_fin_pending $x325 $x653 $x292 $x315 $x319 v_0_fin_sent $x320)))
 (let (($x1467 (= due_1_user due_0_user)))
 (let (($x704 (not v_0_rtt_ambiguous)))
 (let ((?x701 (mod (+ v_0_rtt_end (* ?x268 v_0_snd_una)) 4294967296)))
 (let (($x702 (>= ?x296 ?x701)))
 (let (($x705 (and v_0_rtt_active $x292 $x315 $x319 $x702 $x704)))
 (let ((?x720 (ite $x705 (+ now_1 (* ?x268 v_0_rtt_start_ms)) v_0_rtt_last_ms)))
 (let ((?x721 (to_real ?x720)))
 (let ((?x745 (/ 1.0 2.0)))
 (let ((?x734 (+ v_0_srtt_ms (* (- 1.0) ?x721))))
 (let ((?x741 (ite $x705 (ite (>= ?x734 0.0) ?x734 (+ (* (- 1.0) v_0_srtt_ms) ?x721)) v_0_rtt_error_ms)))
 (let ((?x732 (/ 1.0 4.0)))
 (let ((?x747 (ite v_0_rtt_measured (+ (* (/ 3.0 4.0) v_0_rttvar_ms) (* ?x732 ?x741)) (* ?x745 ?x721))))
 (let ((?x748 (ite $x705 ?x747 v_0_rttvar_ms)))
 (let ((?x708 (- 1.0)))
 (let ((?x724 (ite v_0_rtt_measured (+ (* (/ 7.0 8.0) v_0_srtt_ms) (* (/ 1.0 8.0) ?x721)) ?x721)))
 (let ((?x725 (ite $x705 ?x724 v_0_srtt_ms)))
 (let ((?x753 (+ (* ?x708 ?x725) (* ?x708 (ite (<= ?x748 ?x732) 1.0 (* 4.0 ?x748))))))
 (let ((?x754 (to_int ?x753)))
 (let ((?x759 (ite (<= ?x754 (- 1000)) (* ?x268 ?x754) 1000)))
 (let ((?x761 (ite (<= 60000 ?x759) 60000 ?x759)))
 (let ((?x763 (ite $x705 ?x761 v_0_rto_ms)))
 (let (($x321 (and $x292 $x315 $x319 v_0_fin_sent $x320)))
 (let (($x322 (not $x321)))
 (let (($x1088 (and $x322 v_0_fin_sent)))
 (let ((?x788 (ite (<= 0 v_0_rtx_buf) v_0_rtx_buf 0)))
 (let ((?x786 (ite (<= v_0_rtx_buf ?x296) 0 (+ v_0_rtx_buf (* ?x268 ?x296)))))
 (let (($x660 (and $x292 $x315 $x319)))
 (let ((?x791 (ite $x660 (ite (<= ?x786 ?x788) ?x786 ?x788) v_0_rtx_buf)))
 (let ((?x1446 (+ ?x791 (ite $x1088 1 0))))
 (let (($x1452 (and $x292 $x315 $x319 (<= 1 ?x1446))))
 (let (($x1453 (or (and (not (and $x292 $x315 $x319 (= 0 ?x1446))) active_0_rtx) $x1452)))
 (let (($x657 (not $x656)))
 (let (($x1443 (not v_1_tx_waiting)))
 (let (($x1441 (= v_1_tx_is_fin v_0_tx_is_fin)))
 (let (($x1438 (= v_1_tx_previous_rto v_0_tx_previous_rto)))
 (let (($x1435 (= v_1_tx_elapsed v_0_tx_elapsed)))
 (let (($x1432 (not v_1_tx_retransmitted)))
 (let (($x1430 (= v_1_tx_max_previous v_0_tx_max_previous)))
 (let (($x1427 (= v_1_tx_eligible v_0_tx_eligible)))
 (let (($x1424 (= v_1_tx_emit_count v_0_tx_emit_count)))
 (let (($x1174 (and $x292 $x315 $x319 (not (= 0 ?x296)))))
 (let (($x1169 (= 0 ?x791)))
 (let (($x1417 (= v_1_tx_time_15 (ite (or $x1169 (>= 15 ?x791) $x1174) 0 v_0_tx_time_15))))
 (let ((?x1411 (ite (or $x1169 (>= 14 ?x791)) 0 (ite $x1174 (ite (= 1 ?x296) v_0_tx_time_15 0) v_0_tx_time_14))))
 (let (($x1175 (= 1 ?x296)))
 (let ((?x1403 (ite $x1174 (ite $x1175 v_0_tx_time_14 (ite (= 2 ?x296) v_0_tx_time_15 0)) v_0_tx_time_13)))
 (let (($x1177 (= 2 ?x296)))
 (let ((?x1394 (ite $x1175 v_0_tx_time_13 (ite $x1177 v_0_tx_time_14 (ite (= 3 ?x296) v_0_tx_time_15 0)))))
 (let (($x1397 (= v_1_tx_time_12 (ite (or $x1169 (>= 12 ?x791)) 0 (ite $x1174 ?x1394 v_0_tx_time_12)))))
 (let (($x1179 (= 3 ?x296)))
 (let ((?x1384 (ite $x1177 v_0_tx_time_13 (ite $x1179 v_0_tx_time_14 (ite (= 4 ?x296) v_0_tx_time_15 0)))))
 (let ((?x1387 (ite (or (>= 11 ?x791) $x1169) 0 (ite $x1174 (ite $x1175 v_0_tx_time_12 ?x1384) v_0_tx_time_11))))
 (let (($x1181 (= 4 ?x296)))
 (let ((?x1373 (ite $x1179 v_0_tx_time_13 (ite $x1181 v_0_tx_time_14 (ite (= 5 ?x296) v_0_tx_time_15 0)))))
 (let ((?x1376 (ite $x1174 (ite $x1175 v_0_tx_time_11 (ite $x1177 v_0_tx_time_12 ?x1373)) v_0_tx_time_10)))
 (let (($x1183 (= 5 ?x296)))
 (let ((?x1361 (ite $x1181 v_0_tx_time_13 (ite $x1183 v_0_tx_time_14 (ite (= 6 ?x296) v_0_tx_time_15 0)))))
 (let ((?x1364 (ite $x1175 v_0_tx_time_10 (ite $x1177 v_0_tx_time_11 (ite $x1179 v_0_tx_time_12 ?x1361)))))
 (let (($x1367 (= v_1_tx_time_09 (ite (or (>= 9 ?x791) $x1169) 0 (ite $x1174 ?x1364 v_0_tx_time_09)))))
 (let (($x1185 (= 6 ?x296)))
 (let ((?x1348 (ite $x1183 v_0_tx_time_13 (ite $x1185 v_0_tx_time_14 (ite (= 7 ?x296) v_0_tx_time_15 0)))))
 (let ((?x1351 (ite $x1177 v_0_tx_time_10 (ite $x1179 v_0_tx_time_11 (ite $x1181 v_0_tx_time_12 ?x1348)))))
 (let ((?x1354 (ite (or $x1169 (>= 8 ?x791)) 0 (ite $x1174 (ite $x1175 v_0_tx_time_09 ?x1351) v_0_tx_time_08))))
 (let (($x1187 (= 7 ?x296)))
 (let ((?x1334 (ite $x1185 v_0_tx_time_13 (ite $x1187 v_0_tx_time_14 (ite (= 8 ?x296) v_0_tx_time_15 0)))))
 (let ((?x1337 (ite $x1179 v_0_tx_time_10 (ite $x1181 v_0_tx_time_11 (ite $x1183 v_0_tx_time_12 ?x1334)))))
 (let ((?x1340 (ite $x1174 (ite $x1175 v_0_tx_time_08 (ite $x1177 v_0_tx_time_09 ?x1337)) v_0_tx_time_07)))
 (let (($x1189 (= 8 ?x296)))
 (let ((?x1319 (ite $x1187 v_0_tx_time_13 (ite $x1189 v_0_tx_time_14 (ite (= 9 ?x296) v_0_tx_time_15 0)))))
 (let ((?x1322 (ite $x1181 v_0_tx_time_10 (ite $x1183 v_0_tx_time_11 (ite $x1185 v_0_tx_time_12 ?x1319)))))
 (let ((?x1325 (ite $x1175 v_0_tx_time_07 (ite $x1177 v_0_tx_time_08 (ite $x1179 v_0_tx_time_09 ?x1322)))))
 (let (($x1328 (= v_1_tx_time_06 (ite (or (>= 6 ?x791) $x1169) 0 (ite $x1174 ?x1325 v_0_tx_time_06)))))
 (let (($x1191 (= 9 ?x296)))
 (let ((?x1303 (ite $x1189 v_0_tx_time_13 (ite $x1191 v_0_tx_time_14 (ite (= 10 ?x296) v_0_tx_time_15 0)))))
 (let ((?x1306 (ite $x1183 v_0_tx_time_10 (ite $x1185 v_0_tx_time_11 (ite $x1187 v_0_tx_time_12 ?x1303)))))
 (let ((?x1309 (ite $x1177 v_0_tx_time_07 (ite $x1179 v_0_tx_time_08 (ite $x1181 v_0_tx_time_09 ?x1306)))))
 (let ((?x1312 (ite (or (>= 5 ?x791) $x1169) 0 (ite $x1174 (ite $x1175 v_0_tx_time_06 ?x1309) v_0_tx_time_05))))
 (let (($x1193 (= 10 ?x296)))
 (let ((?x1286 (ite $x1191 v_0_tx_time_13 (ite $x1193 v_0_tx_time_14 (ite (= 11 ?x296) v_0_tx_time_15 0)))))
 (let ((?x1289 (ite $x1185 v_0_tx_time_10 (ite $x1187 v_0_tx_time_11 (ite $x1189 v_0_tx_time_12 ?x1286)))))
 (let ((?x1292 (ite $x1179 v_0_tx_time_07 (ite $x1181 v_0_tx_time_08 (ite $x1183 v_0_tx_time_09 ?x1289)))))
 (let ((?x1295 (ite $x1174 (ite $x1175 v_0_tx_time_05 (ite $x1177 v_0_tx_time_06 ?x1292)) v_0_tx_time_04)))
 (let (($x1195 (= 11 ?x296)))
 (let ((?x1268 (ite $x1193 v_0_tx_time_13 (ite $x1195 v_0_tx_time_14 (ite (= 12 ?x296) v_0_tx_time_15 0)))))
 (let ((?x1271 (ite $x1187 v_0_tx_time_10 (ite $x1189 v_0_tx_time_11 (ite $x1191 v_0_tx_time_12 ?x1268)))))
 (let ((?x1274 (ite $x1181 v_0_tx_time_07 (ite $x1183 v_0_tx_time_08 (ite $x1185 v_0_tx_time_09 ?x1271)))))
 (let ((?x1277 (ite $x1175 v_0_tx_time_04 (ite $x1177 v_0_tx_time_05 (ite $x1179 v_0_tx_time_06 ?x1274)))))
 (let (($x1280 (= v_1_tx_time_03 (ite (or (>= 3 ?x791) $x1169) 0 (ite $x1174 ?x1277 v_0_tx_time_03)))))
 (let (($x1197 (= 12 ?x296)))
 (let ((?x1249 (ite $x1195 v_0_tx_time_13 (ite $x1197 v_0_tx_time_14 (ite (= 13 ?x296) v_0_tx_time_15 0)))))
 (let ((?x1252 (ite $x1189 v_0_tx_time_10 (ite $x1191 v_0_tx_time_11 (ite $x1193 v_0_tx_time_12 ?x1249)))))
 (let ((?x1255 (ite $x1183 v_0_tx_time_07 (ite $x1185 v_0_tx_time_08 (ite $x1187 v_0_tx_time_09 ?x1252)))))
 (let ((?x1258 (ite $x1177 v_0_tx_time_04 (ite $x1179 v_0_tx_time_05 (ite $x1181 v_0_tx_time_06 ?x1255)))))
 (let ((?x1261 (ite (or $x1169 (>= 2 ?x791)) 0 (ite $x1174 (ite $x1175 v_0_tx_time_03 ?x1258) v_0_tx_time_02))))
 (let (($x1199 (= 13 ?x296)))
 (let ((?x1229 (ite $x1197 v_0_tx_time_13 (ite $x1199 v_0_tx_time_14 (ite (= 14 ?x296) v_0_tx_time_15 0)))))
 (let ((?x1232 (ite $x1191 v_0_tx_time_10 (ite $x1193 v_0_tx_time_11 (ite $x1195 v_0_tx_time_12 ?x1229)))))
 (let ((?x1235 (ite $x1185 v_0_tx_time_07 (ite $x1187 v_0_tx_time_08 (ite $x1189 v_0_tx_time_09 ?x1232)))))
 (let ((?x1238 (ite $x1179 v_0_tx_time_04 (ite $x1181 v_0_tx_time_05 (ite $x1183 v_0_tx_time_06 ?x1235)))))
 (let ((?x1241 (ite $x1174 (ite $x1175 v_0_tx_time_02 (ite $x1177 v_0_tx_time_03 ?x1238)) v_0_tx_time_01)))
 (let (($x1201 (= 14 ?x296)))
 (let ((?x1207 (ite $x1199 v_0_tx_time_13 (ite $x1201 v_0_tx_time_14 (ite (= 15 ?x296) v_0_tx_time_15 0)))))
 (let ((?x1210 (ite $x1193 v_0_tx_time_10 (ite $x1195 v_0_tx_time_11 (ite $x1197 v_0_tx_time_12 ?x1207)))))
 (let ((?x1213 (ite $x1187 v_0_tx_time_07 (ite $x1189 v_0_tx_time_08 (ite $x1191 v_0_tx_time_09 ?x1210)))))
 (let ((?x1216 (ite $x1181 v_0_tx_time_04 (ite $x1183 v_0_tx_time_05 (ite $x1185 v_0_tx_time_06 ?x1213)))))
 (let ((?x1219 (ite $x1175 v_0_tx_time_01 (ite $x1177 v_0_tx_time_02 (ite $x1179 v_0_tx_time_03 ?x1216)))))
 (let (($x1223 (= v_1_tx_time_00 (ite (or $x1169 (>= 0 ?x791)) 0 (ite $x1174 ?x1219 v_0_tx_time_00)))))
 (let (($x1156 (= v_1_rtt_sample_was_ambiguous (and v_0_rtt_active v_0_rtt_ambiguous))))
 (let (($x1151 (not v_1_rtt_start_new)))
 (let ((?x784 (* ?x268 ?x296)))
 (let ((?x1143 (+ ?x701 ?x784)))
 (let (($x1146 (and v_0_rtt_active $x292 $x315 $x319 (not (<= v_0_rtt_remaining ?x1143)))))
 (let (($x1127 (and v_0_rtt_active $x292 $x315 $x319 $x702)))
 (let (($x1149 (= v_1_rtt_remaining (ite $x1127 0 (ite $x1146 ?x1143 v_0_rtt_remaining)))))
 (let (($x1140 (= v_1_rtt_end v_0_rtt_end)))
 (let (($x1139 (= v_1_rtt_start_ms v_0_rtt_start_ms)))
 (let (($x1125 (= v_1_rtt_previous_measured (ite $x705 v_0_rtt_measured v_0_rtt_previous_measured))))
 (let (($x1118 (= v_1_rtt_previous_var (ite $x705 v_0_rttvar_ms v_0_rtt_previous_var))))
 (let (($x1114 (= v_1_rtt_previous_srtt (ite $x705 v_0_srtt_ms v_0_rtt_previous_srtt))))
 (let (($x1102 (= v_1_rx_fin_done (or v_0_rx_fin_done (and v_0_rx_fin_pending $x325 $x653)))))
 (let (($x1099 (= v_1_rx_fin_offset (ite (and v_0_rx_fin_pending $x325 $x653) 0 ?x652))))
 (let (($x1096 (= v_1_rx_fin_seq v_0_rx_fin_seq)))
 (let (($x1095 (= v_1_rx_fin_pending (and v_0_rx_fin_pending (not (and v_0_rx_fin_pending $x325 $x653))))))
 (let (($x1090 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x1086 (= v_1_fin_requested v_0_fin_requested)))
 (let ((?x805 (mod (+ input_0_net.data_seq (* ?x268 v_0_snd_wl1)) 4294967296)))
 (let (($x800 (<= 2147483648 (mod (+ input_0_net.data_ack (* ?x268 v_0_snd_wl2)) 4294967296))))
 (let (($x796 (= v_0_snd_wl1 input_0_net.data_seq)))
 (let (($x811 (or (and $x796 (not $x800)) (and (not (<= ?x805 0)) (not (<= 2147483648 ?x805))))))
 (let (($x812 (and $x292 $x319 $x811)))
 (let ((?x1064 (ite (or (not (and $x350 (not $x617))) (and v_0_rx_fin_pending $x325 $x653)) 0 ?x631)))
 (let (($x880 (not $x617)))
 (let (($x684 (not $x350)))
 (let (($x849 (not $x389)))
 (let (($x847 (not $x409)))
 (let (($x845 (not $x429)))
 (let (($x843 (not $x449)))
 (let (($x841 (not $x469)))
 (let (($x839 (not $x489)))
 (let (($x837 (not $x507)))
 (let (($x835 (not $x525)))
 (let (($x833 (not $x543)))
 (let (($x831 (not $x561)))
 (let (($x829 (not $x579)))
 (let (($x827 (not $x597)))
 (let (($x825 (not $x615)))
 (let (($x824 (and false $x633)))
 (let (($x826 (and $x824 $x825)))
 (let (($x828 (and $x826 $x827)))
 (let (($x830 (and $x828 $x829)))
 (let (($x832 (and $x830 $x831)))
 (let (($x834 (and $x832 $x833)))
 (let (($x836 (and $x834 $x835)))
 (let (($x838 (and $x836 $x837)))
 (let (($x840 (and $x838 $x839)))
 (let (($x842 (and $x840 $x841)))
 (let (($x844 (and $x842 $x843)))
 (let (($x846 (and $x844 $x845)))
 (let (($x848 (and $x846 $x847)))
 (let (($x851 (or $x352 (and $x848 $x849) $x368)))
 (let ((?x678 (ite $x599 0 ?x613)))
 (let (($x654 (and v_0_rx_fin_pending $x325 $x653)))
 (let (($x1060 (= v_1_rx_slot_14 (ite $x654 0 (ite $x350 ?x678 (ite (and $x851 $x684 $x880) ?x631 0))))))
 (let (($x852 (and $x851 $x684)))
 (let ((?x1052 (ite $x852 ?x678 (ite (and (or $x848 $x389) (not $x369) $x684 $x880) ?x631 0))))
 (let ((?x677 (ite $x581 0 ?x595)))
 (let (($x854 (not $x369)))
 (let (($x853 (or $x848 $x389)))
 (let (($x855 (and $x853 $x854 $x684)))
 (let ((?x1045 (ite $x855 ?x678 (ite (and (or $x846 $x409) $x849 $x854 $x684 $x880) ?x631 0))))
 (let ((?x676 (ite $x578 0 ?x575)))
 (let (($x1049 (= v_1_rx_slot_12 (ite $x654 0 (ite $x350 ?x676 (ite $x852 ?x677 ?x1045))))))
 (let (($x856 (or $x846 $x409)))
 (let (($x857 (and $x856 $x849 $x854 $x684)))
 (let ((?x1037 (ite $x857 ?x678 (ite (and (or $x844 $x429) $x847 $x849 $x854 $x684 $x880) ?x631 0))))
 (let ((?x675 (ite $x560 0 ?x557)))
 (let (($x1042 (= v_1_rx_slot_11 (ite $x654 0 (ite $x350 ?x675 (ite $x852 ?x676 (ite $x855 ?x677 ?x1037)))))))
 (let (($x858 (or $x844 $x429)))
 (let (($x859 (and $x858 $x847 $x849 $x854 $x684)))
 (let ((?x1028 (ite $x859 ?x678 (ite (and (or $x842 $x449) $x845 $x847 $x849 $x854 $x684 $x880) ?x631 0))))
 (let ((?x674 (ite $x527 0 ?x541)))
 (let ((?x1033 (ite $x654 0 (ite $x350 ?x674 (ite $x852 ?x675 (ite $x855 ?x676 (ite $x857 ?x677 ?x1028)))))))
 (let ((?x1017 (ite (and (or $x840 $x469) $x843 $x845 $x847 $x849 $x854 $x684 $x880) ?x631 0)))
 (let (($x860 (or $x842 $x449)))
 (let (($x861 (and $x860 $x845 $x847 $x849 $x854 $x684)))
 (let ((?x1022 (ite $x852 ?x674 (ite $x855 ?x675 (ite $x857 ?x676 (ite $x859 ?x677 (ite $x861 ?x678 ?x1017)))))))
 (let ((?x673 (ite $x524 0 ?x521)))
 (let ((?x1006 (ite (and (or $x838 $x489) $x841 $x843 $x845 $x847 $x849 $x854 $x684 $x880) ?x631 0)))
 (let (($x862 (or $x840 $x469)))
 (let (($x863 (and $x862 $x843 $x845 $x847 $x849 $x854 $x684)))
 (let ((?x1011 (ite $x855 ?x674 (ite $x857 ?x675 (ite $x859 ?x676 (ite $x861 ?x677 (ite $x863 ?x678 ?x1006)))))))
 (let ((?x672 (ite $x506 0 ?x503)))
 (let (($x1015 (= v_1_rx_slot_08 (ite $x654 0 (ite $x350 ?x672 (ite $x852 ?x673 ?x1011))))))
 (let ((?x994 (ite (and (or $x836 $x507) $x839 $x841 $x843 $x845 $x847 $x849 $x854 $x684 $x880) ?x631 0)))
 (let (($x864 (or $x838 $x489)))
 (let (($x865 (and $x864 $x841 $x843 $x845 $x847 $x849 $x854 $x684)))
 (let ((?x999 (ite $x857 ?x674 (ite $x859 ?x675 (ite $x861 ?x676 (ite $x863 ?x677 (ite $x865 ?x678 ?x994)))))))
 (let ((?x671 (ite $x472 0 ?x487)))
 (let (($x1004 (= v_1_rx_slot_07 (ite $x654 0 (ite $x350 ?x671 (ite $x852 ?x672 (ite $x855 ?x673 ?x999)))))))
 (let (($x868 (or $x834 $x525)))
 (let ((?x981 (ite (and $x868 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x854 $x684 $x880) ?x631 0)))
 (let (($x866 (or $x836 $x507)))
 (let (($x867 (and $x866 $x839 $x841 $x843 $x845 $x847 $x849 $x854 $x684)))
 (let ((?x986 (ite $x859 ?x674 (ite $x861 ?x675 (ite $x863 ?x676 (ite $x865 ?x677 (ite $x867 ?x678 ?x981)))))))
 (let ((?x670 (ite $x452 0 ?x467)))
 (let ((?x991 (ite $x654 0 (ite $x350 ?x670 (ite $x852 ?x671 (ite $x855 ?x672 (ite $x857 ?x673 ?x986)))))))
 (let (($x870 (or $x832 $x543)))
 (let ((?x967 (ite (and $x870 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x854 $x684 $x880) ?x631 0)))
 (let (($x869 (and $x868 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x854 $x684)))
 (let ((?x972 (ite $x861 ?x674 (ite $x863 ?x675 (ite $x865 ?x676 (ite $x867 ?x677 (ite $x869 ?x678 ?x967)))))))
 (let ((?x669 (ite $x432 0 ?x447)))
 (let ((?x977 (ite $x350 ?x669 (ite $x852 ?x670 (ite $x855 ?x671 (ite $x857 ?x672 (ite $x859 ?x673 ?x972)))))))
 (let (($x872 (or $x830 $x561)))
 (let (($x951 (and $x872 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x854 $x684 $x880)))
 (let (($x871 (and $x870 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x854 $x684)))
 (let ((?x956 (ite $x865 ?x675 (ite $x867 ?x676 (ite $x869 ?x677 (ite $x871 ?x678 (ite $x951 ?x631 0)))))))
 (let ((?x961 (ite $x855 ?x670 (ite $x857 ?x671 (ite $x859 ?x672 (ite $x861 ?x673 (ite $x863 ?x674 ?x956)))))))
 (let ((?x668 (ite $x412 0 ?x427)))
 (let (($x965 (= v_1_rx_slot_04 (ite $x654 0 (ite $x350 ?x668 (ite $x852 ?x669 ?x961))))))
 (let (($x874 (or $x828 $x579)))
 (let (($x935 (and $x874 $x831 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x854 $x684 $x880)))
 (let (($x873 (and $x872 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x854 $x684)))
 (let ((?x940 (ite $x867 ?x675 (ite $x869 ?x676 (ite $x871 ?x677 (ite $x873 ?x678 (ite $x935 ?x631 0)))))))
 (let ((?x945 (ite $x857 ?x670 (ite $x859 ?x671 (ite $x861 ?x672 (ite $x863 ?x673 (ite $x865 ?x674 ?x940)))))))
 (let ((?x667 (ite $x408 0 ?x405)))
 (let (($x950 (= v_1_rx_slot_03 (ite $x654 0 (ite $x350 ?x667 (ite $x852 ?x668 (ite $x855 ?x669 ?x945)))))))
 (let (($x876 (or $x826 $x597)))
 (let (($x918 (and $x876 $x829 $x831 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x854 $x684 $x880)))
 (let (($x875 (and $x874 $x831 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x854 $x684)))
 (let ((?x923 (ite $x869 ?x675 (ite $x871 ?x676 (ite $x873 ?x677 (ite $x875 ?x678 (ite $x918 ?x631 0)))))))
 (let ((?x928 (ite $x859 ?x670 (ite $x861 ?x671 (ite $x863 ?x672 (ite $x865 ?x673 (ite $x867 ?x674 ?x923)))))))
 (let ((?x666 (ite $x372 0 ?x387)))
 (let ((?x933 (ite $x654 0 (ite $x350 ?x666 (ite $x852 ?x667 (ite $x855 ?x668 (ite $x857 ?x669 ?x928)))))))
 (let (($x878 (or $x824 $x615)))
 (let (($x900 (and $x878 $x827 $x829 $x831 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x854 $x684 $x880)))
 (let (($x877 (and $x876 $x829 $x831 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x854 $x684)))
 (let ((?x905 (ite $x871 ?x675 (ite $x873 ?x676 (ite $x875 ?x677 (ite $x877 ?x678 (ite $x900 ?x631 0)))))))
 (let ((?x910 (ite $x861 ?x670 (ite $x863 ?x671 (ite $x865 ?x672 (ite $x867 ?x673 (ite $x869 ?x674 ?x905)))))))
 (let ((?x665 (ite $x352 0 ?x367)))
 (let ((?x915 (ite $x350 ?x665 (ite $x852 ?x666 (ite $x855 ?x667 (ite $x857 ?x668 (ite $x859 ?x669 ?x910)))))))
 (let (($x881 (and $x633 $x825 $x827 $x829 $x831 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x854 $x684 $x880)))
 (let (($x879 (and $x878 $x827 $x829 $x831 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x854 $x684)))
 (let ((?x886 (ite $x873 ?x675 (ite $x875 ?x676 (ite $x877 ?x677 (ite $x879 ?x678 (ite $x881 ?x631 0)))))))
 (let ((?x891 (ite $x863 ?x670 (ite $x865 ?x671 (ite $x867 ?x672 (ite $x869 ?x673 (ite $x871 ?x674 ?x886)))))))
 (let ((?x896 (ite $x852 ?x665 (ite $x855 ?x666 (ite $x857 ?x667 (ite $x859 ?x668 (ite $x861 ?x669 ?x891)))))))
 (let ((?x664 (ite $x349 0 ?x346)))
 (let ((?x686 (ite (and (<= 0 ?x649) $x684) ?x648 0)))
 (let ((?x680 (+ ?x664 ?x665 ?x666 ?x667 ?x668 ?x669 ?x670 ?x671 ?x672 ?x673 ?x674 ?x675 ?x676 ?x677 ?x678 (ite $x617 0 ?x631))))
 (let ((?x682 (ite (<= ?x680 0) 0 ?x680)))
 (let ((?x688 (ite (<= ?x682 ?x686) ?x682 ?x686)))
 (let (($x822 (= v_1_take v_0_take)))
 (let (($x782 (= v_1_snd_buf v_0_snd_buf)))
 (let (($x776 (= v_1_msl_ms v_0_msl_ms)))
 (let (($x773 (= v_1_user_timeout_ms v_0_user_timeout_ms)))
 (let (($x770 (= v_1_active_open v_0_active_open)))
 (let (($x767 (= v_1_retries v_0_retries)))
 (let (($x697 (= v_1_tx_flags v_0_tx_flags)))
 (let (($x694 (= v_1_tx_ack v_0_tx_ack)))
 (let (($x693 (= v_1_tx_seq v_0_tx_seq)))
 (let (($x692 (= v_1_rcv_nxt (mod (+ v_0_rcv_nxt ?x688 (ite $x654 1 0)) 4294967296))))
 (let (($x663 (= v_1_snd_nxt v_0_snd_nxt)))
 (let (($x659 (= v_1_irs v_0_irs)))
 (let (($x658 (= v_1_iss v_0_iss)))
 (let (($x655 (not $x654)))
 (let (($x303 (not (= (mod (+ input_0_net.data_ack (* ?x268 v_0_snd_nxt)) 4294967296) 2147483648))))
 (and (>= now_1 now_0) (<= 1 input_0_net.data_data) (>= 16 input_0_net.data_data) (not (= ?x271 2147483648)) (<= 0 input_0_net.data_window) (>= 65535 input_0_net.data_window) (or (not $x292) (and (not (= ?x296 2147483648)) $x303)) (or (not active_0_rtx) (not (<= due_0_rtx now_1))) (or (not active_0_user) (not (<= due_0_user now_1))) (or (not active_0_time_wait) (not (<= due_0_time_wait now_1))) $x322 $x655 $x657 $x658 $x659 (= v_1_snd_una (ite $x660 input_0_net.data_ack v_0_snd_una)) $x663 $x692 $x693 $x694 $x697 (= v_1_rto_ms ?x763) $x767 $x770 $x773 $x776 (= v_1_local_window (+ 16 (* ?x268 v_0_rcv_buf) (* ?x268 ?x688))) $x782 (= v_1_rtx_buf ?x791) (= v_1_rcv_buf (+ v_0_rcv_buf ?x688)) (= v_1_snd_wnd (ite $x812 input_0_net.data_window v_0_snd_wnd)) (= v_1_snd_wl1 (ite $x812 input_0_net.data_seq v_0_snd_wl1)) (= v_1_snd_wl2 (ite $x812 input_0_net.data_ack v_0_snd_wl2)) $x822 (= v_1_rx_chunk ?x688) (= v_1_rx_slot_00 (ite $x654 0 (ite $x350 ?x664 ?x896))) (= v_1_rx_slot_01 (ite $x654 0 ?x915)) (= v_1_rx_slot_02 ?x933) $x950 $x965 (= v_1_rx_slot_05 (ite $x654 0 ?x977)) (= v_1_rx_slot_06 ?x991) $x1004 $x1015 (= v_1_rx_slot_09 (ite $x654 0 (ite $x350 ?x673 ?x1022))) (= v_1_rx_slot_10 ?x1033) $x1042 $x1049 (= v_1_rx_slot_13 (ite $x654 0 (ite $x350 ?x677 ?x1052))) $x1060 (= v_1_rx_slot_15 ?x1064) (= v_1_rx_advance ?x649) (= v_1_rx_acceptable (and $x292 $x332 $x325)) (= v_1_seg_acceptable $x292) (= v_1_ack_delta ?x296) (= v_1_ack_is_new (and $x315 $x319)) (= v_1_ack_is_future $x331) (= v_1_ack_advance $x660) (= v_1_ack_window_update $x812) $x1086 (= v_1_fin_sent $x1088) $x1090 (= v_1_fin_acknowledged $x321) $x1095 $x1096 $x1099 $x1102 (= v_1_rx_fin_consumed $x654) (= v_1_srtt_ms ?x725) (= v_1_rttvar_ms ?x748) (= v_1_rtt_error_ms ?x741) $x1114 $x1118 (= v_1_rtt_measured (or v_0_rtt_measured $x705)) $x1125 (= v_1_rtt_active (and v_0_rtt_active (not $x1127))) (= v_1_rtt_ambiguous (and (not $x1127) v_0_rtt_ambiguous)) (= v_1_rtt_sample_at_ms (ite $x705 now_1 v_0_rtt_sample_at_ms)) $x1139 $x1140 $x1149 $x1151 (= v_1_rtt_sample_used $x705) $x1156 (= v_1_rtt_last_ms ?x720) (= v_1_rtt_samples (+ v_0_rtt_samples (ite $x705 1 0))) (= v_1_rto_base_ms (ite $x705 ?x761 v_0_rto_base_ms)) $x1223 (= v_1_tx_time_01 (ite (or $x1169 (>= 1 ?x791)) 0 ?x1241)) (= v_1_tx_time_02 ?x1261) $x1280 (= v_1_tx_time_04 (ite (or (>= 4 ?x791) $x1169) 0 ?x1295)) (= v_1_tx_time_05 ?x1312) $x1328 (= v_1_tx_time_07 (ite (or (>= 7 ?x791) $x1169) 0 ?x1340)) (= v_1_tx_time_08 ?x1354) $x1367 (= v_1_tx_time_10 (ite (or $x1169 (>= 10 ?x791)) 0 ?x1376)) (= v_1_tx_time_11 ?x1387) $x1397 (= v_1_tx_time_13 (ite (or (>= 13 ?x791) $x1169) 0 ?x1403)) (= v_1_tx_time_14 ?x1411) $x1417 (= v_1_tx_fin_time (ite $x1088 v_0_tx_fin_time 0)) $x1424 $x1427 $x1430 $x1432 $x1435 $x1438 $x1441 $x1443 (= active_1_rtx (and $x657 $x1453)) (= active_1_user (and $x657 active_0_user)) (= active_1_time_wait (or $x656 active_0_time_wait)) (= due_1_rtx (ite $x1452 (+ now_1 ?x763) due_0_rtx)) $x1467 (= due_1_time_wait (ite $x656 ?x1470 due_0_time_wait))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
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
 (let ((?x1478 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1478)))
(assert
 (>= 16 v_0_rcv_buf))
(assert
 (and (<= 0 v_0_snd_wnd) (>= 65535 v_0_snd_wnd)))
(assert
 (= v_0_local_window (+ 16 (* (- 1) v_0_rcv_buf))))
(assert
 (>= 1 v_0_rx_slot_00))
(assert
 (let (($x333 (= 0 v_0_rx_slot_00)))
 (let (($x1488 (not (>= v_0_rcv_buf 16))))
 (or $x1488 $x333))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x353 (= 0 v_0_rx_slot_01)))
 (let (($x1492 (not (>= v_0_rcv_buf 15))))
 (or $x1492 $x353))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x373 (= 0 v_0_rx_slot_02)))
 (let (($x1496 (not (>= v_0_rcv_buf 14))))
 (or $x1496 $x373))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x390 (= 0 v_0_rx_slot_03)))
 (let (($x1500 (not (>= v_0_rcv_buf 13))))
 (or $x1500 $x390))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x413 (= 0 v_0_rx_slot_04)))
 (let (($x1504 (not (>= v_0_rcv_buf 12))))
 (or $x1504 $x413))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x433 (= 0 v_0_rx_slot_05)))
 (let (($x1508 (not (>= v_0_rcv_buf 11))))
 (or $x1508 $x433))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x453 (= 0 v_0_rx_slot_06)))
 (let (($x1512 (not (>= v_0_rcv_buf 10))))
 (or $x1512 $x453))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x473 (= 0 v_0_rx_slot_07)))
 (let (($x1516 (not (>= v_0_rcv_buf 9))))
 (or $x1516 $x473))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x490 (= 0 v_0_rx_slot_08)))
 (let (($x1520 (not (>= v_0_rcv_buf 8))))
 (or $x1520 $x490))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x508 (= 0 v_0_rx_slot_09)))
 (let (($x1524 (not (>= v_0_rcv_buf 7))))
 (or $x1524 $x508))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x528 (= 0 v_0_rx_slot_10)))
 (let (($x1528 (not (>= v_0_rcv_buf 6))))
 (or $x1528 $x528))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x544 (= 0 v_0_rx_slot_11)))
 (let (($x1532 (not (>= v_0_rcv_buf 5))))
 (or $x1532 $x544))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x562 (= 0 v_0_rx_slot_12)))
 (let (($x1536 (not (>= v_0_rcv_buf 4))))
 (or $x1536 $x562))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x582 (= 0 v_0_rx_slot_13)))
 (let (($x1540 (not (>= v_0_rcv_buf 3))))
 (or $x1540 $x582))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x600 (= 0 v_0_rx_slot_14)))
 (let (($x1544 (not (>= v_0_rcv_buf 2))))
 (or $x1544 $x600))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x618 (= 0 v_0_rx_slot_15)))
 (let (($x1548 (not (>= v_0_rcv_buf 1))))
 (or $x1548 $x618))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x1550 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x1550)))
(assert
 (and (<= 0 v_0_rx_advance) (>= 16 v_0_rx_advance)))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (and (<= 0 v_0_ack_delta) (>= 4294967295 v_0_ack_delta)))
(assert
 true)
(assert
 (let ((?x1562 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x1562)))
(assert
 (= active_0_rtx (<= 1 (+ v_0_rtx_buf (ite v_0_fin_sent 1 0)))))
(assert
 (let (($x1571 (and v_0_fin_requested (= v_0_fin_seq (mod (+ v_0_snd_una v_0_rtx_buf) 4294967296)) (= 0 v_0_snd_buf))))
 (let (($x1566 (not v_0_fin_sent)))
 (or $x1566 $x1571))))
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
 (let (($x1574 (<= 1 v_0_rx_fin_offset)))
 (let (($x325 (not v_0_rx_fin_done)))
 (let (($x1576 (and $x325 $x1574 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window)))))
 (let (($x1573 (not v_0_rx_fin_pending)))
 (or $x1573 $x1576))))))
(assert
 (let (($x616 (>= 15 v_0_rx_fin_offset)))
 (and (<= 0 v_0_rx_fin_offset) $x616 (= v_0_rx_fin_pending (<= 1 v_0_rx_fin_offset)))))
(assert
 (let (($x1573 (not v_0_rx_fin_pending)))
 (or $x1573 (= v_0_rx_fin_seq (mod (+ v_0_rcv_nxt v_0_rx_fin_offset) 4294967296)))))
(assert
 (let (($x325 (not v_0_rx_fin_done)))
 (or $x325 (= v_0_rcv_nxt (mod (+ 1 v_0_rx_fin_seq) 4294967296)))))
(assert
 (let (($x333 (= 0 v_0_rx_slot_00)))
 (or (not (and v_0_rx_fin_pending (>= 0 v_0_rx_fin_offset))) $x333)))
(assert
 (let (($x353 (= 0 v_0_rx_slot_01)))
 (or (not (and v_0_rx_fin_pending (>= 1 v_0_rx_fin_offset))) $x353)))
(assert
 (let (($x373 (= 0 v_0_rx_slot_02)))
 (or (not (and v_0_rx_fin_pending (>= 2 v_0_rx_fin_offset))) $x373)))
(assert
 (let (($x390 (= 0 v_0_rx_slot_03)))
 (or (not (and v_0_rx_fin_pending (>= 3 v_0_rx_fin_offset))) $x390)))
(assert
 (let (($x413 (= 0 v_0_rx_slot_04)))
 (or (not (and v_0_rx_fin_pending (>= 4 v_0_rx_fin_offset))) $x413)))
(assert
 (let (($x433 (= 0 v_0_rx_slot_05)))
 (or (not (and v_0_rx_fin_pending (>= 5 v_0_rx_fin_offset))) $x433)))
(assert
 (let (($x453 (= 0 v_0_rx_slot_06)))
 (or (not (and v_0_rx_fin_pending (>= 6 v_0_rx_fin_offset))) $x453)))
(assert
 (let (($x473 (= 0 v_0_rx_slot_07)))
 (or (not (and v_0_rx_fin_pending (>= 7 v_0_rx_fin_offset))) $x473)))
(assert
 (let (($x490 (= 0 v_0_rx_slot_08)))
 (or (not (and v_0_rx_fin_pending (>= 8 v_0_rx_fin_offset))) $x490)))
(assert
 (let (($x508 (= 0 v_0_rx_slot_09)))
 (or (not (and v_0_rx_fin_pending (>= 9 v_0_rx_fin_offset))) $x508)))
(assert
 (let (($x528 (= 0 v_0_rx_slot_10)))
 (or (not (and v_0_rx_fin_pending (>= 10 v_0_rx_fin_offset))) $x528)))
(assert
 (let (($x544 (= 0 v_0_rx_slot_11)))
 (or (not (and v_0_rx_fin_pending (>= 11 v_0_rx_fin_offset))) $x544)))
(assert
 (let (($x562 (= 0 v_0_rx_slot_12)))
 (or (not (and v_0_rx_fin_pending (>= 12 v_0_rx_fin_offset))) $x562)))
(assert
 (let (($x582 (= 0 v_0_rx_slot_13)))
 (or (not (and v_0_rx_fin_pending (>= 13 v_0_rx_fin_offset))) $x582)))
(assert
 (let (($x600 (= 0 v_0_rx_slot_14)))
 (or (not (and v_0_rx_fin_pending (>= 14 v_0_rx_fin_offset))) $x600)))
(assert
 (let (($x618 (= 0 v_0_rx_slot_15)))
 (let (($x616 (>= 15 v_0_rx_fin_offset)))
 (let (($x617 (and v_0_rx_fin_pending $x616)))
 (let (($x880 (not $x617)))
 (or $x880 $x618))))))
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
 (let ((?x1634 (* 4.0 v_0_rttvar_ms)))
 (let ((?x708 (- 1.0)))
 (let ((?x737 (* ?x708 v_0_srtt_ms)))
 (let ((?x1637 (+ ?x737 (* ?x708 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x1634)))))
 (let ((?x1638 (to_int ?x1637)))
 (let ((?x268 (- 1)))
 (let ((?x1641 (ite (<= ?x1638 (- 1000)) (* ?x268 ?x1638) 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x1641) 60000 ?x1641) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x701 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x1656 (and (<= v_0_rtt_start_ms now_0) (<= 1 v_0_rtt_remaining) (>= 4 v_0_rtt_remaining) (>= ?x701 v_0_rtt_remaining) (<= ?x701 (mod (+ v_0_snd_nxt (* (- 1) v_0_snd_una)) 4294967296)))))
 (let (($x1648 (not v_0_rtt_active)))
 (or $x1648 $x1656)))))
(assert
 (or v_0_rtt_active (= 0 v_0_rtt_remaining)))
(assert
 true)
(assert
 (let (($x1665 (= v_0_rtt_last_ms (+ v_0_rtt_sample_at_ms (* (- 1) v_0_rtt_start_ms)))))
 (let (($x1663 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1661 (not v_0_rtt_sample_used)))
 (or $x1661 (and $x1663 v_0_rtt_measured $x1665))))))
(assert
 (and (<= 0 v_0_rtt_sample_at_ms) (<= v_0_rtt_sample_at_ms now_0)))
(assert
 (let ((?x1672 (to_real v_0_rtt_last_ms)))
 (let ((?x1686 (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x1672))))
 (let ((?x1674 (+ v_0_rtt_previous_srtt (* (- 1.0) ?x1672))))
 (let ((?x1678 (ite (>= ?x1674 0.0) ?x1674 (+ (* (- 1.0) v_0_rtt_previous_srtt) ?x1672))))
 (let ((?x732 (/ 1.0 4.0)))
 (let ((?x1682 (ite v_0_rtt_previous_measured (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* ?x732 ?x1678)) (* (/ 1.0 2.0) ?x1672))))
 (let (($x1689 (and (= v_0_rttvar_ms ?x1682) (= v_0_srtt_ms (ite v_0_rtt_previous_measured ?x1686 ?x1672)))))
 (let (($x1661 (not v_0_rtt_sample_used)))
 (or $x1661 $x1689))))))))))
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
 (let (($x1825 (and (>= v_0_tx_elapsed v_0_tx_previous_rto) (<= 1 v_0_tx_emit_count) (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x1819 (not v_0_tx_retransmitted)))
 (or $x1819 $x1825))))
(assert
 (let (($x1819 (not v_0_tx_retransmitted)))
 (or $x1819 (not v_0_tx_waiting))))
(assert
 (= 157 choice_0))
(assert
 (= 5 state_0))
(assert
 (= 5 state_1))
(assert
 (or (not (<= 0 v_1_tx_time_08))))
(check-sat)
