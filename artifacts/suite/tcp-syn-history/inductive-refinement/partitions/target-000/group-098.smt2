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
 (let ((?x1484 (+ now_1 (* 2 v_0_msl_ms))))
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
 (let (($x352 (= ?x351 0)))
 (let (($x355 (or $x352 $x354)))
 (let ((?x654 (ite $x355 0 ?x653)))
 (let ((?x657 (ite $x335 (+ ?x337 (* ?x268 ?x654)) ?x337)))
 (let (($x658 (= 0 ?x657)))
 (let (($x661 (and $x335 $x332 $x658 $x302 $x317 $x320 v_0_fin_sent $x321)))
 (let (($x1481 (= due_1_user due_0_user)))
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
 (let (($x1094 (and $x323 v_0_fin_sent)))
 (let ((?x793 (ite (<= 0 v_0_rtx_buf) v_0_rtx_buf 0)))
 (let ((?x791 (ite (<= v_0_rtx_buf ?x281) 0 (+ v_0_rtx_buf (* ?x268 ?x281)))))
 (let (($x665 (and $x302 $x317 $x320)))
 (let ((?x796 (ite $x665 (ite (<= ?x791 ?x793) ?x791 ?x793) v_0_rtx_buf)))
 (let ((?x1460 (+ ?x796 (ite $x1094 1 0))))
 (let (($x1466 (and $x302 $x317 $x320 (<= 1 ?x1460))))
 (let (($x1467 (or (and (not (and $x302 $x317 $x320 (= 0 ?x1460))) active_0_rtx) $x1466)))
 (let (($x662 (not $x661)))
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
 (let (($x1182 (and $x302 $x317 $x320 (not (= 0 ?x281)))))
 (let (($x1178 (= 0 ?x796)))
 (let (($x1425 (= v_1_tx_time_15 (ite (or $x1178 (>= 15 ?x796) $x1182) 0 v_0_tx_time_15))))
 (let ((?x1419 (ite (or $x1178 (>= 14 ?x796)) 0 (ite $x1182 (ite (= 1 ?x281) v_0_tx_time_15 0) v_0_tx_time_14))))
 (let (($x1183 (= 1 ?x281)))
 (let ((?x1411 (ite $x1182 (ite $x1183 v_0_tx_time_14 (ite (= 2 ?x281) v_0_tx_time_15 0)) v_0_tx_time_13)))
 (let (($x1185 (= 2 ?x281)))
 (let ((?x1402 (ite $x1183 v_0_tx_time_13 (ite $x1185 v_0_tx_time_14 (ite (= 3 ?x281) v_0_tx_time_15 0)))))
 (let (($x1405 (= v_1_tx_time_12 (ite (or (>= 12 ?x796) $x1178) 0 (ite $x1182 ?x1402 v_0_tx_time_12)))))
 (let (($x1187 (= 3 ?x281)))
 (let ((?x1392 (ite $x1185 v_0_tx_time_13 (ite $x1187 v_0_tx_time_14 (ite (= 4 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1395 (ite (or $x1178 (>= 11 ?x796)) 0 (ite $x1182 (ite $x1183 v_0_tx_time_12 ?x1392) v_0_tx_time_11))))
 (let (($x1189 (= 4 ?x281)))
 (let ((?x1381 (ite $x1187 v_0_tx_time_13 (ite $x1189 v_0_tx_time_14 (ite (= 5 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1384 (ite $x1182 (ite $x1183 v_0_tx_time_11 (ite $x1185 v_0_tx_time_12 ?x1381)) v_0_tx_time_10)))
 (let (($x1191 (= 5 ?x281)))
 (let ((?x1369 (ite $x1189 v_0_tx_time_13 (ite $x1191 v_0_tx_time_14 (ite (= 6 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1372 (ite $x1183 v_0_tx_time_10 (ite $x1185 v_0_tx_time_11 (ite $x1187 v_0_tx_time_12 ?x1369)))))
 (let (($x1375 (= v_1_tx_time_09 (ite (or $x1178 (>= 9 ?x796)) 0 (ite $x1182 ?x1372 v_0_tx_time_09)))))
 (let (($x1193 (= 6 ?x281)))
 (let ((?x1356 (ite $x1191 v_0_tx_time_13 (ite $x1193 v_0_tx_time_14 (ite (= 7 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1359 (ite $x1185 v_0_tx_time_10 (ite $x1187 v_0_tx_time_11 (ite $x1189 v_0_tx_time_12 ?x1356)))))
 (let ((?x1362 (ite (or $x1178 (>= 8 ?x796)) 0 (ite $x1182 (ite $x1183 v_0_tx_time_09 ?x1359) v_0_tx_time_08))))
 (let (($x1195 (= 7 ?x281)))
 (let ((?x1342 (ite $x1193 v_0_tx_time_13 (ite $x1195 v_0_tx_time_14 (ite (= 8 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1345 (ite $x1187 v_0_tx_time_10 (ite $x1189 v_0_tx_time_11 (ite $x1191 v_0_tx_time_12 ?x1342)))))
 (let ((?x1348 (ite $x1182 (ite $x1183 v_0_tx_time_08 (ite $x1185 v_0_tx_time_09 ?x1345)) v_0_tx_time_07)))
 (let (($x1197 (= 8 ?x281)))
 (let ((?x1327 (ite $x1195 v_0_tx_time_13 (ite $x1197 v_0_tx_time_14 (ite (= 9 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1330 (ite $x1189 v_0_tx_time_10 (ite $x1191 v_0_tx_time_11 (ite $x1193 v_0_tx_time_12 ?x1327)))))
 (let ((?x1333 (ite $x1183 v_0_tx_time_07 (ite $x1185 v_0_tx_time_08 (ite $x1187 v_0_tx_time_09 ?x1330)))))
 (let (($x1336 (= v_1_tx_time_06 (ite (or $x1178 (>= 6 ?x796)) 0 (ite $x1182 ?x1333 v_0_tx_time_06)))))
 (let (($x1199 (= 9 ?x281)))
 (let ((?x1311 (ite $x1197 v_0_tx_time_13 (ite $x1199 v_0_tx_time_14 (ite (= 10 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1314 (ite $x1191 v_0_tx_time_10 (ite $x1193 v_0_tx_time_11 (ite $x1195 v_0_tx_time_12 ?x1311)))))
 (let ((?x1317 (ite $x1185 v_0_tx_time_07 (ite $x1187 v_0_tx_time_08 (ite $x1189 v_0_tx_time_09 ?x1314)))))
 (let ((?x1320 (ite (or $x1178 (>= 5 ?x796)) 0 (ite $x1182 (ite $x1183 v_0_tx_time_06 ?x1317) v_0_tx_time_05))))
 (let (($x1201 (= 10 ?x281)))
 (let ((?x1294 (ite $x1199 v_0_tx_time_13 (ite $x1201 v_0_tx_time_14 (ite (= 11 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1297 (ite $x1193 v_0_tx_time_10 (ite $x1195 v_0_tx_time_11 (ite $x1197 v_0_tx_time_12 ?x1294)))))
 (let ((?x1300 (ite $x1187 v_0_tx_time_07 (ite $x1189 v_0_tx_time_08 (ite $x1191 v_0_tx_time_09 ?x1297)))))
 (let ((?x1303 (ite $x1182 (ite $x1183 v_0_tx_time_05 (ite $x1185 v_0_tx_time_06 ?x1300)) v_0_tx_time_04)))
 (let (($x1203 (= 11 ?x281)))
 (let ((?x1276 (ite $x1201 v_0_tx_time_13 (ite $x1203 v_0_tx_time_14 (ite (= 12 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1279 (ite $x1195 v_0_tx_time_10 (ite $x1197 v_0_tx_time_11 (ite $x1199 v_0_tx_time_12 ?x1276)))))
 (let ((?x1282 (ite $x1189 v_0_tx_time_07 (ite $x1191 v_0_tx_time_08 (ite $x1193 v_0_tx_time_09 ?x1279)))))
 (let ((?x1285 (ite $x1183 v_0_tx_time_04 (ite $x1185 v_0_tx_time_05 (ite $x1187 v_0_tx_time_06 ?x1282)))))
 (let (($x1288 (= v_1_tx_time_03 (ite (or $x1178 (>= 3 ?x796)) 0 (ite $x1182 ?x1285 v_0_tx_time_03)))))
 (let (($x1205 (= 12 ?x281)))
 (let ((?x1257 (ite $x1203 v_0_tx_time_13 (ite $x1205 v_0_tx_time_14 (ite (= 13 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1260 (ite $x1197 v_0_tx_time_10 (ite $x1199 v_0_tx_time_11 (ite $x1201 v_0_tx_time_12 ?x1257)))))
 (let ((?x1263 (ite $x1191 v_0_tx_time_07 (ite $x1193 v_0_tx_time_08 (ite $x1195 v_0_tx_time_09 ?x1260)))))
 (let ((?x1266 (ite $x1185 v_0_tx_time_04 (ite $x1187 v_0_tx_time_05 (ite $x1189 v_0_tx_time_06 ?x1263)))))
 (let ((?x1269 (ite (or $x1178 (>= 2 ?x796)) 0 (ite $x1182 (ite $x1183 v_0_tx_time_03 ?x1266) v_0_tx_time_02))))
 (let (($x1207 (= 13 ?x281)))
 (let ((?x1237 (ite $x1205 v_0_tx_time_13 (ite $x1207 v_0_tx_time_14 (ite (= 14 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1240 (ite $x1199 v_0_tx_time_10 (ite $x1201 v_0_tx_time_11 (ite $x1203 v_0_tx_time_12 ?x1237)))))
 (let ((?x1243 (ite $x1193 v_0_tx_time_07 (ite $x1195 v_0_tx_time_08 (ite $x1197 v_0_tx_time_09 ?x1240)))))
 (let ((?x1246 (ite $x1187 v_0_tx_time_04 (ite $x1189 v_0_tx_time_05 (ite $x1191 v_0_tx_time_06 ?x1243)))))
 (let ((?x1249 (ite $x1182 (ite $x1183 v_0_tx_time_02 (ite $x1185 v_0_tx_time_03 ?x1246)) v_0_tx_time_01)))
 (let (($x1209 (= 14 ?x281)))
 (let ((?x1215 (ite $x1207 v_0_tx_time_13 (ite $x1209 v_0_tx_time_14 (ite (= 15 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1218 (ite $x1201 v_0_tx_time_10 (ite $x1203 v_0_tx_time_11 (ite $x1205 v_0_tx_time_12 ?x1215)))))
 (let ((?x1221 (ite $x1195 v_0_tx_time_07 (ite $x1197 v_0_tx_time_08 (ite $x1199 v_0_tx_time_09 ?x1218)))))
 (let ((?x1224 (ite $x1189 v_0_tx_time_04 (ite $x1191 v_0_tx_time_05 (ite $x1193 v_0_tx_time_06 ?x1221)))))
 (let ((?x1227 (ite $x1183 v_0_tx_time_01 (ite $x1185 v_0_tx_time_02 (ite $x1187 v_0_tx_time_03 ?x1224)))))
 (let (($x1231 (= v_1_tx_time_00 (ite (or $x1178 (>= 0 ?x796)) 0 (ite $x1182 ?x1227 v_0_tx_time_00)))))
 (let (($x1165 (= v_1_rtt_sample_was_ambiguous (and v_0_rtt_active v_0_rtt_ambiguous))))
 (let (($x1160 (not v_1_rtt_start_new)))
 (let ((?x789 (* ?x268 ?x281)))
 (let ((?x1152 (+ ?x706 ?x789)))
 (let (($x1155 (and v_0_rtt_active $x302 $x317 $x320 (not (<= v_0_rtt_remaining ?x1152)))))
 (let (($x1136 (and v_0_rtt_active $x302 $x317 $x320 $x707)))
 (let (($x1158 (= v_1_rtt_remaining (ite $x1136 0 (ite $x1155 ?x1152 v_0_rtt_remaining)))))
 (let (($x1149 (= v_1_rtt_end v_0_rtt_end)))
 (let (($x1148 (= v_1_rtt_start_ms v_0_rtt_start_ms)))
 (let (($x1134 (= v_1_rtt_previous_measured (ite $x710 v_0_rtt_measured v_0_rtt_previous_measured))))
 (let (($x1127 (= v_1_rtt_previous_var (ite $x710 v_0_rttvar_ms v_0_rtt_previous_var))))
 (let (($x1123 (= v_1_rtt_previous_srtt (ite $x710 v_0_srtt_ms v_0_rtt_previous_srtt))))
 (let ((?x1103 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data) 4294967296)))
 (let (($x1096 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x1092 (= v_1_fin_requested v_0_fin_requested)))
 (let (($x813 (<= 2147483648 (mod (+ input_0_net.fin_segment_ack (* ?x268 v_0_snd_wl2)) 4294967296))))
 (let (($x809 (= v_0_snd_wl1 input_0_net.fin_segment_seq)))
 (let ((?x803 (mod (+ input_0_net.fin_segment_seq (* ?x268 v_0_snd_wl1)) 4294967296)))
 (let (($x816 (or (and (not (<= ?x803 0)) (not (<= 2147483648 ?x803))) (and $x809 (not $x813)))))
 (let (($x817 (and $x302 $x320 $x816)))
 (let ((?x1070 (ite (or (and $x335 $x332 $x658) (not (and (or $x354 $x352) (not $x637)))) 0 ?x634)))
 (let (($x886 (not $x637)))
 (let (($x689 (not $x355)))
 (let (($x855 (not $x394)))
 (let (($x853 (not $x414)))
 (let (($x851 (not $x434)))
 (let (($x849 (not $x454)))
 (let (($x847 (not $x474)))
 (let (($x845 (not $x494)))
 (let (($x843 (not $x512)))
 (let (($x841 (not $x530)))
 (let (($x839 (not $x548)))
 (let (($x837 (not $x566)))
 (let (($x835 (not $x584)))
 (let (($x833 (not $x602)))
 (let (($x831 (not $x620)))
 (let (($x830 (and false $x638)))
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
 (let (($x857 (or $x371 (and $x854 $x855) $x373)))
 (let ((?x683 (ite $x619 0 ?x616)))
 (let (($x829 (or $x354 $x352)))
 (let (($x659 (and $x335 $x332 $x658)))
 (let (($x1066 (= v_1_rx_slot_14 (ite $x659 0 (ite $x829 ?x683 (ite (and $x857 $x689 $x886) ?x634 0))))))
 (let (($x858 (and $x857 $x689)))
 (let ((?x1058 (ite $x858 ?x683 (ite (and (or $x854 $x394) (not $x374) $x689 $x886) ?x634 0))))
 (let ((?x682 (ite $x601 0 ?x598)))
 (let (($x860 (not $x374)))
 (let (($x859 (or $x854 $x394)))
 (let (($x861 (and $x859 $x860 $x689)))
 (let ((?x1051 (ite $x861 ?x683 (ite (and (or $x852 $x414) $x855 $x860 $x689 $x886) ?x634 0))))
 (let ((?x681 (ite $x583 0 ?x580)))
 (let (($x1055 (= v_1_rx_slot_12 (ite $x659 0 (ite $x829 ?x681 (ite $x858 ?x682 ?x1051))))))
 (let (($x862 (or $x852 $x414)))
 (let (($x863 (and $x862 $x855 $x860 $x689)))
 (let ((?x1043 (ite $x863 ?x683 (ite (and (or $x850 $x434) $x853 $x855 $x860 $x689 $x886) ?x634 0))))
 (let ((?x680 (ite $x565 0 ?x562)))
 (let (($x1048 (= v_1_rx_slot_11 (ite $x659 0 (ite $x829 ?x680 (ite $x858 ?x681 (ite $x861 ?x682 ?x1043)))))))
 (let (($x864 (or $x850 $x434)))
 (let (($x865 (and $x864 $x853 $x855 $x860 $x689)))
 (let ((?x1034 (ite $x865 ?x683 (ite (and (or $x848 $x454) $x851 $x853 $x855 $x860 $x689 $x886) ?x634 0))))
 (let ((?x679 (ite $x547 0 ?x544)))
 (let ((?x1039 (ite $x659 0 (ite $x829 ?x679 (ite $x858 ?x680 (ite $x861 ?x681 (ite $x863 ?x682 ?x1034)))))))
 (let ((?x1023 (ite (and (or $x846 $x474) $x849 $x851 $x853 $x855 $x860 $x689 $x886) ?x634 0)))
 (let (($x866 (or $x848 $x454)))
 (let (($x867 (and $x866 $x851 $x853 $x855 $x860 $x689)))
 (let ((?x1028 (ite $x858 ?x679 (ite $x861 ?x680 (ite $x863 ?x681 (ite $x865 ?x682 (ite $x867 ?x683 ?x1023)))))))
 (let ((?x678 (ite $x529 0 ?x526)))
 (let ((?x1012 (ite (and (or $x844 $x494) $x847 $x849 $x851 $x853 $x855 $x860 $x689 $x886) ?x634 0)))
 (let (($x868 (or $x846 $x474)))
 (let (($x869 (and $x868 $x849 $x851 $x853 $x855 $x860 $x689)))
 (let ((?x1017 (ite $x861 ?x679 (ite $x863 ?x680 (ite $x865 ?x681 (ite $x867 ?x682 (ite $x869 ?x683 ?x1012)))))))
 (let ((?x677 (ite $x511 0 ?x508)))
 (let (($x1021 (= v_1_rx_slot_08 (ite $x659 0 (ite $x829 ?x677 (ite $x858 ?x678 ?x1017))))))
 (let ((?x1000 (ite (and (or $x842 $x512) $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x689 $x886) ?x634 0)))
 (let (($x870 (or $x844 $x494)))
 (let (($x871 (and $x870 $x847 $x849 $x851 $x853 $x855 $x860 $x689)))
 (let ((?x1005 (ite $x863 ?x679 (ite $x865 ?x680 (ite $x867 ?x681 (ite $x869 ?x682 (ite $x871 ?x683 ?x1000)))))))
 (let ((?x676 (ite $x493 0 ?x490)))
 (let (($x1010 (= v_1_rx_slot_07 (ite $x659 0 (ite $x829 ?x676 (ite $x858 ?x677 (ite $x861 ?x678 ?x1005)))))))
 (let (($x874 (or $x840 $x530)))
 (let ((?x987 (ite (and $x874 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x689 $x886) ?x634 0)))
 (let (($x872 (or $x842 $x512)))
 (let (($x873 (and $x872 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x689)))
 (let ((?x992 (ite $x865 ?x679 (ite $x867 ?x680 (ite $x869 ?x681 (ite $x871 ?x682 (ite $x873 ?x683 ?x987)))))))
 (let ((?x675 (ite $x473 0 ?x470)))
 (let ((?x997 (ite $x659 0 (ite $x829 ?x675 (ite $x858 ?x676 (ite $x861 ?x677 (ite $x863 ?x678 ?x992)))))))
 (let (($x876 (or $x838 $x548)))
 (let ((?x973 (ite (and $x876 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x689 $x886) ?x634 0)))
 (let (($x875 (and $x874 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x689)))
 (let ((?x978 (ite $x867 ?x679 (ite $x869 ?x680 (ite $x871 ?x681 (ite $x873 ?x682 (ite $x875 ?x683 ?x973)))))))
 (let ((?x674 (ite $x453 0 ?x450)))
 (let ((?x983 (ite $x829 ?x674 (ite $x858 ?x675 (ite $x861 ?x676 (ite $x863 ?x677 (ite $x865 ?x678 ?x978)))))))
 (let (($x878 (or $x836 $x566)))
 (let (($x957 (and $x878 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x689 $x886)))
 (let (($x877 (and $x876 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x689)))
 (let ((?x962 (ite $x871 ?x680 (ite $x873 ?x681 (ite $x875 ?x682 (ite $x877 ?x683 (ite $x957 ?x634 0)))))))
 (let ((?x967 (ite $x861 ?x675 (ite $x863 ?x676 (ite $x865 ?x677 (ite $x867 ?x678 (ite $x869 ?x679 ?x962)))))))
 (let ((?x673 (ite $x433 0 ?x430)))
 (let (($x971 (= v_1_rx_slot_04 (ite $x659 0 (ite $x829 ?x673 (ite $x858 ?x674 ?x967))))))
 (let (($x880 (or $x834 $x584)))
 (let (($x941 (and $x880 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x689 $x886)))
 (let (($x879 (and $x878 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x689)))
 (let ((?x946 (ite $x873 ?x680 (ite $x875 ?x681 (ite $x877 ?x682 (ite $x879 ?x683 (ite $x941 ?x634 0)))))))
 (let ((?x951 (ite $x863 ?x675 (ite $x865 ?x676 (ite $x867 ?x677 (ite $x869 ?x678 (ite $x871 ?x679 ?x946)))))))
 (let ((?x672 (ite $x413 0 ?x410)))
 (let (($x956 (= v_1_rx_slot_03 (ite $x659 0 (ite $x829 ?x672 (ite $x858 ?x673 (ite $x861 ?x674 ?x951)))))))
 (let (($x882 (or $x832 $x602)))
 (let (($x924 (and $x882 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x689 $x886)))
 (let (($x881 (and $x880 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x689)))
 (let ((?x929 (ite $x875 ?x680 (ite $x877 ?x681 (ite $x879 ?x682 (ite $x881 ?x683 (ite $x924 ?x634 0)))))))
 (let ((?x934 (ite $x865 ?x675 (ite $x867 ?x676 (ite $x869 ?x677 (ite $x871 ?x678 (ite $x873 ?x679 ?x929)))))))
 (let ((?x671 (ite $x393 0 ?x390)))
 (let ((?x939 (ite $x659 0 (ite $x829 ?x671 (ite $x858 ?x672 (ite $x861 ?x673 (ite $x863 ?x674 ?x934)))))))
 (let (($x884 (or $x830 $x620)))
 (let (($x906 (and $x884 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x689 $x886)))
 (let (($x883 (and $x882 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x689)))
 (let ((?x911 (ite $x877 ?x680 (ite $x879 ?x681 (ite $x881 ?x682 (ite $x883 ?x683 (ite $x906 ?x634 0)))))))
 (let ((?x916 (ite $x867 ?x675 (ite $x869 ?x676 (ite $x871 ?x677 (ite $x873 ?x678 (ite $x875 ?x679 ?x911)))))))
 (let ((?x670 (ite $x373 0 ?x370)))
 (let ((?x921 (ite $x829 ?x670 (ite $x858 ?x671 (ite $x861 ?x672 (ite $x863 ?x673 (ite $x865 ?x674 ?x916)))))))
 (let (($x887 (and $x638 $x831 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x689 $x886)))
 (let (($x885 (and $x884 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x860 $x689)))
 (let ((?x892 (ite $x879 ?x680 (ite $x881 ?x681 (ite $x883 ?x682 (ite $x885 ?x683 (ite $x887 ?x634 0)))))))
 (let ((?x897 (ite $x869 ?x675 (ite $x871 ?x676 (ite $x873 ?x677 (ite $x875 ?x678 (ite $x877 ?x679 ?x892)))))))
 (let ((?x902 (ite $x858 ?x670 (ite $x861 ?x671 (ite $x863 ?x672 (ite $x865 ?x673 (ite $x867 ?x674 ?x897)))))))
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
 (and (>= now_1 now_0) (<= 0 input_0_net.fin_segment_data) (>= 16 input_0_net.fin_segment_data) (not (= ?x271 2147483648)) (<= 0 input_0_net.fin_segment_window) (>= 65535 input_0_net.fin_segment_window) (or (and (not (= ?x281 2147483648)) (not $x287)) (not $x302)) $x306 $x307 (or (not active_0_rtx) (not (<= due_0_rtx now_1))) (or (not active_0_user) (not (<= due_0_user now_1))) (or (not active_0_time_wait) (not (<= due_0_time_wait now_1))) $x323 $x660 $x662 $x663 $x664 (= v_1_snd_una (ite $x665 input_0_net.fin_segment_ack v_0_snd_una)) $x668 $x697 $x698 $x699 $x702 (= v_1_rto_ms ?x768) $x772 $x775 $x778 $x781 (= v_1_local_window (+ 16 (* ?x268 v_0_rcv_buf) (* ?x268 ?x693))) $x787 (= v_1_rtx_buf ?x796) (= v_1_rcv_buf (+ v_0_rcv_buf ?x693)) (= v_1_snd_wnd (ite $x817 input_0_net.fin_segment_window v_0_snd_wnd)) (= v_1_snd_wl1 (ite $x817 input_0_net.fin_segment_seq v_0_snd_wl1)) (= v_1_snd_wl2 (ite $x817 input_0_net.fin_segment_ack v_0_snd_wl2)) $x827 (= v_1_rx_chunk ?x693) (= v_1_rx_slot_00 (ite $x659 0 (ite $x829 ?x669 ?x902))) (= v_1_rx_slot_01 (ite $x659 0 ?x921)) (= v_1_rx_slot_02 ?x939) $x956 $x971 (= v_1_rx_slot_05 (ite $x659 0 ?x983)) (= v_1_rx_slot_06 ?x997) $x1010 $x1021 (= v_1_rx_slot_09 (ite $x659 0 (ite $x829 ?x678 ?x1028))) (= v_1_rx_slot_10 ?x1039) $x1048 $x1055 (= v_1_rx_slot_13 (ite $x659 0 (ite $x829 ?x682 ?x1058))) $x1066 (= v_1_rx_slot_15 ?x1070) (= v_1_rx_advance ?x654) (= v_1_rx_acceptable (and $x302 $x330 $x332)) (= v_1_seg_acceptable $x302) (= v_1_ack_delta ?x281) (= v_1_ack_is_new (and $x317 $x320)) (= v_1_ack_is_future $x329) (= v_1_ack_advance $x665) (= v_1_ack_window_update $x817) $x1092 (= v_1_fin_sent $x1094) $x1096 (= v_1_fin_acknowledged $x322) (= v_1_rx_fin_pending (and $x335 $x660)) (= v_1_rx_fin_seq (ite $x334 ?x1103 v_0_rx_fin_seq)) (= v_1_rx_fin_offset (ite $x659 0 ?x657)) (= v_1_rx_fin_done (or v_0_rx_fin_done $x659)) (= v_1_rx_fin_consumed $x659) (= v_1_srtt_ms ?x730) (= v_1_rttvar_ms ?x753) (= v_1_rtt_error_ms ?x746) $x1123 $x1127 (= v_1_rtt_measured (or v_0_rtt_measured $x710)) $x1134 (= v_1_rtt_active (and v_0_rtt_active (not $x1136))) (= v_1_rtt_ambiguous (and (not $x1136) v_0_rtt_ambiguous)) (= v_1_rtt_sample_at_ms (ite $x710 now_1 v_0_rtt_sample_at_ms)) $x1148 $x1149 $x1158 $x1160 (= v_1_rtt_sample_used $x710) $x1165 (= v_1_rtt_last_ms ?x725) (= v_1_rtt_samples (+ v_0_rtt_samples (ite $x710 1 0))) (= v_1_rto_base_ms (ite $x710 ?x766 v_0_rto_base_ms)) $x1231 (= v_1_tx_time_01 (ite (or $x1178 (>= 1 ?x796)) 0 ?x1249)) (= v_1_tx_time_02 ?x1269) $x1288 (= v_1_tx_time_04 (ite (or $x1178 (>= 4 ?x796)) 0 ?x1303)) (= v_1_tx_time_05 ?x1320) $x1336 (= v_1_tx_time_07 (ite (or $x1178 (>= 7 ?x796)) 0 ?x1348)) (= v_1_tx_time_08 ?x1362) $x1375 (= v_1_tx_time_10 (ite (or (>= 10 ?x796) $x1178) 0 ?x1384)) (= v_1_tx_time_11 ?x1395) $x1405 (= v_1_tx_time_13 (ite (or (>= 13 ?x796) $x1178) 0 ?x1411)) (= v_1_tx_time_14 ?x1419) $x1425 (= v_1_tx_fin_time (ite $x1094 v_0_tx_fin_time 0)) $x1432 $x1435 $x1438 $x1440 $x1443 $x1446 $x1449 $x1451 $x1453 $x1455 $x1457 (= active_1_rtx (and $x662 $x1467)) (= active_1_user (and $x662 active_0_user)) (= active_1_time_wait (or $x661 active_0_time_wait)) (= due_1_rtx (ite $x1466 (+ now_1 ?x768) due_0_rtx)) $x1481 (= due_1_time_wait (ite $x661 ?x1484 due_0_time_wait))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
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
 (let ((?x1492 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1492)))
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
 (let (($x1502 (not (>= v_0_rcv_buf 16))))
 (or $x1502 $x338))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x356 (= 0 v_0_rx_slot_01)))
 (let (($x1506 (not (>= v_0_rcv_buf 15))))
 (or $x1506 $x356))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x375 (= 0 v_0_rx_slot_02)))
 (let (($x1510 (not (>= v_0_rcv_buf 14))))
 (or $x1510 $x375))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x395 (= 0 v_0_rx_slot_03)))
 (let (($x1514 (not (>= v_0_rcv_buf 13))))
 (or $x1514 $x395))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x415 (= 0 v_0_rx_slot_04)))
 (let (($x1518 (not (>= v_0_rcv_buf 12))))
 (or $x1518 $x415))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x435 (= 0 v_0_rx_slot_05)))
 (let (($x1522 (not (>= v_0_rcv_buf 11))))
 (or $x1522 $x435))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x455 (= 0 v_0_rx_slot_06)))
 (let (($x1526 (not (>= v_0_rcv_buf 10))))
 (or $x1526 $x455))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x475 (= 0 v_0_rx_slot_07)))
 (let (($x1530 (not (>= v_0_rcv_buf 9))))
 (or $x1530 $x475))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x495 (= 0 v_0_rx_slot_08)))
 (let (($x1534 (not (>= v_0_rcv_buf 8))))
 (or $x1534 $x495))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x513 (= 0 v_0_rx_slot_09)))
 (let (($x1538 (not (>= v_0_rcv_buf 7))))
 (or $x1538 $x513))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x531 (= 0 v_0_rx_slot_10)))
 (let (($x1542 (not (>= v_0_rcv_buf 6))))
 (or $x1542 $x531))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x549 (= 0 v_0_rx_slot_11)))
 (let (($x1546 (not (>= v_0_rcv_buf 5))))
 (or $x1546 $x549))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x567 (= 0 v_0_rx_slot_12)))
 (let (($x1550 (not (>= v_0_rcv_buf 4))))
 (or $x1550 $x567))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x585 (= 0 v_0_rx_slot_13)))
 (let (($x1554 (not (>= v_0_rcv_buf 3))))
 (or $x1554 $x585))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x603 (= 0 v_0_rx_slot_14)))
 (let (($x1558 (not (>= v_0_rcv_buf 2))))
 (or $x1558 $x603))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x621 (= 0 v_0_rx_slot_15)))
 (let (($x1562 (not (>= v_0_rcv_buf 1))))
 (or $x1562 $x621))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x1564 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x1564)))
(assert
 (and (<= 0 v_0_rx_advance) (>= 16 v_0_rx_advance)))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (and (<= 0 v_0_ack_delta) (>= 4294967295 v_0_ack_delta)))
(assert
 true)
(assert
 (let ((?x1577 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x1577)))
(assert
 (= active_0_rtx (<= 1 (+ v_0_rtx_buf (ite v_0_fin_sent 1 0)))))
(assert
 (let (($x1585 (and v_0_fin_requested (= v_0_fin_seq (mod (+ v_0_snd_una v_0_rtx_buf) 4294967296)) (= 0 v_0_snd_buf))))
 (let (($x306 (not v_0_fin_sent)))
 (or $x306 $x1585))))
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
 (let (($x1587 (<= 1 v_0_rx_fin_offset)))
 (let (($x332 (not v_0_rx_fin_done)))
 (let (($x1589 (and $x332 $x1587 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window)))))
 (let (($x333 (not v_0_rx_fin_pending)))
 (or $x333 $x1589))))))
(assert
 (let (($x1592 (>= 15 v_0_rx_fin_offset)))
 (and (<= 0 v_0_rx_fin_offset) $x1592 (= v_0_rx_fin_pending (<= 1 v_0_rx_fin_offset)))))
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
 (let ((?x1680 (* 4.0 v_0_rttvar_ms)))
 (let ((?x713 (- 1.0)))
 (let ((?x742 (* ?x713 v_0_srtt_ms)))
 (let ((?x1683 (+ ?x742 (* ?x713 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x1680)))))
 (let ((?x1684 (to_int ?x1683)))
 (let ((?x268 (- 1)))
 (let ((?x1687 (ite (<= ?x1684 (- 1000)) (* ?x268 ?x1684) 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x1687) 60000 ?x1687) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x706 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x1702 (and (<= v_0_rtt_start_ms now_0) (<= 1 v_0_rtt_remaining) (>= 4 v_0_rtt_remaining) (>= ?x706 v_0_rtt_remaining) (<= ?x706 (mod (+ v_0_snd_nxt (* (- 1) v_0_snd_una)) 4294967296)))))
 (let (($x1694 (not v_0_rtt_active)))
 (or $x1694 $x1702)))))
(assert
 (or v_0_rtt_active (= 0 v_0_rtt_remaining)))
(assert
 true)
(assert
 (let (($x1711 (= v_0_rtt_last_ms (+ v_0_rtt_sample_at_ms (* (- 1) v_0_rtt_start_ms)))))
 (let (($x1709 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1707 (not v_0_rtt_sample_used)))
 (or $x1707 (and $x1709 v_0_rtt_measured $x1711))))))
(assert
 (and (<= 0 v_0_rtt_sample_at_ms) (<= v_0_rtt_sample_at_ms now_0)))
(assert
 (let ((?x1718 (to_real v_0_rtt_last_ms)))
 (let ((?x1732 (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x1718))))
 (let ((?x1720 (+ v_0_rtt_previous_srtt (* (- 1.0) ?x1718))))
 (let ((?x1724 (ite (>= ?x1720 0.0) ?x1720 (+ (* (- 1.0) v_0_rtt_previous_srtt) ?x1718))))
 (let ((?x737 (/ 1.0 4.0)))
 (let ((?x1728 (ite v_0_rtt_previous_measured (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* ?x737 ?x1724)) (* (/ 1.0 2.0) ?x1718))))
 (let (($x1735 (and (= v_0_rttvar_ms ?x1728) (= v_0_srtt_ms (ite v_0_rtt_previous_measured ?x1732 ?x1718)))))
 (let (($x1707 (not v_0_rtt_sample_used)))
 (or $x1707 $x1735))))))))))
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
 (let (($x1871 (and (>= v_0_tx_elapsed v_0_tx_previous_rto) (<= 1 v_0_tx_emit_count) (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x1865 (not v_0_tx_retransmitted)))
 (or $x1865 $x1871))))
(assert
 (let (($x1865 (not v_0_tx_retransmitted)))
 (let (($x1874 (not v_0_tx_waiting)))
 (or $x1874 $x1865))))
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
 (or (not (<= 0 v_1_tx_time_00))))
(check-sat)
