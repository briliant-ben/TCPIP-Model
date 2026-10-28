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
(declare-fun due_1_time_wait () Int)
(declare-fun due_1_user () Int)
(declare-fun v_0_rto_ms () Int)
(declare-fun v_0_rttvar_ms () Real)
(declare-fun v_0_rtt_last_ms () Int)
(declare-fun v_0_rtt_start_ms () Int)
(declare-fun now_1 () Int)
(declare-fun v_0_rtt_ambiguous () Bool)
(declare-fun v_0_fin_sent () Bool)
(declare-fun v_0_local_window () Int)
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
(declare-fun v_0_rx_fin_offset () Int)
(declare-fun v_0_rx_fin_pending () Bool)
(declare-fun v_0_rx_fin_done () Bool)
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
(declare-fun v_0_msl_ms () Int)
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
 (let (($x1476 (= due_1_time_wait due_0_time_wait)))
 (let (($x1474 (= due_1_user due_0_user)))
 (let (($x702 (not v_0_rtt_ambiguous)))
 (let ((?x699 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let ((?x281 (mod (+ input_0_net.fin_segment_ack (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x700 (>= ?x281 ?x699)))
 (let ((?x316 (ite v_0_fin_sent 1 0)))
 (let ((?x656 (+ v_0_rtx_buf ?x316)))
 (let (($x657 (<= ?x281 ?x656)))
 (let (($x655 (<= 1 ?x281)))
 (let ((?x268 (- 1)))
 (let ((?x295 (+ ?x268 v_0_local_window)))
 (let (($x300 (<= (mod (+ input_0_net.fin_segment_seq (* ?x268 v_0_rcv_nxt)) 4294967296) ?x295)))
 (let (($x291 (<= 1 v_0_local_window)))
 (let ((?x292 (* ?x268 v_0_rcv_nxt)))
 (let ((?x294 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data ?x292) 4294967296)))
 (let (($x296 (<= ?x294 ?x295)))
 (let (($x302 (or (and $x291 $x296) (and $x291 $x300))))
 (let (($x703 (and v_0_rtt_active $x302 $x655 $x657 $x700 $x702)))
 (let ((?x718 (ite $x703 (+ now_1 (* ?x268 v_0_rtt_start_ms)) v_0_rtt_last_ms)))
 (let ((?x719 (to_real ?x718)))
 (let ((?x743 (/ 1.0 2.0)))
 (let ((?x732 (+ v_0_srtt_ms (* (- 1.0) ?x719))))
 (let ((?x739 (ite $x703 (ite (>= ?x732 0.0) ?x732 (+ (* (- 1.0) v_0_srtt_ms) ?x719)) v_0_rtt_error_ms)))
 (let ((?x730 (/ 1.0 4.0)))
 (let ((?x745 (ite v_0_rtt_measured (+ (* (/ 3.0 4.0) v_0_rttvar_ms) (* ?x730 ?x739)) (* ?x743 ?x719))))
 (let ((?x746 (ite $x703 ?x745 v_0_rttvar_ms)))
 (let ((?x706 (- 1.0)))
 (let ((?x722 (ite v_0_rtt_measured (+ (* (/ 7.0 8.0) v_0_srtt_ms) (* (/ 1.0 8.0) ?x719)) ?x719)))
 (let ((?x723 (ite $x703 ?x722 v_0_srtt_ms)))
 (let ((?x751 (+ (* ?x706 ?x723) (* ?x706 (ite (<= ?x746 ?x730) 1.0 (* 4.0 ?x746))))))
 (let ((?x752 (to_int ?x751)))
 (let ((?x757 (ite (<= ?x752 (- 1000)) (* ?x268 ?x752) 1000)))
 (let ((?x759 (ite (<= 60000 ?x757) 60000 ?x757)))
 (let ((?x761 (ite $x703 ?x759 v_0_rto_ms)))
 (let (($x1089 (and (not (and $x302 $x655 $x657 v_0_fin_sent (= ?x281 ?x656))) v_0_fin_sent)))
 (let ((?x786 (ite (<= 0 v_0_rtx_buf) v_0_rtx_buf 0)))
 (let ((?x784 (ite (<= v_0_rtx_buf ?x281) 0 (+ v_0_rtx_buf (* ?x268 ?x281)))))
 (let (($x658 (and $x302 $x655 $x657)))
 (let ((?x789 (ite $x658 (ite (<= ?x784 ?x786) ?x784 ?x786) v_0_rtx_buf)))
 (let ((?x1456 (+ ?x789 (ite $x1089 1 0))))
 (let (($x1462 (and $x302 $x655 $x657 (<= 1 ?x1456))))
 (let (($x1468 (= active_1_time_wait active_0_time_wait)))
 (let (($x1466 (= active_1_user active_0_user)))
 (let (($x1463 (or (and (not (and $x302 $x655 $x657 (= 0 ?x1456))) active_0_rtx) $x1462)))
 (let (($x1453 (not v_1_syn_timeout_eligible)))
 (let (($x1451 (not v_1_tx_syn_pending)))
 (let (($x1449 (= v_1_tx_syn_time 0)))
 (let (($x1447 (not v_1_tx_waiting)))
 (let (($x1445 (= v_1_tx_is_fin v_0_tx_is_fin)))
 (let (($x1442 (= v_1_tx_previous_rto v_0_tx_previous_rto)))
 (let (($x1439 (= v_1_tx_elapsed v_0_tx_elapsed)))
 (let (($x1436 (not v_1_tx_retransmitted)))
 (let (($x1434 (= v_1_tx_max_previous v_0_tx_max_previous)))
 (let (($x1431 (= v_1_tx_eligible v_0_tx_eligible)))
 (let (($x1428 (= v_1_tx_emit_count v_0_tx_emit_count)))
 (let (($x1178 (and $x302 $x655 $x657 (not (= 0 ?x281)))))
 (let (($x1173 (= 0 ?x789)))
 (let (($x1421 (= v_1_tx_time_15 (ite (or $x1173 (>= 15 ?x789) $x1178) 0 v_0_tx_time_15))))
 (let ((?x1415 (ite (or (>= 14 ?x789) $x1173) 0 (ite $x1178 (ite (= 1 ?x281) v_0_tx_time_15 0) v_0_tx_time_14))))
 (let (($x1179 (= 1 ?x281)))
 (let ((?x1407 (ite $x1178 (ite $x1179 v_0_tx_time_14 (ite (= 2 ?x281) v_0_tx_time_15 0)) v_0_tx_time_13)))
 (let (($x1181 (= 2 ?x281)))
 (let ((?x1398 (ite $x1179 v_0_tx_time_13 (ite $x1181 v_0_tx_time_14 (ite (= 3 ?x281) v_0_tx_time_15 0)))))
 (let (($x1401 (= v_1_tx_time_12 (ite (or $x1173 (>= 12 ?x789)) 0 (ite $x1178 ?x1398 v_0_tx_time_12)))))
 (let (($x1183 (= 3 ?x281)))
 (let ((?x1388 (ite $x1181 v_0_tx_time_13 (ite $x1183 v_0_tx_time_14 (ite (= 4 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1391 (ite (or $x1173 (>= 11 ?x789)) 0 (ite $x1178 (ite $x1179 v_0_tx_time_12 ?x1388) v_0_tx_time_11))))
 (let (($x1185 (= 4 ?x281)))
 (let ((?x1377 (ite $x1183 v_0_tx_time_13 (ite $x1185 v_0_tx_time_14 (ite (= 5 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1380 (ite $x1178 (ite $x1179 v_0_tx_time_11 (ite $x1181 v_0_tx_time_12 ?x1377)) v_0_tx_time_10)))
 (let (($x1187 (= 5 ?x281)))
 (let ((?x1365 (ite $x1185 v_0_tx_time_13 (ite $x1187 v_0_tx_time_14 (ite (= 6 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1368 (ite $x1179 v_0_tx_time_10 (ite $x1181 v_0_tx_time_11 (ite $x1183 v_0_tx_time_12 ?x1365)))))
 (let (($x1371 (= v_1_tx_time_09 (ite (or (>= 9 ?x789) $x1173) 0 (ite $x1178 ?x1368 v_0_tx_time_09)))))
 (let (($x1189 (= 6 ?x281)))
 (let ((?x1352 (ite $x1187 v_0_tx_time_13 (ite $x1189 v_0_tx_time_14 (ite (= 7 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1355 (ite $x1181 v_0_tx_time_10 (ite $x1183 v_0_tx_time_11 (ite $x1185 v_0_tx_time_12 ?x1352)))))
 (let ((?x1358 (ite (or (>= 8 ?x789) $x1173) 0 (ite $x1178 (ite $x1179 v_0_tx_time_09 ?x1355) v_0_tx_time_08))))
 (let (($x1191 (= 7 ?x281)))
 (let ((?x1338 (ite $x1189 v_0_tx_time_13 (ite $x1191 v_0_tx_time_14 (ite (= 8 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1341 (ite $x1183 v_0_tx_time_10 (ite $x1185 v_0_tx_time_11 (ite $x1187 v_0_tx_time_12 ?x1338)))))
 (let ((?x1344 (ite $x1178 (ite $x1179 v_0_tx_time_08 (ite $x1181 v_0_tx_time_09 ?x1341)) v_0_tx_time_07)))
 (let (($x1193 (= 8 ?x281)))
 (let ((?x1323 (ite $x1191 v_0_tx_time_13 (ite $x1193 v_0_tx_time_14 (ite (= 9 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1326 (ite $x1185 v_0_tx_time_10 (ite $x1187 v_0_tx_time_11 (ite $x1189 v_0_tx_time_12 ?x1323)))))
 (let ((?x1329 (ite $x1179 v_0_tx_time_07 (ite $x1181 v_0_tx_time_08 (ite $x1183 v_0_tx_time_09 ?x1326)))))
 (let (($x1332 (= v_1_tx_time_06 (ite (or $x1173 (>= 6 ?x789)) 0 (ite $x1178 ?x1329 v_0_tx_time_06)))))
 (let (($x1195 (= 9 ?x281)))
 (let ((?x1307 (ite $x1193 v_0_tx_time_13 (ite $x1195 v_0_tx_time_14 (ite (= 10 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1310 (ite $x1187 v_0_tx_time_10 (ite $x1189 v_0_tx_time_11 (ite $x1191 v_0_tx_time_12 ?x1307)))))
 (let ((?x1313 (ite $x1181 v_0_tx_time_07 (ite $x1183 v_0_tx_time_08 (ite $x1185 v_0_tx_time_09 ?x1310)))))
 (let ((?x1316 (ite (or $x1173 (>= 5 ?x789)) 0 (ite $x1178 (ite $x1179 v_0_tx_time_06 ?x1313) v_0_tx_time_05))))
 (let (($x1197 (= 10 ?x281)))
 (let ((?x1290 (ite $x1195 v_0_tx_time_13 (ite $x1197 v_0_tx_time_14 (ite (= 11 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1293 (ite $x1189 v_0_tx_time_10 (ite $x1191 v_0_tx_time_11 (ite $x1193 v_0_tx_time_12 ?x1290)))))
 (let ((?x1296 (ite $x1183 v_0_tx_time_07 (ite $x1185 v_0_tx_time_08 (ite $x1187 v_0_tx_time_09 ?x1293)))))
 (let ((?x1299 (ite $x1178 (ite $x1179 v_0_tx_time_05 (ite $x1181 v_0_tx_time_06 ?x1296)) v_0_tx_time_04)))
 (let (($x1199 (= 11 ?x281)))
 (let ((?x1272 (ite $x1197 v_0_tx_time_13 (ite $x1199 v_0_tx_time_14 (ite (= 12 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1275 (ite $x1191 v_0_tx_time_10 (ite $x1193 v_0_tx_time_11 (ite $x1195 v_0_tx_time_12 ?x1272)))))
 (let ((?x1278 (ite $x1185 v_0_tx_time_07 (ite $x1187 v_0_tx_time_08 (ite $x1189 v_0_tx_time_09 ?x1275)))))
 (let ((?x1281 (ite $x1179 v_0_tx_time_04 (ite $x1181 v_0_tx_time_05 (ite $x1183 v_0_tx_time_06 ?x1278)))))
 (let (($x1284 (= v_1_tx_time_03 (ite (or $x1173 (>= 3 ?x789)) 0 (ite $x1178 ?x1281 v_0_tx_time_03)))))
 (let (($x1201 (= 12 ?x281)))
 (let ((?x1253 (ite $x1199 v_0_tx_time_13 (ite $x1201 v_0_tx_time_14 (ite (= 13 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1256 (ite $x1193 v_0_tx_time_10 (ite $x1195 v_0_tx_time_11 (ite $x1197 v_0_tx_time_12 ?x1253)))))
 (let ((?x1259 (ite $x1187 v_0_tx_time_07 (ite $x1189 v_0_tx_time_08 (ite $x1191 v_0_tx_time_09 ?x1256)))))
 (let ((?x1262 (ite $x1181 v_0_tx_time_04 (ite $x1183 v_0_tx_time_05 (ite $x1185 v_0_tx_time_06 ?x1259)))))
 (let ((?x1265 (ite (or $x1173 (>= 2 ?x789)) 0 (ite $x1178 (ite $x1179 v_0_tx_time_03 ?x1262) v_0_tx_time_02))))
 (let (($x1203 (= 13 ?x281)))
 (let ((?x1233 (ite $x1201 v_0_tx_time_13 (ite $x1203 v_0_tx_time_14 (ite (= 14 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1236 (ite $x1195 v_0_tx_time_10 (ite $x1197 v_0_tx_time_11 (ite $x1199 v_0_tx_time_12 ?x1233)))))
 (let ((?x1239 (ite $x1189 v_0_tx_time_07 (ite $x1191 v_0_tx_time_08 (ite $x1193 v_0_tx_time_09 ?x1236)))))
 (let ((?x1242 (ite $x1183 v_0_tx_time_04 (ite $x1185 v_0_tx_time_05 (ite $x1187 v_0_tx_time_06 ?x1239)))))
 (let ((?x1245 (ite $x1178 (ite $x1179 v_0_tx_time_02 (ite $x1181 v_0_tx_time_03 ?x1242)) v_0_tx_time_01)))
 (let (($x1205 (= 14 ?x281)))
 (let ((?x1211 (ite $x1203 v_0_tx_time_13 (ite $x1205 v_0_tx_time_14 (ite (= 15 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1214 (ite $x1197 v_0_tx_time_10 (ite $x1199 v_0_tx_time_11 (ite $x1201 v_0_tx_time_12 ?x1211)))))
 (let ((?x1217 (ite $x1191 v_0_tx_time_07 (ite $x1193 v_0_tx_time_08 (ite $x1195 v_0_tx_time_09 ?x1214)))))
 (let ((?x1220 (ite $x1185 v_0_tx_time_04 (ite $x1187 v_0_tx_time_05 (ite $x1189 v_0_tx_time_06 ?x1217)))))
 (let ((?x1223 (ite $x1179 v_0_tx_time_01 (ite $x1181 v_0_tx_time_02 (ite $x1183 v_0_tx_time_03 ?x1220)))))
 (let (($x1227 (= v_1_tx_time_00 (ite (or $x1173 (>= 0 ?x789)) 0 (ite $x1178 ?x1223 v_0_tx_time_00)))))
 (let (($x1160 (= v_1_rtt_sample_was_ambiguous (and v_0_rtt_active v_0_rtt_ambiguous))))
 (let (($x1155 (not v_1_rtt_start_new)))
 (let ((?x782 (* ?x268 ?x281)))
 (let ((?x1147 (+ ?x699 ?x782)))
 (let (($x1150 (and v_0_rtt_active $x302 $x655 $x657 (not (<= v_0_rtt_remaining ?x1147)))))
 (let (($x1131 (and v_0_rtt_active $x302 $x655 $x657 $x700)))
 (let (($x1153 (= v_1_rtt_remaining (ite $x1131 0 (ite $x1150 ?x1147 v_0_rtt_remaining)))))
 (let (($x1144 (= v_1_rtt_end v_0_rtt_end)))
 (let (($x1143 (= v_1_rtt_start_ms v_0_rtt_start_ms)))
 (let (($x1129 (= v_1_rtt_previous_measured (ite $x703 v_0_rtt_measured v_0_rtt_previous_measured))))
 (let (($x1122 (= v_1_rtt_previous_var (ite $x703 v_0_rttvar_ms v_0_rtt_previous_var))))
 (let (($x1118 (= v_1_rtt_previous_srtt (ite $x703 v_0_srtt_ms v_0_rtt_previous_srtt))))
 (let (($x325 (not v_0_rx_fin_pending)))
 (let (($x324 (not v_0_rx_fin_done)))
 (let (($x321 (and (>= ?x281 (+ 1 v_0_rtx_buf ?x316)) (>= 2147483647 ?x281))))
 (let (($x322 (not $x321)))
 (let (($x326 (and $x302 $x322 $x324 $x325 $x291 $x296)))
 (let ((?x329 (ite $x326 ?x294 v_0_rx_fin_offset)))
 (let (($x327 (or v_0_rx_fin_pending $x326)))
 (let (($x629 (and $x327 (>= 15 ?x329))))
 (let ((?x616 (mod (+ 15 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x621 (+ input_0_net.fin_segment_data (* ?x268 ?x616))))
 (let (($x619 (<= input_0_net.fin_segment_data ?x616)))
 (let (($x614 (<= v_0_rcv_buf 0)))
 (let (($x613 (= 0 v_0_rx_slot_15)))
 (let (($x618 (and $x302 $x322 $x324 $x613 $x614 (<= ?x616 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x626 (ite $x618 (ite (or $x619 (<= ?x621 1)) (ite $x619 0 ?x621) 1) v_0_rx_slot_15)))
 (let (($x630 (or (= ?x626 0) $x629)))
 (let (($x611 (and $x327 (>= 14 ?x329))))
 (let ((?x598 (mod (+ 14 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x603 (+ input_0_net.fin_segment_data (* ?x268 ?x598))))
 (let (($x601 (<= input_0_net.fin_segment_data ?x598)))
 (let (($x596 (<= v_0_rcv_buf 1)))
 (let (($x595 (= 0 v_0_rx_slot_14)))
 (let (($x600 (and $x302 $x322 $x324 $x595 $x596 (<= ?x598 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x608 (ite $x600 (ite (or $x601 (<= ?x603 1)) (ite $x601 0 ?x603) 1) v_0_rx_slot_14)))
 (let (($x612 (or (= ?x608 0) $x611)))
 (let (($x593 (and $x327 (>= 13 ?x329))))
 (let ((?x580 (mod (+ 13 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x585 (+ input_0_net.fin_segment_data (* ?x268 ?x580))))
 (let (($x583 (<= input_0_net.fin_segment_data ?x580)))
 (let (($x578 (<= v_0_rcv_buf 2)))
 (let (($x577 (= 0 v_0_rx_slot_13)))
 (let (($x582 (and $x302 $x322 $x324 $x577 $x578 (<= ?x580 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x590 (ite $x582 (ite (or $x583 (<= ?x585 1)) (ite $x583 0 ?x585) 1) v_0_rx_slot_13)))
 (let (($x594 (or (= ?x590 0) $x593)))
 (let (($x575 (and $x327 (>= 12 ?x329))))
 (let ((?x562 (mod (+ 12 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x567 (+ input_0_net.fin_segment_data (* ?x268 ?x562))))
 (let (($x565 (<= input_0_net.fin_segment_data ?x562)))
 (let (($x560 (<= v_0_rcv_buf 3)))
 (let (($x559 (= 0 v_0_rx_slot_12)))
 (let (($x564 (and $x302 $x322 $x324 $x559 $x560 (<= ?x562 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x572 (ite $x564 (ite (or $x565 (<= ?x567 1)) (ite $x565 0 ?x567) 1) v_0_rx_slot_12)))
 (let (($x576 (or (= ?x572 0) $x575)))
 (let ((?x634 (ite $x576 12 (ite $x594 13 (ite $x612 14 (ite $x630 15 16))))))
 (let (($x557 (and $x327 (>= 11 ?x329))))
 (let ((?x544 (mod (+ 11 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x549 (+ input_0_net.fin_segment_data (* ?x268 ?x544))))
 (let (($x547 (<= input_0_net.fin_segment_data ?x544)))
 (let (($x542 (<= v_0_rcv_buf 4)))
 (let (($x541 (= 0 v_0_rx_slot_11)))
 (let (($x546 (and $x302 $x322 $x324 $x541 $x542 (<= ?x544 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x554 (ite $x546 (ite (or $x547 (<= ?x549 1)) (ite $x547 0 ?x549) 1) v_0_rx_slot_11)))
 (let (($x558 (or (= ?x554 0) $x557)))
 (let (($x539 (and $x327 (>= 10 ?x329))))
 (let ((?x526 (mod (+ 10 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x531 (+ input_0_net.fin_segment_data (* ?x268 ?x526))))
 (let (($x529 (<= input_0_net.fin_segment_data ?x526)))
 (let (($x524 (<= v_0_rcv_buf 5)))
 (let (($x523 (= 0 v_0_rx_slot_10)))
 (let (($x528 (and $x302 $x322 $x324 $x523 $x524 (<= ?x526 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x536 (ite $x528 (ite (or $x529 (<= ?x531 1)) (ite $x529 0 ?x531) 1) v_0_rx_slot_10)))
 (let (($x540 (or (= ?x536 0) $x539)))
 (let (($x521 (and $x327 (>= 9 ?x329))))
 (let ((?x508 (mod (+ 9 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x513 (+ input_0_net.fin_segment_data (* ?x268 ?x508))))
 (let (($x511 (<= input_0_net.fin_segment_data ?x508)))
 (let (($x506 (<= v_0_rcv_buf 6)))
 (let (($x505 (= 0 v_0_rx_slot_09)))
 (let (($x510 (and $x302 $x322 $x324 $x505 $x506 (<= ?x508 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x518 (ite $x510 (ite (or $x511 (<= ?x513 1)) (ite $x511 0 ?x513) 1) v_0_rx_slot_09)))
 (let (($x522 (or (= ?x518 0) $x521)))
 (let (($x503 (and $x327 (>= 8 ?x329))))
 (let ((?x490 (mod (+ 8 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x495 (+ input_0_net.fin_segment_data (* ?x268 ?x490))))
 (let (($x493 (<= input_0_net.fin_segment_data ?x490)))
 (let (($x488 (<= v_0_rcv_buf 7)))
 (let (($x487 (= 0 v_0_rx_slot_08)))
 (let (($x492 (and $x302 $x322 $x324 $x487 $x488 (<= ?x490 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x500 (ite $x492 (ite (or $x493 (<= ?x495 1)) (ite $x493 0 ?x495) 1) v_0_rx_slot_08)))
 (let (($x504 (or (= ?x500 0) $x503)))
 (let ((?x638 (ite $x504 8 (ite $x522 9 (ite $x540 10 (ite $x558 11 ?x634))))))
 (let (($x485 (and $x327 (>= 7 ?x329))))
 (let ((?x472 (mod (+ 7 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x477 (+ input_0_net.fin_segment_data (* ?x268 ?x472))))
 (let (($x475 (<= input_0_net.fin_segment_data ?x472)))
 (let (($x469 (<= v_0_rcv_buf 8)))
 (let (($x467 (= 0 v_0_rx_slot_07)))
 (let (($x474 (and $x302 $x322 $x324 $x467 $x469 (<= ?x472 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x482 (ite $x474 (ite (or $x475 (<= ?x477 1)) (ite $x475 0 ?x477) 1) v_0_rx_slot_07)))
 (let (($x486 (or (= ?x482 0) $x485)))
 (let (($x465 (and $x327 (>= 6 ?x329))))
 (let ((?x452 (mod (+ 6 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x457 (+ input_0_net.fin_segment_data (* ?x268 ?x452))))
 (let (($x455 (<= input_0_net.fin_segment_data ?x452)))
 (let (($x449 (<= v_0_rcv_buf 9)))
 (let (($x447 (= 0 v_0_rx_slot_06)))
 (let (($x454 (and $x302 $x322 $x324 $x447 $x449 (<= ?x452 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x462 (ite $x454 (ite (or $x455 (<= ?x457 1)) (ite $x455 0 ?x457) 1) v_0_rx_slot_06)))
 (let (($x466 (or (= ?x462 0) $x465)))
 (let (($x445 (and $x327 (>= 5 ?x329))))
 (let ((?x432 (mod (+ 5 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x437 (+ input_0_net.fin_segment_data (* ?x268 ?x432))))
 (let (($x435 (<= input_0_net.fin_segment_data ?x432)))
 (let (($x429 (<= v_0_rcv_buf 10)))
 (let (($x427 (= 0 v_0_rx_slot_05)))
 (let (($x434 (and $x302 $x322 $x324 $x427 $x429 (<= ?x432 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x442 (ite $x434 (ite (or $x435 (<= ?x437 1)) (ite $x435 0 ?x437) 1) v_0_rx_slot_05)))
 (let (($x446 (or (= ?x442 0) $x445)))
 (let (($x425 (and $x327 (>= 4 ?x329))))
 (let ((?x412 (mod (+ 4 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x417 (+ input_0_net.fin_segment_data (* ?x268 ?x412))))
 (let (($x415 (<= input_0_net.fin_segment_data ?x412)))
 (let (($x409 (<= v_0_rcv_buf 11)))
 (let (($x407 (= 0 v_0_rx_slot_04)))
 (let (($x414 (and $x302 $x322 $x324 $x407 $x409 (<= ?x412 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x422 (ite $x414 (ite (or $x415 (<= ?x417 1)) (ite $x415 0 ?x417) 1) v_0_rx_slot_04)))
 (let (($x426 (or (= ?x422 0) $x425)))
 (let ((?x642 (ite $x426 4 (ite $x446 5 (ite $x466 6 (ite $x486 7 ?x638))))))
 (let (($x405 (and $x327 (>= 3 ?x329))))
 (let ((?x392 (mod (+ 3 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x397 (+ input_0_net.fin_segment_data (* ?x268 ?x392))))
 (let (($x395 (<= input_0_net.fin_segment_data ?x392)))
 (let (($x389 (<= v_0_rcv_buf 12)))
 (let (($x387 (= 0 v_0_rx_slot_03)))
 (let (($x394 (and $x302 $x322 $x324 $x387 $x389 (<= ?x392 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x402 (ite $x394 (ite (or $x395 (<= ?x397 1)) (ite $x395 0 ?x397) 1) v_0_rx_slot_03)))
 (let (($x406 (or (= ?x402 0) $x405)))
 (let (($x385 (and $x327 (>= 2 ?x329))))
 (let ((?x372 (mod (+ 2 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x377 (+ input_0_net.fin_segment_data (* ?x268 ?x372))))
 (let (($x375 (<= input_0_net.fin_segment_data ?x372)))
 (let (($x369 (<= v_0_rcv_buf 13)))
 (let (($x367 (= 0 v_0_rx_slot_02)))
 (let (($x374 (and $x302 $x322 $x324 $x367 $x369 (<= ?x372 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x382 (ite $x374 (ite (or $x375 (<= ?x377 1)) (ite $x375 0 ?x377) 1) v_0_rx_slot_02)))
 (let (($x386 (or (= ?x382 0) $x385)))
 (let (($x365 (and $x327 (>= 1 ?x329))))
 (let ((?x352 (mod (+ 1 v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x357 (+ input_0_net.fin_segment_data (* ?x268 ?x352))))
 (let (($x355 (<= input_0_net.fin_segment_data ?x352)))
 (let (($x350 (<= v_0_rcv_buf 14)))
 (let (($x348 (= 0 v_0_rx_slot_01)))
 (let (($x354 (and $x302 $x322 $x324 $x348 $x350 (<= ?x352 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x362 (ite $x354 (ite (or $x355 (<= ?x357 1)) (ite $x355 0 ?x357) 1) v_0_rx_slot_01)))
 (let (($x363 (= ?x362 0)))
 (let (($x366 (or $x363 $x365)))
 (let ((?x645 (ite $x366 1 (ite $x386 2 (ite $x406 3 ?x642)))))
 (let (($x346 (and $x327 (>= 0 ?x329))))
 (let ((?x271 (mod (+ v_0_rcv_nxt (* ?x268 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x338 (+ input_0_net.fin_segment_data (* ?x268 ?x271))))
 (let (($x336 (<= input_0_net.fin_segment_data ?x271)))
 (let (($x332 (<= v_0_rcv_buf 15)))
 (let (($x330 (= 0 v_0_rx_slot_00)))
 (let (($x335 (and $x302 $x322 $x324 $x330 $x332 (<= ?x271 (+ ?x268 input_0_net.fin_segment_data)))))
 (let ((?x343 (ite $x335 (ite (or $x336 (<= ?x338 1)) (ite $x336 0 ?x338) 1) v_0_rx_slot_00)))
 (let (($x347 (or (= ?x343 0) $x346)))
 (let ((?x646 (ite $x347 0 ?x645)))
 (let ((?x649 (ite $x327 (+ ?x329 (* ?x268 ?x646)) ?x329)))
 (let (($x651 (and $x327 $x324 (= 0 ?x649))))
 (let ((?x1098 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data) 4294967296)))
 (let (($x1087 (and $x302 $x655 $x657 v_0_fin_sent (= ?x281 ?x656))))
 (let (($x1091 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x1084 (= v_1_fin_requested v_0_fin_requested)))
 (let ((?x803 (mod (+ input_0_net.fin_segment_seq (* ?x268 v_0_snd_wl1)) 4294967296)))
 (let (($x798 (<= 2147483648 (mod (+ input_0_net.fin_segment_ack (* ?x268 v_0_snd_wl2)) 4294967296))))
 (let (($x794 (= v_0_snd_wl1 input_0_net.fin_segment_seq)))
 (let (($x809 (or (and $x794 (not $x798)) (and (not (<= ?x803 0)) (not (<= 2147483648 ?x803))))))
 (let (($x810 (and $x302 $x657 $x809)))
 (let (($x1063 (= v_1_rx_slot_15 (ite (or (not (and $x347 (not $x629))) $x651) 0 ?x626))))
 (let (($x878 (not $x629)))
 (let (($x682 (not $x347)))
 (let (($x847 (not $x386)))
 (let (($x845 (not $x406)))
 (let (($x843 (not $x426)))
 (let (($x841 (not $x446)))
 (let (($x839 (not $x466)))
 (let (($x837 (not $x486)))
 (let (($x835 (not $x504)))
 (let (($x833 (not $x522)))
 (let (($x831 (not $x540)))
 (let (($x829 (not $x558)))
 (let (($x827 (not $x576)))
 (let (($x825 (not $x594)))
 (let (($x823 (not $x612)))
 (let (($x822 (and false $x630)))
 (let (($x824 (and $x822 $x823)))
 (let (($x826 (and $x824 $x825)))
 (let (($x828 (and $x826 $x827)))
 (let (($x830 (and $x828 $x829)))
 (let (($x832 (and $x830 $x831)))
 (let (($x834 (and $x832 $x833)))
 (let (($x836 (and $x834 $x835)))
 (let (($x838 (and $x836 $x837)))
 (let (($x840 (and $x838 $x839)))
 (let (($x842 (and $x840 $x841)))
 (let (($x844 (and $x842 $x843)))
 (let (($x846 (and $x844 $x845)))
 (let (($x849 (or (and $x846 $x847) $x363 $x365)))
 (let ((?x676 (ite $x611 0 ?x608)))
 (let (($x1058 (= v_1_rx_slot_14 (ite $x651 0 (ite $x347 ?x676 (ite (and $x849 $x682 $x878) ?x626 0))))))
 (let (($x850 (and $x849 $x682)))
 (let ((?x1050 (ite $x850 ?x676 (ite (and (or $x846 $x386) (not $x366) $x682 $x878) ?x626 0))))
 (let ((?x675 (ite $x593 0 ?x590)))
 (let (($x852 (not $x366)))
 (let (($x851 (or $x846 $x386)))
 (let (($x853 (and $x851 $x852 $x682)))
 (let ((?x1043 (ite $x853 ?x676 (ite (and (or $x844 $x406) $x847 $x852 $x682 $x878) ?x626 0))))
 (let ((?x674 (ite $x575 0 ?x572)))
 (let (($x1047 (= v_1_rx_slot_12 (ite $x651 0 (ite $x347 ?x674 (ite $x850 ?x675 ?x1043))))))
 (let (($x854 (or $x844 $x406)))
 (let (($x855 (and $x854 $x847 $x852 $x682)))
 (let ((?x1035 (ite $x855 ?x676 (ite (and (or $x842 $x426) $x845 $x847 $x852 $x682 $x878) ?x626 0))))
 (let ((?x673 (ite $x557 0 ?x554)))
 (let (($x1040 (= v_1_rx_slot_11 (ite $x651 0 (ite $x347 ?x673 (ite $x850 ?x674 (ite $x853 ?x675 ?x1035)))))))
 (let (($x856 (or $x842 $x426)))
 (let (($x857 (and $x856 $x845 $x847 $x852 $x682)))
 (let ((?x1026 (ite $x857 ?x676 (ite (and (or $x840 $x446) $x843 $x845 $x847 $x852 $x682 $x878) ?x626 0))))
 (let ((?x672 (ite $x539 0 ?x536)))
 (let ((?x1031 (ite $x651 0 (ite $x347 ?x672 (ite $x850 ?x673 (ite $x853 ?x674 (ite $x855 ?x675 ?x1026)))))))
 (let ((?x1015 (ite (and (or $x838 $x466) $x841 $x843 $x845 $x847 $x852 $x682 $x878) ?x626 0)))
 (let (($x858 (or $x840 $x446)))
 (let (($x859 (and $x858 $x843 $x845 $x847 $x852 $x682)))
 (let ((?x1020 (ite $x850 ?x672 (ite $x853 ?x673 (ite $x855 ?x674 (ite $x857 ?x675 (ite $x859 ?x676 ?x1015)))))))
 (let ((?x671 (ite $x521 0 ?x518)))
 (let ((?x1004 (ite (and (or $x836 $x486) $x839 $x841 $x843 $x845 $x847 $x852 $x682 $x878) ?x626 0)))
 (let (($x860 (or $x838 $x466)))
 (let (($x861 (and $x860 $x841 $x843 $x845 $x847 $x852 $x682)))
 (let ((?x1009 (ite $x853 ?x672 (ite $x855 ?x673 (ite $x857 ?x674 (ite $x859 ?x675 (ite $x861 ?x676 ?x1004)))))))
 (let ((?x670 (ite $x503 0 ?x500)))
 (let (($x1013 (= v_1_rx_slot_08 (ite $x651 0 (ite $x347 ?x670 (ite $x850 ?x671 ?x1009))))))
 (let ((?x992 (ite (and (or $x834 $x504) $x837 $x839 $x841 $x843 $x845 $x847 $x852 $x682 $x878) ?x626 0)))
 (let (($x862 (or $x836 $x486)))
 (let (($x863 (and $x862 $x839 $x841 $x843 $x845 $x847 $x852 $x682)))
 (let ((?x997 (ite $x855 ?x672 (ite $x857 ?x673 (ite $x859 ?x674 (ite $x861 ?x675 (ite $x863 ?x676 ?x992)))))))
 (let ((?x669 (ite $x485 0 ?x482)))
 (let (($x1002 (= v_1_rx_slot_07 (ite $x651 0 (ite $x347 ?x669 (ite $x850 ?x670 (ite $x853 ?x671 ?x997)))))))
 (let (($x866 (or $x832 $x522)))
 (let ((?x979 (ite (and $x866 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x852 $x682 $x878) ?x626 0)))
 (let (($x864 (or $x834 $x504)))
 (let (($x865 (and $x864 $x837 $x839 $x841 $x843 $x845 $x847 $x852 $x682)))
 (let ((?x984 (ite $x857 ?x672 (ite $x859 ?x673 (ite $x861 ?x674 (ite $x863 ?x675 (ite $x865 ?x676 ?x979)))))))
 (let ((?x668 (ite $x465 0 ?x462)))
 (let ((?x989 (ite $x651 0 (ite $x347 ?x668 (ite $x850 ?x669 (ite $x853 ?x670 (ite $x855 ?x671 ?x984)))))))
 (let (($x868 (or $x830 $x540)))
 (let ((?x965 (ite (and $x868 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x852 $x682 $x878) ?x626 0)))
 (let (($x867 (and $x866 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x852 $x682)))
 (let ((?x970 (ite $x859 ?x672 (ite $x861 ?x673 (ite $x863 ?x674 (ite $x865 ?x675 (ite $x867 ?x676 ?x965)))))))
 (let ((?x667 (ite $x445 0 ?x442)))
 (let ((?x975 (ite $x347 ?x667 (ite $x850 ?x668 (ite $x853 ?x669 (ite $x855 ?x670 (ite $x857 ?x671 ?x970)))))))
 (let (($x870 (or $x828 $x558)))
 (let (($x949 (and $x870 $x831 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x852 $x682 $x878)))
 (let (($x869 (and $x868 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x852 $x682)))
 (let ((?x954 (ite $x863 ?x673 (ite $x865 ?x674 (ite $x867 ?x675 (ite $x869 ?x676 (ite $x949 ?x626 0)))))))
 (let ((?x959 (ite $x853 ?x668 (ite $x855 ?x669 (ite $x857 ?x670 (ite $x859 ?x671 (ite $x861 ?x672 ?x954)))))))
 (let ((?x666 (ite $x425 0 ?x422)))
 (let (($x963 (= v_1_rx_slot_04 (ite $x651 0 (ite $x347 ?x666 (ite $x850 ?x667 ?x959))))))
 (let (($x872 (or $x826 $x576)))
 (let (($x933 (and $x872 $x829 $x831 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x852 $x682 $x878)))
 (let (($x871 (and $x870 $x831 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x852 $x682)))
 (let ((?x938 (ite $x865 ?x673 (ite $x867 ?x674 (ite $x869 ?x675 (ite $x871 ?x676 (ite $x933 ?x626 0)))))))
 (let ((?x943 (ite $x855 ?x668 (ite $x857 ?x669 (ite $x859 ?x670 (ite $x861 ?x671 (ite $x863 ?x672 ?x938)))))))
 (let ((?x665 (ite $x405 0 ?x402)))
 (let (($x948 (= v_1_rx_slot_03 (ite $x651 0 (ite $x347 ?x665 (ite $x850 ?x666 (ite $x853 ?x667 ?x943)))))))
 (let (($x874 (or $x824 $x594)))
 (let (($x916 (and $x874 $x827 $x829 $x831 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x852 $x682 $x878)))
 (let (($x873 (and $x872 $x829 $x831 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x852 $x682)))
 (let ((?x921 (ite $x867 ?x673 (ite $x869 ?x674 (ite $x871 ?x675 (ite $x873 ?x676 (ite $x916 ?x626 0)))))))
 (let ((?x926 (ite $x857 ?x668 (ite $x859 ?x669 (ite $x861 ?x670 (ite $x863 ?x671 (ite $x865 ?x672 ?x921)))))))
 (let ((?x664 (ite $x385 0 ?x382)))
 (let ((?x931 (ite $x651 0 (ite $x347 ?x664 (ite $x850 ?x665 (ite $x853 ?x666 (ite $x855 ?x667 ?x926)))))))
 (let (($x876 (or $x822 $x612)))
 (let (($x898 (and $x876 $x825 $x827 $x829 $x831 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x852 $x682 $x878)))
 (let (($x875 (and $x874 $x827 $x829 $x831 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x852 $x682)))
 (let ((?x903 (ite $x869 ?x673 (ite $x871 ?x674 (ite $x873 ?x675 (ite $x875 ?x676 (ite $x898 ?x626 0)))))))
 (let ((?x908 (ite $x859 ?x668 (ite $x861 ?x669 (ite $x863 ?x670 (ite $x865 ?x671 (ite $x867 ?x672 ?x903)))))))
 (let ((?x663 (ite $x365 0 ?x362)))
 (let ((?x913 (ite $x347 ?x663 (ite $x850 ?x664 (ite $x853 ?x665 (ite $x855 ?x666 (ite $x857 ?x667 ?x908)))))))
 (let (($x879 (and $x630 $x823 $x825 $x827 $x829 $x831 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x852 $x682 $x878)))
 (let (($x877 (and $x876 $x825 $x827 $x829 $x831 $x833 $x835 $x837 $x839 $x841 $x843 $x845 $x847 $x852 $x682)))
 (let ((?x884 (ite $x871 ?x673 (ite $x873 ?x674 (ite $x875 ?x675 (ite $x877 ?x676 (ite $x879 ?x626 0)))))))
 (let ((?x889 (ite $x861 ?x668 (ite $x863 ?x669 (ite $x865 ?x670 (ite $x867 ?x671 (ite $x869 ?x672 ?x884)))))))
 (let ((?x894 (ite $x850 ?x663 (ite $x853 ?x664 (ite $x855 ?x665 (ite $x857 ?x666 (ite $x859 ?x667 ?x889)))))))
 (let ((?x662 (ite $x346 0 ?x343)))
 (let ((?x684 (ite (and (<= 0 ?x646) $x682) ?x645 0)))
 (let ((?x678 (+ ?x662 ?x663 ?x664 ?x665 ?x666 ?x667 ?x668 ?x669 ?x670 ?x671 ?x672 ?x673 ?x674 ?x675 ?x676 (ite $x629 0 ?x626))))
 (let ((?x680 (ite (<= ?x678 0) 0 ?x678)))
 (let ((?x686 (ite (<= ?x680 ?x684) ?x680 ?x684)))
 (let (($x820 (= v_1_take v_0_take)))
 (let (($x780 (= v_1_snd_buf v_0_snd_buf)))
 (let (($x774 (= v_1_msl_ms v_0_msl_ms)))
 (let (($x771 (= v_1_user_timeout_ms v_0_user_timeout_ms)))
 (let (($x768 (= v_1_active_open v_0_active_open)))
 (let (($x765 (= v_1_retries v_0_retries)))
 (let (($x695 (= v_1_tx_flags v_0_tx_flags)))
 (let (($x692 (= v_1_tx_ack v_0_tx_ack)))
 (let (($x691 (= v_1_tx_seq v_0_tx_seq)))
 (let (($x690 (= v_1_rcv_nxt (mod (+ v_0_rcv_nxt ?x686 (ite $x651 1 0)) 4294967296))))
 (let (($x661 (= v_1_snd_nxt v_0_snd_nxt)))
 (let (($x654 (= v_1_irs v_0_irs)))
 (let (($x653 (= v_1_iss v_0_iss)))
 (let (($x652 (not $x651)))
 (let (($x287 (= (mod (+ input_0_net.fin_segment_ack (* ?x268 v_0_snd_nxt)) 4294967296) 2147483648)))
 (and (>= now_1 now_0) (<= 0 input_0_net.fin_segment_data) (>= 16 input_0_net.fin_segment_data) (not (= ?x271 2147483648)) (<= 0 input_0_net.fin_segment_window) (>= 65535 input_0_net.fin_segment_window) (or (and (not (= ?x281 2147483648)) (not $x287)) (not $x302)) (or (not active_0_rtx) (not (<= due_0_rtx now_1))) (or (not active_0_user) (not (<= due_0_user now_1))) (or (not active_0_time_wait) (not (<= due_0_time_wait now_1))) $x652 $x653 $x654 (= v_1_snd_una (ite $x658 input_0_net.fin_segment_ack v_0_snd_una)) $x661 $x690 $x691 $x692 $x695 (= v_1_rto_ms ?x761) $x765 $x768 $x771 $x774 (= v_1_local_window (+ 16 (* ?x268 v_0_rcv_buf) (* ?x268 ?x686))) $x780 (= v_1_rtx_buf ?x789) (= v_1_rcv_buf (+ v_0_rcv_buf ?x686)) (= v_1_snd_wnd (ite $x810 input_0_net.fin_segment_window v_0_snd_wnd)) (= v_1_snd_wl1 (ite $x810 input_0_net.fin_segment_seq v_0_snd_wl1)) (= v_1_snd_wl2 (ite $x810 input_0_net.fin_segment_ack v_0_snd_wl2)) $x820 (= v_1_rx_chunk ?x686) (= v_1_rx_slot_00 (ite $x651 0 (ite $x347 ?x662 ?x894))) (= v_1_rx_slot_01 (ite $x651 0 ?x913)) (= v_1_rx_slot_02 ?x931) $x948 $x963 (= v_1_rx_slot_05 (ite $x651 0 ?x975)) (= v_1_rx_slot_06 ?x989) $x1002 $x1013 (= v_1_rx_slot_09 (ite $x651 0 (ite $x347 ?x671 ?x1020))) (= v_1_rx_slot_10 ?x1031) $x1040 $x1047 (= v_1_rx_slot_13 (ite $x651 0 (ite $x347 ?x675 ?x1050))) $x1058 $x1063 (= v_1_rx_advance ?x646) (= v_1_rx_acceptable (and $x302 $x322 $x324)) (= v_1_seg_acceptable $x302) (= v_1_ack_delta ?x281) (= v_1_ack_is_new (and $x655 $x657)) (= v_1_ack_is_future $x321) (= v_1_ack_advance $x658) (= v_1_ack_window_update $x810) $x1084 (= v_1_fin_sent $x1089) $x1091 (= v_1_fin_acknowledged $x1087) (= v_1_rx_fin_pending (and $x327 $x652)) (= v_1_rx_fin_seq (ite $x326 ?x1098 v_0_rx_fin_seq)) (= v_1_rx_fin_offset (ite $x651 0 ?x649)) (= v_1_rx_fin_done (or v_0_rx_fin_done $x651)) (= v_1_rx_fin_consumed $x651) (= v_1_srtt_ms ?x723) (= v_1_rttvar_ms ?x746) (= v_1_rtt_error_ms ?x739) $x1118 $x1122 (= v_1_rtt_measured (or v_0_rtt_measured $x703)) $x1129 (= v_1_rtt_active (and v_0_rtt_active (not $x1131))) (= v_1_rtt_ambiguous (and (not $x1131) v_0_rtt_ambiguous)) (= v_1_rtt_sample_at_ms (ite $x703 now_1 v_0_rtt_sample_at_ms)) $x1143 $x1144 $x1153 $x1155 (= v_1_rtt_sample_used $x703) $x1160 (= v_1_rtt_last_ms ?x718) (= v_1_rtt_samples (+ v_0_rtt_samples (ite $x703 1 0))) (= v_1_rto_base_ms (ite $x703 ?x759 v_0_rto_base_ms)) $x1227 (= v_1_tx_time_01 (ite (or (>= 1 ?x789) $x1173) 0 ?x1245)) (= v_1_tx_time_02 ?x1265) $x1284 (= v_1_tx_time_04 (ite (or (>= 4 ?x789) $x1173) 0 ?x1299)) (= v_1_tx_time_05 ?x1316) $x1332 (= v_1_tx_time_07 (ite (or $x1173 (>= 7 ?x789)) 0 ?x1344)) (= v_1_tx_time_08 ?x1358) $x1371 (= v_1_tx_time_10 (ite (or (>= 10 ?x789) $x1173) 0 ?x1380)) (= v_1_tx_time_11 ?x1391) $x1401 (= v_1_tx_time_13 (ite (or $x1173 (>= 13 ?x789)) 0 ?x1407)) (= v_1_tx_time_14 ?x1415) $x1421 (= v_1_tx_fin_time (ite $x1089 v_0_tx_fin_time 0)) $x1428 $x1431 $x1434 $x1436 $x1439 $x1442 $x1445 $x1447 $x1449 $x1451 $x1453 (= active_1_rtx $x1463) $x1466 $x1468 (= due_1_rtx (ite $x1462 (+ now_1 ?x761) due_0_rtx)) $x1474 $x1476)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
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
 (not active_0_user))
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
 (let ((?x1482 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1482)))
(assert
 (>= 16 v_0_rcv_buf))
(assert
 (and (<= 0 v_0_snd_wnd) (>= 65535 v_0_snd_wnd)))
(assert
 (= v_0_local_window (+ 16 (* (- 1) v_0_rcv_buf))))
(assert
 (>= 1 v_0_rx_slot_00))
(assert
 (let (($x330 (= 0 v_0_rx_slot_00)))
 (let (($x1492 (not (>= v_0_rcv_buf 16))))
 (or $x1492 $x330))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x348 (= 0 v_0_rx_slot_01)))
 (let (($x1496 (not (>= v_0_rcv_buf 15))))
 (or $x1496 $x348))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x367 (= 0 v_0_rx_slot_02)))
 (let (($x1500 (not (>= v_0_rcv_buf 14))))
 (or $x1500 $x367))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x387 (= 0 v_0_rx_slot_03)))
 (let (($x1504 (not (>= v_0_rcv_buf 13))))
 (or $x1504 $x387))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x407 (= 0 v_0_rx_slot_04)))
 (let (($x1508 (not (>= v_0_rcv_buf 12))))
 (or $x1508 $x407))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x427 (= 0 v_0_rx_slot_05)))
 (let (($x1512 (not (>= v_0_rcv_buf 11))))
 (or $x1512 $x427))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x447 (= 0 v_0_rx_slot_06)))
 (let (($x1516 (not (>= v_0_rcv_buf 10))))
 (or $x1516 $x447))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x467 (= 0 v_0_rx_slot_07)))
 (let (($x1520 (not (>= v_0_rcv_buf 9))))
 (or $x1520 $x467))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x487 (= 0 v_0_rx_slot_08)))
 (let (($x1524 (not (>= v_0_rcv_buf 8))))
 (or $x1524 $x487))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x505 (= 0 v_0_rx_slot_09)))
 (let (($x1528 (not (>= v_0_rcv_buf 7))))
 (or $x1528 $x505))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x523 (= 0 v_0_rx_slot_10)))
 (let (($x1532 (not (>= v_0_rcv_buf 6))))
 (or $x1532 $x523))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x541 (= 0 v_0_rx_slot_11)))
 (let (($x1536 (not (>= v_0_rcv_buf 5))))
 (or $x1536 $x541))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x559 (= 0 v_0_rx_slot_12)))
 (let (($x1540 (not (>= v_0_rcv_buf 4))))
 (or $x1540 $x559))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x577 (= 0 v_0_rx_slot_13)))
 (let (($x1544 (not (>= v_0_rcv_buf 3))))
 (or $x1544 $x577))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x595 (= 0 v_0_rx_slot_14)))
 (let (($x1548 (not (>= v_0_rcv_buf 2))))
 (or $x1548 $x595))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x613 (= 0 v_0_rx_slot_15)))
 (let (($x1552 (not (>= v_0_rcv_buf 1))))
 (or $x1552 $x613))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x1554 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x1554)))
(assert
 (and (<= 0 v_0_rx_advance) (>= 16 v_0_rx_advance)))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (and (<= 0 v_0_ack_delta) (>= 4294967295 v_0_ack_delta)))
(assert
 true)
(assert
 (let ((?x1567 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x1567)))
(assert
 (= active_0_rtx (<= 1 (+ v_0_rtx_buf (ite v_0_fin_sent 1 0)))))
(assert
 (not v_0_fin_sent))
(assert
 (not v_0_fin_requested))
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
 (not v_0_rx_fin_done))
(assert
 (let (($x1573 (<= 1 v_0_rx_fin_offset)))
 (let (($x324 (not v_0_rx_fin_done)))
 (let (($x1575 (and $x324 $x1573 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window)))))
 (let (($x325 (not v_0_rx_fin_pending)))
 (or $x325 $x1575))))))
(assert
 (let (($x1578 (>= 15 v_0_rx_fin_offset)))
 (and (<= 0 v_0_rx_fin_offset) $x1578 (= v_0_rx_fin_pending (<= 1 v_0_rx_fin_offset)))))
(assert
 (let (($x325 (not v_0_rx_fin_pending)))
 (or $x325 (= v_0_rx_fin_seq (mod (+ v_0_rcv_nxt v_0_rx_fin_offset) 4294967296)))))
(assert
 (let (($x324 (not v_0_rx_fin_done)))
 (or $x324 (= v_0_rcv_nxt (mod (+ 1 v_0_rx_fin_seq) 4294967296)))))
(assert
 (let (($x330 (= 0 v_0_rx_slot_00)))
 (or (not (and v_0_rx_fin_pending (>= 0 v_0_rx_fin_offset))) $x330)))
(assert
 (let (($x348 (= 0 v_0_rx_slot_01)))
 (or (not (and v_0_rx_fin_pending (>= 1 v_0_rx_fin_offset))) $x348)))
(assert
 (let (($x367 (= 0 v_0_rx_slot_02)))
 (or (not (and v_0_rx_fin_pending (>= 2 v_0_rx_fin_offset))) $x367)))
(assert
 (let (($x387 (= 0 v_0_rx_slot_03)))
 (or (not (and v_0_rx_fin_pending (>= 3 v_0_rx_fin_offset))) $x387)))
(assert
 (let (($x407 (= 0 v_0_rx_slot_04)))
 (or (not (and v_0_rx_fin_pending (>= 4 v_0_rx_fin_offset))) $x407)))
(assert
 (let (($x427 (= 0 v_0_rx_slot_05)))
 (or (not (and v_0_rx_fin_pending (>= 5 v_0_rx_fin_offset))) $x427)))
(assert
 (let (($x447 (= 0 v_0_rx_slot_06)))
 (or (not (and v_0_rx_fin_pending (>= 6 v_0_rx_fin_offset))) $x447)))
(assert
 (let (($x467 (= 0 v_0_rx_slot_07)))
 (or (not (and v_0_rx_fin_pending (>= 7 v_0_rx_fin_offset))) $x467)))
(assert
 (let (($x487 (= 0 v_0_rx_slot_08)))
 (or (not (and v_0_rx_fin_pending (>= 8 v_0_rx_fin_offset))) $x487)))
(assert
 (let (($x505 (= 0 v_0_rx_slot_09)))
 (or (not (and v_0_rx_fin_pending (>= 9 v_0_rx_fin_offset))) $x505)))
(assert
 (let (($x523 (= 0 v_0_rx_slot_10)))
 (or (not (and v_0_rx_fin_pending (>= 10 v_0_rx_fin_offset))) $x523)))
(assert
 (let (($x541 (= 0 v_0_rx_slot_11)))
 (or (not (and v_0_rx_fin_pending (>= 11 v_0_rx_fin_offset))) $x541)))
(assert
 (let (($x559 (= 0 v_0_rx_slot_12)))
 (or (not (and v_0_rx_fin_pending (>= 12 v_0_rx_fin_offset))) $x559)))
(assert
 (let (($x577 (= 0 v_0_rx_slot_13)))
 (or (not (and v_0_rx_fin_pending (>= 13 v_0_rx_fin_offset))) $x577)))
(assert
 (let (($x595 (= 0 v_0_rx_slot_14)))
 (or (not (and v_0_rx_fin_pending (>= 14 v_0_rx_fin_offset))) $x595)))
(assert
 (let (($x613 (= 0 v_0_rx_slot_15)))
 (or (not (and v_0_rx_fin_pending (>= 15 v_0_rx_fin_offset))) $x613)))
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
 (let ((?x1666 (* 4.0 v_0_rttvar_ms)))
 (let ((?x706 (- 1.0)))
 (let ((?x735 (* ?x706 v_0_srtt_ms)))
 (let ((?x1669 (+ ?x735 (* ?x706 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x1666)))))
 (let ((?x1670 (to_int ?x1669)))
 (let ((?x268 (- 1)))
 (let ((?x1673 (ite (<= ?x1670 (- 1000)) (* ?x268 ?x1670) 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x1673) 60000 ?x1673) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x699 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x1688 (and (<= v_0_rtt_start_ms now_0) (<= 1 v_0_rtt_remaining) (>= 4 v_0_rtt_remaining) (>= ?x699 v_0_rtt_remaining) (<= ?x699 (mod (+ v_0_snd_nxt (* (- 1) v_0_snd_una)) 4294967296)))))
 (let (($x1680 (not v_0_rtt_active)))
 (or $x1680 $x1688)))))
(assert
 (or v_0_rtt_active (= 0 v_0_rtt_remaining)))
(assert
 true)
(assert
 (let (($x1697 (= v_0_rtt_last_ms (+ v_0_rtt_sample_at_ms (* (- 1) v_0_rtt_start_ms)))))
 (let (($x1695 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1693 (not v_0_rtt_sample_used)))
 (or $x1693 (and $x1695 v_0_rtt_measured $x1697))))))
(assert
 (and (<= 0 v_0_rtt_sample_at_ms) (<= v_0_rtt_sample_at_ms now_0)))
(assert
 (let ((?x1704 (to_real v_0_rtt_last_ms)))
 (let ((?x1718 (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x1704))))
 (let ((?x1706 (+ v_0_rtt_previous_srtt (* (- 1.0) ?x1704))))
 (let ((?x1710 (ite (>= ?x1706 0.0) ?x1706 (+ (* (- 1.0) v_0_rtt_previous_srtt) ?x1704))))
 (let ((?x730 (/ 1.0 4.0)))
 (let ((?x1714 (ite v_0_rtt_previous_measured (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* ?x730 ?x1710)) (* (/ 1.0 2.0) ?x1704))))
 (let (($x1721 (and (= v_0_rttvar_ms ?x1714) (= v_0_srtt_ms (ite v_0_rtt_previous_measured ?x1718 ?x1704)))))
 (let (($x1693 (not v_0_rtt_sample_used)))
 (or $x1693 $x1721))))))))))
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
 (let (($x1857 (and (>= v_0_tx_elapsed v_0_tx_previous_rto) (<= 1 v_0_tx_emit_count) (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x1851 (not v_0_tx_retransmitted)))
 (or $x1851 $x1857))))
(assert
 (let (($x1851 (not v_0_tx_retransmitted)))
 (or $x1851 (not v_0_tx_waiting))))
(assert
 (and (<= 0 v_0_tx_syn_time) (<= v_0_tx_syn_time now_0)))
(assert
 (not v_0_tx_syn_pending))
(assert
 (or v_0_tx_syn_pending (= 0 v_0_tx_syn_time)))
(assert
 true)
(assert
 (= 155 choice_0))
(assert
 (= 4 state_0))
(assert
 (= 4 state_1))
(assert
 (or (not (<= 0 v_1_rx_fin_offset))))
(check-sat)
