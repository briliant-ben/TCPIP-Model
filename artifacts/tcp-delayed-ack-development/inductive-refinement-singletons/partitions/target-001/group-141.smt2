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
 (let (($x1521 (= due_1_delack due_0_delack)))
 (let ((?x1517 (+ now_1 (* 2 v_0_msl_ms))))
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
 (let (($x364 (= ?x363 0)))
 (let (($x367 (or $x364 $x366)))
 (let ((?x666 (ite $x367 0 ?x665)))
 (let ((?x669 (ite $x347 (+ ?x349 (* ?x273 ?x666)) ?x349)))
 (let (($x670 (= 0 ?x669)))
 (let (($x673 (and $x347 $x344 $x670 $x296 $x314 $x332 v_0_fin_sent $x333)))
 (let (($x1514 (= due_1_user due_0_user)))
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
 (let (($x1106 (and $x335 v_0_fin_sent)))
 (let ((?x805 (ite (<= 0 v_0_rtx_buf) v_0_rtx_buf 0)))
 (let ((?x803 (ite (<= v_0_rtx_buf ?x300) 0 (+ v_0_rtx_buf (* ?x273 ?x300)))))
 (let (($x677 (and $x296 $x314 $x332)))
 (let ((?x808 (ite $x677 (ite (<= ?x803 ?x805) ?x803 ?x805) v_0_rtx_buf)))
 (let ((?x1491 (+ ?x808 (ite $x1106 1 0))))
 (let (($x1493 (and $x296 $x314 $x332 (<= 1 ?x1491))))
 (let (($x1508 (not active_1_delack)))
 (let (($x1498 (or $x1493 (and (not (and $x296 $x314 $x332 (= 0 ?x1491))) active_0_rtx))))
 (let (($x674 (not $x673)))
 (let (($x1488 (not v_1_ack_defer_now)))
 (let (($x1486 (not v_1_ack_defer_candidate)))
 (let (($x1484 (= v_1_ack_rmss v_0_ack_rmss)))
 (let (($x1481 (= v_1_ack_delay_ms v_0_ack_delay_ms)))
 (let (($x1478 (= v_1_ack_full_segments 0)))
 (let (($x1476 (= v_1_ack_bytes 0)))
 (let (($x1474 (= v_1_ack_since_ms 0)))
 (let (($x1472 (not v_1_ack_pending)))
 (let (($x1470 (not v_1_syn_timeout_eligible)))
 (let (($x1468 (not v_1_tx_syn_pending)))
 (let (($x1466 (= v_1_tx_syn_time 0)))
 (let (($x1464 (not v_1_tx_waiting)))
 (let (($x1462 (= v_1_tx_is_fin v_0_tx_is_fin)))
 (let (($x1459 (= v_1_tx_previous_rto v_0_tx_previous_rto)))
 (let (($x1456 (= v_1_tx_elapsed v_0_tx_elapsed)))
 (let (($x1453 (not v_1_tx_retransmitted)))
 (let (($x1451 (= v_1_tx_max_previous v_0_tx_max_previous)))
 (let (($x1448 (= v_1_tx_eligible v_0_tx_eligible)))
 (let (($x1445 (= v_1_tx_emit_count v_0_tx_emit_count)))
 (let (($x1195 (and $x296 $x314 $x332 (not (= 0 ?x300)))))
 (let (($x1190 (= 0 ?x808)))
 (let (($x1438 (= v_1_tx_time_15 (ite (or $x1190 $x1195 (>= 15 ?x808)) 0 v_0_tx_time_15))))
 (let ((?x1432 (ite (or $x1190 (>= 14 ?x808)) 0 (ite $x1195 (ite (= 1 ?x300) v_0_tx_time_15 0) v_0_tx_time_14))))
 (let (($x1196 (= 1 ?x300)))
 (let ((?x1424 (ite $x1195 (ite $x1196 v_0_tx_time_14 (ite (= 2 ?x300) v_0_tx_time_15 0)) v_0_tx_time_13)))
 (let (($x1198 (= 2 ?x300)))
 (let ((?x1415 (ite $x1196 v_0_tx_time_13 (ite $x1198 v_0_tx_time_14 (ite (= 3 ?x300) v_0_tx_time_15 0)))))
 (let (($x1418 (= v_1_tx_time_12 (ite (or $x1190 (>= 12 ?x808)) 0 (ite $x1195 ?x1415 v_0_tx_time_12)))))
 (let (($x1200 (= 3 ?x300)))
 (let ((?x1405 (ite $x1198 v_0_tx_time_13 (ite $x1200 v_0_tx_time_14 (ite (= 4 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1408 (ite (or $x1190 (>= 11 ?x808)) 0 (ite $x1195 (ite $x1196 v_0_tx_time_12 ?x1405) v_0_tx_time_11))))
 (let (($x1202 (= 4 ?x300)))
 (let ((?x1394 (ite $x1200 v_0_tx_time_13 (ite $x1202 v_0_tx_time_14 (ite (= 5 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1397 (ite $x1195 (ite $x1196 v_0_tx_time_11 (ite $x1198 v_0_tx_time_12 ?x1394)) v_0_tx_time_10)))
 (let (($x1204 (= 5 ?x300)))
 (let ((?x1382 (ite $x1202 v_0_tx_time_13 (ite $x1204 v_0_tx_time_14 (ite (= 6 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1385 (ite $x1196 v_0_tx_time_10 (ite $x1198 v_0_tx_time_11 (ite $x1200 v_0_tx_time_12 ?x1382)))))
 (let (($x1388 (= v_1_tx_time_09 (ite (or $x1190 (>= 9 ?x808)) 0 (ite $x1195 ?x1385 v_0_tx_time_09)))))
 (let (($x1206 (= 6 ?x300)))
 (let ((?x1369 (ite $x1204 v_0_tx_time_13 (ite $x1206 v_0_tx_time_14 (ite (= 7 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1372 (ite $x1198 v_0_tx_time_10 (ite $x1200 v_0_tx_time_11 (ite $x1202 v_0_tx_time_12 ?x1369)))))
 (let ((?x1375 (ite (or $x1190 (>= 8 ?x808)) 0 (ite $x1195 (ite $x1196 v_0_tx_time_09 ?x1372) v_0_tx_time_08))))
 (let (($x1208 (= 7 ?x300)))
 (let ((?x1355 (ite $x1206 v_0_tx_time_13 (ite $x1208 v_0_tx_time_14 (ite (= 8 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1358 (ite $x1200 v_0_tx_time_10 (ite $x1202 v_0_tx_time_11 (ite $x1204 v_0_tx_time_12 ?x1355)))))
 (let ((?x1361 (ite $x1195 (ite $x1196 v_0_tx_time_08 (ite $x1198 v_0_tx_time_09 ?x1358)) v_0_tx_time_07)))
 (let (($x1210 (= 8 ?x300)))
 (let ((?x1340 (ite $x1208 v_0_tx_time_13 (ite $x1210 v_0_tx_time_14 (ite (= 9 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1343 (ite $x1202 v_0_tx_time_10 (ite $x1204 v_0_tx_time_11 (ite $x1206 v_0_tx_time_12 ?x1340)))))
 (let ((?x1346 (ite $x1196 v_0_tx_time_07 (ite $x1198 v_0_tx_time_08 (ite $x1200 v_0_tx_time_09 ?x1343)))))
 (let (($x1349 (= v_1_tx_time_06 (ite (or $x1190 (>= 6 ?x808)) 0 (ite $x1195 ?x1346 v_0_tx_time_06)))))
 (let (($x1212 (= 9 ?x300)))
 (let ((?x1324 (ite $x1210 v_0_tx_time_13 (ite $x1212 v_0_tx_time_14 (ite (= 10 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1327 (ite $x1204 v_0_tx_time_10 (ite $x1206 v_0_tx_time_11 (ite $x1208 v_0_tx_time_12 ?x1324)))))
 (let ((?x1330 (ite $x1198 v_0_tx_time_07 (ite $x1200 v_0_tx_time_08 (ite $x1202 v_0_tx_time_09 ?x1327)))))
 (let ((?x1333 (ite (or $x1190 (>= 5 ?x808)) 0 (ite $x1195 (ite $x1196 v_0_tx_time_06 ?x1330) v_0_tx_time_05))))
 (let (($x1214 (= 10 ?x300)))
 (let ((?x1307 (ite $x1212 v_0_tx_time_13 (ite $x1214 v_0_tx_time_14 (ite (= 11 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1310 (ite $x1206 v_0_tx_time_10 (ite $x1208 v_0_tx_time_11 (ite $x1210 v_0_tx_time_12 ?x1307)))))
 (let ((?x1313 (ite $x1200 v_0_tx_time_07 (ite $x1202 v_0_tx_time_08 (ite $x1204 v_0_tx_time_09 ?x1310)))))
 (let ((?x1316 (ite $x1195 (ite $x1196 v_0_tx_time_05 (ite $x1198 v_0_tx_time_06 ?x1313)) v_0_tx_time_04)))
 (let (($x1216 (= 11 ?x300)))
 (let ((?x1289 (ite $x1214 v_0_tx_time_13 (ite $x1216 v_0_tx_time_14 (ite (= 12 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1292 (ite $x1208 v_0_tx_time_10 (ite $x1210 v_0_tx_time_11 (ite $x1212 v_0_tx_time_12 ?x1289)))))
 (let ((?x1295 (ite $x1202 v_0_tx_time_07 (ite $x1204 v_0_tx_time_08 (ite $x1206 v_0_tx_time_09 ?x1292)))))
 (let ((?x1298 (ite $x1196 v_0_tx_time_04 (ite $x1198 v_0_tx_time_05 (ite $x1200 v_0_tx_time_06 ?x1295)))))
 (let (($x1301 (= v_1_tx_time_03 (ite (or $x1190 (>= 3 ?x808)) 0 (ite $x1195 ?x1298 v_0_tx_time_03)))))
 (let (($x1218 (= 12 ?x300)))
 (let ((?x1270 (ite $x1216 v_0_tx_time_13 (ite $x1218 v_0_tx_time_14 (ite (= 13 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1273 (ite $x1210 v_0_tx_time_10 (ite $x1212 v_0_tx_time_11 (ite $x1214 v_0_tx_time_12 ?x1270)))))
 (let ((?x1276 (ite $x1204 v_0_tx_time_07 (ite $x1206 v_0_tx_time_08 (ite $x1208 v_0_tx_time_09 ?x1273)))))
 (let ((?x1279 (ite $x1198 v_0_tx_time_04 (ite $x1200 v_0_tx_time_05 (ite $x1202 v_0_tx_time_06 ?x1276)))))
 (let ((?x1282 (ite (or $x1190 (>= 2 ?x808)) 0 (ite $x1195 (ite $x1196 v_0_tx_time_03 ?x1279) v_0_tx_time_02))))
 (let (($x1220 (= 13 ?x300)))
 (let ((?x1250 (ite $x1218 v_0_tx_time_13 (ite $x1220 v_0_tx_time_14 (ite (= 14 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1253 (ite $x1212 v_0_tx_time_10 (ite $x1214 v_0_tx_time_11 (ite $x1216 v_0_tx_time_12 ?x1250)))))
 (let ((?x1256 (ite $x1206 v_0_tx_time_07 (ite $x1208 v_0_tx_time_08 (ite $x1210 v_0_tx_time_09 ?x1253)))))
 (let ((?x1259 (ite $x1200 v_0_tx_time_04 (ite $x1202 v_0_tx_time_05 (ite $x1204 v_0_tx_time_06 ?x1256)))))
 (let ((?x1262 (ite $x1195 (ite $x1196 v_0_tx_time_02 (ite $x1198 v_0_tx_time_03 ?x1259)) v_0_tx_time_01)))
 (let (($x1222 (= 14 ?x300)))
 (let ((?x1228 (ite $x1220 v_0_tx_time_13 (ite $x1222 v_0_tx_time_14 (ite (= 15 ?x300) v_0_tx_time_15 0)))))
 (let ((?x1231 (ite $x1214 v_0_tx_time_10 (ite $x1216 v_0_tx_time_11 (ite $x1218 v_0_tx_time_12 ?x1228)))))
 (let ((?x1234 (ite $x1208 v_0_tx_time_07 (ite $x1210 v_0_tx_time_08 (ite $x1212 v_0_tx_time_09 ?x1231)))))
 (let ((?x1237 (ite $x1202 v_0_tx_time_04 (ite $x1204 v_0_tx_time_05 (ite $x1206 v_0_tx_time_06 ?x1234)))))
 (let ((?x1240 (ite $x1196 v_0_tx_time_01 (ite $x1198 v_0_tx_time_02 (ite $x1200 v_0_tx_time_03 ?x1237)))))
 (let (($x1244 (= v_1_tx_time_00 (ite (or $x1190 (>= 0 ?x808)) 0 (ite $x1195 ?x1240 v_0_tx_time_00)))))
 (let (($x1177 (= v_1_rtt_sample_was_ambiguous (and v_0_rtt_active v_0_rtt_ambiguous))))
 (let (($x1172 (not v_1_rtt_start_new)))
 (let ((?x801 (* ?x273 ?x300)))
 (let ((?x1164 (+ ?x718 ?x801)))
 (let (($x1167 (and v_0_rtt_active $x296 $x314 $x332 (not (<= v_0_rtt_remaining ?x1164)))))
 (let (($x1148 (and v_0_rtt_active $x296 $x314 $x332 $x719)))
 (let (($x1170 (= v_1_rtt_remaining (ite $x1148 0 (ite $x1167 ?x1164 v_0_rtt_remaining)))))
 (let (($x1161 (= v_1_rtt_end v_0_rtt_end)))
 (let (($x1160 (= v_1_rtt_start_ms v_0_rtt_start_ms)))
 (let (($x1146 (= v_1_rtt_previous_measured (ite $x722 v_0_rtt_measured v_0_rtt_previous_measured))))
 (let (($x1139 (= v_1_rtt_previous_var (ite $x722 v_0_rttvar_ms v_0_rtt_previous_var))))
 (let (($x1135 (= v_1_rtt_previous_srtt (ite $x722 v_0_srtt_ms v_0_rtt_previous_srtt))))
 (let ((?x1115 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data) 4294967296)))
 (let (($x1108 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x1104 (= v_1_fin_requested v_0_fin_requested)))
 (let (($x825 (<= 2147483648 (mod (+ input_0_net.fin_segment_ack (* ?x273 v_0_snd_wl2)) 4294967296))))
 (let (($x821 (= v_0_snd_wl1 input_0_net.fin_segment_seq)))
 (let ((?x815 (mod (+ input_0_net.fin_segment_seq (* ?x273 v_0_snd_wl1)) 4294967296)))
 (let (($x828 (or (and (not (<= ?x815 0)) (not (<= 2147483648 ?x815))) (and $x821 (not $x825)))))
 (let (($x829 (and $x296 $x332 $x828)))
 (let ((?x1082 (ite (or (not (and (or $x366 $x364) (not $x649))) (and $x347 $x344 $x670)) 0 ?x646)))
 (let (($x898 (not $x649)))
 (let (($x701 (not $x367)))
 (let (($x867 (not $x406)))
 (let (($x865 (not $x426)))
 (let (($x863 (not $x446)))
 (let (($x861 (not $x466)))
 (let (($x859 (not $x486)))
 (let (($x857 (not $x506)))
 (let (($x855 (not $x524)))
 (let (($x853 (not $x542)))
 (let (($x851 (not $x560)))
 (let (($x849 (not $x578)))
 (let (($x847 (not $x596)))
 (let (($x845 (not $x614)))
 (let (($x843 (not $x632)))
 (let (($x842 (and false $x650)))
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
 (let (($x864 (and $x862 $x863)))
 (let (($x866 (and $x864 $x865)))
 (let (($x869 (or $x385 $x383 (and $x866 $x867))))
 (let ((?x695 (ite $x631 0 ?x628)))
 (let (($x841 (or $x366 $x364)))
 (let (($x671 (and $x347 $x344 $x670)))
 (let (($x1078 (= v_1_rx_slot_14 (ite $x671 0 (ite $x841 ?x695 (ite (and $x869 $x701 $x898) ?x646 0))))))
 (let (($x870 (and $x869 $x701)))
 (let ((?x1070 (ite $x870 ?x695 (ite (and (or $x866 $x406) (not $x386) $x701 $x898) ?x646 0))))
 (let ((?x694 (ite $x613 0 ?x610)))
 (let (($x872 (not $x386)))
 (let (($x871 (or $x866 $x406)))
 (let (($x873 (and $x871 $x872 $x701)))
 (let ((?x1063 (ite $x873 ?x695 (ite (and (or $x864 $x426) $x867 $x872 $x701 $x898) ?x646 0))))
 (let ((?x693 (ite $x595 0 ?x592)))
 (let (($x1067 (= v_1_rx_slot_12 (ite $x671 0 (ite $x841 ?x693 (ite $x870 ?x694 ?x1063))))))
 (let (($x874 (or $x864 $x426)))
 (let (($x875 (and $x874 $x867 $x872 $x701)))
 (let ((?x1055 (ite $x875 ?x695 (ite (and (or $x862 $x446) $x865 $x867 $x872 $x701 $x898) ?x646 0))))
 (let ((?x692 (ite $x577 0 ?x574)))
 (let (($x1060 (= v_1_rx_slot_11 (ite $x671 0 (ite $x841 ?x692 (ite $x870 ?x693 (ite $x873 ?x694 ?x1055)))))))
 (let (($x876 (or $x862 $x446)))
 (let (($x877 (and $x876 $x865 $x867 $x872 $x701)))
 (let ((?x1046 (ite $x877 ?x695 (ite (and (or $x860 $x466) $x863 $x865 $x867 $x872 $x701 $x898) ?x646 0))))
 (let ((?x691 (ite $x559 0 ?x556)))
 (let ((?x1051 (ite $x671 0 (ite $x841 ?x691 (ite $x870 ?x692 (ite $x873 ?x693 (ite $x875 ?x694 ?x1046)))))))
 (let ((?x1035 (ite (and (or $x858 $x486) $x861 $x863 $x865 $x867 $x872 $x701 $x898) ?x646 0)))
 (let (($x878 (or $x860 $x466)))
 (let (($x879 (and $x878 $x863 $x865 $x867 $x872 $x701)))
 (let ((?x1040 (ite $x870 ?x691 (ite $x873 ?x692 (ite $x875 ?x693 (ite $x877 ?x694 (ite $x879 ?x695 ?x1035)))))))
 (let ((?x690 (ite $x541 0 ?x538)))
 (let ((?x1024 (ite (and (or $x856 $x506) $x859 $x861 $x863 $x865 $x867 $x872 $x701 $x898) ?x646 0)))
 (let (($x880 (or $x858 $x486)))
 (let (($x881 (and $x880 $x861 $x863 $x865 $x867 $x872 $x701)))
 (let ((?x1029 (ite $x873 ?x691 (ite $x875 ?x692 (ite $x877 ?x693 (ite $x879 ?x694 (ite $x881 ?x695 ?x1024)))))))
 (let ((?x689 (ite $x523 0 ?x520)))
 (let (($x1033 (= v_1_rx_slot_08 (ite $x671 0 (ite $x841 ?x689 (ite $x870 ?x690 ?x1029))))))
 (let ((?x1012 (ite (and (or $x854 $x524) $x857 $x859 $x861 $x863 $x865 $x867 $x872 $x701 $x898) ?x646 0)))
 (let (($x882 (or $x856 $x506)))
 (let (($x883 (and $x882 $x859 $x861 $x863 $x865 $x867 $x872 $x701)))
 (let ((?x1017 (ite $x875 ?x691 (ite $x877 ?x692 (ite $x879 ?x693 (ite $x881 ?x694 (ite $x883 ?x695 ?x1012)))))))
 (let ((?x688 (ite $x505 0 ?x502)))
 (let (($x1022 (= v_1_rx_slot_07 (ite $x671 0 (ite $x841 ?x688 (ite $x870 ?x689 (ite $x873 ?x690 ?x1017)))))))
 (let (($x886 (or $x852 $x542)))
 (let ((?x999 (ite (and $x886 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x872 $x701 $x898) ?x646 0)))
 (let (($x884 (or $x854 $x524)))
 (let (($x885 (and $x884 $x857 $x859 $x861 $x863 $x865 $x867 $x872 $x701)))
 (let ((?x1004 (ite $x877 ?x691 (ite $x879 ?x692 (ite $x881 ?x693 (ite $x883 ?x694 (ite $x885 ?x695 ?x999)))))))
 (let ((?x687 (ite $x485 0 ?x482)))
 (let ((?x1009 (ite $x671 0 (ite $x841 ?x687 (ite $x870 ?x688 (ite $x873 ?x689 (ite $x875 ?x690 ?x1004)))))))
 (let (($x888 (or $x850 $x560)))
 (let ((?x985 (ite (and $x888 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x872 $x701 $x898) ?x646 0)))
 (let (($x887 (and $x886 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x872 $x701)))
 (let ((?x990 (ite $x879 ?x691 (ite $x881 ?x692 (ite $x883 ?x693 (ite $x885 ?x694 (ite $x887 ?x695 ?x985)))))))
 (let ((?x686 (ite $x465 0 ?x462)))
 (let ((?x995 (ite $x841 ?x686 (ite $x870 ?x687 (ite $x873 ?x688 (ite $x875 ?x689 (ite $x877 ?x690 ?x990)))))))
 (let (($x890 (or $x848 $x578)))
 (let (($x969 (and $x890 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x872 $x701 $x898)))
 (let (($x889 (and $x888 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x872 $x701)))
 (let ((?x974 (ite $x883 ?x692 (ite $x885 ?x693 (ite $x887 ?x694 (ite $x889 ?x695 (ite $x969 ?x646 0)))))))
 (let ((?x979 (ite $x873 ?x687 (ite $x875 ?x688 (ite $x877 ?x689 (ite $x879 ?x690 (ite $x881 ?x691 ?x974)))))))
 (let ((?x685 (ite $x445 0 ?x442)))
 (let (($x983 (= v_1_rx_slot_04 (ite $x671 0 (ite $x841 ?x685 (ite $x870 ?x686 ?x979))))))
 (let (($x892 (or $x846 $x596)))
 (let (($x953 (and $x892 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x872 $x701 $x898)))
 (let (($x891 (and $x890 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x872 $x701)))
 (let ((?x958 (ite $x885 ?x692 (ite $x887 ?x693 (ite $x889 ?x694 (ite $x891 ?x695 (ite $x953 ?x646 0)))))))
 (let ((?x963 (ite $x875 ?x687 (ite $x877 ?x688 (ite $x879 ?x689 (ite $x881 ?x690 (ite $x883 ?x691 ?x958)))))))
 (let ((?x684 (ite $x425 0 ?x422)))
 (let (($x968 (= v_1_rx_slot_03 (ite $x671 0 (ite $x841 ?x684 (ite $x870 ?x685 (ite $x873 ?x686 ?x963)))))))
 (let (($x894 (or $x844 $x614)))
 (let (($x936 (and $x894 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x872 $x701 $x898)))
 (let (($x893 (and $x892 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x872 $x701)))
 (let ((?x941 (ite $x887 ?x692 (ite $x889 ?x693 (ite $x891 ?x694 (ite $x893 ?x695 (ite $x936 ?x646 0)))))))
 (let ((?x946 (ite $x877 ?x687 (ite $x879 ?x688 (ite $x881 ?x689 (ite $x883 ?x690 (ite $x885 ?x691 ?x941)))))))
 (let ((?x683 (ite $x405 0 ?x402)))
 (let ((?x951 (ite $x671 0 (ite $x841 ?x683 (ite $x870 ?x684 (ite $x873 ?x685 (ite $x875 ?x686 ?x946)))))))
 (let (($x896 (or $x842 $x632)))
 (let (($x918 (and $x896 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x872 $x701 $x898)))
 (let (($x895 (and $x894 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x872 $x701)))
 (let ((?x923 (ite $x889 ?x692 (ite $x891 ?x693 (ite $x893 ?x694 (ite $x895 ?x695 (ite $x918 ?x646 0)))))))
 (let ((?x928 (ite $x879 ?x687 (ite $x881 ?x688 (ite $x883 ?x689 (ite $x885 ?x690 (ite $x887 ?x691 ?x923)))))))
 (let ((?x682 (ite $x385 0 ?x382)))
 (let ((?x933 (ite $x841 ?x682 (ite $x870 ?x683 (ite $x873 ?x684 (ite $x875 ?x685 (ite $x877 ?x686 ?x928)))))))
 (let (($x899 (and $x650 $x843 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x872 $x701 $x898)))
 (let (($x897 (and $x896 $x845 $x847 $x849 $x851 $x853 $x855 $x857 $x859 $x861 $x863 $x865 $x867 $x872 $x701)))
 (let ((?x904 (ite $x891 ?x692 (ite $x893 ?x693 (ite $x895 ?x694 (ite $x897 ?x695 (ite $x899 ?x646 0)))))))
 (let ((?x909 (ite $x881 ?x687 (ite $x883 ?x688 (ite $x885 ?x689 (ite $x887 ?x690 (ite $x889 ?x691 ?x904)))))))
 (let ((?x914 (ite $x870 ?x682 (ite $x873 ?x683 (ite $x875 ?x684 (ite $x877 ?x685 (ite $x879 ?x686 ?x909)))))))
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
 (and (>= now_1 now_0) (<= 0 input_0_net.fin_segment_data) (>= 16 input_0_net.fin_segment_data) (not (= ?x276 2147483648)) (<= 0 input_0_net.fin_segment_window) (>= 65535 input_0_net.fin_segment_window) (or (not $x296) (and (not (= ?x300 2147483648)) (not $x306))) v_0_fin_sent (not (= ?x300 (+ 1 v_0_rtx_buf))) $x314 (<= ?x300 (mod (+ v_0_snd_nxt (* ?x273 v_0_snd_una)) 4294967296)) (or (not active_0_rtx) (not (<= due_0_rtx now_1))) (or (not active_0_user) (not (<= due_0_user now_1))) (or (not active_0_time_wait) (not (<= due_0_time_wait now_1))) (or (not active_0_delack) (not (<= due_0_delack now_1))) $x335 $x672 $x674 $x675 $x676 (= v_1_snd_una (ite $x677 input_0_net.fin_segment_ack v_0_snd_una)) $x680 $x709 $x710 $x711 $x714 (= v_1_rto_ms ?x780) $x784 $x787 $x790 $x793 (= v_1_local_window (+ 16 (* ?x273 v_0_rcv_buf) (* ?x273 ?x705))) $x799 (= v_1_rtx_buf ?x808) (= v_1_rcv_buf (+ v_0_rcv_buf ?x705)) (= v_1_snd_wnd (ite $x829 input_0_net.fin_segment_window v_0_snd_wnd)) (= v_1_snd_wl1 (ite $x829 input_0_net.fin_segment_seq v_0_snd_wl1)) (= v_1_snd_wl2 (ite $x829 input_0_net.fin_segment_ack v_0_snd_wl2)) $x839 (= v_1_rx_chunk ?x705) (= v_1_rx_slot_00 (ite $x671 0 (ite $x841 ?x681 ?x914))) (= v_1_rx_slot_01 (ite $x671 0 ?x933)) (= v_1_rx_slot_02 ?x951) $x968 $x983 (= v_1_rx_slot_05 (ite $x671 0 ?x995)) (= v_1_rx_slot_06 ?x1009) $x1022 $x1033 (= v_1_rx_slot_09 (ite $x671 0 (ite $x841 ?x690 ?x1040))) (= v_1_rx_slot_10 ?x1051) $x1060 $x1067 (= v_1_rx_slot_13 (ite $x671 0 (ite $x841 ?x694 ?x1070))) $x1078 (= v_1_rx_slot_15 ?x1082) (= v_1_rx_advance ?x666) (= v_1_rx_acceptable (and $x296 $x342 $x344)) (= v_1_seg_acceptable $x296) (= v_1_ack_delta ?x300) (= v_1_ack_is_new (and $x314 $x332)) (= v_1_ack_is_future $x341) (= v_1_ack_advance $x677) (= v_1_ack_window_update $x829) $x1104 (= v_1_fin_sent $x1106) $x1108 (= v_1_fin_acknowledged $x334) (= v_1_rx_fin_pending (and $x347 $x672)) (= v_1_rx_fin_seq (ite $x346 ?x1115 v_0_rx_fin_seq)) (= v_1_rx_fin_offset (ite $x671 0 ?x669)) (= v_1_rx_fin_done (or v_0_rx_fin_done $x671)) (= v_1_rx_fin_consumed $x671) (= v_1_srtt_ms ?x742) (= v_1_rttvar_ms ?x765) (= v_1_rtt_error_ms ?x758) $x1135 $x1139 (= v_1_rtt_measured (or v_0_rtt_measured $x722)) $x1146 (= v_1_rtt_active (and v_0_rtt_active (not $x1148))) (= v_1_rtt_ambiguous (and (not $x1148) v_0_rtt_ambiguous)) (= v_1_rtt_sample_at_ms (ite $x722 now_1 v_0_rtt_sample_at_ms)) $x1160 $x1161 $x1170 $x1172 (= v_1_rtt_sample_used $x722) $x1177 (= v_1_rtt_last_ms ?x737) (= v_1_rtt_samples (+ v_0_rtt_samples (ite $x722 1 0))) (= v_1_rto_base_ms (ite $x722 ?x778 v_0_rto_base_ms)) $x1244 (= v_1_tx_time_01 (ite (or $x1190 (>= 1 ?x808)) 0 ?x1262)) (= v_1_tx_time_02 ?x1282) $x1301 (= v_1_tx_time_04 (ite (or $x1190 (>= 4 ?x808)) 0 ?x1316)) (= v_1_tx_time_05 ?x1333) $x1349 (= v_1_tx_time_07 (ite (or (>= 7 ?x808) $x1190) 0 ?x1361)) (= v_1_tx_time_08 ?x1375) $x1388 (= v_1_tx_time_10 (ite (or $x1190 (>= 10 ?x808)) 0 ?x1397)) (= v_1_tx_time_11 ?x1408) $x1418 (= v_1_tx_time_13 (ite (or $x1190 (>= 13 ?x808)) 0 ?x1424)) (= v_1_tx_time_14 ?x1432) $x1438 (= v_1_tx_fin_time (ite $x1106 v_0_tx_fin_time 0)) $x1445 $x1448 $x1451 $x1453 $x1456 $x1459 $x1462 $x1464 $x1466 $x1468 $x1470 $x1472 $x1474 $x1476 $x1478 $x1481 $x1484 $x1486 $x1488 (= active_1_rtx (and $x674 $x1498)) (= active_1_user (and $x674 active_0_user)) (= active_1_time_wait (or active_0_time_wait $x673)) $x1508 (= due_1_rtx (ite $x1493 (+ now_1 ?x780) due_0_rtx)) $x1514 (= due_1_time_wait (ite $x673 ?x1517 due_0_time_wait)) $x1521)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
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
 (let ((?x1527 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1527)))
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
 (let (($x1537 (not (>= v_0_rcv_buf 16))))
 (or $x1537 $x350))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x368 (= 0 v_0_rx_slot_01)))
 (let (($x1541 (not (>= v_0_rcv_buf 15))))
 (or $x1541 $x368))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x387 (= 0 v_0_rx_slot_02)))
 (let (($x1545 (not (>= v_0_rcv_buf 14))))
 (or $x1545 $x387))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x407 (= 0 v_0_rx_slot_03)))
 (let (($x1549 (not (>= v_0_rcv_buf 13))))
 (or $x1549 $x407))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x427 (= 0 v_0_rx_slot_04)))
 (let (($x1553 (not (>= v_0_rcv_buf 12))))
 (or $x1553 $x427))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x447 (= 0 v_0_rx_slot_05)))
 (let (($x1557 (not (>= v_0_rcv_buf 11))))
 (or $x1557 $x447))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x467 (= 0 v_0_rx_slot_06)))
 (let (($x1561 (not (>= v_0_rcv_buf 10))))
 (or $x1561 $x467))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x487 (= 0 v_0_rx_slot_07)))
 (let (($x1565 (not (>= v_0_rcv_buf 9))))
 (or $x1565 $x487))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x507 (= 0 v_0_rx_slot_08)))
 (let (($x1569 (not (>= v_0_rcv_buf 8))))
 (or $x1569 $x507))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x525 (= 0 v_0_rx_slot_09)))
 (let (($x1573 (not (>= v_0_rcv_buf 7))))
 (or $x1573 $x525))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x543 (= 0 v_0_rx_slot_10)))
 (let (($x1577 (not (>= v_0_rcv_buf 6))))
 (or $x1577 $x543))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x561 (= 0 v_0_rx_slot_11)))
 (let (($x1581 (not (>= v_0_rcv_buf 5))))
 (or $x1581 $x561))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x579 (= 0 v_0_rx_slot_12)))
 (let (($x1585 (not (>= v_0_rcv_buf 4))))
 (or $x1585 $x579))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x597 (= 0 v_0_rx_slot_13)))
 (let (($x1589 (not (>= v_0_rcv_buf 3))))
 (or $x1589 $x597))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x615 (= 0 v_0_rx_slot_14)))
 (let (($x1593 (not (>= v_0_rcv_buf 2))))
 (or $x1593 $x615))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x633 (= 0 v_0_rx_slot_15)))
 (let (($x1597 (not (>= v_0_rcv_buf 1))))
 (or $x1597 $x633))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x1599 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x1599)))
(assert
 (and (<= 0 v_0_rx_advance) (>= 16 v_0_rx_advance)))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (and (<= 0 v_0_ack_delta) (>= 4294967295 v_0_ack_delta)))
(assert
 true)
(assert
 (let ((?x1612 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x1612)))
(assert
 (= active_0_rtx (<= 1 (+ v_0_rtx_buf (ite v_0_fin_sent 1 0)))))
(assert
 (let (($x1621 (and v_0_fin_requested (= v_0_fin_seq (mod (+ v_0_snd_una v_0_rtx_buf) 4294967296)) (= 0 v_0_snd_buf))))
 (let (($x1616 (not v_0_fin_sent)))
 (or $x1616 $x1621))))
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
 (let (($x1623 (<= 1 v_0_rx_fin_offset)))
 (let (($x344 (not v_0_rx_fin_done)))
 (let (($x1625 (and $x344 $x1623 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window)))))
 (let (($x345 (not v_0_rx_fin_pending)))
 (or $x345 $x1625))))))
(assert
 (let (($x1628 (>= 15 v_0_rx_fin_offset)))
 (and (<= 0 v_0_rx_fin_offset) $x1628 (= v_0_rx_fin_pending (<= 1 v_0_rx_fin_offset)))))
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
 (let ((?x1716 (* 4.0 v_0_rttvar_ms)))
 (let ((?x725 (- 1.0)))
 (let ((?x754 (* ?x725 v_0_srtt_ms)))
 (let ((?x1719 (+ ?x754 (* ?x725 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x1716)))))
 (let ((?x1720 (to_int ?x1719)))
 (let ((?x273 (- 1)))
 (let ((?x1723 (ite (<= ?x1720 (- 1000)) (* ?x273 ?x1720) 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x1723) 60000 ?x1723) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x316 (mod (+ v_0_snd_nxt (* (- 1) v_0_snd_una)) 4294967296)))
 (let ((?x718 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x1736 (and (<= v_0_rtt_start_ms now_0) (<= 1 v_0_rtt_remaining) (>= 4 v_0_rtt_remaining) (>= ?x718 v_0_rtt_remaining) (<= ?x718 ?x316))))
 (let (($x1730 (not v_0_rtt_active)))
 (or $x1730 $x1736))))))
(assert
 (or v_0_rtt_active (= 0 v_0_rtt_remaining)))
(assert
 true)
(assert
 (let (($x1745 (= v_0_rtt_last_ms (+ v_0_rtt_sample_at_ms (* (- 1) v_0_rtt_start_ms)))))
 (let (($x1743 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1741 (not v_0_rtt_sample_used)))
 (or $x1741 (and $x1743 v_0_rtt_measured $x1745))))))
(assert
 (and (<= 0 v_0_rtt_sample_at_ms) (<= v_0_rtt_sample_at_ms now_0)))
(assert
 (let ((?x1752 (to_real v_0_rtt_last_ms)))
 (let ((?x1766 (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x1752))))
 (let ((?x1754 (+ v_0_rtt_previous_srtt (* (- 1.0) ?x1752))))
 (let ((?x1758 (ite (>= ?x1754 0.0) ?x1754 (+ (* (- 1.0) v_0_rtt_previous_srtt) ?x1752))))
 (let ((?x749 (/ 1.0 4.0)))
 (let ((?x1762 (ite v_0_rtt_previous_measured (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* ?x749 ?x1758)) (* (/ 1.0 2.0) ?x1752))))
 (let (($x1769 (and (= v_0_rttvar_ms ?x1762) (= v_0_srtt_ms (ite v_0_rtt_previous_measured ?x1766 ?x1752)))))
 (let (($x1741 (not v_0_rtt_sample_used)))
 (or $x1741 $x1769))))))))))
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
 (let (($x1905 (and (>= v_0_tx_elapsed v_0_tx_previous_rto) (<= 1 v_0_tx_emit_count) (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x1899 (not v_0_tx_retransmitted)))
 (or $x1899 $x1905))))
(assert
 (let (($x1899 (not v_0_tx_retransmitted)))
 (or $x1899 (not v_0_tx_waiting))))
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
 (let (($x1936 (not v_0_ack_pending)))
 (or $x1936 (and (<= 1 v_0_ack_bytes) (not v_0_rx_fin_done)))))
(assert
 (let (($x1943 (and (= 0 v_0_ack_bytes) (= 0 v_0_ack_full_segments) (= 0 v_0_ack_since_ms))))
 (or v_0_ack_pending $x1943)))
(assert
 (= 178 choice_0))
(assert
 (= 5 state_0))
(assert
 (= 5 state_1))
(assert
 (or (not (or (not (>= 14 v_1_rtx_buf)) (= 0 v_1_tx_time_14)))))
(check-sat)
