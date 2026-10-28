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
(declare-fun due_1_delack () Int)
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
(declare-fun active_1_delack () Bool)
(declare-fun active_1_time_wait () Bool)
(declare-fun active_1_user () Bool)
(declare-fun active_1_rtx () Bool)
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
(declare-fun v_0_ack_pending () Bool)
(declare-fun v_0_ack_full_segments () Int)
(declare-fun v_0_ack_bytes () Int)
(declare-fun v_0_ack_since_ms () Int)
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
 (let (($x1516 (= due_1_delack due_0_delack)))
 (let ((?x1512 (+ now_1 (* 2 v_0_msl_ms))))
 (let ((?x326 (ite v_0_fin_sent 1 0)))
 (let ((?x327 (+ v_0_rtx_buf ?x326)))
 (let ((?x286 (mod (+ input_0_net.fin_segment_ack (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x329 (= ?x286 ?x327)))
 (let (($x328 (<= ?x286 ?x327)))
 (let (($x325 (<= 1 ?x286)))
 (let ((?x273 (- 1)))
 (let ((?x300 (+ ?x273 v_0_local_window)))
 (let (($x305 (<= (mod (+ input_0_net.fin_segment_seq (* ?x273 v_0_rcv_nxt)) 4294967296) ?x300)))
 (let (($x296 (<= 1 v_0_local_window)))
 (let ((?x297 (* ?x273 v_0_rcv_nxt)))
 (let ((?x299 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data ?x297) 4294967296)))
 (let (($x301 (<= ?x299 ?x300)))
 (let (($x307 (or (and $x296 $x301) (and $x296 $x305))))
 (let (($x341 (not v_0_rx_fin_pending)))
 (let (($x340 (not v_0_rx_fin_done)))
 (let (($x337 (and (>= ?x286 (+ 1 v_0_rtx_buf ?x326)) (>= 2147483647 ?x286))))
 (let (($x338 (not $x337)))
 (let (($x342 (and $x307 $x338 $x340 $x341 $x296 $x301)))
 (let ((?x345 (ite $x342 ?x299 v_0_rx_fin_offset)))
 (let (($x343 (or v_0_rx_fin_pending $x342)))
 (let (($x645 (and $x343 (>= 15 ?x345))))
 (let ((?x632 (mod (+ 15 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x637 (+ input_0_net.fin_segment_data (* ?x273 ?x632))))
 (let (($x635 (<= input_0_net.fin_segment_data ?x632)))
 (let (($x630 (<= v_0_rcv_buf 0)))
 (let (($x629 (= 0 v_0_rx_slot_15)))
 (let (($x634 (and $x307 $x338 $x340 $x629 $x630 (<= ?x632 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x642 (ite $x634 (ite (or $x635 (<= ?x637 1)) (ite $x635 0 ?x637) 1) v_0_rx_slot_15)))
 (let (($x646 (or (= ?x642 0) $x645)))
 (let (($x627 (and $x343 (>= 14 ?x345))))
 (let ((?x614 (mod (+ 14 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x619 (+ input_0_net.fin_segment_data (* ?x273 ?x614))))
 (let (($x617 (<= input_0_net.fin_segment_data ?x614)))
 (let (($x612 (<= v_0_rcv_buf 1)))
 (let (($x611 (= 0 v_0_rx_slot_14)))
 (let (($x616 (and $x307 $x338 $x340 $x611 $x612 (<= ?x614 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x624 (ite $x616 (ite (or $x617 (<= ?x619 1)) (ite $x617 0 ?x619) 1) v_0_rx_slot_14)))
 (let (($x628 (or (= ?x624 0) $x627)))
 (let (($x609 (and $x343 (>= 13 ?x345))))
 (let ((?x596 (mod (+ 13 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x601 (+ input_0_net.fin_segment_data (* ?x273 ?x596))))
 (let (($x599 (<= input_0_net.fin_segment_data ?x596)))
 (let (($x594 (<= v_0_rcv_buf 2)))
 (let (($x593 (= 0 v_0_rx_slot_13)))
 (let (($x598 (and $x307 $x338 $x340 $x593 $x594 (<= ?x596 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x606 (ite $x598 (ite (or $x599 (<= ?x601 1)) (ite $x599 0 ?x601) 1) v_0_rx_slot_13)))
 (let (($x610 (or (= ?x606 0) $x609)))
 (let (($x591 (and $x343 (>= 12 ?x345))))
 (let ((?x578 (mod (+ 12 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x583 (+ input_0_net.fin_segment_data (* ?x273 ?x578))))
 (let (($x581 (<= input_0_net.fin_segment_data ?x578)))
 (let (($x576 (<= v_0_rcv_buf 3)))
 (let (($x575 (= 0 v_0_rx_slot_12)))
 (let (($x580 (and $x307 $x338 $x340 $x575 $x576 (<= ?x578 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x588 (ite $x580 (ite (or $x581 (<= ?x583 1)) (ite $x581 0 ?x583) 1) v_0_rx_slot_12)))
 (let (($x592 (or (= ?x588 0) $x591)))
 (let ((?x650 (ite $x592 12 (ite $x610 13 (ite $x628 14 (ite $x646 15 16))))))
 (let (($x573 (and $x343 (>= 11 ?x345))))
 (let ((?x560 (mod (+ 11 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x565 (+ input_0_net.fin_segment_data (* ?x273 ?x560))))
 (let (($x563 (<= input_0_net.fin_segment_data ?x560)))
 (let (($x558 (<= v_0_rcv_buf 4)))
 (let (($x557 (= 0 v_0_rx_slot_11)))
 (let (($x562 (and $x307 $x338 $x340 $x557 $x558 (<= ?x560 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x570 (ite $x562 (ite (or $x563 (<= ?x565 1)) (ite $x563 0 ?x565) 1) v_0_rx_slot_11)))
 (let (($x574 (or (= ?x570 0) $x573)))
 (let (($x555 (and $x343 (>= 10 ?x345))))
 (let ((?x542 (mod (+ 10 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x547 (+ input_0_net.fin_segment_data (* ?x273 ?x542))))
 (let (($x545 (<= input_0_net.fin_segment_data ?x542)))
 (let (($x540 (<= v_0_rcv_buf 5)))
 (let (($x539 (= 0 v_0_rx_slot_10)))
 (let (($x544 (and $x307 $x338 $x340 $x539 $x540 (<= ?x542 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x552 (ite $x544 (ite (or $x545 (<= ?x547 1)) (ite $x545 0 ?x547) 1) v_0_rx_slot_10)))
 (let (($x556 (or (= ?x552 0) $x555)))
 (let (($x537 (and $x343 (>= 9 ?x345))))
 (let ((?x524 (mod (+ 9 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x529 (+ input_0_net.fin_segment_data (* ?x273 ?x524))))
 (let (($x527 (<= input_0_net.fin_segment_data ?x524)))
 (let (($x522 (<= v_0_rcv_buf 6)))
 (let (($x521 (= 0 v_0_rx_slot_09)))
 (let (($x526 (and $x307 $x338 $x340 $x521 $x522 (<= ?x524 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x534 (ite $x526 (ite (or $x527 (<= ?x529 1)) (ite $x527 0 ?x529) 1) v_0_rx_slot_09)))
 (let (($x538 (or (= ?x534 0) $x537)))
 (let (($x519 (and $x343 (>= 8 ?x345))))
 (let ((?x506 (mod (+ 8 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x511 (+ input_0_net.fin_segment_data (* ?x273 ?x506))))
 (let (($x509 (<= input_0_net.fin_segment_data ?x506)))
 (let (($x504 (<= v_0_rcv_buf 7)))
 (let (($x503 (= 0 v_0_rx_slot_08)))
 (let (($x508 (and $x307 $x338 $x340 $x503 $x504 (<= ?x506 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x516 (ite $x508 (ite (or $x509 (<= ?x511 1)) (ite $x509 0 ?x511) 1) v_0_rx_slot_08)))
 (let (($x520 (or (= ?x516 0) $x519)))
 (let ((?x654 (ite $x520 8 (ite $x538 9 (ite $x556 10 (ite $x574 11 ?x650))))))
 (let (($x501 (and $x343 (>= 7 ?x345))))
 (let ((?x488 (mod (+ 7 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x493 (+ input_0_net.fin_segment_data (* ?x273 ?x488))))
 (let (($x491 (<= input_0_net.fin_segment_data ?x488)))
 (let (($x485 (<= v_0_rcv_buf 8)))
 (let (($x483 (= 0 v_0_rx_slot_07)))
 (let (($x490 (and $x307 $x338 $x340 $x483 $x485 (<= ?x488 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x498 (ite $x490 (ite (or $x491 (<= ?x493 1)) (ite $x491 0 ?x493) 1) v_0_rx_slot_07)))
 (let (($x502 (or (= ?x498 0) $x501)))
 (let (($x481 (and $x343 (>= 6 ?x345))))
 (let ((?x468 (mod (+ 6 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x473 (+ input_0_net.fin_segment_data (* ?x273 ?x468))))
 (let (($x471 (<= input_0_net.fin_segment_data ?x468)))
 (let (($x465 (<= v_0_rcv_buf 9)))
 (let (($x463 (= 0 v_0_rx_slot_06)))
 (let (($x470 (and $x307 $x338 $x340 $x463 $x465 (<= ?x468 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x478 (ite $x470 (ite (or $x471 (<= ?x473 1)) (ite $x471 0 ?x473) 1) v_0_rx_slot_06)))
 (let (($x482 (or (= ?x478 0) $x481)))
 (let (($x461 (and $x343 (>= 5 ?x345))))
 (let ((?x448 (mod (+ 5 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x453 (+ input_0_net.fin_segment_data (* ?x273 ?x448))))
 (let (($x451 (<= input_0_net.fin_segment_data ?x448)))
 (let (($x445 (<= v_0_rcv_buf 10)))
 (let (($x443 (= 0 v_0_rx_slot_05)))
 (let (($x450 (and $x307 $x338 $x340 $x443 $x445 (<= ?x448 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x458 (ite $x450 (ite (or $x451 (<= ?x453 1)) (ite $x451 0 ?x453) 1) v_0_rx_slot_05)))
 (let (($x462 (or (= ?x458 0) $x461)))
 (let (($x441 (and $x343 (>= 4 ?x345))))
 (let ((?x428 (mod (+ 4 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x433 (+ input_0_net.fin_segment_data (* ?x273 ?x428))))
 (let (($x431 (<= input_0_net.fin_segment_data ?x428)))
 (let (($x425 (<= v_0_rcv_buf 11)))
 (let (($x423 (= 0 v_0_rx_slot_04)))
 (let (($x430 (and $x307 $x338 $x340 $x423 $x425 (<= ?x428 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x438 (ite $x430 (ite (or $x431 (<= ?x433 1)) (ite $x431 0 ?x433) 1) v_0_rx_slot_04)))
 (let (($x442 (or (= ?x438 0) $x441)))
 (let ((?x658 (ite $x442 4 (ite $x462 5 (ite $x482 6 (ite $x502 7 ?x654))))))
 (let (($x421 (and $x343 (>= 3 ?x345))))
 (let ((?x408 (mod (+ 3 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x413 (+ input_0_net.fin_segment_data (* ?x273 ?x408))))
 (let (($x411 (<= input_0_net.fin_segment_data ?x408)))
 (let (($x405 (<= v_0_rcv_buf 12)))
 (let (($x403 (= 0 v_0_rx_slot_03)))
 (let (($x410 (and $x307 $x338 $x340 $x403 $x405 (<= ?x408 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x418 (ite $x410 (ite (or $x411 (<= ?x413 1)) (ite $x411 0 ?x413) 1) v_0_rx_slot_03)))
 (let (($x422 (or (= ?x418 0) $x421)))
 (let (($x401 (and $x343 (>= 2 ?x345))))
 (let ((?x388 (mod (+ 2 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x393 (+ input_0_net.fin_segment_data (* ?x273 ?x388))))
 (let (($x391 (<= input_0_net.fin_segment_data ?x388)))
 (let (($x385 (<= v_0_rcv_buf 13)))
 (let (($x383 (= 0 v_0_rx_slot_02)))
 (let (($x390 (and $x307 $x338 $x340 $x383 $x385 (<= ?x388 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x398 (ite $x390 (ite (or $x391 (<= ?x393 1)) (ite $x391 0 ?x393) 1) v_0_rx_slot_02)))
 (let (($x402 (or (= ?x398 0) $x401)))
 (let (($x381 (and $x343 (>= 1 ?x345))))
 (let ((?x368 (mod (+ 1 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x373 (+ input_0_net.fin_segment_data (* ?x273 ?x368))))
 (let (($x371 (<= input_0_net.fin_segment_data ?x368)))
 (let (($x366 (<= v_0_rcv_buf 14)))
 (let (($x364 (= 0 v_0_rx_slot_01)))
 (let (($x370 (and $x307 $x338 $x340 $x364 $x366 (<= ?x368 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x378 (ite $x370 (ite (or $x371 (<= ?x373 1)) (ite $x371 0 ?x373) 1) v_0_rx_slot_01)))
 (let (($x379 (= ?x378 0)))
 (let (($x382 (or $x379 $x381)))
 (let ((?x661 (ite $x382 1 (ite $x402 2 (ite $x422 3 ?x658)))))
 (let (($x362 (and $x343 (>= 0 ?x345))))
 (let ((?x276 (mod (+ v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x354 (+ input_0_net.fin_segment_data (* ?x273 ?x276))))
 (let (($x352 (<= input_0_net.fin_segment_data ?x276)))
 (let (($x348 (<= v_0_rcv_buf 15)))
 (let (($x346 (= 0 v_0_rx_slot_00)))
 (let (($x351 (and $x307 $x338 $x340 $x346 $x348 (<= ?x276 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x359 (ite $x351 (ite (or $x352 (<= ?x354 1)) (ite $x352 0 ?x354) 1) v_0_rx_slot_00)))
 (let (($x360 (= ?x359 0)))
 (let (($x363 (or $x360 $x362)))
 (let ((?x662 (ite $x363 0 ?x661)))
 (let ((?x665 (ite $x343 (+ ?x345 (* ?x273 ?x662)) ?x345)))
 (let (($x666 (= 0 ?x665)))
 (let (($x669 (and $x343 $x340 $x666 $x307 $x325 $x328 v_0_fin_sent $x329)))
 (let (($x1509 (= due_1_user due_0_user)))
 (let (($x717 (not v_0_rtt_ambiguous)))
 (let ((?x714 (mod (+ v_0_rtt_end (* ?x273 v_0_snd_una)) 4294967296)))
 (let (($x715 (>= ?x286 ?x714)))
 (let (($x718 (and v_0_rtt_active $x307 $x325 $x328 $x715 $x717)))
 (let ((?x733 (ite $x718 (+ now_1 (* ?x273 v_0_rtt_start_ms)) v_0_rtt_last_ms)))
 (let ((?x734 (to_real ?x733)))
 (let ((?x758 (/ 1.0 2.0)))
 (let ((?x747 (+ v_0_srtt_ms (* (- 1.0) ?x734))))
 (let ((?x754 (ite $x718 (ite (>= ?x747 0.0) ?x747 (+ (* (- 1.0) v_0_srtt_ms) ?x734)) v_0_rtt_error_ms)))
 (let ((?x745 (/ 1.0 4.0)))
 (let ((?x760 (ite v_0_rtt_measured (+ (* (/ 3.0 4.0) v_0_rttvar_ms) (* ?x745 ?x754)) (* ?x758 ?x734))))
 (let ((?x761 (ite $x718 ?x760 v_0_rttvar_ms)))
 (let ((?x721 (- 1.0)))
 (let ((?x737 (ite v_0_rtt_measured (+ (* (/ 7.0 8.0) v_0_srtt_ms) (* (/ 1.0 8.0) ?x734)) ?x734)))
 (let ((?x738 (ite $x718 ?x737 v_0_srtt_ms)))
 (let ((?x766 (+ (* ?x721 ?x738) (* ?x721 (ite (<= ?x761 ?x745) 1.0 (* 4.0 ?x761))))))
 (let ((?x767 (to_int ?x766)))
 (let ((?x772 (ite (<= ?x767 (- 1000)) (* ?x273 ?x767) 1000)))
 (let ((?x774 (ite (<= 60000 ?x772) 60000 ?x772)))
 (let ((?x776 (ite $x718 ?x774 v_0_rto_ms)))
 (let (($x330 (and $x307 $x325 $x328 v_0_fin_sent $x329)))
 (let (($x331 (not $x330)))
 (let (($x1102 (and $x331 v_0_fin_sent)))
 (let ((?x801 (ite (<= 0 v_0_rtx_buf) v_0_rtx_buf 0)))
 (let ((?x799 (ite (<= v_0_rtx_buf ?x286) 0 (+ v_0_rtx_buf (* ?x273 ?x286)))))
 (let (($x673 (and $x307 $x325 $x328)))
 (let ((?x804 (ite $x673 (ite (<= ?x799 ?x801) ?x799 ?x801) v_0_rtx_buf)))
 (let ((?x1486 (+ ?x804 (ite $x1102 1 0))))
 (let (($x1488 (and $x307 $x325 $x328 (<= 1 ?x1486))))
 (let (($x1503 (not active_1_delack)))
 (let (($x1493 (or $x1488 (and (not (and $x307 $x325 $x328 (= 0 ?x1486))) active_0_rtx))))
 (let (($x670 (not $x669)))
 (let (($x1483 (not v_1_ack_defer_now)))
 (let (($x1481 (not v_1_ack_defer_candidate)))
 (let (($x1479 (= v_1_ack_rmss v_0_ack_rmss)))
 (let (($x1476 (= v_1_ack_delay_ms v_0_ack_delay_ms)))
 (let (($x1473 (= v_1_ack_full_segments 0)))
 (let (($x1471 (= v_1_ack_bytes 0)))
 (let (($x1469 (= v_1_ack_since_ms 0)))
 (let (($x1467 (not v_1_ack_pending)))
 (let (($x1465 (not v_1_syn_timeout_eligible)))
 (let (($x1463 (not v_1_tx_syn_pending)))
 (let (($x1461 (= v_1_tx_syn_time 0)))
 (let (($x1459 (not v_1_tx_waiting)))
 (let (($x1457 (= v_1_tx_is_fin v_0_tx_is_fin)))
 (let (($x1454 (= v_1_tx_previous_rto v_0_tx_previous_rto)))
 (let (($x1451 (= v_1_tx_elapsed v_0_tx_elapsed)))
 (let (($x1448 (not v_1_tx_retransmitted)))
 (let (($x1446 (= v_1_tx_max_previous v_0_tx_max_previous)))
 (let (($x1443 (= v_1_tx_eligible v_0_tx_eligible)))
 (let (($x1440 (= v_1_tx_emit_count v_0_tx_emit_count)))
 (let (($x1190 (and $x307 $x325 $x328 (not (= 0 ?x286)))))
 (let (($x1186 (= 0 ?x804)))
 (let (($x1433 (= v_1_tx_time_15 (ite (or $x1186 $x1190 (>= 15 ?x804)) 0 v_0_tx_time_15))))
 (let ((?x1427 (ite (or (>= 14 ?x804) $x1186) 0 (ite $x1190 (ite (= 1 ?x286) v_0_tx_time_15 0) v_0_tx_time_14))))
 (let (($x1191 (= 1 ?x286)))
 (let ((?x1419 (ite $x1190 (ite $x1191 v_0_tx_time_14 (ite (= 2 ?x286) v_0_tx_time_15 0)) v_0_tx_time_13)))
 (let (($x1193 (= 2 ?x286)))
 (let ((?x1410 (ite $x1191 v_0_tx_time_13 (ite $x1193 v_0_tx_time_14 (ite (= 3 ?x286) v_0_tx_time_15 0)))))
 (let (($x1413 (= v_1_tx_time_12 (ite (or (>= 12 ?x804) $x1186) 0 (ite $x1190 ?x1410 v_0_tx_time_12)))))
 (let (($x1195 (= 3 ?x286)))
 (let ((?x1400 (ite $x1193 v_0_tx_time_13 (ite $x1195 v_0_tx_time_14 (ite (= 4 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1403 (ite (or $x1186 (>= 11 ?x804)) 0 (ite $x1190 (ite $x1191 v_0_tx_time_12 ?x1400) v_0_tx_time_11))))
 (let (($x1197 (= 4 ?x286)))
 (let ((?x1389 (ite $x1195 v_0_tx_time_13 (ite $x1197 v_0_tx_time_14 (ite (= 5 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1392 (ite $x1190 (ite $x1191 v_0_tx_time_11 (ite $x1193 v_0_tx_time_12 ?x1389)) v_0_tx_time_10)))
 (let (($x1199 (= 5 ?x286)))
 (let ((?x1377 (ite $x1197 v_0_tx_time_13 (ite $x1199 v_0_tx_time_14 (ite (= 6 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1380 (ite $x1191 v_0_tx_time_10 (ite $x1193 v_0_tx_time_11 (ite $x1195 v_0_tx_time_12 ?x1377)))))
 (let (($x1383 (= v_1_tx_time_09 (ite (or $x1186 (>= 9 ?x804)) 0 (ite $x1190 ?x1380 v_0_tx_time_09)))))
 (let (($x1201 (= 6 ?x286)))
 (let ((?x1364 (ite $x1199 v_0_tx_time_13 (ite $x1201 v_0_tx_time_14 (ite (= 7 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1367 (ite $x1193 v_0_tx_time_10 (ite $x1195 v_0_tx_time_11 (ite $x1197 v_0_tx_time_12 ?x1364)))))
 (let ((?x1370 (ite (or (>= 8 ?x804) $x1186) 0 (ite $x1190 (ite $x1191 v_0_tx_time_09 ?x1367) v_0_tx_time_08))))
 (let (($x1203 (= 7 ?x286)))
 (let ((?x1350 (ite $x1201 v_0_tx_time_13 (ite $x1203 v_0_tx_time_14 (ite (= 8 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1353 (ite $x1195 v_0_tx_time_10 (ite $x1197 v_0_tx_time_11 (ite $x1199 v_0_tx_time_12 ?x1350)))))
 (let ((?x1356 (ite $x1190 (ite $x1191 v_0_tx_time_08 (ite $x1193 v_0_tx_time_09 ?x1353)) v_0_tx_time_07)))
 (let (($x1205 (= 8 ?x286)))
 (let ((?x1335 (ite $x1203 v_0_tx_time_13 (ite $x1205 v_0_tx_time_14 (ite (= 9 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1338 (ite $x1197 v_0_tx_time_10 (ite $x1199 v_0_tx_time_11 (ite $x1201 v_0_tx_time_12 ?x1335)))))
 (let ((?x1341 (ite $x1191 v_0_tx_time_07 (ite $x1193 v_0_tx_time_08 (ite $x1195 v_0_tx_time_09 ?x1338)))))
 (let (($x1344 (= v_1_tx_time_06 (ite (or $x1186 (>= 6 ?x804)) 0 (ite $x1190 ?x1341 v_0_tx_time_06)))))
 (let (($x1207 (= 9 ?x286)))
 (let ((?x1319 (ite $x1205 v_0_tx_time_13 (ite $x1207 v_0_tx_time_14 (ite (= 10 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1322 (ite $x1199 v_0_tx_time_10 (ite $x1201 v_0_tx_time_11 (ite $x1203 v_0_tx_time_12 ?x1319)))))
 (let ((?x1325 (ite $x1193 v_0_tx_time_07 (ite $x1195 v_0_tx_time_08 (ite $x1197 v_0_tx_time_09 ?x1322)))))
 (let ((?x1328 (ite (or (>= 5 ?x804) $x1186) 0 (ite $x1190 (ite $x1191 v_0_tx_time_06 ?x1325) v_0_tx_time_05))))
 (let (($x1209 (= 10 ?x286)))
 (let ((?x1302 (ite $x1207 v_0_tx_time_13 (ite $x1209 v_0_tx_time_14 (ite (= 11 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1305 (ite $x1201 v_0_tx_time_10 (ite $x1203 v_0_tx_time_11 (ite $x1205 v_0_tx_time_12 ?x1302)))))
 (let ((?x1308 (ite $x1195 v_0_tx_time_07 (ite $x1197 v_0_tx_time_08 (ite $x1199 v_0_tx_time_09 ?x1305)))))
 (let ((?x1311 (ite $x1190 (ite $x1191 v_0_tx_time_05 (ite $x1193 v_0_tx_time_06 ?x1308)) v_0_tx_time_04)))
 (let (($x1211 (= 11 ?x286)))
 (let ((?x1284 (ite $x1209 v_0_tx_time_13 (ite $x1211 v_0_tx_time_14 (ite (= 12 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1287 (ite $x1203 v_0_tx_time_10 (ite $x1205 v_0_tx_time_11 (ite $x1207 v_0_tx_time_12 ?x1284)))))
 (let ((?x1290 (ite $x1197 v_0_tx_time_07 (ite $x1199 v_0_tx_time_08 (ite $x1201 v_0_tx_time_09 ?x1287)))))
 (let ((?x1293 (ite $x1191 v_0_tx_time_04 (ite $x1193 v_0_tx_time_05 (ite $x1195 v_0_tx_time_06 ?x1290)))))
 (let (($x1296 (= v_1_tx_time_03 (ite (or (>= 3 ?x804) $x1186) 0 (ite $x1190 ?x1293 v_0_tx_time_03)))))
 (let (($x1213 (= 12 ?x286)))
 (let ((?x1265 (ite $x1211 v_0_tx_time_13 (ite $x1213 v_0_tx_time_14 (ite (= 13 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1268 (ite $x1205 v_0_tx_time_10 (ite $x1207 v_0_tx_time_11 (ite $x1209 v_0_tx_time_12 ?x1265)))))
 (let ((?x1271 (ite $x1199 v_0_tx_time_07 (ite $x1201 v_0_tx_time_08 (ite $x1203 v_0_tx_time_09 ?x1268)))))
 (let ((?x1274 (ite $x1193 v_0_tx_time_04 (ite $x1195 v_0_tx_time_05 (ite $x1197 v_0_tx_time_06 ?x1271)))))
 (let ((?x1277 (ite (or (>= 2 ?x804) $x1186) 0 (ite $x1190 (ite $x1191 v_0_tx_time_03 ?x1274) v_0_tx_time_02))))
 (let (($x1215 (= 13 ?x286)))
 (let ((?x1245 (ite $x1213 v_0_tx_time_13 (ite $x1215 v_0_tx_time_14 (ite (= 14 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1248 (ite $x1207 v_0_tx_time_10 (ite $x1209 v_0_tx_time_11 (ite $x1211 v_0_tx_time_12 ?x1245)))))
 (let ((?x1251 (ite $x1201 v_0_tx_time_07 (ite $x1203 v_0_tx_time_08 (ite $x1205 v_0_tx_time_09 ?x1248)))))
 (let ((?x1254 (ite $x1195 v_0_tx_time_04 (ite $x1197 v_0_tx_time_05 (ite $x1199 v_0_tx_time_06 ?x1251)))))
 (let ((?x1257 (ite $x1190 (ite $x1191 v_0_tx_time_02 (ite $x1193 v_0_tx_time_03 ?x1254)) v_0_tx_time_01)))
 (let (($x1217 (= 14 ?x286)))
 (let ((?x1223 (ite $x1215 v_0_tx_time_13 (ite $x1217 v_0_tx_time_14 (ite (= 15 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1226 (ite $x1209 v_0_tx_time_10 (ite $x1211 v_0_tx_time_11 (ite $x1213 v_0_tx_time_12 ?x1223)))))
 (let ((?x1229 (ite $x1203 v_0_tx_time_07 (ite $x1205 v_0_tx_time_08 (ite $x1207 v_0_tx_time_09 ?x1226)))))
 (let ((?x1232 (ite $x1197 v_0_tx_time_04 (ite $x1199 v_0_tx_time_05 (ite $x1201 v_0_tx_time_06 ?x1229)))))
 (let ((?x1235 (ite $x1191 v_0_tx_time_01 (ite $x1193 v_0_tx_time_02 (ite $x1195 v_0_tx_time_03 ?x1232)))))
 (let (($x1239 (= v_1_tx_time_00 (ite (or $x1186 (>= 0 ?x804)) 0 (ite $x1190 ?x1235 v_0_tx_time_00)))))
 (let (($x1173 (= v_1_rtt_sample_was_ambiguous (and v_0_rtt_active v_0_rtt_ambiguous))))
 (let (($x1168 (not v_1_rtt_start_new)))
 (let ((?x797 (* ?x273 ?x286)))
 (let ((?x1160 (+ ?x714 ?x797)))
 (let (($x1163 (and v_0_rtt_active $x307 $x325 $x328 (not (<= v_0_rtt_remaining ?x1160)))))
 (let (($x1144 (and v_0_rtt_active $x307 $x325 $x328 $x715)))
 (let (($x1166 (= v_1_rtt_remaining (ite $x1144 0 (ite $x1163 ?x1160 v_0_rtt_remaining)))))
 (let (($x1157 (= v_1_rtt_end v_0_rtt_end)))
 (let (($x1156 (= v_1_rtt_start_ms v_0_rtt_start_ms)))
 (let (($x1142 (= v_1_rtt_previous_measured (ite $x718 v_0_rtt_measured v_0_rtt_previous_measured))))
 (let (($x1135 (= v_1_rtt_previous_var (ite $x718 v_0_rttvar_ms v_0_rtt_previous_var))))
 (let (($x1131 (= v_1_rtt_previous_srtt (ite $x718 v_0_srtt_ms v_0_rtt_previous_srtt))))
 (let ((?x1111 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data) 4294967296)))
 (let (($x1104 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x1100 (= v_1_fin_requested v_0_fin_requested)))
 (let (($x821 (<= 2147483648 (mod (+ input_0_net.fin_segment_ack (* ?x273 v_0_snd_wl2)) 4294967296))))
 (let (($x817 (= v_0_snd_wl1 input_0_net.fin_segment_seq)))
 (let ((?x811 (mod (+ input_0_net.fin_segment_seq (* ?x273 v_0_snd_wl1)) 4294967296)))
 (let (($x824 (or (and (not (<= ?x811 0)) (not (<= 2147483648 ?x811))) (and $x817 (not $x821)))))
 (let (($x825 (and $x307 $x328 $x824)))
 (let ((?x1078 (ite (or (not (and (or $x362 $x360) (not $x645))) (and $x343 $x340 $x666)) 0 ?x642)))
 (let (($x894 (not $x645)))
 (let (($x697 (not $x363)))
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
 (let (($x865 (or (and $x862 $x863) $x381 $x379)))
 (let ((?x691 (ite $x627 0 ?x624)))
 (let (($x837 (or $x362 $x360)))
 (let (($x667 (and $x343 $x340 $x666)))
 (let (($x1074 (= v_1_rx_slot_14 (ite $x667 0 (ite $x837 ?x691 (ite (and $x865 $x697 $x894) ?x642 0))))))
 (let (($x866 (and $x865 $x697)))
 (let ((?x1066 (ite $x866 ?x691 (ite (and (or $x862 $x402) (not $x382) $x697 $x894) ?x642 0))))
 (let ((?x690 (ite $x609 0 ?x606)))
 (let (($x868 (not $x382)))
 (let (($x867 (or $x862 $x402)))
 (let (($x869 (and $x867 $x868 $x697)))
 (let ((?x1059 (ite $x869 ?x691 (ite (and (or $x860 $x422) $x863 $x868 $x697 $x894) ?x642 0))))
 (let ((?x689 (ite $x591 0 ?x588)))
 (let (($x1063 (= v_1_rx_slot_12 (ite $x667 0 (ite $x837 ?x689 (ite $x866 ?x690 ?x1059))))))
 (let (($x870 (or $x860 $x422)))
 (let (($x871 (and $x870 $x863 $x868 $x697)))
 (let ((?x1051 (ite $x871 ?x691 (ite (and (or $x858 $x442) $x861 $x863 $x868 $x697 $x894) ?x642 0))))
 (let ((?x688 (ite $x573 0 ?x570)))
 (let (($x1056 (= v_1_rx_slot_11 (ite $x667 0 (ite $x837 ?x688 (ite $x866 ?x689 (ite $x869 ?x690 ?x1051)))))))
 (let (($x872 (or $x858 $x442)))
 (let (($x873 (and $x872 $x861 $x863 $x868 $x697)))
 (let ((?x1042 (ite $x873 ?x691 (ite (and (or $x856 $x462) $x859 $x861 $x863 $x868 $x697 $x894) ?x642 0))))
 (let ((?x687 (ite $x555 0 ?x552)))
 (let ((?x1047 (ite $x667 0 (ite $x837 ?x687 (ite $x866 ?x688 (ite $x869 ?x689 (ite $x871 ?x690 ?x1042)))))))
 (let ((?x1031 (ite (and (or $x854 $x482) $x857 $x859 $x861 $x863 $x868 $x697 $x894) ?x642 0)))
 (let (($x874 (or $x856 $x462)))
 (let (($x875 (and $x874 $x859 $x861 $x863 $x868 $x697)))
 (let ((?x1036 (ite $x866 ?x687 (ite $x869 ?x688 (ite $x871 ?x689 (ite $x873 ?x690 (ite $x875 ?x691 ?x1031)))))))
 (let ((?x686 (ite $x537 0 ?x534)))
 (let ((?x1020 (ite (and (or $x852 $x502) $x855 $x857 $x859 $x861 $x863 $x868 $x697 $x894) ?x642 0)))
 (let (($x876 (or $x854 $x482)))
 (let (($x877 (and $x876 $x857 $x859 $x861 $x863 $x868 $x697)))
 (let ((?x1025 (ite $x869 ?x687 (ite $x871 ?x688 (ite $x873 ?x689 (ite $x875 ?x690 (ite $x877 ?x691 ?x1020)))))))
 (let ((?x685 (ite $x519 0 ?x516)))
 (let (($x1029 (= v_1_rx_slot_08 (ite $x667 0 (ite $x837 ?x685 (ite $x866 ?x686 ?x1025))))))
 (let ((?x1008 (ite (and (or $x850 $x520) $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x697 $x894) ?x642 0)))
 (let (($x878 (or $x852 $x502)))
 (let (($x879 (and $x878 $x855 $x857 $x859 $x861 $x863 $x868 $x697)))
 (let ((?x1013 (ite $x871 ?x687 (ite $x873 ?x688 (ite $x875 ?x689 (ite $x877 ?x690 (ite $x879 ?x691 ?x1008)))))))
 (let ((?x684 (ite $x501 0 ?x498)))
 (let (($x1018 (= v_1_rx_slot_07 (ite $x667 0 (ite $x837 ?x684 (ite $x866 ?x685 (ite $x869 ?x686 ?x1013)))))))
 (let (($x882 (or $x848 $x538)))
 (let ((?x995 (ite (and $x882 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x697 $x894) ?x642 0)))
 (let (($x880 (or $x850 $x520)))
 (let (($x881 (and $x880 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x697)))
 (let ((?x1000 (ite $x873 ?x687 (ite $x875 ?x688 (ite $x877 ?x689 (ite $x879 ?x690 (ite $x881 ?x691 ?x995)))))))
 (let ((?x683 (ite $x481 0 ?x478)))
 (let ((?x1005 (ite $x667 0 (ite $x837 ?x683 (ite $x866 ?x684 (ite $x869 ?x685 (ite $x871 ?x686 ?x1000)))))))
 (let (($x884 (or $x846 $x556)))
 (let ((?x981 (ite (and $x884 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x697 $x894) ?x642 0)))
 (let (($x883 (and $x882 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x697)))
 (let ((?x986 (ite $x875 ?x687 (ite $x877 ?x688 (ite $x879 ?x689 (ite $x881 ?x690 (ite $x883 ?x691 ?x981)))))))
 (let ((?x682 (ite $x461 0 ?x458)))
 (let ((?x991 (ite $x837 ?x682 (ite $x866 ?x683 (ite $x869 ?x684 (ite $x871 ?x685 (ite $x873 ?x686 ?x986)))))))
 (let (($x886 (or $x844 $x574)))
 (let (($x965 (and $x886 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x697 $x894)))
 (let (($x885 (and $x884 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x697)))
 (let ((?x970 (ite $x879 ?x688 (ite $x881 ?x689 (ite $x883 ?x690 (ite $x885 ?x691 (ite $x965 ?x642 0)))))))
 (let ((?x975 (ite $x869 ?x683 (ite $x871 ?x684 (ite $x873 ?x685 (ite $x875 ?x686 (ite $x877 ?x687 ?x970)))))))
 (let ((?x681 (ite $x441 0 ?x438)))
 (let (($x979 (= v_1_rx_slot_04 (ite $x667 0 (ite $x837 ?x681 (ite $x866 ?x682 ?x975))))))
 (let (($x888 (or $x842 $x592)))
 (let (($x949 (and $x888 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x697 $x894)))
 (let (($x887 (and $x886 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x697)))
 (let ((?x954 (ite $x881 ?x688 (ite $x883 ?x689 (ite $x885 ?x690 (ite $x887 ?x691 (ite $x949 ?x642 0)))))))
 (let ((?x959 (ite $x871 ?x683 (ite $x873 ?x684 (ite $x875 ?x685 (ite $x877 ?x686 (ite $x879 ?x687 ?x954)))))))
 (let ((?x680 (ite $x421 0 ?x418)))
 (let (($x964 (= v_1_rx_slot_03 (ite $x667 0 (ite $x837 ?x680 (ite $x866 ?x681 (ite $x869 ?x682 ?x959)))))))
 (let (($x890 (or $x840 $x610)))
 (let (($x932 (and $x890 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x697 $x894)))
 (let (($x889 (and $x888 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x697)))
 (let ((?x937 (ite $x883 ?x688 (ite $x885 ?x689 (ite $x887 ?x690 (ite $x889 ?x691 (ite $x932 ?x642 0)))))))
 (let ((?x942 (ite $x873 ?x683 (ite $x875 ?x684 (ite $x877 ?x685 (ite $x879 ?x686 (ite $x881 ?x687 ?x937)))))))
 (let ((?x679 (ite $x401 0 ?x398)))
 (let ((?x947 (ite $x667 0 (ite $x837 ?x679 (ite $x866 ?x680 (ite $x869 ?x681 (ite $x871 ?x682 ?x942)))))))
 (let (($x892 (or $x838 $x628)))
 (let (($x914 (and $x892 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x697 $x894)))
 (let (($x891 (and $x890 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x697)))
 (let ((?x919 (ite $x885 ?x688 (ite $x887 ?x689 (ite $x889 ?x690 (ite $x891 ?x691 (ite $x914 ?x642 0)))))))
 (let ((?x924 (ite $x875 ?x683 (ite $x877 ?x684 (ite $x879 ?x685 (ite $x881 ?x686 (ite $x883 ?x687 ?x919)))))))
 (let ((?x678 (ite $x381 0 ?x378)))
 (let ((?x929 (ite $x837 ?x678 (ite $x866 ?x679 (ite $x869 ?x680 (ite $x871 ?x681 (ite $x873 ?x682 ?x924)))))))
 (let (($x895 (and $x646 $x839 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x697 $x894)))
 (let (($x893 (and $x892 $x841 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x868 $x697)))
 (let ((?x900 (ite $x887 ?x688 (ite $x889 ?x689 (ite $x891 ?x690 (ite $x893 ?x691 (ite $x895 ?x642 0)))))))
 (let ((?x905 (ite $x877 ?x683 (ite $x879 ?x684 (ite $x881 ?x685 (ite $x883 ?x686 (ite $x885 ?x687 ?x900)))))))
 (let ((?x910 (ite $x866 ?x678 (ite $x869 ?x679 (ite $x871 ?x680 (ite $x873 ?x681 (ite $x875 ?x682 ?x905)))))))
 (let ((?x677 (ite $x362 0 ?x359)))
 (let ((?x699 (ite (and (<= 0 ?x662) $x697) ?x661 0)))
 (let ((?x693 (+ ?x677 ?x678 ?x679 ?x680 ?x681 ?x682 ?x683 ?x684 ?x685 ?x686 ?x687 ?x688 ?x689 ?x690 ?x691 (ite $x645 0 ?x642))))
 (let ((?x695 (ite (<= ?x693 0) 0 ?x693)))
 (let ((?x701 (ite (<= ?x695 ?x699) ?x695 ?x699)))
 (let (($x835 (= v_1_take v_0_take)))
 (let (($x795 (= v_1_snd_buf v_0_snd_buf)))
 (let (($x789 (= v_1_msl_ms v_0_msl_ms)))
 (let (($x786 (= v_1_user_timeout_ms v_0_user_timeout_ms)))
 (let (($x783 (= v_1_active_open v_0_active_open)))
 (let (($x780 (= v_1_retries v_0_retries)))
 (let (($x710 (= v_1_tx_flags v_0_tx_flags)))
 (let (($x707 (= v_1_tx_ack v_0_tx_ack)))
 (let (($x706 (= v_1_tx_seq v_0_tx_seq)))
 (let (($x705 (= v_1_rcv_nxt (mod (+ v_0_rcv_nxt ?x701 (ite $x667 1 0)) 4294967296))))
 (let (($x676 (= v_1_snd_nxt v_0_snd_nxt)))
 (let (($x672 (= v_1_irs v_0_irs)))
 (let (($x671 (= v_1_iss v_0_iss)))
 (let (($x668 (not $x667)))
 (let (($x312 (= 0 ?x286)))
 (let (($x311 (not v_0_fin_sent)))
 (let (($x292 (= (mod (+ input_0_net.fin_segment_ack (* ?x273 v_0_snd_nxt)) 4294967296) 2147483648)))
 (and (>= now_1 now_0) (<= 0 input_0_net.fin_segment_data) (>= 16 input_0_net.fin_segment_data) (not (= ?x276 2147483648)) (<= 0 input_0_net.fin_segment_window) (>= 65535 input_0_net.fin_segment_window) (or (and (not (= ?x286 2147483648)) (not $x292)) (not $x307)) $x311 $x312 (or (not active_0_rtx) (not (<= due_0_rtx now_1))) (or (not active_0_user) (not (<= due_0_user now_1))) (or (not active_0_time_wait) (not (<= due_0_time_wait now_1))) (or (not active_0_delack) (not (<= due_0_delack now_1))) $x331 $x668 $x670 $x671 $x672 (= v_1_snd_una (ite $x673 input_0_net.fin_segment_ack v_0_snd_una)) $x676 $x705 $x706 $x707 $x710 (= v_1_rto_ms ?x776) $x780 $x783 $x786 $x789 (= v_1_local_window (+ 16 (* ?x273 v_0_rcv_buf) (* ?x273 ?x701))) $x795 (= v_1_rtx_buf ?x804) (= v_1_rcv_buf (+ v_0_rcv_buf ?x701)) (= v_1_snd_wnd (ite $x825 input_0_net.fin_segment_window v_0_snd_wnd)) (= v_1_snd_wl1 (ite $x825 input_0_net.fin_segment_seq v_0_snd_wl1)) (= v_1_snd_wl2 (ite $x825 input_0_net.fin_segment_ack v_0_snd_wl2)) $x835 (= v_1_rx_chunk ?x701) (= v_1_rx_slot_00 (ite $x667 0 (ite $x837 ?x677 ?x910))) (= v_1_rx_slot_01 (ite $x667 0 ?x929)) (= v_1_rx_slot_02 ?x947) $x964 $x979 (= v_1_rx_slot_05 (ite $x667 0 ?x991)) (= v_1_rx_slot_06 ?x1005) $x1018 $x1029 (= v_1_rx_slot_09 (ite $x667 0 (ite $x837 ?x686 ?x1036))) (= v_1_rx_slot_10 ?x1047) $x1056 $x1063 (= v_1_rx_slot_13 (ite $x667 0 (ite $x837 ?x690 ?x1066))) $x1074 (= v_1_rx_slot_15 ?x1078) (= v_1_rx_advance ?x662) (= v_1_rx_acceptable (and $x307 $x338 $x340)) (= v_1_seg_acceptable $x307) (= v_1_ack_delta ?x286) (= v_1_ack_is_new (and $x325 $x328)) (= v_1_ack_is_future $x337) (= v_1_ack_advance $x673) (= v_1_ack_window_update $x825) $x1100 (= v_1_fin_sent $x1102) $x1104 (= v_1_fin_acknowledged $x330) (= v_1_rx_fin_pending (and $x343 $x668)) (= v_1_rx_fin_seq (ite $x342 ?x1111 v_0_rx_fin_seq)) (= v_1_rx_fin_offset (ite $x667 0 ?x665)) (= v_1_rx_fin_done (or v_0_rx_fin_done $x667)) (= v_1_rx_fin_consumed $x667) (= v_1_srtt_ms ?x738) (= v_1_rttvar_ms ?x761) (= v_1_rtt_error_ms ?x754) $x1131 $x1135 (= v_1_rtt_measured (or v_0_rtt_measured $x718)) $x1142 (= v_1_rtt_active (and v_0_rtt_active (not $x1144))) (= v_1_rtt_ambiguous (and (not $x1144) v_0_rtt_ambiguous)) (= v_1_rtt_sample_at_ms (ite $x718 now_1 v_0_rtt_sample_at_ms)) $x1156 $x1157 $x1166 $x1168 (= v_1_rtt_sample_used $x718) $x1173 (= v_1_rtt_last_ms ?x733) (= v_1_rtt_samples (+ v_0_rtt_samples (ite $x718 1 0))) (= v_1_rto_base_ms (ite $x718 ?x774 v_0_rto_base_ms)) $x1239 (= v_1_tx_time_01 (ite (or (>= 1 ?x804) $x1186) 0 ?x1257)) (= v_1_tx_time_02 ?x1277) $x1296 (= v_1_tx_time_04 (ite (or (>= 4 ?x804) $x1186) 0 ?x1311)) (= v_1_tx_time_05 ?x1328) $x1344 (= v_1_tx_time_07 (ite (or $x1186 (>= 7 ?x804)) 0 ?x1356)) (= v_1_tx_time_08 ?x1370) $x1383 (= v_1_tx_time_10 (ite (or $x1186 (>= 10 ?x804)) 0 ?x1392)) (= v_1_tx_time_11 ?x1403) $x1413 (= v_1_tx_time_13 (ite (or $x1186 (>= 13 ?x804)) 0 ?x1419)) (= v_1_tx_time_14 ?x1427) $x1433 (= v_1_tx_fin_time (ite $x1102 v_0_tx_fin_time 0)) $x1440 $x1443 $x1446 $x1448 $x1451 $x1454 $x1457 $x1459 $x1461 $x1463 $x1465 $x1467 $x1469 $x1471 $x1473 $x1476 $x1479 $x1481 $x1483 (= active_1_rtx (and $x670 $x1493)) (= active_1_user (and $x670 active_0_user)) (= active_1_time_wait (or active_0_time_wait $x669)) $x1503 (= due_1_rtx (ite $x1488 (+ now_1 ?x776) due_0_rtx)) $x1509 (= due_1_time_wait (ite $x669 ?x1512 due_0_time_wait)) $x1516))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
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
 (let ((?x1522 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1522)))
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
 (let (($x1532 (not (>= v_0_rcv_buf 16))))
 (or $x1532 $x346))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x364 (= 0 v_0_rx_slot_01)))
 (let (($x1536 (not (>= v_0_rcv_buf 15))))
 (or $x1536 $x364))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x383 (= 0 v_0_rx_slot_02)))
 (let (($x1540 (not (>= v_0_rcv_buf 14))))
 (or $x1540 $x383))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x403 (= 0 v_0_rx_slot_03)))
 (let (($x1544 (not (>= v_0_rcv_buf 13))))
 (or $x1544 $x403))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x423 (= 0 v_0_rx_slot_04)))
 (let (($x1548 (not (>= v_0_rcv_buf 12))))
 (or $x1548 $x423))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x443 (= 0 v_0_rx_slot_05)))
 (let (($x1552 (not (>= v_0_rcv_buf 11))))
 (or $x1552 $x443))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x463 (= 0 v_0_rx_slot_06)))
 (let (($x1556 (not (>= v_0_rcv_buf 10))))
 (or $x1556 $x463))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x483 (= 0 v_0_rx_slot_07)))
 (let (($x1560 (not (>= v_0_rcv_buf 9))))
 (or $x1560 $x483))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x503 (= 0 v_0_rx_slot_08)))
 (let (($x1564 (not (>= v_0_rcv_buf 8))))
 (or $x1564 $x503))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x521 (= 0 v_0_rx_slot_09)))
 (let (($x1568 (not (>= v_0_rcv_buf 7))))
 (or $x1568 $x521))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x539 (= 0 v_0_rx_slot_10)))
 (let (($x1572 (not (>= v_0_rcv_buf 6))))
 (or $x1572 $x539))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x557 (= 0 v_0_rx_slot_11)))
 (let (($x1576 (not (>= v_0_rcv_buf 5))))
 (or $x1576 $x557))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x575 (= 0 v_0_rx_slot_12)))
 (let (($x1580 (not (>= v_0_rcv_buf 4))))
 (or $x1580 $x575))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x593 (= 0 v_0_rx_slot_13)))
 (let (($x1584 (not (>= v_0_rcv_buf 3))))
 (or $x1584 $x593))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x611 (= 0 v_0_rx_slot_14)))
 (let (($x1588 (not (>= v_0_rcv_buf 2))))
 (or $x1588 $x611))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x629 (= 0 v_0_rx_slot_15)))
 (let (($x1592 (not (>= v_0_rcv_buf 1))))
 (or $x1592 $x629))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x1594 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x1594)))
(assert
 (and (<= 0 v_0_rx_advance) (>= 16 v_0_rx_advance)))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (and (<= 0 v_0_ack_delta) (>= 4294967295 v_0_ack_delta)))
(assert
 true)
(assert
 (let ((?x1607 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x1607)))
(assert
 (= active_0_rtx (<= 1 (+ v_0_rtx_buf (ite v_0_fin_sent 1 0)))))
(assert
 (let (($x1615 (and v_0_fin_requested (= v_0_fin_seq (mod (+ v_0_snd_una v_0_rtx_buf) 4294967296)) (= 0 v_0_snd_buf))))
 (let (($x311 (not v_0_fin_sent)))
 (or $x311 $x1615))))
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
 (let (($x1617 (<= 1 v_0_rx_fin_offset)))
 (let (($x340 (not v_0_rx_fin_done)))
 (let (($x1619 (and $x340 $x1617 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window)))))
 (let (($x341 (not v_0_rx_fin_pending)))
 (or $x341 $x1619))))))
(assert
 (let (($x1622 (>= 15 v_0_rx_fin_offset)))
 (and (<= 0 v_0_rx_fin_offset) $x1622 (= v_0_rx_fin_pending (<= 1 v_0_rx_fin_offset)))))
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
 (let ((?x1710 (* 4.0 v_0_rttvar_ms)))
 (let ((?x721 (- 1.0)))
 (let ((?x750 (* ?x721 v_0_srtt_ms)))
 (let ((?x1713 (+ ?x750 (* ?x721 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x1710)))))
 (let ((?x1714 (to_int ?x1713)))
 (let ((?x273 (- 1)))
 (let ((?x1717 (ite (<= ?x1714 (- 1000)) (* ?x273 ?x1714) 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x1717) 60000 ?x1717) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x714 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x1732 (and (<= v_0_rtt_start_ms now_0) (<= 1 v_0_rtt_remaining) (>= 4 v_0_rtt_remaining) (>= ?x714 v_0_rtt_remaining) (<= ?x714 (mod (+ v_0_snd_nxt (* (- 1) v_0_snd_una)) 4294967296)))))
 (let (($x1724 (not v_0_rtt_active)))
 (or $x1724 $x1732)))))
(assert
 (or v_0_rtt_active (= 0 v_0_rtt_remaining)))
(assert
 true)
(assert
 (let (($x1741 (= v_0_rtt_last_ms (+ v_0_rtt_sample_at_ms (* (- 1) v_0_rtt_start_ms)))))
 (let (($x1739 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1737 (not v_0_rtt_sample_used)))
 (or $x1737 (and $x1739 v_0_rtt_measured $x1741))))))
(assert
 (and (<= 0 v_0_rtt_sample_at_ms) (<= v_0_rtt_sample_at_ms now_0)))
(assert
 (let ((?x1748 (to_real v_0_rtt_last_ms)))
 (let ((?x1762 (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x1748))))
 (let ((?x1750 (+ v_0_rtt_previous_srtt (* (- 1.0) ?x1748))))
 (let ((?x1754 (ite (>= ?x1750 0.0) ?x1750 (+ (* (- 1.0) v_0_rtt_previous_srtt) ?x1748))))
 (let ((?x745 (/ 1.0 4.0)))
 (let ((?x1758 (ite v_0_rtt_previous_measured (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* ?x745 ?x1754)) (* (/ 1.0 2.0) ?x1748))))
 (let (($x1765 (and (= v_0_rttvar_ms ?x1758) (= v_0_srtt_ms (ite v_0_rtt_previous_measured ?x1762 ?x1748)))))
 (let (($x1737 (not v_0_rtt_sample_used)))
 (or $x1737 $x1765))))))))))
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
 (let (($x1901 (and (>= v_0_tx_elapsed v_0_tx_previous_rto) (<= 1 v_0_tx_emit_count) (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x1895 (not v_0_tx_retransmitted)))
 (or $x1895 $x1901))))
(assert
 (let (($x1895 (not v_0_tx_retransmitted)))
 (let (($x1904 (not v_0_tx_waiting)))
 (or $x1904 $x1895))))
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
 (let (($x1932 (not v_0_ack_pending)))
 (or $x1932 (and (<= 1 v_0_ack_bytes) (not v_0_rx_fin_done)))))
(assert
 (let (($x1939 (and (= 0 v_0_ack_bytes) (= 0 v_0_ack_full_segments) (= 0 v_0_ack_since_ms))))
 (or v_0_ack_pending $x1939)))
(assert
 (= 174 choice_0))
(assert
 (= 5 state_0))
(assert
 (= 5 state_1))
(assert
 (or (not (<= v_1_tx_time_13 now_1))))
(check-sat)
