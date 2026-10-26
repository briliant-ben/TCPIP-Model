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
 (let ((?x1479 (+ now_1 (* 2 v_0_msl_ms))))
 (let ((?x318 (ite v_0_fin_sent 1 0)))
 (let ((?x319 (+ v_0_rtx_buf ?x318)))
 (let ((?x281 (mod (+ input_0_net.fin_segment_ack (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x321 (= ?x281 ?x319)))
 (let (($x320 (<= ?x281 ?x319)))
 (let (($x317 (<= 1 ?x281)))
 (let ((?x268 (- 1)))
 (let ((?x295 (+ ?x268 v_0_local_window)))
 (let (($x300 (<= (mod (+ input_0_net.fin_segment_seq (* ?x268 v_0_rcv_nxt)) 4294967296) ?x295)))
 (let (($x291 (<= 1 v_0_local_window)))
 (let ((?x292 (* ?x268 v_0_rcv_nxt)))
 (let ((?x294 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data ?x292) 4294967296)))
 (let (($x296 (<= ?x294 ?x295)))
 (let (($x302 (or (and $x291 $x296) (and $x291 $x300))))
 (let (($x333 (not v_0_rx_fin_pending)))
 (let (($x332 (not v_0_rx_fin_done)))
 (let (($x329 (and (>= ?x281 (+ 1 v_0_rtx_buf ?x318)) (>= 2147483647 ?x281))))
 (let (($x330 (not $x329)))
 (let (($x334 (and $x302 $x330 $x332 $x333 $x291 $x296)))
 (let ((?x337 (ite $x334 ?x294 v_0_rx_fin_offset)))
 (let (($x335 (or v_0_rx_fin_pending $x334)))
 (let (($x637 (and $x335 (>= 15 ?x337))))
 (let ((?x624 (mod (+ 15 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x629 (+ input_0_net.fin_segment_data (* ?x268 ?x624))))
 (let (($x627 (<= input_0_net.fin_segment_data ?x624)))
 (let (($x622 (<= v_0_rcv_buf 0)))
 (let (($x621 (= 0 v_0_rx_slot_15)))
 (let (($x626 (and $x302 $x330 $x332 $x621 $x622 (<= ?x624 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x634 (ite $x626 (ite (or $x627 (<= ?x629 1)) (ite $x627 0 ?x629) 1) v_0_rx_slot_15)))
 (let (($x638 (or (= ?x634 0) $x637)))
 (let (($x619 (and $x335 (>= 14 ?x337))))
 (let ((?x606 (mod (+ 14 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x611 (+ input_0_net.fin_segment_data (* ?x268 ?x606))))
 (let (($x609 (<= input_0_net.fin_segment_data ?x606)))
 (let (($x604 (<= v_0_rcv_buf 1)))
 (let (($x603 (= 0 v_0_rx_slot_14)))
 (let (($x608 (and $x302 $x330 $x332 $x603 $x604 (<= ?x606 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x616 (ite $x608 (ite (or $x609 (<= ?x611 1)) (ite $x609 0 ?x611) 1) v_0_rx_slot_14)))
 (let (($x620 (or (= ?x616 0) $x619)))
 (let (($x601 (and $x335 (>= 13 ?x337))))
 (let ((?x588 (mod (+ 13 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x593 (+ input_0_net.fin_segment_data (* ?x268 ?x588))))
 (let (($x591 (<= input_0_net.fin_segment_data ?x588)))
 (let (($x586 (<= v_0_rcv_buf 2)))
 (let (($x585 (= 0 v_0_rx_slot_13)))
 (let (($x590 (and $x302 $x330 $x332 $x585 $x586 (<= ?x588 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x598 (ite $x590 (ite (or $x591 (<= ?x593 1)) (ite $x591 0 ?x593) 1) v_0_rx_slot_13)))
 (let (($x602 (or (= ?x598 0) $x601)))
 (let (($x583 (and $x335 (>= 12 ?x337))))
 (let ((?x570 (mod (+ 12 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x575 (+ input_0_net.fin_segment_data (* ?x268 ?x570))))
 (let (($x573 (<= input_0_net.fin_segment_data ?x570)))
 (let (($x568 (<= v_0_rcv_buf 3)))
 (let (($x567 (= 0 v_0_rx_slot_12)))
 (let (($x572 (and $x302 $x330 $x332 $x567 $x568 (<= ?x570 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x580 (ite $x572 (ite (or $x573 (<= ?x575 1)) (ite $x573 0 ?x575) 1) v_0_rx_slot_12)))
 (let (($x584 (or (= ?x580 0) $x583)))
 (let ((?x642 (ite $x584 12 (ite $x602 13 (ite $x620 14 (ite $x638 15 16))))))
 (let (($x565 (and $x335 (>= 11 ?x337))))
 (let ((?x552 (mod (+ 11 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x557 (+ input_0_net.fin_segment_data (* ?x268 ?x552))))
 (let (($x555 (<= input_0_net.fin_segment_data ?x552)))
 (let (($x550 (<= v_0_rcv_buf 4)))
 (let (($x549 (= 0 v_0_rx_slot_11)))
 (let (($x554 (and $x302 $x330 $x332 $x549 $x550 (<= ?x552 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x562 (ite $x554 (ite (or $x555 (<= ?x557 1)) (ite $x555 0 ?x557) 1) v_0_rx_slot_11)))
 (let (($x566 (or (= ?x562 0) $x565)))
 (let (($x547 (and $x335 (>= 10 ?x337))))
 (let ((?x534 (mod (+ 10 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x539 (+ input_0_net.fin_segment_data (* ?x268 ?x534))))
 (let (($x537 (<= input_0_net.fin_segment_data ?x534)))
 (let (($x532 (<= v_0_rcv_buf 5)))
 (let (($x531 (= 0 v_0_rx_slot_10)))
 (let (($x536 (and $x302 $x330 $x332 $x531 $x532 (<= ?x534 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x544 (ite $x536 (ite (or $x537 (<= ?x539 1)) (ite $x537 0 ?x539) 1) v_0_rx_slot_10)))
 (let (($x548 (or (= ?x544 0) $x547)))
 (let (($x529 (and $x335 (>= 9 ?x337))))
 (let ((?x516 (mod (+ 9 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x521 (+ input_0_net.fin_segment_data (* ?x268 ?x516))))
 (let (($x519 (<= input_0_net.fin_segment_data ?x516)))
 (let (($x514 (<= v_0_rcv_buf 6)))
 (let (($x513 (= 0 v_0_rx_slot_09)))
 (let (($x518 (and $x302 $x330 $x332 $x513 $x514 (<= ?x516 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x526 (ite $x518 (ite (or $x519 (<= ?x521 1)) (ite $x519 0 ?x521) 1) v_0_rx_slot_09)))
 (let (($x530 (or (= ?x526 0) $x529)))
 (let (($x511 (and $x335 (>= 8 ?x337))))
 (let ((?x498 (mod (+ 8 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x503 (+ input_0_net.fin_segment_data (* ?x268 ?x498))))
 (let (($x501 (<= input_0_net.fin_segment_data ?x498)))
 (let (($x496 (<= v_0_rcv_buf 7)))
 (let (($x495 (= 0 v_0_rx_slot_08)))
 (let (($x500 (and $x302 $x330 $x332 $x495 $x496 (<= ?x498 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x508 (ite $x500 (ite (or $x501 (<= ?x503 1)) (ite $x501 0 ?x503) 1) v_0_rx_slot_08)))
 (let (($x512 (or (= ?x508 0) $x511)))
 (let ((?x646 (ite $x512 8 (ite $x530 9 (ite $x548 10 (ite $x566 11 ?x642))))))
 (let (($x493 (and $x335 (>= 7 ?x337))))
 (let ((?x480 (mod (+ 7 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x485 (+ input_0_net.fin_segment_data (* ?x268 ?x480))))
 (let (($x483 (<= input_0_net.fin_segment_data ?x480)))
 (let (($x477 (<= v_0_rcv_buf 8)))
 (let (($x475 (= 0 v_0_rx_slot_07)))
 (let (($x482 (and $x302 $x330 $x332 $x475 $x477 (<= ?x480 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x490 (ite $x482 (ite (or $x483 (<= ?x485 1)) (ite $x483 0 ?x485) 1) v_0_rx_slot_07)))
 (let (($x494 (or (= ?x490 0) $x493)))
 (let (($x473 (and $x335 (>= 6 ?x337))))
 (let ((?x460 (mod (+ 6 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x465 (+ input_0_net.fin_segment_data (* ?x268 ?x460))))
 (let (($x463 (<= input_0_net.fin_segment_data ?x460)))
 (let (($x457 (<= v_0_rcv_buf 9)))
 (let (($x455 (= 0 v_0_rx_slot_06)))
 (let (($x462 (and $x302 $x330 $x332 $x455 $x457 (<= ?x460 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x470 (ite $x462 (ite (or $x463 (<= ?x465 1)) (ite $x463 0 ?x465) 1) v_0_rx_slot_06)))
 (let (($x474 (or (= ?x470 0) $x473)))
 (let (($x453 (and $x335 (>= 5 ?x337))))
 (let ((?x440 (mod (+ 5 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x445 (+ input_0_net.fin_segment_data (* ?x268 ?x440))))
 (let (($x443 (<= input_0_net.fin_segment_data ?x440)))
 (let (($x437 (<= v_0_rcv_buf 10)))
 (let (($x435 (= 0 v_0_rx_slot_05)))
 (let (($x442 (and $x302 $x330 $x332 $x435 $x437 (<= ?x440 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x450 (ite $x442 (ite (or $x443 (<= ?x445 1)) (ite $x443 0 ?x445) 1) v_0_rx_slot_05)))
 (let (($x454 (or (= ?x450 0) $x453)))
 (let (($x433 (and $x335 (>= 4 ?x337))))
 (let ((?x420 (mod (+ 4 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x425 (+ input_0_net.fin_segment_data (* ?x268 ?x420))))
 (let (($x423 (<= input_0_net.fin_segment_data ?x420)))
 (let (($x417 (<= v_0_rcv_buf 11)))
 (let (($x415 (= 0 v_0_rx_slot_04)))
 (let (($x422 (and $x302 $x330 $x332 $x415 $x417 (<= ?x420 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x430 (ite $x422 (ite (or $x423 (<= ?x425 1)) (ite $x423 0 ?x425) 1) v_0_rx_slot_04)))
 (let (($x434 (or (= ?x430 0) $x433)))
 (let ((?x650 (ite $x434 4 (ite $x454 5 (ite $x474 6 (ite $x494 7 ?x646))))))
 (let (($x413 (and $x335 (>= 3 ?x337))))
 (let ((?x400 (mod (+ 3 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x405 (+ input_0_net.fin_segment_data (* ?x268 ?x400))))
 (let (($x403 (<= input_0_net.fin_segment_data ?x400)))
 (let (($x397 (<= v_0_rcv_buf 12)))
 (let (($x395 (= 0 v_0_rx_slot_03)))
 (let (($x402 (and $x302 $x330 $x332 $x395 $x397 (<= ?x400 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x410 (ite $x402 (ite (or $x403 (<= ?x405 1)) (ite $x403 0 ?x405) 1) v_0_rx_slot_03)))
 (let (($x414 (or (= ?x410 0) $x413)))
 (let (($x393 (and $x335 (>= 2 ?x337))))
 (let ((?x380 (mod (+ 2 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x385 (+ input_0_net.fin_segment_data (* ?x268 ?x380))))
 (let (($x383 (<= input_0_net.fin_segment_data ?x380)))
 (let (($x377 (<= v_0_rcv_buf 13)))
 (let (($x375 (= 0 v_0_rx_slot_02)))
 (let (($x382 (and $x302 $x330 $x332 $x375 $x377 (<= ?x380 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x390 (ite $x382 (ite (or $x383 (<= ?x385 1)) (ite $x383 0 ?x385) 1) v_0_rx_slot_02)))
 (let (($x394 (or (= ?x390 0) $x393)))
 (let (($x373 (and $x335 (>= 1 ?x337))))
 (let ((?x360 (mod (+ 1 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x365 (+ input_0_net.fin_segment_data (* ?x268 ?x360))))
 (let (($x363 (<= input_0_net.fin_segment_data ?x360)))
 (let (($x358 (<= v_0_rcv_buf 14)))
 (let (($x356 (= 0 v_0_rx_slot_01)))
 (let (($x362 (and $x302 $x330 $x332 $x356 $x358 (<= ?x360 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x370 (ite $x362 (ite (or $x363 (<= ?x365 1)) (ite $x363 0 ?x365) 1) v_0_rx_slot_01)))
 (let (($x371 (= ?x370 0)))
 (let (($x374 (or $x371 $x373)))
 (let ((?x653 (ite $x374 1 (ite $x394 2 (ite $x414 3 ?x650)))))
 (let (($x354 (and $x335 (>= 0 ?x337))))
 (let ((?x271 (mod (+ v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x346 (+ input_0_net.fin_segment_data (* ?x268 ?x271))))
 (let (($x344 (<= input_0_net.fin_segment_data ?x271)))
 (let (($x340 (<= v_0_rcv_buf 15)))
 (let (($x338 (= 0 v_0_rx_slot_00)))
 (let (($x343 (and $x302 $x330 $x332 $x338 $x340 (<= ?x271 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x351 (ite $x343 (ite (or $x344 (<= ?x346 1)) (ite $x344 0 ?x346) 1) v_0_rx_slot_00)))
 (let (($x355 (or (= ?x351 0) $x354)))
 (let ((?x654 (ite $x355 0 ?x653)))
 (let ((?x657 (ite $x335 (+ ?x337 (* ?x268 ?x654)) ?x337)))
 (let (($x658 (= 0 ?x657)))
 (let (($x661 (and $x335 $x332 $x658 $x302 $x317 $x320 v_0_fin_sent $x321)))
 (let (($x1476 (= due_1_user due_0_user)))
 (let (($x709 (not v_0_rtt_ambiguous)))
 (let ((?x706 (mod (+ v_0_rtt_end (* ?x268 v_0_snd_una)) 4294967296)))
 (let (($x707 (>= ?x281 ?x706)))
 (let (($x710 (and v_0_rtt_active $x302 $x317 $x320 $x707 $x709)))
 (let ((?x725 (ite $x710 (+ now_1 (* ?x268 v_0_rtt_start_ms)) v_0_rtt_last_ms)))
 (let ((?x726 (to_real ?x725)))
 (let ((?x750 (/ 1.0 2.0)))
 (let ((?x739 (+ v_0_srtt_ms (* (- 1.0) ?x726))))
 (let ((?x746 (ite $x710 (ite (>= ?x739 0.0) ?x739 (+ (* (- 1.0) v_0_srtt_ms) ?x726)) v_0_rtt_error_ms)))
 (let ((?x737 (/ 1.0 4.0)))
 (let ((?x752 (ite v_0_rtt_measured (+ (* (/ 3.0 4.0) v_0_rttvar_ms) (* ?x737 ?x746)) (* ?x750 ?x726))))
 (let ((?x753 (ite $x710 ?x752 v_0_rttvar_ms)))
 (let ((?x713 (- 1.0)))
 (let ((?x729 (ite v_0_rtt_measured (+ (* (/ 7.0 8.0) v_0_srtt_ms) (* (/ 1.0 8.0) ?x726)) ?x726)))
 (let ((?x730 (ite $x710 ?x729 v_0_srtt_ms)))
 (let ((?x758 (+ (* ?x713 ?x730) (* ?x713 (ite (<= ?x753 ?x737) 1.0 (* 4.0 ?x753))))))
 (let ((?x759 (to_int ?x758)))
 (let ((?x764 (ite (<= ?x759 (- 1000)) (* ?x268 ?x759) 1000)))
 (let ((?x766 (ite (<= 60000 ?x764) 60000 ?x764)))
 (let ((?x768 (ite $x710 ?x766 v_0_rto_ms)))
 (let (($x322 (and $x302 $x317 $x320 v_0_fin_sent $x321)))
 (let (($x323 (not $x322)))
 (let (($x1093 (and $x323 v_0_fin_sent)))
 (let ((?x793 (ite (<= 0 v_0_rtx_buf) v_0_rtx_buf 0)))
 (let ((?x791 (ite (<= v_0_rtx_buf ?x281) 0 (+ v_0_rtx_buf (* ?x268 ?x281)))))
 (let (($x665 (and $x302 $x317 $x320)))
 (let ((?x796 (ite $x665 (ite (<= ?x791 ?x793) ?x791 ?x793) v_0_rtx_buf)))
 (let ((?x1455 (+ ?x796 (ite $x1093 1 0))))
 (let (($x1457 (and $x302 $x317 $x320 (<= 1 ?x1455))))
 (let (($x1462 (or $x1457 (and (not (and $x302 $x317 $x320 (= 0 ?x1455))) active_0_rtx))))
 (let (($x662 (not $x661)))
 (let (($x1452 (not v_1_syn_timeout_eligible)))
 (let (($x1450 (not v_1_tx_syn_pending)))
 (let (($x1448 (= v_1_tx_syn_time 0)))
 (let (($x1446 (not v_1_tx_waiting)))
 (let (($x1444 (= v_1_tx_is_fin v_0_tx_is_fin)))
 (let (($x1441 (= v_1_tx_previous_rto v_0_tx_previous_rto)))
 (let (($x1438 (= v_1_tx_elapsed v_0_tx_elapsed)))
 (let (($x1435 (not v_1_tx_retransmitted)))
 (let (($x1433 (= v_1_tx_max_previous v_0_tx_max_previous)))
 (let (($x1430 (= v_1_tx_eligible v_0_tx_eligible)))
 (let (($x1427 (= v_1_tx_emit_count v_0_tx_emit_count)))
 (let (($x1177 (and $x302 $x317 $x320 (not (= 0 ?x281)))))
 (let (($x1173 (= 0 ?x796)))
 (let (($x1420 (= v_1_tx_time_15 (ite (or (>= 15 ?x796) $x1173 $x1177) 0 v_0_tx_time_15))))
 (let ((?x1414 (ite (or (>= 14 ?x796) $x1173) 0 (ite $x1177 (ite (= 1 ?x281) v_0_tx_time_15 0) v_0_tx_time_14))))
 (let (($x1178 (= 1 ?x281)))
 (let ((?x1406 (ite $x1177 (ite $x1178 v_0_tx_time_14 (ite (= 2 ?x281) v_0_tx_time_15 0)) v_0_tx_time_13)))
 (let (($x1180 (= 2 ?x281)))
 (let ((?x1397 (ite $x1178 v_0_tx_time_13 (ite $x1180 v_0_tx_time_14 (ite (= 3 ?x281) v_0_tx_time_15 0)))))
 (let (($x1400 (= v_1_tx_time_12 (ite (or $x1173 (>= 12 ?x796)) 0 (ite $x1177 ?x1397 v_0_tx_time_12)))))
 (let (($x1182 (= 3 ?x281)))
 (let ((?x1387 (ite $x1180 v_0_tx_time_13 (ite $x1182 v_0_tx_time_14 (ite (= 4 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1390 (ite (or (>= 11 ?x796) $x1173) 0 (ite $x1177 (ite $x1178 v_0_tx_time_12 ?x1387) v_0_tx_time_11))))
 (let (($x1184 (= 4 ?x281)))
 (let ((?x1376 (ite $x1182 v_0_tx_time_13 (ite $x1184 v_0_tx_time_14 (ite (= 5 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1379 (ite $x1177 (ite $x1178 v_0_tx_time_11 (ite $x1180 v_0_tx_time_12 ?x1376)) v_0_tx_time_10)))
 (let (($x1186 (= 5 ?x281)))
 (let ((?x1364 (ite $x1184 v_0_tx_time_13 (ite $x1186 v_0_tx_time_14 (ite (= 6 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1367 (ite $x1178 v_0_tx_time_10 (ite $x1180 v_0_tx_time_11 (ite $x1182 v_0_tx_time_12 ?x1364)))))
 (let (($x1370 (= v_1_tx_time_09 (ite (or (>= 9 ?x796) $x1173) 0 (ite $x1177 ?x1367 v_0_tx_time_09)))))
 (let (($x1188 (= 6 ?x281)))
 (let ((?x1351 (ite $x1186 v_0_tx_time_13 (ite $x1188 v_0_tx_time_14 (ite (= 7 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1354 (ite $x1180 v_0_tx_time_10 (ite $x1182 v_0_tx_time_11 (ite $x1184 v_0_tx_time_12 ?x1351)))))
 (let ((?x1357 (ite (or (>= 8 ?x796) $x1173) 0 (ite $x1177 (ite $x1178 v_0_tx_time_09 ?x1354) v_0_tx_time_08))))
 (let (($x1190 (= 7 ?x281)))
 (let ((?x1337 (ite $x1188 v_0_tx_time_13 (ite $x1190 v_0_tx_time_14 (ite (= 8 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1340 (ite $x1182 v_0_tx_time_10 (ite $x1184 v_0_tx_time_11 (ite $x1186 v_0_tx_time_12 ?x1337)))))
 (let ((?x1343 (ite $x1177 (ite $x1178 v_0_tx_time_08 (ite $x1180 v_0_tx_time_09 ?x1340)) v_0_tx_time_07)))
 (let (($x1192 (= 8 ?x281)))
 (let ((?x1322 (ite $x1190 v_0_tx_time_13 (ite $x1192 v_0_tx_time_14 (ite (= 9 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1325 (ite $x1184 v_0_tx_time_10 (ite $x1186 v_0_tx_time_11 (ite $x1188 v_0_tx_time_12 ?x1322)))))
 (let ((?x1328 (ite $x1178 v_0_tx_time_07 (ite $x1180 v_0_tx_time_08 (ite $x1182 v_0_tx_time_09 ?x1325)))))
 (let (($x1331 (= v_1_tx_time_06 (ite (or (>= 6 ?x796) $x1173) 0 (ite $x1177 ?x1328 v_0_tx_time_06)))))
 (let (($x1194 (= 9 ?x281)))
 (let ((?x1306 (ite $x1192 v_0_tx_time_13 (ite $x1194 v_0_tx_time_14 (ite (= 10 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1309 (ite $x1186 v_0_tx_time_10 (ite $x1188 v_0_tx_time_11 (ite $x1190 v_0_tx_time_12 ?x1306)))))
 (let ((?x1312 (ite $x1180 v_0_tx_time_07 (ite $x1182 v_0_tx_time_08 (ite $x1184 v_0_tx_time_09 ?x1309)))))
 (let ((?x1315 (ite (or $x1173 (>= 5 ?x796)) 0 (ite $x1177 (ite $x1178 v_0_tx_time_06 ?x1312) v_0_tx_time_05))))
 (let (($x1196 (= 10 ?x281)))
 (let ((?x1289 (ite $x1194 v_0_tx_time_13 (ite $x1196 v_0_tx_time_14 (ite (= 11 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1292 (ite $x1188 v_0_tx_time_10 (ite $x1190 v_0_tx_time_11 (ite $x1192 v_0_tx_time_12 ?x1289)))))
 (let ((?x1295 (ite $x1182 v_0_tx_time_07 (ite $x1184 v_0_tx_time_08 (ite $x1186 v_0_tx_time_09 ?x1292)))))
 (let ((?x1298 (ite $x1177 (ite $x1178 v_0_tx_time_05 (ite $x1180 v_0_tx_time_06 ?x1295)) v_0_tx_time_04)))
 (let (($x1198 (= 11 ?x281)))
 (let ((?x1271 (ite $x1196 v_0_tx_time_13 (ite $x1198 v_0_tx_time_14 (ite (= 12 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1274 (ite $x1190 v_0_tx_time_10 (ite $x1192 v_0_tx_time_11 (ite $x1194 v_0_tx_time_12 ?x1271)))))
 (let ((?x1277 (ite $x1184 v_0_tx_time_07 (ite $x1186 v_0_tx_time_08 (ite $x1188 v_0_tx_time_09 ?x1274)))))
 (let ((?x1280 (ite $x1178 v_0_tx_time_04 (ite $x1180 v_0_tx_time_05 (ite $x1182 v_0_tx_time_06 ?x1277)))))
 (let (($x1283 (= v_1_tx_time_03 (ite (or $x1173 (>= 3 ?x796)) 0 (ite $x1177 ?x1280 v_0_tx_time_03)))))
 (let (($x1200 (= 12 ?x281)))
 (let ((?x1252 (ite $x1198 v_0_tx_time_13 (ite $x1200 v_0_tx_time_14 (ite (= 13 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1255 (ite $x1192 v_0_tx_time_10 (ite $x1194 v_0_tx_time_11 (ite $x1196 v_0_tx_time_12 ?x1252)))))
 (let ((?x1258 (ite $x1186 v_0_tx_time_07 (ite $x1188 v_0_tx_time_08 (ite $x1190 v_0_tx_time_09 ?x1255)))))
 (let ((?x1261 (ite $x1180 v_0_tx_time_04 (ite $x1182 v_0_tx_time_05 (ite $x1184 v_0_tx_time_06 ?x1258)))))
 (let ((?x1264 (ite (or $x1173 (>= 2 ?x796)) 0 (ite $x1177 (ite $x1178 v_0_tx_time_03 ?x1261) v_0_tx_time_02))))
 (let (($x1202 (= 13 ?x281)))
 (let ((?x1232 (ite $x1200 v_0_tx_time_13 (ite $x1202 v_0_tx_time_14 (ite (= 14 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1235 (ite $x1194 v_0_tx_time_10 (ite $x1196 v_0_tx_time_11 (ite $x1198 v_0_tx_time_12 ?x1232)))))
 (let ((?x1238 (ite $x1188 v_0_tx_time_07 (ite $x1190 v_0_tx_time_08 (ite $x1192 v_0_tx_time_09 ?x1235)))))
 (let ((?x1241 (ite $x1182 v_0_tx_time_04 (ite $x1184 v_0_tx_time_05 (ite $x1186 v_0_tx_time_06 ?x1238)))))
 (let ((?x1244 (ite $x1177 (ite $x1178 v_0_tx_time_02 (ite $x1180 v_0_tx_time_03 ?x1241)) v_0_tx_time_01)))
 (let (($x1204 (= 14 ?x281)))
 (let ((?x1210 (ite $x1202 v_0_tx_time_13 (ite $x1204 v_0_tx_time_14 (ite (= 15 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1213 (ite $x1196 v_0_tx_time_10 (ite $x1198 v_0_tx_time_11 (ite $x1200 v_0_tx_time_12 ?x1210)))))
 (let ((?x1216 (ite $x1190 v_0_tx_time_07 (ite $x1192 v_0_tx_time_08 (ite $x1194 v_0_tx_time_09 ?x1213)))))
 (let ((?x1219 (ite $x1184 v_0_tx_time_04 (ite $x1186 v_0_tx_time_05 (ite $x1188 v_0_tx_time_06 ?x1216)))))
 (let ((?x1222 (ite $x1178 v_0_tx_time_01 (ite $x1180 v_0_tx_time_02 (ite $x1182 v_0_tx_time_03 ?x1219)))))
 (let (($x1226 (= v_1_tx_time_00 (ite (or $x1173 (>= 0 ?x796)) 0 (ite $x1177 ?x1222 v_0_tx_time_00)))))
 (let (($x1160 (= v_1_rtt_sample_was_ambiguous (and v_0_rtt_active v_0_rtt_ambiguous))))
 (let (($x1155 (not v_1_rtt_start_new)))
 (let ((?x789 (* ?x268 ?x281)))
 (let ((?x1147 (+ ?x706 ?x789)))
 (let (($x1150 (and v_0_rtt_active $x302 $x317 $x320 (not (<= v_0_rtt_remaining ?x1147)))))
 (let (($x1135 (and v_0_rtt_active $x302 $x317 $x320 $x707)))
 (let (($x1153 (= v_1_rtt_remaining (ite $x1135 0 (ite $x1150 ?x1147 v_0_rtt_remaining)))))
 (let (($x1144 (= v_1_rtt_end v_0_rtt_end)))
 (let (($x1143 (= v_1_rtt_start_ms v_0_rtt_start_ms)))
 (let (($x1133 (= v_1_rtt_previous_measured (ite $x710 v_0_rtt_measured v_0_rtt_previous_measured))))
 (let (($x1126 (= v_1_rtt_previous_var (ite $x710 v_0_rttvar_ms v_0_rtt_previous_var))))
 (let (($x1122 (= v_1_rtt_previous_srtt (ite $x710 v_0_srtt_ms v_0_rtt_previous_srtt))))
 (let ((?x1102 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data) 4294967296)))
 (let (($x1095 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x1091 (= v_1_fin_requested v_0_fin_requested)))
 (let (($x813 (<= 2147483648 (mod (+ input_0_net.fin_segment_ack (* ?x268 v_0_snd_wl2)) 4294967296))))
 (let (($x809 (= v_0_snd_wl1 input_0_net.fin_segment_seq)))
 (let ((?x803 (mod (+ input_0_net.fin_segment_seq (* ?x268 v_0_snd_wl1)) 4294967296)))
 (let (($x816 (or (and (not (<= ?x803 0)) (not (<= 2147483648 ?x803))) (and $x809 (not $x813)))))
 (let (($x817 (and $x302 $x320 $x816)))
 (let ((?x1069 (ite (or (and $x335 $x332 $x658) (not (and $x355 (not $x637)))) 0 ?x634)))
 (let (($x885 (not $x637)))
 (let (($x689 (not $x355)))
 (let (($x854 (not $x394)))
 (let (($x852 (not $x414)))
 (let (($x850 (not $x434)))
 (let (($x848 (not $x454)))
 (let (($x846 (not $x474)))
 (let (($x844 (not $x494)))
 (let (($x842 (not $x512)))
 (let (($x840 (not $x530)))
 (let (($x838 (not $x548)))
 (let (($x836 (not $x566)))
 (let (($x834 (not $x584)))
 (let (($x832 (not $x602)))
 (let (($x830 (not $x620)))
 (let (($x829 (and false $x638)))
 (let (($x831 (and $x829 $x830)))
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
 (let (($x856 (or $x373 $x371 (and $x853 $x854))))
 (let ((?x683 (ite $x619 0 ?x616)))
 (let (($x659 (and $x335 $x332 $x658)))
 (let (($x1065 (= v_1_rx_slot_14 (ite $x659 0 (ite $x355 ?x683 (ite (and $x856 $x689 $x885) ?x634 0))))))
 (let (($x857 (and $x856 $x689)))
 (let ((?x1057 (ite $x857 ?x683 (ite (and (or $x853 $x394) (not $x374) $x689 $x885) ?x634 0))))
 (let ((?x682 (ite $x601 0 ?x598)))
 (let (($x859 (not $x374)))
 (let (($x858 (or $x853 $x394)))
 (let (($x860 (and $x858 $x859 $x689)))
 (let ((?x1050 (ite $x860 ?x683 (ite (and (or $x851 $x414) $x854 $x859 $x689 $x885) ?x634 0))))
 (let ((?x681 (ite $x583 0 ?x580)))
 (let (($x1054 (= v_1_rx_slot_12 (ite $x659 0 (ite $x355 ?x681 (ite $x857 ?x682 ?x1050))))))
 (let (($x861 (or $x851 $x414)))
 (let (($x862 (and $x861 $x854 $x859 $x689)))
 (let ((?x1042 (ite $x862 ?x683 (ite (and (or $x849 $x434) $x852 $x854 $x859 $x689 $x885) ?x634 0))))
 (let ((?x680 (ite $x565 0 ?x562)))
 (let (($x1047 (= v_1_rx_slot_11 (ite $x659 0 (ite $x355 ?x680 (ite $x857 ?x681 (ite $x860 ?x682 ?x1042)))))))
 (let (($x863 (or $x849 $x434)))
 (let (($x864 (and $x863 $x852 $x854 $x859 $x689)))
 (let ((?x1033 (ite $x864 ?x683 (ite (and (or $x847 $x454) $x850 $x852 $x854 $x859 $x689 $x885) ?x634 0))))
 (let ((?x679 (ite $x547 0 ?x544)))
 (let ((?x1038 (ite $x659 0 (ite $x355 ?x679 (ite $x857 ?x680 (ite $x860 ?x681 (ite $x862 ?x682 ?x1033)))))))
 (let ((?x1022 (ite (and (or $x845 $x474) $x848 $x850 $x852 $x854 $x859 $x689 $x885) ?x634 0)))
 (let (($x865 (or $x847 $x454)))
 (let (($x866 (and $x865 $x850 $x852 $x854 $x859 $x689)))
 (let ((?x1027 (ite $x857 ?x679 (ite $x860 ?x680 (ite $x862 ?x681 (ite $x864 ?x682 (ite $x866 ?x683 ?x1022)))))))
 (let ((?x678 (ite $x529 0 ?x526)))
 (let ((?x1011 (ite (and (or $x843 $x494) $x846 $x848 $x850 $x852 $x854 $x859 $x689 $x885) ?x634 0)))
 (let (($x867 (or $x845 $x474)))
 (let (($x868 (and $x867 $x848 $x850 $x852 $x854 $x859 $x689)))
 (let ((?x1016 (ite $x860 ?x679 (ite $x862 ?x680 (ite $x864 ?x681 (ite $x866 ?x682 (ite $x868 ?x683 ?x1011)))))))
 (let ((?x677 (ite $x511 0 ?x508)))
 (let (($x1020 (= v_1_rx_slot_08 (ite $x659 0 (ite $x355 ?x677 (ite $x857 ?x678 ?x1016))))))
 (let ((?x999 (ite (and (or $x841 $x512) $x844 $x846 $x848 $x850 $x852 $x854 $x859 $x689 $x885) ?x634 0)))
 (let (($x869 (or $x843 $x494)))
 (let (($x870 (and $x869 $x846 $x848 $x850 $x852 $x854 $x859 $x689)))
 (let ((?x1004 (ite $x862 ?x679 (ite $x864 ?x680 (ite $x866 ?x681 (ite $x868 ?x682 (ite $x870 ?x683 ?x999)))))))
 (let ((?x676 (ite $x493 0 ?x490)))
 (let (($x1009 (= v_1_rx_slot_07 (ite $x659 0 (ite $x355 ?x676 (ite $x857 ?x677 (ite $x860 ?x678 ?x1004)))))))
 (let (($x873 (or $x839 $x530)))
 (let ((?x986 (ite (and $x873 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x859 $x689 $x885) ?x634 0)))
 (let (($x871 (or $x841 $x512)))
 (let (($x872 (and $x871 $x844 $x846 $x848 $x850 $x852 $x854 $x859 $x689)))
 (let ((?x991 (ite $x864 ?x679 (ite $x866 ?x680 (ite $x868 ?x681 (ite $x870 ?x682 (ite $x872 ?x683 ?x986)))))))
 (let ((?x675 (ite $x473 0 ?x470)))
 (let ((?x996 (ite $x659 0 (ite $x355 ?x675 (ite $x857 ?x676 (ite $x860 ?x677 (ite $x862 ?x678 ?x991)))))))
 (let (($x875 (or $x837 $x548)))
 (let ((?x972 (ite (and $x875 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x859 $x689 $x885) ?x634 0)))
 (let (($x874 (and $x873 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x859 $x689)))
 (let ((?x977 (ite $x866 ?x679 (ite $x868 ?x680 (ite $x870 ?x681 (ite $x872 ?x682 (ite $x874 ?x683 ?x972)))))))
 (let ((?x674 (ite $x453 0 ?x450)))
 (let ((?x982 (ite $x355 ?x674 (ite $x857 ?x675 (ite $x860 ?x676 (ite $x862 ?x677 (ite $x864 ?x678 ?x977)))))))
 (let (($x877 (or $x835 $x566)))
 (let (($x956 (and $x877 $x838 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x859 $x689 $x885)))
 (let (($x876 (and $x875 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x859 $x689)))
 (let ((?x961 (ite $x870 ?x680 (ite $x872 ?x681 (ite $x874 ?x682 (ite $x876 ?x683 (ite $x956 ?x634 0)))))))
 (let ((?x966 (ite $x860 ?x675 (ite $x862 ?x676 (ite $x864 ?x677 (ite $x866 ?x678 (ite $x868 ?x679 ?x961)))))))
 (let ((?x673 (ite $x433 0 ?x430)))
 (let (($x970 (= v_1_rx_slot_04 (ite $x659 0 (ite $x355 ?x673 (ite $x857 ?x674 ?x966))))))
 (let (($x879 (or $x833 $x584)))
 (let (($x940 (and $x879 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x859 $x689 $x885)))
 (let (($x878 (and $x877 $x838 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x859 $x689)))
 (let ((?x945 (ite $x872 ?x680 (ite $x874 ?x681 (ite $x876 ?x682 (ite $x878 ?x683 (ite $x940 ?x634 0)))))))
 (let ((?x950 (ite $x862 ?x675 (ite $x864 ?x676 (ite $x866 ?x677 (ite $x868 ?x678 (ite $x870 ?x679 ?x945)))))))
 (let ((?x672 (ite $x413 0 ?x410)))
 (let (($x955 (= v_1_rx_slot_03 (ite $x659 0 (ite $x355 ?x672 (ite $x857 ?x673 (ite $x860 ?x674 ?x950)))))))
 (let (($x881 (or $x831 $x602)))
 (let (($x923 (and $x881 $x834 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x859 $x689 $x885)))
 (let (($x880 (and $x879 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x859 $x689)))
 (let ((?x928 (ite $x874 ?x680 (ite $x876 ?x681 (ite $x878 ?x682 (ite $x880 ?x683 (ite $x923 ?x634 0)))))))
 (let ((?x933 (ite $x864 ?x675 (ite $x866 ?x676 (ite $x868 ?x677 (ite $x870 ?x678 (ite $x872 ?x679 ?x928)))))))
 (let ((?x671 (ite $x393 0 ?x390)))
 (let ((?x938 (ite $x659 0 (ite $x355 ?x671 (ite $x857 ?x672 (ite $x860 ?x673 (ite $x862 ?x674 ?x933)))))))
 (let (($x883 (or $x829 $x620)))
 (let (($x905 (and $x883 $x832 $x834 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x859 $x689 $x885)))
 (let (($x882 (and $x881 $x834 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x859 $x689)))
 (let ((?x910 (ite $x876 ?x680 (ite $x878 ?x681 (ite $x880 ?x682 (ite $x882 ?x683 (ite $x905 ?x634 0)))))))
 (let ((?x915 (ite $x866 ?x675 (ite $x868 ?x676 (ite $x870 ?x677 (ite $x872 ?x678 (ite $x874 ?x679 ?x910)))))))
 (let ((?x670 (ite $x373 0 ?x370)))
 (let ((?x920 (ite $x355 ?x670 (ite $x857 ?x671 (ite $x860 ?x672 (ite $x862 ?x673 (ite $x864 ?x674 ?x915)))))))
 (let (($x886 (and $x638 $x830 $x832 $x834 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x859 $x689 $x885)))
 (let (($x884 (and $x883 $x832 $x834 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x859 $x689)))
 (let ((?x891 (ite $x878 ?x680 (ite $x880 ?x681 (ite $x882 ?x682 (ite $x884 ?x683 (ite $x886 ?x634 0)))))))
 (let ((?x896 (ite $x868 ?x675 (ite $x870 ?x676 (ite $x872 ?x677 (ite $x874 ?x678 (ite $x876 ?x679 ?x891)))))))
 (let ((?x901 (ite $x857 ?x670 (ite $x860 ?x671 (ite $x862 ?x672 (ite $x864 ?x673 (ite $x866 ?x674 ?x896)))))))
 (let ((?x669 (ite $x354 0 ?x351)))
 (let ((?x691 (ite (and (<= 0 ?x654) $x689) ?x653 0)))
 (let ((?x685 (+ ?x669 ?x670 ?x671 ?x672 ?x673 ?x674 ?x675 ?x676 ?x677 ?x678 ?x679 ?x680 ?x681 ?x682 ?x683 (ite $x637 0 ?x634))))
 (let ((?x687 (ite (<= ?x685 0) 0 ?x685)))
 (let ((?x693 (ite (<= ?x687 ?x691) ?x687 ?x691)))
 (let (($x827 (= v_1_take v_0_take)))
 (let (($x787 (= v_1_snd_buf v_0_snd_buf)))
 (let (($x781 (= v_1_msl_ms v_0_msl_ms)))
 (let (($x778 (= v_1_user_timeout_ms v_0_user_timeout_ms)))
 (let (($x775 (= v_1_active_open v_0_active_open)))
 (let (($x772 (= v_1_retries v_0_retries)))
 (let (($x702 (= v_1_tx_flags v_0_tx_flags)))
 (let (($x699 (= v_1_tx_ack v_0_tx_ack)))
 (let (($x698 (= v_1_tx_seq v_0_tx_seq)))
 (let (($x697 (= v_1_rcv_nxt (mod (+ v_0_rcv_nxt ?x693 (ite $x659 1 0)) 4294967296))))
 (let (($x668 (= v_1_snd_nxt v_0_snd_nxt)))
 (let (($x664 (= v_1_irs v_0_irs)))
 (let (($x663 (= v_1_iss v_0_iss)))
 (let (($x660 (not $x659)))
 (let (($x307 (= 0 ?x281)))
 (let (($x306 (not v_0_fin_sent)))
 (let (($x287 (= (mod (+ input_0_net.fin_segment_ack (* ?x268 v_0_snd_nxt)) 4294967296) 2147483648)))
 (and (>= now_1 now_0) (<= 0 input_0_net.fin_segment_data) (>= 16 input_0_net.fin_segment_data) (not (= ?x271 2147483648)) (<= 0 input_0_net.fin_segment_window) (>= 65535 input_0_net.fin_segment_window) (or (and (not (= ?x281 2147483648)) (not $x287)) (not $x302)) $x306 $x307 (or (not active_0_rtx) (not (<= due_0_rtx now_1))) (or (not active_0_user) (not (<= due_0_user now_1))) (or (not active_0_time_wait) (not (<= due_0_time_wait now_1))) $x323 $x660 $x662 $x663 $x664 (= v_1_snd_una (ite $x665 input_0_net.fin_segment_ack v_0_snd_una)) $x668 $x697 $x698 $x699 $x702 (= v_1_rto_ms ?x768) $x772 $x775 $x778 $x781 (= v_1_local_window (+ 16 (* ?x268 v_0_rcv_buf) (* ?x268 ?x693))) $x787 (= v_1_rtx_buf ?x796) (= v_1_rcv_buf (+ v_0_rcv_buf ?x693)) (= v_1_snd_wnd (ite $x817 input_0_net.fin_segment_window v_0_snd_wnd)) (= v_1_snd_wl1 (ite $x817 input_0_net.fin_segment_seq v_0_snd_wl1)) (= v_1_snd_wl2 (ite $x817 input_0_net.fin_segment_ack v_0_snd_wl2)) $x827 (= v_1_rx_chunk ?x693) (= v_1_rx_slot_00 (ite $x659 0 (ite $x355 ?x669 ?x901))) (= v_1_rx_slot_01 (ite $x659 0 ?x920)) (= v_1_rx_slot_02 ?x938) $x955 $x970 (= v_1_rx_slot_05 (ite $x659 0 ?x982)) (= v_1_rx_slot_06 ?x996) $x1009 $x1020 (= v_1_rx_slot_09 (ite $x659 0 (ite $x355 ?x678 ?x1027))) (= v_1_rx_slot_10 ?x1038) $x1047 $x1054 (= v_1_rx_slot_13 (ite $x659 0 (ite $x355 ?x682 ?x1057))) $x1065 (= v_1_rx_slot_15 ?x1069) (= v_1_rx_advance ?x654) (= v_1_rx_acceptable (and $x302 $x330 $x332)) (= v_1_seg_acceptable $x302) (= v_1_ack_delta ?x281) (= v_1_ack_is_new (and $x317 $x320)) (= v_1_ack_is_future $x329) (= v_1_ack_advance $x665) (= v_1_ack_window_update $x817) $x1091 (= v_1_fin_sent $x1093) $x1095 (= v_1_fin_acknowledged $x322) (= v_1_rx_fin_pending (and $x335 $x660)) (= v_1_rx_fin_seq (ite $x334 ?x1102 v_0_rx_fin_seq)) (= v_1_rx_fin_offset (ite $x659 0 ?x657)) (= v_1_rx_fin_done (or v_0_rx_fin_done $x659)) (= v_1_rx_fin_consumed $x659) (= v_1_srtt_ms ?x730) (= v_1_rttvar_ms ?x753) (= v_1_rtt_error_ms ?x746) $x1122 $x1126 (= v_1_rtt_measured (or v_0_rtt_measured $x710)) $x1133 (= v_1_rtt_active (and v_0_rtt_active (not $x1135))) (= v_1_rtt_ambiguous (and (not $x1135) v_0_rtt_ambiguous)) $x1143 $x1144 $x1153 $x1155 (= v_1_rtt_sample_used $x710) $x1160 (= v_1_rtt_last_ms ?x725) (= v_1_rtt_samples (+ v_0_rtt_samples (ite $x710 1 0))) (= v_1_rto_base_ms (ite $x710 ?x766 v_0_rto_base_ms)) $x1226 (= v_1_tx_time_01 (ite (or (>= 1 ?x796) $x1173) 0 ?x1244)) (= v_1_tx_time_02 ?x1264) $x1283 (= v_1_tx_time_04 (ite (or $x1173 (>= 4 ?x796)) 0 ?x1298)) (= v_1_tx_time_05 ?x1315) $x1331 (= v_1_tx_time_07 (ite (or (>= 7 ?x796) $x1173) 0 ?x1343)) (= v_1_tx_time_08 ?x1357) $x1370 (= v_1_tx_time_10 (ite (or (>= 10 ?x796) $x1173) 0 ?x1379)) (= v_1_tx_time_11 ?x1390) $x1400 (= v_1_tx_time_13 (ite (or (>= 13 ?x796) $x1173) 0 ?x1406)) (= v_1_tx_time_14 ?x1414) $x1420 (= v_1_tx_fin_time (ite $x1093 v_0_tx_fin_time 0)) $x1427 $x1430 $x1433 $x1435 $x1438 $x1441 $x1444 $x1446 $x1448 $x1450 $x1452 (= active_1_rtx (and $x662 $x1462)) (= active_1_user (and $x662 active_0_user)) (= active_1_time_wait (or active_0_time_wait $x661)) (= due_1_rtx (ite $x1457 (+ now_1 ?x768) due_0_rtx)) $x1476 (= due_1_time_wait (ite $x661 ?x1479 due_0_time_wait))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
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
 (let ((?x1487 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1487)))
(assert
 (>= 16 v_0_rcv_buf))
(assert
 (and (<= 0 v_0_snd_wnd) (>= 65535 v_0_snd_wnd)))
(assert
 (= v_0_local_window (+ 16 (* (- 1) v_0_rcv_buf))))
(assert
 (>= 1 v_0_rx_slot_00))
(assert
 (let (($x338 (= 0 v_0_rx_slot_00)))
 (let (($x1497 (not (>= v_0_rcv_buf 16))))
 (or $x1497 $x338))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x356 (= 0 v_0_rx_slot_01)))
 (let (($x1501 (not (>= v_0_rcv_buf 15))))
 (or $x1501 $x356))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x375 (= 0 v_0_rx_slot_02)))
 (let (($x1505 (not (>= v_0_rcv_buf 14))))
 (or $x1505 $x375))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x395 (= 0 v_0_rx_slot_03)))
 (let (($x1509 (not (>= v_0_rcv_buf 13))))
 (or $x1509 $x395))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x415 (= 0 v_0_rx_slot_04)))
 (let (($x1513 (not (>= v_0_rcv_buf 12))))
 (or $x1513 $x415))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x435 (= 0 v_0_rx_slot_05)))
 (let (($x1517 (not (>= v_0_rcv_buf 11))))
 (or $x1517 $x435))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x455 (= 0 v_0_rx_slot_06)))
 (let (($x1521 (not (>= v_0_rcv_buf 10))))
 (or $x1521 $x455))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x475 (= 0 v_0_rx_slot_07)))
 (let (($x1525 (not (>= v_0_rcv_buf 9))))
 (or $x1525 $x475))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x495 (= 0 v_0_rx_slot_08)))
 (let (($x1529 (not (>= v_0_rcv_buf 8))))
 (or $x1529 $x495))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x513 (= 0 v_0_rx_slot_09)))
 (let (($x1533 (not (>= v_0_rcv_buf 7))))
 (or $x1533 $x513))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x531 (= 0 v_0_rx_slot_10)))
 (let (($x1537 (not (>= v_0_rcv_buf 6))))
 (or $x1537 $x531))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x549 (= 0 v_0_rx_slot_11)))
 (let (($x1541 (not (>= v_0_rcv_buf 5))))
 (or $x1541 $x549))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x567 (= 0 v_0_rx_slot_12)))
 (let (($x1545 (not (>= v_0_rcv_buf 4))))
 (or $x1545 $x567))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x585 (= 0 v_0_rx_slot_13)))
 (let (($x1549 (not (>= v_0_rcv_buf 3))))
 (or $x1549 $x585))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x603 (= 0 v_0_rx_slot_14)))
 (let (($x1553 (not (>= v_0_rcv_buf 2))))
 (or $x1553 $x603))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x621 (= 0 v_0_rx_slot_15)))
 (let (($x1557 (not (>= v_0_rcv_buf 1))))
 (or $x1557 $x621))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x1559 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x1559)))
(assert
 (and (<= 0 v_0_rx_advance) (>= 16 v_0_rx_advance)))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (and (<= 0 v_0_ack_delta) (>= 4294967295 v_0_ack_delta)))
(assert
 true)
(assert
 (let ((?x1572 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x1572)))
(assert
 (= active_0_rtx (<= 1 (+ v_0_rtx_buf (ite v_0_fin_sent 1 0)))))
(assert
 (let (($x1580 (and v_0_fin_requested (= v_0_fin_seq (mod (+ v_0_snd_una v_0_rtx_buf) 4294967296)) (= 0 v_0_snd_buf))))
 (let (($x306 (not v_0_fin_sent)))
 (or $x306 $x1580))))
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
 (let (($x332 (not v_0_rx_fin_done)))
 (let (($x1584 (and $x332 $x1582 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window)))))
 (let (($x333 (not v_0_rx_fin_pending)))
 (or $x333 $x1584))))))
(assert
 (let (($x1587 (>= 15 v_0_rx_fin_offset)))
 (and (<= 0 v_0_rx_fin_offset) $x1587 (= v_0_rx_fin_pending (<= 1 v_0_rx_fin_offset)))))
(assert
 (let (($x333 (not v_0_rx_fin_pending)))
 (or $x333 (= v_0_rx_fin_seq (mod (+ v_0_rcv_nxt v_0_rx_fin_offset) 4294967296)))))
(assert
 (let (($x332 (not v_0_rx_fin_done)))
 (or $x332 (= v_0_rcv_nxt (mod (+ 1 v_0_rx_fin_seq) 4294967296)))))
(assert
 (let (($x338 (= 0 v_0_rx_slot_00)))
 (or (not (and v_0_rx_fin_pending (>= 0 v_0_rx_fin_offset))) $x338)))
(assert
 (let (($x356 (= 0 v_0_rx_slot_01)))
 (or (not (and v_0_rx_fin_pending (>= 1 v_0_rx_fin_offset))) $x356)))
(assert
 (let (($x375 (= 0 v_0_rx_slot_02)))
 (or (not (and v_0_rx_fin_pending (>= 2 v_0_rx_fin_offset))) $x375)))
(assert
 (let (($x395 (= 0 v_0_rx_slot_03)))
 (or (not (and v_0_rx_fin_pending (>= 3 v_0_rx_fin_offset))) $x395)))
(assert
 (let (($x415 (= 0 v_0_rx_slot_04)))
 (or (not (and v_0_rx_fin_pending (>= 4 v_0_rx_fin_offset))) $x415)))
(assert
 (let (($x435 (= 0 v_0_rx_slot_05)))
 (or (not (and v_0_rx_fin_pending (>= 5 v_0_rx_fin_offset))) $x435)))
(assert
 (let (($x455 (= 0 v_0_rx_slot_06)))
 (or (not (and v_0_rx_fin_pending (>= 6 v_0_rx_fin_offset))) $x455)))
(assert
 (let (($x475 (= 0 v_0_rx_slot_07)))
 (or (not (and v_0_rx_fin_pending (>= 7 v_0_rx_fin_offset))) $x475)))
(assert
 (let (($x495 (= 0 v_0_rx_slot_08)))
 (or (not (and v_0_rx_fin_pending (>= 8 v_0_rx_fin_offset))) $x495)))
(assert
 (let (($x513 (= 0 v_0_rx_slot_09)))
 (or (not (and v_0_rx_fin_pending (>= 9 v_0_rx_fin_offset))) $x513)))
(assert
 (let (($x531 (= 0 v_0_rx_slot_10)))
 (or (not (and v_0_rx_fin_pending (>= 10 v_0_rx_fin_offset))) $x531)))
(assert
 (let (($x549 (= 0 v_0_rx_slot_11)))
 (or (not (and v_0_rx_fin_pending (>= 11 v_0_rx_fin_offset))) $x549)))
(assert
 (let (($x567 (= 0 v_0_rx_slot_12)))
 (or (not (and v_0_rx_fin_pending (>= 12 v_0_rx_fin_offset))) $x567)))
(assert
 (let (($x585 (= 0 v_0_rx_slot_13)))
 (or (not (and v_0_rx_fin_pending (>= 13 v_0_rx_fin_offset))) $x585)))
(assert
 (let (($x603 (= 0 v_0_rx_slot_14)))
 (or (not (and v_0_rx_fin_pending (>= 14 v_0_rx_fin_offset))) $x603)))
(assert
 (let (($x621 (= 0 v_0_rx_slot_15)))
 (or (not (and v_0_rx_fin_pending (>= 15 v_0_rx_fin_offset))) $x621)))
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
 (let ((?x713 (- 1.0)))
 (let ((?x742 (* ?x713 v_0_srtt_ms)))
 (let ((?x1678 (+ ?x742 (* ?x713 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x1675)))))
 (let ((?x1679 (to_int ?x1678)))
 (let ((?x268 (- 1)))
 (let ((?x1682 (ite (<= ?x1679 (- 1000)) (* ?x268 ?x1679) 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x1682) 60000 ?x1682) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x706 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x1697 (and (<= v_0_rtt_start_ms now_0) (<= 1 v_0_rtt_remaining) (>= 4 v_0_rtt_remaining) (>= ?x706 v_0_rtt_remaining) (<= ?x706 (mod (+ v_0_snd_nxt (* (- 1) v_0_snd_una)) 4294967296)))))
 (let (($x1689 (not v_0_rtt_active)))
 (or $x1689 $x1697)))))
(assert
 (or v_0_rtt_active (= 0 v_0_rtt_remaining)))
(assert
 true)
(assert
 (let (($x1704 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1707 (and $x1704 v_0_rtt_measured (= v_0_rtt_last_ms (+ now_0 (* (- 1) v_0_rtt_start_ms))))))
 (let (($x1702 (not v_0_rtt_sample_used)))
 (or $x1702 $x1707)))))
(assert
 (let ((?x1710 (to_real v_0_rtt_last_ms)))
 (let ((?x1724 (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x1710))))
 (let ((?x1712 (+ v_0_rtt_previous_srtt (* (- 1.0) ?x1710))))
 (let ((?x1716 (ite (>= ?x1712 0.0) ?x1712 (+ (* (- 1.0) v_0_rtt_previous_srtt) ?x1710))))
 (let ((?x737 (/ 1.0 4.0)))
 (let ((?x1720 (ite v_0_rtt_previous_measured (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* ?x737 ?x1716)) (* (/ 1.0 2.0) ?x1710))))
 (let (($x1727 (and (= v_0_rttvar_ms ?x1720) (= v_0_srtt_ms (ite v_0_rtt_previous_measured ?x1724 ?x1710)))))
 (let (($x1702 (not v_0_rtt_sample_used)))
 (or $x1702 $x1727))))))))))
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
 (let (($x1863 (and (>= v_0_tx_elapsed v_0_tx_previous_rto) (<= 1 v_0_tx_emit_count) (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x1857 (not v_0_tx_retransmitted)))
 (or $x1857 $x1863))))
(assert
 (let (($x1857 (not v_0_tx_retransmitted)))
 (or $x1857 (not v_0_tx_waiting))))
(assert
 (and (<= 0 v_0_tx_syn_time) (<= v_0_tx_syn_time now_0)))
(assert
 (not v_0_tx_syn_pending))
(assert
 (or v_0_tx_syn_pending (= 0 v_0_tx_syn_time)))
(assert
 true)
(assert
 (= 174 choice_0))
(assert
 (= 5 state_0))
(assert
 (= 5 state_1))
(assert
 (or (not (or (not (>= v_1_rcv_buf 10)) (= 0 v_1_rx_slot_06))) (not (>= 1 v_1_rx_slot_07)) (not (or (not (>= v_1_rcv_buf 9)) (= 0 v_1_rx_slot_07))) (not (>= 1 v_1_rx_slot_08)) (not (or (not (>= v_1_rcv_buf 8)) (= 0 v_1_rx_slot_08))) (not (>= 1 v_1_rx_slot_09)) (not (or (not (>= v_1_rcv_buf 7)) (= 0 v_1_rx_slot_09))) (not (>= 1 v_1_rx_slot_10))))
(check-sat)
