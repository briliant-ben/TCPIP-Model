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
 (let (($x1520 (= due_1_delack due_0_delack)))
 (let ((?x1516 (+ now_1 (* 2 v_0_msl_ms))))
 (let ((?x330 (ite v_0_fin_sent 1 0)))
 (let ((?x331 (+ v_0_rtx_buf ?x330)))
 (let ((?x300 (mod (+ input_0_net.fin_segment_ack (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x333 (= ?x300 ?x331)))
 (let (($x332 (<= ?x300 ?x331)))
 (let (($x314 (<= 1 ?x300)))
 (let ((?x273 (- 1)))
 (let ((?x289 (+ ?x273 v_0_local_window)))
 (let ((?x286 (* ?x273 v_0_rcv_nxt)))
 (let ((?x293 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data ?x286) 4294967296)))
 (let (($x294 (<= ?x293 ?x289)))
 (let (($x285 (<= 1 v_0_local_window)))
 (let (($x296 (or (and $x285 (<= (mod (+ input_0_net.fin_segment_seq ?x286) 4294967296) ?x289)) (and $x285 $x294))))
 (let (($x345 (not v_0_rx_fin_pending)))
 (let (($x344 (not v_0_rx_fin_done)))
 (let (($x341 (and (>= ?x300 (+ 1 v_0_rtx_buf ?x330)) (>= 2147483647 ?x300))))
 (let (($x342 (not $x341)))
 (let (($x346 (and $x296 $x342 $x344 $x345 $x285 $x294)))
 (let ((?x349 (ite $x346 ?x293 v_0_rx_fin_offset)))
 (let (($x347 (or v_0_rx_fin_pending $x346)))
 (let (($x649 (and $x347 (>= 15 ?x349))))
 (let ((?x636 (mod (+ 15 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x641 (+ input_0_net.fin_segment_data (* ?x273 ?x636))))
 (let (($x639 (<= input_0_net.fin_segment_data ?x636)))
 (let (($x634 (<= v_0_rcv_buf 0)))
 (let (($x633 (= 0 v_0_rx_slot_15)))
 (let (($x638 (and $x296 $x342 $x344 $x633 $x634 (<= ?x636 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x646 (ite $x638 (ite (or $x639 (<= ?x641 1)) (ite $x639 0 ?x641) 1) v_0_rx_slot_15)))
 (let (($x650 (or (= ?x646 0) $x649)))
 (let (($x631 (and $x347 (>= 14 ?x349))))
 (let ((?x618 (mod (+ 14 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x623 (+ input_0_net.fin_segment_data (* ?x273 ?x618))))
 (let (($x621 (<= input_0_net.fin_segment_data ?x618)))
 (let (($x616 (<= v_0_rcv_buf 1)))
 (let (($x615 (= 0 v_0_rx_slot_14)))
 (let (($x620 (and $x296 $x342 $x344 $x615 $x616 (<= ?x618 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x628 (ite $x620 (ite (or $x621 (<= ?x623 1)) (ite $x621 0 ?x623) 1) v_0_rx_slot_14)))
 (let (($x632 (or (= ?x628 0) $x631)))
 (let (($x613 (and $x347 (>= 13 ?x349))))
 (let ((?x600 (mod (+ 13 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x605 (+ input_0_net.fin_segment_data (* ?x273 ?x600))))
 (let (($x603 (<= input_0_net.fin_segment_data ?x600)))
 (let (($x598 (<= v_0_rcv_buf 2)))
 (let (($x597 (= 0 v_0_rx_slot_13)))
 (let (($x602 (and $x296 $x342 $x344 $x597 $x598 (<= ?x600 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x610 (ite $x602 (ite (or $x603 (<= ?x605 1)) (ite $x603 0 ?x605) 1) v_0_rx_slot_13)))
 (let (($x614 (or (= ?x610 0) $x613)))
 (let (($x595 (and $x347 (>= 12 ?x349))))
 (let ((?x582 (mod (+ 12 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x587 (+ input_0_net.fin_segment_data (* ?x273 ?x582))))
 (let (($x585 (<= input_0_net.fin_segment_data ?x582)))
 (let (($x580 (<= v_0_rcv_buf 3)))
 (let (($x579 (= 0 v_0_rx_slot_12)))
 (let (($x584 (and $x296 $x342 $x344 $x579 $x580 (<= ?x582 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x592 (ite $x584 (ite (or $x585 (<= ?x587 1)) (ite $x585 0 ?x587) 1) v_0_rx_slot_12)))
 (let (($x596 (or (= ?x592 0) $x595)))
 (let ((?x654 (ite $x596 12 (ite $x614 13 (ite $x632 14 (ite $x650 15 16))))))
 (let (($x577 (and $x347 (>= 11 ?x349))))
 (let ((?x564 (mod (+ 11 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x569 (+ input_0_net.fin_segment_data (* ?x273 ?x564))))
 (let (($x567 (<= input_0_net.fin_segment_data ?x564)))
 (let (($x562 (<= v_0_rcv_buf 4)))
 (let (($x561 (= 0 v_0_rx_slot_11)))
 (let (($x566 (and $x296 $x342 $x344 $x561 $x562 (<= ?x564 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x574 (ite $x566 (ite (or $x567 (<= ?x569 1)) (ite $x567 0 ?x569) 1) v_0_rx_slot_11)))
 (let (($x578 (or (= ?x574 0) $x577)))
 (let (($x559 (and $x347 (>= 10 ?x349))))
 (let ((?x546 (mod (+ 10 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x551 (+ input_0_net.fin_segment_data (* ?x273 ?x546))))
 (let (($x549 (<= input_0_net.fin_segment_data ?x546)))
 (let (($x544 (<= v_0_rcv_buf 5)))
 (let (($x543 (= 0 v_0_rx_slot_10)))
 (let (($x548 (and $x296 $x342 $x344 $x543 $x544 (<= ?x546 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x556 (ite $x548 (ite (or $x549 (<= ?x551 1)) (ite $x549 0 ?x551) 1) v_0_rx_slot_10)))
 (let (($x560 (or (= ?x556 0) $x559)))
 (let (($x541 (and $x347 (>= 9 ?x349))))
 (let ((?x528 (mod (+ 9 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x533 (+ input_0_net.fin_segment_data (* ?x273 ?x528))))
 (let (($x531 (<= input_0_net.fin_segment_data ?x528)))
 (let (($x526 (<= v_0_rcv_buf 6)))
 (let (($x525 (= 0 v_0_rx_slot_09)))
 (let (($x530 (and $x296 $x342 $x344 $x525 $x526 (<= ?x528 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x538 (ite $x530 (ite (or $x531 (<= ?x533 1)) (ite $x531 0 ?x533) 1) v_0_rx_slot_09)))
 (let (($x542 (or (= ?x538 0) $x541)))
 (let (($x523 (and $x347 (>= 8 ?x349))))
 (let ((?x510 (mod (+ 8 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x515 (+ input_0_net.fin_segment_data (* ?x273 ?x510))))
 (let (($x513 (<= input_0_net.fin_segment_data ?x510)))
 (let (($x508 (<= v_0_rcv_buf 7)))
 (let (($x507 (= 0 v_0_rx_slot_08)))
 (let (($x512 (and $x296 $x342 $x344 $x507 $x508 (<= ?x510 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x520 (ite $x512 (ite (or $x513 (<= ?x515 1)) (ite $x513 0 ?x515) 1) v_0_rx_slot_08)))
 (let (($x524 (or (= ?x520 0) $x523)))
 (let ((?x658 (ite $x524 8 (ite $x542 9 (ite $x560 10 (ite $x578 11 ?x654))))))
 (let (($x505 (and $x347 (>= 7 ?x349))))
 (let ((?x492 (mod (+ 7 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x497 (+ input_0_net.fin_segment_data (* ?x273 ?x492))))
 (let (($x495 (<= input_0_net.fin_segment_data ?x492)))
 (let (($x489 (<= v_0_rcv_buf 8)))
 (let (($x487 (= 0 v_0_rx_slot_07)))
 (let (($x494 (and $x296 $x342 $x344 $x487 $x489 (<= ?x492 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x502 (ite $x494 (ite (or $x495 (<= ?x497 1)) (ite $x495 0 ?x497) 1) v_0_rx_slot_07)))
 (let (($x506 (or (= ?x502 0) $x505)))
 (let (($x485 (and $x347 (>= 6 ?x349))))
 (let ((?x472 (mod (+ 6 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x477 (+ input_0_net.fin_segment_data (* ?x273 ?x472))))
 (let (($x475 (<= input_0_net.fin_segment_data ?x472)))
 (let (($x469 (<= v_0_rcv_buf 9)))
 (let (($x467 (= 0 v_0_rx_slot_06)))
 (let (($x474 (and $x296 $x342 $x344 $x467 $x469 (<= ?x472 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x482 (ite $x474 (ite (or $x475 (<= ?x477 1)) (ite $x475 0 ?x477) 1) v_0_rx_slot_06)))
 (let (($x486 (or (= ?x482 0) $x485)))
 (let (($x465 (and $x347 (>= 5 ?x349))))
 (let ((?x452 (mod (+ 5 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x457 (+ input_0_net.fin_segment_data (* ?x273 ?x452))))
 (let (($x455 (<= input_0_net.fin_segment_data ?x452)))
 (let (($x449 (<= v_0_rcv_buf 10)))
 (let (($x447 (= 0 v_0_rx_slot_05)))
 (let (($x454 (and $x296 $x342 $x344 $x447 $x449 (<= ?x452 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x462 (ite $x454 (ite (or $x455 (<= ?x457 1)) (ite $x455 0 ?x457) 1) v_0_rx_slot_05)))
 (let (($x466 (or (= ?x462 0) $x465)))
 (let (($x445 (and $x347 (>= 4 ?x349))))
 (let ((?x432 (mod (+ 4 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x437 (+ input_0_net.fin_segment_data (* ?x273 ?x432))))
 (let (($x435 (<= input_0_net.fin_segment_data ?x432)))
 (let (($x429 (<= v_0_rcv_buf 11)))
 (let (($x427 (= 0 v_0_rx_slot_04)))
 (let (($x434 (and $x296 $x342 $x344 $x427 $x429 (<= ?x432 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x442 (ite $x434 (ite (or $x435 (<= ?x437 1)) (ite $x435 0 ?x437) 1) v_0_rx_slot_04)))
 (let (($x446 (or (= ?x442 0) $x445)))
 (let ((?x662 (ite $x446 4 (ite $x466 5 (ite $x486 6 (ite $x506 7 ?x658))))))
 (let (($x425 (and $x347 (>= 3 ?x349))))
 (let ((?x412 (mod (+ 3 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x417 (+ input_0_net.fin_segment_data (* ?x273 ?x412))))
 (let (($x415 (<= input_0_net.fin_segment_data ?x412)))
 (let (($x409 (<= v_0_rcv_buf 12)))
 (let (($x407 (= 0 v_0_rx_slot_03)))
 (let (($x414 (and $x296 $x342 $x344 $x407 $x409 (<= ?x412 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x422 (ite $x414 (ite (or $x415 (<= ?x417 1)) (ite $x415 0 ?x417) 1) v_0_rx_slot_03)))
 (let (($x426 (or (= ?x422 0) $x425)))
 (let (($x405 (and $x347 (>= 2 ?x349))))
 (let ((?x392 (mod (+ 2 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x397 (+ input_0_net.fin_segment_data (* ?x273 ?x392))))
 (let (($x395 (<= input_0_net.fin_segment_data ?x392)))
 (let (($x389 (<= v_0_rcv_buf 13)))
 (let (($x387 (= 0 v_0_rx_slot_02)))
 (let (($x394 (and $x296 $x342 $x344 $x387 $x389 (<= ?x392 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x402 (ite $x394 (ite (or $x395 (<= ?x397 1)) (ite $x395 0 ?x397) 1) v_0_rx_slot_02)))
 (let (($x406 (or (= ?x402 0) $x405)))
 (let (($x385 (and $x347 (>= 1 ?x349))))
 (let ((?x372 (mod (+ 1 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x377 (+ input_0_net.fin_segment_data (* ?x273 ?x372))))
 (let (($x375 (<= input_0_net.fin_segment_data ?x372)))
 (let (($x370 (<= v_0_rcv_buf 14)))
 (let (($x368 (= 0 v_0_rx_slot_01)))
 (let (($x374 (and $x296 $x342 $x344 $x368 $x370 (<= ?x372 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x382 (ite $x374 (ite (or $x375 (<= ?x377 1)) (ite $x375 0 ?x377) 1) v_0_rx_slot_01)))
 (let (($x383 (= ?x382 0)))
 (let (($x386 (or $x383 $x385)))
 (let ((?x665 (ite $x386 1 (ite $x406 2 (ite $x426 3 ?x662)))))
 (let (($x366 (and $x347 (>= 0 ?x349))))
 (let ((?x276 (mod (+ v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x358 (+ input_0_net.fin_segment_data (* ?x273 ?x276))))
 (let (($x356 (<= input_0_net.fin_segment_data ?x276)))
 (let (($x352 (<= v_0_rcv_buf 15)))
 (let (($x350 (= 0 v_0_rx_slot_00)))
 (let (($x355 (and $x296 $x342 $x344 $x350 $x352 (<= ?x276 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x363 (ite $x355 (ite (or $x356 (<= ?x358 1)) (ite $x356 0 ?x358) 1) v_0_rx_slot_00)))
 (let (($x367 (or (= ?x363 0) $x366)))
 (let ((?x666 (ite $x367 0 ?x665)))
 (let ((?x669 (ite $x347 (+ ?x349 (* ?x273 ?x666)) ?x349)))
 (let (($x670 (= 0 ?x669)))
 (let (($x673 (and $x347 $x344 $x670 $x296 $x314 $x332 v_0_fin_sent $x333)))
 (let (($x1513 (= due_1_user due_0_user)))
 (let (($x721 (not v_0_rtt_ambiguous)))
 (let ((?x718 (mod (+ v_0_rtt_end (* ?x273 v_0_snd_una)) 4294967296)))
 (let (($x719 (>= ?x300 ?x718)))
 (let (($x722 (and v_0_rtt_active $x296 $x314 $x332 $x719 $x721)))
 (let ((?x737 (ite $x722 (+ now_1 (* ?x273 v_0_rtt_start_ms)) v_0_rtt_last_ms)))
 (let ((?x738 (to_real ?x737)))
 (let ((?x762 (/ 1.0 2.0)))
 (let ((?x751 (+ v_0_srtt_ms (* (- 1.0) ?x738))))
 (let ((?x758 (ite $x722 (ite (>= ?x751 0.0) ?x751 (+ (* (- 1.0) v_0_srtt_ms) ?x738)) v_0_rtt_error_ms)))
 (let ((?x749 (/ 1.0 4.0)))
 (let ((?x764 (ite v_0_rtt_measured (+ (* (/ 3.0 4.0) v_0_rttvar_ms) (* ?x749 ?x758)) (* ?x762 ?x738))))
 (let ((?x765 (ite $x722 ?x764 v_0_rttvar_ms)))
 (let ((?x725 (- 1.0)))
 (let ((?x741 (ite v_0_rtt_measured (+ (* (/ 7.0 8.0) v_0_srtt_ms) (* (/ 1.0 8.0) ?x738)) ?x738)))
 (let ((?x742 (ite $x722 ?x741 v_0_srtt_ms)))
 (let ((?x770 (+ (* ?x725 ?x742) (* ?x725 (ite (<= ?x765 ?x749) 1.0 (* 4.0 ?x765))))))
 (let ((?x771 (to_int ?x770)))
 (let ((?x776 (ite (<= ?x771 (- 1000)) (* ?x273 ?x771) 1000)))
 (let ((?x778 (ite (<= 60000 ?x776) 60000 ?x776)))
 (let ((?x780 (ite $x722 ?x778 v_0_rto_ms)))
 (let (($x334 (and $x296 $x314 $x332 v_0_fin_sent $x333)))
 (let (($x335 (not $x334)))
 (let (($x1105 (and $x335 v_0_fin_sent)))
 (let ((?x805 (ite (<= 0 v_0_rtx_buf) v_0_rtx_buf 0)))
 (let ((?x803 (ite (<= v_0_rtx_buf ?x300) 0 (+ v_0_rtx_buf (* ?x273 ?x300)))))
 (let (($x677 (and $x296 $x314 $x332)))
 (let ((?x808 (ite $x677 (ite (<= ?x803 ?x805) ?x803 ?x805) v_0_rtx_buf)))
 (let ((?x1490 (+ ?x808 (ite $x1105 1 0))))
 (let (($x1496 (and $x296 $x314 $x332 (<= 1 ?x1490))))
 (let (($x1507 (not active_1_delack)))
 (let (($x1497 (or (and (not (and $x296 $x314 $x332 (= 0 ?x1490))) active_0_rtx) $x1496)))
 (let (($x674 (not $x673)))
 (let (($x1487 (not v_1_ack_defer_now)))
 (let (($x1485 (not v_1_ack_defer_candidate)))
 (let (($x1483 (= v_1_ack_rmss v_0_ack_rmss)))
 (let (($x1480 (= v_1_ack_delay_ms v_0_ack_delay_ms)))
 (let (($x1477 (= v_1_ack_full_segments 0)))
 (let (($x1475 (= v_1_ack_bytes 0)))
 (let (($x1473 (= v_1_ack_since_ms 0)))
 (let (($x1471 (not v_1_ack_pending)))
 (let (($x1469 (not v_1_syn_timeout_eligible)))
 (let (($x1467 (not v_1_tx_syn_pending)))
 (let (($x1465 (= v_1_tx_syn_time 0)))
 (let (($x1463 (not v_1_tx_waiting)))
 (let (($x1461 (= v_1_tx_is_fin v_0_tx_is_fin)))
 (let (($x1458 (= v_1_tx_previous_rto v_0_tx_previous_rto)))
 (let (($x1455 (= v_1_tx_elapsed v_0_tx_elapsed)))
 (let (($x1452 (not v_1_tx_retransmitted)))
 (let (($x1450 (= v_1_tx_max_previous v_0_tx_max_previous)))
 (let (($x1447 (= v_1_tx_eligible v_0_tx_eligible)))
 (let (($x1444 (= v_1_tx_emit_count v_0_tx_emit_count)))
 (let (($x1189 (= 0 ?x808)))
 (let (($x1194 (and $x296 $x314 $x332 (not (= 0 ?x300)))))
 (let (($x1437 (= v_1_tx_time_15 (ite (or (>= 15 ?x808) $x1194 $x1189) 0 v_0_tx_time_15))))
 (let ((?x1431 (ite (or (>= 14 ?x808) $x1189) 0 (ite $x1194 (ite (= 1 ?x300) v_0_tx_time_15 0) v_0_tx_time_14))))
 (let (($x1195 (= 1 ?x300)))
 (let ((?x1423 (ite $x1194 (ite $x1195 v_0_tx_time_14 (ite (= 2 ?x300) v_0_tx_time_15 0)) v_0_tx_time_13)))
 (let (($x1197 (= 2 ?x300)))
 (let ((?x1414 (ite $x1195 v_0_tx_time_13 (ite $x1197 v_0_tx_time_14 (ite (= 3 ?x300) v_0_tx_time_15 0)))))
 (let (($x1417 (= v_1_tx_time_12 (ite (or (>= 12 ?x808) $x1189) 0 (ite $x1194 ?x1414 v_0_tx_time_12)))))
 (let (($x1199 (= 3 ?x300)))
 (let ((?x1404 (ite $x1197 v_0_tx_time_13 (ite $x1199 v_0_tx_time_14 (ite (= 4 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1407 (ite (or (>= 11 ?x808) $x1189) 0 (ite $x1194 (ite $x1195 v_0_tx_time_12 ?x1404) v_0_tx_time_11))))
 (let (($x1201 (= 4 ?x300)))
 (let ((?x1393 (ite $x1199 v_0_tx_time_13 (ite $x1201 v_0_tx_time_14 (ite (= 5 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1396 (ite $x1194 (ite $x1195 v_0_tx_time_11 (ite $x1197 v_0_tx_time_12 ?x1393)) v_0_tx_time_10)))
 (let (($x1203 (= 5 ?x300)))
 (let ((?x1381 (ite $x1201 v_0_tx_time_13 (ite $x1203 v_0_tx_time_14 (ite (= 6 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1384 (ite $x1195 v_0_tx_time_10 (ite $x1197 v_0_tx_time_11 (ite $x1199 v_0_tx_time_12 ?x1381)))))
 (let (($x1387 (= v_1_tx_time_09 (ite (or (>= 9 ?x808) $x1189) 0 (ite $x1194 ?x1384 v_0_tx_time_09)))))
 (let (($x1205 (= 6 ?x300)))
 (let ((?x1368 (ite $x1203 v_0_tx_time_13 (ite $x1205 v_0_tx_time_14 (ite (= 7 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1371 (ite $x1197 v_0_tx_time_10 (ite $x1199 v_0_tx_time_11 (ite $x1201 v_0_tx_time_12 ?x1368)))))
 (let ((?x1374 (ite (or (>= 8 ?x808) $x1189) 0 (ite $x1194 (ite $x1195 v_0_tx_time_09 ?x1371) v_0_tx_time_08))))
 (let (($x1207 (= 7 ?x300)))
 (let ((?x1354 (ite $x1205 v_0_tx_time_13 (ite $x1207 v_0_tx_time_14 (ite (= 8 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1357 (ite $x1199 v_0_tx_time_10 (ite $x1201 v_0_tx_time_11 (ite $x1203 v_0_tx_time_12 ?x1354)))))
 (let ((?x1360 (ite $x1194 (ite $x1195 v_0_tx_time_08 (ite $x1197 v_0_tx_time_09 ?x1357)) v_0_tx_time_07)))
 (let (($x1209 (= 8 ?x300)))
 (let ((?x1339 (ite $x1207 v_0_tx_time_13 (ite $x1209 v_0_tx_time_14 (ite (= 9 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1342 (ite $x1201 v_0_tx_time_10 (ite $x1203 v_0_tx_time_11 (ite $x1205 v_0_tx_time_12 ?x1339)))))
 (let ((?x1345 (ite $x1195 v_0_tx_time_07 (ite $x1197 v_0_tx_time_08 (ite $x1199 v_0_tx_time_09 ?x1342)))))
 (let (($x1348 (= v_1_tx_time_06 (ite (or (>= 6 ?x808) $x1189) 0 (ite $x1194 ?x1345 v_0_tx_time_06)))))
 (let (($x1211 (= 9 ?x300)))
 (let ((?x1323 (ite $x1209 v_0_tx_time_13 (ite $x1211 v_0_tx_time_14 (ite (= 10 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1326 (ite $x1203 v_0_tx_time_10 (ite $x1205 v_0_tx_time_11 (ite $x1207 v_0_tx_time_12 ?x1323)))))
 (let ((?x1329 (ite $x1197 v_0_tx_time_07 (ite $x1199 v_0_tx_time_08 (ite $x1201 v_0_tx_time_09 ?x1326)))))
 (let ((?x1332 (ite (or (>= 5 ?x808) $x1189) 0 (ite $x1194 (ite $x1195 v_0_tx_time_06 ?x1329) v_0_tx_time_05))))
 (let (($x1213 (= 10 ?x300)))
 (let ((?x1306 (ite $x1211 v_0_tx_time_13 (ite $x1213 v_0_tx_time_14 (ite (= 11 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1309 (ite $x1205 v_0_tx_time_10 (ite $x1207 v_0_tx_time_11 (ite $x1209 v_0_tx_time_12 ?x1306)))))
 (let ((?x1312 (ite $x1199 v_0_tx_time_07 (ite $x1201 v_0_tx_time_08 (ite $x1203 v_0_tx_time_09 ?x1309)))))
 (let ((?x1315 (ite $x1194 (ite $x1195 v_0_tx_time_05 (ite $x1197 v_0_tx_time_06 ?x1312)) v_0_tx_time_04)))
 (let (($x1215 (= 11 ?x300)))
 (let ((?x1288 (ite $x1213 v_0_tx_time_13 (ite $x1215 v_0_tx_time_14 (ite (= 12 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1291 (ite $x1207 v_0_tx_time_10 (ite $x1209 v_0_tx_time_11 (ite $x1211 v_0_tx_time_12 ?x1288)))))
 (let ((?x1294 (ite $x1201 v_0_tx_time_07 (ite $x1203 v_0_tx_time_08 (ite $x1205 v_0_tx_time_09 ?x1291)))))
 (let ((?x1297 (ite $x1195 v_0_tx_time_04 (ite $x1197 v_0_tx_time_05 (ite $x1199 v_0_tx_time_06 ?x1294)))))
 (let (($x1300 (= v_1_tx_time_03 (ite (or (>= 3 ?x808) $x1189) 0 (ite $x1194 ?x1297 v_0_tx_time_03)))))
 (let (($x1217 (= 12 ?x300)))
 (let ((?x1269 (ite $x1215 v_0_tx_time_13 (ite $x1217 v_0_tx_time_14 (ite (= 13 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1272 (ite $x1209 v_0_tx_time_10 (ite $x1211 v_0_tx_time_11 (ite $x1213 v_0_tx_time_12 ?x1269)))))
 (let ((?x1275 (ite $x1203 v_0_tx_time_07 (ite $x1205 v_0_tx_time_08 (ite $x1207 v_0_tx_time_09 ?x1272)))))
 (let ((?x1278 (ite $x1197 v_0_tx_time_04 (ite $x1199 v_0_tx_time_05 (ite $x1201 v_0_tx_time_06 ?x1275)))))
 (let ((?x1281 (ite (or (>= 2 ?x808) $x1189) 0 (ite $x1194 (ite $x1195 v_0_tx_time_03 ?x1278) v_0_tx_time_02))))
 (let (($x1219 (= 13 ?x300)))
 (let ((?x1249 (ite $x1217 v_0_tx_time_13 (ite $x1219 v_0_tx_time_14 (ite (= 14 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1252 (ite $x1211 v_0_tx_time_10 (ite $x1213 v_0_tx_time_11 (ite $x1215 v_0_tx_time_12 ?x1249)))))
 (let ((?x1255 (ite $x1205 v_0_tx_time_07 (ite $x1207 v_0_tx_time_08 (ite $x1209 v_0_tx_time_09 ?x1252)))))
 (let ((?x1258 (ite $x1199 v_0_tx_time_04 (ite $x1201 v_0_tx_time_05 (ite $x1203 v_0_tx_time_06 ?x1255)))))
 (let ((?x1261 (ite $x1194 (ite $x1195 v_0_tx_time_02 (ite $x1197 v_0_tx_time_03 ?x1258)) v_0_tx_time_01)))
 (let (($x1221 (= 14 ?x300)))
 (let ((?x1227 (ite $x1219 v_0_tx_time_13 (ite $x1221 v_0_tx_time_14 (ite (= 15 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1230 (ite $x1213 v_0_tx_time_10 (ite $x1215 v_0_tx_time_11 (ite $x1217 v_0_tx_time_12 ?x1227)))))
 (let ((?x1233 (ite $x1207 v_0_tx_time_07 (ite $x1209 v_0_tx_time_08 (ite $x1211 v_0_tx_time_09 ?x1230)))))
 (let ((?x1236 (ite $x1201 v_0_tx_time_04 (ite $x1203 v_0_tx_time_05 (ite $x1205 v_0_tx_time_06 ?x1233)))))
 (let ((?x1239 (ite $x1195 v_0_tx_time_01 (ite $x1197 v_0_tx_time_02 (ite $x1199 v_0_tx_time_03 ?x1236)))))
 (let (($x1243 (= v_1_tx_time_00 (ite (or $x1189 (>= 0 ?x808)) 0 (ite $x1194 ?x1239 v_0_tx_time_00)))))
 (let (($x1176 (= v_1_rtt_sample_was_ambiguous (and v_0_rtt_active v_0_rtt_ambiguous))))
 (let (($x1171 (not v_1_rtt_start_new)))
 (let ((?x801 (* ?x273 ?x300)))
 (let ((?x1163 (+ ?x718 ?x801)))
 (let (($x1166 (and v_0_rtt_active $x296 $x314 $x332 (not (<= v_0_rtt_remaining ?x1163)))))
 (let (($x1147 (and v_0_rtt_active $x296 $x314 $x332 $x719)))
 (let (($x1169 (= v_1_rtt_remaining (ite $x1147 0 (ite $x1166 ?x1163 v_0_rtt_remaining)))))
 (let (($x1160 (= v_1_rtt_end v_0_rtt_end)))
 (let (($x1159 (= v_1_rtt_start_ms v_0_rtt_start_ms)))
 (let (($x1145 (= v_1_rtt_previous_measured (ite $x722 v_0_rtt_measured v_0_rtt_previous_measured))))
 (let (($x1138 (= v_1_rtt_previous_var (ite $x722 v_0_rttvar_ms v_0_rtt_previous_var))))
 (let (($x1134 (= v_1_rtt_previous_srtt (ite $x722 v_0_srtt_ms v_0_rtt_previous_srtt))))
 (let ((?x1114 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data) 4294967296)))
 (let (($x1107 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x1103 (= v_1_fin_requested v_0_fin_requested)))
 (let (($x825 (<= 2147483648 (mod (+ input_0_net.fin_segment_ack (* ?x273 v_0_snd_wl2)) 4294967296))))
 (let (($x821 (= v_0_snd_wl1 input_0_net.fin_segment_seq)))
 (let ((?x815 (mod (+ input_0_net.fin_segment_seq (* ?x273 v_0_snd_wl1)) 4294967296)))
 (let (($x828 (or (and (not (<= ?x815 0)) (not (<= 2147483648 ?x815))) (and $x821 (not $x825)))))
 (let (($x829 (and $x296 $x332 $x828)))
 (let ((?x1081 (ite (or (and $x347 $x344 $x670) (not (and $x367 (not $x649)))) 0 ?x646)))
 (let (($x897 (not $x649)))
 (let (($x701 (not $x367)))
 (let (($x866 (not $x406)))
 (let (($x864 (not $x426)))
 (let (($x862 (not $x446)))
 (let (($x860 (not $x466)))
 (let (($x858 (not $x486)))
 (let (($x856 (not $x506)))
 (let (($x854 (not $x524)))
 (let (($x852 (not $x542)))
 (let (($x850 (not $x560)))
 (let (($x848 (not $x578)))
 (let (($x846 (not $x596)))
 (let (($x844 (not $x614)))
 (let (($x842 (not $x632)))
 (let (($x841 (and false $x650)))
 (let (($x843 (and $x841 $x842)))
 (let (($x845 (and $x843 $x844)))
 (let (($x847 (and $x845 $x846)))
 (let (($x849 (and $x847 $x848)))
 (let (($x851 (and $x849 $x850)))
 (let (($x853 (and $x851 $x852)))
 (let (($x855 (and $x853 $x854)))
 (let (($x857 (and $x855 $x856)))
 (let (($x859 (and $x857 $x858)))
 (let (($x861 (and $x859 $x860)))
 (let (($x863 (and $x861 $x862)))
 (let (($x865 (and $x863 $x864)))
 (let (($x868 (or (and $x865 $x866) $x383 $x385)))
 (let ((?x695 (ite $x631 0 ?x628)))
 (let (($x671 (and $x347 $x344 $x670)))
 (let (($x1077 (= v_1_rx_slot_14 (ite $x671 0 (ite $x367 ?x695 (ite (and $x868 $x701 $x897) ?x646 0))))))
 (let (($x869 (and $x868 $x701)))
 (let ((?x1069 (ite $x869 ?x695 (ite (and (or $x865 $x406) (not $x386) $x701 $x897) ?x646 0))))
 (let ((?x694 (ite $x613 0 ?x610)))
 (let (($x871 (not $x386)))
 (let (($x870 (or $x865 $x406)))
 (let (($x872 (and $x870 $x871 $x701)))
 (let ((?x1062 (ite $x872 ?x695 (ite (and (or $x863 $x426) $x866 $x871 $x701 $x897) ?x646 0))))
 (let ((?x693 (ite $x595 0 ?x592)))
 (let (($x1066 (= v_1_rx_slot_12 (ite $x671 0 (ite $x367 ?x693 (ite $x869 ?x694 ?x1062))))))
 (let (($x873 (or $x863 $x426)))
 (let (($x874 (and $x873 $x866 $x871 $x701)))
 (let ((?x1054 (ite $x874 ?x695 (ite (and (or $x861 $x446) $x864 $x866 $x871 $x701 $x897) ?x646 0))))
 (let ((?x692 (ite $x577 0 ?x574)))
 (let (($x1059 (= v_1_rx_slot_11 (ite $x671 0 (ite $x367 ?x692 (ite $x869 ?x693 (ite $x872 ?x694 ?x1054)))))))
 (let (($x875 (or $x861 $x446)))
 (let (($x876 (and $x875 $x864 $x866 $x871 $x701)))
 (let ((?x1045 (ite $x876 ?x695 (ite (and (or $x859 $x466) $x862 $x864 $x866 $x871 $x701 $x897) ?x646 0))))
 (let ((?x691 (ite $x559 0 ?x556)))
 (let ((?x1050 (ite $x671 0 (ite $x367 ?x691 (ite $x869 ?x692 (ite $x872 ?x693 (ite $x874 ?x694 ?x1045)))))))
 (let ((?x1034 (ite (and (or $x857 $x486) $x860 $x862 $x864 $x866 $x871 $x701 $x897) ?x646 0)))
 (let (($x877 (or $x859 $x466)))
 (let (($x878 (and $x877 $x862 $x864 $x866 $x871 $x701)))
 (let ((?x1039 (ite $x869 ?x691 (ite $x872 ?x692 (ite $x874 ?x693 (ite $x876 ?x694 (ite $x878 ?x695 ?x1034)))))))
 (let ((?x690 (ite $x541 0 ?x538)))
 (let ((?x1023 (ite (and (or $x855 $x506) $x858 $x860 $x862 $x864 $x866 $x871 $x701 $x897) ?x646 0)))
 (let (($x879 (or $x857 $x486)))
 (let (($x880 (and $x879 $x860 $x862 $x864 $x866 $x871 $x701)))
 (let ((?x1028 (ite $x872 ?x691 (ite $x874 ?x692 (ite $x876 ?x693 (ite $x878 ?x694 (ite $x880 ?x695 ?x1023)))))))
 (let ((?x689 (ite $x523 0 ?x520)))
 (let (($x1032 (= v_1_rx_slot_08 (ite $x671 0 (ite $x367 ?x689 (ite $x869 ?x690 ?x1028))))))
 (let ((?x1011 (ite (and (or $x853 $x524) $x856 $x858 $x860 $x862 $x864 $x866 $x871 $x701 $x897) ?x646 0)))
 (let (($x881 (or $x855 $x506)))
 (let (($x882 (and $x881 $x858 $x860 $x862 $x864 $x866 $x871 $x701)))
 (let ((?x1016 (ite $x874 ?x691 (ite $x876 ?x692 (ite $x878 ?x693 (ite $x880 ?x694 (ite $x882 ?x695 ?x1011)))))))
 (let ((?x688 (ite $x505 0 ?x502)))
 (let (($x1021 (= v_1_rx_slot_07 (ite $x671 0 (ite $x367 ?x688 (ite $x869 ?x689 (ite $x872 ?x690 ?x1016)))))))
 (let (($x885 (or $x851 $x542)))
 (let ((?x998 (ite (and $x885 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x871 $x701 $x897) ?x646 0)))
 (let (($x883 (or $x853 $x524)))
 (let (($x884 (and $x883 $x856 $x858 $x860 $x862 $x864 $x866 $x871 $x701)))
 (let ((?x1003 (ite $x876 ?x691 (ite $x878 ?x692 (ite $x880 ?x693 (ite $x882 ?x694 (ite $x884 ?x695 ?x998)))))))
 (let ((?x687 (ite $x485 0 ?x482)))
 (let ((?x1008 (ite $x671 0 (ite $x367 ?x687 (ite $x869 ?x688 (ite $x872 ?x689 (ite $x874 ?x690 ?x1003)))))))
 (let (($x887 (or $x849 $x560)))
 (let ((?x984 (ite (and $x887 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x871 $x701 $x897) ?x646 0)))
 (let (($x886 (and $x885 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x871 $x701)))
 (let ((?x989 (ite $x878 ?x691 (ite $x880 ?x692 (ite $x882 ?x693 (ite $x884 ?x694 (ite $x886 ?x695 ?x984)))))))
 (let ((?x686 (ite $x465 0 ?x462)))
 (let ((?x994 (ite $x367 ?x686 (ite $x869 ?x687 (ite $x872 ?x688 (ite $x874 ?x689 (ite $x876 ?x690 ?x989)))))))
 (let (($x889 (or $x847 $x578)))
 (let (($x968 (and $x889 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x871 $x701 $x897)))
 (let (($x888 (and $x887 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x871 $x701)))
 (let ((?x973 (ite $x882 ?x692 (ite $x884 ?x693 (ite $x886 ?x694 (ite $x888 ?x695 (ite $x968 ?x646 0)))))))
 (let ((?x978 (ite $x872 ?x687 (ite $x874 ?x688 (ite $x876 ?x689 (ite $x878 ?x690 (ite $x880 ?x691 ?x973)))))))
 (let ((?x685 (ite $x445 0 ?x442)))
 (let (($x982 (= v_1_rx_slot_04 (ite $x671 0 (ite $x367 ?x685 (ite $x869 ?x686 ?x978))))))
 (let (($x891 (or $x845 $x596)))
 (let (($x952 (and $x891 $x848 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x871 $x701 $x897)))
 (let (($x890 (and $x889 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x871 $x701)))
 (let ((?x957 (ite $x884 ?x692 (ite $x886 ?x693 (ite $x888 ?x694 (ite $x890 ?x695 (ite $x952 ?x646 0)))))))
 (let ((?x962 (ite $x874 ?x687 (ite $x876 ?x688 (ite $x878 ?x689 (ite $x880 ?x690 (ite $x882 ?x691 ?x957)))))))
 (let ((?x684 (ite $x425 0 ?x422)))
 (let (($x967 (= v_1_rx_slot_03 (ite $x671 0 (ite $x367 ?x684 (ite $x869 ?x685 (ite $x872 ?x686 ?x962)))))))
 (let (($x893 (or $x843 $x614)))
 (let (($x935 (and $x893 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x871 $x701 $x897)))
 (let (($x892 (and $x891 $x848 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x871 $x701)))
 (let ((?x940 (ite $x886 ?x692 (ite $x888 ?x693 (ite $x890 ?x694 (ite $x892 ?x695 (ite $x935 ?x646 0)))))))
 (let ((?x945 (ite $x876 ?x687 (ite $x878 ?x688 (ite $x880 ?x689 (ite $x882 ?x690 (ite $x884 ?x691 ?x940)))))))
 (let ((?x683 (ite $x405 0 ?x402)))
 (let ((?x950 (ite $x671 0 (ite $x367 ?x683 (ite $x869 ?x684 (ite $x872 ?x685 (ite $x874 ?x686 ?x945)))))))
 (let (($x895 (or $x841 $x632)))
 (let (($x917 (and $x895 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x871 $x701 $x897)))
 (let (($x894 (and $x893 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x871 $x701)))
 (let ((?x922 (ite $x888 ?x692 (ite $x890 ?x693 (ite $x892 ?x694 (ite $x894 ?x695 (ite $x917 ?x646 0)))))))
 (let ((?x927 (ite $x878 ?x687 (ite $x880 ?x688 (ite $x882 ?x689 (ite $x884 ?x690 (ite $x886 ?x691 ?x922)))))))
 (let ((?x682 (ite $x385 0 ?x382)))
 (let ((?x932 (ite $x367 ?x682 (ite $x869 ?x683 (ite $x872 ?x684 (ite $x874 ?x685 (ite $x876 ?x686 ?x927)))))))
 (let (($x898 (and $x650 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x871 $x701 $x897)))
 (let (($x896 (and $x895 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x866 $x871 $x701)))
 (let ((?x903 (ite $x890 ?x692 (ite $x892 ?x693 (ite $x894 ?x694 (ite $x896 ?x695 (ite $x898 ?x646 0)))))))
 (let ((?x908 (ite $x880 ?x687 (ite $x882 ?x688 (ite $x884 ?x689 (ite $x886 ?x690 (ite $x888 ?x691 ?x903)))))))
 (let ((?x913 (ite $x869 ?x682 (ite $x872 ?x683 (ite $x874 ?x684 (ite $x876 ?x685 (ite $x878 ?x686 ?x908)))))))
 (let ((?x681 (ite $x366 0 ?x363)))
 (let ((?x703 (ite (and (<= 0 ?x666) $x701) ?x665 0)))
 (let ((?x697 (+ ?x681 ?x682 ?x683 ?x684 ?x685 ?x686 ?x687 ?x688 ?x689 ?x690 ?x691 ?x692 ?x693 ?x694 ?x695 (ite $x649 0 ?x646))))
 (let ((?x699 (ite (<= ?x697 0) 0 ?x697)))
 (let ((?x705 (ite (<= ?x699 ?x703) ?x699 ?x703)))
 (let (($x839 (= v_1_take v_0_take)))
 (let (($x799 (= v_1_snd_buf v_0_snd_buf)))
 (let (($x793 (= v_1_msl_ms v_0_msl_ms)))
 (let (($x790 (= v_1_user_timeout_ms v_0_user_timeout_ms)))
 (let (($x787 (= v_1_active_open v_0_active_open)))
 (let (($x784 (= v_1_retries v_0_retries)))
 (let (($x714 (= v_1_tx_flags v_0_tx_flags)))
 (let (($x711 (= v_1_tx_ack v_0_tx_ack)))
 (let (($x710 (= v_1_tx_seq v_0_tx_seq)))
 (let (($x709 (= v_1_rcv_nxt (mod (+ v_0_rcv_nxt ?x705 (ite $x671 1 0)) 4294967296))))
 (let (($x680 (= v_1_snd_nxt v_0_snd_nxt)))
 (let (($x676 (= v_1_irs v_0_irs)))
 (let (($x675 (= v_1_iss v_0_iss)))
 (let (($x672 (not $x671)))
 (let (($x306 (= (mod (+ input_0_net.fin_segment_ack (* ?x273 v_0_snd_nxt)) 4294967296) 2147483648)))
 (and (>= now_1 now_0) (<= 0 input_0_net.fin_segment_data) (>= 16 input_0_net.fin_segment_data) (not (= ?x276 2147483648)) (<= 0 input_0_net.fin_segment_window) (>= 65535 input_0_net.fin_segment_window) (or (not $x296) (and (not (= ?x300 2147483648)) (not $x306))) v_0_fin_sent (not (= ?x300 (+ 1 v_0_rtx_buf))) $x314 (<= ?x300 (mod (+ v_0_snd_nxt (* ?x273 v_0_snd_una)) 4294967296)) (or (not active_0_rtx) (not (<= due_0_rtx now_1))) (or (not active_0_user) (not (<= due_0_user now_1))) (or (not active_0_time_wait) (not (<= due_0_time_wait now_1))) (or (not active_0_delack) (not (<= due_0_delack now_1))) $x335 $x672 $x674 $x675 $x676 (= v_1_snd_una (ite $x677 input_0_net.fin_segment_ack v_0_snd_una)) $x680 $x709 $x710 $x711 $x714 (= v_1_rto_ms ?x780) $x784 $x787 $x790 $x793 (= v_1_local_window (+ 16 (* ?x273 v_0_rcv_buf) (* ?x273 ?x705))) $x799 (= v_1_rtx_buf ?x808) (= v_1_rcv_buf (+ v_0_rcv_buf ?x705)) (= v_1_snd_wnd (ite $x829 input_0_net.fin_segment_window v_0_snd_wnd)) (= v_1_snd_wl1 (ite $x829 input_0_net.fin_segment_seq v_0_snd_wl1)) (= v_1_snd_wl2 (ite $x829 input_0_net.fin_segment_ack v_0_snd_wl2)) $x839 (= v_1_rx_chunk ?x705) (= v_1_rx_slot_00 (ite $x671 0 (ite $x367 ?x681 ?x913))) (= v_1_rx_slot_01 (ite $x671 0 ?x932)) (= v_1_rx_slot_02 ?x950) $x967 $x982 (= v_1_rx_slot_05 (ite $x671 0 ?x994)) (= v_1_rx_slot_06 ?x1008) $x1021 $x1032 (= v_1_rx_slot_09 (ite $x671 0 (ite $x367 ?x690 ?x1039))) (= v_1_rx_slot_10 ?x1050) $x1059 $x1066 (= v_1_rx_slot_13 (ite $x671 0 (ite $x367 ?x694 ?x1069))) $x1077 (= v_1_rx_slot_15 ?x1081) (= v_1_rx_advance ?x666) (= v_1_rx_acceptable (and $x296 $x342 $x344)) (= v_1_seg_acceptable $x296) (= v_1_ack_delta ?x300) (= v_1_ack_is_new (and $x314 $x332)) (= v_1_ack_is_future $x341) (= v_1_ack_advance $x677) (= v_1_ack_window_update $x829) $x1103 (= v_1_fin_sent $x1105) $x1107 (= v_1_fin_acknowledged $x334) (= v_1_rx_fin_pending (and $x347 $x672)) (= v_1_rx_fin_seq (ite $x346 ?x1114 v_0_rx_fin_seq)) (= v_1_rx_fin_offset (ite $x671 0 ?x669)) (= v_1_rx_fin_done (or v_0_rx_fin_done $x671)) (= v_1_rx_fin_consumed $x671) (= v_1_srtt_ms ?x742) (= v_1_rttvar_ms ?x765) (= v_1_rtt_error_ms ?x758) $x1134 $x1138 (= v_1_rtt_measured (or v_0_rtt_measured $x722)) $x1145 (= v_1_rtt_active (and v_0_rtt_active (not $x1147))) (= v_1_rtt_ambiguous (and (not $x1147) v_0_rtt_ambiguous)) (= v_1_rtt_sample_at_ms (ite $x722 now_1 v_0_rtt_sample_at_ms)) $x1159 $x1160 $x1169 $x1171 (= v_1_rtt_sample_used $x722) $x1176 (= v_1_rtt_last_ms ?x737) (= v_1_rtt_samples (+ v_0_rtt_samples (ite $x722 1 0))) (= v_1_rto_base_ms (ite $x722 ?x778 v_0_rto_base_ms)) $x1243 (= v_1_tx_time_01 (ite (or $x1189 (>= 1 ?x808)) 0 ?x1261)) (= v_1_tx_time_02 ?x1281) $x1300 (= v_1_tx_time_04 (ite (or (>= 4 ?x808) $x1189) 0 ?x1315)) (= v_1_tx_time_05 ?x1332) $x1348 (= v_1_tx_time_07 (ite (or (>= 7 ?x808) $x1189) 0 ?x1360)) (= v_1_tx_time_08 ?x1374) $x1387 (= v_1_tx_time_10 (ite (or (>= 10 ?x808) $x1189) 0 ?x1396)) (= v_1_tx_time_11 ?x1407) $x1417 (= v_1_tx_time_13 (ite (or (>= 13 ?x808) $x1189) 0 ?x1423)) (= v_1_tx_time_14 ?x1431) $x1437 (= v_1_tx_fin_time (ite $x1105 v_0_tx_fin_time 0)) $x1444 $x1447 $x1450 $x1452 $x1455 $x1458 $x1461 $x1463 $x1465 $x1467 $x1469 $x1471 $x1473 $x1475 $x1477 $x1480 $x1483 $x1485 $x1487 (= active_1_rtx (and $x674 $x1497)) (= active_1_user (and $x674 active_0_user)) (= active_1_time_wait (or $x673 active_0_time_wait)) $x1507 (= due_1_rtx (ite $x1496 (+ now_1 ?x780) due_0_rtx)) $x1513 (= due_1_time_wait (ite $x673 ?x1516 due_0_time_wait)) $x1520)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
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
 (let ((?x1526 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1526)))
(assert
 (>= 16 v_0_rcv_buf))
(assert
 (and (<= 0 v_0_snd_wnd) (>= 65535 v_0_snd_wnd)))
(assert
 (= v_0_local_window (+ 16 (* (- 1) v_0_rcv_buf))))
(assert
 (>= 1 v_0_rx_slot_00))
(assert
 (let (($x350 (= 0 v_0_rx_slot_00)))
 (let (($x1536 (not (>= v_0_rcv_buf 16))))
 (or $x1536 $x350))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x368 (= 0 v_0_rx_slot_01)))
 (let (($x1540 (not (>= v_0_rcv_buf 15))))
 (or $x1540 $x368))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x387 (= 0 v_0_rx_slot_02)))
 (let (($x1544 (not (>= v_0_rcv_buf 14))))
 (or $x1544 $x387))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x407 (= 0 v_0_rx_slot_03)))
 (let (($x1548 (not (>= v_0_rcv_buf 13))))
 (or $x1548 $x407))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x427 (= 0 v_0_rx_slot_04)))
 (let (($x1552 (not (>= v_0_rcv_buf 12))))
 (or $x1552 $x427))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x447 (= 0 v_0_rx_slot_05)))
 (let (($x1556 (not (>= v_0_rcv_buf 11))))
 (or $x1556 $x447))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x467 (= 0 v_0_rx_slot_06)))
 (let (($x1560 (not (>= v_0_rcv_buf 10))))
 (or $x1560 $x467))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x487 (= 0 v_0_rx_slot_07)))
 (let (($x1564 (not (>= v_0_rcv_buf 9))))
 (or $x1564 $x487))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x507 (= 0 v_0_rx_slot_08)))
 (let (($x1568 (not (>= v_0_rcv_buf 8))))
 (or $x1568 $x507))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x525 (= 0 v_0_rx_slot_09)))
 (let (($x1572 (not (>= v_0_rcv_buf 7))))
 (or $x1572 $x525))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x543 (= 0 v_0_rx_slot_10)))
 (let (($x1576 (not (>= v_0_rcv_buf 6))))
 (or $x1576 $x543))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x561 (= 0 v_0_rx_slot_11)))
 (let (($x1580 (not (>= v_0_rcv_buf 5))))
 (or $x1580 $x561))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x579 (= 0 v_0_rx_slot_12)))
 (let (($x1584 (not (>= v_0_rcv_buf 4))))
 (or $x1584 $x579))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x597 (= 0 v_0_rx_slot_13)))
 (let (($x1588 (not (>= v_0_rcv_buf 3))))
 (or $x1588 $x597))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x615 (= 0 v_0_rx_slot_14)))
 (let (($x1592 (not (>= v_0_rcv_buf 2))))
 (or $x1592 $x615))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x633 (= 0 v_0_rx_slot_15)))
 (let (($x1596 (not (>= v_0_rcv_buf 1))))
 (or $x1596 $x633))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x1598 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x1598)))
(assert
 (and (<= 0 v_0_rx_advance) (>= 16 v_0_rx_advance)))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (and (<= 0 v_0_ack_delta) (>= 4294967295 v_0_ack_delta)))
(assert
 true)
(assert
 (let ((?x1611 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x1611)))
(assert
 (= active_0_rtx (<= 1 (+ v_0_rtx_buf (ite v_0_fin_sent 1 0)))))
(assert
 (let (($x1620 (and v_0_fin_requested (= v_0_fin_seq (mod (+ v_0_snd_una v_0_rtx_buf) 4294967296)) (= 0 v_0_snd_buf))))
 (let (($x1615 (not v_0_fin_sent)))
 (or $x1615 $x1620))))
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
 (let (($x1622 (<= 1 v_0_rx_fin_offset)))
 (let (($x344 (not v_0_rx_fin_done)))
 (let (($x1624 (and $x344 $x1622 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window)))))
 (let (($x345 (not v_0_rx_fin_pending)))
 (or $x345 $x1624))))))
(assert
 (let (($x1627 (>= 15 v_0_rx_fin_offset)))
 (and (<= 0 v_0_rx_fin_offset) $x1627 (= v_0_rx_fin_pending (<= 1 v_0_rx_fin_offset)))))
(assert
 (let (($x345 (not v_0_rx_fin_pending)))
 (or $x345 (= v_0_rx_fin_seq (mod (+ v_0_rcv_nxt v_0_rx_fin_offset) 4294967296)))))
(assert
 (let (($x344 (not v_0_rx_fin_done)))
 (or $x344 (= v_0_rcv_nxt (mod (+ 1 v_0_rx_fin_seq) 4294967296)))))
(assert
 (let (($x350 (= 0 v_0_rx_slot_00)))
 (or (not (and v_0_rx_fin_pending (>= 0 v_0_rx_fin_offset))) $x350)))
(assert
 (let (($x368 (= 0 v_0_rx_slot_01)))
 (or (not (and v_0_rx_fin_pending (>= 1 v_0_rx_fin_offset))) $x368)))
(assert
 (let (($x387 (= 0 v_0_rx_slot_02)))
 (or (not (and v_0_rx_fin_pending (>= 2 v_0_rx_fin_offset))) $x387)))
(assert
 (let (($x407 (= 0 v_0_rx_slot_03)))
 (or (not (and v_0_rx_fin_pending (>= 3 v_0_rx_fin_offset))) $x407)))
(assert
 (let (($x427 (= 0 v_0_rx_slot_04)))
 (or (not (and v_0_rx_fin_pending (>= 4 v_0_rx_fin_offset))) $x427)))
(assert
 (let (($x447 (= 0 v_0_rx_slot_05)))
 (or (not (and v_0_rx_fin_pending (>= 5 v_0_rx_fin_offset))) $x447)))
(assert
 (let (($x467 (= 0 v_0_rx_slot_06)))
 (or (not (and v_0_rx_fin_pending (>= 6 v_0_rx_fin_offset))) $x467)))
(assert
 (let (($x487 (= 0 v_0_rx_slot_07)))
 (or (not (and v_0_rx_fin_pending (>= 7 v_0_rx_fin_offset))) $x487)))
(assert
 (let (($x507 (= 0 v_0_rx_slot_08)))
 (or (not (and v_0_rx_fin_pending (>= 8 v_0_rx_fin_offset))) $x507)))
(assert
 (let (($x525 (= 0 v_0_rx_slot_09)))
 (or (not (and v_0_rx_fin_pending (>= 9 v_0_rx_fin_offset))) $x525)))
(assert
 (let (($x543 (= 0 v_0_rx_slot_10)))
 (or (not (and v_0_rx_fin_pending (>= 10 v_0_rx_fin_offset))) $x543)))
(assert
 (let (($x561 (= 0 v_0_rx_slot_11)))
 (or (not (and v_0_rx_fin_pending (>= 11 v_0_rx_fin_offset))) $x561)))
(assert
 (let (($x579 (= 0 v_0_rx_slot_12)))
 (or (not (and v_0_rx_fin_pending (>= 12 v_0_rx_fin_offset))) $x579)))
(assert
 (let (($x597 (= 0 v_0_rx_slot_13)))
 (or (not (and v_0_rx_fin_pending (>= 13 v_0_rx_fin_offset))) $x597)))
(assert
 (let (($x615 (= 0 v_0_rx_slot_14)))
 (or (not (and v_0_rx_fin_pending (>= 14 v_0_rx_fin_offset))) $x615)))
(assert
 (let (($x633 (= 0 v_0_rx_slot_15)))
 (or (not (and v_0_rx_fin_pending (>= 15 v_0_rx_fin_offset))) $x633)))
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
 (let ((?x1715 (* 4.0 v_0_rttvar_ms)))
 (let ((?x725 (- 1.0)))
 (let ((?x754 (* ?x725 v_0_srtt_ms)))
 (let ((?x1718 (+ ?x754 (* ?x725 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x1715)))))
 (let ((?x1719 (to_int ?x1718)))
 (let ((?x273 (- 1)))
 (let ((?x1722 (ite (<= ?x1719 (- 1000)) (* ?x273 ?x1719) 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x1722) 60000 ?x1722) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x316 (mod (+ v_0_snd_nxt (* (- 1) v_0_snd_una)) 4294967296)))
 (let ((?x718 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x1735 (and (<= v_0_rtt_start_ms now_0) (<= 1 v_0_rtt_remaining) (>= 4 v_0_rtt_remaining) (>= ?x718 v_0_rtt_remaining) (<= ?x718 ?x316))))
 (let (($x1729 (not v_0_rtt_active)))
 (or $x1729 $x1735))))))
(assert
 (or v_0_rtt_active (= 0 v_0_rtt_remaining)))
(assert
 true)
(assert
 (let (($x1744 (= v_0_rtt_last_ms (+ v_0_rtt_sample_at_ms (* (- 1) v_0_rtt_start_ms)))))
 (let (($x1742 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1740 (not v_0_rtt_sample_used)))
 (or $x1740 (and $x1742 v_0_rtt_measured $x1744))))))
(assert
 (and (<= 0 v_0_rtt_sample_at_ms) (<= v_0_rtt_sample_at_ms now_0)))
(assert
 (let ((?x1751 (to_real v_0_rtt_last_ms)))
 (let ((?x1765 (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x1751))))
 (let ((?x1753 (+ v_0_rtt_previous_srtt (* (- 1.0) ?x1751))))
 (let ((?x1757 (ite (>= ?x1753 0.0) ?x1753 (+ (* (- 1.0) v_0_rtt_previous_srtt) ?x1751))))
 (let ((?x749 (/ 1.0 4.0)))
 (let ((?x1761 (ite v_0_rtt_previous_measured (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* ?x749 ?x1757)) (* (/ 1.0 2.0) ?x1751))))
 (let (($x1768 (and (= v_0_rttvar_ms ?x1761) (= v_0_srtt_ms (ite v_0_rtt_previous_measured ?x1765 ?x1751)))))
 (let (($x1740 (not v_0_rtt_sample_used)))
 (or $x1740 $x1768))))))))))
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
 (let (($x1904 (and (>= v_0_tx_elapsed v_0_tx_previous_rto) (<= 1 v_0_tx_emit_count) (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x1898 (not v_0_tx_retransmitted)))
 (or $x1898 $x1904))))
(assert
 (let (($x1898 (not v_0_tx_retransmitted)))
 (let (($x1907 (not v_0_tx_waiting)))
 (or $x1907 $x1898))))
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
 (let (($x1935 (not v_0_ack_pending)))
 (or $x1935 (and (<= 1 v_0_ack_bytes) (not v_0_rx_fin_done)))))
(assert
 (let (($x1942 (and (= 0 v_0_ack_bytes) (= 0 v_0_ack_full_segments) (= 0 v_0_ack_since_ms))))
 (or v_0_ack_pending $x1942)))
(assert
 (= 178 choice_0))
(assert
 (= 5 state_0))
(assert
 (= 5 state_1))
(assert
 (or (not (or (not (>= 7 v_1_rtx_buf)) (= 0 v_1_tx_time_07)))))
(check-sat)
