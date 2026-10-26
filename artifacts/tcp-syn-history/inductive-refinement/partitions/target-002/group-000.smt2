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
 (let ((?x1481 (+ now_1 (* 2 v_0_msl_ms))))
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
 (let (($x357 (or (= ?x353 0) $x356)))
 (let ((?x656 (ite $x357 0 ?x655)))
 (let ((?x659 (ite $x337 (+ ?x339 (* ?x268 ?x656)) ?x339)))
 (let (($x660 (= 0 ?x659)))
 (let (($x663 (and $x337 $x334 $x660 $x302 $x319 $x322 v_0_fin_sent $x323)))
 (let (($x1478 (= due_1_user due_0_user)))
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
 (let (($x1095 (and $x325 v_0_fin_sent)))
 (let ((?x795 (ite (<= 0 v_0_rtx_buf) v_0_rtx_buf 0)))
 (let ((?x793 (ite (<= v_0_rtx_buf ?x281) 0 (+ v_0_rtx_buf (* ?x268 ?x281)))))
 (let (($x667 (and $x302 $x319 $x322)))
 (let ((?x798 (ite $x667 (ite (<= ?x793 ?x795) ?x793 ?x795) v_0_rtx_buf)))
 (let ((?x1457 (+ ?x798 (ite $x1095 1 0))))
 (let (($x1459 (and $x302 $x319 $x322 (<= 1 ?x1457))))
 (let (($x1464 (or $x1459 (and (not (and $x302 $x319 $x322 (= 0 ?x1457))) active_0_rtx))))
 (let (($x664 (not $x663)))
 (let (($x1454 (not v_1_syn_timeout_eligible)))
 (let (($x1452 (not v_1_tx_syn_pending)))
 (let (($x1450 (= v_1_tx_syn_time 0)))
 (let (($x1448 (not v_1_tx_waiting)))
 (let (($x1446 (= v_1_tx_is_fin v_0_tx_is_fin)))
 (let (($x1443 (= v_1_tx_previous_rto v_0_tx_previous_rto)))
 (let (($x1440 (= v_1_tx_elapsed v_0_tx_elapsed)))
 (let (($x1437 (not v_1_tx_retransmitted)))
 (let (($x1435 (= v_1_tx_max_previous v_0_tx_max_previous)))
 (let (($x1432 (= v_1_tx_eligible v_0_tx_eligible)))
 (let (($x1429 (= v_1_tx_emit_count v_0_tx_emit_count)))
 (let (($x1176 (= 0 ?x798)))
 (let (($x1179 (and $x302 $x319 $x322 (not (= 0 ?x281)))))
 (let (($x1422 (= v_1_tx_time_15 (ite (or (>= 15 ?x798) $x1179 $x1176) 0 v_0_tx_time_15))))
 (let ((?x1416 (ite (or (>= 14 ?x798) $x1176) 0 (ite $x1179 (ite (= 1 ?x281) v_0_tx_time_15 0) v_0_tx_time_14))))
 (let (($x1180 (= 1 ?x281)))
 (let ((?x1408 (ite $x1179 (ite $x1180 v_0_tx_time_14 (ite (= 2 ?x281) v_0_tx_time_15 0)) v_0_tx_time_13)))
 (let (($x1182 (= 2 ?x281)))
 (let ((?x1399 (ite $x1180 v_0_tx_time_13 (ite $x1182 v_0_tx_time_14 (ite (= 3 ?x281) v_0_tx_time_15 0)))))
 (let (($x1402 (= v_1_tx_time_12 (ite (or (>= 12 ?x798) $x1176) 0 (ite $x1179 ?x1399 v_0_tx_time_12)))))
 (let (($x1184 (= 3 ?x281)))
 (let ((?x1389 (ite $x1182 v_0_tx_time_13 (ite $x1184 v_0_tx_time_14 (ite (= 4 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1392 (ite (or (>= 11 ?x798) $x1176) 0 (ite $x1179 (ite $x1180 v_0_tx_time_12 ?x1389) v_0_tx_time_11))))
 (let (($x1186 (= 4 ?x281)))
 (let ((?x1378 (ite $x1184 v_0_tx_time_13 (ite $x1186 v_0_tx_time_14 (ite (= 5 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1381 (ite $x1179 (ite $x1180 v_0_tx_time_11 (ite $x1182 v_0_tx_time_12 ?x1378)) v_0_tx_time_10)))
 (let (($x1188 (= 5 ?x281)))
 (let ((?x1366 (ite $x1186 v_0_tx_time_13 (ite $x1188 v_0_tx_time_14 (ite (= 6 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1369 (ite $x1180 v_0_tx_time_10 (ite $x1182 v_0_tx_time_11 (ite $x1184 v_0_tx_time_12 ?x1366)))))
 (let (($x1372 (= v_1_tx_time_09 (ite (or (>= 9 ?x798) $x1176) 0 (ite $x1179 ?x1369 v_0_tx_time_09)))))
 (let (($x1190 (= 6 ?x281)))
 (let ((?x1353 (ite $x1188 v_0_tx_time_13 (ite $x1190 v_0_tx_time_14 (ite (= 7 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1356 (ite $x1182 v_0_tx_time_10 (ite $x1184 v_0_tx_time_11 (ite $x1186 v_0_tx_time_12 ?x1353)))))
 (let ((?x1359 (ite (or (>= 8 ?x798) $x1176) 0 (ite $x1179 (ite $x1180 v_0_tx_time_09 ?x1356) v_0_tx_time_08))))
 (let (($x1192 (= 7 ?x281)))
 (let ((?x1339 (ite $x1190 v_0_tx_time_13 (ite $x1192 v_0_tx_time_14 (ite (= 8 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1342 (ite $x1184 v_0_tx_time_10 (ite $x1186 v_0_tx_time_11 (ite $x1188 v_0_tx_time_12 ?x1339)))))
 (let ((?x1345 (ite $x1179 (ite $x1180 v_0_tx_time_08 (ite $x1182 v_0_tx_time_09 ?x1342)) v_0_tx_time_07)))
 (let (($x1194 (= 8 ?x281)))
 (let ((?x1324 (ite $x1192 v_0_tx_time_13 (ite $x1194 v_0_tx_time_14 (ite (= 9 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1327 (ite $x1186 v_0_tx_time_10 (ite $x1188 v_0_tx_time_11 (ite $x1190 v_0_tx_time_12 ?x1324)))))
 (let ((?x1330 (ite $x1180 v_0_tx_time_07 (ite $x1182 v_0_tx_time_08 (ite $x1184 v_0_tx_time_09 ?x1327)))))
 (let (($x1333 (= v_1_tx_time_06 (ite (or (>= 6 ?x798) $x1176) 0 (ite $x1179 ?x1330 v_0_tx_time_06)))))
 (let (($x1196 (= 9 ?x281)))
 (let ((?x1308 (ite $x1194 v_0_tx_time_13 (ite $x1196 v_0_tx_time_14 (ite (= 10 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1311 (ite $x1188 v_0_tx_time_10 (ite $x1190 v_0_tx_time_11 (ite $x1192 v_0_tx_time_12 ?x1308)))))
 (let ((?x1314 (ite $x1182 v_0_tx_time_07 (ite $x1184 v_0_tx_time_08 (ite $x1186 v_0_tx_time_09 ?x1311)))))
 (let ((?x1317 (ite (or (>= 5 ?x798) $x1176) 0 (ite $x1179 (ite $x1180 v_0_tx_time_06 ?x1314) v_0_tx_time_05))))
 (let (($x1198 (= 10 ?x281)))
 (let ((?x1291 (ite $x1196 v_0_tx_time_13 (ite $x1198 v_0_tx_time_14 (ite (= 11 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1294 (ite $x1190 v_0_tx_time_10 (ite $x1192 v_0_tx_time_11 (ite $x1194 v_0_tx_time_12 ?x1291)))))
 (let ((?x1297 (ite $x1184 v_0_tx_time_07 (ite $x1186 v_0_tx_time_08 (ite $x1188 v_0_tx_time_09 ?x1294)))))
 (let ((?x1300 (ite $x1179 (ite $x1180 v_0_tx_time_05 (ite $x1182 v_0_tx_time_06 ?x1297)) v_0_tx_time_04)))
 (let (($x1200 (= 11 ?x281)))
 (let ((?x1273 (ite $x1198 v_0_tx_time_13 (ite $x1200 v_0_tx_time_14 (ite (= 12 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1276 (ite $x1192 v_0_tx_time_10 (ite $x1194 v_0_tx_time_11 (ite $x1196 v_0_tx_time_12 ?x1273)))))
 (let ((?x1279 (ite $x1186 v_0_tx_time_07 (ite $x1188 v_0_tx_time_08 (ite $x1190 v_0_tx_time_09 ?x1276)))))
 (let ((?x1282 (ite $x1180 v_0_tx_time_04 (ite $x1182 v_0_tx_time_05 (ite $x1184 v_0_tx_time_06 ?x1279)))))
 (let (($x1285 (= v_1_tx_time_03 (ite (or $x1176 (>= 3 ?x798)) 0 (ite $x1179 ?x1282 v_0_tx_time_03)))))
 (let (($x1202 (= 12 ?x281)))
 (let ((?x1254 (ite $x1200 v_0_tx_time_13 (ite $x1202 v_0_tx_time_14 (ite (= 13 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1257 (ite $x1194 v_0_tx_time_10 (ite $x1196 v_0_tx_time_11 (ite $x1198 v_0_tx_time_12 ?x1254)))))
 (let ((?x1260 (ite $x1188 v_0_tx_time_07 (ite $x1190 v_0_tx_time_08 (ite $x1192 v_0_tx_time_09 ?x1257)))))
 (let ((?x1263 (ite $x1182 v_0_tx_time_04 (ite $x1184 v_0_tx_time_05 (ite $x1186 v_0_tx_time_06 ?x1260)))))
 (let ((?x1266 (ite (or (>= 2 ?x798) $x1176) 0 (ite $x1179 (ite $x1180 v_0_tx_time_03 ?x1263) v_0_tx_time_02))))
 (let (($x1204 (= 13 ?x281)))
 (let ((?x1234 (ite $x1202 v_0_tx_time_13 (ite $x1204 v_0_tx_time_14 (ite (= 14 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1237 (ite $x1196 v_0_tx_time_10 (ite $x1198 v_0_tx_time_11 (ite $x1200 v_0_tx_time_12 ?x1234)))))
 (let ((?x1240 (ite $x1190 v_0_tx_time_07 (ite $x1192 v_0_tx_time_08 (ite $x1194 v_0_tx_time_09 ?x1237)))))
 (let ((?x1243 (ite $x1184 v_0_tx_time_04 (ite $x1186 v_0_tx_time_05 (ite $x1188 v_0_tx_time_06 ?x1240)))))
 (let ((?x1246 (ite $x1179 (ite $x1180 v_0_tx_time_02 (ite $x1182 v_0_tx_time_03 ?x1243)) v_0_tx_time_01)))
 (let (($x1206 (= 14 ?x281)))
 (let ((?x1212 (ite $x1204 v_0_tx_time_13 (ite $x1206 v_0_tx_time_14 (ite (= 15 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1215 (ite $x1198 v_0_tx_time_10 (ite $x1200 v_0_tx_time_11 (ite $x1202 v_0_tx_time_12 ?x1212)))))
 (let ((?x1218 (ite $x1192 v_0_tx_time_07 (ite $x1194 v_0_tx_time_08 (ite $x1196 v_0_tx_time_09 ?x1215)))))
 (let ((?x1221 (ite $x1186 v_0_tx_time_04 (ite $x1188 v_0_tx_time_05 (ite $x1190 v_0_tx_time_06 ?x1218)))))
 (let ((?x1224 (ite $x1180 v_0_tx_time_01 (ite $x1182 v_0_tx_time_02 (ite $x1184 v_0_tx_time_03 ?x1221)))))
 (let (($x1228 (= v_1_tx_time_00 (ite (or (>= 0 ?x798) $x1176) 0 (ite $x1179 ?x1224 v_0_tx_time_00)))))
 (let (($x1162 (= v_1_rtt_sample_was_ambiguous (and v_0_rtt_active v_0_rtt_ambiguous))))
 (let (($x1157 (not v_1_rtt_start_new)))
 (let ((?x791 (* ?x268 ?x281)))
 (let ((?x1149 (+ ?x708 ?x791)))
 (let (($x1152 (and v_0_rtt_active $x302 $x319 $x322 (not (<= v_0_rtt_remaining ?x1149)))))
 (let (($x1137 (and v_0_rtt_active $x302 $x319 $x322 $x709)))
 (let (($x1155 (= v_1_rtt_remaining (ite $x1137 0 (ite $x1152 ?x1149 v_0_rtt_remaining)))))
 (let (($x1146 (= v_1_rtt_end v_0_rtt_end)))
 (let (($x1145 (= v_1_rtt_start_ms v_0_rtt_start_ms)))
 (let (($x1135 (= v_1_rtt_previous_measured (ite $x712 v_0_rtt_measured v_0_rtt_previous_measured))))
 (let (($x1128 (= v_1_rtt_previous_var (ite $x712 v_0_rttvar_ms v_0_rtt_previous_var))))
 (let (($x1124 (= v_1_rtt_previous_srtt (ite $x712 v_0_srtt_ms v_0_rtt_previous_srtt))))
 (let ((?x1104 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data) 4294967296)))
 (let (($x1097 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x1093 (= v_1_fin_requested v_0_fin_requested)))
 (let ((?x812 (mod (+ input_0_net.fin_segment_seq (* ?x268 v_0_snd_wl1)) 4294967296)))
 (let (($x807 (<= 2147483648 (mod (+ input_0_net.fin_segment_ack (* ?x268 v_0_snd_wl2)) 4294967296))))
 (let (($x803 (= v_0_snd_wl1 input_0_net.fin_segment_seq)))
 (let (($x818 (or (and $x803 (not $x807)) (and (not (<= ?x812 0)) (not (<= 2147483648 ?x812))))))
 (let (($x819 (and $x302 $x322 $x818)))
 (let ((?x1071 (ite (or (not (and $x357 (not $x639))) (and $x337 $x334 $x660)) 0 ?x636)))
 (let (($x887 (not $x639)))
 (let (($x691 (not $x357)))
 (let (($x856 (not $x396)))
 (let (($x854 (not $x416)))
 (let (($x852 (not $x436)))
 (let (($x850 (not $x456)))
 (let (($x848 (not $x476)))
 (let (($x846 (not $x496)))
 (let (($x844 (not $x514)))
 (let (($x842 (not $x532)))
 (let (($x840 (not $x550)))
 (let (($x838 (not $x568)))
 (let (($x836 (not $x586)))
 (let (($x834 (not $x604)))
 (let (($x832 (not $x622)))
 (let (($x831 (and false $x640)))
 (let (($x833 (and $x831 $x832)))
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
 (let (($x858 (or $x373 $x375 (and $x855 $x856))))
 (let ((?x685 (ite $x621 0 ?x618)))
 (let (($x661 (and $x337 $x334 $x660)))
 (let (($x1067 (= v_1_rx_slot_14 (ite $x661 0 (ite $x357 ?x685 (ite (and $x858 $x691 $x887) ?x636 0))))))
 (let (($x859 (and $x858 $x691)))
 (let ((?x1059 (ite $x859 ?x685 (ite (and (or $x855 $x396) (not $x376) $x691 $x887) ?x636 0))))
 (let ((?x684 (ite $x603 0 ?x600)))
 (let (($x861 (not $x376)))
 (let (($x860 (or $x855 $x396)))
 (let (($x862 (and $x860 $x861 $x691)))
 (let ((?x1052 (ite $x862 ?x685 (ite (and (or $x853 $x416) $x856 $x861 $x691 $x887) ?x636 0))))
 (let ((?x683 (ite $x585 0 ?x582)))
 (let (($x1056 (= v_1_rx_slot_12 (ite $x661 0 (ite $x357 ?x683 (ite $x859 ?x684 ?x1052))))))
 (let (($x863 (or $x853 $x416)))
 (let (($x864 (and $x863 $x856 $x861 $x691)))
 (let ((?x1044 (ite $x864 ?x685 (ite (and (or $x851 $x436) $x854 $x856 $x861 $x691 $x887) ?x636 0))))
 (let ((?x682 (ite $x567 0 ?x564)))
 (let (($x1049 (= v_1_rx_slot_11 (ite $x661 0 (ite $x357 ?x682 (ite $x859 ?x683 (ite $x862 ?x684 ?x1044)))))))
 (let (($x865 (or $x851 $x436)))
 (let (($x866 (and $x865 $x854 $x856 $x861 $x691)))
 (let ((?x1035 (ite $x866 ?x685 (ite (and (or $x849 $x456) $x852 $x854 $x856 $x861 $x691 $x887) ?x636 0))))
 (let ((?x681 (ite $x549 0 ?x546)))
 (let ((?x1040 (ite $x661 0 (ite $x357 ?x681 (ite $x859 ?x682 (ite $x862 ?x683 (ite $x864 ?x684 ?x1035)))))))
 (let ((?x1024 (ite (and (or $x847 $x476) $x850 $x852 $x854 $x856 $x861 $x691 $x887) ?x636 0)))
 (let (($x867 (or $x849 $x456)))
 (let (($x868 (and $x867 $x852 $x854 $x856 $x861 $x691)))
 (let ((?x1029 (ite $x859 ?x681 (ite $x862 ?x682 (ite $x864 ?x683 (ite $x866 ?x684 (ite $x868 ?x685 ?x1024)))))))
 (let ((?x680 (ite $x531 0 ?x528)))
 (let ((?x1013 (ite (and (or $x845 $x496) $x848 $x850 $x852 $x854 $x856 $x861 $x691 $x887) ?x636 0)))
 (let (($x869 (or $x847 $x476)))
 (let (($x870 (and $x869 $x850 $x852 $x854 $x856 $x861 $x691)))
 (let ((?x1018 (ite $x862 ?x681 (ite $x864 ?x682 (ite $x866 ?x683 (ite $x868 ?x684 (ite $x870 ?x685 ?x1013)))))))
 (let ((?x679 (ite $x513 0 ?x510)))
 (let (($x1022 (= v_1_rx_slot_08 (ite $x661 0 (ite $x357 ?x679 (ite $x859 ?x680 ?x1018))))))
 (let ((?x1001 (ite (and (or $x843 $x514) $x846 $x848 $x850 $x852 $x854 $x856 $x861 $x691 $x887) ?x636 0)))
 (let (($x871 (or $x845 $x496)))
 (let (($x872 (and $x871 $x848 $x850 $x852 $x854 $x856 $x861 $x691)))
 (let ((?x1006 (ite $x864 ?x681 (ite $x866 ?x682 (ite $x868 ?x683 (ite $x870 ?x684 (ite $x872 ?x685 ?x1001)))))))
 (let ((?x678 (ite $x495 0 ?x492)))
 (let (($x1011 (= v_1_rx_slot_07 (ite $x661 0 (ite $x357 ?x678 (ite $x859 ?x679 (ite $x862 ?x680 ?x1006)))))))
 (let (($x875 (or $x841 $x532)))
 (let ((?x988 (ite (and $x875 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x861 $x691 $x887) ?x636 0)))
 (let (($x873 (or $x843 $x514)))
 (let (($x874 (and $x873 $x846 $x848 $x850 $x852 $x854 $x856 $x861 $x691)))
 (let ((?x993 (ite $x866 ?x681 (ite $x868 ?x682 (ite $x870 ?x683 (ite $x872 ?x684 (ite $x874 ?x685 ?x988)))))))
 (let ((?x677 (ite $x475 0 ?x472)))
 (let ((?x998 (ite $x661 0 (ite $x357 ?x677 (ite $x859 ?x678 (ite $x862 ?x679 (ite $x864 ?x680 ?x993)))))))
 (let (($x877 (or $x839 $x550)))
 (let ((?x974 (ite (and $x877 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x861 $x691 $x887) ?x636 0)))
 (let (($x876 (and $x875 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x861 $x691)))
 (let ((?x979 (ite $x868 ?x681 (ite $x870 ?x682 (ite $x872 ?x683 (ite $x874 ?x684 (ite $x876 ?x685 ?x974)))))))
 (let ((?x676 (ite $x455 0 ?x452)))
 (let ((?x984 (ite $x357 ?x676 (ite $x859 ?x677 (ite $x862 ?x678 (ite $x864 ?x679 (ite $x866 ?x680 ?x979)))))))
 (let (($x879 (or $x837 $x568)))
 (let (($x958 (and $x879 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x861 $x691 $x887)))
 (let (($x878 (and $x877 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x861 $x691)))
 (let ((?x963 (ite $x872 ?x682 (ite $x874 ?x683 (ite $x876 ?x684 (ite $x878 ?x685 (ite $x958 ?x636 0)))))))
 (let ((?x968 (ite $x862 ?x677 (ite $x864 ?x678 (ite $x866 ?x679 (ite $x868 ?x680 (ite $x870 ?x681 ?x963)))))))
 (let ((?x675 (ite $x435 0 ?x432)))
 (let (($x972 (= v_1_rx_slot_04 (ite $x661 0 (ite $x357 ?x675 (ite $x859 ?x676 ?x968))))))
 (let (($x881 (or $x835 $x586)))
 (let (($x942 (and $x881 $x838 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x861 $x691 $x887)))
 (let (($x880 (and $x879 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x861 $x691)))
 (let ((?x947 (ite $x874 ?x682 (ite $x876 ?x683 (ite $x878 ?x684 (ite $x880 ?x685 (ite $x942 ?x636 0)))))))
 (let ((?x952 (ite $x864 ?x677 (ite $x866 ?x678 (ite $x868 ?x679 (ite $x870 ?x680 (ite $x872 ?x681 ?x947)))))))
 (let ((?x674 (ite $x415 0 ?x412)))
 (let (($x957 (= v_1_rx_slot_03 (ite $x661 0 (ite $x357 ?x674 (ite $x859 ?x675 (ite $x862 ?x676 ?x952)))))))
 (let (($x883 (or $x833 $x604)))
 (let (($x925 (and $x883 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x861 $x691 $x887)))
 (let (($x882 (and $x881 $x838 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x861 $x691)))
 (let ((?x930 (ite $x876 ?x682 (ite $x878 ?x683 (ite $x880 ?x684 (ite $x882 ?x685 (ite $x925 ?x636 0)))))))
 (let ((?x935 (ite $x866 ?x677 (ite $x868 ?x678 (ite $x870 ?x679 (ite $x872 ?x680 (ite $x874 ?x681 ?x930)))))))
 (let ((?x673 (ite $x395 0 ?x392)))
 (let ((?x940 (ite $x661 0 (ite $x357 ?x673 (ite $x859 ?x674 (ite $x862 ?x675 (ite $x864 ?x676 ?x935)))))))
 (let (($x885 (or $x831 $x622)))
 (let (($x907 (and $x885 $x834 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x861 $x691 $x887)))
 (let (($x884 (and $x883 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x861 $x691)))
 (let ((?x912 (ite $x878 ?x682 (ite $x880 ?x683 (ite $x882 ?x684 (ite $x884 ?x685 (ite $x907 ?x636 0)))))))
 (let ((?x917 (ite $x868 ?x677 (ite $x870 ?x678 (ite $x872 ?x679 (ite $x874 ?x680 (ite $x876 ?x681 ?x912)))))))
 (let ((?x672 (ite $x375 0 ?x372)))
 (let ((?x922 (ite $x357 ?x672 (ite $x859 ?x673 (ite $x862 ?x674 (ite $x864 ?x675 (ite $x866 ?x676 ?x917)))))))
 (let (($x888 (and $x640 $x832 $x834 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x861 $x691 $x887)))
 (let (($x886 (and $x885 $x834 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x861 $x691)))
 (let ((?x893 (ite $x880 ?x682 (ite $x882 ?x683 (ite $x884 ?x684 (ite $x886 ?x685 (ite $x888 ?x636 0)))))))
 (let ((?x898 (ite $x870 ?x677 (ite $x872 ?x678 (ite $x874 ?x679 (ite $x876 ?x680 (ite $x878 ?x681 ?x893)))))))
 (let ((?x903 (ite $x859 ?x672 (ite $x862 ?x673 (ite $x864 ?x674 (ite $x866 ?x675 (ite $x868 ?x676 ?x898)))))))
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
 (and (>= now_1 now_0) (<= 0 input_0_net.fin_segment_data) (>= 16 input_0_net.fin_segment_data) (not (= ?x271 2147483648)) (<= 0 input_0_net.fin_segment_window) (>= 65535 input_0_net.fin_segment_window) (or (and (not (= ?x281 2147483648)) (not $x287)) (not $x302)) v_0_fin_sent (not (= ?x281 (+ 1 v_0_rtx_buf))) $x309 (or (not active_0_rtx) (not (<= due_0_rtx now_1))) (or (not active_0_user) (not (<= due_0_user now_1))) (or (not active_0_time_wait) (not (<= due_0_time_wait now_1))) $x325 $x662 $x664 $x665 $x666 (= v_1_snd_una (ite $x667 input_0_net.fin_segment_ack v_0_snd_una)) $x670 $x699 $x700 $x701 $x704 (= v_1_rto_ms ?x770) $x774 $x777 $x780 $x783 (= v_1_local_window (+ 16 (* ?x268 v_0_rcv_buf) (* ?x268 ?x695))) $x789 (= v_1_rtx_buf ?x798) (= v_1_rcv_buf (+ v_0_rcv_buf ?x695)) (= v_1_snd_wnd (ite $x819 input_0_net.fin_segment_window v_0_snd_wnd)) (= v_1_snd_wl1 (ite $x819 input_0_net.fin_segment_seq v_0_snd_wl1)) (= v_1_snd_wl2 (ite $x819 input_0_net.fin_segment_ack v_0_snd_wl2)) $x829 (= v_1_rx_chunk ?x695) (= v_1_rx_slot_00 (ite $x661 0 (ite $x357 ?x671 ?x903))) (= v_1_rx_slot_01 (ite $x661 0 ?x922)) (= v_1_rx_slot_02 ?x940) $x957 $x972 (= v_1_rx_slot_05 (ite $x661 0 ?x984)) (= v_1_rx_slot_06 ?x998) $x1011 $x1022 (= v_1_rx_slot_09 (ite $x661 0 (ite $x357 ?x680 ?x1029))) (= v_1_rx_slot_10 ?x1040) $x1049 $x1056 (= v_1_rx_slot_13 (ite $x661 0 (ite $x357 ?x684 ?x1059))) $x1067 (= v_1_rx_slot_15 ?x1071) (= v_1_rx_advance ?x656) (= v_1_rx_acceptable (and $x302 $x332 $x334)) (= v_1_seg_acceptable $x302) (= v_1_ack_delta ?x281) (= v_1_ack_is_new (and $x319 $x322)) (= v_1_ack_is_future $x331) (= v_1_ack_advance $x667) (= v_1_ack_window_update $x819) $x1093 (= v_1_fin_sent $x1095) $x1097 (= v_1_fin_acknowledged $x324) (= v_1_rx_fin_pending (and $x337 $x662)) (= v_1_rx_fin_seq (ite $x336 ?x1104 v_0_rx_fin_seq)) (= v_1_rx_fin_offset (ite $x661 0 ?x659)) (= v_1_rx_fin_done (or v_0_rx_fin_done $x661)) (= v_1_rx_fin_consumed $x661) (= v_1_srtt_ms ?x732) (= v_1_rttvar_ms ?x755) (= v_1_rtt_error_ms ?x748) $x1124 $x1128 (= v_1_rtt_measured (or v_0_rtt_measured $x712)) $x1135 (= v_1_rtt_active (and v_0_rtt_active (not $x1137))) (= v_1_rtt_ambiguous (and (not $x1137) v_0_rtt_ambiguous)) $x1145 $x1146 $x1155 $x1157 (= v_1_rtt_sample_used $x712) $x1162 (= v_1_rtt_last_ms ?x727) (= v_1_rtt_samples (+ v_0_rtt_samples (ite $x712 1 0))) (= v_1_rto_base_ms (ite $x712 ?x768 v_0_rto_base_ms)) $x1228 (= v_1_tx_time_01 (ite (or $x1176 (>= 1 ?x798)) 0 ?x1246)) (= v_1_tx_time_02 ?x1266) $x1285 (= v_1_tx_time_04 (ite (or (>= 4 ?x798) $x1176) 0 ?x1300)) (= v_1_tx_time_05 ?x1317) $x1333 (= v_1_tx_time_07 (ite (or $x1176 (>= 7 ?x798)) 0 ?x1345)) (= v_1_tx_time_08 ?x1359) $x1372 (= v_1_tx_time_10 (ite (or (>= 10 ?x798) $x1176) 0 ?x1381)) (= v_1_tx_time_11 ?x1392) $x1402 (= v_1_tx_time_13 (ite (or (>= 13 ?x798) $x1176) 0 ?x1408)) (= v_1_tx_time_14 ?x1416) $x1422 (= v_1_tx_fin_time (ite $x1095 v_0_tx_fin_time 0)) $x1429 $x1432 $x1435 $x1437 $x1440 $x1443 $x1446 $x1448 $x1450 $x1452 $x1454 (= active_1_rtx (and $x664 $x1464)) (= active_1_user (and $x664 active_0_user)) (= active_1_time_wait (or active_0_time_wait $x663)) (= due_1_rtx (ite $x1459 (+ now_1 ?x770) due_0_rtx)) $x1478 (= due_1_time_wait (ite $x663 ?x1481 due_0_time_wait))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
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
 (let ((?x1489 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1489)))
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
 (let (($x1499 (not (>= v_0_rcv_buf 16))))
 (or $x1499 $x340))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x358 (= 0 v_0_rx_slot_01)))
 (let (($x1503 (not (>= v_0_rcv_buf 15))))
 (or $x1503 $x358))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x377 (= 0 v_0_rx_slot_02)))
 (let (($x1507 (not (>= v_0_rcv_buf 14))))
 (or $x1507 $x377))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x397 (= 0 v_0_rx_slot_03)))
 (let (($x1511 (not (>= v_0_rcv_buf 13))))
 (or $x1511 $x397))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x417 (= 0 v_0_rx_slot_04)))
 (let (($x1515 (not (>= v_0_rcv_buf 12))))
 (or $x1515 $x417))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x437 (= 0 v_0_rx_slot_05)))
 (let (($x1519 (not (>= v_0_rcv_buf 11))))
 (or $x1519 $x437))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x457 (= 0 v_0_rx_slot_06)))
 (let (($x1523 (not (>= v_0_rcv_buf 10))))
 (or $x1523 $x457))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x477 (= 0 v_0_rx_slot_07)))
 (let (($x1527 (not (>= v_0_rcv_buf 9))))
 (or $x1527 $x477))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x497 (= 0 v_0_rx_slot_08)))
 (let (($x1531 (not (>= v_0_rcv_buf 8))))
 (or $x1531 $x497))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x515 (= 0 v_0_rx_slot_09)))
 (let (($x1535 (not (>= v_0_rcv_buf 7))))
 (or $x1535 $x515))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x533 (= 0 v_0_rx_slot_10)))
 (let (($x1539 (not (>= v_0_rcv_buf 6))))
 (or $x1539 $x533))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x551 (= 0 v_0_rx_slot_11)))
 (let (($x1543 (not (>= v_0_rcv_buf 5))))
 (or $x1543 $x551))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x569 (= 0 v_0_rx_slot_12)))
 (let (($x1547 (not (>= v_0_rcv_buf 4))))
 (or $x1547 $x569))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x587 (= 0 v_0_rx_slot_13)))
 (let (($x1551 (not (>= v_0_rcv_buf 3))))
 (or $x1551 $x587))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x605 (= 0 v_0_rx_slot_14)))
 (let (($x1555 (not (>= v_0_rcv_buf 2))))
 (or $x1555 $x605))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x623 (= 0 v_0_rx_slot_15)))
 (let (($x1559 (not (>= v_0_rcv_buf 1))))
 (or $x1559 $x623))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x1561 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x1561)))
(assert
 (and (<= 0 v_0_rx_advance) (>= 16 v_0_rx_advance)))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (and (<= 0 v_0_ack_delta) (>= 4294967295 v_0_ack_delta)))
(assert
 true)
(assert
 (let ((?x1574 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x1574)))
(assert
 (= active_0_rtx (<= 1 (+ v_0_rtx_buf (ite v_0_fin_sent 1 0)))))
(assert
 (let (($x1583 (and v_0_fin_requested (= v_0_fin_seq (mod (+ v_0_snd_una v_0_rtx_buf) 4294967296)) (= 0 v_0_snd_buf))))
 (let (($x1578 (not v_0_fin_sent)))
 (or $x1578 $x1583))))
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
 (let (($x1585 (<= 1 v_0_rx_fin_offset)))
 (let (($x334 (not v_0_rx_fin_done)))
 (let (($x1587 (and $x334 $x1585 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window)))))
 (let (($x335 (not v_0_rx_fin_pending)))
 (or $x335 $x1587))))))
(assert
 (let (($x1590 (>= 15 v_0_rx_fin_offset)))
 (and (<= 0 v_0_rx_fin_offset) $x1590 (= v_0_rx_fin_pending (<= 1 v_0_rx_fin_offset)))))
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
 (let ((?x1678 (* 4.0 v_0_rttvar_ms)))
 (let ((?x715 (- 1.0)))
 (let ((?x744 (* ?x715 v_0_srtt_ms)))
 (let ((?x1681 (+ ?x744 (* ?x715 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x1678)))))
 (let ((?x1682 (to_int ?x1681)))
 (let ((?x268 (- 1)))
 (let ((?x1685 (ite (<= ?x1682 (- 1000)) (* ?x268 ?x1682) 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x1685) 60000 ?x1685) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x708 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x1700 (and (<= v_0_rtt_start_ms now_0) (<= 1 v_0_rtt_remaining) (>= 4 v_0_rtt_remaining) (>= ?x708 v_0_rtt_remaining) (<= ?x708 (mod (+ v_0_snd_nxt (* (- 1) v_0_snd_una)) 4294967296)))))
 (let (($x1692 (not v_0_rtt_active)))
 (or $x1692 $x1700)))))
(assert
 (or v_0_rtt_active (= 0 v_0_rtt_remaining)))
(assert
 true)
(assert
 (let (($x1707 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1710 (and $x1707 v_0_rtt_measured (= v_0_rtt_last_ms (+ now_0 (* (- 1) v_0_rtt_start_ms))))))
 (let (($x1705 (not v_0_rtt_sample_used)))
 (or $x1705 $x1710)))))
(assert
 (let ((?x1713 (to_real v_0_rtt_last_ms)))
 (let ((?x1727 (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x1713))))
 (let ((?x1715 (+ v_0_rtt_previous_srtt (* (- 1.0) ?x1713))))
 (let ((?x1719 (ite (>= ?x1715 0.0) ?x1715 (+ (* (- 1.0) v_0_rtt_previous_srtt) ?x1713))))
 (let ((?x739 (/ 1.0 4.0)))
 (let ((?x1723 (ite v_0_rtt_previous_measured (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* ?x739 ?x1719)) (* (/ 1.0 2.0) ?x1713))))
 (let (($x1730 (and (= v_0_rttvar_ms ?x1723) (= v_0_srtt_ms (ite v_0_rtt_previous_measured ?x1727 ?x1713)))))
 (let (($x1705 (not v_0_rtt_sample_used)))
 (or $x1705 $x1730))))))))))
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
 (let (($x1866 (and (>= v_0_tx_elapsed v_0_tx_previous_rto) (<= 1 v_0_tx_emit_count) (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x1860 (not v_0_tx_retransmitted)))
 (or $x1860 $x1866))))
(assert
 (let (($x1860 (not v_0_tx_retransmitted)))
 (or $x1860 (not v_0_tx_waiting))))
(assert
 (and (<= 0 v_0_tx_syn_time) (<= v_0_tx_syn_time now_0)))
(assert
 (not v_0_tx_syn_pending))
(assert
 (or v_0_tx_syn_pending (= 0 v_0_tx_syn_time)))
(assert
 true)
(assert
 (= 177 choice_0))
(assert
 (= 5 state_0))
(assert
 (= 5 state_1))
(assert
 (let (($x1886 (not active_1_user)))
(or $x1886 (not (not active_1_time_wait)) (not (<= 1000 v_1_rto_ms)) (not (<= 0 v_1_retries)) (not (<= 1 v_1_msl_ms)) (not (<= 1 v_1_user_timeout_ms)) (not (>= 16 (+ v_1_snd_buf v_1_rtx_buf))) (not (>= 16 v_1_rcv_buf)))))
(check-sat)
