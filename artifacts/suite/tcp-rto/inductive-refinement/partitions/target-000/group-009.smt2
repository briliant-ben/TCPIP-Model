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
 (let ((?x1199 (+ now_1 (* 2 v_0_msl_ms))))
 (let ((?x319 (ite v_0_fin_sent 1 0)))
 (let ((?x320 (+ v_0_rtx_buf ?x319)))
 (let ((?x281 (mod (+ input_0_net.fin_segment_ack (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x322 (= ?x281 ?x320)))
 (let (($x321 (<= ?x281 ?x320)))
 (let (($x318 (<= 1 ?x281)))
 (let ((?x268 (- 1)))
 (let ((?x295 (+ ?x268 v_0_local_window)))
 (let ((?x292 (* ?x268 v_0_rcv_nxt)))
 (let ((?x299 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data ?x292) 4294967296)))
 (let (($x300 (<= ?x299 ?x295)))
 (let (($x291 (<= 1 v_0_local_window)))
 (let (($x302 (or (and $x291 (<= (mod (+ input_0_net.fin_segment_seq ?x292) 4294967296) ?x295)) (and $x291 $x300))))
 (let (($x334 (not v_0_rx_fin_pending)))
 (let (($x333 (not v_0_rx_fin_done)))
 (let (($x330 (and (>= ?x281 (+ 1 v_0_rtx_buf ?x319)) (>= 2147483647 ?x281))))
 (let (($x331 (not $x330)))
 (let (($x335 (and $x302 $x331 $x333 $x334 $x291 $x300)))
 (let ((?x338 (ite $x335 ?x299 v_0_rx_fin_offset)))
 (let (($x336 (or v_0_rx_fin_pending $x335)))
 (let (($x638 (and $x336 (>= 15 ?x338))))
 (let ((?x625 (mod (+ 15 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x630 (+ input_0_net.fin_segment_data (* ?x268 ?x625))))
 (let (($x628 (<= input_0_net.fin_segment_data ?x625)))
 (let (($x623 (<= v_0_rcv_buf 0)))
 (let (($x622 (= 0 v_0_rx_slot_15)))
 (let (($x627 (and $x302 $x331 $x333 $x622 $x623 (<= ?x625 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x635 (ite $x627 (ite (or $x628 (<= ?x630 1)) (ite $x628 0 ?x630) 1) v_0_rx_slot_15)))
 (let (($x639 (or (= ?x635 0) $x638)))
 (let (($x620 (and $x336 (>= 14 ?x338))))
 (let ((?x607 (mod (+ 14 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x612 (+ input_0_net.fin_segment_data (* ?x268 ?x607))))
 (let (($x610 (<= input_0_net.fin_segment_data ?x607)))
 (let (($x605 (<= v_0_rcv_buf 1)))
 (let (($x604 (= 0 v_0_rx_slot_14)))
 (let (($x609 (and $x302 $x331 $x333 $x604 $x605 (<= ?x607 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x617 (ite $x609 (ite (or $x610 (<= ?x612 1)) (ite $x610 0 ?x612) 1) v_0_rx_slot_14)))
 (let (($x621 (or (= ?x617 0) $x620)))
 (let (($x602 (and $x336 (>= 13 ?x338))))
 (let ((?x589 (mod (+ 13 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x594 (+ input_0_net.fin_segment_data (* ?x268 ?x589))))
 (let (($x592 (<= input_0_net.fin_segment_data ?x589)))
 (let (($x587 (<= v_0_rcv_buf 2)))
 (let (($x586 (= 0 v_0_rx_slot_13)))
 (let (($x591 (and $x302 $x331 $x333 $x586 $x587 (<= ?x589 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x599 (ite $x591 (ite (or $x592 (<= ?x594 1)) (ite $x592 0 ?x594) 1) v_0_rx_slot_13)))
 (let (($x603 (or (= ?x599 0) $x602)))
 (let (($x584 (and $x336 (>= 12 ?x338))))
 (let ((?x571 (mod (+ 12 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x576 (+ input_0_net.fin_segment_data (* ?x268 ?x571))))
 (let (($x574 (<= input_0_net.fin_segment_data ?x571)))
 (let (($x569 (<= v_0_rcv_buf 3)))
 (let (($x568 (= 0 v_0_rx_slot_12)))
 (let (($x573 (and $x302 $x331 $x333 $x568 $x569 (<= ?x571 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x581 (ite $x573 (ite (or $x574 (<= ?x576 1)) (ite $x574 0 ?x576) 1) v_0_rx_slot_12)))
 (let (($x585 (or (= ?x581 0) $x584)))
 (let ((?x643 (ite $x585 12 (ite $x603 13 (ite $x621 14 (ite $x639 15 16))))))
 (let (($x566 (and $x336 (>= 11 ?x338))))
 (let ((?x553 (mod (+ 11 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x558 (+ input_0_net.fin_segment_data (* ?x268 ?x553))))
 (let (($x556 (<= input_0_net.fin_segment_data ?x553)))
 (let (($x551 (<= v_0_rcv_buf 4)))
 (let (($x550 (= 0 v_0_rx_slot_11)))
 (let (($x555 (and $x302 $x331 $x333 $x550 $x551 (<= ?x553 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x563 (ite $x555 (ite (or $x556 (<= ?x558 1)) (ite $x556 0 ?x558) 1) v_0_rx_slot_11)))
 (let (($x567 (or (= ?x563 0) $x566)))
 (let (($x548 (and $x336 (>= 10 ?x338))))
 (let ((?x535 (mod (+ 10 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x540 (+ input_0_net.fin_segment_data (* ?x268 ?x535))))
 (let (($x538 (<= input_0_net.fin_segment_data ?x535)))
 (let (($x533 (<= v_0_rcv_buf 5)))
 (let (($x532 (= 0 v_0_rx_slot_10)))
 (let (($x537 (and $x302 $x331 $x333 $x532 $x533 (<= ?x535 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x545 (ite $x537 (ite (or $x538 (<= ?x540 1)) (ite $x538 0 ?x540) 1) v_0_rx_slot_10)))
 (let (($x549 (or (= ?x545 0) $x548)))
 (let (($x530 (and $x336 (>= 9 ?x338))))
 (let ((?x517 (mod (+ 9 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x522 (+ input_0_net.fin_segment_data (* ?x268 ?x517))))
 (let (($x520 (<= input_0_net.fin_segment_data ?x517)))
 (let (($x515 (<= v_0_rcv_buf 6)))
 (let (($x514 (= 0 v_0_rx_slot_09)))
 (let (($x519 (and $x302 $x331 $x333 $x514 $x515 (<= ?x517 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x527 (ite $x519 (ite (or $x520 (<= ?x522 1)) (ite $x520 0 ?x522) 1) v_0_rx_slot_09)))
 (let (($x531 (or (= ?x527 0) $x530)))
 (let (($x512 (and $x336 (>= 8 ?x338))))
 (let ((?x499 (mod (+ 8 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x504 (+ input_0_net.fin_segment_data (* ?x268 ?x499))))
 (let (($x502 (<= input_0_net.fin_segment_data ?x499)))
 (let (($x497 (<= v_0_rcv_buf 7)))
 (let (($x496 (= 0 v_0_rx_slot_08)))
 (let (($x501 (and $x302 $x331 $x333 $x496 $x497 (<= ?x499 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x509 (ite $x501 (ite (or $x502 (<= ?x504 1)) (ite $x502 0 ?x504) 1) v_0_rx_slot_08)))
 (let (($x513 (or (= ?x509 0) $x512)))
 (let ((?x647 (ite $x513 8 (ite $x531 9 (ite $x549 10 (ite $x567 11 ?x643))))))
 (let (($x494 (and $x336 (>= 7 ?x338))))
 (let ((?x481 (mod (+ 7 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x486 (+ input_0_net.fin_segment_data (* ?x268 ?x481))))
 (let (($x484 (<= input_0_net.fin_segment_data ?x481)))
 (let (($x478 (<= v_0_rcv_buf 8)))
 (let (($x476 (= 0 v_0_rx_slot_07)))
 (let (($x483 (and $x302 $x331 $x333 $x476 $x478 (<= ?x481 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x491 (ite $x483 (ite (or $x484 (<= ?x486 1)) (ite $x484 0 ?x486) 1) v_0_rx_slot_07)))
 (let (($x495 (or (= ?x491 0) $x494)))
 (let (($x474 (and $x336 (>= 6 ?x338))))
 (let ((?x461 (mod (+ 6 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x466 (+ input_0_net.fin_segment_data (* ?x268 ?x461))))
 (let (($x464 (<= input_0_net.fin_segment_data ?x461)))
 (let (($x458 (<= v_0_rcv_buf 9)))
 (let (($x456 (= 0 v_0_rx_slot_06)))
 (let (($x463 (and $x302 $x331 $x333 $x456 $x458 (<= ?x461 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x471 (ite $x463 (ite (or $x464 (<= ?x466 1)) (ite $x464 0 ?x466) 1) v_0_rx_slot_06)))
 (let (($x475 (or (= ?x471 0) $x474)))
 (let (($x454 (and $x336 (>= 5 ?x338))))
 (let ((?x441 (mod (+ 5 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x446 (+ input_0_net.fin_segment_data (* ?x268 ?x441))))
 (let (($x444 (<= input_0_net.fin_segment_data ?x441)))
 (let (($x438 (<= v_0_rcv_buf 10)))
 (let (($x436 (= 0 v_0_rx_slot_05)))
 (let (($x443 (and $x302 $x331 $x333 $x436 $x438 (<= ?x441 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x451 (ite $x443 (ite (or $x444 (<= ?x446 1)) (ite $x444 0 ?x446) 1) v_0_rx_slot_05)))
 (let (($x455 (or (= ?x451 0) $x454)))
 (let (($x434 (and $x336 (>= 4 ?x338))))
 (let ((?x421 (mod (+ 4 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x426 (+ input_0_net.fin_segment_data (* ?x268 ?x421))))
 (let (($x424 (<= input_0_net.fin_segment_data ?x421)))
 (let (($x418 (<= v_0_rcv_buf 11)))
 (let (($x416 (= 0 v_0_rx_slot_04)))
 (let (($x423 (and $x302 $x331 $x333 $x416 $x418 (<= ?x421 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x431 (ite $x423 (ite (or $x424 (<= ?x426 1)) (ite $x424 0 ?x426) 1) v_0_rx_slot_04)))
 (let (($x435 (or (= ?x431 0) $x434)))
 (let ((?x651 (ite $x435 4 (ite $x455 5 (ite $x475 6 (ite $x495 7 ?x647))))))
 (let (($x414 (and $x336 (>= 3 ?x338))))
 (let ((?x401 (mod (+ 3 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x406 (+ input_0_net.fin_segment_data (* ?x268 ?x401))))
 (let (($x404 (<= input_0_net.fin_segment_data ?x401)))
 (let (($x398 (<= v_0_rcv_buf 12)))
 (let (($x396 (= 0 v_0_rx_slot_03)))
 (let (($x403 (and $x302 $x331 $x333 $x396 $x398 (<= ?x401 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x411 (ite $x403 (ite (or $x404 (<= ?x406 1)) (ite $x404 0 ?x406) 1) v_0_rx_slot_03)))
 (let (($x415 (or (= ?x411 0) $x414)))
 (let (($x394 (and $x336 (>= 2 ?x338))))
 (let ((?x381 (mod (+ 2 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x386 (+ input_0_net.fin_segment_data (* ?x268 ?x381))))
 (let (($x384 (<= input_0_net.fin_segment_data ?x381)))
 (let (($x378 (<= v_0_rcv_buf 13)))
 (let (($x376 (= 0 v_0_rx_slot_02)))
 (let (($x383 (and $x302 $x331 $x333 $x376 $x378 (<= ?x381 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x391 (ite $x383 (ite (or $x384 (<= ?x386 1)) (ite $x384 0 ?x386) 1) v_0_rx_slot_02)))
 (let (($x395 (or (= ?x391 0) $x394)))
 (let (($x374 (and $x336 (>= 1 ?x338))))
 (let ((?x361 (mod (+ 1 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x366 (+ input_0_net.fin_segment_data (* ?x268 ?x361))))
 (let (($x364 (<= input_0_net.fin_segment_data ?x361)))
 (let (($x359 (<= v_0_rcv_buf 14)))
 (let (($x357 (= 0 v_0_rx_slot_01)))
 (let (($x363 (and $x302 $x331 $x333 $x357 $x359 (<= ?x361 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x371 (ite $x363 (ite (or $x364 (<= ?x366 1)) (ite $x364 0 ?x366) 1) v_0_rx_slot_01)))
 (let (($x372 (= ?x371 0)))
 (let (($x375 (or $x372 $x374)))
 (let ((?x654 (ite $x375 1 (ite $x395 2 (ite $x415 3 ?x651)))))
 (let (($x355 (and $x336 (>= 0 ?x338))))
 (let ((?x271 (mod (+ v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x347 (+ input_0_net.fin_segment_data (* ?x268 ?x271))))
 (let (($x345 (<= input_0_net.fin_segment_data ?x271)))
 (let (($x341 (<= v_0_rcv_buf 15)))
 (let (($x339 (= 0 v_0_rx_slot_00)))
 (let (($x344 (and $x302 $x331 $x333 $x339 $x341 (<= ?x271 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x352 (ite $x344 (ite (or $x345 (<= ?x347 1)) (ite $x345 0 ?x347) 1) v_0_rx_slot_00)))
 (let (($x356 (or (= ?x352 0) $x355)))
 (let ((?x655 (ite $x356 0 ?x654)))
 (let ((?x658 (ite $x336 (+ ?x338 (* ?x268 ?x655)) ?x338)))
 (let (($x659 (= 0 ?x658)))
 (let (($x662 (and $x336 $x333 $x659 $x302 $x318 $x321 v_0_fin_sent $x322)))
 (let (($x1196 (= due_1_user due_0_user)))
 (let (($x710 (not v_0_rtt_ambiguous)))
 (let ((?x707 (mod (+ v_0_rtt_end (* ?x268 v_0_snd_una)) 4294967296)))
 (let (($x708 (>= ?x281 ?x707)))
 (let (($x711 (and v_0_rtt_active $x302 $x318 $x321 $x708 $x710)))
 (let ((?x726 (ite $x711 (+ now_1 (* ?x268 v_0_rtt_start_ms)) v_0_rtt_last_ms)))
 (let ((?x727 (to_real ?x726)))
 (let ((?x751 (/ 1.0 2.0)))
 (let ((?x740 (+ v_0_srtt_ms (* (- 1.0) ?x727))))
 (let ((?x747 (ite $x711 (ite (>= ?x740 0.0) ?x740 (+ (* (- 1.0) v_0_srtt_ms) ?x727)) v_0_rtt_error_ms)))
 (let ((?x738 (/ 1.0 4.0)))
 (let ((?x753 (ite v_0_rtt_measured (+ (* (/ 3.0 4.0) v_0_rttvar_ms) (* ?x738 ?x747)) (* ?x751 ?x727))))
 (let ((?x754 (ite $x711 ?x753 v_0_rttvar_ms)))
 (let ((?x714 (- 1.0)))
 (let ((?x730 (ite v_0_rtt_measured (+ (* (/ 7.0 8.0) v_0_srtt_ms) (* (/ 1.0 8.0) ?x727)) ?x727)))
 (let ((?x731 (ite $x711 ?x730 v_0_srtt_ms)))
 (let ((?x759 (+ (* ?x714 ?x731) (* ?x714 (ite (<= ?x754 ?x738) 1.0 (* 4.0 ?x754))))))
 (let ((?x760 (to_int ?x759)))
 (let ((?x765 (ite (<= ?x760 (- 1000)) (* ?x268 ?x760) 1000)))
 (let ((?x767 (ite (<= 60000 ?x765) 60000 ?x765)))
 (let ((?x769 (ite $x711 ?x767 v_0_rto_ms)))
 (let (($x323 (and $x302 $x318 $x321 v_0_fin_sent $x322)))
 (let (($x324 (not $x323)))
 (let (($x1094 (and $x324 v_0_fin_sent)))
 (let ((?x794 (ite (<= 0 v_0_rtx_buf) v_0_rtx_buf 0)))
 (let ((?x792 (ite (<= v_0_rtx_buf ?x281) 0 (+ v_0_rtx_buf (* ?x268 ?x281)))))
 (let (($x666 (and $x302 $x318 $x321)))
 (let ((?x797 (ite $x666 (ite (<= ?x792 ?x794) ?x792 ?x794) v_0_rtx_buf)))
 (let ((?x1175 (+ ?x797 (ite $x1094 1 0))))
 (let (($x1181 (and $x302 $x318 $x321 (<= 1 ?x1175))))
 (let (($x1182 (or (and (not (and $x302 $x318 $x321 (= 0 ?x1175))) active_0_rtx) $x1181)))
 (let (($x663 (not $x662)))
 (let (($x1161 (= v_1_rtt_sample_was_ambiguous (and v_0_rtt_active v_0_rtt_ambiguous))))
 (let (($x1156 (not v_1_rtt_start_new)))
 (let ((?x790 (* ?x268 ?x281)))
 (let ((?x1148 (+ ?x707 ?x790)))
 (let (($x1151 (and v_0_rtt_active $x302 $x318 $x321 (not (<= v_0_rtt_remaining ?x1148)))))
 (let (($x1136 (and v_0_rtt_active $x302 $x318 $x321 $x708)))
 (let (($x1154 (= v_1_rtt_remaining (ite $x1136 0 (ite $x1151 ?x1148 v_0_rtt_remaining)))))
 (let (($x1145 (= v_1_rtt_end v_0_rtt_end)))
 (let (($x1144 (= v_1_rtt_start_ms v_0_rtt_start_ms)))
 (let (($x1134 (= v_1_rtt_previous_measured (ite $x711 v_0_rtt_measured v_0_rtt_previous_measured))))
 (let (($x1127 (= v_1_rtt_previous_var (ite $x711 v_0_rttvar_ms v_0_rtt_previous_var))))
 (let (($x1123 (= v_1_rtt_previous_srtt (ite $x711 v_0_srtt_ms v_0_rtt_previous_srtt))))
 (let ((?x1103 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data) 4294967296)))
 (let (($x1096 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x1092 (= v_1_fin_requested v_0_fin_requested)))
 (let (($x814 (<= 2147483648 (mod (+ input_0_net.fin_segment_ack (* ?x268 v_0_snd_wl2)) 4294967296))))
 (let (($x810 (= v_0_snd_wl1 input_0_net.fin_segment_seq)))
 (let ((?x804 (mod (+ input_0_net.fin_segment_seq (* ?x268 v_0_snd_wl1)) 4294967296)))
 (let (($x817 (or (and (not (<= ?x804 0)) (not (<= 2147483648 ?x804))) (and $x810 (not $x814)))))
 (let (($x818 (and $x302 $x321 $x817)))
 (let ((?x1070 (ite (or (not (and $x356 (not $x638))) (and $x336 $x333 $x659)) 0 ?x635)))
 (let (($x886 (not $x638)))
 (let (($x690 (not $x356)))
 (let (($x855 (not $x395)))
 (let (($x853 (not $x415)))
 (let (($x851 (not $x435)))
 (let (($x849 (not $x455)))
 (let (($x847 (not $x475)))
 (let (($x845 (not $x495)))
 (let (($x843 (not $x513)))
 (let (($x841 (not $x531)))
 (let (($x839 (not $x549)))
 (let (($x837 (not $x567)))
 (let (($x835 (not $x585)))
 (let (($x833 (not $x603)))
 (let (($x831 (not $x621)))
 (let (($x830 (and false $x639)))
 (let (($x832 (and $x830 $x831)))
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
 (let (($x857 (or $x372 (and $x854 $x855) $x374)))
 (let ((?x684 (ite $x620 0 ?x617)))
 (let (($x660 (and $x336 $x333 $x659)))
 (let (($x1066 (= v_1_rx_slot_14 (ite $x660 0 (ite $x356 ?x684 (ite (and $x857 $x690 $x886) ?x635 0))))))
 (let (($x858 (and $x857 $x690)))
 (let ((?x1058 (ite $x858 ?x684 (ite (and (or $x854 $x395) (not $x375) $x690 $x886) ?x635 0))))
 (let ((?x683 (ite $x602 0 ?x599)))
 (let (($x860 (not $x375)))
 (let (($x859 (or $x854 $x395)))
 (let (($x861 (and $x859 $x860 $x690)))
 (let ((?x1051 (ite $x861 ?x684 (ite (and (or $x852 $x415) $x855 $x860 $x690 $x886) ?x635 0))))
 (let ((?x682 (ite $x584 0 ?x581)))
 (let (($x1055 (= v_1_rx_slot_12 (ite $x660 0 (ite $x356 ?x682 (ite $x858 ?x683 ?x1051))))))
 (let (($x862 (or $x852 $x415)))
 (let (($x863 (and $x862 $x855 $x860 $x690)))
 (let ((?x1043 (ite $x863 ?x684 (ite (and (or $x850 $x435) $x853 $x855 $x860 $x690 $x886) ?x635 0))))
 (let ((?x681 (ite $x566 0 ?x563)))
 (let (($x1048 (= v_1_rx_slot_11 (ite $x660 0 (ite $x356 ?x681 (ite $x858 ?x682 (ite $x861 ?x683 ?x1043)))))))
 (let (($x864 (or $x850 $x435)))
 (let (($x865 (and $x864 $x853 $x855 $x860 $x690)))
 (let ((?x1034 (ite $x865 ?x684 (ite (and (or $x848 $x455) $x851 $x853 $x855 $x860 $x690 $x886) ?x635 0))))
 (let ((?x680 (ite $x548 0 ?x545)))
 (let ((?x1039 (ite $x660 0 (ite $x356 ?x680 (ite $x858 ?x681 (ite $x861 ?x682 (ite $x863 ?x683 ?x1034)))))))
 (let ((?x1023 (ite (and (or $x846 $x475) $x849 $x851 $x853 $x855 $x860 $x690 $x886) ?x635 0)))
 (let (($x866 (or $x848 $x455)))
 (let (($x867 (and $x866 $x851 $x853 $x855 $x860 $x690)))
 (let ((?x1028 (ite $x858 ?x680 (ite $x861 ?x681 (ite $x863 ?x682 (ite $x865 ?x683 (ite $x867 ?x684 ?x1023)))))))
 (let ((?x679 (ite $x530 0 ?x527)))
 (let ((?x1012 (ite (and (or $x844 $x495) $x847 $x849 $x851 $x853 $x855 $x860 $x690 $x886) ?x635 0)))
 (let (($x868 (or $x846 $x475)))
 (let (($x869 (and $x868 $x849 $x851 $x853 $x855 $x860 $x690)))
 (let ((?x1017 (ite $x861 ?x680 (ite $x863 ?x681 (ite $x865 ?x682 (ite $x867 ?x683 (ite $x869 ?x684 ?x1012)))))))
 (let ((?x678 (ite $x512 0 ?x509)))
 (let (($x1021 (= v_1_rx_slot_08 (ite $x660 0 (ite $x356 ?x678 (ite $x858 ?x679 ?x1017))))))
 (let ((?x1000 (ite (and (or $x842 $x513) $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x690 $x886) ?x635 0)))
 (let (($x870 (or $x844 $x495)))
 (let (($x871 (and $x870 $x847 $x849 $x851 $x853 $x855 $x860 $x690)))
 (let ((?x1005 (ite $x863 ?x680 (ite $x865 ?x681 (ite $x867 ?x682 (ite $x869 ?x683 (ite $x871 ?x684 ?x1000)))))))
 (let ((?x677 (ite $x494 0 ?x491)))
 (let (($x1010 (= v_1_rx_slot_07 (ite $x660 0 (ite $x356 ?x677 (ite $x858 ?x678 (ite $x861 ?x679 ?x1005)))))))
 (let (($x874 (or $x840 $x531)))
 (let ((?x987 (ite (and $x874 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x690 $x886) ?x635 0)))
 (let (($x872 (or $x842 $x513)))
 (let (($x873 (and $x872 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x690)))
 (let ((?x992 (ite $x865 ?x680 (ite $x867 ?x681 (ite $x869 ?x682 (ite $x871 ?x683 (ite $x873 ?x684 ?x987)))))))
 (let ((?x676 (ite $x474 0 ?x471)))
 (let ((?x997 (ite $x660 0 (ite $x356 ?x676 (ite $x858 ?x677 (ite $x861 ?x678 (ite $x863 ?x679 ?x992)))))))
 (let (($x876 (or $x838 $x549)))
 (let ((?x973 (ite (and $x876 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x690 $x886) ?x635 0)))
 (let (($x875 (and $x874 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x690)))
 (let ((?x978 (ite $x867 ?x680 (ite $x869 ?x681 (ite $x871 ?x682 (ite $x873 ?x683 (ite $x875 ?x684 ?x973)))))))
 (let ((?x675 (ite $x454 0 ?x451)))
 (let ((?x983 (ite $x356 ?x675 (ite $x858 ?x676 (ite $x861 ?x677 (ite $x863 ?x678 (ite $x865 ?x679 ?x978)))))))
 (let (($x878 (or $x836 $x567)))
 (let (($x957 (and $x878 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x690 $x886)))
 (let (($x877 (and $x876 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x690)))
 (let ((?x962 (ite $x871 ?x681 (ite $x873 ?x682 (ite $x875 ?x683 (ite $x877 ?x684 (ite $x957 ?x635 0)))))))
 (let ((?x967 (ite $x861 ?x676 (ite $x863 ?x677 (ite $x865 ?x678 (ite $x867 ?x679 (ite $x869 ?x680 ?x962)))))))
 (let ((?x674 (ite $x434 0 ?x431)))
 (let (($x971 (= v_1_rx_slot_04 (ite $x660 0 (ite $x356 ?x674 (ite $x858 ?x675 ?x967))))))
 (let (($x880 (or $x834 $x585)))
 (let (($x941 (and $x880 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x690 $x886)))
 (let (($x879 (and $x878 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x690)))
 (let ((?x946 (ite $x873 ?x681 (ite $x875 ?x682 (ite $x877 ?x683 (ite $x879 ?x684 (ite $x941 ?x635 0)))))))
 (let ((?x951 (ite $x863 ?x676 (ite $x865 ?x677 (ite $x867 ?x678 (ite $x869 ?x679 (ite $x871 ?x680 ?x946)))))))
 (let ((?x673 (ite $x414 0 ?x411)))
 (let (($x956 (= v_1_rx_slot_03 (ite $x660 0 (ite $x356 ?x673 (ite $x858 ?x674 (ite $x861 ?x675 ?x951)))))))
 (let (($x882 (or $x832 $x603)))
 (let (($x924 (and $x882 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x690 $x886)))
 (let (($x881 (and $x880 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x690)))
 (let ((?x929 (ite $x875 ?x681 (ite $x877 ?x682 (ite $x879 ?x683 (ite $x881 ?x684 (ite $x924 ?x635 0)))))))
 (let ((?x934 (ite $x865 ?x676 (ite $x867 ?x677 (ite $x869 ?x678 (ite $x871 ?x679 (ite $x873 ?x680 ?x929)))))))
 (let ((?x672 (ite $x394 0 ?x391)))
 (let ((?x939 (ite $x660 0 (ite $x356 ?x672 (ite $x858 ?x673 (ite $x861 ?x674 (ite $x863 ?x675 ?x934)))))))
 (let (($x884 (or $x830 $x621)))
 (let (($x906 (and $x884 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x690 $x886)))
 (let (($x883 (and $x882 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x690)))
 (let ((?x911 (ite $x877 ?x681 (ite $x879 ?x682 (ite $x881 ?x683 (ite $x883 ?x684 (ite $x906 ?x635 0)))))))
 (let ((?x916 (ite $x867 ?x676 (ite $x869 ?x677 (ite $x871 ?x678 (ite $x873 ?x679 (ite $x875 ?x680 ?x911)))))))
 (let ((?x671 (ite $x374 0 ?x371)))
 (let ((?x921 (ite $x356 ?x671 (ite $x858 ?x672 (ite $x861 ?x673 (ite $x863 ?x674 (ite $x865 ?x675 ?x916)))))))
 (let (($x887 (and $x639 $x831 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x690 $x886)))
 (let (($x885 (and $x884 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x690)))
 (let ((?x892 (ite $x879 ?x681 (ite $x881 ?x682 (ite $x883 ?x683 (ite $x885 ?x684 (ite $x887 ?x635 0)))))))
 (let ((?x897 (ite $x869 ?x676 (ite $x871 ?x677 (ite $x873 ?x678 (ite $x875 ?x679 (ite $x877 ?x680 ?x892)))))))
 (let ((?x902 (ite $x858 ?x671 (ite $x861 ?x672 (ite $x863 ?x673 (ite $x865 ?x674 (ite $x867 ?x675 ?x897)))))))
 (let ((?x670 (ite $x355 0 ?x352)))
 (let ((?x692 (ite (and (<= 0 ?x655) $x690) ?x654 0)))
 (let ((?x686 (+ ?x670 ?x671 ?x672 ?x673 ?x674 ?x675 ?x676 ?x677 ?x678 ?x679 ?x680 ?x681 ?x682 ?x683 ?x684 (ite $x638 0 ?x635))))
 (let ((?x688 (ite (<= ?x686 0) 0 ?x686)))
 (let ((?x694 (ite (<= ?x688 ?x692) ?x688 ?x692)))
 (let (($x828 (= v_1_take v_0_take)))
 (let (($x788 (= v_1_snd_buf v_0_snd_buf)))
 (let (($x782 (= v_1_msl_ms v_0_msl_ms)))
 (let (($x779 (= v_1_user_timeout_ms v_0_user_timeout_ms)))
 (let (($x776 (= v_1_active_open v_0_active_open)))
 (let (($x773 (= v_1_retries v_0_retries)))
 (let (($x703 (= v_1_tx_flags v_0_tx_flags)))
 (let (($x700 (= v_1_tx_ack v_0_tx_ack)))
 (let (($x699 (= v_1_tx_seq v_0_tx_seq)))
 (let (($x698 (= v_1_rcv_nxt (mod (+ v_0_rcv_nxt ?x694 (ite $x660 1 0)) 4294967296))))
 (let (($x669 (= v_1_snd_nxt v_0_snd_nxt)))
 (let (($x665 (= v_1_irs v_0_irs)))
 (let (($x664 (= v_1_iss v_0_iss)))
 (let (($x661 (not $x660)))
 (let (($x287 (= (mod (+ input_0_net.fin_segment_ack (* ?x268 v_0_snd_nxt)) 4294967296) 2147483648)))
 (and (>= now_1 now_0) (<= 0 input_0_net.fin_segment_data) (>= 16 input_0_net.fin_segment_data) (not (= ?x271 2147483648)) (<= 0 input_0_net.fin_segment_window) (>= 65535 input_0_net.fin_segment_window) (or (and (not (= ?x281 2147483648)) (not $x287)) (not $x302)) v_0_fin_sent (not (= ?x281 (+ 1 v_0_rtx_buf))) (or (not active_0_rtx) (not (<= due_0_rtx now_1))) (or (not active_0_user) (not (<= due_0_user now_1))) (or (not active_0_time_wait) (not (<= due_0_time_wait now_1))) $x324 $x661 $x663 $x664 $x665 (= v_1_snd_una (ite $x666 input_0_net.fin_segment_ack v_0_snd_una)) $x669 $x698 $x699 $x700 $x703 (= v_1_rto_ms ?x769) $x773 $x776 $x779 $x782 (= v_1_local_window (+ 16 (* ?x268 v_0_rcv_buf) (* ?x268 ?x694))) $x788 (= v_1_rtx_buf ?x797) (= v_1_rcv_buf (+ v_0_rcv_buf ?x694)) (= v_1_snd_wnd (ite $x818 input_0_net.fin_segment_window v_0_snd_wnd)) (= v_1_snd_wl1 (ite $x818 input_0_net.fin_segment_seq v_0_snd_wl1)) (= v_1_snd_wl2 (ite $x818 input_0_net.fin_segment_ack v_0_snd_wl2)) $x828 (= v_1_rx_chunk ?x694) (= v_1_rx_slot_00 (ite $x660 0 (ite $x356 ?x670 ?x902))) (= v_1_rx_slot_01 (ite $x660 0 ?x921)) (= v_1_rx_slot_02 ?x939) $x956 $x971 (= v_1_rx_slot_05 (ite $x660 0 ?x983)) (= v_1_rx_slot_06 ?x997) $x1010 $x1021 (= v_1_rx_slot_09 (ite $x660 0 (ite $x356 ?x679 ?x1028))) (= v_1_rx_slot_10 ?x1039) $x1048 $x1055 (= v_1_rx_slot_13 (ite $x660 0 (ite $x356 ?x683 ?x1058))) $x1066 (= v_1_rx_slot_15 ?x1070) (= v_1_rx_advance ?x655) (= v_1_rx_acceptable (and $x302 $x331 $x333)) (= v_1_seg_acceptable $x302) (= v_1_ack_delta ?x281) (= v_1_ack_is_new (and $x318 $x321)) (= v_1_ack_is_future $x330) (= v_1_ack_advance $x666) (= v_1_ack_window_update $x818) $x1092 (= v_1_fin_sent $x1094) $x1096 (= v_1_fin_acknowledged $x323) (= v_1_rx_fin_pending (and $x336 $x661)) (= v_1_rx_fin_seq (ite $x335 ?x1103 v_0_rx_fin_seq)) (= v_1_rx_fin_offset (ite $x660 0 ?x658)) (= v_1_rx_fin_done (or v_0_rx_fin_done $x660)) (= v_1_rx_fin_consumed $x660) (= v_1_srtt_ms ?x731) (= v_1_rttvar_ms ?x754) (= v_1_rtt_error_ms ?x747) $x1123 $x1127 (= v_1_rtt_measured (or v_0_rtt_measured $x711)) $x1134 (= v_1_rtt_active (and v_0_rtt_active (not $x1136))) (= v_1_rtt_ambiguous (and (not $x1136) v_0_rtt_ambiguous)) $x1144 $x1145 $x1154 $x1156 (= v_1_rtt_sample_used $x711) $x1161 (= v_1_rtt_last_ms ?x726) (= v_1_rtt_samples (+ v_0_rtt_samples (ite $x711 1 0))) (= v_1_rto_base_ms (ite $x711 ?x767 v_0_rto_base_ms)) (= active_1_rtx (and $x663 $x1182)) (= active_1_user (and $x663 active_0_user)) (= active_1_time_wait (or active_0_time_wait $x662)) (= due_1_rtx (ite $x1181 (+ now_1 ?x769) due_0_rtx)) $x1196 (= due_1_time_wait (ite $x662 ?x1199 due_0_time_wait)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
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
 (let ((?x1207 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1207)))
(assert
 (>= 16 v_0_rcv_buf))
(assert
 (and (<= 0 v_0_snd_wnd) (>= 65535 v_0_snd_wnd)))
(assert
 (= v_0_local_window (+ 16 (* (- 1) v_0_rcv_buf))))
(assert
 (>= 1 v_0_rx_slot_00))
(assert
 (let (($x339 (= 0 v_0_rx_slot_00)))
 (let (($x1217 (not (>= v_0_rcv_buf 16))))
 (or $x1217 $x339))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x357 (= 0 v_0_rx_slot_01)))
 (let (($x1221 (not (>= v_0_rcv_buf 15))))
 (or $x1221 $x357))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x376 (= 0 v_0_rx_slot_02)))
 (let (($x1225 (not (>= v_0_rcv_buf 14))))
 (or $x1225 $x376))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x396 (= 0 v_0_rx_slot_03)))
 (let (($x1229 (not (>= v_0_rcv_buf 13))))
 (or $x1229 $x396))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x416 (= 0 v_0_rx_slot_04)))
 (let (($x1233 (not (>= v_0_rcv_buf 12))))
 (or $x1233 $x416))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x436 (= 0 v_0_rx_slot_05)))
 (let (($x1237 (not (>= v_0_rcv_buf 11))))
 (or $x1237 $x436))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x456 (= 0 v_0_rx_slot_06)))
 (let (($x1241 (not (>= v_0_rcv_buf 10))))
 (or $x1241 $x456))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x476 (= 0 v_0_rx_slot_07)))
 (let (($x1245 (not (>= v_0_rcv_buf 9))))
 (or $x1245 $x476))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x496 (= 0 v_0_rx_slot_08)))
 (let (($x1249 (not (>= v_0_rcv_buf 8))))
 (or $x1249 $x496))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x514 (= 0 v_0_rx_slot_09)))
 (let (($x1253 (not (>= v_0_rcv_buf 7))))
 (or $x1253 $x514))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x532 (= 0 v_0_rx_slot_10)))
 (let (($x1257 (not (>= v_0_rcv_buf 6))))
 (or $x1257 $x532))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x550 (= 0 v_0_rx_slot_11)))
 (let (($x1261 (not (>= v_0_rcv_buf 5))))
 (or $x1261 $x550))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x568 (= 0 v_0_rx_slot_12)))
 (let (($x1265 (not (>= v_0_rcv_buf 4))))
 (or $x1265 $x568))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x586 (= 0 v_0_rx_slot_13)))
 (let (($x1269 (not (>= v_0_rcv_buf 3))))
 (or $x1269 $x586))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x604 (= 0 v_0_rx_slot_14)))
 (let (($x1273 (not (>= v_0_rcv_buf 2))))
 (or $x1273 $x604))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x622 (= 0 v_0_rx_slot_15)))
 (let (($x1277 (not (>= v_0_rcv_buf 1))))
 (or $x1277 $x622))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x1279 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x1279)))
(assert
 (and (<= 0 v_0_rx_advance) (>= 16 v_0_rx_advance)))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (and (<= 0 v_0_ack_delta) (>= 4294967295 v_0_ack_delta)))
(assert
 true)
(assert
 (let ((?x1292 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x1292)))
(assert
 (= active_0_rtx (<= 1 (+ v_0_rtx_buf (ite v_0_fin_sent 1 0)))))
(assert
 (let (($x1301 (and v_0_fin_requested (= v_0_fin_seq (mod (+ v_0_snd_una v_0_rtx_buf) 4294967296)) (= 0 v_0_snd_buf))))
 (let (($x1296 (not v_0_fin_sent)))
 (or $x1296 $x1301))))
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
 (let (($x1303 (<= 1 v_0_rx_fin_offset)))
 (let (($x333 (not v_0_rx_fin_done)))
 (let (($x1305 (and $x333 $x1303 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window)))))
 (let (($x334 (not v_0_rx_fin_pending)))
 (or $x334 $x1305))))))
(assert
 (let (($x1308 (>= 15 v_0_rx_fin_offset)))
 (and (<= 0 v_0_rx_fin_offset) $x1308 (= v_0_rx_fin_pending (<= 1 v_0_rx_fin_offset)))))
(assert
 (let (($x334 (not v_0_rx_fin_pending)))
 (or $x334 (= v_0_rx_fin_seq (mod (+ v_0_rcv_nxt v_0_rx_fin_offset) 4294967296)))))
(assert
 (let (($x333 (not v_0_rx_fin_done)))
 (or $x333 (= v_0_rcv_nxt (mod (+ 1 v_0_rx_fin_seq) 4294967296)))))
(assert
 (let (($x339 (= 0 v_0_rx_slot_00)))
 (or (not (and v_0_rx_fin_pending (>= 0 v_0_rx_fin_offset))) $x339)))
(assert
 (let (($x357 (= 0 v_0_rx_slot_01)))
 (or (not (and v_0_rx_fin_pending (>= 1 v_0_rx_fin_offset))) $x357)))
(assert
 (let (($x376 (= 0 v_0_rx_slot_02)))
 (or (not (and v_0_rx_fin_pending (>= 2 v_0_rx_fin_offset))) $x376)))
(assert
 (let (($x396 (= 0 v_0_rx_slot_03)))
 (or (not (and v_0_rx_fin_pending (>= 3 v_0_rx_fin_offset))) $x396)))
(assert
 (let (($x416 (= 0 v_0_rx_slot_04)))
 (or (not (and v_0_rx_fin_pending (>= 4 v_0_rx_fin_offset))) $x416)))
(assert
 (let (($x436 (= 0 v_0_rx_slot_05)))
 (or (not (and v_0_rx_fin_pending (>= 5 v_0_rx_fin_offset))) $x436)))
(assert
 (let (($x456 (= 0 v_0_rx_slot_06)))
 (or (not (and v_0_rx_fin_pending (>= 6 v_0_rx_fin_offset))) $x456)))
(assert
 (let (($x476 (= 0 v_0_rx_slot_07)))
 (or (not (and v_0_rx_fin_pending (>= 7 v_0_rx_fin_offset))) $x476)))
(assert
 (let (($x496 (= 0 v_0_rx_slot_08)))
 (or (not (and v_0_rx_fin_pending (>= 8 v_0_rx_fin_offset))) $x496)))
(assert
 (let (($x514 (= 0 v_0_rx_slot_09)))
 (or (not (and v_0_rx_fin_pending (>= 9 v_0_rx_fin_offset))) $x514)))
(assert
 (let (($x532 (= 0 v_0_rx_slot_10)))
 (or (not (and v_0_rx_fin_pending (>= 10 v_0_rx_fin_offset))) $x532)))
(assert
 (let (($x550 (= 0 v_0_rx_slot_11)))
 (or (not (and v_0_rx_fin_pending (>= 11 v_0_rx_fin_offset))) $x550)))
(assert
 (let (($x568 (= 0 v_0_rx_slot_12)))
 (or (not (and v_0_rx_fin_pending (>= 12 v_0_rx_fin_offset))) $x568)))
(assert
 (let (($x586 (= 0 v_0_rx_slot_13)))
 (or (not (and v_0_rx_fin_pending (>= 13 v_0_rx_fin_offset))) $x586)))
(assert
 (let (($x604 (= 0 v_0_rx_slot_14)))
 (or (not (and v_0_rx_fin_pending (>= 14 v_0_rx_fin_offset))) $x604)))
(assert
 (let (($x622 (= 0 v_0_rx_slot_15)))
 (or (not (and v_0_rx_fin_pending (>= 15 v_0_rx_fin_offset))) $x622)))
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
 (let ((?x1396 (* 4.0 v_0_rttvar_ms)))
 (let ((?x714 (- 1.0)))
 (let ((?x743 (* ?x714 v_0_srtt_ms)))
 (let ((?x1399 (+ ?x743 (* ?x714 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x1396)))))
 (let ((?x1400 (to_int ?x1399)))
 (let ((?x268 (- 1)))
 (let ((?x1403 (ite (<= ?x1400 (- 1000)) (* ?x268 ?x1400) 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x1403) 60000 ?x1403) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x707 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x1418 (and (<= v_0_rtt_start_ms now_0) (<= 1 v_0_rtt_remaining) (>= 4 v_0_rtt_remaining) (>= ?x707 v_0_rtt_remaining) (<= ?x707 (mod (+ v_0_snd_nxt (* (- 1) v_0_snd_una)) 4294967296)))))
 (let (($x1410 (not v_0_rtt_active)))
 (or $x1410 $x1418)))))
(assert
 (or v_0_rtt_active (= 0 v_0_rtt_remaining)))
(assert
 true)
(assert
 (let (($x1425 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1428 (and $x1425 v_0_rtt_measured (= v_0_rtt_last_ms (+ now_0 (* (- 1) v_0_rtt_start_ms))))))
 (let (($x1423 (not v_0_rtt_sample_used)))
 (or $x1423 $x1428)))))
(assert
 (let ((?x1431 (to_real v_0_rtt_last_ms)))
 (let ((?x1445 (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x1431))))
 (let ((?x1433 (+ v_0_rtt_previous_srtt (* (- 1.0) ?x1431))))
 (let ((?x1437 (ite (>= ?x1433 0.0) ?x1433 (+ (* (- 1.0) v_0_rtt_previous_srtt) ?x1431))))
 (let ((?x738 (/ 1.0 4.0)))
 (let ((?x1441 (ite v_0_rtt_previous_measured (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* ?x738 ?x1437)) (* (/ 1.0 2.0) ?x1431))))
 (let (($x1448 (and (= v_0_rttvar_ms ?x1441) (= v_0_srtt_ms (ite v_0_rtt_previous_measured ?x1445 ?x1431)))))
 (let (($x1423 (not v_0_rtt_sample_used)))
 (or $x1423 $x1448))))))))))
(assert
 (= 160 choice_0))
(assert
 (= 5 state_0))
(assert
 (= 5 state_1))
(assert
 (let (($x1497 (or (not (and v_1_rx_fin_pending (>= 15 v_1_rx_fin_offset))) (= 0 v_1_rx_slot_15))))
(let (($x1491 (or (not (and v_1_rx_fin_pending (>= 14 v_1_rx_fin_offset))) (= 0 v_1_rx_slot_14))))
(let (($x1485 (or (not (and v_1_rx_fin_pending (>= 13 v_1_rx_fin_offset))) (= 0 v_1_rx_slot_13))))
(let (($x1479 (or (not (and v_1_rx_fin_pending (>= 12 v_1_rx_fin_offset))) (= 0 v_1_rx_slot_12))))
(let (($x1473 (or (not (and v_1_rx_fin_pending (>= 11 v_1_rx_fin_offset))) (= 0 v_1_rx_slot_11))))
(let (($x1467 (or (not (and v_1_rx_fin_pending (>= 10 v_1_rx_fin_offset))) (= 0 v_1_rx_slot_10))))
(let (($x1461 (or (not (and v_1_rx_fin_pending (>= 9 v_1_rx_fin_offset))) (= 0 v_1_rx_slot_09))))
(or (not $x1461) (not $x1467) (not $x1473) (not $x1479) (not $x1485) (not $x1491) (not $x1497) (not (<= 0.0 v_1_srtt_ms)))))))))))
(check-sat)
