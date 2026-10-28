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
 (let (($x1473 (= due_1_time_wait due_0_time_wait)))
 (let (($x1471 (= due_1_user due_0_user)))
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
 (let (($x1090 (and (not (and $x302 $x655 $x657 v_0_fin_sent (= ?x281 ?x656))) v_0_fin_sent)))
 (let ((?x786 (ite (<= 0 v_0_rtx_buf) v_0_rtx_buf 0)))
 (let ((?x784 (ite (<= v_0_rtx_buf ?x281) 0 (+ v_0_rtx_buf (* ?x268 ?x281)))))
 (let (($x658 (and $x302 $x655 $x657)))
 (let ((?x789 (ite $x658 (ite (<= ?x784 ?x786) ?x784 ?x786) v_0_rtx_buf)))
 (let ((?x1453 (+ ?x789 (ite $x1090 1 0))))
 (let (($x1455 (and $x302 $x655 $x657 (<= 1 ?x1453))))
 (let (($x1465 (= active_1_time_wait active_0_time_wait)))
 (let (($x1463 (= active_1_user active_0_user)))
 (let (($x1460 (or $x1455 (and (not (and $x302 $x655 $x657 (= 0 ?x1453))) active_0_rtx))))
 (let (($x1450 (not v_1_syn_timeout_eligible)))
 (let (($x1448 (not v_1_tx_syn_pending)))
 (let (($x1446 (= v_1_tx_syn_time 0)))
 (let (($x1444 (not v_1_tx_waiting)))
 (let (($x1442 (= v_1_tx_is_fin v_0_tx_is_fin)))
 (let (($x1439 (= v_1_tx_previous_rto v_0_tx_previous_rto)))
 (let (($x1436 (= v_1_tx_elapsed v_0_tx_elapsed)))
 (let (($x1433 (not v_1_tx_retransmitted)))
 (let (($x1431 (= v_1_tx_max_previous v_0_tx_max_previous)))
 (let (($x1428 (= v_1_tx_eligible v_0_tx_eligible)))
 (let (($x1425 (= v_1_tx_emit_count v_0_tx_emit_count)))
 (let (($x1175 (and $x302 $x655 $x657 (not (= 0 ?x281)))))
 (let (($x1170 (= 0 ?x789)))
 (let (($x1418 (= v_1_tx_time_15 (ite (or (>= 15 ?x789) $x1170 $x1175) 0 v_0_tx_time_15))))
 (let ((?x1412 (ite (or $x1170 (>= 14 ?x789)) 0 (ite $x1175 (ite (= 1 ?x281) v_0_tx_time_15 0) v_0_tx_time_14))))
 (let (($x1176 (= 1 ?x281)))
 (let ((?x1404 (ite $x1175 (ite $x1176 v_0_tx_time_14 (ite (= 2 ?x281) v_0_tx_time_15 0)) v_0_tx_time_13)))
 (let (($x1178 (= 2 ?x281)))
 (let ((?x1395 (ite $x1176 v_0_tx_time_13 (ite $x1178 v_0_tx_time_14 (ite (= 3 ?x281) v_0_tx_time_15 0)))))
 (let (($x1398 (= v_1_tx_time_12 (ite (or $x1170 (>= 12 ?x789)) 0 (ite $x1175 ?x1395 v_0_tx_time_12)))))
 (let (($x1180 (= 3 ?x281)))
 (let ((?x1385 (ite $x1178 v_0_tx_time_13 (ite $x1180 v_0_tx_time_14 (ite (= 4 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1388 (ite (or $x1170 (>= 11 ?x789)) 0 (ite $x1175 (ite $x1176 v_0_tx_time_12 ?x1385) v_0_tx_time_11))))
 (let (($x1182 (= 4 ?x281)))
 (let ((?x1374 (ite $x1180 v_0_tx_time_13 (ite $x1182 v_0_tx_time_14 (ite (= 5 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1377 (ite $x1175 (ite $x1176 v_0_tx_time_11 (ite $x1178 v_0_tx_time_12 ?x1374)) v_0_tx_time_10)))
 (let (($x1184 (= 5 ?x281)))
 (let ((?x1362 (ite $x1182 v_0_tx_time_13 (ite $x1184 v_0_tx_time_14 (ite (= 6 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1365 (ite $x1176 v_0_tx_time_10 (ite $x1178 v_0_tx_time_11 (ite $x1180 v_0_tx_time_12 ?x1362)))))
 (let (($x1368 (= v_1_tx_time_09 (ite (or (>= 9 ?x789) $x1170) 0 (ite $x1175 ?x1365 v_0_tx_time_09)))))
 (let (($x1186 (= 6 ?x281)))
 (let ((?x1349 (ite $x1184 v_0_tx_time_13 (ite $x1186 v_0_tx_time_14 (ite (= 7 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1352 (ite $x1178 v_0_tx_time_10 (ite $x1180 v_0_tx_time_11 (ite $x1182 v_0_tx_time_12 ?x1349)))))
 (let ((?x1355 (ite (or $x1170 (>= 8 ?x789)) 0 (ite $x1175 (ite $x1176 v_0_tx_time_09 ?x1352) v_0_tx_time_08))))
 (let (($x1188 (= 7 ?x281)))
 (let ((?x1335 (ite $x1186 v_0_tx_time_13 (ite $x1188 v_0_tx_time_14 (ite (= 8 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1338 (ite $x1180 v_0_tx_time_10 (ite $x1182 v_0_tx_time_11 (ite $x1184 v_0_tx_time_12 ?x1335)))))
 (let ((?x1341 (ite $x1175 (ite $x1176 v_0_tx_time_08 (ite $x1178 v_0_tx_time_09 ?x1338)) v_0_tx_time_07)))
 (let (($x1190 (= 8 ?x281)))
 (let ((?x1320 (ite $x1188 v_0_tx_time_13 (ite $x1190 v_0_tx_time_14 (ite (= 9 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1323 (ite $x1182 v_0_tx_time_10 (ite $x1184 v_0_tx_time_11 (ite $x1186 v_0_tx_time_12 ?x1320)))))
 (let ((?x1326 (ite $x1176 v_0_tx_time_07 (ite $x1178 v_0_tx_time_08 (ite $x1180 v_0_tx_time_09 ?x1323)))))
 (let (($x1329 (= v_1_tx_time_06 (ite (or $x1170 (>= 6 ?x789)) 0 (ite $x1175 ?x1326 v_0_tx_time_06)))))
 (let (($x1192 (= 9 ?x281)))
 (let ((?x1304 (ite $x1190 v_0_tx_time_13 (ite $x1192 v_0_tx_time_14 (ite (= 10 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1307 (ite $x1184 v_0_tx_time_10 (ite $x1186 v_0_tx_time_11 (ite $x1188 v_0_tx_time_12 ?x1304)))))
 (let ((?x1310 (ite $x1178 v_0_tx_time_07 (ite $x1180 v_0_tx_time_08 (ite $x1182 v_0_tx_time_09 ?x1307)))))
 (let ((?x1313 (ite (or $x1170 (>= 5 ?x789)) 0 (ite $x1175 (ite $x1176 v_0_tx_time_06 ?x1310) v_0_tx_time_05))))
 (let (($x1194 (= 10 ?x281)))
 (let ((?x1287 (ite $x1192 v_0_tx_time_13 (ite $x1194 v_0_tx_time_14 (ite (= 11 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1290 (ite $x1186 v_0_tx_time_10 (ite $x1188 v_0_tx_time_11 (ite $x1190 v_0_tx_time_12 ?x1287)))))
 (let ((?x1293 (ite $x1180 v_0_tx_time_07 (ite $x1182 v_0_tx_time_08 (ite $x1184 v_0_tx_time_09 ?x1290)))))
 (let ((?x1296 (ite $x1175 (ite $x1176 v_0_tx_time_05 (ite $x1178 v_0_tx_time_06 ?x1293)) v_0_tx_time_04)))
 (let (($x1196 (= 11 ?x281)))
 (let ((?x1269 (ite $x1194 v_0_tx_time_13 (ite $x1196 v_0_tx_time_14 (ite (= 12 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1272 (ite $x1188 v_0_tx_time_10 (ite $x1190 v_0_tx_time_11 (ite $x1192 v_0_tx_time_12 ?x1269)))))
 (let ((?x1275 (ite $x1182 v_0_tx_time_07 (ite $x1184 v_0_tx_time_08 (ite $x1186 v_0_tx_time_09 ?x1272)))))
 (let ((?x1278 (ite $x1176 v_0_tx_time_04 (ite $x1178 v_0_tx_time_05 (ite $x1180 v_0_tx_time_06 ?x1275)))))
 (let (($x1281 (= v_1_tx_time_03 (ite (or $x1170 (>= 3 ?x789)) 0 (ite $x1175 ?x1278 v_0_tx_time_03)))))
 (let (($x1198 (= 12 ?x281)))
 (let ((?x1250 (ite $x1196 v_0_tx_time_13 (ite $x1198 v_0_tx_time_14 (ite (= 13 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1253 (ite $x1190 v_0_tx_time_10 (ite $x1192 v_0_tx_time_11 (ite $x1194 v_0_tx_time_12 ?x1250)))))
 (let ((?x1256 (ite $x1184 v_0_tx_time_07 (ite $x1186 v_0_tx_time_08 (ite $x1188 v_0_tx_time_09 ?x1253)))))
 (let ((?x1259 (ite $x1178 v_0_tx_time_04 (ite $x1180 v_0_tx_time_05 (ite $x1182 v_0_tx_time_06 ?x1256)))))
 (let ((?x1262 (ite (or (>= 2 ?x789) $x1170) 0 (ite $x1175 (ite $x1176 v_0_tx_time_03 ?x1259) v_0_tx_time_02))))
 (let (($x1200 (= 13 ?x281)))
 (let ((?x1230 (ite $x1198 v_0_tx_time_13 (ite $x1200 v_0_tx_time_14 (ite (= 14 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1233 (ite $x1192 v_0_tx_time_10 (ite $x1194 v_0_tx_time_11 (ite $x1196 v_0_tx_time_12 ?x1230)))))
 (let ((?x1236 (ite $x1186 v_0_tx_time_07 (ite $x1188 v_0_tx_time_08 (ite $x1190 v_0_tx_time_09 ?x1233)))))
 (let ((?x1239 (ite $x1180 v_0_tx_time_04 (ite $x1182 v_0_tx_time_05 (ite $x1184 v_0_tx_time_06 ?x1236)))))
 (let ((?x1242 (ite $x1175 (ite $x1176 v_0_tx_time_02 (ite $x1178 v_0_tx_time_03 ?x1239)) v_0_tx_time_01)))
 (let (($x1202 (= 14 ?x281)))
 (let ((?x1208 (ite $x1200 v_0_tx_time_13 (ite $x1202 v_0_tx_time_14 (ite (= 15 ?x281) v_0_tx_time_15 0)))))
 (let ((?x1211 (ite $x1194 v_0_tx_time_10 (ite $x1196 v_0_tx_time_11 (ite $x1198 v_0_tx_time_12 ?x1208)))))
 (let ((?x1214 (ite $x1188 v_0_tx_time_07 (ite $x1190 v_0_tx_time_08 (ite $x1192 v_0_tx_time_09 ?x1211)))))
 (let ((?x1217 (ite $x1182 v_0_tx_time_04 (ite $x1184 v_0_tx_time_05 (ite $x1186 v_0_tx_time_06 ?x1214)))))
 (let ((?x1220 (ite $x1176 v_0_tx_time_01 (ite $x1178 v_0_tx_time_02 (ite $x1180 v_0_tx_time_03 ?x1217)))))
 (let (($x1224 (= v_1_tx_time_00 (ite (or $x1170 (>= 0 ?x789)) 0 (ite $x1175 ?x1220 v_0_tx_time_00)))))
 (let (($x1157 (= v_1_rtt_sample_was_ambiguous (and v_0_rtt_active v_0_rtt_ambiguous))))
 (let (($x1152 (not v_1_rtt_start_new)))
 (let ((?x782 (* ?x268 ?x281)))
 (let ((?x1144 (+ ?x699 ?x782)))
 (let (($x1147 (and v_0_rtt_active $x302 $x655 $x657 (not (<= v_0_rtt_remaining ?x1144)))))
 (let (($x1132 (and v_0_rtt_active $x302 $x655 $x657 $x700)))
 (let (($x1150 (= v_1_rtt_remaining (ite $x1132 0 (ite $x1147 ?x1144 v_0_rtt_remaining)))))
 (let (($x1141 (= v_1_rtt_end v_0_rtt_end)))
 (let (($x1140 (= v_1_rtt_start_ms v_0_rtt_start_ms)))
 (let (($x1130 (= v_1_rtt_previous_measured (ite $x703 v_0_rtt_measured v_0_rtt_previous_measured))))
 (let (($x1123 (= v_1_rtt_previous_var (ite $x703 v_0_rttvar_ms v_0_rtt_previous_var))))
 (let (($x1119 (= v_1_rtt_previous_srtt (ite $x703 v_0_srtt_ms v_0_rtt_previous_srtt))))
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
 (let (($x344 (= ?x343 0)))
 (let (($x347 (or $x344 $x346)))
 (let ((?x646 (ite $x347 0 ?x645)))
 (let ((?x649 (ite $x327 (+ ?x329 (* ?x268 ?x646)) ?x329)))
 (let (($x651 (and $x327 $x324 (= 0 ?x649))))
 (let ((?x1099 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data) 4294967296)))
 (let (($x1088 (and $x302 $x655 $x657 v_0_fin_sent (= ?x281 ?x656))))
 (let (($x1092 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x1085 (= v_1_fin_requested v_0_fin_requested)))
 (let ((?x803 (mod (+ input_0_net.fin_segment_seq (* ?x268 v_0_snd_wl1)) 4294967296)))
 (let (($x798 (<= 2147483648 (mod (+ input_0_net.fin_segment_ack (* ?x268 v_0_snd_wl2)) 4294967296))))
 (let (($x794 (= v_0_snd_wl1 input_0_net.fin_segment_seq)))
 (let (($x809 (or (and $x794 (not $x798)) (and (not (<= ?x803 0)) (not (<= 2147483648 ?x803))))))
 (let (($x810 (and $x302 $x657 $x809)))
 (let (($x1064 (= v_1_rx_slot_15 (ite (or $x651 (not (and (or $x346 $x344) (not $x629)))) 0 ?x626))))
 (let (($x879 (not $x629)))
 (let (($x682 (not $x347)))
 (let (($x848 (not $x386)))
 (let (($x846 (not $x406)))
 (let (($x844 (not $x426)))
 (let (($x842 (not $x446)))
 (let (($x840 (not $x466)))
 (let (($x838 (not $x486)))
 (let (($x836 (not $x504)))
 (let (($x834 (not $x522)))
 (let (($x832 (not $x540)))
 (let (($x830 (not $x558)))
 (let (($x828 (not $x576)))
 (let (($x826 (not $x594)))
 (let (($x824 (not $x612)))
 (let (($x823 (and false $x630)))
 (let (($x825 (and $x823 $x824)))
 (let (($x827 (and $x825 $x826)))
 (let (($x829 (and $x827 $x828)))
 (let (($x831 (and $x829 $x830)))
 (let (($x833 (and $x831 $x832)))
 (let (($x835 (and $x833 $x834)))
 (let (($x837 (and $x835 $x836)))
 (let (($x839 (and $x837 $x838)))
 (let (($x841 (and $x839 $x840)))
 (let (($x843 (and $x841 $x842)))
 (let (($x845 (and $x843 $x844)))
 (let (($x847 (and $x845 $x846)))
 (let (($x850 (or $x365 $x363 (and $x847 $x848))))
 (let ((?x676 (ite $x611 0 ?x608)))
 (let (($x822 (or $x346 $x344)))
 (let (($x1059 (= v_1_rx_slot_14 (ite $x651 0 (ite $x822 ?x676 (ite (and $x850 $x682 $x879) ?x626 0))))))
 (let (($x851 (and $x850 $x682)))
 (let ((?x1051 (ite $x851 ?x676 (ite (and (or $x847 $x386) (not $x366) $x682 $x879) ?x626 0))))
 (let ((?x675 (ite $x593 0 ?x590)))
 (let (($x853 (not $x366)))
 (let (($x852 (or $x847 $x386)))
 (let (($x854 (and $x852 $x853 $x682)))
 (let ((?x1044 (ite $x854 ?x676 (ite (and (or $x845 $x406) $x848 $x853 $x682 $x879) ?x626 0))))
 (let ((?x674 (ite $x575 0 ?x572)))
 (let (($x1048 (= v_1_rx_slot_12 (ite $x651 0 (ite $x822 ?x674 (ite $x851 ?x675 ?x1044))))))
 (let (($x855 (or $x845 $x406)))
 (let (($x856 (and $x855 $x848 $x853 $x682)))
 (let ((?x1036 (ite $x856 ?x676 (ite (and (or $x843 $x426) $x846 $x848 $x853 $x682 $x879) ?x626 0))))
 (let ((?x673 (ite $x557 0 ?x554)))
 (let (($x1041 (= v_1_rx_slot_11 (ite $x651 0 (ite $x822 ?x673 (ite $x851 ?x674 (ite $x854 ?x675 ?x1036)))))))
 (let (($x857 (or $x843 $x426)))
 (let (($x858 (and $x857 $x846 $x848 $x853 $x682)))
 (let ((?x1027 (ite $x858 ?x676 (ite (and (or $x841 $x446) $x844 $x846 $x848 $x853 $x682 $x879) ?x626 0))))
 (let ((?x672 (ite $x539 0 ?x536)))
 (let ((?x1032 (ite $x651 0 (ite $x822 ?x672 (ite $x851 ?x673 (ite $x854 ?x674 (ite $x856 ?x675 ?x1027)))))))
 (let ((?x1016 (ite (and (or $x839 $x466) $x842 $x844 $x846 $x848 $x853 $x682 $x879) ?x626 0)))
 (let (($x859 (or $x841 $x446)))
 (let (($x860 (and $x859 $x844 $x846 $x848 $x853 $x682)))
 (let ((?x1021 (ite $x851 ?x672 (ite $x854 ?x673 (ite $x856 ?x674 (ite $x858 ?x675 (ite $x860 ?x676 ?x1016)))))))
 (let ((?x671 (ite $x521 0 ?x518)))
 (let ((?x1005 (ite (and (or $x837 $x486) $x840 $x842 $x844 $x846 $x848 $x853 $x682 $x879) ?x626 0)))
 (let (($x861 (or $x839 $x466)))
 (let (($x862 (and $x861 $x842 $x844 $x846 $x848 $x853 $x682)))
 (let ((?x1010 (ite $x854 ?x672 (ite $x856 ?x673 (ite $x858 ?x674 (ite $x860 ?x675 (ite $x862 ?x676 ?x1005)))))))
 (let ((?x670 (ite $x503 0 ?x500)))
 (let (($x1014 (= v_1_rx_slot_08 (ite $x651 0 (ite $x822 ?x670 (ite $x851 ?x671 ?x1010))))))
 (let ((?x993 (ite (and (or $x835 $x504) $x838 $x840 $x842 $x844 $x846 $x848 $x853 $x682 $x879) ?x626 0)))
 (let (($x863 (or $x837 $x486)))
 (let (($x864 (and $x863 $x840 $x842 $x844 $x846 $x848 $x853 $x682)))
 (let ((?x998 (ite $x856 ?x672 (ite $x858 ?x673 (ite $x860 ?x674 (ite $x862 ?x675 (ite $x864 ?x676 ?x993)))))))
 (let ((?x669 (ite $x485 0 ?x482)))
 (let (($x1003 (= v_1_rx_slot_07 (ite $x651 0 (ite $x822 ?x669 (ite $x851 ?x670 (ite $x854 ?x671 ?x998)))))))
 (let (($x867 (or $x833 $x522)))
 (let ((?x980 (ite (and $x867 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x853 $x682 $x879) ?x626 0)))
 (let (($x865 (or $x835 $x504)))
 (let (($x866 (and $x865 $x838 $x840 $x842 $x844 $x846 $x848 $x853 $x682)))
 (let ((?x985 (ite $x858 ?x672 (ite $x860 ?x673 (ite $x862 ?x674 (ite $x864 ?x675 (ite $x866 ?x676 ?x980)))))))
 (let ((?x668 (ite $x465 0 ?x462)))
 (let ((?x990 (ite $x651 0 (ite $x822 ?x668 (ite $x851 ?x669 (ite $x854 ?x670 (ite $x856 ?x671 ?x985)))))))
 (let (($x869 (or $x831 $x540)))
 (let ((?x966 (ite (and $x869 $x834 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x853 $x682 $x879) ?x626 0)))
 (let (($x868 (and $x867 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x853 $x682)))
 (let ((?x971 (ite $x860 ?x672 (ite $x862 ?x673 (ite $x864 ?x674 (ite $x866 ?x675 (ite $x868 ?x676 ?x966)))))))
 (let ((?x667 (ite $x445 0 ?x442)))
 (let ((?x976 (ite $x822 ?x667 (ite $x851 ?x668 (ite $x854 ?x669 (ite $x856 ?x670 (ite $x858 ?x671 ?x971)))))))
 (let (($x871 (or $x829 $x558)))
 (let (($x950 (and $x871 $x832 $x834 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x853 $x682 $x879)))
 (let (($x870 (and $x869 $x834 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x853 $x682)))
 (let ((?x955 (ite $x864 ?x673 (ite $x866 ?x674 (ite $x868 ?x675 (ite $x870 ?x676 (ite $x950 ?x626 0)))))))
 (let ((?x960 (ite $x854 ?x668 (ite $x856 ?x669 (ite $x858 ?x670 (ite $x860 ?x671 (ite $x862 ?x672 ?x955)))))))
 (let ((?x666 (ite $x425 0 ?x422)))
 (let (($x964 (= v_1_rx_slot_04 (ite $x651 0 (ite $x822 ?x666 (ite $x851 ?x667 ?x960))))))
 (let (($x873 (or $x827 $x576)))
 (let (($x934 (and $x873 $x830 $x832 $x834 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x853 $x682 $x879)))
 (let (($x872 (and $x871 $x832 $x834 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x853 $x682)))
 (let ((?x939 (ite $x866 ?x673 (ite $x868 ?x674 (ite $x870 ?x675 (ite $x872 ?x676 (ite $x934 ?x626 0)))))))
 (let ((?x944 (ite $x856 ?x668 (ite $x858 ?x669 (ite $x860 ?x670 (ite $x862 ?x671 (ite $x864 ?x672 ?x939)))))))
 (let ((?x665 (ite $x405 0 ?x402)))
 (let (($x949 (= v_1_rx_slot_03 (ite $x651 0 (ite $x822 ?x665 (ite $x851 ?x666 (ite $x854 ?x667 ?x944)))))))
 (let (($x875 (or $x825 $x594)))
 (let (($x917 (and $x875 $x828 $x830 $x832 $x834 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x853 $x682 $x879)))
 (let (($x874 (and $x873 $x830 $x832 $x834 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x853 $x682)))
 (let ((?x922 (ite $x868 ?x673 (ite $x870 ?x674 (ite $x872 ?x675 (ite $x874 ?x676 (ite $x917 ?x626 0)))))))
 (let ((?x927 (ite $x858 ?x668 (ite $x860 ?x669 (ite $x862 ?x670 (ite $x864 ?x671 (ite $x866 ?x672 ?x922)))))))
 (let ((?x664 (ite $x385 0 ?x382)))
 (let ((?x932 (ite $x651 0 (ite $x822 ?x664 (ite $x851 ?x665 (ite $x854 ?x666 (ite $x856 ?x667 ?x927)))))))
 (let (($x877 (or $x823 $x612)))
 (let (($x899 (and $x877 $x826 $x828 $x830 $x832 $x834 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x853 $x682 $x879)))
 (let (($x876 (and $x875 $x828 $x830 $x832 $x834 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x853 $x682)))
 (let ((?x904 (ite $x870 ?x673 (ite $x872 ?x674 (ite $x874 ?x675 (ite $x876 ?x676 (ite $x899 ?x626 0)))))))
 (let ((?x909 (ite $x860 ?x668 (ite $x862 ?x669 (ite $x864 ?x670 (ite $x866 ?x671 (ite $x868 ?x672 ?x904)))))))
 (let ((?x663 (ite $x365 0 ?x362)))
 (let ((?x914 (ite $x822 ?x663 (ite $x851 ?x664 (ite $x854 ?x665 (ite $x856 ?x666 (ite $x858 ?x667 ?x909)))))))
 (let (($x880 (and $x630 $x824 $x826 $x828 $x830 $x832 $x834 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x853 $x682 $x879)))
 (let (($x878 (and $x877 $x826 $x828 $x830 $x832 $x834 $x836 $x838 $x840 $x842 $x844 $x846 $x848 $x853 $x682)))
 (let ((?x885 (ite $x872 ?x673 (ite $x874 ?x674 (ite $x876 ?x675 (ite $x878 ?x676 (ite $x880 ?x626 0)))))))
 (let ((?x890 (ite $x862 ?x668 (ite $x864 ?x669 (ite $x866 ?x670 (ite $x868 ?x671 (ite $x870 ?x672 ?x885)))))))
 (let ((?x895 (ite $x851 ?x663 (ite $x854 ?x664 (ite $x856 ?x665 (ite $x858 ?x666 (ite $x860 ?x667 ?x890)))))))
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
 (and (>= now_1 now_0) (<= 0 input_0_net.fin_segment_data) (>= 16 input_0_net.fin_segment_data) (not (= ?x271 2147483648)) (<= 0 input_0_net.fin_segment_window) (>= 65535 input_0_net.fin_segment_window) (or (and (not (= ?x281 2147483648)) (not $x287)) (not $x302)) (or (not active_0_rtx) (not (<= due_0_rtx now_1))) (or (not active_0_user) (not (<= due_0_user now_1))) (or (not active_0_time_wait) (not (<= due_0_time_wait now_1))) $x652 $x653 $x654 (= v_1_snd_una (ite $x658 input_0_net.fin_segment_ack v_0_snd_una)) $x661 $x690 $x691 $x692 $x695 (= v_1_rto_ms ?x761) $x765 $x768 $x771 $x774 (= v_1_local_window (+ 16 (* ?x268 v_0_rcv_buf) (* ?x268 ?x686))) $x780 (= v_1_rtx_buf ?x789) (= v_1_rcv_buf (+ v_0_rcv_buf ?x686)) (= v_1_snd_wnd (ite $x810 input_0_net.fin_segment_window v_0_snd_wnd)) (= v_1_snd_wl1 (ite $x810 input_0_net.fin_segment_seq v_0_snd_wl1)) (= v_1_snd_wl2 (ite $x810 input_0_net.fin_segment_ack v_0_snd_wl2)) $x820 (= v_1_rx_chunk ?x686) (= v_1_rx_slot_00 (ite $x651 0 (ite $x822 ?x662 ?x895))) (= v_1_rx_slot_01 (ite $x651 0 ?x914)) (= v_1_rx_slot_02 ?x932) $x949 $x964 (= v_1_rx_slot_05 (ite $x651 0 ?x976)) (= v_1_rx_slot_06 ?x990) $x1003 $x1014 (= v_1_rx_slot_09 (ite $x651 0 (ite $x822 ?x671 ?x1021))) (= v_1_rx_slot_10 ?x1032) $x1041 $x1048 (= v_1_rx_slot_13 (ite $x651 0 (ite $x822 ?x675 ?x1051))) $x1059 $x1064 (= v_1_rx_advance ?x646) (= v_1_rx_acceptable (and $x302 $x322 $x324)) (= v_1_seg_acceptable $x302) (= v_1_ack_delta ?x281) (= v_1_ack_is_new (and $x655 $x657)) (= v_1_ack_is_future $x321) (= v_1_ack_advance $x658) (= v_1_ack_window_update $x810) $x1085 (= v_1_fin_sent $x1090) $x1092 (= v_1_fin_acknowledged $x1088) (= v_1_rx_fin_pending (and $x327 $x652)) (= v_1_rx_fin_seq (ite $x326 ?x1099 v_0_rx_fin_seq)) (= v_1_rx_fin_offset (ite $x651 0 ?x649)) (= v_1_rx_fin_done (or v_0_rx_fin_done $x651)) (= v_1_rx_fin_consumed $x651) (= v_1_srtt_ms ?x723) (= v_1_rttvar_ms ?x746) (= v_1_rtt_error_ms ?x739) $x1119 $x1123 (= v_1_rtt_measured (or v_0_rtt_measured $x703)) $x1130 (= v_1_rtt_active (and v_0_rtt_active (not $x1132))) (= v_1_rtt_ambiguous (and (not $x1132) v_0_rtt_ambiguous)) $x1140 $x1141 $x1150 $x1152 (= v_1_rtt_sample_used $x703) $x1157 (= v_1_rtt_last_ms ?x718) (= v_1_rtt_samples (+ v_0_rtt_samples (ite $x703 1 0))) (= v_1_rto_base_ms (ite $x703 ?x759 v_0_rto_base_ms)) $x1224 (= v_1_tx_time_01 (ite (or $x1170 (>= 1 ?x789)) 0 ?x1242)) (= v_1_tx_time_02 ?x1262) $x1281 (= v_1_tx_time_04 (ite (or $x1170 (>= 4 ?x789)) 0 ?x1296)) (= v_1_tx_time_05 ?x1313) $x1329 (= v_1_tx_time_07 (ite (or $x1170 (>= 7 ?x789)) 0 ?x1341)) (= v_1_tx_time_08 ?x1355) $x1368 (= v_1_tx_time_10 (ite (or (>= 10 ?x789) $x1170) 0 ?x1377)) (= v_1_tx_time_11 ?x1388) $x1398 (= v_1_tx_time_13 (ite (or $x1170 (>= 13 ?x789)) 0 ?x1404)) (= v_1_tx_time_14 ?x1412) $x1418 (= v_1_tx_fin_time (ite $x1090 v_0_tx_fin_time 0)) $x1425 $x1428 $x1431 $x1433 $x1436 $x1439 $x1442 $x1444 $x1446 $x1448 $x1450 (= active_1_rtx $x1460) $x1463 $x1465 (= due_1_rtx (ite $x1455 (+ now_1 ?x761) due_0_rtx)) $x1471 $x1473)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
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
 (let ((?x1479 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1479)))
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
 (let (($x1489 (not (>= v_0_rcv_buf 16))))
 (or $x1489 $x330))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x348 (= 0 v_0_rx_slot_01)))
 (let (($x1493 (not (>= v_0_rcv_buf 15))))
 (or $x1493 $x348))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x367 (= 0 v_0_rx_slot_02)))
 (let (($x1497 (not (>= v_0_rcv_buf 14))))
 (or $x1497 $x367))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x387 (= 0 v_0_rx_slot_03)))
 (let (($x1501 (not (>= v_0_rcv_buf 13))))
 (or $x1501 $x387))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x407 (= 0 v_0_rx_slot_04)))
 (let (($x1505 (not (>= v_0_rcv_buf 12))))
 (or $x1505 $x407))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x427 (= 0 v_0_rx_slot_05)))
 (let (($x1509 (not (>= v_0_rcv_buf 11))))
 (or $x1509 $x427))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x447 (= 0 v_0_rx_slot_06)))
 (let (($x1513 (not (>= v_0_rcv_buf 10))))
 (or $x1513 $x447))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x467 (= 0 v_0_rx_slot_07)))
 (let (($x1517 (not (>= v_0_rcv_buf 9))))
 (or $x1517 $x467))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x487 (= 0 v_0_rx_slot_08)))
 (let (($x1521 (not (>= v_0_rcv_buf 8))))
 (or $x1521 $x487))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x505 (= 0 v_0_rx_slot_09)))
 (let (($x1525 (not (>= v_0_rcv_buf 7))))
 (or $x1525 $x505))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x523 (= 0 v_0_rx_slot_10)))
 (let (($x1529 (not (>= v_0_rcv_buf 6))))
 (or $x1529 $x523))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x541 (= 0 v_0_rx_slot_11)))
 (let (($x1533 (not (>= v_0_rcv_buf 5))))
 (or $x1533 $x541))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x559 (= 0 v_0_rx_slot_12)))
 (let (($x1537 (not (>= v_0_rcv_buf 4))))
 (or $x1537 $x559))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x577 (= 0 v_0_rx_slot_13)))
 (let (($x1541 (not (>= v_0_rcv_buf 3))))
 (or $x1541 $x577))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x595 (= 0 v_0_rx_slot_14)))
 (let (($x1545 (not (>= v_0_rcv_buf 2))))
 (or $x1545 $x595))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x613 (= 0 v_0_rx_slot_15)))
 (let (($x1549 (not (>= v_0_rcv_buf 1))))
 (or $x1549 $x613))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x1551 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x1551)))
(assert
 (and (<= 0 v_0_rx_advance) (>= 16 v_0_rx_advance)))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (and (<= 0 v_0_ack_delta) (>= 4294967295 v_0_ack_delta)))
(assert
 true)
(assert
 (let ((?x1564 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x1564)))
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
 (let (($x1570 (<= 1 v_0_rx_fin_offset)))
 (let (($x324 (not v_0_rx_fin_done)))
 (let (($x1572 (and $x324 $x1570 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window)))))
 (let (($x325 (not v_0_rx_fin_pending)))
 (or $x325 $x1572))))))
(assert
 (let (($x1575 (>= 15 v_0_rx_fin_offset)))
 (and (<= 0 v_0_rx_fin_offset) $x1575 (= v_0_rx_fin_pending (<= 1 v_0_rx_fin_offset)))))
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
 (let ((?x1663 (* 4.0 v_0_rttvar_ms)))
 (let ((?x706 (- 1.0)))
 (let ((?x735 (* ?x706 v_0_srtt_ms)))
 (let ((?x1666 (+ ?x735 (* ?x706 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x1663)))))
 (let ((?x1667 (to_int ?x1666)))
 (let ((?x268 (- 1)))
 (let ((?x1670 (ite (<= ?x1667 (- 1000)) (* ?x268 ?x1667) 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x1670) 60000 ?x1670) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x699 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x1685 (and (<= v_0_rtt_start_ms now_0) (<= 1 v_0_rtt_remaining) (>= 4 v_0_rtt_remaining) (>= ?x699 v_0_rtt_remaining) (<= ?x699 (mod (+ v_0_snd_nxt (* (- 1) v_0_snd_una)) 4294967296)))))
 (let (($x1677 (not v_0_rtt_active)))
 (or $x1677 $x1685)))))
(assert
 (or v_0_rtt_active (= 0 v_0_rtt_remaining)))
(assert
 true)
(assert
 (let (($x1692 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1695 (and $x1692 v_0_rtt_measured (= v_0_rtt_last_ms (+ now_0 (* (- 1) v_0_rtt_start_ms))))))
 (let (($x1690 (not v_0_rtt_sample_used)))
 (or $x1690 $x1695)))))
(assert
 (let ((?x1698 (to_real v_0_rtt_last_ms)))
 (let ((?x1712 (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x1698))))
 (let ((?x1700 (+ v_0_rtt_previous_srtt (* (- 1.0) ?x1698))))
 (let ((?x1704 (ite (>= ?x1700 0.0) ?x1700 (+ (* (- 1.0) v_0_rtt_previous_srtt) ?x1698))))
 (let ((?x730 (/ 1.0 4.0)))
 (let ((?x1708 (ite v_0_rtt_previous_measured (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* ?x730 ?x1704)) (* (/ 1.0 2.0) ?x1698))))
 (let (($x1715 (and (= v_0_rttvar_ms ?x1708) (= v_0_srtt_ms (ite v_0_rtt_previous_measured ?x1712 ?x1698)))))
 (let (($x1690 (not v_0_rtt_sample_used)))
 (or $x1690 $x1715))))))))))
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
 (let (($x1851 (and (>= v_0_tx_elapsed v_0_tx_previous_rto) (<= 1 v_0_tx_emit_count) (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x1845 (not v_0_tx_retransmitted)))
 (or $x1845 $x1851))))
(assert
 (let (($x1845 (not v_0_tx_retransmitted)))
 (or $x1845 (not v_0_tx_waiting))))
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
 (or (not (<= v_1_tx_fin_time now_1)) (not (<= 0 v_1_tx_emit_count)) (not (>= 4 v_1_tx_emit_count)) (not (<= 0 v_1_tx_eligible)) (not (>= 4 v_1_tx_eligible)) (not (<= 0 v_1_tx_elapsed)) (not (<= 0 v_1_tx_max_previous)) (not (<= v_1_tx_max_previous now_1))))
(check-sat)
