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
 (let (($x1517 (= due_1_delack due_0_delack)))
 (let ((?x1513 (+ now_1 (* 2 v_0_msl_ms))))
 (let ((?x328 (ite v_0_fin_sent 1 0)))
 (let ((?x329 (+ v_0_rtx_buf ?x328)))
 (let ((?x286 (mod (+ input_0_net.fin_segment_ack (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x331 (= ?x286 ?x329)))
 (let (($x330 (<= ?x286 ?x329)))
 (let (($x327 (<= 1 ?x286)))
 (let ((?x273 (- 1)))
 (let ((?x300 (+ ?x273 v_0_local_window)))
 (let (($x305 (<= (mod (+ input_0_net.fin_segment_seq (* ?x273 v_0_rcv_nxt)) 4294967296) ?x300)))
 (let (($x296 (<= 1 v_0_local_window)))
 (let ((?x297 (* ?x273 v_0_rcv_nxt)))
 (let ((?x299 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data ?x297) 4294967296)))
 (let (($x301 (<= ?x299 ?x300)))
 (let (($x307 (or (and $x296 $x301) (and $x296 $x305))))
 (let (($x343 (not v_0_rx_fin_pending)))
 (let (($x342 (not v_0_rx_fin_done)))
 (let (($x339 (and (>= ?x286 (+ 1 v_0_rtx_buf ?x328)) (>= 2147483647 ?x286))))
 (let (($x340 (not $x339)))
 (let (($x344 (and $x307 $x340 $x342 $x343 $x296 $x301)))
 (let ((?x347 (ite $x344 ?x299 v_0_rx_fin_offset)))
 (let (($x345 (or v_0_rx_fin_pending $x344)))
 (let (($x647 (and $x345 (>= 15 ?x347))))
 (let ((?x634 (mod (+ 15 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x639 (+ input_0_net.fin_segment_data (* ?x273 ?x634))))
 (let (($x637 (<= input_0_net.fin_segment_data ?x634)))
 (let (($x632 (<= v_0_rcv_buf 0)))
 (let (($x631 (= 0 v_0_rx_slot_15)))
 (let (($x636 (and $x307 $x340 $x342 $x631 $x632 (<= ?x634 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x644 (ite $x636 (ite (or $x637 (<= ?x639 1)) (ite $x637 0 ?x639) 1) v_0_rx_slot_15)))
 (let (($x648 (or (= ?x644 0) $x647)))
 (let (($x629 (and $x345 (>= 14 ?x347))))
 (let ((?x616 (mod (+ 14 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x621 (+ input_0_net.fin_segment_data (* ?x273 ?x616))))
 (let (($x619 (<= input_0_net.fin_segment_data ?x616)))
 (let (($x614 (<= v_0_rcv_buf 1)))
 (let (($x613 (= 0 v_0_rx_slot_14)))
 (let (($x618 (and $x307 $x340 $x342 $x613 $x614 (<= ?x616 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x626 (ite $x618 (ite (or $x619 (<= ?x621 1)) (ite $x619 0 ?x621) 1) v_0_rx_slot_14)))
 (let (($x630 (or (= ?x626 0) $x629)))
 (let (($x611 (and $x345 (>= 13 ?x347))))
 (let ((?x598 (mod (+ 13 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x603 (+ input_0_net.fin_segment_data (* ?x273 ?x598))))
 (let (($x601 (<= input_0_net.fin_segment_data ?x598)))
 (let (($x596 (<= v_0_rcv_buf 2)))
 (let (($x595 (= 0 v_0_rx_slot_13)))
 (let (($x600 (and $x307 $x340 $x342 $x595 $x596 (<= ?x598 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x608 (ite $x600 (ite (or $x601 (<= ?x603 1)) (ite $x601 0 ?x603) 1) v_0_rx_slot_13)))
 (let (($x612 (or (= ?x608 0) $x611)))
 (let (($x593 (and $x345 (>= 12 ?x347))))
 (let ((?x580 (mod (+ 12 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x585 (+ input_0_net.fin_segment_data (* ?x273 ?x580))))
 (let (($x583 (<= input_0_net.fin_segment_data ?x580)))
 (let (($x578 (<= v_0_rcv_buf 3)))
 (let (($x577 (= 0 v_0_rx_slot_12)))
 (let (($x582 (and $x307 $x340 $x342 $x577 $x578 (<= ?x580 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x590 (ite $x582 (ite (or $x583 (<= ?x585 1)) (ite $x583 0 ?x585) 1) v_0_rx_slot_12)))
 (let (($x594 (or (= ?x590 0) $x593)))
 (let ((?x652 (ite $x594 12 (ite $x612 13 (ite $x630 14 (ite $x648 15 16))))))
 (let (($x575 (and $x345 (>= 11 ?x347))))
 (let ((?x562 (mod (+ 11 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x567 (+ input_0_net.fin_segment_data (* ?x273 ?x562))))
 (let (($x565 (<= input_0_net.fin_segment_data ?x562)))
 (let (($x560 (<= v_0_rcv_buf 4)))
 (let (($x559 (= 0 v_0_rx_slot_11)))
 (let (($x564 (and $x307 $x340 $x342 $x559 $x560 (<= ?x562 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x572 (ite $x564 (ite (or $x565 (<= ?x567 1)) (ite $x565 0 ?x567) 1) v_0_rx_slot_11)))
 (let (($x576 (or (= ?x572 0) $x575)))
 (let (($x557 (and $x345 (>= 10 ?x347))))
 (let ((?x544 (mod (+ 10 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x549 (+ input_0_net.fin_segment_data (* ?x273 ?x544))))
 (let (($x547 (<= input_0_net.fin_segment_data ?x544)))
 (let (($x542 (<= v_0_rcv_buf 5)))
 (let (($x541 (= 0 v_0_rx_slot_10)))
 (let (($x546 (and $x307 $x340 $x342 $x541 $x542 (<= ?x544 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x554 (ite $x546 (ite (or $x547 (<= ?x549 1)) (ite $x547 0 ?x549) 1) v_0_rx_slot_10)))
 (let (($x558 (or (= ?x554 0) $x557)))
 (let (($x539 (and $x345 (>= 9 ?x347))))
 (let ((?x526 (mod (+ 9 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x531 (+ input_0_net.fin_segment_data (* ?x273 ?x526))))
 (let (($x529 (<= input_0_net.fin_segment_data ?x526)))
 (let (($x524 (<= v_0_rcv_buf 6)))
 (let (($x523 (= 0 v_0_rx_slot_09)))
 (let (($x528 (and $x307 $x340 $x342 $x523 $x524 (<= ?x526 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x536 (ite $x528 (ite (or $x529 (<= ?x531 1)) (ite $x529 0 ?x531) 1) v_0_rx_slot_09)))
 (let (($x540 (or (= ?x536 0) $x539)))
 (let (($x521 (and $x345 (>= 8 ?x347))))
 (let ((?x508 (mod (+ 8 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x513 (+ input_0_net.fin_segment_data (* ?x273 ?x508))))
 (let (($x511 (<= input_0_net.fin_segment_data ?x508)))
 (let (($x506 (<= v_0_rcv_buf 7)))
 (let (($x505 (= 0 v_0_rx_slot_08)))
 (let (($x510 (and $x307 $x340 $x342 $x505 $x506 (<= ?x508 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x518 (ite $x510 (ite (or $x511 (<= ?x513 1)) (ite $x511 0 ?x513) 1) v_0_rx_slot_08)))
 (let (($x522 (or (= ?x518 0) $x521)))
 (let ((?x656 (ite $x522 8 (ite $x540 9 (ite $x558 10 (ite $x576 11 ?x652))))))
 (let (($x503 (and $x345 (>= 7 ?x347))))
 (let ((?x490 (mod (+ 7 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x495 (+ input_0_net.fin_segment_data (* ?x273 ?x490))))
 (let (($x493 (<= input_0_net.fin_segment_data ?x490)))
 (let (($x487 (<= v_0_rcv_buf 8)))
 (let (($x485 (= 0 v_0_rx_slot_07)))
 (let (($x492 (and $x307 $x340 $x342 $x485 $x487 (<= ?x490 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x500 (ite $x492 (ite (or $x493 (<= ?x495 1)) (ite $x493 0 ?x495) 1) v_0_rx_slot_07)))
 (let (($x504 (or (= ?x500 0) $x503)))
 (let (($x483 (and $x345 (>= 6 ?x347))))
 (let ((?x470 (mod (+ 6 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x475 (+ input_0_net.fin_segment_data (* ?x273 ?x470))))
 (let (($x473 (<= input_0_net.fin_segment_data ?x470)))
 (let (($x467 (<= v_0_rcv_buf 9)))
 (let (($x465 (= 0 v_0_rx_slot_06)))
 (let (($x472 (and $x307 $x340 $x342 $x465 $x467 (<= ?x470 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x480 (ite $x472 (ite (or $x473 (<= ?x475 1)) (ite $x473 0 ?x475) 1) v_0_rx_slot_06)))
 (let (($x484 (or (= ?x480 0) $x483)))
 (let (($x463 (and $x345 (>= 5 ?x347))))
 (let ((?x450 (mod (+ 5 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x455 (+ input_0_net.fin_segment_data (* ?x273 ?x450))))
 (let (($x453 (<= input_0_net.fin_segment_data ?x450)))
 (let (($x447 (<= v_0_rcv_buf 10)))
 (let (($x445 (= 0 v_0_rx_slot_05)))
 (let (($x452 (and $x307 $x340 $x342 $x445 $x447 (<= ?x450 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x460 (ite $x452 (ite (or $x453 (<= ?x455 1)) (ite $x453 0 ?x455) 1) v_0_rx_slot_05)))
 (let (($x464 (or (= ?x460 0) $x463)))
 (let (($x443 (and $x345 (>= 4 ?x347))))
 (let ((?x430 (mod (+ 4 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x435 (+ input_0_net.fin_segment_data (* ?x273 ?x430))))
 (let (($x433 (<= input_0_net.fin_segment_data ?x430)))
 (let (($x427 (<= v_0_rcv_buf 11)))
 (let (($x425 (= 0 v_0_rx_slot_04)))
 (let (($x432 (and $x307 $x340 $x342 $x425 $x427 (<= ?x430 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x440 (ite $x432 (ite (or $x433 (<= ?x435 1)) (ite $x433 0 ?x435) 1) v_0_rx_slot_04)))
 (let (($x444 (or (= ?x440 0) $x443)))
 (let ((?x660 (ite $x444 4 (ite $x464 5 (ite $x484 6 (ite $x504 7 ?x656))))))
 (let (($x423 (and $x345 (>= 3 ?x347))))
 (let ((?x410 (mod (+ 3 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x415 (+ input_0_net.fin_segment_data (* ?x273 ?x410))))
 (let (($x413 (<= input_0_net.fin_segment_data ?x410)))
 (let (($x407 (<= v_0_rcv_buf 12)))
 (let (($x405 (= 0 v_0_rx_slot_03)))
 (let (($x412 (and $x307 $x340 $x342 $x405 $x407 (<= ?x410 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x420 (ite $x412 (ite (or $x413 (<= ?x415 1)) (ite $x413 0 ?x415) 1) v_0_rx_slot_03)))
 (let (($x424 (or (= ?x420 0) $x423)))
 (let (($x403 (and $x345 (>= 2 ?x347))))
 (let ((?x390 (mod (+ 2 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x395 (+ input_0_net.fin_segment_data (* ?x273 ?x390))))
 (let (($x393 (<= input_0_net.fin_segment_data ?x390)))
 (let (($x387 (<= v_0_rcv_buf 13)))
 (let (($x385 (= 0 v_0_rx_slot_02)))
 (let (($x392 (and $x307 $x340 $x342 $x385 $x387 (<= ?x390 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x400 (ite $x392 (ite (or $x393 (<= ?x395 1)) (ite $x393 0 ?x395) 1) v_0_rx_slot_02)))
 (let (($x404 (or (= ?x400 0) $x403)))
 (let (($x383 (and $x345 (>= 1 ?x347))))
 (let ((?x370 (mod (+ 1 v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x375 (+ input_0_net.fin_segment_data (* ?x273 ?x370))))
 (let (($x373 (<= input_0_net.fin_segment_data ?x370)))
 (let (($x368 (<= v_0_rcv_buf 14)))
 (let (($x366 (= 0 v_0_rx_slot_01)))
 (let (($x372 (and $x307 $x340 $x342 $x366 $x368 (<= ?x370 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x380 (ite $x372 (ite (or $x373 (<= ?x375 1)) (ite $x373 0 ?x375) 1) v_0_rx_slot_01)))
 (let (($x381 (= ?x380 0)))
 (let (($x384 (or $x381 $x383)))
 (let ((?x663 (ite $x384 1 (ite $x404 2 (ite $x424 3 ?x660)))))
 (let (($x364 (and $x345 (>= 0 ?x347))))
 (let ((?x276 (mod (+ v_0_rcv_nxt (* ?x273 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x356 (+ input_0_net.fin_segment_data (* ?x273 ?x276))))
 (let (($x354 (<= input_0_net.fin_segment_data ?x276)))
 (let (($x350 (<= v_0_rcv_buf 15)))
 (let (($x348 (= 0 v_0_rx_slot_00)))
 (let (($x353 (and $x307 $x340 $x342 $x348 $x350 (<= ?x276 (+ ?x273 input_0_net.fin_segment_data)))))
 (let ((?x361 (ite $x353 (ite (or $x354 (<= ?x356 1)) (ite $x354 0 ?x356) 1) v_0_rx_slot_00)))
 (let (($x365 (or (= ?x361 0) $x364)))
 (let ((?x664 (ite $x365 0 ?x663)))
 (let ((?x667 (ite $x345 (+ ?x347 (* ?x273 ?x664)) ?x347)))
 (let (($x668 (= 0 ?x667)))
 (let (($x671 (and $x345 $x342 $x668 $x307 $x327 $x330 v_0_fin_sent $x331)))
 (let (($x1510 (= due_1_user due_0_user)))
 (let (($x719 (not v_0_rtt_ambiguous)))
 (let ((?x716 (mod (+ v_0_rtt_end (* ?x273 v_0_snd_una)) 4294967296)))
 (let (($x717 (>= ?x286 ?x716)))
 (let (($x720 (and v_0_rtt_active $x307 $x327 $x330 $x717 $x719)))
 (let ((?x735 (ite $x720 (+ now_1 (* ?x273 v_0_rtt_start_ms)) v_0_rtt_last_ms)))
 (let ((?x736 (to_real ?x735)))
 (let ((?x760 (/ 1.0 2.0)))
 (let ((?x749 (+ v_0_srtt_ms (* (- 1.0) ?x736))))
 (let ((?x756 (ite $x720 (ite (>= ?x749 0.0) ?x749 (+ (* (- 1.0) v_0_srtt_ms) ?x736)) v_0_rtt_error_ms)))
 (let ((?x747 (/ 1.0 4.0)))
 (let ((?x762 (ite v_0_rtt_measured (+ (* (/ 3.0 4.0) v_0_rttvar_ms) (* ?x747 ?x756)) (* ?x760 ?x736))))
 (let ((?x763 (ite $x720 ?x762 v_0_rttvar_ms)))
 (let ((?x723 (- 1.0)))
 (let ((?x739 (ite v_0_rtt_measured (+ (* (/ 7.0 8.0) v_0_srtt_ms) (* (/ 1.0 8.0) ?x736)) ?x736)))
 (let ((?x740 (ite $x720 ?x739 v_0_srtt_ms)))
 (let ((?x768 (+ (* ?x723 ?x740) (* ?x723 (ite (<= ?x763 ?x747) 1.0 (* 4.0 ?x763))))))
 (let ((?x769 (to_int ?x768)))
 (let ((?x774 (ite (<= ?x769 (- 1000)) (* ?x273 ?x769) 1000)))
 (let ((?x776 (ite (<= 60000 ?x774) 60000 ?x774)))
 (let ((?x778 (ite $x720 ?x776 v_0_rto_ms)))
 (let (($x332 (and $x307 $x327 $x330 v_0_fin_sent $x331)))
 (let (($x333 (not $x332)))
 (let (($x1103 (and $x333 v_0_fin_sent)))
 (let ((?x803 (ite (<= 0 v_0_rtx_buf) v_0_rtx_buf 0)))
 (let ((?x801 (ite (<= v_0_rtx_buf ?x286) 0 (+ v_0_rtx_buf (* ?x273 ?x286)))))
 (let (($x675 (and $x307 $x327 $x330)))
 (let ((?x806 (ite $x675 (ite (<= ?x801 ?x803) ?x801 ?x803) v_0_rtx_buf)))
 (let ((?x1487 (+ ?x806 (ite $x1103 1 0))))
 (let (($x1493 (and $x307 $x327 $x330 (<= 1 ?x1487))))
 (let (($x1504 (not active_1_delack)))
 (let (($x1494 (or (and (not (and $x307 $x327 $x330 (= 0 ?x1487))) active_0_rtx) $x1493)))
 (let (($x672 (not $x671)))
 (let (($x1484 (not v_1_ack_defer_now)))
 (let (($x1482 (not v_1_ack_defer_candidate)))
 (let (($x1480 (= v_1_ack_rmss v_0_ack_rmss)))
 (let (($x1477 (= v_1_ack_delay_ms v_0_ack_delay_ms)))
 (let (($x1474 (= v_1_ack_full_segments 0)))
 (let (($x1472 (= v_1_ack_bytes 0)))
 (let (($x1470 (= v_1_ack_since_ms 0)))
 (let (($x1468 (not v_1_ack_pending)))
 (let (($x1466 (not v_1_syn_timeout_eligible)))
 (let (($x1464 (not v_1_tx_syn_pending)))
 (let (($x1462 (= v_1_tx_syn_time 0)))
 (let (($x1460 (not v_1_tx_waiting)))
 (let (($x1458 (= v_1_tx_is_fin v_0_tx_is_fin)))
 (let (($x1455 (= v_1_tx_previous_rto v_0_tx_previous_rto)))
 (let (($x1452 (= v_1_tx_elapsed v_0_tx_elapsed)))
 (let (($x1449 (not v_1_tx_retransmitted)))
 (let (($x1447 (= v_1_tx_max_previous v_0_tx_max_previous)))
 (let (($x1444 (= v_1_tx_eligible v_0_tx_eligible)))
 (let (($x1441 (= v_1_tx_emit_count v_0_tx_emit_count)))
 (let (($x1191 (and $x307 $x327 $x330 (not (= 0 ?x286)))))
 (let (($x1187 (= 0 ?x806)))
 (let (($x1434 (= v_1_tx_time_15 (ite (or $x1187 $x1191 (>= 15 ?x806)) 0 v_0_tx_time_15))))
 (let ((?x1428 (ite (or (>= 14 ?x806) $x1187) 0 (ite $x1191 (ite (= 1 ?x286) v_0_tx_time_15 0) v_0_tx_time_14))))
 (let (($x1192 (= 1 ?x286)))
 (let ((?x1420 (ite $x1191 (ite $x1192 v_0_tx_time_14 (ite (= 2 ?x286) v_0_tx_time_15 0)) v_0_tx_time_13)))
 (let (($x1194 (= 2 ?x286)))
 (let ((?x1411 (ite $x1192 v_0_tx_time_13 (ite $x1194 v_0_tx_time_14 (ite (= 3 ?x286) v_0_tx_time_15 0)))))
 (let (($x1414 (= v_1_tx_time_12 (ite (or $x1187 (>= 12 ?x806)) 0 (ite $x1191 ?x1411 v_0_tx_time_12)))))
 (let (($x1196 (= 3 ?x286)))
 (let ((?x1401 (ite $x1194 v_0_tx_time_13 (ite $x1196 v_0_tx_time_14 (ite (= 4 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1404 (ite (or $x1187 (>= 11 ?x806)) 0 (ite $x1191 (ite $x1192 v_0_tx_time_12 ?x1401) v_0_tx_time_11))))
 (let (($x1198 (= 4 ?x286)))
 (let ((?x1390 (ite $x1196 v_0_tx_time_13 (ite $x1198 v_0_tx_time_14 (ite (= 5 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1393 (ite $x1191 (ite $x1192 v_0_tx_time_11 (ite $x1194 v_0_tx_time_12 ?x1390)) v_0_tx_time_10)))
 (let (($x1200 (= 5 ?x286)))
 (let ((?x1378 (ite $x1198 v_0_tx_time_13 (ite $x1200 v_0_tx_time_14 (ite (= 6 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1381 (ite $x1192 v_0_tx_time_10 (ite $x1194 v_0_tx_time_11 (ite $x1196 v_0_tx_time_12 ?x1378)))))
 (let (($x1384 (= v_1_tx_time_09 (ite (or (>= 9 ?x806) $x1187) 0 (ite $x1191 ?x1381 v_0_tx_time_09)))))
 (let (($x1202 (= 6 ?x286)))
 (let ((?x1365 (ite $x1200 v_0_tx_time_13 (ite $x1202 v_0_tx_time_14 (ite (= 7 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1368 (ite $x1194 v_0_tx_time_10 (ite $x1196 v_0_tx_time_11 (ite $x1198 v_0_tx_time_12 ?x1365)))))
 (let ((?x1371 (ite (or (>= 8 ?x806) $x1187) 0 (ite $x1191 (ite $x1192 v_0_tx_time_09 ?x1368) v_0_tx_time_08))))
 (let (($x1204 (= 7 ?x286)))
 (let ((?x1351 (ite $x1202 v_0_tx_time_13 (ite $x1204 v_0_tx_time_14 (ite (= 8 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1354 (ite $x1196 v_0_tx_time_10 (ite $x1198 v_0_tx_time_11 (ite $x1200 v_0_tx_time_12 ?x1351)))))
 (let ((?x1357 (ite $x1191 (ite $x1192 v_0_tx_time_08 (ite $x1194 v_0_tx_time_09 ?x1354)) v_0_tx_time_07)))
 (let (($x1206 (= 8 ?x286)))
 (let ((?x1336 (ite $x1204 v_0_tx_time_13 (ite $x1206 v_0_tx_time_14 (ite (= 9 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1339 (ite $x1198 v_0_tx_time_10 (ite $x1200 v_0_tx_time_11 (ite $x1202 v_0_tx_time_12 ?x1336)))))
 (let ((?x1342 (ite $x1192 v_0_tx_time_07 (ite $x1194 v_0_tx_time_08 (ite $x1196 v_0_tx_time_09 ?x1339)))))
 (let (($x1345 (= v_1_tx_time_06 (ite (or (>= 6 ?x806) $x1187) 0 (ite $x1191 ?x1342 v_0_tx_time_06)))))
 (let (($x1208 (= 9 ?x286)))
 (let ((?x1320 (ite $x1206 v_0_tx_time_13 (ite $x1208 v_0_tx_time_14 (ite (= 10 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1323 (ite $x1200 v_0_tx_time_10 (ite $x1202 v_0_tx_time_11 (ite $x1204 v_0_tx_time_12 ?x1320)))))
 (let ((?x1326 (ite $x1194 v_0_tx_time_07 (ite $x1196 v_0_tx_time_08 (ite $x1198 v_0_tx_time_09 ?x1323)))))
 (let ((?x1329 (ite (or (>= 5 ?x806) $x1187) 0 (ite $x1191 (ite $x1192 v_0_tx_time_06 ?x1326) v_0_tx_time_05))))
 (let (($x1210 (= 10 ?x286)))
 (let ((?x1303 (ite $x1208 v_0_tx_time_13 (ite $x1210 v_0_tx_time_14 (ite (= 11 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1306 (ite $x1202 v_0_tx_time_10 (ite $x1204 v_0_tx_time_11 (ite $x1206 v_0_tx_time_12 ?x1303)))))
 (let ((?x1309 (ite $x1196 v_0_tx_time_07 (ite $x1198 v_0_tx_time_08 (ite $x1200 v_0_tx_time_09 ?x1306)))))
 (let ((?x1312 (ite $x1191 (ite $x1192 v_0_tx_time_05 (ite $x1194 v_0_tx_time_06 ?x1309)) v_0_tx_time_04)))
 (let (($x1212 (= 11 ?x286)))
 (let ((?x1285 (ite $x1210 v_0_tx_time_13 (ite $x1212 v_0_tx_time_14 (ite (= 12 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1288 (ite $x1204 v_0_tx_time_10 (ite $x1206 v_0_tx_time_11 (ite $x1208 v_0_tx_time_12 ?x1285)))))
 (let ((?x1291 (ite $x1198 v_0_tx_time_07 (ite $x1200 v_0_tx_time_08 (ite $x1202 v_0_tx_time_09 ?x1288)))))
 (let ((?x1294 (ite $x1192 v_0_tx_time_04 (ite $x1194 v_0_tx_time_05 (ite $x1196 v_0_tx_time_06 ?x1291)))))
 (let (($x1297 (= v_1_tx_time_03 (ite (or $x1187 (>= 3 ?x806)) 0 (ite $x1191 ?x1294 v_0_tx_time_03)))))
 (let (($x1214 (= 12 ?x286)))
 (let ((?x1266 (ite $x1212 v_0_tx_time_13 (ite $x1214 v_0_tx_time_14 (ite (= 13 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1269 (ite $x1206 v_0_tx_time_10 (ite $x1208 v_0_tx_time_11 (ite $x1210 v_0_tx_time_12 ?x1266)))))
 (let ((?x1272 (ite $x1200 v_0_tx_time_07 (ite $x1202 v_0_tx_time_08 (ite $x1204 v_0_tx_time_09 ?x1269)))))
 (let ((?x1275 (ite $x1194 v_0_tx_time_04 (ite $x1196 v_0_tx_time_05 (ite $x1198 v_0_tx_time_06 ?x1272)))))
 (let ((?x1278 (ite (or $x1187 (>= 2 ?x806)) 0 (ite $x1191 (ite $x1192 v_0_tx_time_03 ?x1275) v_0_tx_time_02))))
 (let (($x1216 (= 13 ?x286)))
 (let ((?x1246 (ite $x1214 v_0_tx_time_13 (ite $x1216 v_0_tx_time_14 (ite (= 14 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1249 (ite $x1208 v_0_tx_time_10 (ite $x1210 v_0_tx_time_11 (ite $x1212 v_0_tx_time_12 ?x1246)))))
 (let ((?x1252 (ite $x1202 v_0_tx_time_07 (ite $x1204 v_0_tx_time_08 (ite $x1206 v_0_tx_time_09 ?x1249)))))
 (let ((?x1255 (ite $x1196 v_0_tx_time_04 (ite $x1198 v_0_tx_time_05 (ite $x1200 v_0_tx_time_06 ?x1252)))))
 (let ((?x1258 (ite $x1191 (ite $x1192 v_0_tx_time_02 (ite $x1194 v_0_tx_time_03 ?x1255)) v_0_tx_time_01)))
 (let (($x1218 (= 14 ?x286)))
 (let ((?x1224 (ite $x1216 v_0_tx_time_13 (ite $x1218 v_0_tx_time_14 (ite (= 15 ?x286) v_0_tx_time_15 0)))))
 (let ((?x1227 (ite $x1210 v_0_tx_time_10 (ite $x1212 v_0_tx_time_11 (ite $x1214 v_0_tx_time_12 ?x1224)))))
 (let ((?x1230 (ite $x1204 v_0_tx_time_07 (ite $x1206 v_0_tx_time_08 (ite $x1208 v_0_tx_time_09 ?x1227)))))
 (let ((?x1233 (ite $x1198 v_0_tx_time_04 (ite $x1200 v_0_tx_time_05 (ite $x1202 v_0_tx_time_06 ?x1230)))))
 (let ((?x1236 (ite $x1192 v_0_tx_time_01 (ite $x1194 v_0_tx_time_02 (ite $x1196 v_0_tx_time_03 ?x1233)))))
 (let (($x1240 (= v_1_tx_time_00 (ite (or $x1187 (>= 0 ?x806)) 0 (ite $x1191 ?x1236 v_0_tx_time_00)))))
 (let (($x1174 (= v_1_rtt_sample_was_ambiguous (and v_0_rtt_active v_0_rtt_ambiguous))))
 (let (($x1169 (not v_1_rtt_start_new)))
 (let ((?x799 (* ?x273 ?x286)))
 (let ((?x1161 (+ ?x716 ?x799)))
 (let (($x1164 (and v_0_rtt_active $x307 $x327 $x330 (not (<= v_0_rtt_remaining ?x1161)))))
 (let (($x1145 (and v_0_rtt_active $x307 $x327 $x330 $x717)))
 (let (($x1167 (= v_1_rtt_remaining (ite $x1145 0 (ite $x1164 ?x1161 v_0_rtt_remaining)))))
 (let (($x1158 (= v_1_rtt_end v_0_rtt_end)))
 (let (($x1157 (= v_1_rtt_start_ms v_0_rtt_start_ms)))
 (let (($x1143 (= v_1_rtt_previous_measured (ite $x720 v_0_rtt_measured v_0_rtt_previous_measured))))
 (let (($x1136 (= v_1_rtt_previous_var (ite $x720 v_0_rttvar_ms v_0_rtt_previous_var))))
 (let (($x1132 (= v_1_rtt_previous_srtt (ite $x720 v_0_srtt_ms v_0_rtt_previous_srtt))))
 (let ((?x1112 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data) 4294967296)))
 (let (($x1105 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x1101 (= v_1_fin_requested v_0_fin_requested)))
 (let (($x823 (<= 2147483648 (mod (+ input_0_net.fin_segment_ack (* ?x273 v_0_snd_wl2)) 4294967296))))
 (let (($x819 (= v_0_snd_wl1 input_0_net.fin_segment_seq)))
 (let ((?x813 (mod (+ input_0_net.fin_segment_seq (* ?x273 v_0_snd_wl1)) 4294967296)))
 (let (($x826 (or (and (not (<= ?x813 0)) (not (<= 2147483648 ?x813))) (and $x819 (not $x823)))))
 (let (($x827 (and $x307 $x330 $x826)))
 (let ((?x1079 (ite (or (not (and $x365 (not $x647))) (and $x345 $x342 $x668)) 0 ?x644)))
 (let (($x895 (not $x647)))
 (let (($x699 (not $x365)))
 (let (($x864 (not $x404)))
 (let (($x862 (not $x424)))
 (let (($x860 (not $x444)))
 (let (($x858 (not $x464)))
 (let (($x856 (not $x484)))
 (let (($x854 (not $x504)))
 (let (($x852 (not $x522)))
 (let (($x850 (not $x540)))
 (let (($x848 (not $x558)))
 (let (($x846 (not $x576)))
 (let (($x844 (not $x594)))
 (let (($x842 (not $x612)))
 (let (($x840 (not $x630)))
 (let (($x839 (and false $x648)))
 (let (($x841 (and $x839 $x840)))
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
 (let (($x866 (or (and $x863 $x864) $x383 $x381)))
 (let ((?x693 (ite $x629 0 ?x626)))
 (let (($x669 (and $x345 $x342 $x668)))
 (let (($x1075 (= v_1_rx_slot_14 (ite $x669 0 (ite $x365 ?x693 (ite (and $x866 $x699 $x895) ?x644 0))))))
 (let (($x867 (and $x866 $x699)))
 (let ((?x1067 (ite $x867 ?x693 (ite (and (or $x863 $x404) (not $x384) $x699 $x895) ?x644 0))))
 (let ((?x692 (ite $x611 0 ?x608)))
 (let (($x869 (not $x384)))
 (let (($x868 (or $x863 $x404)))
 (let (($x870 (and $x868 $x869 $x699)))
 (let ((?x1060 (ite $x870 ?x693 (ite (and (or $x861 $x424) $x864 $x869 $x699 $x895) ?x644 0))))
 (let ((?x691 (ite $x593 0 ?x590)))
 (let (($x1064 (= v_1_rx_slot_12 (ite $x669 0 (ite $x365 ?x691 (ite $x867 ?x692 ?x1060))))))
 (let (($x871 (or $x861 $x424)))
 (let (($x872 (and $x871 $x864 $x869 $x699)))
 (let ((?x1052 (ite $x872 ?x693 (ite (and (or $x859 $x444) $x862 $x864 $x869 $x699 $x895) ?x644 0))))
 (let ((?x690 (ite $x575 0 ?x572)))
 (let (($x1057 (= v_1_rx_slot_11 (ite $x669 0 (ite $x365 ?x690 (ite $x867 ?x691 (ite $x870 ?x692 ?x1052)))))))
 (let (($x873 (or $x859 $x444)))
 (let (($x874 (and $x873 $x862 $x864 $x869 $x699)))
 (let ((?x1043 (ite $x874 ?x693 (ite (and (or $x857 $x464) $x860 $x862 $x864 $x869 $x699 $x895) ?x644 0))))
 (let ((?x689 (ite $x557 0 ?x554)))
 (let ((?x1048 (ite $x669 0 (ite $x365 ?x689 (ite $x867 ?x690 (ite $x870 ?x691 (ite $x872 ?x692 ?x1043)))))))
 (let ((?x1032 (ite (and (or $x855 $x484) $x858 $x860 $x862 $x864 $x869 $x699 $x895) ?x644 0)))
 (let (($x875 (or $x857 $x464)))
 (let (($x876 (and $x875 $x860 $x862 $x864 $x869 $x699)))
 (let ((?x1037 (ite $x867 ?x689 (ite $x870 ?x690 (ite $x872 ?x691 (ite $x874 ?x692 (ite $x876 ?x693 ?x1032)))))))
 (let ((?x688 (ite $x539 0 ?x536)))
 (let ((?x1021 (ite (and (or $x853 $x504) $x856 $x858 $x860 $x862 $x864 $x869 $x699 $x895) ?x644 0)))
 (let (($x877 (or $x855 $x484)))
 (let (($x878 (and $x877 $x858 $x860 $x862 $x864 $x869 $x699)))
 (let ((?x1026 (ite $x870 ?x689 (ite $x872 ?x690 (ite $x874 ?x691 (ite $x876 ?x692 (ite $x878 ?x693 ?x1021)))))))
 (let ((?x687 (ite $x521 0 ?x518)))
 (let (($x1030 (= v_1_rx_slot_08 (ite $x669 0 (ite $x365 ?x687 (ite $x867 ?x688 ?x1026))))))
 (let ((?x1009 (ite (and (or $x851 $x522) $x854 $x856 $x858 $x860 $x862 $x864 $x869 $x699 $x895) ?x644 0)))
 (let (($x879 (or $x853 $x504)))
 (let (($x880 (and $x879 $x856 $x858 $x860 $x862 $x864 $x869 $x699)))
 (let ((?x1014 (ite $x872 ?x689 (ite $x874 ?x690 (ite $x876 ?x691 (ite $x878 ?x692 (ite $x880 ?x693 ?x1009)))))))
 (let ((?x686 (ite $x503 0 ?x500)))
 (let (($x1019 (= v_1_rx_slot_07 (ite $x669 0 (ite $x365 ?x686 (ite $x867 ?x687 (ite $x870 ?x688 ?x1014)))))))
 (let (($x883 (or $x849 $x540)))
 (let ((?x996 (ite (and $x883 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x869 $x699 $x895) ?x644 0)))
 (let (($x881 (or $x851 $x522)))
 (let (($x882 (and $x881 $x854 $x856 $x858 $x860 $x862 $x864 $x869 $x699)))
 (let ((?x1001 (ite $x874 ?x689 (ite $x876 ?x690 (ite $x878 ?x691 (ite $x880 ?x692 (ite $x882 ?x693 ?x996)))))))
 (let ((?x685 (ite $x483 0 ?x480)))
 (let ((?x1006 (ite $x669 0 (ite $x365 ?x685 (ite $x867 ?x686 (ite $x870 ?x687 (ite $x872 ?x688 ?x1001)))))))
 (let (($x885 (or $x847 $x558)))
 (let ((?x982 (ite (and $x885 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x869 $x699 $x895) ?x644 0)))
 (let (($x884 (and $x883 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x869 $x699)))
 (let ((?x987 (ite $x876 ?x689 (ite $x878 ?x690 (ite $x880 ?x691 (ite $x882 ?x692 (ite $x884 ?x693 ?x982)))))))
 (let ((?x684 (ite $x463 0 ?x460)))
 (let ((?x992 (ite $x365 ?x684 (ite $x867 ?x685 (ite $x870 ?x686 (ite $x872 ?x687 (ite $x874 ?x688 ?x987)))))))
 (let (($x887 (or $x845 $x576)))
 (let (($x966 (and $x887 $x848 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x869 $x699 $x895)))
 (let (($x886 (and $x885 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x869 $x699)))
 (let ((?x971 (ite $x880 ?x690 (ite $x882 ?x691 (ite $x884 ?x692 (ite $x886 ?x693 (ite $x966 ?x644 0)))))))
 (let ((?x976 (ite $x870 ?x685 (ite $x872 ?x686 (ite $x874 ?x687 (ite $x876 ?x688 (ite $x878 ?x689 ?x971)))))))
 (let ((?x683 (ite $x443 0 ?x440)))
 (let (($x980 (= v_1_rx_slot_04 (ite $x669 0 (ite $x365 ?x683 (ite $x867 ?x684 ?x976))))))
 (let (($x889 (or $x843 $x594)))
 (let (($x950 (and $x889 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x869 $x699 $x895)))
 (let (($x888 (and $x887 $x848 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x869 $x699)))
 (let ((?x955 (ite $x882 ?x690 (ite $x884 ?x691 (ite $x886 ?x692 (ite $x888 ?x693 (ite $x950 ?x644 0)))))))
 (let ((?x960 (ite $x872 ?x685 (ite $x874 ?x686 (ite $x876 ?x687 (ite $x878 ?x688 (ite $x880 ?x689 ?x955)))))))
 (let ((?x682 (ite $x423 0 ?x420)))
 (let (($x965 (= v_1_rx_slot_03 (ite $x669 0 (ite $x365 ?x682 (ite $x867 ?x683 (ite $x870 ?x684 ?x960)))))))
 (let (($x891 (or $x841 $x612)))
 (let (($x933 (and $x891 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x869 $x699 $x895)))
 (let (($x890 (and $x889 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x869 $x699)))
 (let ((?x938 (ite $x884 ?x690 (ite $x886 ?x691 (ite $x888 ?x692 (ite $x890 ?x693 (ite $x933 ?x644 0)))))))
 (let ((?x943 (ite $x874 ?x685 (ite $x876 ?x686 (ite $x878 ?x687 (ite $x880 ?x688 (ite $x882 ?x689 ?x938)))))))
 (let ((?x681 (ite $x403 0 ?x400)))
 (let ((?x948 (ite $x669 0 (ite $x365 ?x681 (ite $x867 ?x682 (ite $x870 ?x683 (ite $x872 ?x684 ?x943)))))))
 (let (($x893 (or $x839 $x630)))
 (let (($x915 (and $x893 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x869 $x699 $x895)))
 (let (($x892 (and $x891 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x869 $x699)))
 (let ((?x920 (ite $x886 ?x690 (ite $x888 ?x691 (ite $x890 ?x692 (ite $x892 ?x693 (ite $x915 ?x644 0)))))))
 (let ((?x925 (ite $x876 ?x685 (ite $x878 ?x686 (ite $x880 ?x687 (ite $x882 ?x688 (ite $x884 ?x689 ?x920)))))))
 (let ((?x680 (ite $x383 0 ?x380)))
 (let ((?x930 (ite $x365 ?x680 (ite $x867 ?x681 (ite $x870 ?x682 (ite $x872 ?x683 (ite $x874 ?x684 ?x925)))))))
 (let (($x896 (and $x648 $x840 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x869 $x699 $x895)))
 (let (($x894 (and $x893 $x842 $x844 $x846 $x848 $x850 $x852 $x854 $x856 $x858 $x860 $x862 $x864 $x869 $x699)))
 (let ((?x901 (ite $x888 ?x690 (ite $x890 ?x691 (ite $x892 ?x692 (ite $x894 ?x693 (ite $x896 ?x644 0)))))))
 (let ((?x906 (ite $x878 ?x685 (ite $x880 ?x686 (ite $x882 ?x687 (ite $x884 ?x688 (ite $x886 ?x689 ?x901)))))))
 (let ((?x911 (ite $x867 ?x680 (ite $x870 ?x681 (ite $x872 ?x682 (ite $x874 ?x683 (ite $x876 ?x684 ?x906)))))))
 (let ((?x679 (ite $x364 0 ?x361)))
 (let ((?x701 (ite (and (<= 0 ?x664) $x699) ?x663 0)))
 (let ((?x695 (+ ?x679 ?x680 ?x681 ?x682 ?x683 ?x684 ?x685 ?x686 ?x687 ?x688 ?x689 ?x690 ?x691 ?x692 ?x693 (ite $x647 0 ?x644))))
 (let ((?x697 (ite (<= ?x695 0) 0 ?x695)))
 (let ((?x703 (ite (<= ?x697 ?x701) ?x697 ?x701)))
 (let (($x837 (= v_1_take v_0_take)))
 (let (($x797 (= v_1_snd_buf v_0_snd_buf)))
 (let (($x791 (= v_1_msl_ms v_0_msl_ms)))
 (let (($x788 (= v_1_user_timeout_ms v_0_user_timeout_ms)))
 (let (($x785 (= v_1_active_open v_0_active_open)))
 (let (($x782 (= v_1_retries v_0_retries)))
 (let (($x712 (= v_1_tx_flags v_0_tx_flags)))
 (let (($x709 (= v_1_tx_ack v_0_tx_ack)))
 (let (($x708 (= v_1_tx_seq v_0_tx_seq)))
 (let (($x707 (= v_1_rcv_nxt (mod (+ v_0_rcv_nxt ?x703 (ite $x669 1 0)) 4294967296))))
 (let (($x678 (= v_1_snd_nxt v_0_snd_nxt)))
 (let (($x674 (= v_1_irs v_0_irs)))
 (let (($x673 (= v_1_iss v_0_iss)))
 (let (($x670 (not $x669)))
 (let (($x314 (= 0 ?x286)))
 (let (($x292 (= (mod (+ input_0_net.fin_segment_ack (* ?x273 v_0_snd_nxt)) 4294967296) 2147483648)))
 (and (>= now_1 now_0) (<= 0 input_0_net.fin_segment_data) (>= 16 input_0_net.fin_segment_data) (not (= ?x276 2147483648)) (<= 0 input_0_net.fin_segment_window) (>= 65535 input_0_net.fin_segment_window) (or (and (not (= ?x286 2147483648)) (not $x292)) (not $x307)) v_0_fin_sent (not (= ?x286 (+ 1 v_0_rtx_buf))) $x314 (or (not active_0_rtx) (not (<= due_0_rtx now_1))) (or (not active_0_user) (not (<= due_0_user now_1))) (or (not active_0_time_wait) (not (<= due_0_time_wait now_1))) (or (not active_0_delack) (not (<= due_0_delack now_1))) $x333 $x670 $x672 $x673 $x674 (= v_1_snd_una (ite $x675 input_0_net.fin_segment_ack v_0_snd_una)) $x678 $x707 $x708 $x709 $x712 (= v_1_rto_ms ?x778) $x782 $x785 $x788 $x791 (= v_1_local_window (+ 16 (* ?x273 v_0_rcv_buf) (* ?x273 ?x703))) $x797 (= v_1_rtx_buf ?x806) (= v_1_rcv_buf (+ v_0_rcv_buf ?x703)) (= v_1_snd_wnd (ite $x827 input_0_net.fin_segment_window v_0_snd_wnd)) (= v_1_snd_wl1 (ite $x827 input_0_net.fin_segment_seq v_0_snd_wl1)) (= v_1_snd_wl2 (ite $x827 input_0_net.fin_segment_ack v_0_snd_wl2)) $x837 (= v_1_rx_chunk ?x703) (= v_1_rx_slot_00 (ite $x669 0 (ite $x365 ?x679 ?x911))) (= v_1_rx_slot_01 (ite $x669 0 ?x930)) (= v_1_rx_slot_02 ?x948) $x965 $x980 (= v_1_rx_slot_05 (ite $x669 0 ?x992)) (= v_1_rx_slot_06 ?x1006) $x1019 $x1030 (= v_1_rx_slot_09 (ite $x669 0 (ite $x365 ?x688 ?x1037))) (= v_1_rx_slot_10 ?x1048) $x1057 $x1064 (= v_1_rx_slot_13 (ite $x669 0 (ite $x365 ?x692 ?x1067))) $x1075 (= v_1_rx_slot_15 ?x1079) (= v_1_rx_advance ?x664) (= v_1_rx_acceptable (and $x307 $x340 $x342)) (= v_1_seg_acceptable $x307) (= v_1_ack_delta ?x286) (= v_1_ack_is_new (and $x327 $x330)) (= v_1_ack_is_future $x339) (= v_1_ack_advance $x675) (= v_1_ack_window_update $x827) $x1101 (= v_1_fin_sent $x1103) $x1105 (= v_1_fin_acknowledged $x332) (= v_1_rx_fin_pending (and $x345 $x670)) (= v_1_rx_fin_seq (ite $x344 ?x1112 v_0_rx_fin_seq)) (= v_1_rx_fin_offset (ite $x669 0 ?x667)) (= v_1_rx_fin_done (or v_0_rx_fin_done $x669)) (= v_1_rx_fin_consumed $x669) (= v_1_srtt_ms ?x740) (= v_1_rttvar_ms ?x763) (= v_1_rtt_error_ms ?x756) $x1132 $x1136 (= v_1_rtt_measured (or v_0_rtt_measured $x720)) $x1143 (= v_1_rtt_active (and v_0_rtt_active (not $x1145))) (= v_1_rtt_ambiguous (and (not $x1145) v_0_rtt_ambiguous)) (= v_1_rtt_sample_at_ms (ite $x720 now_1 v_0_rtt_sample_at_ms)) $x1157 $x1158 $x1167 $x1169 (= v_1_rtt_sample_used $x720) $x1174 (= v_1_rtt_last_ms ?x735) (= v_1_rtt_samples (+ v_0_rtt_samples (ite $x720 1 0))) (= v_1_rto_base_ms (ite $x720 ?x776 v_0_rto_base_ms)) $x1240 (= v_1_tx_time_01 (ite (or (>= 1 ?x806) $x1187) 0 ?x1258)) (= v_1_tx_time_02 ?x1278) $x1297 (= v_1_tx_time_04 (ite (or (>= 4 ?x806) $x1187) 0 ?x1312)) (= v_1_tx_time_05 ?x1329) $x1345 (= v_1_tx_time_07 (ite (or (>= 7 ?x806) $x1187) 0 ?x1357)) (= v_1_tx_time_08 ?x1371) $x1384 (= v_1_tx_time_10 (ite (or $x1187 (>= 10 ?x806)) 0 ?x1393)) (= v_1_tx_time_11 ?x1404) $x1414 (= v_1_tx_time_13 (ite (or $x1187 (>= 13 ?x806)) 0 ?x1420)) (= v_1_tx_time_14 ?x1428) $x1434 (= v_1_tx_fin_time (ite $x1103 v_0_tx_fin_time 0)) $x1441 $x1444 $x1447 $x1449 $x1452 $x1455 $x1458 $x1460 $x1462 $x1464 $x1466 $x1468 $x1470 $x1472 $x1474 $x1477 $x1480 $x1482 $x1484 (= active_1_rtx (and $x672 $x1494)) (= active_1_user (and $x672 active_0_user)) (= active_1_time_wait (or active_0_time_wait $x671)) $x1504 (= due_1_rtx (ite $x1493 (+ now_1 ?x778) due_0_rtx)) $x1510 (= due_1_time_wait (ite $x671 ?x1513 due_0_time_wait)) $x1517)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
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
 (let ((?x1523 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1523)))
(assert
 (>= 16 v_0_rcv_buf))
(assert
 (and (<= 0 v_0_snd_wnd) (>= 65535 v_0_snd_wnd)))
(assert
 (= v_0_local_window (+ 16 (* (- 1) v_0_rcv_buf))))
(assert
 (>= 1 v_0_rx_slot_00))
(assert
 (let (($x348 (= 0 v_0_rx_slot_00)))
 (let (($x1533 (not (>= v_0_rcv_buf 16))))
 (or $x1533 $x348))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x366 (= 0 v_0_rx_slot_01)))
 (let (($x1537 (not (>= v_0_rcv_buf 15))))
 (or $x1537 $x366))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x385 (= 0 v_0_rx_slot_02)))
 (let (($x1541 (not (>= v_0_rcv_buf 14))))
 (or $x1541 $x385))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x405 (= 0 v_0_rx_slot_03)))
 (let (($x1545 (not (>= v_0_rcv_buf 13))))
 (or $x1545 $x405))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x425 (= 0 v_0_rx_slot_04)))
 (let (($x1549 (not (>= v_0_rcv_buf 12))))
 (or $x1549 $x425))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x445 (= 0 v_0_rx_slot_05)))
 (let (($x1553 (not (>= v_0_rcv_buf 11))))
 (or $x1553 $x445))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x465 (= 0 v_0_rx_slot_06)))
 (let (($x1557 (not (>= v_0_rcv_buf 10))))
 (or $x1557 $x465))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x485 (= 0 v_0_rx_slot_07)))
 (let (($x1561 (not (>= v_0_rcv_buf 9))))
 (or $x1561 $x485))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x505 (= 0 v_0_rx_slot_08)))
 (let (($x1565 (not (>= v_0_rcv_buf 8))))
 (or $x1565 $x505))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x523 (= 0 v_0_rx_slot_09)))
 (let (($x1569 (not (>= v_0_rcv_buf 7))))
 (or $x1569 $x523))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x541 (= 0 v_0_rx_slot_10)))
 (let (($x1573 (not (>= v_0_rcv_buf 6))))
 (or $x1573 $x541))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x559 (= 0 v_0_rx_slot_11)))
 (let (($x1577 (not (>= v_0_rcv_buf 5))))
 (or $x1577 $x559))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x577 (= 0 v_0_rx_slot_12)))
 (let (($x1581 (not (>= v_0_rcv_buf 4))))
 (or $x1581 $x577))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x595 (= 0 v_0_rx_slot_13)))
 (let (($x1585 (not (>= v_0_rcv_buf 3))))
 (or $x1585 $x595))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x613 (= 0 v_0_rx_slot_14)))
 (let (($x1589 (not (>= v_0_rcv_buf 2))))
 (or $x1589 $x613))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x631 (= 0 v_0_rx_slot_15)))
 (let (($x1593 (not (>= v_0_rcv_buf 1))))
 (or $x1593 $x631))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x1595 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x1595)))
(assert
 (and (<= 0 v_0_rx_advance) (>= 16 v_0_rx_advance)))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (and (<= 0 v_0_ack_delta) (>= 4294967295 v_0_ack_delta)))
(assert
 true)
(assert
 (let ((?x1608 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x1608)))
(assert
 (= active_0_rtx (<= 1 (+ v_0_rtx_buf (ite v_0_fin_sent 1 0)))))
(assert
 (let (($x1617 (and v_0_fin_requested (= v_0_fin_seq (mod (+ v_0_snd_una v_0_rtx_buf) 4294967296)) (= 0 v_0_snd_buf))))
 (let (($x1612 (not v_0_fin_sent)))
 (or $x1612 $x1617))))
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
 (let (($x1619 (<= 1 v_0_rx_fin_offset)))
 (let (($x342 (not v_0_rx_fin_done)))
 (let (($x1621 (and $x342 $x1619 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window)))))
 (let (($x343 (not v_0_rx_fin_pending)))
 (or $x343 $x1621))))))
(assert
 (let (($x1624 (>= 15 v_0_rx_fin_offset)))
 (and (<= 0 v_0_rx_fin_offset) $x1624 (= v_0_rx_fin_pending (<= 1 v_0_rx_fin_offset)))))
(assert
 (let (($x343 (not v_0_rx_fin_pending)))
 (or $x343 (= v_0_rx_fin_seq (mod (+ v_0_rcv_nxt v_0_rx_fin_offset) 4294967296)))))
(assert
 (let (($x342 (not v_0_rx_fin_done)))
 (or $x342 (= v_0_rcv_nxt (mod (+ 1 v_0_rx_fin_seq) 4294967296)))))
(assert
 (let (($x348 (= 0 v_0_rx_slot_00)))
 (or (not (and v_0_rx_fin_pending (>= 0 v_0_rx_fin_offset))) $x348)))
(assert
 (let (($x366 (= 0 v_0_rx_slot_01)))
 (or (not (and v_0_rx_fin_pending (>= 1 v_0_rx_fin_offset))) $x366)))
(assert
 (let (($x385 (= 0 v_0_rx_slot_02)))
 (or (not (and v_0_rx_fin_pending (>= 2 v_0_rx_fin_offset))) $x385)))
(assert
 (let (($x405 (= 0 v_0_rx_slot_03)))
 (or (not (and v_0_rx_fin_pending (>= 3 v_0_rx_fin_offset))) $x405)))
(assert
 (let (($x425 (= 0 v_0_rx_slot_04)))
 (or (not (and v_0_rx_fin_pending (>= 4 v_0_rx_fin_offset))) $x425)))
(assert
 (let (($x445 (= 0 v_0_rx_slot_05)))
 (or (not (and v_0_rx_fin_pending (>= 5 v_0_rx_fin_offset))) $x445)))
(assert
 (let (($x465 (= 0 v_0_rx_slot_06)))
 (or (not (and v_0_rx_fin_pending (>= 6 v_0_rx_fin_offset))) $x465)))
(assert
 (let (($x485 (= 0 v_0_rx_slot_07)))
 (or (not (and v_0_rx_fin_pending (>= 7 v_0_rx_fin_offset))) $x485)))
(assert
 (let (($x505 (= 0 v_0_rx_slot_08)))
 (or (not (and v_0_rx_fin_pending (>= 8 v_0_rx_fin_offset))) $x505)))
(assert
 (let (($x523 (= 0 v_0_rx_slot_09)))
 (or (not (and v_0_rx_fin_pending (>= 9 v_0_rx_fin_offset))) $x523)))
(assert
 (let (($x541 (= 0 v_0_rx_slot_10)))
 (or (not (and v_0_rx_fin_pending (>= 10 v_0_rx_fin_offset))) $x541)))
(assert
 (let (($x559 (= 0 v_0_rx_slot_11)))
 (or (not (and v_0_rx_fin_pending (>= 11 v_0_rx_fin_offset))) $x559)))
(assert
 (let (($x577 (= 0 v_0_rx_slot_12)))
 (or (not (and v_0_rx_fin_pending (>= 12 v_0_rx_fin_offset))) $x577)))
(assert
 (let (($x595 (= 0 v_0_rx_slot_13)))
 (or (not (and v_0_rx_fin_pending (>= 13 v_0_rx_fin_offset))) $x595)))
(assert
 (let (($x613 (= 0 v_0_rx_slot_14)))
 (or (not (and v_0_rx_fin_pending (>= 14 v_0_rx_fin_offset))) $x613)))
(assert
 (let (($x631 (= 0 v_0_rx_slot_15)))
 (or (not (and v_0_rx_fin_pending (>= 15 v_0_rx_fin_offset))) $x631)))
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
 (let ((?x1712 (* 4.0 v_0_rttvar_ms)))
 (let ((?x723 (- 1.0)))
 (let ((?x752 (* ?x723 v_0_srtt_ms)))
 (let ((?x1715 (+ ?x752 (* ?x723 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x1712)))))
 (let ((?x1716 (to_int ?x1715)))
 (let ((?x273 (- 1)))
 (let ((?x1719 (ite (<= ?x1716 (- 1000)) (* ?x273 ?x1716) 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x1719) 60000 ?x1719) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x716 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x1734 (and (<= v_0_rtt_start_ms now_0) (<= 1 v_0_rtt_remaining) (>= 4 v_0_rtt_remaining) (>= ?x716 v_0_rtt_remaining) (<= ?x716 (mod (+ v_0_snd_nxt (* (- 1) v_0_snd_una)) 4294967296)))))
 (let (($x1726 (not v_0_rtt_active)))
 (or $x1726 $x1734)))))
(assert
 (or v_0_rtt_active (= 0 v_0_rtt_remaining)))
(assert
 true)
(assert
 (let (($x1743 (= v_0_rtt_last_ms (+ v_0_rtt_sample_at_ms (* (- 1) v_0_rtt_start_ms)))))
 (let (($x1741 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1739 (not v_0_rtt_sample_used)))
 (or $x1739 (and $x1741 v_0_rtt_measured $x1743))))))
(assert
 (and (<= 0 v_0_rtt_sample_at_ms) (<= v_0_rtt_sample_at_ms now_0)))
(assert
 (let ((?x1750 (to_real v_0_rtt_last_ms)))
 (let ((?x1764 (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x1750))))
 (let ((?x1752 (+ v_0_rtt_previous_srtt (* (- 1.0) ?x1750))))
 (let ((?x1756 (ite (>= ?x1752 0.0) ?x1752 (+ (* (- 1.0) v_0_rtt_previous_srtt) ?x1750))))
 (let ((?x747 (/ 1.0 4.0)))
 (let ((?x1760 (ite v_0_rtt_previous_measured (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* ?x747 ?x1756)) (* (/ 1.0 2.0) ?x1750))))
 (let (($x1767 (and (= v_0_rttvar_ms ?x1760) (= v_0_srtt_ms (ite v_0_rtt_previous_measured ?x1764 ?x1750)))))
 (let (($x1739 (not v_0_rtt_sample_used)))
 (or $x1739 $x1767))))))))))
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
 (let (($x1903 (and (>= v_0_tx_elapsed v_0_tx_previous_rto) (<= 1 v_0_tx_emit_count) (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x1897 (not v_0_tx_retransmitted)))
 (or $x1897 $x1903))))
(assert
 (let (($x1897 (not v_0_tx_retransmitted)))
 (let (($x1906 (not v_0_tx_waiting)))
 (or $x1906 $x1897))))
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
 (let (($x1934 (not v_0_ack_pending)))
 (or $x1934 (and (<= 1 v_0_ack_bytes) (not v_0_rx_fin_done)))))
(assert
 (let (($x1941 (and (= 0 v_0_ack_bytes) (= 0 v_0_ack_full_segments) (= 0 v_0_ack_since_ms))))
 (or v_0_ack_pending $x1941)))
(assert
 (= 177 choice_0))
(assert
 (= 5 state_0))
(assert
 (= 5 state_1))
(assert
 (or (not (>= 16 (+ v_1_snd_buf v_1_rtx_buf)))))
(check-sat)
