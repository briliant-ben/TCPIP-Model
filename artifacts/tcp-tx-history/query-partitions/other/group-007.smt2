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
(declare-fun v_0_rx_fin_pending () Bool)
(declare-fun v_0_rx_fin_done () Bool)
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
(declare-fun input_0_net.fin_segment_window () Int)
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
 (let ((?x1478 (+ now_1 (* 2 v_0_msl_ms))))
 (let ((?x322 (ite v_0_fin_sent 1 0)))
 (let ((?x323 (+ v_0_rtx_buf ?x322)))
 (let ((?x295 (mod (+ input_0_net.fin_segment_ack (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x325 (= ?x295 ?x323)))
 (let (($x324 (<= ?x295 ?x323)))
 (let (($x309 (<= 1 ?x295)))
 (let ((?x268 (- 1)))
 (let ((?x284 (+ ?x268 v_0_local_window)))
 (let ((?x281 (* ?x268 v_0_rcv_nxt)))
 (let ((?x288 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data ?x281) 4294967296)))
 (let (($x289 (<= ?x288 ?x284)))
 (let (($x280 (<= 1 v_0_local_window)))
 (let (($x291 (or (and $x280 (<= (mod (+ input_0_net.fin_segment_seq ?x281) 4294967296) ?x284)) (and $x280 $x289))))
 (let (($x337 (not v_0_rx_fin_pending)))
 (let (($x336 (not v_0_rx_fin_done)))
 (let (($x333 (and (>= ?x295 (+ 1 v_0_rtx_buf ?x322)) (>= 2147483647 ?x295))))
 (let (($x334 (not $x333)))
 (let (($x338 (and $x291 $x334 $x336 $x337 $x280 $x289)))
 (let ((?x341 (ite $x338 ?x288 v_0_rx_fin_offset)))
 (let (($x339 (or v_0_rx_fin_pending $x338)))
 (let (($x641 (and $x339 (>= 15 ?x341))))
 (let ((?x628 (mod (+ 15 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x633 (+ input_0_net.fin_segment_data (* ?x268 ?x628))))
 (let (($x631 (<= input_0_net.fin_segment_data ?x628)))
 (let (($x626 (<= v_0_rcv_buf 0)))
 (let (($x625 (= 0 v_0_rx_slot_15)))
 (let (($x630 (and $x291 $x334 $x336 $x625 $x626 (<= ?x628 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x638 (ite $x630 (ite (or $x631 (<= ?x633 1)) (ite $x631 0 ?x633) 1) v_0_rx_slot_15)))
 (let (($x642 (or (= ?x638 0) $x641)))
 (let (($x623 (and $x339 (>= 14 ?x341))))
 (let ((?x610 (mod (+ 14 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x615 (+ input_0_net.fin_segment_data (* ?x268 ?x610))))
 (let (($x613 (<= input_0_net.fin_segment_data ?x610)))
 (let (($x608 (<= v_0_rcv_buf 1)))
 (let (($x607 (= 0 v_0_rx_slot_14)))
 (let (($x612 (and $x291 $x334 $x336 $x607 $x608 (<= ?x610 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x620 (ite $x612 (ite (or $x613 (<= ?x615 1)) (ite $x613 0 ?x615) 1) v_0_rx_slot_14)))
 (let (($x624 (or (= ?x620 0) $x623)))
 (let (($x605 (and $x339 (>= 13 ?x341))))
 (let ((?x592 (mod (+ 13 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x597 (+ input_0_net.fin_segment_data (* ?x268 ?x592))))
 (let (($x595 (<= input_0_net.fin_segment_data ?x592)))
 (let (($x590 (<= v_0_rcv_buf 2)))
 (let (($x589 (= 0 v_0_rx_slot_13)))
 (let (($x594 (and $x291 $x334 $x336 $x589 $x590 (<= ?x592 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x602 (ite $x594 (ite (or $x595 (<= ?x597 1)) (ite $x595 0 ?x597) 1) v_0_rx_slot_13)))
 (let (($x606 (or (= ?x602 0) $x605)))
 (let (($x587 (and $x339 (>= 12 ?x341))))
 (let ((?x574 (mod (+ 12 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x579 (+ input_0_net.fin_segment_data (* ?x268 ?x574))))
 (let (($x577 (<= input_0_net.fin_segment_data ?x574)))
 (let (($x572 (<= v_0_rcv_buf 3)))
 (let (($x571 (= 0 v_0_rx_slot_12)))
 (let (($x576 (and $x291 $x334 $x336 $x571 $x572 (<= ?x574 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x584 (ite $x576 (ite (or $x577 (<= ?x579 1)) (ite $x577 0 ?x579) 1) v_0_rx_slot_12)))
 (let (($x588 (or (= ?x584 0) $x587)))
 (let ((?x646 (ite $x588 12 (ite $x606 13 (ite $x624 14 (ite $x642 15 16))))))
 (let (($x569 (and $x339 (>= 11 ?x341))))
 (let ((?x556 (mod (+ 11 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x561 (+ input_0_net.fin_segment_data (* ?x268 ?x556))))
 (let (($x559 (<= input_0_net.fin_segment_data ?x556)))
 (let (($x554 (<= v_0_rcv_buf 4)))
 (let (($x553 (= 0 v_0_rx_slot_11)))
 (let (($x558 (and $x291 $x334 $x336 $x553 $x554 (<= ?x556 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x566 (ite $x558 (ite (or $x559 (<= ?x561 1)) (ite $x559 0 ?x561) 1) v_0_rx_slot_11)))
 (let (($x570 (or (= ?x566 0) $x569)))
 (let (($x551 (and $x339 (>= 10 ?x341))))
 (let ((?x538 (mod (+ 10 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x543 (+ input_0_net.fin_segment_data (* ?x268 ?x538))))
 (let (($x541 (<= input_0_net.fin_segment_data ?x538)))
 (let (($x536 (<= v_0_rcv_buf 5)))
 (let (($x535 (= 0 v_0_rx_slot_10)))
 (let (($x540 (and $x291 $x334 $x336 $x535 $x536 (<= ?x538 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x548 (ite $x540 (ite (or $x541 (<= ?x543 1)) (ite $x541 0 ?x543) 1) v_0_rx_slot_10)))
 (let (($x552 (or (= ?x548 0) $x551)))
 (let (($x533 (and $x339 (>= 9 ?x341))))
 (let ((?x520 (mod (+ 9 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x525 (+ input_0_net.fin_segment_data (* ?x268 ?x520))))
 (let (($x523 (<= input_0_net.fin_segment_data ?x520)))
 (let (($x518 (<= v_0_rcv_buf 6)))
 (let (($x517 (= 0 v_0_rx_slot_09)))
 (let (($x522 (and $x291 $x334 $x336 $x517 $x518 (<= ?x520 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x530 (ite $x522 (ite (or $x523 (<= ?x525 1)) (ite $x523 0 ?x525) 1) v_0_rx_slot_09)))
 (let (($x534 (or (= ?x530 0) $x533)))
 (let (($x515 (and $x339 (>= 8 ?x341))))
 (let ((?x502 (mod (+ 8 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x507 (+ input_0_net.fin_segment_data (* ?x268 ?x502))))
 (let (($x505 (<= input_0_net.fin_segment_data ?x502)))
 (let (($x500 (<= v_0_rcv_buf 7)))
 (let (($x499 (= 0 v_0_rx_slot_08)))
 (let (($x504 (and $x291 $x334 $x336 $x499 $x500 (<= ?x502 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x512 (ite $x504 (ite (or $x505 (<= ?x507 1)) (ite $x505 0 ?x507) 1) v_0_rx_slot_08)))
 (let (($x516 (or (= ?x512 0) $x515)))
 (let ((?x650 (ite $x516 8 (ite $x534 9 (ite $x552 10 (ite $x570 11 ?x646))))))
 (let (($x497 (and $x339 (>= 7 ?x341))))
 (let ((?x484 (mod (+ 7 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x489 (+ input_0_net.fin_segment_data (* ?x268 ?x484))))
 (let (($x487 (<= input_0_net.fin_segment_data ?x484)))
 (let (($x481 (<= v_0_rcv_buf 8)))
 (let (($x479 (= 0 v_0_rx_slot_07)))
 (let (($x486 (and $x291 $x334 $x336 $x479 $x481 (<= ?x484 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x494 (ite $x486 (ite (or $x487 (<= ?x489 1)) (ite $x487 0 ?x489) 1) v_0_rx_slot_07)))
 (let (($x498 (or (= ?x494 0) $x497)))
 (let (($x477 (and $x339 (>= 6 ?x341))))
 (let ((?x464 (mod (+ 6 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x469 (+ input_0_net.fin_segment_data (* ?x268 ?x464))))
 (let (($x467 (<= input_0_net.fin_segment_data ?x464)))
 (let (($x461 (<= v_0_rcv_buf 9)))
 (let (($x459 (= 0 v_0_rx_slot_06)))
 (let (($x466 (and $x291 $x334 $x336 $x459 $x461 (<= ?x464 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x474 (ite $x466 (ite (or $x467 (<= ?x469 1)) (ite $x467 0 ?x469) 1) v_0_rx_slot_06)))
 (let (($x478 (or (= ?x474 0) $x477)))
 (let (($x457 (and $x339 (>= 5 ?x341))))
 (let ((?x444 (mod (+ 5 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x449 (+ input_0_net.fin_segment_data (* ?x268 ?x444))))
 (let (($x447 (<= input_0_net.fin_segment_data ?x444)))
 (let (($x441 (<= v_0_rcv_buf 10)))
 (let (($x439 (= 0 v_0_rx_slot_05)))
 (let (($x446 (and $x291 $x334 $x336 $x439 $x441 (<= ?x444 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x454 (ite $x446 (ite (or $x447 (<= ?x449 1)) (ite $x447 0 ?x449) 1) v_0_rx_slot_05)))
 (let (($x458 (or (= ?x454 0) $x457)))
 (let (($x437 (and $x339 (>= 4 ?x341))))
 (let ((?x424 (mod (+ 4 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x429 (+ input_0_net.fin_segment_data (* ?x268 ?x424))))
 (let (($x427 (<= input_0_net.fin_segment_data ?x424)))
 (let (($x421 (<= v_0_rcv_buf 11)))
 (let (($x419 (= 0 v_0_rx_slot_04)))
 (let (($x426 (and $x291 $x334 $x336 $x419 $x421 (<= ?x424 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x434 (ite $x426 (ite (or $x427 (<= ?x429 1)) (ite $x427 0 ?x429) 1) v_0_rx_slot_04)))
 (let (($x438 (or (= ?x434 0) $x437)))
 (let ((?x654 (ite $x438 4 (ite $x458 5 (ite $x478 6 (ite $x498 7 ?x650))))))
 (let (($x417 (and $x339 (>= 3 ?x341))))
 (let ((?x404 (mod (+ 3 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x409 (+ input_0_net.fin_segment_data (* ?x268 ?x404))))
 (let (($x407 (<= input_0_net.fin_segment_data ?x404)))
 (let (($x401 (<= v_0_rcv_buf 12)))
 (let (($x399 (= 0 v_0_rx_slot_03)))
 (let (($x406 (and $x291 $x334 $x336 $x399 $x401 (<= ?x404 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x414 (ite $x406 (ite (or $x407 (<= ?x409 1)) (ite $x407 0 ?x409) 1) v_0_rx_slot_03)))
 (let (($x418 (or (= ?x414 0) $x417)))
 (let (($x397 (and $x339 (>= 2 ?x341))))
 (let ((?x384 (mod (+ 2 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x389 (+ input_0_net.fin_segment_data (* ?x268 ?x384))))
 (let (($x387 (<= input_0_net.fin_segment_data ?x384)))
 (let (($x381 (<= v_0_rcv_buf 13)))
 (let (($x379 (= 0 v_0_rx_slot_02)))
 (let (($x386 (and $x291 $x334 $x336 $x379 $x381 (<= ?x384 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x394 (ite $x386 (ite (or $x387 (<= ?x389 1)) (ite $x387 0 ?x389) 1) v_0_rx_slot_02)))
 (let (($x398 (or (= ?x394 0) $x397)))
 (let (($x377 (and $x339 (>= 1 ?x341))))
 (let ((?x364 (mod (+ 1 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x369 (+ input_0_net.fin_segment_data (* ?x268 ?x364))))
 (let (($x367 (<= input_0_net.fin_segment_data ?x364)))
 (let (($x362 (<= v_0_rcv_buf 14)))
 (let (($x360 (= 0 v_0_rx_slot_01)))
 (let (($x366 (and $x291 $x334 $x336 $x360 $x362 (<= ?x364 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x374 (ite $x366 (ite (or $x367 (<= ?x369 1)) (ite $x367 0 ?x369) 1) v_0_rx_slot_01)))
 (let (($x375 (= ?x374 0)))
 (let (($x378 (or $x375 $x377)))
 (let ((?x657 (ite $x378 1 (ite $x398 2 (ite $x418 3 ?x654)))))
 (let (($x358 (and $x339 (>= 0 ?x341))))
 (let ((?x271 (mod (+ v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x350 (+ input_0_net.fin_segment_data (* ?x268 ?x271))))
 (let (($x348 (<= input_0_net.fin_segment_data ?x271)))
 (let (($x344 (<= v_0_rcv_buf 15)))
 (let (($x342 (= 0 v_0_rx_slot_00)))
 (let (($x347 (and $x291 $x334 $x336 $x342 $x344 (<= ?x271 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x355 (ite $x347 (ite (or $x348 (<= ?x350 1)) (ite $x348 0 ?x350) 1) v_0_rx_slot_00)))
 (let (($x359 (or (= ?x355 0) $x358)))
 (let ((?x658 (ite $x359 0 ?x657)))
 (let ((?x661 (ite $x339 (+ ?x341 (* ?x268 ?x658)) ?x341)))
 (let (($x662 (= 0 ?x661)))
 (let (($x665 (and $x339 $x336 $x662 $x291 $x309 $x324 v_0_fin_sent $x325)))
 (let (($x1475 (= due_1_user due_0_user)))
 (let (($x713 (not v_0_rtt_ambiguous)))
 (let ((?x710 (mod (+ v_0_rtt_end (* ?x268 v_0_snd_una)) 4294967296)))
 (let (($x711 (>= ?x295 ?x710)))
 (let (($x714 (and v_0_rtt_active $x291 $x309 $x324 $x711 $x713)))
 (let ((?x729 (ite $x714 (+ now_1 (* ?x268 v_0_rtt_start_ms)) v_0_rtt_last_ms)))
 (let ((?x730 (to_real ?x729)))
 (let ((?x754 (/ 1.0 2.0)))
 (let ((?x743 (+ v_0_srtt_ms (* (- 1.0) ?x730))))
 (let ((?x750 (ite $x714 (ite (>= ?x743 0.0) ?x743 (+ (* (- 1.0) v_0_srtt_ms) ?x730)) v_0_rtt_error_ms)))
 (let ((?x741 (/ 1.0 4.0)))
 (let ((?x756 (ite v_0_rtt_measured (+ (* (/ 3.0 4.0) v_0_rttvar_ms) (* ?x741 ?x750)) (* ?x754 ?x730))))
 (let ((?x757 (ite $x714 ?x756 v_0_rttvar_ms)))
 (let ((?x717 (- 1.0)))
 (let ((?x733 (ite v_0_rtt_measured (+ (* (/ 7.0 8.0) v_0_srtt_ms) (* (/ 1.0 8.0) ?x730)) ?x730)))
 (let ((?x734 (ite $x714 ?x733 v_0_srtt_ms)))
 (let ((?x762 (+ (* ?x717 ?x734) (* ?x717 (ite (<= ?x757 ?x741) 1.0 (* 4.0 ?x757))))))
 (let ((?x763 (to_int ?x762)))
 (let ((?x768 (ite (<= ?x763 (- 1000)) (* ?x268 ?x763) 1000)))
 (let ((?x770 (ite (<= 60000 ?x768) 60000 ?x768)))
 (let ((?x772 (ite $x714 ?x770 v_0_rto_ms)))
 (let (($x326 (and $x291 $x309 $x324 v_0_fin_sent $x325)))
 (let (($x327 (not $x326)))
 (let (($x1097 (and $x327 v_0_fin_sent)))
 (let ((?x797 (ite (<= 0 v_0_rtx_buf) v_0_rtx_buf 0)))
 (let ((?x795 (ite (<= v_0_rtx_buf ?x295) 0 (+ v_0_rtx_buf (* ?x268 ?x295)))))
 (let (($x669 (and $x291 $x309 $x324)))
 (let ((?x800 (ite $x669 (ite (<= ?x795 ?x797) ?x795 ?x797) v_0_rtx_buf)))
 (let ((?x1454 (+ ?x800 (ite $x1097 1 0))))
 (let (($x1456 (and $x291 $x309 $x324 (<= 1 ?x1454))))
 (let (($x1461 (or $x1456 (and (not (and $x291 $x309 $x324 (= 0 ?x1454))) active_0_rtx))))
 (let (($x666 (not $x665)))
 (let (($x1451 (not v_1_tx_waiting)))
 (let (($x1449 (= v_1_tx_is_fin v_0_tx_is_fin)))
 (let (($x1446 (= v_1_tx_previous_rto v_0_tx_previous_rto)))
 (let (($x1443 (= v_1_tx_elapsed v_0_tx_elapsed)))
 (let (($x1440 (not v_1_tx_retransmitted)))
 (let (($x1438 (= v_1_tx_max_previous v_0_tx_max_previous)))
 (let (($x1435 (= v_1_tx_eligible v_0_tx_eligible)))
 (let (($x1432 (= v_1_tx_emit_count v_0_tx_emit_count)))
 (let (($x1178 (= 0 ?x800)))
 (let (($x1182 (and $x291 $x309 $x324 (not (= 0 ?x295)))))
 (let (($x1425 (= v_1_tx_time_15 (ite (or (>= 15 ?x800) $x1182 $x1178) 0 v_0_tx_time_15))))
 (let ((?x1419 (ite (or (>= 14 ?x800) $x1178) 0 (ite $x1182 (ite (= 1 ?x295) v_0_tx_time_15 0) v_0_tx_time_14))))
 (let (($x1183 (= 1 ?x295)))
 (let ((?x1411 (ite $x1182 (ite $x1183 v_0_tx_time_14 (ite (= 2 ?x295) v_0_tx_time_15 0)) v_0_tx_time_13)))
 (let (($x1185 (= 2 ?x295)))
 (let ((?x1402 (ite $x1183 v_0_tx_time_13 (ite $x1185 v_0_tx_time_14 (ite (= 3 ?x295) v_0_tx_time_15 0)))))
 (let (($x1405 (= v_1_tx_time_12 (ite (or (>= 12 ?x800) $x1178) 0 (ite $x1182 ?x1402 v_0_tx_time_12)))))
 (let (($x1187 (= 3 ?x295)))
 (let ((?x1392 (ite $x1185 v_0_tx_time_13 (ite $x1187 v_0_tx_time_14 (ite (= 4 ?x295) v_0_tx_time_15 0)))))
 (let ((?x1395 (ite (or (>= 11 ?x800) $x1178) 0 (ite $x1182 (ite $x1183 v_0_tx_time_12 ?x1392) v_0_tx_time_11))))
 (let (($x1189 (= 4 ?x295)))
 (let ((?x1381 (ite $x1187 v_0_tx_time_13 (ite $x1189 v_0_tx_time_14 (ite (= 5 ?x295) v_0_tx_time_15 0)))))
 (let ((?x1384 (ite $x1182 (ite $x1183 v_0_tx_time_11 (ite $x1185 v_0_tx_time_12 ?x1381)) v_0_tx_time_10)))
 (let (($x1191 (= 5 ?x295)))
 (let ((?x1369 (ite $x1189 v_0_tx_time_13 (ite $x1191 v_0_tx_time_14 (ite (= 6 ?x295) v_0_tx_time_15 0)))))
 (let ((?x1372 (ite $x1183 v_0_tx_time_10 (ite $x1185 v_0_tx_time_11 (ite $x1187 v_0_tx_time_12 ?x1369)))))
 (let (($x1375 (= v_1_tx_time_09 (ite (or (>= 9 ?x800) $x1178) 0 (ite $x1182 ?x1372 v_0_tx_time_09)))))
 (let (($x1193 (= 6 ?x295)))
 (let ((?x1356 (ite $x1191 v_0_tx_time_13 (ite $x1193 v_0_tx_time_14 (ite (= 7 ?x295) v_0_tx_time_15 0)))))
 (let ((?x1359 (ite $x1185 v_0_tx_time_10 (ite $x1187 v_0_tx_time_11 (ite $x1189 v_0_tx_time_12 ?x1356)))))
 (let ((?x1362 (ite (or (>= 8 ?x800) $x1178) 0 (ite $x1182 (ite $x1183 v_0_tx_time_09 ?x1359) v_0_tx_time_08))))
 (let (($x1195 (= 7 ?x295)))
 (let ((?x1342 (ite $x1193 v_0_tx_time_13 (ite $x1195 v_0_tx_time_14 (ite (= 8 ?x295) v_0_tx_time_15 0)))))
 (let ((?x1345 (ite $x1187 v_0_tx_time_10 (ite $x1189 v_0_tx_time_11 (ite $x1191 v_0_tx_time_12 ?x1342)))))
 (let ((?x1348 (ite $x1182 (ite $x1183 v_0_tx_time_08 (ite $x1185 v_0_tx_time_09 ?x1345)) v_0_tx_time_07)))
 (let (($x1197 (= 8 ?x295)))
 (let ((?x1327 (ite $x1195 v_0_tx_time_13 (ite $x1197 v_0_tx_time_14 (ite (= 9 ?x295) v_0_tx_time_15 0)))))
 (let ((?x1330 (ite $x1189 v_0_tx_time_10 (ite $x1191 v_0_tx_time_11 (ite $x1193 v_0_tx_time_12 ?x1327)))))
 (let ((?x1333 (ite $x1183 v_0_tx_time_07 (ite $x1185 v_0_tx_time_08 (ite $x1187 v_0_tx_time_09 ?x1330)))))
 (let (($x1336 (= v_1_tx_time_06 (ite (or (>= 6 ?x800) $x1178) 0 (ite $x1182 ?x1333 v_0_tx_time_06)))))
 (let (($x1199 (= 9 ?x295)))
 (let ((?x1311 (ite $x1197 v_0_tx_time_13 (ite $x1199 v_0_tx_time_14 (ite (= 10 ?x295) v_0_tx_time_15 0)))))
 (let ((?x1314 (ite $x1191 v_0_tx_time_10 (ite $x1193 v_0_tx_time_11 (ite $x1195 v_0_tx_time_12 ?x1311)))))
 (let ((?x1317 (ite $x1185 v_0_tx_time_07 (ite $x1187 v_0_tx_time_08 (ite $x1189 v_0_tx_time_09 ?x1314)))))
 (let ((?x1320 (ite (or (>= 5 ?x800) $x1178) 0 (ite $x1182 (ite $x1183 v_0_tx_time_06 ?x1317) v_0_tx_time_05))))
 (let (($x1201 (= 10 ?x295)))
 (let ((?x1294 (ite $x1199 v_0_tx_time_13 (ite $x1201 v_0_tx_time_14 (ite (= 11 ?x295) v_0_tx_time_15 0)))))
 (let ((?x1297 (ite $x1193 v_0_tx_time_10 (ite $x1195 v_0_tx_time_11 (ite $x1197 v_0_tx_time_12 ?x1294)))))
 (let ((?x1300 (ite $x1187 v_0_tx_time_07 (ite $x1189 v_0_tx_time_08 (ite $x1191 v_0_tx_time_09 ?x1297)))))
 (let ((?x1303 (ite $x1182 (ite $x1183 v_0_tx_time_05 (ite $x1185 v_0_tx_time_06 ?x1300)) v_0_tx_time_04)))
 (let (($x1203 (= 11 ?x295)))
 (let ((?x1276 (ite $x1201 v_0_tx_time_13 (ite $x1203 v_0_tx_time_14 (ite (= 12 ?x295) v_0_tx_time_15 0)))))
 (let ((?x1279 (ite $x1195 v_0_tx_time_10 (ite $x1197 v_0_tx_time_11 (ite $x1199 v_0_tx_time_12 ?x1276)))))
 (let ((?x1282 (ite $x1189 v_0_tx_time_07 (ite $x1191 v_0_tx_time_08 (ite $x1193 v_0_tx_time_09 ?x1279)))))
 (let ((?x1285 (ite $x1183 v_0_tx_time_04 (ite $x1185 v_0_tx_time_05 (ite $x1187 v_0_tx_time_06 ?x1282)))))
 (let (($x1288 (= v_1_tx_time_03 (ite (or (>= 3 ?x800) $x1178) 0 (ite $x1182 ?x1285 v_0_tx_time_03)))))
 (let (($x1205 (= 12 ?x295)))
 (let ((?x1257 (ite $x1203 v_0_tx_time_13 (ite $x1205 v_0_tx_time_14 (ite (= 13 ?x295) v_0_tx_time_15 0)))))
 (let ((?x1260 (ite $x1197 v_0_tx_time_10 (ite $x1199 v_0_tx_time_11 (ite $x1201 v_0_tx_time_12 ?x1257)))))
 (let ((?x1263 (ite $x1191 v_0_tx_time_07 (ite $x1193 v_0_tx_time_08 (ite $x1195 v_0_tx_time_09 ?x1260)))))
 (let ((?x1266 (ite $x1185 v_0_tx_time_04 (ite $x1187 v_0_tx_time_05 (ite $x1189 v_0_tx_time_06 ?x1263)))))
 (let ((?x1269 (ite (or (>= 2 ?x800) $x1178) 0 (ite $x1182 (ite $x1183 v_0_tx_time_03 ?x1266) v_0_tx_time_02))))
 (let (($x1207 (= 13 ?x295)))
 (let ((?x1237 (ite $x1205 v_0_tx_time_13 (ite $x1207 v_0_tx_time_14 (ite (= 14 ?x295) v_0_tx_time_15 0)))))
 (let ((?x1240 (ite $x1199 v_0_tx_time_10 (ite $x1201 v_0_tx_time_11 (ite $x1203 v_0_tx_time_12 ?x1237)))))
 (let ((?x1243 (ite $x1193 v_0_tx_time_07 (ite $x1195 v_0_tx_time_08 (ite $x1197 v_0_tx_time_09 ?x1240)))))
 (let ((?x1246 (ite $x1187 v_0_tx_time_04 (ite $x1189 v_0_tx_time_05 (ite $x1191 v_0_tx_time_06 ?x1243)))))
 (let ((?x1249 (ite $x1182 (ite $x1183 v_0_tx_time_02 (ite $x1185 v_0_tx_time_03 ?x1246)) v_0_tx_time_01)))
 (let (($x1209 (= 14 ?x295)))
 (let ((?x1215 (ite $x1207 v_0_tx_time_13 (ite $x1209 v_0_tx_time_14 (ite (= 15 ?x295) v_0_tx_time_15 0)))))
 (let ((?x1218 (ite $x1201 v_0_tx_time_10 (ite $x1203 v_0_tx_time_11 (ite $x1205 v_0_tx_time_12 ?x1215)))))
 (let ((?x1221 (ite $x1195 v_0_tx_time_07 (ite $x1197 v_0_tx_time_08 (ite $x1199 v_0_tx_time_09 ?x1218)))))
 (let ((?x1224 (ite $x1189 v_0_tx_time_04 (ite $x1191 v_0_tx_time_05 (ite $x1193 v_0_tx_time_06 ?x1221)))))
 (let ((?x1227 (ite $x1183 v_0_tx_time_01 (ite $x1185 v_0_tx_time_02 (ite $x1187 v_0_tx_time_03 ?x1224)))))
 (let (($x1231 (= v_1_tx_time_00 (ite (or (>= 0 ?x800) $x1178) 0 (ite $x1182 ?x1227 v_0_tx_time_00)))))
 (let (($x1164 (= v_1_rtt_sample_was_ambiguous (and v_0_rtt_active v_0_rtt_ambiguous))))
 (let (($x1159 (not v_1_rtt_start_new)))
 (let ((?x793 (* ?x268 ?x295)))
 (let ((?x1151 (+ ?x710 ?x793)))
 (let (($x1154 (and v_0_rtt_active $x291 $x309 $x324 (not (<= v_0_rtt_remaining ?x1151)))))
 (let (($x1139 (and v_0_rtt_active $x291 $x309 $x324 $x711)))
 (let (($x1157 (= v_1_rtt_remaining (ite $x1139 0 (ite $x1154 ?x1151 v_0_rtt_remaining)))))
 (let (($x1148 (= v_1_rtt_end v_0_rtt_end)))
 (let (($x1147 (= v_1_rtt_start_ms v_0_rtt_start_ms)))
 (let (($x1137 (= v_1_rtt_previous_measured (ite $x714 v_0_rtt_measured v_0_rtt_previous_measured))))
 (let (($x1130 (= v_1_rtt_previous_var (ite $x714 v_0_rttvar_ms v_0_rtt_previous_var))))
 (let (($x1126 (= v_1_rtt_previous_srtt (ite $x714 v_0_srtt_ms v_0_rtt_previous_srtt))))
 (let ((?x1106 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data) 4294967296)))
 (let (($x1099 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x1095 (= v_1_fin_requested v_0_fin_requested)))
 (let ((?x814 (mod (+ input_0_net.fin_segment_seq (* ?x268 v_0_snd_wl1)) 4294967296)))
 (let (($x809 (<= 2147483648 (mod (+ input_0_net.fin_segment_ack (* ?x268 v_0_snd_wl2)) 4294967296))))
 (let (($x805 (= v_0_snd_wl1 input_0_net.fin_segment_seq)))
 (let (($x820 (or (and $x805 (not $x809)) (and (not (<= ?x814 0)) (not (<= 2147483648 ?x814))))))
 (let (($x821 (and $x291 $x324 $x820)))
 (let ((?x1073 (ite (or (not (and $x359 (not $x641))) (and $x339 $x336 $x662)) 0 ?x638)))
 (let (($x889 (not $x641)))
 (let (($x693 (not $x359)))
 (let (($x858 (not $x398)))
 (let (($x856 (not $x418)))
 (let (($x854 (not $x438)))
 (let (($x852 (not $x458)))
 (let (($x850 (not $x478)))
 (let (($x848 (not $x498)))
 (let (($x846 (not $x516)))
 (let (($x844 (not $x534)))
 (let (($x842 (not $x552)))
 (let (($x840 (not $x570)))
 (let (($x838 (not $x588)))
 (let (($x836 (not $x606)))
 (let (($x834 (not $x624)))
 (let (($x833 (and false $x642)))
 (let (($x835 (and $x833 $x834)))
 (let (($x837 (and $x835 $x836)))
 (let (($x839 (and $x837 $x838)))
 (let (($x841 (and $x839 $x840)))
 (let (($x843 (and $x841 $x842)))
 (let (($x845 (and $x843 $x844)))
 (let (($x847 (and $x845 $x846)))
 (let (($x849 (and $x847 $x848)))
 (let (($x851 (and $x849 $x850)))
 (let (($x853 (and $x851 $x852)))
 (let (($x855 (and $x853 $x854)))
 (let (($x857 (and $x855 $x856)))
 (let (($x860 (or $x375 $x377 (and $x857 $x858))))
 (let ((?x687 (ite $x623 0 ?x620)))
 (let (($x663 (and $x339 $x336 $x662)))
 (let (($x1069 (= v_1_rx_slot_14 (ite $x663 0 (ite $x359 ?x687 (ite (and $x860 $x693 $x889) ?x638 0))))))
 (let (($x861 (and $x860 $x693)))
 (let ((?x1061 (ite $x861 ?x687 (ite (and (or $x857 $x398) (not $x378) $x693 $x889) ?x638 0))))
 (let ((?x686 (ite $x605 0 ?x602)))
 (let (($x863 (not $x378)))
 (let (($x862 (or $x857 $x398)))
 (let (($x864 (and $x862 $x863 $x693)))
 (let ((?x1054 (ite $x864 ?x687 (ite (and (or $x855 $x418) $x858 $x863 $x693 $x889) ?x638 0))))
 (let ((?x685 (ite $x587 0 ?x584)))
 (let (($x1058 (= v_1_rx_slot_12 (ite $x663 0 (ite $x359 ?x685 (ite $x861 ?x686 ?x1054))))))
 (let (($x865 (or $x855 $x418)))
 (let (($x866 (and $x865 $x858 $x863 $x693)))
 (let ((?x1046 (ite $x866 ?x687 (ite (and (or $x853 $x438) $x856 $x858 $x863 $x693 $x889) ?x638 0))))
 (let ((?x684 (ite $x569 0 ?x566)))
 (let (($x1051 (= v_1_rx_slot_11 (ite $x663 0 (ite $x359 ?x684 (ite $x861 ?x685 (ite $x864 ?x686 ?x1046)))))))
 (let (($x867 (or $x853 $x438)))
 (let (($x868 (and $x867 $x856 $x858 $x863 $x693)))
 (let ((?x1037 (ite $x868 ?x687 (ite (and (or $x851 $x458) $x854 $x856 $x858 $x863 $x693 $x889) ?x638 0))))
 (let ((?x683 (ite $x551 0 ?x548)))
 (let ((?x1042 (ite $x663 0 (ite $x359 ?x683 (ite $x861 ?x684 (ite $x864 ?x685 (ite $x866 ?x686 ?x1037)))))))
 (let ((?x1026 (ite (and (or $x849 $x478) $x852 $x854 $x856 $x858 $x863 $x693 $x889) ?x638 0)))
 (let (($x869 (or $x851 $x458)))
 (let (($x870 (and $x869 $x854 $x856 $x858 $x863 $x693)))
 (let ((?x1031 (ite $x861 ?x683 (ite $x864 ?x684 (ite $x866 ?x685 (ite $x868 ?x686 (ite $x870 ?x687 ?x1026)))))))
 (let ((?x682 (ite $x533 0 ?x530)))
 (let ((?x1015 (ite (and (or $x847 $x498) $x850 $x852 $x854 $x856 $x858 $x863 $x693 $x889) ?x638 0)))
 (let (($x871 (or $x849 $x478)))
 (let (($x872 (and $x871 $x852 $x854 $x856 $x858 $x863 $x693)))
 (let ((?x1020 (ite $x864 ?x683 (ite $x866 ?x684 (ite $x868 ?x685 (ite $x870 ?x686 (ite $x872 ?x687 ?x1015)))))))
 (let ((?x681 (ite $x515 0 ?x512)))
 (let (($x1024 (= v_1_rx_slot_08 (ite $x663 0 (ite $x359 ?x681 (ite $x861 ?x682 ?x1020))))))
 (let ((?x1003 (ite (and (or $x845 $x516) $x848 $x850 $x852 $x854 $x856 $x858 $x863 $x693 $x889) ?x638 0)))
 (let (($x873 (or $x847 $x498)))
 (let (($x874 (and $x873 $x850 $x852 $x854 $x856 $x858 $x863 $x693)))
 (let ((?x1008 (ite $x866 ?x683 (ite $x868 ?x684 (ite $x870 ?x685 (ite $x872 ?x686 (ite $x874 ?x687 ?x1003)))))))
 (let ((?x680 (ite $x497 0 ?x494)))
 (let (($x1013 (= v_1_rx_slot_07 (ite $x663 0 (ite $x359 ?x680 (ite $x861 ?x681 (ite $x864 ?x682 ?x1008)))))))
 (let (($x877 (or $x843 $x534)))
 (let ((?x990 (ite (and $x877 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x863 $x693 $x889) ?x638 0)))
 (let (($x875 (or $x845 $x516)))
 (let (($x876 (and $x875 $x848 $x850 $x852 $x854 $x856 $x858 $x863 $x693)))
 (let ((?x995 (ite $x868 ?x683 (ite $x870 ?x684 (ite $x872 ?x685 (ite $x874 ?x686 (ite $x876 ?x687 ?x990)))))))
 (let ((?x679 (ite $x477 0 ?x474)))
 (let ((?x1000 (ite $x663 0 (ite $x359 ?x679 (ite $x861 ?x680 (ite $x864 ?x681 (ite $x866 ?x682 ?x995)))))))
 (let (($x879 (or $x841 $x552)))
 (let ((?x976 (ite (and $x879 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x863 $x693 $x889) ?x638 0)))
 (let (($x878 (and $x877 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x863 $x693)))
 (let ((?x981 (ite $x870 ?x683 (ite $x872 ?x684 (ite $x874 ?x685 (ite $x876 ?x686 (ite $x878 ?x687 ?x976)))))))
 (let ((?x678 (ite $x457 0 ?x454)))
 (let ((?x986 (ite $x359 ?x678 (ite $x861 ?x679 (ite $x864 ?x680 (ite $x866 ?x681 (ite $x868 ?x682 ?x981)))))))
 (let (($x881 (or $x839 $x570)))
 (let (($x960 (and $x881 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x863 $x693 $x889)))
 (let (($x880 (and $x879 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x863 $x693)))
 (let ((?x965 (ite $x874 ?x684 (ite $x876 ?x685 (ite $x878 ?x686 (ite $x880 ?x687 (ite $x960 ?x638 0)))))))
 (let ((?x970 (ite $x864 ?x679 (ite $x866 ?x680 (ite $x868 ?x681 (ite $x870 ?x682 (ite $x872 ?x683 ?x965)))))))
 (let ((?x677 (ite $x437 0 ?x434)))
 (let (($x974 (= v_1_rx_slot_04 (ite $x663 0 (ite $x359 ?x677 (ite $x861 ?x678 ?x970))))))
 (let (($x883 (or $x837 $x588)))
 (let (($x944 (and $x883 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x863 $x693 $x889)))
 (let (($x882 (and $x881 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x863 $x693)))
 (let ((?x949 (ite $x876 ?x684 (ite $x878 ?x685 (ite $x880 ?x686 (ite $x882 ?x687 (ite $x944 ?x638 0)))))))
 (let ((?x954 (ite $x866 ?x679 (ite $x868 ?x680 (ite $x870 ?x681 (ite $x872 ?x682 (ite $x874 ?x683 ?x949)))))))
 (let ((?x676 (ite $x417 0 ?x414)))
 (let (($x959 (= v_1_rx_slot_03 (ite $x663 0 (ite $x359 ?x676 (ite $x861 ?x677 (ite $x864 ?x678 ?x954)))))))
 (let (($x885 (or $x835 $x606)))
 (let (($x927 (and $x885 $x838 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x863 $x693 $x889)))
 (let (($x884 (and $x883 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x863 $x693)))
 (let ((?x932 (ite $x878 ?x684 (ite $x880 ?x685 (ite $x882 ?x686 (ite $x884 ?x687 (ite $x927 ?x638 0)))))))
 (let ((?x937 (ite $x868 ?x679 (ite $x870 ?x680 (ite $x872 ?x681 (ite $x874 ?x682 (ite $x876 ?x683 ?x932)))))))
 (let ((?x675 (ite $x397 0 ?x394)))
 (let ((?x942 (ite $x663 0 (ite $x359 ?x675 (ite $x861 ?x676 (ite $x864 ?x677 (ite $x866 ?x678 ?x937)))))))
 (let (($x887 (or $x833 $x624)))
 (let (($x909 (and $x887 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x863 $x693 $x889)))
 (let (($x886 (and $x885 $x838 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x863 $x693)))
 (let ((?x914 (ite $x880 ?x684 (ite $x882 ?x685 (ite $x884 ?x686 (ite $x886 ?x687 (ite $x909 ?x638 0)))))))
 (let ((?x919 (ite $x870 ?x679 (ite $x872 ?x680 (ite $x874 ?x681 (ite $x876 ?x682 (ite $x878 ?x683 ?x914)))))))
 (let ((?x674 (ite $x377 0 ?x374)))
 (let ((?x924 (ite $x359 ?x674 (ite $x861 ?x675 (ite $x864 ?x676 (ite $x866 ?x677 (ite $x868 ?x678 ?x919)))))))
 (let (($x890 (and $x642 $x834 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x863 $x693 $x889)))
 (let (($x888 (and $x887 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x863 $x693)))
 (let ((?x895 (ite $x882 ?x684 (ite $x884 ?x685 (ite $x886 ?x686 (ite $x888 ?x687 (ite $x890 ?x638 0)))))))
 (let ((?x900 (ite $x872 ?x679 (ite $x874 ?x680 (ite $x876 ?x681 (ite $x878 ?x682 (ite $x880 ?x683 ?x895)))))))
 (let ((?x905 (ite $x861 ?x674 (ite $x864 ?x675 (ite $x866 ?x676 (ite $x868 ?x677 (ite $x870 ?x678 ?x900)))))))
 (let ((?x673 (ite $x358 0 ?x355)))
 (let ((?x695 (ite (and (<= 0 ?x658) $x693) ?x657 0)))
 (let ((?x689 (+ ?x673 ?x674 ?x675 ?x676 ?x677 ?x678 ?x679 ?x680 ?x681 ?x682 ?x683 ?x684 ?x685 ?x686 ?x687 (ite $x641 0 ?x638))))
 (let ((?x691 (ite (<= ?x689 0) 0 ?x689)))
 (let ((?x697 (ite (<= ?x691 ?x695) ?x691 ?x695)))
 (let (($x831 (= v_1_take v_0_take)))
 (let (($x791 (= v_1_snd_buf v_0_snd_buf)))
 (let (($x785 (= v_1_msl_ms v_0_msl_ms)))
 (let (($x782 (= v_1_user_timeout_ms v_0_user_timeout_ms)))
 (let (($x779 (= v_1_active_open v_0_active_open)))
 (let (($x776 (= v_1_retries v_0_retries)))
 (let (($x706 (= v_1_tx_flags v_0_tx_flags)))
 (let (($x703 (= v_1_tx_ack v_0_tx_ack)))
 (let (($x702 (= v_1_tx_seq v_0_tx_seq)))
 (let (($x701 (= v_1_rcv_nxt (mod (+ v_0_rcv_nxt ?x697 (ite $x663 1 0)) 4294967296))))
 (let (($x672 (= v_1_snd_nxt v_0_snd_nxt)))
 (let (($x668 (= v_1_irs v_0_irs)))
 (let (($x667 (= v_1_iss v_0_iss)))
 (let (($x664 (not $x663)))
 (let (($x301 (= (mod (+ input_0_net.fin_segment_ack (* ?x268 v_0_snd_nxt)) 4294967296) 2147483648)))
 (and (>= now_1 now_0) (<= 0 input_0_net.fin_segment_data) (>= 16 input_0_net.fin_segment_data) (not (= ?x271 2147483648)) (<= 0 input_0_net.fin_segment_window) (>= 65535 input_0_net.fin_segment_window) (or (not $x291) (and (not (= ?x295 2147483648)) (not $x301))) v_0_fin_sent (not (= ?x295 (+ 1 v_0_rtx_buf))) $x309 (<= ?x295 (mod (+ v_0_snd_nxt (* ?x268 v_0_snd_una)) 4294967296)) (or (not active_0_rtx) (not (<= due_0_rtx now_1))) (or (not active_0_user) (not (<= due_0_user now_1))) (or (not active_0_time_wait) (not (<= due_0_time_wait now_1))) $x327 $x664 $x666 $x667 $x668 (= v_1_snd_una (ite $x669 input_0_net.fin_segment_ack v_0_snd_una)) $x672 $x701 $x702 $x703 $x706 (= v_1_rto_ms ?x772) $x776 $x779 $x782 $x785 (= v_1_local_window (+ 16 (* ?x268 v_0_rcv_buf) (* ?x268 ?x697))) $x791 (= v_1_rtx_buf ?x800) (= v_1_rcv_buf (+ v_0_rcv_buf ?x697)) (= v_1_snd_wnd (ite $x821 input_0_net.fin_segment_window v_0_snd_wnd)) (= v_1_snd_wl1 (ite $x821 input_0_net.fin_segment_seq v_0_snd_wl1)) (= v_1_snd_wl2 (ite $x821 input_0_net.fin_segment_ack v_0_snd_wl2)) $x831 (= v_1_rx_chunk ?x697) (= v_1_rx_slot_00 (ite $x663 0 (ite $x359 ?x673 ?x905))) (= v_1_rx_slot_01 (ite $x663 0 ?x924)) (= v_1_rx_slot_02 ?x942) $x959 $x974 (= v_1_rx_slot_05 (ite $x663 0 ?x986)) (= v_1_rx_slot_06 ?x1000) $x1013 $x1024 (= v_1_rx_slot_09 (ite $x663 0 (ite $x359 ?x682 ?x1031))) (= v_1_rx_slot_10 ?x1042) $x1051 $x1058 (= v_1_rx_slot_13 (ite $x663 0 (ite $x359 ?x686 ?x1061))) $x1069 (= v_1_rx_slot_15 ?x1073) (= v_1_rx_advance ?x658) (= v_1_rx_acceptable (and $x291 $x334 $x336)) (= v_1_seg_acceptable $x291) (= v_1_ack_delta ?x295) (= v_1_ack_is_new (and $x309 $x324)) (= v_1_ack_is_future $x333) (= v_1_ack_advance $x669) (= v_1_ack_window_update $x821) $x1095 (= v_1_fin_sent $x1097) $x1099 (= v_1_fin_acknowledged $x326) (= v_1_rx_fin_pending (and $x339 $x664)) (= v_1_rx_fin_seq (ite $x338 ?x1106 v_0_rx_fin_seq)) (= v_1_rx_fin_offset (ite $x663 0 ?x661)) (= v_1_rx_fin_done (or v_0_rx_fin_done $x663)) (= v_1_rx_fin_consumed $x663) (= v_1_srtt_ms ?x734) (= v_1_rttvar_ms ?x757) (= v_1_rtt_error_ms ?x750) $x1126 $x1130 (= v_1_rtt_measured (or v_0_rtt_measured $x714)) $x1137 (= v_1_rtt_active (and v_0_rtt_active (not $x1139))) (= v_1_rtt_ambiguous (and (not $x1139) v_0_rtt_ambiguous)) $x1147 $x1148 $x1157 $x1159 (= v_1_rtt_sample_used $x714) $x1164 (= v_1_rtt_last_ms ?x729) (= v_1_rtt_samples (+ v_0_rtt_samples (ite $x714 1 0))) (= v_1_rto_base_ms (ite $x714 ?x770 v_0_rto_base_ms)) $x1231 (= v_1_tx_time_01 (ite (or (>= 1 ?x800) $x1178) 0 ?x1249)) (= v_1_tx_time_02 ?x1269) $x1288 (= v_1_tx_time_04 (ite (or (>= 4 ?x800) $x1178) 0 ?x1303)) (= v_1_tx_time_05 ?x1320) $x1336 (= v_1_tx_time_07 (ite (or (>= 7 ?x800) $x1178) 0 ?x1348)) (= v_1_tx_time_08 ?x1362) $x1375 (= v_1_tx_time_10 (ite (or (>= 10 ?x800) $x1178) 0 ?x1384)) (= v_1_tx_time_11 ?x1395) $x1405 (= v_1_tx_time_13 (ite (or $x1178 (>= 13 ?x800)) 0 ?x1411)) (= v_1_tx_time_14 ?x1419) $x1425 (= v_1_tx_fin_time (ite $x1097 v_0_tx_fin_time 0)) $x1432 $x1435 $x1438 $x1440 $x1443 $x1446 $x1449 $x1451 (= active_1_rtx (and $x666 $x1461)) (= active_1_user (and $x666 active_0_user)) (= active_1_time_wait (or active_0_time_wait $x665)) (= due_1_rtx (ite $x1456 (+ now_1 ?x772) due_0_rtx)) $x1475 (= due_1_time_wait (ite $x665 ?x1478 due_0_time_wait))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
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
 (let ((?x1486 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1486)))
(assert
 (>= 16 v_0_rcv_buf))
(assert
 (and (<= 0 v_0_snd_wnd) (>= 65535 v_0_snd_wnd)))
(assert
 (= v_0_local_window (+ 16 (* (- 1) v_0_rcv_buf))))
(assert
 (>= 1 v_0_rx_slot_00))
(assert
 (let (($x342 (= 0 v_0_rx_slot_00)))
 (let (($x1496 (not (>= v_0_rcv_buf 16))))
 (or $x1496 $x342))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x360 (= 0 v_0_rx_slot_01)))
 (let (($x1500 (not (>= v_0_rcv_buf 15))))
 (or $x1500 $x360))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x379 (= 0 v_0_rx_slot_02)))
 (let (($x1504 (not (>= v_0_rcv_buf 14))))
 (or $x1504 $x379))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x399 (= 0 v_0_rx_slot_03)))
 (let (($x1508 (not (>= v_0_rcv_buf 13))))
 (or $x1508 $x399))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x419 (= 0 v_0_rx_slot_04)))
 (let (($x1512 (not (>= v_0_rcv_buf 12))))
 (or $x1512 $x419))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x439 (= 0 v_0_rx_slot_05)))
 (let (($x1516 (not (>= v_0_rcv_buf 11))))
 (or $x1516 $x439))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x459 (= 0 v_0_rx_slot_06)))
 (let (($x1520 (not (>= v_0_rcv_buf 10))))
 (or $x1520 $x459))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x479 (= 0 v_0_rx_slot_07)))
 (let (($x1524 (not (>= v_0_rcv_buf 9))))
 (or $x1524 $x479))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x499 (= 0 v_0_rx_slot_08)))
 (let (($x1528 (not (>= v_0_rcv_buf 8))))
 (or $x1528 $x499))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x517 (= 0 v_0_rx_slot_09)))
 (let (($x1532 (not (>= v_0_rcv_buf 7))))
 (or $x1532 $x517))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x535 (= 0 v_0_rx_slot_10)))
 (let (($x1536 (not (>= v_0_rcv_buf 6))))
 (or $x1536 $x535))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x553 (= 0 v_0_rx_slot_11)))
 (let (($x1540 (not (>= v_0_rcv_buf 5))))
 (or $x1540 $x553))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x571 (= 0 v_0_rx_slot_12)))
 (let (($x1544 (not (>= v_0_rcv_buf 4))))
 (or $x1544 $x571))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x589 (= 0 v_0_rx_slot_13)))
 (let (($x1548 (not (>= v_0_rcv_buf 3))))
 (or $x1548 $x589))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x607 (= 0 v_0_rx_slot_14)))
 (let (($x1552 (not (>= v_0_rcv_buf 2))))
 (or $x1552 $x607))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x625 (= 0 v_0_rx_slot_15)))
 (let (($x1556 (not (>= v_0_rcv_buf 1))))
 (or $x1556 $x625))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x1558 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x1558)))
(assert
 (and (<= 0 v_0_rx_advance) (>= 16 v_0_rx_advance)))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (and (<= 0 v_0_ack_delta) (>= 4294967295 v_0_ack_delta)))
(assert
 true)
(assert
 (let ((?x1571 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x1571)))
(assert
 (= active_0_rtx (<= 1 (+ v_0_rtx_buf (ite v_0_fin_sent 1 0)))))
(assert
 (let (($x1580 (and v_0_fin_requested (= v_0_fin_seq (mod (+ v_0_snd_una v_0_rtx_buf) 4294967296)) (= 0 v_0_snd_buf))))
 (let (($x1575 (not v_0_fin_sent)))
 (or $x1575 $x1580))))
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
 (let (($x1582 (<= 1 v_0_rx_fin_offset)))
 (let (($x336 (not v_0_rx_fin_done)))
 (let (($x1584 (and $x336 $x1582 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window)))))
 (let (($x337 (not v_0_rx_fin_pending)))
 (or $x337 $x1584))))))
(assert
 (let (($x1587 (>= 15 v_0_rx_fin_offset)))
 (and (<= 0 v_0_rx_fin_offset) $x1587 (= v_0_rx_fin_pending (<= 1 v_0_rx_fin_offset)))))
(assert
 (let (($x337 (not v_0_rx_fin_pending)))
 (or $x337 (= v_0_rx_fin_seq (mod (+ v_0_rcv_nxt v_0_rx_fin_offset) 4294967296)))))
(assert
 (let (($x336 (not v_0_rx_fin_done)))
 (or $x336 (= v_0_rcv_nxt (mod (+ 1 v_0_rx_fin_seq) 4294967296)))))
(assert
 (let (($x342 (= 0 v_0_rx_slot_00)))
 (or (not (and v_0_rx_fin_pending (>= 0 v_0_rx_fin_offset))) $x342)))
(assert
 (let (($x360 (= 0 v_0_rx_slot_01)))
 (or (not (and v_0_rx_fin_pending (>= 1 v_0_rx_fin_offset))) $x360)))
(assert
 (let (($x379 (= 0 v_0_rx_slot_02)))
 (or (not (and v_0_rx_fin_pending (>= 2 v_0_rx_fin_offset))) $x379)))
(assert
 (let (($x399 (= 0 v_0_rx_slot_03)))
 (or (not (and v_0_rx_fin_pending (>= 3 v_0_rx_fin_offset))) $x399)))
(assert
 (let (($x419 (= 0 v_0_rx_slot_04)))
 (or (not (and v_0_rx_fin_pending (>= 4 v_0_rx_fin_offset))) $x419)))
(assert
 (let (($x439 (= 0 v_0_rx_slot_05)))
 (or (not (and v_0_rx_fin_pending (>= 5 v_0_rx_fin_offset))) $x439)))
(assert
 (let (($x459 (= 0 v_0_rx_slot_06)))
 (or (not (and v_0_rx_fin_pending (>= 6 v_0_rx_fin_offset))) $x459)))
(assert
 (let (($x479 (= 0 v_0_rx_slot_07)))
 (or (not (and v_0_rx_fin_pending (>= 7 v_0_rx_fin_offset))) $x479)))
(assert
 (let (($x499 (= 0 v_0_rx_slot_08)))
 (or (not (and v_0_rx_fin_pending (>= 8 v_0_rx_fin_offset))) $x499)))
(assert
 (let (($x517 (= 0 v_0_rx_slot_09)))
 (or (not (and v_0_rx_fin_pending (>= 9 v_0_rx_fin_offset))) $x517)))
(assert
 (let (($x535 (= 0 v_0_rx_slot_10)))
 (or (not (and v_0_rx_fin_pending (>= 10 v_0_rx_fin_offset))) $x535)))
(assert
 (let (($x553 (= 0 v_0_rx_slot_11)))
 (or (not (and v_0_rx_fin_pending (>= 11 v_0_rx_fin_offset))) $x553)))
(assert
 (let (($x571 (= 0 v_0_rx_slot_12)))
 (or (not (and v_0_rx_fin_pending (>= 12 v_0_rx_fin_offset))) $x571)))
(assert
 (let (($x589 (= 0 v_0_rx_slot_13)))
 (or (not (and v_0_rx_fin_pending (>= 13 v_0_rx_fin_offset))) $x589)))
(assert
 (let (($x607 (= 0 v_0_rx_slot_14)))
 (or (not (and v_0_rx_fin_pending (>= 14 v_0_rx_fin_offset))) $x607)))
(assert
 (let (($x625 (= 0 v_0_rx_slot_15)))
 (or (not (and v_0_rx_fin_pending (>= 15 v_0_rx_fin_offset))) $x625)))
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
 (let ((?x1675 (* 4.0 v_0_rttvar_ms)))
 (let ((?x717 (- 1.0)))
 (let ((?x746 (* ?x717 v_0_srtt_ms)))
 (let ((?x1678 (+ ?x746 (* ?x717 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x1675)))))
 (let ((?x1679 (to_int ?x1678)))
 (let ((?x268 (- 1)))
 (let ((?x1682 (ite (<= ?x1679 (- 1000)) (* ?x268 ?x1679) 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x1682) 60000 ?x1682) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x311 (mod (+ v_0_snd_nxt (* (- 1) v_0_snd_una)) 4294967296)))
 (let ((?x710 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x1695 (and (<= v_0_rtt_start_ms now_0) (<= 1 v_0_rtt_remaining) (>= 4 v_0_rtt_remaining) (>= ?x710 v_0_rtt_remaining) (<= ?x710 ?x311))))
 (let (($x1689 (not v_0_rtt_active)))
 (or $x1689 $x1695))))))
(assert
 (or v_0_rtt_active (= 0 v_0_rtt_remaining)))
(assert
 true)
(assert
 (let (($x1702 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1705 (and $x1702 v_0_rtt_measured (= v_0_rtt_last_ms (+ now_0 (* (- 1) v_0_rtt_start_ms))))))
 (let (($x1700 (not v_0_rtt_sample_used)))
 (or $x1700 $x1705)))))
(assert
 (let ((?x1708 (to_real v_0_rtt_last_ms)))
 (let ((?x1722 (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x1708))))
 (let ((?x1710 (+ v_0_rtt_previous_srtt (* (- 1.0) ?x1708))))
 (let ((?x1714 (ite (>= ?x1710 0.0) ?x1710 (+ (* (- 1.0) v_0_rtt_previous_srtt) ?x1708))))
 (let ((?x741 (/ 1.0 4.0)))
 (let ((?x1718 (ite v_0_rtt_previous_measured (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* ?x741 ?x1714)) (* (/ 1.0 2.0) ?x1708))))
 (let (($x1725 (and (= v_0_rttvar_ms ?x1718) (= v_0_srtt_ms (ite v_0_rtt_previous_measured ?x1722 ?x1708)))))
 (let (($x1700 (not v_0_rtt_sample_used)))
 (or $x1700 $x1725))))))))))
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
 (let (($x1861 (and (>= v_0_tx_elapsed v_0_tx_previous_rto) (<= 1 v_0_tx_emit_count) (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x1855 (not v_0_tx_retransmitted)))
 (or $x1855 $x1861))))
(assert
 (let (($x1855 (not v_0_tx_retransmitted)))
 (or $x1855 (not v_0_tx_waiting))))
(assert
 (= 178 choice_0))
(assert
 (= 5 state_0))
(assert
 (= 5 state_1))
(assert
 (or (not (<= 0 v_1_tx_time_05)) (not (<= v_1_tx_time_05 now_1)) (not (or (not (>= 5 v_1_rtx_buf)) (= 0 v_1_tx_time_05))) (not (<= 0 v_1_tx_time_06)) (not (<= v_1_tx_time_06 now_1)) (not (or (not (>= 6 v_1_rtx_buf)) (= 0 v_1_tx_time_06))) (not (<= 0 v_1_tx_time_07)) (not (<= v_1_tx_time_07 now_1)) (not (or (not (>= 7 v_1_rtx_buf)) (= 0 v_1_tx_time_07))) (not (<= 0 v_1_tx_time_08)) (not (<= v_1_tx_time_08 now_1)) (not (or (not (>= 8 v_1_rtx_buf)) (= 0 v_1_tx_time_08))) (not (<= 0 v_1_tx_time_09)) (not (<= v_1_tx_time_09 now_1)) (not (or (not (>= 9 v_1_rtx_buf)) (= 0 v_1_tx_time_09))) (not (<= 0 v_1_tx_time_10))))
(check-sat)
