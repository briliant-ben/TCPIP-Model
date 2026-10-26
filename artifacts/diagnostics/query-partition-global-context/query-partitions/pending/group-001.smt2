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
 (let (($x188 (not active_0_rtx)))
 (or $x188 (>= due_0_rtx now_0))))
(assert
 (let (($x193 (not active_0_user)))
 (or $x193 (>= due_0_user now_0))))
(assert
 (let (($x198 (not active_0_time_wait)))
 (or $x198 (>= due_0_time_wait now_0))))
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
 (let ((?x630 (+ now_1 (* 2 v_0_msl_ms))))
 (let ((?x264 (ite v_0_fin_sent 1 0)))
 (let ((?x265 (+ v_0_rtx_buf ?x264)))
 (let ((?x269 (mod (+ input_0_net.fin_segment_ack (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x270 (= ?x269 ?x265)))
 (let (($x271 (<= ?x269 ?x265)))
 (let (($x272 (<= 1 ?x269)))
 (let ((?x266 (- 1)))
 (let ((?x274 (+ ?x266 v_0_local_window)))
 (let ((?x275 (* ?x266 v_0_rcv_nxt)))
 (let ((?x277 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data ?x275) 4294967296)))
 (let (($x278 (<= ?x277 ?x274)))
 (let (($x279 (<= 1 v_0_local_window)))
 (let (($x285 (or (and $x279 (<= (mod (+ input_0_net.fin_segment_seq ?x275) 4294967296) ?x274)) (and $x279 $x278))))
 (let (($x287 (not v_0_rx_fin_pending)))
 (let (($x289 (not v_0_rx_fin_done)))
 (let (($x294 (and (>= ?x269 (+ 1 v_0_rtx_buf ?x264)) (>= 2147483647 ?x269))))
 (let (($x295 (not $x294)))
 (let (($x296 (and $x285 $x295 $x289 $x287 $x279 $x278)))
 (let ((?x298 (ite $x296 ?x277 v_0_rx_fin_offset)))
 (let (($x299 (or v_0_rx_fin_pending $x296)))
 (let (($x302 (and $x299 (>= 15 ?x298))))
 (let ((?x305 (mod (+ 15 v_0_rcv_nxt (* ?x266 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x307 (+ input_0_net.fin_segment_data (* ?x266 ?x305))))
 (let (($x308 (<= input_0_net.fin_segment_data ?x305)))
 (let (($x309 (<= v_0_rcv_buf 0)))
 (let (($x310 (= 0 v_0_rx_slot_15)))
 (let (($x313 (and $x285 $x295 $x289 $x310 $x309 (<= ?x305 (+ ?x266 input_0_net.fin_segment_data)))))
 (let ((?x318 (ite $x313 (ite (or $x308 (<= ?x307 1)) (ite $x308 0 ?x307) 1) v_0_rx_slot_15)))
 (let (($x320 (or (= ?x318 0) $x302)))
 (let (($x323 (and $x299 (>= 14 ?x298))))
 (let ((?x325 (mod (+ 14 v_0_rcv_nxt (* ?x266 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x327 (+ input_0_net.fin_segment_data (* ?x266 ?x325))))
 (let (($x328 (<= input_0_net.fin_segment_data ?x325)))
 (let (($x329 (<= v_0_rcv_buf 1)))
 (let (($x330 (= 0 v_0_rx_slot_14)))
 (let (($x332 (and $x285 $x295 $x289 $x330 $x329 (<= ?x325 (+ ?x266 input_0_net.fin_segment_data)))))
 (let ((?x337 (ite $x332 (ite (or $x328 (<= ?x327 1)) (ite $x328 0 ?x327) 1) v_0_rx_slot_14)))
 (let (($x339 (or (= ?x337 0) $x323)))
 (let (($x342 (and $x299 (>= 13 ?x298))))
 (let ((?x344 (mod (+ 13 v_0_rcv_nxt (* ?x266 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x346 (+ input_0_net.fin_segment_data (* ?x266 ?x344))))
 (let (($x347 (<= input_0_net.fin_segment_data ?x344)))
 (let (($x349 (<= v_0_rcv_buf 2)))
 (let (($x350 (= 0 v_0_rx_slot_13)))
 (let (($x352 (and $x285 $x295 $x289 $x350 $x349 (<= ?x344 (+ ?x266 input_0_net.fin_segment_data)))))
 (let ((?x357 (ite $x352 (ite (or $x347 (<= ?x346 1)) (ite $x347 0 ?x346) 1) v_0_rx_slot_13)))
 (let (($x359 (or (= ?x357 0) $x342)))
 (let (($x362 (and $x299 (>= 12 ?x298))))
 (let ((?x364 (mod (+ 12 v_0_rcv_nxt (* ?x266 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x366 (+ input_0_net.fin_segment_data (* ?x266 ?x364))))
 (let (($x367 (<= input_0_net.fin_segment_data ?x364)))
 (let (($x369 (<= v_0_rcv_buf 3)))
 (let (($x370 (= 0 v_0_rx_slot_12)))
 (let (($x372 (and $x285 $x295 $x289 $x370 $x369 (<= ?x364 (+ ?x266 input_0_net.fin_segment_data)))))
 (let ((?x377 (ite $x372 (ite (or $x367 (<= ?x366 1)) (ite $x367 0 ?x366) 1) v_0_rx_slot_12)))
 (let (($x379 (or (= ?x377 0) $x362)))
 (let ((?x384 (ite $x379 12 (ite $x359 13 (ite $x339 14 (ite $x320 15 16))))))
 (let (($x387 (and $x299 (>= 11 ?x298))))
 (let ((?x389 (mod (+ 11 v_0_rcv_nxt (* ?x266 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x391 (+ input_0_net.fin_segment_data (* ?x266 ?x389))))
 (let (($x392 (<= input_0_net.fin_segment_data ?x389)))
 (let (($x394 (<= v_0_rcv_buf 4)))
 (let (($x395 (= 0 v_0_rx_slot_11)))
 (let (($x397 (and $x285 $x295 $x289 $x395 $x394 (<= ?x389 (+ ?x266 input_0_net.fin_segment_data)))))
 (let ((?x402 (ite $x397 (ite (or $x392 (<= ?x391 1)) (ite $x392 0 ?x391) 1) v_0_rx_slot_11)))
 (let (($x404 (or (= ?x402 0) $x387)))
 (let (($x407 (and $x299 (>= 10 ?x298))))
 (let ((?x409 (mod (+ 10 v_0_rcv_nxt (* ?x266 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x411 (+ input_0_net.fin_segment_data (* ?x266 ?x409))))
 (let (($x412 (<= input_0_net.fin_segment_data ?x409)))
 (let (($x414 (<= v_0_rcv_buf 5)))
 (let (($x415 (= 0 v_0_rx_slot_10)))
 (let (($x417 (and $x285 $x295 $x289 $x415 $x414 (<= ?x409 (+ ?x266 input_0_net.fin_segment_data)))))
 (let ((?x422 (ite $x417 (ite (or $x412 (<= ?x411 1)) (ite $x412 0 ?x411) 1) v_0_rx_slot_10)))
 (let (($x424 (or (= ?x422 0) $x407)))
 (let (($x427 (and $x299 (>= 9 ?x298))))
 (let ((?x429 (mod (+ 9 v_0_rcv_nxt (* ?x266 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x431 (+ input_0_net.fin_segment_data (* ?x266 ?x429))))
 (let (($x432 (<= input_0_net.fin_segment_data ?x429)))
 (let (($x434 (<= v_0_rcv_buf 6)))
 (let (($x435 (= 0 v_0_rx_slot_09)))
 (let (($x437 (and $x285 $x295 $x289 $x435 $x434 (<= ?x429 (+ ?x266 input_0_net.fin_segment_data)))))
 (let ((?x442 (ite $x437 (ite (or $x432 (<= ?x431 1)) (ite $x432 0 ?x431) 1) v_0_rx_slot_09)))
 (let (($x444 (or (= ?x442 0) $x427)))
 (let (($x447 (and $x299 (>= 8 ?x298))))
 (let ((?x449 (mod (+ 8 v_0_rcv_nxt (* ?x266 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x451 (+ input_0_net.fin_segment_data (* ?x266 ?x449))))
 (let (($x452 (<= input_0_net.fin_segment_data ?x449)))
 (let (($x454 (<= v_0_rcv_buf 7)))
 (let (($x455 (= 0 v_0_rx_slot_08)))
 (let (($x457 (and $x285 $x295 $x289 $x455 $x454 (<= ?x449 (+ ?x266 input_0_net.fin_segment_data)))))
 (let ((?x462 (ite $x457 (ite (or $x452 (<= ?x451 1)) (ite $x452 0 ?x451) 1) v_0_rx_slot_08)))
 (let (($x464 (or (= ?x462 0) $x447)))
 (let ((?x468 (ite $x464 8 (ite $x444 9 (ite $x424 10 (ite $x404 11 ?x384))))))
 (let (($x470 (and $x299 (>= 7 ?x298))))
 (let ((?x472 (mod (+ 7 v_0_rcv_nxt (* ?x266 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x474 (+ input_0_net.fin_segment_data (* ?x266 ?x472))))
 (let (($x475 (<= input_0_net.fin_segment_data ?x472)))
 (let (($x476 (<= v_0_rcv_buf 8)))
 (let (($x477 (= 0 v_0_rx_slot_07)))
 (let (($x479 (and $x285 $x295 $x289 $x477 $x476 (<= ?x472 (+ ?x266 input_0_net.fin_segment_data)))))
 (let ((?x484 (ite $x479 (ite (or $x475 (<= ?x474 1)) (ite $x475 0 ?x474) 1) v_0_rx_slot_07)))
 (let (($x486 (or (= ?x484 0) $x470)))
 (let (($x488 (and $x299 (>= 6 ?x298))))
 (let ((?x490 (mod (+ 6 v_0_rcv_nxt (* ?x266 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x492 (+ input_0_net.fin_segment_data (* ?x266 ?x490))))
 (let (($x493 (<= input_0_net.fin_segment_data ?x490)))
 (let (($x494 (<= v_0_rcv_buf 9)))
 (let (($x495 (= 0 v_0_rx_slot_06)))
 (let (($x497 (and $x285 $x295 $x289 $x495 $x494 (<= ?x490 (+ ?x266 input_0_net.fin_segment_data)))))
 (let ((?x502 (ite $x497 (ite (or $x493 (<= ?x492 1)) (ite $x493 0 ?x492) 1) v_0_rx_slot_06)))
 (let (($x504 (or (= ?x502 0) $x488)))
 (let (($x506 (and $x299 (>= 5 ?x298))))
 (let ((?x508 (mod (+ 5 v_0_rcv_nxt (* ?x266 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x510 (+ input_0_net.fin_segment_data (* ?x266 ?x508))))
 (let (($x511 (<= input_0_net.fin_segment_data ?x508)))
 (let (($x512 (<= v_0_rcv_buf 10)))
 (let (($x513 (= 0 v_0_rx_slot_05)))
 (let (($x515 (and $x285 $x295 $x289 $x513 $x512 (<= ?x508 (+ ?x266 input_0_net.fin_segment_data)))))
 (let ((?x520 (ite $x515 (ite (or $x511 (<= ?x510 1)) (ite $x511 0 ?x510) 1) v_0_rx_slot_05)))
 (let (($x522 (or (= ?x520 0) $x506)))
 (let (($x524 (and $x299 (>= 4 ?x298))))
 (let ((?x526 (mod (+ 4 v_0_rcv_nxt (* ?x266 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x528 (+ input_0_net.fin_segment_data (* ?x266 ?x526))))
 (let (($x529 (<= input_0_net.fin_segment_data ?x526)))
 (let (($x530 (<= v_0_rcv_buf 11)))
 (let (($x531 (= 0 v_0_rx_slot_04)))
 (let (($x533 (and $x285 $x295 $x289 $x531 $x530 (<= ?x526 (+ ?x266 input_0_net.fin_segment_data)))))
 (let ((?x538 (ite $x533 (ite (or $x529 (<= ?x528 1)) (ite $x529 0 ?x528) 1) v_0_rx_slot_04)))
 (let (($x540 (or (= ?x538 0) $x524)))
 (let ((?x544 (ite $x540 4 (ite $x522 5 (ite $x504 6 (ite $x486 7 ?x468))))))
 (let (($x546 (and $x299 (>= 3 ?x298))))
 (let ((?x548 (mod (+ 3 v_0_rcv_nxt (* ?x266 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x550 (+ input_0_net.fin_segment_data (* ?x266 ?x548))))
 (let (($x551 (<= input_0_net.fin_segment_data ?x548)))
 (let (($x552 (<= v_0_rcv_buf 12)))
 (let (($x553 (= 0 v_0_rx_slot_03)))
 (let (($x555 (and $x285 $x295 $x289 $x553 $x552 (<= ?x548 (+ ?x266 input_0_net.fin_segment_data)))))
 (let ((?x560 (ite $x555 (ite (or $x551 (<= ?x550 1)) (ite $x551 0 ?x550) 1) v_0_rx_slot_03)))
 (let (($x562 (or (= ?x560 0) $x546)))
 (let (($x564 (and $x299 (>= 2 ?x298))))
 (let ((?x566 (mod (+ 2 v_0_rcv_nxt (* ?x266 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x568 (+ input_0_net.fin_segment_data (* ?x266 ?x566))))
 (let (($x569 (<= input_0_net.fin_segment_data ?x566)))
 (let (($x570 (<= v_0_rcv_buf 13)))
 (let (($x571 (= 0 v_0_rx_slot_02)))
 (let (($x573 (and $x285 $x295 $x289 $x571 $x570 (<= ?x566 (+ ?x266 input_0_net.fin_segment_data)))))
 (let ((?x578 (ite $x573 (ite (or $x569 (<= ?x568 1)) (ite $x569 0 ?x568) 1) v_0_rx_slot_02)))
 (let (($x580 (or (= ?x578 0) $x564)))
 (let (($x582 (and $x299 (>= 1 ?x298))))
 (let ((?x584 (mod (+ 1 v_0_rcv_nxt (* ?x266 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x586 (+ input_0_net.fin_segment_data (* ?x266 ?x584))))
 (let (($x587 (<= input_0_net.fin_segment_data ?x584)))
 (let (($x588 (<= v_0_rcv_buf 14)))
 (let (($x589 (= 0 v_0_rx_slot_01)))
 (let (($x591 (and $x285 $x295 $x289 $x589 $x588 (<= ?x584 (+ ?x266 input_0_net.fin_segment_data)))))
 (let ((?x596 (ite $x591 (ite (or $x587 (<= ?x586 1)) (ite $x587 0 ?x586) 1) v_0_rx_slot_01)))
 (let (($x597 (= ?x596 0)))
 (let (($x598 (or $x597 $x582)))
 (let ((?x601 (ite $x598 1 (ite $x580 2 (ite $x562 3 ?x544)))))
 (let (($x603 (and $x299 (>= 0 ?x298))))
 (let ((?x605 (mod (+ v_0_rcv_nxt (* ?x266 input_0_net.fin_segment_seq)) 4294967296)))
 (let ((?x607 (+ input_0_net.fin_segment_data (* ?x266 ?x605))))
 (let (($x608 (<= input_0_net.fin_segment_data ?x605)))
 (let (($x609 (<= v_0_rcv_buf 15)))
 (let (($x610 (= 0 v_0_rx_slot_00)))
 (let (($x612 (and $x285 $x295 $x289 $x610 $x609 (<= ?x605 (+ ?x266 input_0_net.fin_segment_data)))))
 (let ((?x617 (ite $x612 (ite (or $x608 (<= ?x607 1)) (ite $x608 0 ?x607) 1) v_0_rx_slot_00)))
 (let (($x619 (or (= ?x617 0) $x603)))
 (let ((?x620 (ite $x619 0 ?x601)))
 (let ((?x623 (ite $x299 (+ ?x298 (* ?x266 ?x620)) ?x298)))
 (let (($x624 (= 0 ?x623)))
 (let (($x625 (and $x299 $x289 $x624 $x285 $x272 $x271 v_0_fin_sent $x270)))
 (let (($x634 (= due_1_user due_0_user)))
 (let (($x636 (not v_0_rtt_ambiguous)))
 (let ((?x638 (mod (+ v_0_rtt_end (* ?x266 v_0_snd_una)) 4294967296)))
 (let (($x639 (>= ?x269 ?x638)))
 (let (($x641 (and v_0_rtt_active $x285 $x272 $x271 $x639 $x636)))
 (let ((?x646 (ite $x641 (+ now_1 (* ?x266 v_0_rtt_start_ms)) v_0_rtt_last_ms)))
 (let ((?x647 (to_real ?x646)))
 (let ((?x670 (/ 1.0 2.0)))
 (let ((?x652 (+ v_0_srtt_ms (* (- 1.0) ?x647))))
 (let ((?x659 (ite $x641 (ite (>= ?x652 0.0) ?x652 (+ (* (- 1.0) v_0_srtt_ms) ?x647)) v_0_rtt_error_ms)))
 (let ((?x666 (/ 1.0 4.0)))
 (let ((?x672 (ite v_0_rtt_measured (+ (* (/ 3.0 4.0) v_0_rttvar_ms) (* ?x666 ?x659)) (* ?x670 ?x647))))
 (let ((?x673 (ite $x641 ?x672 v_0_rttvar_ms)))
 (let ((?x650 (- 1.0)))
 (let ((?x681 (ite v_0_rtt_measured (+ (* (/ 7.0 8.0) v_0_srtt_ms) (* (/ 1.0 8.0) ?x647)) ?x647)))
 (let ((?x682 (ite $x641 ?x681 v_0_srtt_ms)))
 (let ((?x688 (+ (* ?x650 ?x682) (* ?x650 (ite (<= ?x673 ?x666) 1.0 (* 4.0 ?x673))))))
 (let ((?x689 (to_int ?x688)))
 (let ((?x694 (ite (<= ?x689 (- 1000)) (* ?x266 ?x689) 1000)))
 (let ((?x697 (ite (<= 60000 ?x694) 60000 ?x694)))
 (let ((?x699 (ite $x641 ?x697 v_0_rto_ms)))
 (let (($x700 (and $x285 $x272 $x271 v_0_fin_sent $x270)))
 (let (($x701 (not $x700)))
 (let (($x702 (and $x701 v_0_fin_sent)))
 (let ((?x704 (ite (<= 0 v_0_rtx_buf) v_0_rtx_buf 0)))
 (let ((?x708 (ite (<= v_0_rtx_buf ?x269) 0 (+ v_0_rtx_buf (* ?x266 ?x269)))))
 (let (($x709 (and $x285 $x272 $x271)))
 (let ((?x712 (ite $x709 (ite (<= ?x708 ?x704) ?x708 ?x704) v_0_rtx_buf)))
 (let ((?x714 (+ ?x712 (ite $x702 1 0))))
 (let (($x715 (<= 1 ?x714)))
 (let (($x716 (and $x285 $x272 $x271 $x715)))
 (let (($x721 (or $x716 (and (not (and $x285 $x272 $x271 (= 0 ?x714))) active_0_rtx))))
 (let (($x722 (not $x625)))
 (let (($x724 (not v_1_tx_waiting)))
 (let (($x727 (= v_1_tx_is_fin v_0_tx_is_fin)))
 (let (($x730 (= v_1_tx_previous_rto v_0_tx_previous_rto)))
 (let (($x733 (= v_1_tx_elapsed v_0_tx_elapsed)))
 (let (($x735 (not v_1_tx_retransmitted)))
 (let (($x738 (= v_1_tx_max_previous v_0_tx_max_previous)))
 (let (($x741 (= v_1_tx_eligible v_0_tx_eligible)))
 (let (($x744 (= v_1_tx_emit_count v_0_tx_emit_count)))
 (let (($x747 (and $x285 $x272 $x271 (not (= 0 ?x269)))))
 (let (($x748 (= 0 ?x712)))
 (let (($x754 (= v_1_tx_time_15 (ite (or (>= 15 ?x712) $x748 $x747) 0 v_0_tx_time_15))))
 (let ((?x761 (ite (or $x748 (>= 14 ?x712)) 0 (ite $x747 (ite (= 1 ?x269) v_0_tx_time_15 0) v_0_tx_time_14))))
 (let (($x757 (= 1 ?x269)))
 (let ((?x766 (ite $x747 (ite $x757 v_0_tx_time_14 (ite (= 2 ?x269) v_0_tx_time_15 0)) v_0_tx_time_13)))
 (let (($x762 (= 2 ?x269)))
 (let ((?x770 (ite $x757 v_0_tx_time_13 (ite $x762 v_0_tx_time_14 (ite (= 3 ?x269) v_0_tx_time_15 0)))))
 (let (($x777 (= v_1_tx_time_12 (ite (or (>= 12 ?x712) $x748) 0 (ite $x747 ?x770 v_0_tx_time_12)))))
 (let (($x767 (= 3 ?x269)))
 (let ((?x781 (ite $x762 v_0_tx_time_13 (ite $x767 v_0_tx_time_14 (ite (= 4 ?x269) v_0_tx_time_15 0)))))
 (let ((?x787 (ite (or (>= 11 ?x712) $x748) 0 (ite $x747 (ite $x757 v_0_tx_time_12 ?x781) v_0_tx_time_11))))
 (let (($x778 (= 4 ?x269)))
 (let ((?x791 (ite $x767 v_0_tx_time_13 (ite $x778 v_0_tx_time_14 (ite (= 5 ?x269) v_0_tx_time_15 0)))))
 (let ((?x795 (ite $x747 (ite $x757 v_0_tx_time_11 (ite $x762 v_0_tx_time_12 ?x791)) v_0_tx_time_10)))
 (let (($x788 (= 5 ?x269)))
 (let ((?x799 (ite $x778 v_0_tx_time_13 (ite $x788 v_0_tx_time_14 (ite (= 6 ?x269) v_0_tx_time_15 0)))))
 (let ((?x802 (ite $x757 v_0_tx_time_10 (ite $x762 v_0_tx_time_11 (ite $x767 v_0_tx_time_12 ?x799)))))
 (let (($x809 (= v_1_tx_time_09 (ite (or (>= 9 ?x712) $x748) 0 (ite $x747 ?x802 v_0_tx_time_09)))))
 (let (($x796 (= 6 ?x269)))
 (let ((?x813 (ite $x788 v_0_tx_time_13 (ite $x796 v_0_tx_time_14 (ite (= 7 ?x269) v_0_tx_time_15 0)))))
 (let ((?x816 (ite $x762 v_0_tx_time_10 (ite $x767 v_0_tx_time_11 (ite $x778 v_0_tx_time_12 ?x813)))))
 (let ((?x822 (ite (or (>= 8 ?x712) $x748) 0 (ite $x747 (ite $x757 v_0_tx_time_09 ?x816) v_0_tx_time_08))))
 (let (($x810 (= 7 ?x269)))
 (let ((?x826 (ite $x796 v_0_tx_time_13 (ite $x810 v_0_tx_time_14 (ite (= 8 ?x269) v_0_tx_time_15 0)))))
 (let ((?x829 (ite $x767 v_0_tx_time_10 (ite $x778 v_0_tx_time_11 (ite $x788 v_0_tx_time_12 ?x826)))))
 (let ((?x833 (ite $x747 (ite $x757 v_0_tx_time_08 (ite $x762 v_0_tx_time_09 ?x829)) v_0_tx_time_07)))
 (let (($x823 (= 8 ?x269)))
 (let ((?x837 (ite $x810 v_0_tx_time_13 (ite $x823 v_0_tx_time_14 (ite (= 9 ?x269) v_0_tx_time_15 0)))))
 (let ((?x840 (ite $x778 v_0_tx_time_10 (ite $x788 v_0_tx_time_11 (ite $x796 v_0_tx_time_12 ?x837)))))
 (let ((?x843 (ite $x757 v_0_tx_time_07 (ite $x762 v_0_tx_time_08 (ite $x767 v_0_tx_time_09 ?x840)))))
 (let (($x850 (= v_1_tx_time_06 (ite (or (>= 6 ?x712) $x748) 0 (ite $x747 ?x843 v_0_tx_time_06)))))
 (let (($x834 (= 9 ?x269)))
 (let ((?x854 (ite $x823 v_0_tx_time_13 (ite $x834 v_0_tx_time_14 (ite (= 10 ?x269) v_0_tx_time_15 0)))))
 (let ((?x857 (ite $x788 v_0_tx_time_10 (ite $x796 v_0_tx_time_11 (ite $x810 v_0_tx_time_12 ?x854)))))
 (let ((?x860 (ite $x762 v_0_tx_time_07 (ite $x767 v_0_tx_time_08 (ite $x778 v_0_tx_time_09 ?x857)))))
 (let ((?x866 (ite (or (>= 5 ?x712) $x748) 0 (ite $x747 (ite $x757 v_0_tx_time_06 ?x860) v_0_tx_time_05))))
 (let (($x851 (= 10 ?x269)))
 (let ((?x870 (ite $x834 v_0_tx_time_13 (ite $x851 v_0_tx_time_14 (ite (= 11 ?x269) v_0_tx_time_15 0)))))
 (let ((?x873 (ite $x796 v_0_tx_time_10 (ite $x810 v_0_tx_time_11 (ite $x823 v_0_tx_time_12 ?x870)))))
 (let ((?x876 (ite $x767 v_0_tx_time_07 (ite $x778 v_0_tx_time_08 (ite $x788 v_0_tx_time_09 ?x873)))))
 (let ((?x880 (ite $x747 (ite $x757 v_0_tx_time_05 (ite $x762 v_0_tx_time_06 ?x876)) v_0_tx_time_04)))
 (let (($x867 (= 11 ?x269)))
 (let ((?x884 (ite $x851 v_0_tx_time_13 (ite $x867 v_0_tx_time_14 (ite (= 12 ?x269) v_0_tx_time_15 0)))))
 (let ((?x887 (ite $x810 v_0_tx_time_10 (ite $x823 v_0_tx_time_11 (ite $x834 v_0_tx_time_12 ?x884)))))
 (let ((?x890 (ite $x778 v_0_tx_time_07 (ite $x788 v_0_tx_time_08 (ite $x796 v_0_tx_time_09 ?x887)))))
 (let ((?x893 (ite $x757 v_0_tx_time_04 (ite $x762 v_0_tx_time_05 (ite $x767 v_0_tx_time_06 ?x890)))))
 (let (($x900 (= v_1_tx_time_03 (ite (or $x748 (>= 3 ?x712)) 0 (ite $x747 ?x893 v_0_tx_time_03)))))
 (let (($x881 (= 12 ?x269)))
 (let ((?x904 (ite $x867 v_0_tx_time_13 (ite $x881 v_0_tx_time_14 (ite (= 13 ?x269) v_0_tx_time_15 0)))))
 (let ((?x907 (ite $x823 v_0_tx_time_10 (ite $x834 v_0_tx_time_11 (ite $x851 v_0_tx_time_12 ?x904)))))
 (let ((?x910 (ite $x788 v_0_tx_time_07 (ite $x796 v_0_tx_time_08 (ite $x810 v_0_tx_time_09 ?x907)))))
 (let ((?x913 (ite $x762 v_0_tx_time_04 (ite $x767 v_0_tx_time_05 (ite $x778 v_0_tx_time_06 ?x910)))))
 (let ((?x919 (ite (or (>= 2 ?x712) $x748) 0 (ite $x747 (ite $x757 v_0_tx_time_03 ?x913) v_0_tx_time_02))))
 (let (($x901 (= 13 ?x269)))
 (let ((?x923 (ite $x881 v_0_tx_time_13 (ite $x901 v_0_tx_time_14 (ite (= 14 ?x269) v_0_tx_time_15 0)))))
 (let ((?x926 (ite $x834 v_0_tx_time_10 (ite $x851 v_0_tx_time_11 (ite $x867 v_0_tx_time_12 ?x923)))))
 (let ((?x929 (ite $x796 v_0_tx_time_07 (ite $x810 v_0_tx_time_08 (ite $x823 v_0_tx_time_09 ?x926)))))
 (let ((?x932 (ite $x767 v_0_tx_time_04 (ite $x778 v_0_tx_time_05 (ite $x788 v_0_tx_time_06 ?x929)))))
 (let ((?x936 (ite $x747 (ite $x757 v_0_tx_time_02 (ite $x762 v_0_tx_time_03 ?x932)) v_0_tx_time_01)))
 (let (($x920 (= 14 ?x269)))
 (let ((?x940 (ite $x901 v_0_tx_time_13 (ite $x920 v_0_tx_time_14 (ite (= 15 ?x269) v_0_tx_time_15 0)))))
 (let ((?x943 (ite $x851 v_0_tx_time_10 (ite $x867 v_0_tx_time_11 (ite $x881 v_0_tx_time_12 ?x940)))))
 (let ((?x946 (ite $x810 v_0_tx_time_07 (ite $x823 v_0_tx_time_08 (ite $x834 v_0_tx_time_09 ?x943)))))
 (let ((?x949 (ite $x778 v_0_tx_time_04 (ite $x788 v_0_tx_time_05 (ite $x796 v_0_tx_time_06 ?x946)))))
 (let ((?x952 (ite $x757 v_0_tx_time_01 (ite $x762 v_0_tx_time_02 (ite $x767 v_0_tx_time_03 ?x949)))))
 (let (($x959 (= v_1_tx_time_00 (ite (or (>= 0 ?x712) $x748) 0 (ite $x747 ?x952 v_0_tx_time_00)))))
 (let (($x962 (= v_1_rtt_sample_was_ambiguous (and v_0_rtt_active v_0_rtt_ambiguous))))
 (let (($x964 (not v_1_rtt_start_new)))
 (let ((?x706 (* ?x266 ?x269)))
 (let ((?x965 (+ ?x638 ?x706)))
 (let (($x969 (and v_0_rtt_active $x285 $x272 $x271 (not (<= v_0_rtt_remaining ?x965)))))
 (let (($x970 (and v_0_rtt_active $x285 $x272 $x271 $x639)))
 (let (($x974 (= v_1_rtt_remaining (ite $x970 0 (ite $x969 ?x965 v_0_rtt_remaining)))))
 (let (($x975 (= v_1_rtt_end v_0_rtt_end)))
 (let (($x977 (= v_1_rtt_start_ms v_0_rtt_start_ms)))
 (let (($x981 (= v_1_rtt_previous_measured (ite $x641 v_0_rtt_measured v_0_rtt_previous_measured))))
 (let (($x985 (= v_1_rtt_previous_var (ite $x641 v_0_rttvar_ms v_0_rtt_previous_var))))
 (let (($x989 (= v_1_rtt_previous_srtt (ite $x641 v_0_srtt_ms v_0_rtt_previous_srtt))))
 (let ((?x991 (mod (+ input_0_net.fin_segment_seq input_0_net.fin_segment_data) 4294967296)))
 (let (($x992 (= v_1_fin_seq v_0_fin_seq)))
 (let (($x995 (= v_1_fin_requested v_0_fin_requested)))
 (let (($x1000 (<= 2147483648 (mod (+ input_0_net.fin_segment_ack (* ?x266 v_0_snd_wl2)) 4294967296))))
 (let (($x1001 (= v_0_snd_wl1 input_0_net.fin_segment_seq)))
 (let ((?x1004 (mod (+ input_0_net.fin_segment_seq (* ?x266 v_0_snd_wl1)) 4294967296)))
 (let (($x1012 (or (and (not (<= ?x1004 0)) (not (<= 2147483648 ?x1004))) (and $x1001 (not $x1000)))))
 (let (($x1013 (and $x285 $x271 $x1012)))
 (let ((?x1019 (ite (or (not (and $x619 (not $x302))) (and $x299 $x289 $x624)) 0 ?x318)))
 (let (($x1014 (not $x302)))
 (let (($x1020 (not $x619)))
 (let (($x1021 (not $x580)))
 (let (($x1022 (not $x562)))
 (let (($x1023 (not $x540)))
 (let (($x1024 (not $x522)))
 (let (($x1025 (not $x504)))
 (let (($x1026 (not $x486)))
 (let (($x1027 (not $x464)))
 (let (($x1028 (not $x444)))
 (let (($x1029 (not $x424)))
 (let (($x1030 (not $x404)))
 (let (($x1031 (not $x379)))
 (let (($x1032 (not $x359)))
 (let (($x1033 (not $x339)))
 (let (($x1034 (and false $x320)))
 (let (($x1035 (and $x1034 $x1033)))
 (let (($x1036 (and $x1035 $x1032)))
 (let (($x1037 (and $x1036 $x1031)))
 (let (($x1038 (and $x1037 $x1030)))
 (let (($x1039 (and $x1038 $x1029)))
 (let (($x1040 (and $x1039 $x1028)))
 (let (($x1041 (and $x1040 $x1027)))
 (let (($x1042 (and $x1041 $x1026)))
 (let (($x1043 (and $x1042 $x1025)))
 (let (($x1044 (and $x1043 $x1024)))
 (let (($x1045 (and $x1044 $x1023)))
 (let (($x1046 (and $x1045 $x1022)))
 (let (($x1048 (or (and $x1046 $x1021) $x597 $x582)))
 (let ((?x1049 (ite $x323 0 ?x337)))
 (let (($x1017 (and $x299 $x289 $x624)))
 (let (($x1054 (= v_1_rx_slot_14 (ite $x1017 0 (ite $x619 ?x1049 (ite (and $x1048 $x1020 $x1014) ?x318 0))))))
 (let (($x1055 (and $x1048 $x1020)))
 (let ((?x1060 (ite $x1055 ?x1049 (ite (and (or $x1046 $x580) (not $x598) $x1020 $x1014) ?x318 0))))
 (let ((?x1061 (ite $x342 0 ?x357)))
 (let (($x1057 (not $x598)))
 (let (($x1056 (or $x1046 $x580)))
 (let (($x1062 (and $x1056 $x1057 $x1020)))
 (let ((?x1066 (ite $x1062 ?x1049 (ite (and (or $x1045 $x562) $x1021 $x1057 $x1020 $x1014) ?x318 0))))
 (let ((?x1067 (ite $x362 0 ?x377)))
 (let (($x1071 (= v_1_rx_slot_12 (ite $x1017 0 (ite $x619 ?x1067 (ite $x1055 ?x1061 ?x1066))))))
 (let (($x1063 (or $x1045 $x562)))
 (let (($x1072 (and $x1063 $x1021 $x1057 $x1020)))
 (let ((?x1076 (ite $x1072 ?x1049 (ite (and (or $x1044 $x540) $x1022 $x1021 $x1057 $x1020 $x1014) ?x318 0))))
 (let ((?x1077 (ite $x387 0 ?x402)))
 (let (($x1082 (= v_1_rx_slot_11 (ite $x1017 0 (ite $x619 ?x1077 (ite $x1055 ?x1067 (ite $x1062 ?x1061 ?x1076)))))))
 (let (($x1073 (or $x1044 $x540)))
 (let (($x1083 (and $x1073 $x1022 $x1021 $x1057 $x1020)))
 (let ((?x1087 (ite $x1083 ?x1049 (ite (and (or $x1043 $x522) $x1023 $x1022 $x1021 $x1057 $x1020 $x1014) ?x318 0))))
 (let ((?x1088 (ite $x407 0 ?x422)))
 (let ((?x1093 (ite $x1017 0 (ite $x619 ?x1088 (ite $x1055 ?x1077 (ite $x1062 ?x1067 (ite $x1072 ?x1061 ?x1087)))))))
 (let ((?x1096 (ite (and (or $x1042 $x504) $x1024 $x1023 $x1022 $x1021 $x1057 $x1020 $x1014) ?x318 0)))
 (let (($x1084 (or $x1043 $x522)))
 (let (($x1097 (and $x1084 $x1023 $x1022 $x1021 $x1057 $x1020)))
 (let ((?x1102 (ite $x1055 ?x1088 (ite $x1062 ?x1077 (ite $x1072 ?x1067 (ite $x1083 ?x1061 (ite $x1097 ?x1049 ?x1096)))))))
 (let ((?x1103 (ite $x427 0 ?x442)))
 (let ((?x1106 (ite (and (or $x1041 $x486) $x1025 $x1024 $x1023 $x1022 $x1021 $x1057 $x1020 $x1014) ?x318 0)))
 (let (($x1094 (or $x1042 $x504)))
 (let (($x1107 (and $x1094 $x1024 $x1023 $x1022 $x1021 $x1057 $x1020)))
 (let ((?x1112 (ite $x1062 ?x1088 (ite $x1072 ?x1077 (ite $x1083 ?x1067 (ite $x1097 ?x1061 (ite $x1107 ?x1049 ?x1106)))))))
 (let ((?x1113 (ite $x447 0 ?x462)))
 (let (($x1117 (= v_1_rx_slot_08 (ite $x1017 0 (ite $x619 ?x1113 (ite $x1055 ?x1103 ?x1112))))))
 (let ((?x1120 (ite (and (or $x1040 $x464) $x1026 $x1025 $x1024 $x1023 $x1022 $x1021 $x1057 $x1020 $x1014) ?x318 0)))
 (let (($x1104 (or $x1041 $x486)))
 (let (($x1121 (and $x1104 $x1025 $x1024 $x1023 $x1022 $x1021 $x1057 $x1020)))
 (let ((?x1126 (ite $x1072 ?x1088 (ite $x1083 ?x1077 (ite $x1097 ?x1067 (ite $x1107 ?x1061 (ite $x1121 ?x1049 ?x1120)))))))
 (let ((?x1127 (ite $x470 0 ?x484)))
 (let (($x1132 (= v_1_rx_slot_07 (ite $x1017 0 (ite $x619 ?x1127 (ite $x1055 ?x1113 (ite $x1062 ?x1103 ?x1126)))))))
 (let (($x1133 (or $x1039 $x444)))
 (let ((?x1135 (ite (and $x1133 $x1027 $x1026 $x1025 $x1024 $x1023 $x1022 $x1021 $x1057 $x1020 $x1014) ?x318 0)))
 (let (($x1118 (or $x1040 $x464)))
 (let (($x1136 (and $x1118 $x1026 $x1025 $x1024 $x1023 $x1022 $x1021 $x1057 $x1020)))
 (let ((?x1141 (ite $x1083 ?x1088 (ite $x1097 ?x1077 (ite $x1107 ?x1067 (ite $x1121 ?x1061 (ite $x1136 ?x1049 ?x1135)))))))
 (let ((?x1142 (ite $x488 0 ?x502)))
 (let ((?x1147 (ite $x1017 0 (ite $x619 ?x1142 (ite $x1055 ?x1127 (ite $x1062 ?x1113 (ite $x1072 ?x1103 ?x1141)))))))
 (let (($x1148 (or $x1038 $x424)))
 (let ((?x1150 (ite (and $x1148 $x1028 $x1027 $x1026 $x1025 $x1024 $x1023 $x1022 $x1021 $x1057 $x1020 $x1014) ?x318 0)))
 (let (($x1151 (and $x1133 $x1027 $x1026 $x1025 $x1024 $x1023 $x1022 $x1021 $x1057 $x1020)))
 (let ((?x1156 (ite $x1097 ?x1088 (ite $x1107 ?x1077 (ite $x1121 ?x1067 (ite $x1136 ?x1061 (ite $x1151 ?x1049 ?x1150)))))))
 (let ((?x1157 (ite $x506 0 ?x520)))
 (let ((?x1162 (ite $x619 ?x1157 (ite $x1055 ?x1142 (ite $x1062 ?x1127 (ite $x1072 ?x1113 (ite $x1083 ?x1103 ?x1156)))))))
 (let (($x1163 (or $x1037 $x404)))
 (let (($x1164 (and $x1163 $x1029 $x1028 $x1027 $x1026 $x1025 $x1024 $x1023 $x1022 $x1021 $x1057 $x1020 $x1014)))
 (let (($x1165 (and $x1148 $x1028 $x1027 $x1026 $x1025 $x1024 $x1023 $x1022 $x1021 $x1057 $x1020)))
 (let ((?x1170 (ite $x1121 ?x1077 (ite $x1136 ?x1067 (ite $x1151 ?x1061 (ite $x1165 ?x1049 (ite $x1164 ?x318 0)))))))
 (let ((?x1175 (ite $x1062 ?x1142 (ite $x1072 ?x1127 (ite $x1083 ?x1113 (ite $x1097 ?x1103 (ite $x1107 ?x1088 ?x1170)))))))
 (let ((?x1176 (ite $x524 0 ?x538)))
 (let (($x1180 (= v_1_rx_slot_04 (ite $x1017 0 (ite $x619 ?x1176 (ite $x1055 ?x1157 ?x1175))))))
 (let (($x1181 (or $x1036 $x379)))
 (let (($x1182 (and $x1181 $x1030 $x1029 $x1028 $x1027 $x1026 $x1025 $x1024 $x1023 $x1022 $x1021 $x1057 $x1020 $x1014)))
 (let (($x1183 (and $x1163 $x1029 $x1028 $x1027 $x1026 $x1025 $x1024 $x1023 $x1022 $x1021 $x1057 $x1020)))
 (let ((?x1188 (ite $x1136 ?x1077 (ite $x1151 ?x1067 (ite $x1165 ?x1061 (ite $x1183 ?x1049 (ite $x1182 ?x318 0)))))))
 (let ((?x1193 (ite $x1072 ?x1142 (ite $x1083 ?x1127 (ite $x1097 ?x1113 (ite $x1107 ?x1103 (ite $x1121 ?x1088 ?x1188)))))))
 (let ((?x1194 (ite $x546 0 ?x560)))
 (let (($x1199 (= v_1_rx_slot_03 (ite $x1017 0 (ite $x619 ?x1194 (ite $x1055 ?x1176 (ite $x1062 ?x1157 ?x1193)))))))
 (let (($x1200 (or $x1035 $x359)))
 (let (($x1201 (and $x1200 $x1031 $x1030 $x1029 $x1028 $x1027 $x1026 $x1025 $x1024 $x1023 $x1022 $x1021 $x1057 $x1020 $x1014)))
 (let (($x1202 (and $x1181 $x1030 $x1029 $x1028 $x1027 $x1026 $x1025 $x1024 $x1023 $x1022 $x1021 $x1057 $x1020)))
 (let ((?x1207 (ite $x1151 ?x1077 (ite $x1165 ?x1067 (ite $x1183 ?x1061 (ite $x1202 ?x1049 (ite $x1201 ?x318 0)))))))
 (let ((?x1212 (ite $x1083 ?x1142 (ite $x1097 ?x1127 (ite $x1107 ?x1113 (ite $x1121 ?x1103 (ite $x1136 ?x1088 ?x1207)))))))
 (let ((?x1213 (ite $x564 0 ?x578)))
 (let ((?x1218 (ite $x1017 0 (ite $x619 ?x1213 (ite $x1055 ?x1194 (ite $x1062 ?x1176 (ite $x1072 ?x1157 ?x1212)))))))
 (let (($x1219 (or $x1034 $x339)))
 (let (($x1220 (and $x1219 $x1032 $x1031 $x1030 $x1029 $x1028 $x1027 $x1026 $x1025 $x1024 $x1023 $x1022 $x1021 $x1057 $x1020 $x1014)))
 (let (($x1221 (and $x1200 $x1031 $x1030 $x1029 $x1028 $x1027 $x1026 $x1025 $x1024 $x1023 $x1022 $x1021 $x1057 $x1020)))
 (let ((?x1226 (ite $x1165 ?x1077 (ite $x1183 ?x1067 (ite $x1202 ?x1061 (ite $x1221 ?x1049 (ite $x1220 ?x318 0)))))))
 (let ((?x1231 (ite $x1097 ?x1142 (ite $x1107 ?x1127 (ite $x1121 ?x1113 (ite $x1136 ?x1103 (ite $x1151 ?x1088 ?x1226)))))))
 (let ((?x1232 (ite $x582 0 ?x596)))
 (let ((?x1237 (ite $x619 ?x1232 (ite $x1055 ?x1213 (ite $x1062 ?x1194 (ite $x1072 ?x1176 (ite $x1083 ?x1157 ?x1231)))))))
 (let (($x1238 (and $x320 $x1033 $x1032 $x1031 $x1030 $x1029 $x1028 $x1027 $x1026 $x1025 $x1024 $x1023 $x1022 $x1021 $x1057 $x1020 $x1014)))
 (let (($x1239 (and $x1219 $x1032 $x1031 $x1030 $x1029 $x1028 $x1027 $x1026 $x1025 $x1024 $x1023 $x1022 $x1021 $x1057 $x1020)))
 (let ((?x1244 (ite $x1183 ?x1077 (ite $x1202 ?x1067 (ite $x1221 ?x1061 (ite $x1239 ?x1049 (ite $x1238 ?x318 0)))))))
 (let ((?x1249 (ite $x1107 ?x1142 (ite $x1121 ?x1127 (ite $x1136 ?x1113 (ite $x1151 ?x1103 (ite $x1165 ?x1088 ?x1244)))))))
 (let ((?x1254 (ite $x1055 ?x1232 (ite $x1062 ?x1213 (ite $x1072 ?x1194 (ite $x1083 ?x1176 (ite $x1097 ?x1157 ?x1249)))))))
 (let ((?x1255 (ite $x603 0 ?x617)))
 (let ((?x1258 (ite (and (<= 0 ?x620) $x1020) ?x601 0)))
 (let ((?x1260 (+ ?x1255 ?x1232 ?x1213 ?x1194 ?x1176 ?x1157 ?x1142 ?x1127 ?x1113 ?x1103 ?x1088 ?x1077 ?x1067 ?x1061 ?x1049 (ite $x302 0 ?x318))))
 (let ((?x1262 (ite (<= ?x1260 0) 0 ?x1260)))
 (let ((?x1264 (ite (<= ?x1262 ?x1258) ?x1262 ?x1258)))
 (let (($x1267 (= v_1_take v_0_take)))
 (let (($x1268 (= v_1_snd_buf v_0_snd_buf)))
 (let (($x1275 (= v_1_msl_ms v_0_msl_ms)))
 (let (($x1278 (= v_1_user_timeout_ms v_0_user_timeout_ms)))
 (let (($x1281 (= v_1_active_open v_0_active_open)))
 (let (($x1284 (= v_1_retries v_0_retries)))
 (let (($x1287 (= v_1_tx_flags v_0_tx_flags)))
 (let (($x1288 (= v_1_tx_ack v_0_tx_ack)))
 (let (($x1289 (= v_1_tx_seq v_0_tx_seq)))
 (let (($x1293 (= v_1_rcv_nxt (mod (+ v_0_rcv_nxt ?x1264 (ite $x1017 1 0)) 4294967296))))
 (let (($x1294 (= v_1_snd_nxt v_0_snd_nxt)))
 (let (($x1295 (= v_1_irs v_0_irs)))
 (let (($x1296 (= v_1_iss v_0_iss)))
 (let (($x1297 (not $x1017)))
 (let (($x198 (not active_0_time_wait)))
 (let (($x1300 (or $x198 (not (<= due_0_time_wait now_1)))))
 (let (($x193 (not active_0_user)))
 (let (($x1303 (or $x193 (not (<= due_0_user now_1)))))
 (let (($x188 (not active_0_rtx)))
 (let (($x1306 (or $x188 (not (<= due_0_rtx now_1)))))
 (let (($x745 (= 0 ?x269)))
 (let (($x1307 (not v_0_fin_sent)))
 (let (($x1311 (= (mod (+ input_0_net.fin_segment_ack (* ?x266 v_0_snd_nxt)) 4294967296) 2147483648)))
 (let (($x1317 (or (and (not (= ?x269 2147483648)) (not $x1311)) (not $x285))))
 (let (($x1320 (>= 65535 input_0_net.fin_segment_window)))
 (let (($x1321 (<= 0 input_0_net.fin_segment_window)))
 (let (($x1323 (not (= ?x605 2147483648))))
 (let (($x1324 (>= 16 input_0_net.fin_segment_data)))
 (let (($x1325 (<= 0 input_0_net.fin_segment_data)))
 (let (($x1326 (>= now_1 now_0)))
 (and $x1326 $x1325 $x1324 $x1323 $x1321 $x1320 $x1317 $x1307 $x745 $x1306 $x1303 $x1300 $x701 $x1297 $x722 $x1296 $x1295 (= v_1_snd_una (ite $x709 input_0_net.fin_segment_ack v_0_snd_una)) $x1294 $x1293 $x1289 $x1288 $x1287 (= v_1_rto_ms ?x699) $x1284 $x1281 $x1278 $x1275 (= v_1_local_window (+ 16 (* ?x266 v_0_rcv_buf) (* ?x266 ?x1264))) $x1268 (= v_1_rtx_buf ?x712) (= v_1_rcv_buf (+ v_0_rcv_buf ?x1264)) (= v_1_snd_wnd (ite $x1013 input_0_net.fin_segment_window v_0_snd_wnd)) (= v_1_snd_wl1 (ite $x1013 input_0_net.fin_segment_seq v_0_snd_wl1)) (= v_1_snd_wl2 (ite $x1013 input_0_net.fin_segment_ack v_0_snd_wl2)) $x1267 (= v_1_rx_chunk ?x1264) (= v_1_rx_slot_00 (ite $x1017 0 (ite $x619 ?x1255 ?x1254))) (= v_1_rx_slot_01 (ite $x1017 0 ?x1237)) (= v_1_rx_slot_02 ?x1218) $x1199 $x1180 (= v_1_rx_slot_05 (ite $x1017 0 ?x1162)) (= v_1_rx_slot_06 ?x1147) $x1132 $x1117 (= v_1_rx_slot_09 (ite $x1017 0 (ite $x619 ?x1103 ?x1102))) (= v_1_rx_slot_10 ?x1093) $x1082 $x1071 (= v_1_rx_slot_13 (ite $x1017 0 (ite $x619 ?x1061 ?x1060))) $x1054 (= v_1_rx_slot_15 ?x1019) (= v_1_rx_advance ?x620) (= v_1_rx_acceptable (and $x285 $x295 $x289)) (= v_1_seg_acceptable $x285) (= v_1_ack_delta ?x269) (= v_1_ack_is_new (and $x272 $x271)) (= v_1_ack_is_future $x294) (= v_1_ack_advance $x709) (= v_1_ack_window_update $x1013) $x995 (= v_1_fin_sent $x702) $x992 (= v_1_fin_acknowledged $x700) (= v_1_rx_fin_pending (and $x299 $x1297)) (= v_1_rx_fin_seq (ite $x296 ?x991 v_0_rx_fin_seq)) (= v_1_rx_fin_offset (ite $x1017 0 ?x623)) (= v_1_rx_fin_done (or v_0_rx_fin_done $x1017)) (= v_1_rx_fin_consumed $x1017) (= v_1_srtt_ms ?x682) (= v_1_rttvar_ms ?x673) (= v_1_rtt_error_ms ?x659) $x989 $x985 (= v_1_rtt_measured (or v_0_rtt_measured $x641)) $x981 (= v_1_rtt_active (and v_0_rtt_active (not $x970))) (= v_1_rtt_ambiguous (and (not $x970) v_0_rtt_ambiguous)) $x977 $x975 $x974 $x964 (= v_1_rtt_sample_used $x641) $x962 (= v_1_rtt_last_ms ?x646) (= v_1_rtt_samples (+ v_0_rtt_samples (ite $x641 1 0))) (= v_1_rto_base_ms (ite $x641 ?x697 v_0_rto_base_ms)) $x959 (= v_1_tx_time_01 (ite (or (>= 1 ?x712) $x748) 0 ?x936)) (= v_1_tx_time_02 ?x919) $x900 (= v_1_tx_time_04 (ite (or $x748 (>= 4 ?x712)) 0 ?x880)) (= v_1_tx_time_05 ?x866) $x850 (= v_1_tx_time_07 (ite (or (>= 7 ?x712) $x748) 0 ?x833)) (= v_1_tx_time_08 ?x822) $x809 (= v_1_tx_time_10 (ite (or $x748 (>= 10 ?x712)) 0 ?x795)) (= v_1_tx_time_11 ?x787) $x777 (= v_1_tx_time_13 (ite (or $x748 (>= 13 ?x712)) 0 ?x766)) (= v_1_tx_time_14 ?x761) $x754 (= v_1_tx_fin_time (ite $x702 v_0_tx_fin_time 0)) $x744 $x741 $x738 $x735 $x733 $x730 $x727 $x724 (= active_1_rtx (and $x722 $x721)) (= active_1_user (and $x722 active_0_user)) (= active_1_time_wait (or active_0_time_wait $x625)) (= due_1_rtx (ite $x716 (+ now_1 ?x699) due_0_rtx)) $x634 (= due_1_time_wait (ite $x625 ?x630 due_0_time_wait))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
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
 (let ((?x1481 (+ v_0_snd_buf v_0_rtx_buf)))
 (>= 16 ?x1481)))
(assert
 (>= 16 v_0_rcv_buf))
(assert
 (and (<= 0 v_0_snd_wnd) (>= 65535 v_0_snd_wnd)))
(assert
 (= v_0_local_window (+ 16 (* (- 1) v_0_rcv_buf))))
(assert
 (>= 1 v_0_rx_slot_00))
(assert
 (let (($x610 (= 0 v_0_rx_slot_00)))
 (let (($x1491 (not (>= v_0_rcv_buf 16))))
 (or $x1491 $x610))))
(assert
 (>= 1 v_0_rx_slot_01))
(assert
 (let (($x589 (= 0 v_0_rx_slot_01)))
 (let (($x1495 (not (>= v_0_rcv_buf 15))))
 (or $x1495 $x589))))
(assert
 (>= 1 v_0_rx_slot_02))
(assert
 (let (($x571 (= 0 v_0_rx_slot_02)))
 (let (($x1499 (not (>= v_0_rcv_buf 14))))
 (or $x1499 $x571))))
(assert
 (>= 1 v_0_rx_slot_03))
(assert
 (let (($x553 (= 0 v_0_rx_slot_03)))
 (let (($x1503 (not (>= v_0_rcv_buf 13))))
 (or $x1503 $x553))))
(assert
 (>= 1 v_0_rx_slot_04))
(assert
 (let (($x531 (= 0 v_0_rx_slot_04)))
 (let (($x1507 (not (>= v_0_rcv_buf 12))))
 (or $x1507 $x531))))
(assert
 (>= 1 v_0_rx_slot_05))
(assert
 (let (($x513 (= 0 v_0_rx_slot_05)))
 (let (($x1511 (not (>= v_0_rcv_buf 11))))
 (or $x1511 $x513))))
(assert
 (>= 1 v_0_rx_slot_06))
(assert
 (let (($x495 (= 0 v_0_rx_slot_06)))
 (let (($x1515 (not (>= v_0_rcv_buf 10))))
 (or $x1515 $x495))))
(assert
 (>= 1 v_0_rx_slot_07))
(assert
 (let (($x477 (= 0 v_0_rx_slot_07)))
 (let (($x1519 (not (>= v_0_rcv_buf 9))))
 (or $x1519 $x477))))
(assert
 (>= 1 v_0_rx_slot_08))
(assert
 (let (($x455 (= 0 v_0_rx_slot_08)))
 (let (($x1523 (not (>= v_0_rcv_buf 8))))
 (or $x1523 $x455))))
(assert
 (>= 1 v_0_rx_slot_09))
(assert
 (let (($x435 (= 0 v_0_rx_slot_09)))
 (let (($x1527 (not (>= v_0_rcv_buf 7))))
 (or $x1527 $x435))))
(assert
 (>= 1 v_0_rx_slot_10))
(assert
 (let (($x415 (= 0 v_0_rx_slot_10)))
 (let (($x1531 (not (>= v_0_rcv_buf 6))))
 (or $x1531 $x415))))
(assert
 (>= 1 v_0_rx_slot_11))
(assert
 (let (($x395 (= 0 v_0_rx_slot_11)))
 (let (($x1535 (not (>= v_0_rcv_buf 5))))
 (or $x1535 $x395))))
(assert
 (>= 1 v_0_rx_slot_12))
(assert
 (let (($x370 (= 0 v_0_rx_slot_12)))
 (let (($x1539 (not (>= v_0_rcv_buf 4))))
 (or $x1539 $x370))))
(assert
 (>= 1 v_0_rx_slot_13))
(assert
 (let (($x350 (= 0 v_0_rx_slot_13)))
 (let (($x1543 (not (>= v_0_rcv_buf 3))))
 (or $x1543 $x350))))
(assert
 (>= 1 v_0_rx_slot_14))
(assert
 (let (($x330 (= 0 v_0_rx_slot_14)))
 (let (($x1547 (not (>= v_0_rcv_buf 2))))
 (or $x1547 $x330))))
(assert
 (>= 1 v_0_rx_slot_15))
(assert
 (let (($x310 (= 0 v_0_rx_slot_15)))
 (let (($x1551 (not (>= v_0_rcv_buf 1))))
 (or $x1551 $x310))))
(assert
 (= 0 v_0_rx_slot_00))
(assert
 (let ((?x1553 (+ v_0_rcv_buf v_0_rx_slot_00 v_0_rx_slot_01 v_0_rx_slot_02 v_0_rx_slot_03 v_0_rx_slot_04 v_0_rx_slot_05 v_0_rx_slot_06 v_0_rx_slot_07 v_0_rx_slot_08 v_0_rx_slot_09 v_0_rx_slot_10 v_0_rx_slot_11 v_0_rx_slot_12 v_0_rx_slot_13 v_0_rx_slot_14 v_0_rx_slot_15)))
 (>= 16 ?x1553)))
(assert
 (and (<= 0 v_0_rx_advance) (>= 16 v_0_rx_advance)))
(assert
 (= v_0_rx_chunk v_0_rx_advance))
(assert
 (and (<= 0 v_0_ack_delta) (>= 4294967295 v_0_ack_delta)))
(assert
 true)
(assert
 (let ((?x1566 (mod (+ v_0_snd_una v_0_rtx_buf (ite v_0_fin_sent 1 0)) 4294967296)))
 (= v_0_snd_nxt ?x1566)))
(assert
 (= active_0_rtx (<= 1 (+ v_0_rtx_buf (ite v_0_fin_sent 1 0)))))
(assert
 (let (($x1574 (and v_0_fin_requested (= v_0_fin_seq (mod (+ v_0_snd_una v_0_rtx_buf) 4294967296)) (= 0 v_0_snd_buf))))
 (let (($x1307 (not v_0_fin_sent)))
 (or $x1307 $x1574))))
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
 (let (($x1576 (<= 1 v_0_rx_fin_offset)))
 (let (($x289 (not v_0_rx_fin_done)))
 (let (($x1578 (and $x289 $x1576 (<= v_0_rx_fin_offset (+ (- 1) v_0_local_window)))))
 (let (($x287 (not v_0_rx_fin_pending)))
 (or $x287 $x1578))))))
(assert
 (let (($x1581 (>= 15 v_0_rx_fin_offset)))
 (and (<= 0 v_0_rx_fin_offset) $x1581 (= v_0_rx_fin_pending (<= 1 v_0_rx_fin_offset)))))
(assert
 (let (($x287 (not v_0_rx_fin_pending)))
 (or $x287 (= v_0_rx_fin_seq (mod (+ v_0_rcv_nxt v_0_rx_fin_offset) 4294967296)))))
(assert
 (let (($x289 (not v_0_rx_fin_done)))
 (or $x289 (= v_0_rcv_nxt (mod (+ 1 v_0_rx_fin_seq) 4294967296)))))
(assert
 (let (($x610 (= 0 v_0_rx_slot_00)))
 (or (not (and v_0_rx_fin_pending (>= 0 v_0_rx_fin_offset))) $x610)))
(assert
 (let (($x589 (= 0 v_0_rx_slot_01)))
 (or (not (and v_0_rx_fin_pending (>= 1 v_0_rx_fin_offset))) $x589)))
(assert
 (let (($x571 (= 0 v_0_rx_slot_02)))
 (or (not (and v_0_rx_fin_pending (>= 2 v_0_rx_fin_offset))) $x571)))
(assert
 (let (($x553 (= 0 v_0_rx_slot_03)))
 (or (not (and v_0_rx_fin_pending (>= 3 v_0_rx_fin_offset))) $x553)))
(assert
 (let (($x531 (= 0 v_0_rx_slot_04)))
 (or (not (and v_0_rx_fin_pending (>= 4 v_0_rx_fin_offset))) $x531)))
(assert
 (let (($x513 (= 0 v_0_rx_slot_05)))
 (or (not (and v_0_rx_fin_pending (>= 5 v_0_rx_fin_offset))) $x513)))
(assert
 (let (($x495 (= 0 v_0_rx_slot_06)))
 (or (not (and v_0_rx_fin_pending (>= 6 v_0_rx_fin_offset))) $x495)))
(assert
 (let (($x477 (= 0 v_0_rx_slot_07)))
 (or (not (and v_0_rx_fin_pending (>= 7 v_0_rx_fin_offset))) $x477)))
(assert
 (let (($x455 (= 0 v_0_rx_slot_08)))
 (or (not (and v_0_rx_fin_pending (>= 8 v_0_rx_fin_offset))) $x455)))
(assert
 (let (($x435 (= 0 v_0_rx_slot_09)))
 (or (not (and v_0_rx_fin_pending (>= 9 v_0_rx_fin_offset))) $x435)))
(assert
 (let (($x415 (= 0 v_0_rx_slot_10)))
 (or (not (and v_0_rx_fin_pending (>= 10 v_0_rx_fin_offset))) $x415)))
(assert
 (let (($x395 (= 0 v_0_rx_slot_11)))
 (or (not (and v_0_rx_fin_pending (>= 11 v_0_rx_fin_offset))) $x395)))
(assert
 (let (($x370 (= 0 v_0_rx_slot_12)))
 (or (not (and v_0_rx_fin_pending (>= 12 v_0_rx_fin_offset))) $x370)))
(assert
 (let (($x350 (= 0 v_0_rx_slot_13)))
 (or (not (and v_0_rx_fin_pending (>= 13 v_0_rx_fin_offset))) $x350)))
(assert
 (let (($x330 (= 0 v_0_rx_slot_14)))
 (or (not (and v_0_rx_fin_pending (>= 14 v_0_rx_fin_offset))) $x330)))
(assert
 (let (($x310 (= 0 v_0_rx_slot_15)))
 (or (not (and v_0_rx_fin_pending (>= 15 v_0_rx_fin_offset))) $x310)))
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
 (let ((?x1668 (* 4.0 v_0_rttvar_ms)))
 (let ((?x650 (- 1.0)))
 (let ((?x655 (* ?x650 v_0_srtt_ms)))
 (let ((?x1672 (+ ?x655 (* ?x650 (ite (<= v_0_rttvar_ms (/ 1.0 4.0)) 1.0 ?x1668)))))
 (let ((?x1673 (to_int ?x1672)))
 (let ((?x266 (- 1)))
 (let ((?x1676 (ite (<= ?x1673 (- 1000)) (* ?x266 ?x1673) 1000)))
 (= v_0_rto_base_ms (ite v_0_rtt_measured (ite (<= 60000 ?x1676) 60000 ?x1676) 1000))))))))))
(assert
 (= v_0_rtt_measured (<= 1 v_0_rtt_samples)))
(assert
 (let ((?x638 (mod (+ v_0_rtt_end (* (- 1) v_0_snd_una)) 4294967296)))
 (let (($x1690 (and (<= v_0_rtt_start_ms now_0) (<= 1 v_0_rtt_remaining) (>= 4 v_0_rtt_remaining) (>= ?x638 v_0_rtt_remaining) (<= ?x638 (mod (+ v_0_snd_nxt (* (- 1) v_0_snd_una)) 4294967296)))))
 (let (($x1691 (not v_0_rtt_active)))
 (or $x1691 $x1690)))))
(assert
 (or v_0_rtt_active (= 0 v_0_rtt_remaining)))
(assert
 true)
(assert
 (let (($x1696 (not v_0_rtt_sample_was_ambiguous)))
 (let (($x1699 (and $x1696 v_0_rtt_measured (= v_0_rtt_last_ms (+ now_0 (* (- 1) v_0_rtt_start_ms))))))
 (let (($x1701 (not v_0_rtt_sample_used)))
 (or $x1701 $x1699)))))
(assert
 (let ((?x1703 (to_real v_0_rtt_last_ms)))
 (let ((?x1706 (+ (* (/ 7.0 8.0) v_0_rtt_previous_srtt) (* (/ 1.0 8.0) ?x1703))))
 (let ((?x1711 (+ v_0_rtt_previous_srtt (* (- 1.0) ?x1703))))
 (let ((?x1714 (ite (>= ?x1711 0.0) ?x1711 (+ (* (- 1.0) v_0_rtt_previous_srtt) ?x1703))))
 (let ((?x666 (/ 1.0 4.0)))
 (let ((?x1718 (ite v_0_rtt_previous_measured (+ (* (/ 3.0 4.0) v_0_rtt_previous_var) (* ?x666 ?x1714)) (* (/ 1.0 2.0) ?x1703))))
 (let (($x1721 (and (= v_0_rttvar_ms ?x1718) (= v_0_srtt_ms (ite v_0_rtt_previous_measured ?x1706 ?x1703)))))
 (let (($x1701 (not v_0_rtt_sample_used)))
 (or $x1701 $x1721))))))))))
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
 (let (($x1855 (and (>= v_0_tx_elapsed v_0_tx_previous_rto) (<= 1 v_0_tx_emit_count) (or (not v_0_tx_is_fin) (= 1 v_0_tx_emit_count)))))
 (let (($x1857 (not v_0_tx_retransmitted)))
 (or $x1857 $x1855))))
(assert
 (let (($x1857 (not v_0_tx_retransmitted)))
 (or $x1857 (not v_0_tx_waiting))))
(assert
 (= 174 choice_0))
(assert
 (= 5 state_0))
(assert
 (= 5 state_1))
(assert
 (let (($x2008 (= 0 v_1_rx_slot_09)))
(let (($x2144 (not (>= v_1_rcv_buf 7))))
(let (($x2145 (or $x2144 $x2008)))
(let (($x2291 (not $x2145)))
(let (($x2093 (>= 1 v_1_rx_slot_09)))
(let (($x2290 (not $x2093)))
(let (($x2013 (= 0 v_1_rx_slot_08)))
(let (($x2141 (not (>= v_1_rcv_buf 8))))
(let (($x2142 (or $x2141 $x2013)))
(let (($x2289 (not $x2142)))
(let (($x2094 (>= 1 v_1_rx_slot_08)))
(let (($x2288 (not $x2094)))
(let (($x2018 (= 0 v_1_rx_slot_07)))
(let (($x2138 (not (>= v_1_rcv_buf 9))))
(let (($x2139 (or $x2138 $x2018)))
(let (($x2287 (not $x2139)))
(let (($x2095 (>= 1 v_1_rx_slot_07)))
(let (($x2286 (not $x2095)))
(let (($x2023 (= 0 v_1_rx_slot_06)))
(let (($x2135 (not (>= v_1_rcv_buf 10))))
(let (($x2136 (or $x2135 $x2023)))
(let (($x2285 (not $x2136)))
(let (($x2096 (>= 1 v_1_rx_slot_06)))
(let (($x2284 (not $x2096)))
(let (($x2028 (= 0 v_1_rx_slot_05)))
(let (($x2132 (not (>= v_1_rcv_buf 11))))
(let (($x2133 (or $x2132 $x2028)))
(let (($x2283 (not $x2133)))
(let (($x2097 (>= 1 v_1_rx_slot_05)))
(let (($x2282 (not $x2097)))
(let (($x2033 (= 0 v_1_rx_slot_04)))
(let (($x2129 (not (>= v_1_rcv_buf 12))))
(let (($x2130 (or $x2129 $x2033)))
(let (($x2281 (not $x2130)))
(let (($x2098 (>= 1 v_1_rx_slot_04)))
(let (($x2280 (not $x2098)))
(let (($x2038 (= 0 v_1_rx_slot_03)))
(let (($x2126 (not (>= v_1_rcv_buf 13))))
(let (($x2127 (or $x2126 $x2038)))
(let (($x2279 (not $x2127)))
(let (($x2099 (>= 1 v_1_rx_slot_03)))
(let (($x2278 (not $x2099)))
(let (($x2043 (= 0 v_1_rx_slot_02)))
(let (($x2123 (not (>= v_1_rcv_buf 14))))
(let (($x2124 (or $x2123 $x2043)))
(let (($x2277 (not $x2124)))
(let (($x2100 (>= 1 v_1_rx_slot_02)))
(let (($x2276 (not $x2100)))
(or $x2276 $x2277 $x2278 $x2279 $x2280 $x2281 $x2282 $x2283 $x2284 $x2285 $x2286 $x2287 $x2288 $x2289 $x2290 $x2291))))))))))))))))))))))))))))))))))))))))))))))))))
(check-sat)
