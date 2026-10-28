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
 (let ((?x1480 (+ now_1 (* 2 v_0_msl_ms))))
 (let ((?x320 (ite v_0_fin_sent 1 0)))
 (let ((?x321 (+ v_0_rtx_buf ?x320)))
 (let ((?x281 (mod (+ input_0_net.fin_segment_ack (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x323 (= ?x281 ?x321)))
 (let (($x322 (<= ?x281 ?x321)))
 (let (($x319 (<= 1 ?x281)))
 (let ((?x268 (- 1)))
 (let ((?x295 (+ ?x268 v_0_local_window)))
 (let ((?x292 (* ?x268 v_0_rcv_nxt)))
 (let ((?x299 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data ?x292) 4294967296)))
 (let (($x300 (<= ?x299 ?x295)))
 (let (($x291 (<= 1 v_0_local_window)))
 (let (($x302 (or (and $x291 (<= (mod (+ input_0_net.fin_segment_seq ?x292) 4294967296) ?x295)) (and $x291 $x300))))
 (let (($x335 (not v_0_rx_fin_pending)))
 (let (($x334 (not v_0_rx_fin_done)))
 (let (($x331 (and (>= ?x281 (+ 1 v_0_rtx_buf ?x320)) (>= 2147483647 ?x281))))
 (let (($x332 (not $x331)))
 (let (($x336 (and $x302 $x332 $x334 $x335 $x291 $x300)))
 (let ((?x339 (ite $x336 ?x299 v_0_rx_fin_offset)))
 (let (($x337 (or v_0_rx_fin_pending $x336)))
 (let (($x639 (and $x337 (>= 15 ?x339))))
 (let ((?x626 (mod (+ 15 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x631 (+ input_0_net.fin_segment_data (* ?x268 ?x626))))
 (let (($x629 (<= input_0_net.fin_segment_data ?x626)))
 (let (($x624 (<= v_0_rcv_buf 0)))
 (let (($x623 (= 0 v_0_rx_slot_15)))
 (let (($x628 (and $x302 $x332 $x334 $x623 $x624 (<= ?x626 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x636 (ite $x628 (ite (or $x629 (<= ?x631 1)) (ite $x629 0 ?x631) 1) v_0_rx_slot_15)))
 (let (($x640 (or (= ?x636 0) $x639)))
 (let (($x621 (and $x337 (>= 14 ?x339))))
 (let ((?x608 (mod (+ 14 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x613 (+ input_0_net.fin_segment_data (* ?x268 ?x608))))
 (let (($x611 (<= input_0_net.fin_segment_data ?x608)))
 (let (($x606 (<= v_0_rcv_buf 1)))
 (let (($x605 (= 0 v_0_rx_slot_14)))
 (let (($x610 (and $x302 $x332 $x334 $x605 $x606 (<= ?x608 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x618 (ite $x610 (ite (or $x611 (<= ?x613 1)) (ite $x611 0 ?x613) 1) v_0_rx_slot_14)))
 (let (($x622 (or (= ?x618 0) $x621)))
 (let (($x603 (and $x337 (>= 13 ?x339))))
 (let ((?x590 (mod (+ 13 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x595 (+ input_0_net.fin_segment_data (* ?x268 ?x590))))
 (let (($x593 (<= input_0_net.fin_segment_data ?x590)))
 (let (($x588 (<= v_0_rcv_buf 2)))
 (let (($x587 (= 0 v_0_rx_slot_13)))
 (let (($x592 (and $x302 $x332 $x334 $x587 $x588 (<= ?x590 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x600 (ite $x592 (ite (or $x593 (<= ?x595 1)) (ite $x593 0 ?x595) 1) v_0_rx_slot_13)))
 (let (($x604 (or (= ?x600 0) $x603)))
 (let (($x585 (and $x337 (>= 12 ?x339))))
 (let ((?x572 (mod (+ 12 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x577 (+ input_0_net.fin_segment_data (* ?x268 ?x572))))
 (let (($x575 (<= input_0_net.fin_segment_data ?x572)))
 (let (($x570 (<= v_0_rcv_buf 3)))
 (let (($x569 (= 0 v_0_rx_slot_12)))
 (let (($x574 (and $x302 $x332 $x334 $x569 $x570 (<= ?x572 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x582 (ite $x574 (ite (or $x575 (<= ?x577 1)) (ite $x575 0 ?x577) 1) v_0_rx_slot_12)))
 (let (($x586 (or (= ?x582 0) $x585)))
 (let ((?x644 (ite $x586 12 (ite $x604 13 (ite $x622 14 (ite $x640 15 16))))))
 (let (($x567 (and $x337 (>= 11 ?x339))))
 (let ((?x554 (mod (+ 11 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x559 (+ input_0_net.fin_segment_data (* ?x268 ?x554))))
 (let (($x557 (<= input_0_net.fin_segment_data ?x554)))
 (let (($x552 (<= v_0_rcv_buf 4)))
 (let (($x551 (= 0 v_0_rx_slot_11)))
 (let (($x556 (and $x302 $x332 $x334 $x551 $x552 (<= ?x554 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x564 (ite $x556 (ite (or $x557 (<= ?x559 1)) (ite $x557 0 ?x559) 1) v_0_rx_slot_11)))
 (let (($x568 (or (= ?x564 0) $x567)))
 (let (($x549 (and $x337 (>= 10 ?x339))))
 (let ((?x536 (mod (+ 10 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x541 (+ input_0_net.fin_segment_data (* ?x268 ?x536))))
 (let (($x539 (<= input_0_net.fin_segment_data ?x536)))
 (let (($x534 (<= v_0_rcv_buf 5)))
 (let (($x533 (= 0 v_0_rx_slot_10)))
 (let (($x538 (and $x302 $x332 $x334 $x533 $x534 (<= ?x536 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x546 (ite $x538 (ite (or $x539 (<= ?x541 1)) (ite $x539 0 ?x541) 1) v_0_rx_slot_10)))
 (let (($x550 (or (= ?x546 0) $x549)))
 (let (($x531 (and $x337 (>= 9 ?x339))))
 (let ((?x518 (mod (+ 9 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x523 (+ input_0_net.fin_segment_data (* ?x268 ?x518))))
 (let (($x521 (<= input_0_net.fin_segment_data ?x518)))
 (let (($x516 (<= v_0_rcv_buf 6)))
 (let (($x515 (= 0 v_0_rx_slot_09)))
 (let (($x520 (and $x302 $x332 $x334 $x515 $x516 (<= ?x518 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x528 (ite $x520 (ite (or $x521 (<= ?x523 1)) (ite $x521 0 ?x523) 1) v_0_rx_slot_09)))
 (let (($x532 (or (= ?x528 0) $x531)))
 (let (($x513 (and $x337 (>= 8 ?x339))))
 (let ((?x500 (mod (+ 8 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x505 (+ input_0_net.fin_segment_data (* ?x268 ?x500))))
 (let (($x503 (<= input_0_net.fin_segment_data ?x500)))
 (let (($x498 (<= v_0_rcv_buf 7)))
 (let (($x497 (= 0 v_0_rx_slot_08)))
 (let (($x502 (and $x302 $x332 $x334 $x497 $x498 (<= ?x500 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x510 (ite $x502 (ite (or $x503 (<= ?x505 1)) (ite $x503 0 ?x505) 1) v_0_rx_slot_08)))
 (let (($x514 (or (= ?x510 0) $x513)))
 (let ((?x648 (ite $x514 8 (ite $x532 9 (ite $x550 10 (ite $x568 11 ?x644))))))
 (let (($x495 (and $x337 (>= 7 ?x339))))
 (let ((?x482 (mod (+ 7 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x487 (+ input_0_net.fin_segment_data (* ?x268 ?x482))))
 (let (($x485 (<= input_0_net.fin_segment_data ?x482)))
 (let (($x479 (<= v_0_rcv_buf 8)))
 (let (($x477 (= 0 v_0_rx_slot_07)))
 (let (($x484 (and $x302 $x332 $x334 $x477 $x479 (<= ?x482 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x492 (ite $x484 (ite (or $x485 (<= ?x487 1)) (ite $x485 0 ?x487) 1) v_0_rx_slot_07)))
 (let (($x496 (or (= ?x492 0) $x495)))
 (let (($x475 (and $x337 (>= 6 ?x339))))
 (let ((?x462 (mod (+ 6 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x467 (+ input_0_net.fin_segment_data (* ?x268 ?x462))))
 (let (($x465 (<= input_0_net.fin_segment_data ?x462)))
 (let (($x459 (<= v_0_rcv_buf 9)))
 (let (($x457 (= 0 v_0_rx_slot_06)))
 (let (($x464 (and $x302 $x332 $x334 $x457 $x459 (<= ?x462 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x472 (ite $x464 (ite (or $x465 (<= ?x467 1)) (ite $x465 0 ?x467) 1) v_0_rx_slot_06)))
 (let (($x476 (or (= ?x472 0) $x475)))
 (let (($x455 (and $x337 (>= 5 ?x339))))
 (let ((?x442 (mod (+ 5 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x447 (+ input_0_net.fin_segment_data (* ?x268 ?x442))))
 (let (($x445 (<= input_0_net.fin_segment_data ?x442)))
 (let (($x439 (<= v_0_rcv_buf 10)))
 (let (($x437 (= 0 v_0_rx_slot_05)))
 (let (($x444 (and $x302 $x332 $x334 $x437 $x439 (<= ?x442 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x452 (ite $x444 (ite (or $x445 (<= ?x447 1)) (ite $x445 0 ?x447) 1) v_0_rx_slot_05)))
 (let (($x456 (or (= ?x452 0) $x455)))
 (let (($x435 (and $x337 (>= 4 ?x339))))
 (let ((?x422 (mod (+ 4 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x427 (+ input_0_net.fin_segment_data (* ?x268 ?x422))))
 (let (($x425 (<= input_0_net.fin_segment_data ?x422)))
 (let (($x419 (<= v_0_rcv_buf 11)))
 (let (($x417 (= 0 v_0_rx_slot_04)))
 (let (($x424 (and $x302 $x332 $x334 $x417 $x419 (<= ?x422 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x432 (ite $x424 (ite (or $x425 (<= ?x427 1)) (ite $x425 0 ?x427) 1) v_0_rx_slot_04)))
 (let (($x436 (or (= ?x432 0) $x435)))
 (let ((?x652 (ite $x436 4 (ite $x456 5 (ite $x476 6 (ite $x496 7 ?x648))))))
 (let (($x415 (and $x337 (>= 3 ?x339))))
 (let ((?x402 (mod (+ 3 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x407 (+ input_0_net.fin_segment_data (* ?x268 ?x402))))
 (let (($x405 (<= input_0_net.fin_segment_data ?x402)))
 (let (($x399 (<= v_0_rcv_buf 12)))
 (let (($x397 (= 0 v_0_rx_slot_03)))
 (let (($x404 (and $x302 $x332 $x334 $x397 $x399 (<= ?x402 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x412 (ite $x404 (ite (or $x405 (<= ?x407 1)) (ite $x405 0 ?x407) 1) v_0_rx_slot_03)))
 (let (($x416 (or (= ?x412 0) $x415)))
 (let (($x395 (and $x337 (>= 2 ?x339))))
 (let ((?x382 (mod (+ 2 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x387 (+ input_0_net.fin_segment_data (* ?x268 ?x382))))
 (let (($x385 (<= input_0_net.fin_segment_data ?x382)))
 (let (($x379 (<= v_0_rcv_buf 13)))
 (let (($x377 (= 0 v_0_rx_slot_02)))
 (let (($x384 (and $x302 $x332 $x334 $x377 $x379 (<= ?x382 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x392 (ite $x384 (ite (or $x385 (<= ?x387 1)) (ite $x385 0 ?x387) 1) v_0_rx_slot_02)))
 (let (($x396 (or (= ?x392 0) $x395)))
 (let (($x375 (and $x337 (>= 1 ?x339))))
 (let ((?x362 (mod (+ 1 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x367 (+ input_0_net.fin_segment_data (* ?x268 ?x362))))
 (let (($x365 (<= input_0_net.fin_segment_data ?x362)))
 (let (($x360 (<= v_0_rcv_buf 14)))
 (let (($x358 (= 0 v_0_rx_slot_01)))
 (let (($x364 (and $x302 $x332 $x334 $x358 $x360 (<= ?x362 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x372 (ite $x364 (ite (or $x365 (<= ?x367 1)) (ite $x365 0 ?x367) 1) v_0_rx_slot_01)))
 (let (($x373 (= ?x372 0)))
 (let (($x376 (or $x373 $x375)))
 (let ((?x655 (ite $x376 1 (ite $x396 2 (ite $x416 3 ?x652)))))
 (let (($x356 (and $x337 (>= 0 ?x339))))
 (let ((?x271 (mod (+ v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x348 (+ input_0_net.fin_segment_data (* ?x268 ?x271))))
 (let (($x346 (<= input_0_net.fin_segment_data ?x271)))
 (let (($x342 (<= v_0_rcv_buf 15)))
 (let (($x340 (= 0 v_0_rx_slot_00)))
 (let (($x345 (and $x302 $x332 $x334 $x340 $x342 (<= ?x271 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x353 (ite $x345 (ite (or $x346 (<= ?x348 1)) (ite $x346 0 ?x348) 1) v_0_rx_slot_00)))
 (let (($x354 (= ?x353 0)))
 (let (($x357 (or $x354 $x356)))
 (let ((?x656 (ite $x357 0 ?x655)))
 (let ((?x659 (ite $x337 (+ ?x339 (* ?x268 ?x656)) ?x339)))
 (let (($x660 (= 0 ?x659)))
 (let (($x663 (and $x337 $x334 $x660 $x302 $x319 $x322 v_0_fin_sent $x323)))
 (let (($x1477 (= due_1_user due_0_user)))
 (let (($x711 (not v_0_rtt_ambiguous)))
 (let ((?x708 (mod (+ v_0_rtt_end (* ?x268 v_0_snd_una)) 4294967296)))
 (let (($x709 (>= ?x281 ?x708)))
 (let (($x712 (and v_0_rtt_active $x302 $x319 $x322 $x709 $x711)))
 (let ((?x727 (ite $x712 (+ now_1 (* ?x268 v_0_rtt_start_ms)) v_0_rtt_last_ms)))
 (let ((?x728 (to_real ?x727)))
 (let ((?x752 (/ 1.0 2.0)))
 (let ((?x741 (+ v_0_srtt_ms (* (- 1.0) ?x728))))
 (let ((?x748 (ite $x712 (ite (>= ?x741 0.0) ?x741 (+ (* (- 1.0) v_0_srtt_ms) ?x728)) v_0_rtt_error_ms)))
 (let ((?x739 (/ 1.0 4.0)))
 (let ((?x754 (ite v_0_rtt_measured (+ (* (/ 3.0 4.0) v_0_rttvar_ms) (* ?x739 ?x748)) (* ?x752 ?x728))))
 (let ((?x755 (ite $x712 ?x754 v_0_rttvar_ms)))
 (let ((?x715 (- 1.0)))
 (let ((?x731 (ite v_0_rtt_measured (+ (* (/ 7.0 8.0) v_0_srtt_ms) (* (/ 1.0 8.0) ?x728)) ?x728)))
 (let ((?x732 (ite $x712 ?x731 v_0_srtt_ms)))
 (let ((?x760 (+ (* ?x715 ?x732) (* ?x715 (ite (<= ?x755 ?x739) 1.0 (* 4.0 ?x755))))))
 (let ((?x761 (to_int ?x760)))
 (let ((?x766 (ite (<= ?x761 (- 1000)) (* ?x268 ?x761) 1000)))
 (let ((?x768 (ite (<= 60000 ?x766) 60000 ?x766)))
 (let ((?x770 (ite $x712 ?x768 v_0_rto_ms)))
 (let (($x324 (and $x302 $x319 $x322 v_0_fin_sent $x323)))
 (let (($x325 (not $x324)))
 (let (($x1096 (and $x325 v_0_fin_sent)))
 (let ((?x795 (ite (<= 0 v_0_rtx_buf) v_0_rtx_buf 0)))
 (let ((?x793 (ite (<= v_0_rtx_buf ?x281) 0 (+ v_0_rtx_buf (* ?x268 ?x281)))))
 (let (($x667 (and $x302 $x319 $x322)))
 (let ((?x798 (ite $x667 (ite (<= ?x793 ?x795) ?x793 ?x795) v_0_rtx_buf)))
 (let ((?x1456 (+ ?x798 (ite $x1096 1 0))))
 (let (($x1462 (and $x302 $x319 $x322 (<= 1 ?x1456))))
 (let (($x1463 (or (and (not (and $x302 $x319 $x322 (= 0 ?x1456))) active_0_rtx) $x1462)))
 (let (($x664 (not $x663)))
 (let (($x1453 (not v_1_tx_waiting)))
 (let (($x1451 (= v_1_tx_is_fin v_0_tx_is_fin)))
 (let (($x1448 (= v_1_tx_previous_rto v_0_tx_previous_rto)))
 (let (($x1445 (= v_1_tx_elapsed v_0_tx_elapsed)))
 (let (($x1442 (not v_1_tx_retransmitted)))
 (let (($x1440 (= v_1_tx_max_previous v_0_tx_max_previous)))
 (let (($x1437 (= v_1_tx_eligible v_0_tx_eligible)))
 (let (($x1434 (= v_1_tx_emit_count v_0_tx_emit_count)))
 (let (($x1184 (and $x302 $x319 $x322 (not (= 0 ?x281)))))
 (let (($x1180 (= 0 ?x798)))
 (let (($x1427 (= v_1_tx_time_15 (ite (or $x1180 (>= 15 ?x798) $x1184) 0 v_0_tx_time_15))))
 (let ((?x1421 (ite (or (>= 14 ?x798) $x1180) 0 (ite $x1184 (ite (= 1 ?x281) v_0_tx_time_15 0) v_0_tx_time_14))))
 (let (($x1185 (= 1 ?x281)))
 (let ((?x1413 (ite $x1184 (ite $x1185 v_0_tx_time_14 (ite (= 2 ?x281) v_0_tx_time_15 0)) v_0_tx_time_13)))
 (let (($x1187 (= 2 ?x281)))
 (let ((?x1404 (ite $x1185 v_0_tx_time_13 (ite $x1187 v_0_tx_time_14 (ite (= 3 ?x281) v_0_tx_time_15 0)))))
 (let (($x1407 (= v_1_tx_time_12 (ite (or $x1180 (>= 12 ?x798)) 0 (ite $x1184 ?x1404 v_0_tx_time_12)))))
 (let (($x1189 (= 3 ?x281)))
 (let ((?x1394 (ite $x1187 v_0_tx_time_13 (ite $x1189 v_0_tx_time_14 (ite (= 4 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1397 (ite (or (>= 11 ?x798) $x1180) 0 (ite $x1184 (ite $x1185 v_0_tx_time_12 ?x1394) v_0_tx_time_11))))
 (let (($x1191 (= 4 ?x281)))
 (let ((?x1383 (ite $x1189 v_0_tx_time_13 (ite $x1191 v_0_tx_time_14 (ite (= 5 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1386 (ite $x1184 (ite $x1185 v_0_tx_time_11 (ite $x1187 v_0_tx_time_12 ?x1383)) v_0_tx_time_10)))
 (let (($x1193 (= 5 ?x281)))
 (let ((?x1371 (ite $x1191 v_0_tx_time_13 (ite $x1193 v_0_tx_time_14 (ite (= 6 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1374 (ite $x1185 v_0_tx_time_10 (ite $x1187 v_0_tx_time_11 (ite $x1189 v_0_tx_time_12 ?x1371)))))
 (let (($x1377 (= v_1_tx_time_09 (ite (or (>= 9 ?x798) $x1180) 0 (ite $x1184 ?x1374 v_0_tx_time_09)))))
 (let (($x1195 (= 6 ?x281)))
 (let ((?x1358 (ite $x1193 v_0_tx_time_13 (ite $x1195 v_0_tx_time_14 (ite (= 7 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1361 (ite $x1187 v_0_tx_time_10 (ite $x1189 v_0_tx_time_11 (ite $x1191 v_0_tx_time_12 ?x1358)))))
 (let ((?x1364 (ite (or (>= 8 ?x798) $x1180) 0 (ite $x1184 (ite $x1185 v_0_tx_time_09 ?x1361) v_0_tx_time_08))))
 (let (($x1197 (= 7 ?x281)))
 (let ((?x1344 (ite $x1195 v_0_tx_time_13 (ite $x1197 v_0_tx_time_14 (ite (= 8 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1347 (ite $x1189 v_0_tx_time_10 (ite $x1191 v_0_tx_time_11 (ite $x1193 v_0_tx_time_12 ?x1344)))))
 (let ((?x1350 (ite $x1184 (ite $x1185 v_0_tx_time_08 (ite $x1187 v_0_tx_time_09 ?x1347)) v_0_tx_time_07)))
 (let (($x1199 (= 8 ?x281)))
 (let ((?x1329 (ite $x1197 v_0_tx_time_13 (ite $x1199 v_0_tx_time_14 (ite (= 9 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1332 (ite $x1191 v_0_tx_time_10 (ite $x1193 v_0_tx_time_11 (ite $x1195 v_0_tx_time_12 ?x1329)))))
 (let ((?x1335 (ite $x1185 v_0_tx_time_07 (ite $x1187 v_0_tx_time_08 (ite $x1189 v_0_tx_time_09 ?x1332)))))
 (let (($x1338 (= v_1_tx_time_06 (ite (or $x1180 (>= 6 ?x798)) 0 (ite $x1184 ?x1335 v_0_tx_time_06)))))
 (let (($x1201 (= 9 ?x281)))
 (let ((?x1313 (ite $x1199 v_0_tx_time_13 (ite $x1201 v_0_tx_time_14 (ite (= 10 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1316 (ite $x1193 v_0_tx_time_10 (ite $x1195 v_0_tx_time_11 (ite $x1197 v_0_tx_time_12 ?x1313)))))
 (let ((?x1319 (ite $x1187 v_0_tx_time_07 (ite $x1189 v_0_tx_time_08 (ite $x1191 v_0_tx_time_09 ?x1316)))))
 (let ((?x1322 (ite (or $x1180 (>= 5 ?x798)) 0 (ite $x1184 (ite $x1185 v_0_tx_time_06 ?x1319) v_0_tx_time_05))))
 (let (($x1203 (= 10 ?x281)))
 (let ((?x1296 (ite $x1201 v_0_tx_time_13 (ite $x1203 v_0_tx_time_14 (ite (= 11 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1299 (ite $x1195 v_0_tx_time_10 (ite $x1197 v_0_tx_time_11 (ite $x1199 v_0_tx_time_12 ?x1296)))))
 (let ((?x1302 (ite $x1189 v_0_tx_time_07 (ite $x1191 v_0_tx_time_08 (ite $x1193 v_0_tx_time_09 ?x1299)))))
 (let ((?x1305 (ite $x1184 (ite $x1185 v_0_tx_time_05 (ite $x1187 v_0_tx_time_06 ?x1302)) v_0_tx_time_04)))
 (let (($x1205 (= 11 ?x281)))
 (let ((?x1278 (ite $x1203 v_0_tx_time_13 (ite $x1205 v_0_tx_time_14 (ite (= 12 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1281 (ite $x1197 v_0_tx_time_10 (ite $x1199 v_0_tx_time_11 (ite $x1201 v_0_tx_time_12 ?x1278)))))
 (let ((?x1284 (ite $x1191 v_0_tx_time_07 (ite $x1193 v_0_tx_time_08 (ite $x1195 v_0_tx_time_09 ?x1281)))))
 (let ((?x1287 (ite $x1185 v_0_tx_time_04 (ite $x1187 v_0_tx_time_05 (ite $x1189 v_0_tx_time_06 ?x1284)))))
 (let (($x1290 (= v_1_tx_time_03 (ite (or (>= 3 ?x798) $x1180) 0 (ite $x1184 ?x1287 v_0_tx_time_03)))))
 (let (($x1207 (= 12 ?x281)))
 (let ((?x1259 (ite $x1205 v_0_tx_time_13 (ite $x1207 v_0_tx_time_14 (ite (= 13 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1262 (ite $x1199 v_0_tx_time_10 (ite $x1201 v_0_tx_time_11 (ite $x1203 v_0_tx_time_12 ?x1259)))))
 (let ((?x1265 (ite $x1193 v_0_tx_time_07 (ite $x1195 v_0_tx_time_08 (ite $x1197 v_0_tx_time_09 ?x1262)))))
 (let ((?x1268 (ite $x1187 v_0_tx_time_04 (ite $x1189 v_0_tx_time_05 (ite $x1191 v_0_tx_time_06 ?x1265)))))
 (let ((?x1271 (ite (or $x1180 (>= 2 ?x798)) 0 (ite $x1184 (ite $x1185 v_0_tx_time_03 ?x1268) v_0_tx_time_02))))
 (let (($x1209 (= 13 ?x281)))
 (let ((?x1239 (ite $x1207 v_0_tx_time_13 (ite $x1209 v_0_tx_time_14 (ite (= 14 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1242 (ite $x1201 v_0_tx_time_10 (ite $x1203 v_0_tx_time_11 (ite $x1205 v_0_tx_time_12 ?x1239)))))
 (let ((?x1245 (ite $x1195 v_0_tx_time_07 (ite $x1197 v_0_tx_time_08 (ite $x1199 v_0_tx_time_09 ?x1242)))))
 (let ((?x1248 (ite $x1189 v_0_tx_time_04 (ite $x1191 v_0_tx_time_05 (ite $x1193 v_0_tx_time_06 ?x1245)))))
 (let ((?x1251 (ite $x1184 (ite $x1185 v_0_tx_time_02 (ite $x1187 v_0_tx_time_03 ?x1248)) v_0_tx_time_01)))
 (let (($x1211 (= 14 ?x281)))
 (let ((?x1217 (ite $x1209 v_0_tx_time_13 (ite $x1211 v_0_tx_time_14 (ite (= 15 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1220 (ite $x1203 v_0_tx_time_10 (ite $x1205 v_0_tx_time_11 (ite $x1207 v_0_tx_time_12 ?x1217)))))
 (let ((?x1223 (ite $x1197 v_0_tx_time_07 (ite $x1199 v_0_tx_time_08 (ite $x1201 v_0_tx_time_09 ?x1220)))))
 (let ((?x1226 (ite $x1191 v_0_tx_time_04 (ite $x1193 v_0_tx_time_05 (ite $x1195 v_0_tx_time_06 ?x1223)))))
 (let ((?x1229 (ite $x1185 v_0_tx_time_01 (ite $x1187 v_0_tx_time_02 (ite $x1189 v_0_tx_time_03 ?x1226)))))
 (let (($x1233 (= v_1_tx_time_00 (ite (or $x1180 (>= 0 ?x798)) 0 (ite $x1184 ?x1229 v_0_tx_time_00)))))
 (let (($x1167 (= v_1_rtt_sample_was_ambiguous (and v_0_rtt_active v_0_rtt_ambiguous))))
 (let (($x1162 (not v_1_rtt_start_new)))
 (let ((?x791 (* ?x268 ?x281)))
 (let ((?x1154 (+ ?x708 ?x791)))
 (let (($x1157 (and v_0_rtt_active $x302 $x319 $x322 (not (<= v_0_rtt_remaining ?x1154)))))
 (let (($x1138 (and v_0_rtt_active $x302 $x319 $x322 $x709)))
 (let (($x1160 (= v_1_rtt_remaining (ite $x1138 0 (ite $x1157 ?x1154 v_0_rtt_remaining)))))
 (let (($x1151 (= v_1_rtt_end v_0_rtt_end)))
 (let (($x1150 (= v_1_rtt_start_ms v_0_rtt_start_ms)))
 (let (($x1136 (= v_1_rtt_previous_measured (ite $x712 v_0_rtt_measured v_0_rtt_previous_measured))))
 (let (($x1129 (= v_1_rtt_previous_var (ite $x712 v_0_rttvar_ms v_0_rtt_previous_var))))
 (let (($x1125 (= v_1_rtt_previous_srtt (ite $x712 v_0_srtt_ms v_0_rtt_previous_srtt))))
 (let ((?x1105 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data) 4294967296)))
 (let (($x1098 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x1094 (= v_1_fin_requested v_0_fin_requested)))
 (let (($x815 (<= 2147483648 (mod (+ input_0_net.fin_segment_ack (* ?x268 v_0_snd_wl2)) 4294967296))))
 (let (($x811 (= v_0_snd_wl1 input_0_net.fin_segment_seq)))
 (let ((?x805 (mod (+ input_0_net.fin_segment_seq (* ?x268 v_0_snd_wl1)) 4294967296)))
 (let (($x818 (or (and (not (<= ?x805 0)) (not (<= 2147483648 ?x805))) (and $x811 (not $x815)))))
 (let (($x819 (and $x302 $x322 $x818)))
 (let ((?x1072 (ite (or (and $x337 $x334 $x660) (not (and (or $x356 $x354) (not $x639)))) 0 ?x636)))
 (let (($x888 (not $x639)))
 (let (($x691 (not $x357)))
 (let (($x857 (not $x396)))
 (let (($x855 (not $x416)))
 (let (($x853 (not $x436)))
 (let (($x851 (not $x456)))
 (let (($x849 (not $x476)))
 (let (($x847 (not $x496)))
 (let (($x845 (not $x514)))
 (let (($x843 (not $x532)))
 (let (($x841 (not $x550)))
 (let (($x839 (not $x568)))
 (let (($x837 (not $x586)))
 (let (($x835 (not $x604)))
 (let (($x833 (not $x622)))
 (let (($x832 (and false $x640)))
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
 (let (($x859 (or $x375 $x373 (and $x856 $x857))))
 (let ((?x685 (ite $x621 0 ?x618)))
 (let (($x831 (or $x356 $x354)))
 (let (($x661 (and $x337 $x334 $x660)))
 (let (($x1068 (= v_1_rx_slot_14 (ite $x661 0 (ite $x831 ?x685 (ite (and $x859 $x691 $x888) ?x636 0))))))
 (let (($x860 (and $x859 $x691)))
 (let ((?x1060 (ite $x860 ?x685 (ite (and (or $x856 $x396) (not $x376) $x691 $x888) ?x636 0))))
 (let ((?x684 (ite $x603 0 ?x600)))
 (let (($x862 (not $x376)))
 (let (($x861 (or $x856 $x396)))
 (let (($x863 (and $x861 $x862 $x691)))
 (let ((?x1053 (ite $x863 ?x685 (ite (and (or $x854 $x416) $x857 $x862 $x691 $x888) ?x636 0))))
 (let ((?x683 (ite $x585 0 ?x582)))
 (let (($x1057 (= v_1_rx_slot_12 (ite $x661 0 (ite $x831 ?x683 (ite $x860 ?x684 ?x1053))))))
 (let (($x864 (or $x854 $x416)))
 (let (($x865 (and $x864 $x857 $x862 $x691)))
 (let ((?x1045 (ite $x865 ?x685 (ite (and (or $x852 $x436) $x855 $x857 $x862 $x691 $x888) ?x636 0))))
 (let ((?x682 (ite $x567 0 ?x564)))
 (let (($x1050 (= v_1_rx_slot_11 (ite $x661 0 (ite $x831 ?x682 (ite $x860 ?x683 (ite $x863 ?x684 ?x1045)))))))
 (let (($x866 (or $x852 $x436)))
 (let (($x867 (and $x866 $x855 $x857 $x862 $x691)))
 (let ((?x1036 (ite $x867 ?x685 (ite (and (or $x850 $x456) $x853 $x855 $x857 $x862 $x691 $x888) ?x636 0))))
 (let ((?x681 (ite $x549 0 ?x546)))
 (let ((?x1041 (ite $x661 0 (ite $x831 ?x681 (ite $x860 ?x682 (ite $x863 ?x683 (ite $x865 ?x684 ?x1036)))))))
 (let ((?x1025 (ite (and (or $x848 $x476) $x851 $x853 $x855 $x857 $x862 $x691 $x888) ?x636 0)))
 (let (($x868 (or $x850 $x456)))
 (let (($x869 (and $x868 $x853 $x855 $x857 $x862 $x691)))
 (let ((?x1030 (ite $x860 ?x681 (ite $x863 ?x682 (ite $x865 ?x683 (ite $x867 ?x684 (ite $x869 ?x685 ?x1025)))))))
 (let ((?x680 (ite $x531 0 ?x528)))
 (let ((?x1014 (ite (and (or $x846 $x496) $x849 $x851 $x853 $x855 $x857 $x862 $x691 $x888) ?x636 0)))
 (let (($x870 (or $x848 $x476)))
 (let (($x871 (and $x870 $x851 $x853 $x855 $x857 $x862 $x691)))
 (let ((?x1019 (ite $x863 ?x681 (ite $x865 ?x682 (ite $x867 ?x683 (ite $x869 ?x684 (ite $x871 ?x685 ?x1014)))))))
 (let ((?x679 (ite $x513 0 ?x510)))
 (let (($x1023 (= v_1_rx_slot_08 (ite $x661 0 (ite $x831 ?x679 (ite $x860 ?x680 ?x1019))))))
 (let ((?x1002 (ite (and (or $x844 $x514) $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x691 $x888) ?x636 0)))
 (let (($x872 (or $x846 $x496)))
 (let (($x873 (and $x872 $x849 $x851 $x853 $x855 $x857 $x862 $x691)))
 (let ((?x1007 (ite $x865 ?x681 (ite $x867 ?x682 (ite $x869 ?x683 (ite $x871 ?x684 (ite $x873 ?x685 ?x1002)))))))
 (let ((?x678 (ite $x495 0 ?x492)))
 (let (($x1012 (= v_1_rx_slot_07 (ite $x661 0 (ite $x831 ?x678 (ite $x860 ?x679 (ite $x863 ?x680 ?x1007)))))))
 (let (($x876 (or $x842 $x532)))
 (let ((?x989 (ite (and $x876 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x691 $x888) ?x636 0)))
 (let (($x874 (or $x844 $x514)))
 (let (($x875 (and $x874 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x691)))
 (let ((?x994 (ite $x867 ?x681 (ite $x869 ?x682 (ite $x871 ?x683 (ite $x873 ?x684 (ite $x875 ?x685 ?x989)))))))
 (let ((?x677 (ite $x475 0 ?x472)))
 (let ((?x999 (ite $x661 0 (ite $x831 ?x677 (ite $x860 ?x678 (ite $x863 ?x679 (ite $x865 ?x680 ?x994)))))))
 (let (($x878 (or $x840 $x550)))
 (let ((?x975 (ite (and $x878 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x691 $x888) ?x636 0)))
 (let (($x877 (and $x876 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x691)))
 (let ((?x980 (ite $x869 ?x681 (ite $x871 ?x682 (ite $x873 ?x683 (ite $x875 ?x684 (ite $x877 ?x685 ?x975)))))))
 (let ((?x676 (ite $x455 0 ?x452)))
 (let ((?x985 (ite $x831 ?x676 (ite $x860 ?x677 (ite $x863 ?x678 (ite $x865 ?x679 (ite $x867 ?x680 ?x980)))))))
 (let (($x880 (or $x838 $x568)))
 (let (($x959 (and $x880 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x691 $x888)))
 (let (($x879 (and $x878 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x691)))
 (let ((?x964 (ite $x873 ?x682 (ite $x875 ?x683 (ite $x877 ?x684 (ite $x879 ?x685 (ite $x959 ?x636 0)))))))
 (let ((?x969 (ite $x863 ?x677 (ite $x865 ?x678 (ite $x867 ?x679 (ite $x869 ?x680 (ite $x871 ?x681 ?x964)))))))
 (let ((?x675 (ite $x435 0 ?x432)))
 (let (($x973 (= v_1_rx_slot_04 (ite $x661 0 (ite $x831 ?x675 (ite $x860 ?x676 ?x969))))))
 (let (($x882 (or $x836 $x586)))
 (let (($x943 (and $x882 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x691 $x888)))
 (let (($x881 (and $x880 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x691)))
 (let ((?x948 (ite $x875 ?x682 (ite $x877 ?x683 (ite $x879 ?x684 (ite $x881 ?x685 (ite $x943 ?x636 0)))))))
 (let ((?x953 (ite $x865 ?x677 (ite $x867 ?x678 (ite $x869 ?x679 (ite $x871 ?x680 (ite $x873 ?x681 ?x948)))))))
 (let ((?x674 (ite $x415 0 ?x412)))
 (let (($x958 (= v_1_rx_slot_03 (ite $x661 0 (ite $x831 ?x674 (ite $x860 ?x675 (ite $x863 ?x676 ?x953)))))))
 (let (($x884 (or $x834 $x604)))
 (let (($x926 (and $x884 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x691 $x888)))
 (let (($x883 (and $x882 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x691)))
 (let ((?x931 (ite $x877 ?x682 (ite $x879 ?x683 (ite $x881 ?x684 (ite $x883 ?x685 (ite $x926 ?x636 0)))))))
 (let ((?x936 (ite $x867 ?x677 (ite $x869 ?x678 (ite $x871 ?x679 (ite $x873 ?x680 (ite $x875 ?x681 ?x931)))))))
 (let ((?x673 (ite $x395 0 ?x392)))
 (let ((?x941 (ite $x661 0 (ite $x831 ?x673 (ite $x860 ?x674 (ite $x863 ?x675 (ite $x865 ?x676 ?x936)))))))
 (let (($x886 (or $x832 $x622)))
 (let (($x908 (and $x886 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x691 $x888)))
 (let (($x885 (and $x884 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x691)))
 (let ((?x913 (ite $x879 ?x682 (ite $x881 ?x683 (ite $x883 ?x684 (ite $x885 ?x685 (ite $x908 ?x636 0)))))))
 (let ((?x918 (ite $x869 ?x677 (ite $x871 ?x678 (ite $x873 ?x679 (ite $x875 ?x680 (ite $x877 ?x681 ?x913)))))))
 (let ((?x672 (ite $x375 0 ?x372)))
 (let ((?x923 (ite $x831 ?x672 (ite $x860 ?x673 (ite $x863 ?x674 (ite $x865 ?x675 (ite $x867 ?x676 ?x918)))))))
 (let (($x889 (and $x640 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x691 $x888)))
 (let (($x887 (and $x886 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x862 $x691)))
 (let ((?x894 (ite $x881 ?x682 (ite $x883 ?x683 (ite $x885 ?x684 (ite $x887 ?x685 (ite $x889 ?x636 0)))))))
 (let ((?x899 (ite $x871 ?x677 (ite $x873 ?x678 (ite $x875 ?x679 (ite $x877 ?x680 (ite $x879 ?x681 ?x894)))))))
 (let ((?x904 (ite $x860 ?x672 (ite $x863 ?x673 (ite $x865 ?x674 (ite $x867 ?x675 (ite $x869 ?x676 ?x899)))))))
 (let ((?x671 (ite $x356 0 ?x353)))
 (let ((?x693 (ite (and (<= 0 ?x656) $x691) ?x655 0)))
 (let ((?x687 (+ ?x671 ?x672 ?x673 ?x674 ?x675 ?x676 ?x677 ?x678 ?x679 ?x680 ?x681 ?x682 ?x683 ?x684 ?x685 (ite $x639 0 ?x636))))
 (let ((?x689 (ite (<= ?x687 0) 0 ?x687)))
 (let ((?x695 (ite (<= ?x689 ?x693) ?x689 ?x693)))
 (let (($x829 (= v_1_take v_0_take)))
 (let (($x789 (= v_1_snd_buf v_0_snd_buf)))
 (let (($x783 (= v_1_msl_ms v_0_msl_ms)))
 (let (($x780 (= v_1_user_timeout_ms v_0_user_timeout_ms)))
 (let (($x777 (= v_1_active_open v_0_active_open)))
 (let (($x774 (= v_1_retries v_0_retries)))
 (let (($x704 (= v_1_tx_flags v_0_tx_flags)))
 (let (($x701 (= v_1_tx_ack v_0_tx_ack)))
 (let (($x700 (= v_1_tx_seq v_0_tx_seq)))
 (let (($x699 (= v_1_rcv_nxt (mod (+ v_0_rcv_nxt ?x695 (ite $x661 1 0)) 4294967296))))
 (let (($x670 (= v_1_snd_nxt v_0_snd_nxt)))
 (let (($x666 (= v_1_irs v_0_irs)))
 (let (($x665 (= v_1_iss v_0_iss)))
 (let (($x662 (not $x661)))
 (let (($x309 (= 0 ?x281)))
 (let (($x287 (= (mod (+ input_0_net.fin_segment_ack (* ?x268 v_0_snd_nxt)) 4294967296) 2147483648)))
 (and (>= now_1 now_0) (<= 0 input_0_net.fin_segment_data) (>= 16 input_0_net.fin_segment_data) (not (= ?x271 2147483648)) (<= 0 input_0_net.fin_segment_window) (>= 65535 input_0_net.fin_segment_window) (or (and (not (= ?x281 2147483648)) (not $x287)) (not $x302)) v_0_fin_sent (not (= ?x281 (+ 1 v_0_rtx_buf))) $x309 (or (not active_0_rtx) (not (<= due_0_rtx now_1))) (or (not active_0_user) (not (<= due_0_user now_1))) (or (not active_0_time_wait) (not (<= due_0_time_wait now_1))) $x325 $x662 $x664 $x665 $x666 (= v_1_snd_una (ite $x667 input_0_net.fin_segment_ack v_0_snd_una)) $x670 $x699 $x700 $x701 $x704 (= v_1_rto_ms ?x770) $x774 $x777 $x780 $x783 (= v_1_local_window (+ 16 (* ?x268 v_0_rcv_buf) (* ?x268 ?x695))) $x789 (= v_1_rtx_buf ?x798) (= v_1_rcv_buf (+ v_0_rcv_buf ?x695)) (= v_1_snd_wnd (ite $x819 input_0_net.fin_segment_window v_0_snd_wnd)) (= v_1_snd_wl1 (ite $x819 input_0_net.fin_segment_seq v_0_snd_wl1)) (= v_1_snd_wl2 (ite $x819 input_0_net.fin_segment_ack v_0_snd_wl2)) $x829 (= v_1_rx_chunk ?x695) (= v_1_rx_slot_00 (ite $x661 0 (ite $x831 ?x671 ?x904))) (= v_1_rx_slot_01 (ite $x661 0 ?x923)) (= v_1_rx_slot_02 ?x941) $x958 $x973 (= v_1_rx_slot_05 (ite $x661 0 ?x985)) (= v_1_rx_slot_06 ?x999) $x1012 $x1023 (= v_1_rx_slot_09 (ite $x661 0 (ite $x831 ?x680 ?x1030))) (= v_1_rx_slot_10 ?x1041) $x1050 $x1057 (= v_1_rx_slot_13 (ite $x661 0 (ite $x831 ?x684 ?x1060))) $x1068 (= v_1_rx_slot_15 ?x1072) (= v_1_rx_advance ?x656) (= v_1_rx_acceptable (and $x302 $x332 $x334)) (= v_1_seg_acceptable $x302) (= v_1_ack_delta ?x281) (= v_1_ack_is_new (and $x319 $x322)) (= v_1_ack_is_future $x331) (= v_1_ack_advance $x667) (= v_1_ack_window_update $x819) $x1094 (= v_1_fin_sent $x1096) $x1098 (= v_1_fin_acknowledged $x324) (= v_1_rx_fin_pending (and $x337 $x662)) (= v_1_rx_fin_seq (ite $x336 ?x1105 v_0_rx_fin_seq)) (= v_1_rx_fin_offset (ite $x661 0 ?x659)) (= v_1_rx_fin_done (or v_0_rx_fin_done $x661)) (= v_1_rx_fin_consumed $x661) (= v_1_srtt_ms ?x732) (= v_1_rttvar_ms ?x755) (= v_1_rtt_error_ms ?x748) $x1125 $x1129 (= v_1_rtt_measured (or v_0_rtt_measured $x712)) $x1136 (= v_1_rtt_active (and v_0_rtt_active (not $x1138))) (= v_1_rtt_ambiguous (and (not $x1138) v_0_rtt_ambiguous)) (= v_1_rtt_sample_at_ms (ite $x712 now_1 v_0_rtt_sample_at_ms)) $x1150 $x1151 $x1160 $x1162 (= v_1_rtt_sample_used $x712) $x1167 (= v_1_rtt_last_ms ?x727) (= v_1_rtt_samples (+ v_0_rtt_samples (ite $x712 1 0))) (= v_1_rto_base_ms (ite $x712 ?x768 v_0_rto_base_ms)) $x1233 (= v_1_tx_time_01 (ite (or (>= 1 ?x798) $x1180) 0 ?x1251)) (= v_1_tx_time_02 ?x1271) $x1290 (= v_1_tx_time_04 (ite (or (>= 4 ?x798) $x1180) 0 ?x1305)) (= v_1_tx_time_05 ?x1322) $x1338 (= v_1_tx_time_07 (ite (or (>= 7 ?x798) $x1180) 0 ?x1350)) (= v_1_tx_time_08 ?x1364) $x1377 (= v_1_tx_time_10 (ite (or $x1180 (>= 10 ?x798)) 0 ?x1386)) (= v_1_tx_time_11 ?x1397) $x1407 (= v_1_tx_time_13 (ite (or $x1180 (>= 13 ?x798)) 0 ?x1413)) (= v_1_tx_time_14 ?x1421) $x1427 (= v_1_tx_fin_time (ite $x1096 v_0_tx_fin_time 0)) $x1434 $x1437 $x1440 $x1442 $x1445 $x1448 $x1451 $x1453 (= active_1_rtx (and $x664 $x1463)) (= active_1_user (and $x664 active_0_user)) (= active_1_time_wait (or $x663 active_0_time_wait)) (= due_1_rtx (ite $x1462 (+ now_1 ?x770) due_0_rtx)) $x1477 (= due_1_time_wait (ite $x663 ?x1480 due_0_time_wait)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
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
 (let ((?x1488 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1488)))
(assert
 (>= 16 v_0_rcv_buf))
(assert
 (and (<= 0 v_0_snd_wnd) (>= 65535 v_0_snd_wnd)))
(assert
 (= v_0_local_window (+ 16 (* (- 1) v_0_rcv_buf))))
(assert
 (>= 1 v_0_rx_slot_00))
(assert
 (let (($x340 (= 0 v_0_rx_slot_00)))
 (let (($x1498 (not (>= v_0_rcv_buf 16))))
 (or $x1498 $x340))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x358 (= 0 v_0_rx_slot_01)))
 (let (($x1502 (not (>= v_0_rcv_buf 15))))
 (or $x1502 $x358))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x377 (= 0 v_0_rx_slot_02)))
 (let (($x1506 (not (>= v_0_rcv_buf 14))))
 (or $x1506 $x377))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x397 (= 0 v_0_rx_slot_03)))
 (let (($x1510 (not (>= v_0_rcv_buf 13))))
 (or $x1510 $x397))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x417 (= 0 v_0_rx_slot_04)))
 (let (($x1514 (not (>= v_0_rcv_buf 12))))
 (or $x1514 $x417))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x437 (= 0 v_0_rx_slot_05)))
 (let (($x1518 (not (>= v_0_rcv_buf 11))))
 (or $x1518 $x437))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x457 (= 0 v_0_rx_slot_06)))
 (let (($x1522 (not (>= v_0_rcv_buf 10))))
 (or $x1522 $x457))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x477 (= 0 v_0_rx_slot_07)))
 (let (($x1526 (not (>= v_0_rcv_buf 9))))
 (or $x1526 $x477))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x497 (= 0 v_0_rx_slot_08)))
 (let (($x1530 (not (>= v_0_rcv_buf 8))))
 (or $x1530 $x497))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x515 (= 0 v_0_rx_slot_09)))
 (let (($x1534 (not (>= v_0_rcv_buf 7))))
 (or $x1534 $x515))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x533 (= 0 v_0_rx_slot_10)))
 (let (($x1538 (not (>= v_0_rcv_buf 6))))
 (or $x1538 $x533))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x551 (= 0 v_0_rx_slot_11)))
 (let (($x1542 (not (>= v_0_rcv_buf 5))))
 (or $x1542 $x551))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x569 (= 0 v_0_rx_slot_12)))
 (let (($x1546 (not (>= v_0_rcv_buf 4))))
 (or $x1546 $x569))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x587 (= 0 v_0_rx_slot_13)))
 (let (($x1550 (not (>= v_0_rcv_buf 3))))
 (or $x1550 $x587))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x605 (= 0 v_0_rx_slot_14)))
 (let (($x1554 (not (>= v_0_rcv_buf 2))))
 (or $x1554 $x605))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x623 (= 0 v_0_rx_slot_15)))
 (let (($x1558 (not (>= v_0_rcv_buf 1))))
 (or $x1558 $x623))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x1560 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x1560)))
(assert
 (and (<= 0 v_0_rx_advance) (>= 16 v_0_rx_advance)))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (and (<= 0 v_0_ack_delta) (>= 4294967295 v_0_ack_delta)))
(assert
 true)
(assert
 (let ((?x1573 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x1573)))
(assert
 (= active_0_rtx (<= 1 (+ v_0_rtx_buf (ite v_0_fin_sent 1 0)))))
(assert
 (let (($x1582 (and v_0_fin_requested (= v_0_fin_seq (mod (+ v_0_snd_una v_0_rtx_buf) 4294967296)) (= 0 v_0_snd_buf))))
 (let (($x1577 (not v_0_fin_sent)))
 (or $x1577 $x1582))))
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
 (let (($x1584 (<= 1 v_0_rx_fin_offset)))
 (let (($x334 (not v_0_rx_fin_done)))
 (let (($x1586 (and $x334 $x1584 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window)))))
 (let (($x335 (not v_0_rx_fin_pending)))
 (or $x335 $x1586))))))
(assert
 (let (($x1589 (>= 15 v_0_rx_fin_offset)))
 (and (<= 0 v_0_rx_fin_offset) $x1589 (= v_0_rx_fin_pending (<= 1 v_0_rx_fin_offset)))))
(assert
 (let (($x335 (not v_0_rx_fin_pending)))
 (or $x335 (= v_0_rx_fin_seq (mod (+ v_0_rcv_nxt v_0_rx_fin_offset) 4294967296)))))
(assert
 (let (($x334 (not v_0_rx_fin_done)))
 (or $x334 (= v_0_rcv_nxt (mod (+ 1 v_0_rx_fin_seq) 4294967296)))))
(assert
 (let (($x340 (= 0 v_0_rx_slot_00)))
 (or (not (and v_0_rx_fin_pending (>= 0 v_0_rx_fin_offset))) $x340)))
(assert
 (let (($x358 (= 0 v_0_rx_slot_01)))
 (or (not (and v_0_rx_fin_pending (>= 1 v_0_rx_fin_offset))) $x358)))
(assert
 (let (($x377 (= 0 v_0_rx_slot_02)))
 (or (not (and v_0_rx_fin_pending (>= 2 v_0_rx_fin_offset))) $x377)))
(assert
 (let (($x397 (= 0 v_0_rx_slot_03)))
 (or (not (and v_0_rx_fin_pending (>= 3 v_0_rx_fin_offset))) $x397)))
(assert
 (let (($x417 (= 0 v_0_rx_slot_04)))
 (or (not (and v_0_rx_fin_pending (>= 4 v_0_rx_fin_offset))) $x417)))
(assert
 (let (($x437 (= 0 v_0_rx_slot_05)))
 (or (not (and v_0_rx_fin_pending (>= 5 v_0_rx_fin_offset))) $x437)))
(assert
 (let (($x457 (= 0 v_0_rx_slot_06)))
 (or (not (and v_0_rx_fin_pending (>= 6 v_0_rx_fin_offset))) $x457)))
(assert
 (let (($x477 (= 0 v_0_rx_slot_07)))
 (or (not (and v_0_rx_fin_pending (>= 7 v_0_rx_fin_offset))) $x477)))
(assert
 (let (($x497 (= 0 v_0_rx_slot_08)))
 (or (not (and v_0_rx_fin_pending (>= 8 v_0_rx_fin_offset))) $x497)))
(assert
 (let (($x515 (= 0 v_0_rx_slot_09)))
 (or (not (and v_0_rx_fin_pending (>= 9 v_0_rx_fin_offset))) $x515)))
(assert
 (let (($x533 (= 0 v_0_rx_slot_10)))
 (or (not (and v_0_rx_fin_pending (>= 10 v_0_rx_fin_offset))) $x533)))
(assert
 (let (($x551 (= 0 v_0_rx_slot_11)))
 (or (not (and v_0_rx_fin_pending (>= 11 v_0_rx_fin_offset))) $x551)))
(assert
 (let (($x569 (= 0 v_0_rx_slot_12)))
 (or (not (and v_0_rx_fin_pending (>= 12 v_0_rx_fin_offset))) $x569)))
(assert
 (let (($x587 (= 0 v_0_rx_slot_13)))
 (or (not (and v_0_rx_fin_pending (>= 13 v_0_rx_fin_offset))) $x587)))
(assert
 (let (($x605 (= 0 v_0_rx_slot_14)))
 (or (not (and v_0_rx_fin_pending (>= 14 v_0_rx_fin_offset))) $x605)))
(assert
 (let (($x623 (= 0 v_0_rx_slot_15)))
 (or (not (and v_0_rx_fin_pending (>= 15 v_0_rx_fin_offset))) $x623)))
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
 (let ((?x1677 (* 4.0 v_0_rttvar_ms)))
 (let ((?x715 (- 1.0)))
 (let ((?x744 (* ?x715 v_0_srtt_ms)))
 (let ((?x1680 (+ ?x744 (* ?x715 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x1677)))))
 (let ((?x1681 (to_int ?x1680)))
 (let ((?x268 (- 1)))
 (let ((?x1684 (ite (<= ?x1681 (- 1000)) (* ?x268 ?x1681) 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x1684) 60000 ?x1684) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x708 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x1699 (and (<= v_0_rtt_start_ms now_0) (<= 1 v_0_rtt_remaining) (>= 4 v_0_rtt_remaining) (>= ?x708 v_0_rtt_remaining) (<= ?x708 (mod (+ v_0_snd_nxt (* (- 1) v_0_snd_una)) 4294967296)))))
 (let (($x1691 (not v_0_rtt_active)))
 (or $x1691 $x1699)))))
(assert
 (or v_0_rtt_active (= 0 v_0_rtt_remaining)))
(assert
 true)
(assert
 (let (($x1708 (= v_0_rtt_last_ms (+ v_0_rtt_sample_at_ms (* (- 1) v_0_rtt_start_ms)))))
 (let (($x1706 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1704 (not v_0_rtt_sample_used)))
 (or $x1704 (and $x1706 v_0_rtt_measured $x1708))))))
(assert
 (and (<= 0 v_0_rtt_sample_at_ms) (<= v_0_rtt_sample_at_ms now_0)))
(assert
 (let ((?x1715 (to_real v_0_rtt_last_ms)))
 (let ((?x1729 (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x1715))))
 (let ((?x1717 (+ v_0_rtt_previous_srtt (* (- 1.0) ?x1715))))
 (let ((?x1721 (ite (>= ?x1717 0.0) ?x1717 (+ (* (- 1.0) v_0_rtt_previous_srtt) ?x1715))))
 (let ((?x739 (/ 1.0 4.0)))
 (let ((?x1725 (ite v_0_rtt_previous_measured (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* ?x739 ?x1721)) (* (/ 1.0 2.0) ?x1715))))
 (let (($x1732 (and (= v_0_rttvar_ms ?x1725) (= v_0_srtt_ms (ite v_0_rtt_previous_measured ?x1729 ?x1715)))))
 (let (($x1704 (not v_0_rtt_sample_used)))
 (or $x1704 $x1732))))))))))
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
 (let (($x1868 (and (>= v_0_tx_elapsed v_0_tx_previous_rto) (<= 1 v_0_tx_emit_count) (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x1862 (not v_0_tx_retransmitted)))
 (or $x1862 $x1868))))
(assert
 (let (($x1862 (not v_0_tx_retransmitted)))
 (or $x1862 (not v_0_tx_waiting))))
(assert
 (= 177 choice_0))
(assert
 (= 5 state_0))
(assert
 (= 5 state_1))
(assert
 (let ((?x1886 (mod (+ v_1_rtt_end (* (- 1) v_1_snd_una)) 4294967296)))
(let (($x1891 (and (<= v_1_rtt_start_ms now_1) (<= 1 v_1_rtt_remaining) (>= 4 v_1_rtt_remaining) (>= ?x1886 v_1_rtt_remaining) (<= ?x1886 (mod (+ v_1_snd_nxt (* (- 1) v_1_snd_una)) 4294967296)))))
(or (not (or (not v_1_rtt_active) $x1891))))))
(check-sat)
