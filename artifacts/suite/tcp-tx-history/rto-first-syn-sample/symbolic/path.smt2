; benchmark generated from python API
(set-info :status unknown)
(declare-fun state_0 () Int)
(declare-fun now_0 () Int)
(declare-fun active_0_rtx () Bool)
(declare-fun due_0_rtx () Int)
(declare-fun active_0_user () Bool)
(declare-fun due_0_user () Int)
(declare-fun active_0_time_wait () Bool)
(declare-fun due_0_time_wait () Int)
(declare-fun due_1_time_wait () Int)
(declare-fun due_1_user () Int)
(declare-fun due_1_rtx () Int)
(declare-fun active_1_time_wait () Bool)
(declare-fun active_1_user () Bool)
(declare-fun active_1_rtx () Bool)
(declare-fun v_1_tx_waiting () Bool)
(declare-fun v_1_tx_is_fin () Bool)
(declare-fun v_1_tx_previous_rto () Int)
(declare-fun v_1_tx_elapsed () Int)
(declare-fun v_1_tx_retransmitted () Bool)
(declare-fun v_1_tx_max_previous () Int)
(declare-fun v_1_tx_eligible () Int)
(declare-fun v_1_tx_emit_count () Int)
(declare-fun v_1_tx_fin_time () Int)
(declare-fun v_1_tx_time_15 () Int)
(declare-fun v_1_tx_time_14 () Int)
(declare-fun v_1_tx_time_13 () Int)
(declare-fun v_1_tx_time_12 () Int)
(declare-fun v_1_tx_time_11 () Int)
(declare-fun v_1_tx_time_10 () Int)
(declare-fun v_1_tx_time_09 () Int)
(declare-fun v_1_tx_time_08 () Int)
(declare-fun v_1_tx_time_07 () Int)
(declare-fun v_1_tx_time_06 () Int)
(declare-fun v_1_tx_time_05 () Int)
(declare-fun v_1_tx_time_04 () Int)
(declare-fun v_1_tx_time_03 () Int)
(declare-fun v_1_tx_time_02 () Int)
(declare-fun v_1_tx_time_01 () Int)
(declare-fun v_1_tx_time_00 () Int)
(declare-fun v_1_rto_base_ms () Int)
(declare-fun v_1_rtt_samples () Int)
(declare-fun v_1_rtt_last_ms () Int)
(declare-fun v_1_rtt_sample_was_ambiguous () Bool)
(declare-fun v_1_rtt_sample_used () Bool)
(declare-fun v_1_rtt_start_new () Bool)
(declare-fun v_1_rtt_remaining () Int)
(declare-fun v_1_rtt_end () (_ BitVec 32))
(declare-fun v_1_rtt_start_ms () Int)
(declare-fun v_1_rtt_sample_at_ms () Int)
(declare-fun v_1_rtt_ambiguous () Bool)
(declare-fun v_1_rtt_active () Bool)
(declare-fun v_1_rtt_previous_measured () Bool)
(declare-fun v_1_rtt_measured () Bool)
(declare-fun v_1_rtt_previous_var () Real)
(declare-fun v_1_rtt_previous_srtt () Real)
(declare-fun v_1_rtt_error_ms () Real)
(declare-fun v_1_rttvar_ms () Real)
(declare-fun v_1_srtt_ms () Real)
(declare-fun v_1_rx_fin_consumed () Bool)
(declare-fun v_1_rx_fin_done () Bool)
(declare-fun v_1_rx_fin_offset () Int)
(declare-fun v_1_rx_fin_seq () (_ BitVec 32))
(declare-fun v_1_rx_fin_pending () Bool)
(declare-fun v_1_fin_acknowledged () Bool)
(declare-fun v_1_fin_seq () (_ BitVec 32))
(declare-fun v_1_fin_sent () Bool)
(declare-fun v_1_fin_requested () Bool)
(declare-fun v_1_ack_window_update () Bool)
(declare-fun v_1_ack_advance () Bool)
(declare-fun v_1_ack_is_future () Bool)
(declare-fun v_1_ack_is_new () Bool)
(declare-fun v_1_ack_delta () Int)
(declare-fun v_1_seg_acceptable () Bool)
(declare-fun v_1_rx_acceptable () Bool)
(declare-fun v_1_rx_advance () Int)
(declare-fun v_1_rx_slot_15 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_14 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_13 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_12 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_11 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_10 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_09 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_08 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_07 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_06 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_05 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_04 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_03 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_02 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_01 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_slot_00 () (Seq (_ BitVec 8)))
(declare-fun v_1_rx_chunk () (Seq (_ BitVec 8)))
(declare-fun v_1_take () Int)
(declare-fun v_1_snd_wl2 () (_ BitVec 32))
(declare-fun v_1_snd_wl1 () (_ BitVec 32))
(declare-fun v_1_snd_wnd () Int)
(declare-fun v_1_rcv_buf () (Seq (_ BitVec 8)))
(declare-fun v_1_rtx_buf () (Seq (_ BitVec 8)))
(declare-fun v_1_snd_buf () (Seq (_ BitVec 8)))
(declare-fun v_1_local_window () Int)
(declare-fun v_1_msl_ms () Int)
(declare-fun v_1_user_timeout_ms () Int)
(declare-fun v_1_active_open () Bool)
(declare-fun v_1_retries () Int)
(declare-fun v_1_rto_ms () Int)
(declare-fun v_1_tx_flags () String)
(declare-fun v_1_tx_ack () (_ BitVec 32))
(declare-fun v_1_tx_seq () (_ BitVec 32))
(declare-fun v_1_rcv_nxt () (_ BitVec 32))
(declare-fun v_1_snd_nxt () (_ BitVec 32))
(declare-fun v_1_snd_una () (_ BitVec 32))
(declare-fun v_1_irs () (_ BitVec 32))
(declare-fun v_1_iss () (_ BitVec 32))
(declare-fun state_1 () Int)
(declare-fun due_2_time_wait () Int)
(declare-fun due_2_user () Int)
(declare-fun due_2_rtx () Int)
(declare-fun active_2_time_wait () Bool)
(declare-fun active_2_user () Bool)
(declare-fun active_2_rtx () Bool)
(declare-fun v_2_tx_waiting () Bool)
(declare-fun v_2_tx_is_fin () Bool)
(declare-fun v_2_tx_previous_rto () Int)
(declare-fun v_2_tx_elapsed () Int)
(declare-fun v_2_tx_retransmitted () Bool)
(declare-fun v_2_tx_max_previous () Int)
(declare-fun v_2_tx_eligible () Int)
(declare-fun v_2_tx_emit_count () Int)
(declare-fun v_2_tx_fin_time () Int)
(declare-fun v_2_tx_time_15 () Int)
(declare-fun v_2_tx_time_14 () Int)
(declare-fun v_2_tx_time_13 () Int)
(declare-fun v_2_tx_time_12 () Int)
(declare-fun v_2_tx_time_11 () Int)
(declare-fun v_2_tx_time_10 () Int)
(declare-fun v_2_tx_time_09 () Int)
(declare-fun v_2_tx_time_08 () Int)
(declare-fun v_2_tx_time_07 () Int)
(declare-fun v_2_tx_time_06 () Int)
(declare-fun v_2_tx_time_05 () Int)
(declare-fun v_2_tx_time_04 () Int)
(declare-fun v_2_tx_time_03 () Int)
(declare-fun v_2_tx_time_02 () Int)
(declare-fun v_2_tx_time_01 () Int)
(declare-fun v_2_tx_time_00 () Int)
(declare-fun v_2_rto_base_ms () Int)
(declare-fun v_2_rtt_samples () Int)
(declare-fun v_2_rtt_last_ms () Int)
(declare-fun v_2_rtt_sample_was_ambiguous () Bool)
(declare-fun v_2_rtt_sample_used () Bool)
(declare-fun v_2_rtt_start_new () Bool)
(declare-fun v_2_rtt_remaining () Int)
(declare-fun v_2_rtt_end () (_ BitVec 32))
(declare-fun v_2_rtt_start_ms () Int)
(declare-fun v_2_rtt_sample_at_ms () Int)
(declare-fun v_2_rtt_ambiguous () Bool)
(declare-fun v_2_rtt_active () Bool)
(declare-fun v_2_rtt_previous_measured () Bool)
(declare-fun v_2_rtt_measured () Bool)
(declare-fun v_2_rtt_previous_var () Real)
(declare-fun v_2_rtt_previous_srtt () Real)
(declare-fun v_2_rtt_error_ms () Real)
(declare-fun v_2_rttvar_ms () Real)
(declare-fun v_2_srtt_ms () Real)
(declare-fun v_2_rx_fin_consumed () Bool)
(declare-fun v_2_rx_fin_done () Bool)
(declare-fun v_2_rx_fin_offset () Int)
(declare-fun v_2_rx_fin_seq () (_ BitVec 32))
(declare-fun v_2_rx_fin_pending () Bool)
(declare-fun v_2_fin_acknowledged () Bool)
(declare-fun v_2_fin_seq () (_ BitVec 32))
(declare-fun v_2_fin_sent () Bool)
(declare-fun v_2_fin_requested () Bool)
(declare-fun v_2_ack_window_update () Bool)
(declare-fun v_2_ack_advance () Bool)
(declare-fun v_2_ack_is_future () Bool)
(declare-fun v_2_ack_is_new () Bool)
(declare-fun v_2_ack_delta () Int)
(declare-fun v_2_seg_acceptable () Bool)
(declare-fun v_2_rx_acceptable () Bool)
(declare-fun v_2_rx_advance () Int)
(declare-fun v_2_rx_slot_15 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_14 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_13 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_12 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_11 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_10 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_09 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_08 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_07 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_06 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_05 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_04 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_03 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_02 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_01 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_slot_00 () (Seq (_ BitVec 8)))
(declare-fun v_2_rx_chunk () (Seq (_ BitVec 8)))
(declare-fun v_2_take () Int)
(declare-fun v_2_snd_wl2 () (_ BitVec 32))
(declare-fun v_2_snd_wl1 () (_ BitVec 32))
(declare-fun v_2_snd_wnd () Int)
(declare-fun v_2_rcv_buf () (Seq (_ BitVec 8)))
(declare-fun v_2_rtx_buf () (Seq (_ BitVec 8)))
(declare-fun v_2_snd_buf () (Seq (_ BitVec 8)))
(declare-fun v_2_local_window () Int)
(declare-fun v_2_msl_ms () Int)
(declare-fun v_2_user_timeout_ms () Int)
(declare-fun v_2_active_open () Bool)
(declare-fun v_2_retries () Int)
(declare-fun v_2_rto_ms () Int)
(declare-fun v_2_tx_flags () String)
(declare-fun v_2_tx_ack () (_ BitVec 32))
(declare-fun v_2_tx_seq () (_ BitVec 32))
(declare-fun v_2_rcv_nxt () (_ BitVec 32))
(declare-fun v_2_snd_nxt () (_ BitVec 32))
(declare-fun v_2_snd_una () (_ BitVec 32))
(declare-fun v_2_irs () (_ BitVec 32))
(declare-fun v_2_iss () (_ BitVec 32))
(declare-fun state_2 () Int)
(declare-fun v_0_iss () (_ BitVec 32))
(declare-fun v_0_irs () (_ BitVec 32))
(declare-fun v_0_snd_una () (_ BitVec 32))
(declare-fun v_0_snd_nxt () (_ BitVec 32))
(declare-fun v_0_rcv_nxt () (_ BitVec 32))
(declare-fun v_0_tx_seq () (_ BitVec 32))
(declare-fun v_0_tx_ack () (_ BitVec 32))
(declare-fun v_0_tx_flags () String)
(declare-fun v_0_rto_ms () Int)
(declare-fun v_0_retries () Int)
(declare-fun v_0_active_open () Bool)
(declare-fun v_0_user_timeout_ms () Int)
(declare-fun v_0_msl_ms () Int)
(declare-fun v_0_local_window () Int)
(declare-fun v_0_snd_buf () (Seq (_ BitVec 8)))
(declare-fun v_0_rtx_buf () (Seq (_ BitVec 8)))
(declare-fun v_0_rcv_buf () (Seq (_ BitVec 8)))
(declare-fun v_0_snd_wnd () Int)
(declare-fun v_0_snd_wl1 () (_ BitVec 32))
(declare-fun v_0_snd_wl2 () (_ BitVec 32))
(declare-fun v_0_take () Int)
(declare-fun v_0_rx_chunk () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_00 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_01 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_02 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_03 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_04 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_05 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_06 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_07 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_08 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_09 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_10 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_11 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_12 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_13 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_14 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_slot_15 () (Seq (_ BitVec 8)))
(declare-fun v_0_rx_advance () Int)
(declare-fun v_0_rx_acceptable () Bool)
(declare-fun v_0_seg_acceptable () Bool)
(declare-fun v_0_ack_delta () Int)
(declare-fun v_0_ack_is_new () Bool)
(declare-fun v_0_ack_is_future () Bool)
(declare-fun v_0_ack_advance () Bool)
(declare-fun v_0_ack_window_update () Bool)
(declare-fun v_0_fin_requested () Bool)
(declare-fun v_0_fin_sent () Bool)
(declare-fun v_0_fin_seq () (_ BitVec 32))
(declare-fun v_0_fin_acknowledged () Bool)
(declare-fun v_0_rx_fin_pending () Bool)
(declare-fun v_0_rx_fin_seq () (_ BitVec 32))
(declare-fun v_0_rx_fin_offset () Int)
(declare-fun v_0_rx_fin_done () Bool)
(declare-fun v_0_rx_fin_consumed () Bool)
(declare-fun v_0_srtt_ms () Real)
(declare-fun v_0_rttvar_ms () Real)
(declare-fun v_0_rtt_error_ms () Real)
(declare-fun v_0_rtt_previous_srtt () Real)
(declare-fun v_0_rtt_previous_var () Real)
(declare-fun v_0_rtt_measured () Bool)
(declare-fun v_0_rtt_previous_measured () Bool)
(declare-fun v_0_rtt_active () Bool)
(declare-fun v_0_rtt_ambiguous () Bool)
(declare-fun v_0_rtt_sample_at_ms () Int)
(declare-fun v_0_rtt_start_ms () Int)
(declare-fun v_0_rtt_end () (_ BitVec 32))
(declare-fun v_0_rtt_remaining () Int)
(declare-fun v_0_rtt_start_new () Bool)
(declare-fun v_0_rtt_sample_used () Bool)
(declare-fun v_0_rtt_sample_was_ambiguous () Bool)
(declare-fun v_0_rtt_last_ms () Int)
(declare-fun v_0_rtt_samples () Int)
(declare-fun v_0_rto_base_ms () Int)
(declare-fun v_0_tx_time_00 () Int)
(declare-fun v_0_tx_time_01 () Int)
(declare-fun v_0_tx_time_02 () Int)
(declare-fun v_0_tx_time_03 () Int)
(declare-fun v_0_tx_time_04 () Int)
(declare-fun v_0_tx_time_05 () Int)
(declare-fun v_0_tx_time_06 () Int)
(declare-fun v_0_tx_time_07 () Int)
(declare-fun v_0_tx_time_08 () Int)
(declare-fun v_0_tx_time_09 () Int)
(declare-fun v_0_tx_time_10 () Int)
(declare-fun v_0_tx_time_11 () Int)
(declare-fun v_0_tx_time_12 () Int)
(declare-fun v_0_tx_time_13 () Int)
(declare-fun v_0_tx_time_14 () Int)
(declare-fun v_0_tx_time_15 () Int)
(declare-fun v_0_tx_fin_time () Int)
(declare-fun v_0_tx_emit_count () Int)
(declare-fun v_0_tx_eligible () Int)
(declare-fun v_0_tx_max_previous () Int)
(declare-fun v_0_tx_retransmitted () Bool)
(declare-fun v_0_tx_elapsed () Int)
(declare-fun v_0_tx_previous_rto () Int)
(declare-fun v_0_tx_is_fin () Bool)
(declare-fun v_0_tx_waiting () Bool)
(declare-fun choice_0 () Int)
(declare-fun now_1 () Int)
(declare-fun choice_1 () Int)
(declare-fun now_2 () Int)
(declare-fun input_1_net.synack_seq () (_ BitVec 32))
(declare-fun input_1_net.synack_ack () (_ BitVec 32))
(declare-fun input_1_net.synack_window () Int)
(assert
 (= state_0 0))
(assert
 (= now_0 0))
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
 true)
(assert
 (not active_0_rtx))
(assert
 (= due_0_rtx 0))
(assert
 (not active_0_user))
(assert
 (= due_0_user 0))
(assert
 (not active_0_time_wait))
(assert
 (= due_0_time_wait 0))
(assert
 true)
(assert
 (let (($x44641 (= due_1_time_wait due_0_time_wait)))
 (let (($x138563 (= due_1_user 30000)))
 (let (($x111460 (= due_1_rtx 1000)))
 (let (($x137502 (not active_1_time_wait)))
 (let (($x361455 (not v_1_tx_waiting)))
 (let (($x372858 (not v_1_tx_is_fin)))
 (let (($x7601 (= v_1_tx_previous_rto 1000)))
 (let (($x381418 (= v_1_tx_elapsed 0)))
 (let (($x123863 (not v_1_tx_retransmitted)))
 (let (($x379254 (= v_1_tx_max_previous 0)))
 (let (($x352617 (= v_1_tx_eligible 0)))
 (let (($x287124 (= v_1_tx_emit_count 0)))
 (let (($x186348 (= v_1_tx_fin_time 0)))
 (let (($x358673 (= v_1_tx_time_15 0)))
 (let (($x334863 (= v_1_tx_time_14 0)))
 (let (($x13014 (= v_1_tx_time_13 0)))
 (let (($x303026 (= v_1_tx_time_12 0)))
 (let (($x363542 (= v_1_tx_time_11 0)))
 (let (($x353276 (= v_1_tx_time_10 0)))
 (let (($x235857 (= v_1_tx_time_09 0)))
 (let (($x360014 (= v_1_tx_time_08 0)))
 (let (($x441937 (= v_1_tx_time_07 0)))
 (let (($x287110 (= v_1_tx_time_06 0)))
 (let (($x33846 (= v_1_tx_time_05 0)))
 (let (($x7018 (= v_1_tx_time_04 0)))
 (let (($x138513 (= v_1_tx_time_03 0)))
 (let (($x175938 (= v_1_tx_time_02 0)))
 (let (($x72348 (= v_1_tx_time_01 0)))
 (let (($x7297 (= v_1_tx_time_00 0)))
 (let (($x370584 (= v_1_rto_base_ms 1000)))
 (let (($x129285 (= v_1_rtt_samples 0)))
 (let (($x338678 (= v_1_rtt_last_ms 0)))
 (let (($x360594 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x48765 (not v_1_rtt_sample_used)))
 (let (($x366401 (= v_1_rtt_remaining 1)))
 (let (($x6764 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x7953 (= v_1_rtt_start_ms 0)))
 (let (($x103256 (= v_1_rtt_sample_at_ms 0)))
 (let (($x118266 (not v_1_rtt_ambiguous)))
 (let (($x320410 (not v_1_rtt_previous_measured)))
 (let (($x58989 (not v_1_rtt_measured)))
 (let (($x131588 (= v_1_rtt_previous_var 0.0)))
 (let (($x363370 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x6213 (= v_1_rtt_error_ms 0.0)))
 (let (($x362274 (= v_1_rttvar_ms 0.0)))
 (let (($x333698 (= v_1_srtt_ms 0.0)))
 (let (($x340811 (not v_1_rx_fin_consumed)))
 (let (($x70013 (not v_1_rx_fin_done)))
 (let (($x372242 (= v_1_rx_fin_offset 0)))
 (let (($x43734 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x2005 (not v_1_rx_fin_pending)))
 (let (($x70021 (not v_1_fin_acknowledged)))
 (let (($x5277 (= v_1_fin_seq (_ bv0 32))))
 (let (($x373817 (not v_1_fin_sent)))
 (let (($x362399 (not v_1_fin_requested)))
 (let (($x322142 (not v_1_ack_window_update)))
 (let (($x71997 (not v_1_ack_advance)))
 (let (($x23384 (not v_1_ack_is_future)))
 (let (($x3153 (not v_1_ack_is_new)))
 (let (($x132442 (= v_1_ack_delta 0)))
 (let (($x348969 (not v_1_seg_acceptable)))
 (let (($x362697 (not v_1_rx_acceptable)))
 (let (($x167197 (= v_1_rx_advance 0)))
 (let (($x318493 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x150198 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x369914 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x40734 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x1977 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x135366 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x59984 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x30130 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x363734 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x129939 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x299820 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x285719 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x169012 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x203164 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x9282 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x370902 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x53819 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x481369 (= v_1_take 0)))
 (let (($x127474 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x375450 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x374678 (= v_1_snd_wnd 8)))
 (let (($x59471 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x35970 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x256107 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x373169 (= v_1_local_window 16)))
 (let (($x29741 (= v_1_msl_ms 60000)))
 (let (($x5950 (= v_1_user_timeout_ms 30000)))
 (let (($x60790 (= 0 v_1_retries)))
 (let (($x18046 (= 1000 v_1_rto_ms)))
 (let (($x330947 (= v_1_tx_flags "S")))
 (let (($x16166 (= v_1_tx_ack (_ bv0 32))))
 (let (($x160475 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x43941 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x167413 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x37376 (= v_1_snd_una (_ bv1000 32))))
 (let (($x378156 (= v_1_irs (_ bv0 32))))
 (let (($x339485 (= v_1_iss (_ bv1000 32))))
 (let (($x164408 (= 2 state_1)))
 (let (($x128184 (not active_0_time_wait)))
 (let (($x66937 (or $x128184 (not (<= due_0_time_wait 0)))))
 (let (($x398412 (not active_0_user)))
 (let (($x383938 (or $x398412 (not (<= due_0_user 0)))))
 (let (($x327391 (not active_0_rtx)))
 (let (($x54934 (or $x327391 (not (<= due_0_rtx 0)))))
 (let (($x337583 (= state_0 0)))
 (and $x337583 (>= 0 now_0) $x54934 $x383938 $x66937 $x164408 $x339485 $x378156 $x37376 $x167413 $x43941 $x160475 $x16166 $x330947 $x18046 $x60790 v_1_active_open $x5950 $x29741 $x373169 $x256107 $x35970 $x59471 $x374678 $x375450 $x127474 $x481369 $x53819 $x370902 $x9282 $x203164 $x169012 $x285719 $x299820 $x129939 $x363734 $x30130 $x59984 $x135366 $x1977 $x40734 $x369914 $x150198 $x318493 $x167197 $x362697 $x348969 $x132442 $x3153 $x23384 $x71997 $x322142 $x362399 $x373817 $x5277 $x70021 $x2005 $x43734 $x372242 $x70013 $x340811 $x333698 $x362274 $x6213 $x363370 $x131588 $x58989 $x320410 v_1_rtt_active $x118266 $x103256 $x7953 $x6764 $x366401 v_1_rtt_start_new $x48765 $x360594 $x338678 $x129285 $x370584 $x7297 $x72348 $x175938 $x138513 $x7018 $x33846 $x287110 $x441937 $x360014 $x235857 $x353276 $x363542 $x303026 $x13014 $x334863 $x358673 $x186348 $x287124 $x352617 $x379254 $x123863 $x381418 $x7601 $x372858 $x361455 active_1_rtx active_1_user $x137502 $x111460 $x138563 $x44641))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x162903 (= due_2_time_wait due_1_time_wait)))
 (let (($x297561 (= due_2_user due_1_user)))
 (let (($x404592 (= due_2_rtx due_1_rtx)))
 (let (($x379946 (= active_2_time_wait active_1_time_wait)))
 (let (($x125555 (not active_2_user)))
 (let (($x128353 (not active_2_rtx)))
 (let (($x130015 (not v_2_tx_waiting)))
 (let (($x128422 (= v_2_tx_is_fin v_1_tx_is_fin)))
 (let (($x18330 (= v_2_tx_previous_rto v_1_tx_previous_rto)))
 (let (($x318404 (= v_2_tx_elapsed v_1_tx_elapsed)))
 (let (($x155470 (not v_2_tx_retransmitted)))
 (let (($x238150 (= v_2_tx_max_previous v_1_tx_max_previous)))
 (let (($x240210 (= v_2_tx_eligible v_1_tx_eligible)))
 (let (($x311702 (= v_2_tx_emit_count v_1_tx_emit_count)))
 (let ((?x16633 (ite (and v_1_fin_sent (not v_1_fin_acknowledged)) v_1_tx_fin_time 0)))
 (let (($x169281 (= v_2_tx_fin_time ?x16633)))
 (let (($x242216 (= v_2_tx_time_15 (ite (>= 15 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_15))))
 (let (($x141669 (= v_2_tx_time_14 (ite (>= 14 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_14))))
 (let (($x379557 (= v_2_tx_time_13 (ite (>= 13 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_13))))
 (let (($x35133 (= v_2_tx_time_12 (ite (>= 12 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_12))))
 (let (($x165199 (= v_2_tx_time_11 (ite (>= 11 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_11))))
 (let (($x377142 (= v_2_tx_time_10 (ite (>= 10 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_10))))
 (let (($x12046 (= v_2_tx_time_09 (ite (>= 9 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_09))))
 (let (($x471483 (= v_2_tx_time_08 (ite (>= 8 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_08))))
 (let (($x127541 (= v_2_tx_time_07 (ite (>= 7 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_07))))
 (let (($x38700 (= v_2_tx_time_06 (ite (>= 6 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_06))))
 (let (($x58019 (= v_2_tx_time_05 (ite (>= 5 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_05))))
 (let (($x431693 (= v_2_tx_time_04 (ite (>= 4 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_04))))
 (let (($x164568 (= v_2_tx_time_03 (ite (>= 3 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_03))))
 (let (($x371133 (= v_2_tx_time_02 (ite (>= 2 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_02))))
 (let (($x371095 (= v_2_tx_time_01 (ite (>= 1 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_01))))
 (let (($x327838 (= v_2_tx_time_00 (ite (>= 0 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_00))))
 (let ((?x431827 (+ 900 (* (- 1) v_1_rtt_start_ms))))
 (let (($x118266 (not v_1_rtt_ambiguous)))
 (let ((?x392680 (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let ((?x74963 (ubv_to_int (bvadd (_ bv1001 32) (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let (($x105263 (>= ?x74963 ?x392680)))
 (let (($x382266 (and v_1_rtt_active $x105263 $x118266)))
 (let ((?x134303 (ite $x382266 ?x431827 v_1_rtt_last_ms)))
 (let ((?x374238 (to_real ?x134303)))
 (let ((?x330416 (+ v_1_srtt_ms (* (- 1.0) ?x374238))))
 (let ((?x118004 (ite $x382266 (ite (>= ?x330416 0.0) ?x330416 (+ (* (- 1.0) v_1_srtt_ms) ?x374238)) v_1_rtt_error_ms)))
 (let ((?x84789 (* (/ 3.0 4.0) v_1_rttvar_ms)))
 (let ((?x229267 (ite $x382266 (ite v_1_rtt_measured (+ ?x84789 (* (/ 1.0 4.0) ?x118004)) (* (/ 1.0 2.0) ?x374238)) v_1_rttvar_ms)))
 (let ((?x271183 (ite v_1_rtt_measured (+ (* (/ 7.0 8.0) v_1_srtt_ms) (* (/ 1.0 8.0) ?x374238)) ?x374238)))
 (let ((?x132301 (ite $x382266 ?x271183 v_1_srtt_ms)))
 (let ((?x51209 (+ (* (- 1.0) ?x132301) (* (- 1.0) (ite (<= ?x229267 (/ 1.0 4.0)) 1.0 (* 4.0 ?x229267))))))
 (let ((?x21797 (to_int ?x51209)))
 (let ((?x2055 (ite (<= ?x21797 (- 1000)) (* (- 1) ?x21797) 1000)))
 (let ((?x17499 (ite (<= 60000 ?x2055) 60000 ?x2055)))
 (let (($x361618 (= v_2_rtt_sample_was_ambiguous (and v_1_rtt_active v_1_rtt_ambiguous))))
 (let (($x6850 (not v_2_rtt_start_new)))
 (let ((?x362693 (* (- 1) ?x74963)))
 (let ((?x72595 (+ ?x392680 ?x362693)))
 (let ((?x387523 (ite (and v_1_rtt_active (not (<= v_1_rtt_remaining ?x72595))) ?x72595 v_1_rtt_remaining)))
 (let (($x288531 (and v_1_rtt_active $x105263)))
 (let (($x461794 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x4550 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let (($x373171 (= v_2_rtt_previous_measured (ite $x382266 v_1_rtt_measured v_1_rtt_previous_measured))))
 (let (($x362497 (= v_2_rtt_previous_var (ite $x382266 v_1_rttvar_ms v_1_rtt_previous_var))))
 (let (($x55586 (= v_2_rtt_previous_srtt (ite $x382266 v_1_srtt_ms v_1_rtt_previous_srtt))))
 (let (($x177528 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x360706 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x376747 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x65272 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x389676 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x384720 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x380644 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x162256 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x148157 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x308208 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x304717 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x497107 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x362079 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x119164 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x375351 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x7470 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x1597 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x374033 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x130732 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x361883 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x12088 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x373109 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x361083 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x164025 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x378499 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x49390 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x348989 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x334240 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x369387 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x257433 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x99660 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x371136 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x139573 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x399136 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x307488 (= v_2_take v_1_take)))
 (let (($x303855 (= v_2_snd_wl2 (_ bv1001 32))))
 (let (($x211125 (= v_2_snd_wl1 (_ bv9000 32))))
 (let (($x49223 (= v_2_snd_wnd 16)))
 (let (($x364778 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x127898 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x374327 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x369923 (= v_2_local_window v_1_local_window)))
 (let (($x371190 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x61375 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x129266 (= v_2_active_open v_1_active_open)))
 (let (($x58638 (= v_2_retries v_1_retries)))
 (let (($x363127 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x132976 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x359787 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x371415 (= v_2_rcv_nxt (_ bv9001 32))))
 (let (($x133702 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x442196 (= v_2_snd_una (_ bv1001 32))))
 (let (($x55931 (= v_2_irs (_ bv9000 32))))
 (let (($x348440 (= v_2_iss v_1_iss)))
 (let (($x226571 (= 4 state_2)))
 (let (($x137502 (not active_1_time_wait)))
 (let (($x65850 (or $x137502 (not (<= due_1_time_wait 900)))))
 (let (($x337710 (or (not active_1_user) (not (<= due_1_user 900)))))
 (let (($x154917 (or (not active_1_rtx) (not (<= due_1_rtx 900)))))
 (let (($x60790 (= 0 v_1_retries)))
 (let (($x167413 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x138980 (= state_1 2)))
 (and $x138980 $x167413 $x60790 $x154917 $x337710 $x65850 $x226571 $x348440 $x55931 $x442196 $x133702 $x371415 $x359787 $x132976 $x363127 (= v_2_rto_ms (ite $x382266 ?x17499 v_1_rto_ms)) $x58638 $x129266 $x61375 $x371190 $x369923 $x374327 $x127898 $x364778 $x49223 $x211125 $x303855 $x307488 $x399136 $x139573 $x371136 $x99660 $x257433 $x369387 $x334240 $x348989 $x49390 $x378499 $x164025 $x361083 $x373109 $x12088 $x361883 $x130732 $x374033 $x1597 $x7470 $x375351 $x119164 $x362079 $x497107 $x304717 $x308208 $x148157 $x162256 $x380644 $x384720 $x389676 $x65272 $x376747 $x360706 $x177528 (= v_2_srtt_ms ?x132301) (= v_2_rttvar_ms ?x229267) (= v_2_rtt_error_ms ?x118004) $x55586 $x362497 (= v_2_rtt_measured (or v_1_rtt_measured $x382266)) $x373171 (= v_2_rtt_active (and v_1_rtt_active (not $x288531))) (= v_2_rtt_ambiguous (and (not $x288531) v_1_rtt_ambiguous)) (= v_2_rtt_sample_at_ms (ite $x382266 900 v_1_rtt_sample_at_ms)) $x4550 $x461794 (= v_2_rtt_remaining (ite $x288531 0 ?x387523)) $x6850 (= v_2_rtt_sample_used $x382266) $x361618 (= v_2_rtt_last_ms ?x134303) (= v_2_rtt_samples (+ v_1_rtt_samples (ite $x382266 1 0))) (= v_2_rto_base_ms (ite $x382266 ?x17499 v_1_rto_base_ms)) $x327838 $x371095 $x371133 $x164568 $x431693 $x58019 $x38700 $x127541 $x471483 $x12046 $x377142 $x165199 $x35133 $x379557 $x141669 $x242216 $x169281 $x311702 $x240210 $x238150 $x155470 $x318404 $x18330 $x128422 $x130015 $x128353 $x125555 $x379946 $x404592 $x297561 $x162903)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
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
 (= (_ bv1000 32) v_0_iss))
(assert
 (= (_ bv0 32) v_0_irs))
(assert
 (= (_ bv1000 32) v_0_snd_una))
(assert
 (= (_ bv1000 32) v_0_snd_nxt))
(assert
 (= (_ bv0 32) v_0_rcv_nxt))
(assert
 (= (_ bv1000 32) v_0_tx_seq))
(assert
 (= (_ bv0 32) v_0_tx_ack))
(assert
 (= v_0_tx_flags "S"))
(assert
 (= 1000 v_0_rto_ms))
(assert
 (= 0 v_0_retries))
(assert
 (= v_0_active_open true))
(assert
 (= 30000 v_0_user_timeout_ms))
(assert
 (= 60000 v_0_msl_ms))
(assert
 (= 16 v_0_local_window))
(assert
 (= v_0_snd_buf (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rtx_buf (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rcv_buf (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= 8 v_0_snd_wnd))
(assert
 (= (_ bv0 32) v_0_snd_wl1))
(assert
 (= (_ bv0 32) v_0_snd_wl2))
(assert
 (= 0 v_0_take))
(assert
 (= v_0_rx_chunk (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_00 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_01 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_02 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_03 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_04 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_05 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_06 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_07 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_08 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_09 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_10 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_11 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_12 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_13 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_14 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= v_0_rx_slot_15 (as seq.empty (Seq (_ BitVec 8)))))
(assert
 (= 0 v_0_rx_advance))
(assert
 (= v_0_rx_acceptable false))
(assert
 (= v_0_seg_acceptable false))
(assert
 (= 0 v_0_ack_delta))
(assert
 (= v_0_ack_is_new false))
(assert
 (= v_0_ack_is_future false))
(assert
 (= v_0_ack_advance false))
(assert
 (= v_0_ack_window_update false))
(assert
 (= v_0_fin_requested false))
(assert
 (= v_0_fin_sent false))
(assert
 (= (_ bv0 32) v_0_fin_seq))
(assert
 (= v_0_fin_acknowledged false))
(assert
 (= v_0_rx_fin_pending false))
(assert
 (= (_ bv0 32) v_0_rx_fin_seq))
(assert
 (= 0 v_0_rx_fin_offset))
(assert
 (= v_0_rx_fin_done false))
(assert
 (= v_0_rx_fin_consumed false))
(assert
 (= 0.0 v_0_srtt_ms))
(assert
 (= 0.0 v_0_rttvar_ms))
(assert
 (= 0.0 v_0_rtt_error_ms))
(assert
 (= 0.0 v_0_rtt_previous_srtt))
(assert
 (= 0.0 v_0_rtt_previous_var))
(assert
 (= v_0_rtt_measured false))
(assert
 (= v_0_rtt_previous_measured false))
(assert
 (= v_0_rtt_active false))
(assert
 (= v_0_rtt_ambiguous false))
(assert
 (= 0 v_0_rtt_sample_at_ms))
(assert
 (= 0 v_0_rtt_start_ms))
(assert
 (= (_ bv0 32) v_0_rtt_end))
(assert
 (= 0 v_0_rtt_remaining))
(assert
 (= v_0_rtt_start_new false))
(assert
 (= v_0_rtt_sample_used false))
(assert
 (= v_0_rtt_sample_was_ambiguous false))
(assert
 (= 0 v_0_rtt_last_ms))
(assert
 (= 0 v_0_rtt_samples))
(assert
 (= 1000 v_0_rto_base_ms))
(assert
 (= 0 v_0_tx_time_00))
(assert
 (= 0 v_0_tx_time_01))
(assert
 (= 0 v_0_tx_time_02))
(assert
 (= 0 v_0_tx_time_03))
(assert
 (= 0 v_0_tx_time_04))
(assert
 (= 0 v_0_tx_time_05))
(assert
 (= 0 v_0_tx_time_06))
(assert
 (= 0 v_0_tx_time_07))
(assert
 (= 0 v_0_tx_time_08))
(assert
 (= 0 v_0_tx_time_09))
(assert
 (= 0 v_0_tx_time_10))
(assert
 (= 0 v_0_tx_time_11))
(assert
 (= 0 v_0_tx_time_12))
(assert
 (= 0 v_0_tx_time_13))
(assert
 (= 0 v_0_tx_time_14))
(assert
 (= 0 v_0_tx_time_15))
(assert
 (= 0 v_0_tx_fin_time))
(assert
 (= 0 v_0_tx_emit_count))
(assert
 (= 0 v_0_tx_eligible))
(assert
 (= 0 v_0_tx_max_previous))
(assert
 (= v_0_tx_retransmitted false))
(assert
 (= 0 v_0_tx_elapsed))
(assert
 (= 1000 v_0_tx_previous_rto))
(assert
 (= v_0_tx_is_fin false))
(assert
 (= v_0_tx_waiting false))
(assert
 (= 0 choice_0))
(assert
 (= 0 now_1))
(assert
 (= 4 choice_1))
(assert
 (= 900 now_2))
(assert
 (= (_ bv9000 32) input_1_net.synack_seq))
(assert
 (= (_ bv1001 32) input_1_net.synack_ack))
(assert
 (= 16 input_1_net.synack_window))
(check-sat)
