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
 (let (($x707684 (= due_1_time_wait due_0_time_wait)))
 (let (($x199825 (= due_1_user 30000)))
 (let (($x172958 (= due_1_rtx 1000)))
 (let (($x321079 (not active_1_time_wait)))
 (let (($x62875 (not v_1_tx_waiting)))
 (let (($x632220 (not v_1_tx_is_fin)))
 (let (($x170009 (= v_1_tx_previous_rto 1000)))
 (let (($x791663 (= v_1_tx_elapsed 0)))
 (let (($x276424 (not v_1_tx_retransmitted)))
 (let (($x265817 (= v_1_tx_max_previous 0)))
 (let (($x83847 (= v_1_tx_eligible 0)))
 (let (($x319594 (= v_1_tx_emit_count 0)))
 (let (($x18338 (= v_1_tx_fin_time 0)))
 (let (($x296548 (= v_1_tx_time_15 0)))
 (let (($x120496 (= v_1_tx_time_14 0)))
 (let (($x41584 (= v_1_tx_time_13 0)))
 (let (($x284595 (= v_1_tx_time_12 0)))
 (let (($x130363 (= v_1_tx_time_11 0)))
 (let (($x106933 (= v_1_tx_time_10 0)))
 (let (($x185184 (= v_1_tx_time_09 0)))
 (let (($x82542 (= v_1_tx_time_08 0)))
 (let (($x73178 (= v_1_tx_time_07 0)))
 (let (($x293315 (= v_1_tx_time_06 0)))
 (let (($x725792 (= v_1_tx_time_05 0)))
 (let (($x130740 (= v_1_tx_time_04 0)))
 (let (($x265752 (= v_1_tx_time_03 0)))
 (let (($x381513 (= v_1_tx_time_02 0)))
 (let (($x388066 (= v_1_tx_time_01 0)))
 (let (($x15847 (= v_1_tx_time_00 0)))
 (let (($x247510 (= v_1_rto_base_ms 1000)))
 (let (($x72223 (= v_1_rtt_samples 0)))
 (let (($x132763 (= v_1_rtt_last_ms 0)))
 (let (($x172686 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x237761 (not v_1_rtt_sample_used)))
 (let (($x279075 (= v_1_rtt_remaining 1)))
 (let (($x87832 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x183773 (= v_1_rtt_start_ms 0)))
 (let (($x158380 (not v_1_rtt_ambiguous)))
 (let (($x274721 (not v_1_rtt_previous_measured)))
 (let (($x18644 (not v_1_rtt_measured)))
 (let (($x140368 (= v_1_rtt_previous_var 0.0)))
 (let (($x233561 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x172465 (= v_1_rtt_error_ms 0.0)))
 (let (($x73912 (= v_1_rttvar_ms 0.0)))
 (let (($x917367 (= v_1_srtt_ms 0.0)))
 (let (($x859088 (not v_1_rx_fin_consumed)))
 (let (($x166126 (not v_1_rx_fin_done)))
 (let (($x40520 (= v_1_rx_fin_offset 0)))
 (let (($x859525 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x124836 (not v_1_rx_fin_pending)))
 (let (($x55499 (not v_1_fin_acknowledged)))
 (let (($x179329 (= v_1_fin_seq (_ bv0 32))))
 (let (($x310848 (not v_1_fin_sent)))
 (let (($x61302 (not v_1_fin_requested)))
 (let (($x151255 (not v_1_ack_window_update)))
 (let (($x34755 (not v_1_ack_advance)))
 (let (($x313038 (not v_1_ack_is_future)))
 (let (($x145732 (not v_1_ack_is_new)))
 (let (($x188395 (= v_1_ack_delta 0)))
 (let (($x141965 (not v_1_seg_acceptable)))
 (let (($x120038 (not v_1_rx_acceptable)))
 (let (($x233052 (= v_1_rx_advance 0)))
 (let (($x141102 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x93849 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x66604 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x21044 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x792246 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x203752 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x135601 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x279664 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x168233 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x812827 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x270016 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x88751 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x271294 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x247208 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x36438 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x206397 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x344325 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x164517 (= v_1_take 0)))
 (let (($x416292 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x267775 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x387700 (= v_1_snd_wnd 8)))
 (let (($x261036 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x266869 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x385839 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x350182 (= v_1_local_window 16)))
 (let (($x181835 (= v_1_msl_ms 60000)))
 (let (($x17369 (= v_1_user_timeout_ms 30000)))
 (let (($x31678 (= 0 v_1_retries)))
 (let (($x765489 (= 1000 v_1_rto_ms)))
 (let (($x172932 (= v_1_tx_flags "S")))
 (let (($x263714 (= v_1_tx_ack (_ bv0 32))))
 (let (($x289168 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x234043 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x70368 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x140540 (= v_1_snd_una (_ bv1000 32))))
 (let (($x297686 (= v_1_irs (_ bv0 32))))
 (let (($x228863 (= v_1_iss (_ bv1000 32))))
 (let (($x122734 (= 2 state_1)))
 (let (($x225428 (not active_0_time_wait)))
 (let (($x165036 (or $x225428 (not (<= due_0_time_wait 0)))))
 (let (($x147944 (not active_0_user)))
 (let (($x149522 (or $x147944 (not (<= due_0_user 0)))))
 (let (($x934284 (not active_0_rtx)))
 (let (($x46894 (or $x934284 (not (<= due_0_rtx 0)))))
 (let (($x793333 (= state_0 0)))
 (and $x793333 (>= 0 now_0) $x46894 $x149522 $x165036 $x122734 $x228863 $x297686 $x140540 $x70368 $x234043 $x289168 $x263714 $x172932 $x765489 $x31678 v_1_active_open $x17369 $x181835 $x350182 $x385839 $x266869 $x261036 $x387700 $x267775 $x416292 $x164517 $x344325 $x206397 $x36438 $x247208 $x271294 $x88751 $x270016 $x812827 $x168233 $x279664 $x135601 $x203752 $x792246 $x21044 $x66604 $x93849 $x141102 $x233052 $x120038 $x141965 $x188395 $x145732 $x313038 $x34755 $x151255 $x61302 $x310848 $x179329 $x55499 $x124836 $x859525 $x40520 $x166126 $x859088 $x917367 $x73912 $x172465 $x233561 $x140368 $x18644 $x274721 v_1_rtt_active $x158380 $x183773 $x87832 $x279075 v_1_rtt_start_new $x237761 $x172686 $x132763 $x72223 $x247510 $x15847 $x388066 $x381513 $x265752 $x130740 $x725792 $x293315 $x73178 $x82542 $x185184 $x106933 $x130363 $x284595 $x41584 $x120496 $x296548 $x18338 $x319594 $x83847 $x265817 $x276424 $x791663 $x170009 $x632220 $x62875 active_1_rtx active_1_user $x321079 $x172958 $x199825 $x707684)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 (let (($x30072 (= due_2_time_wait due_1_time_wait)))
 (let (($x277192 (= due_2_user due_1_user)))
 (let (($x728830 (= due_2_rtx due_1_rtx)))
 (let (($x348436 (= active_2_time_wait active_1_time_wait)))
 (let (($x853687 (not active_2_user)))
 (let (($x219624 (not active_2_rtx)))
 (let (($x238095 (not v_2_tx_waiting)))
 (let (($x203815 (= v_2_tx_is_fin v_1_tx_is_fin)))
 (let (($x87704 (= v_2_tx_previous_rto v_1_tx_previous_rto)))
 (let (($x79223 (= v_2_tx_elapsed v_1_tx_elapsed)))
 (let (($x78405 (not v_2_tx_retransmitted)))
 (let (($x64244 (= v_2_tx_max_previous v_1_tx_max_previous)))
 (let (($x275832 (= v_2_tx_eligible v_1_tx_eligible)))
 (let (($x294490 (= v_2_tx_emit_count v_1_tx_emit_count)))
 (let ((?x158343 (ite (and v_1_fin_sent (not v_1_fin_acknowledged)) v_1_tx_fin_time 0)))
 (let (($x153809 (= v_2_tx_fin_time ?x158343)))
 (let (($x248473 (= v_2_tx_time_15 (ite (>= 15 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_15))))
 (let (($x72550 (= v_2_tx_time_14 (ite (>= 14 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_14))))
 (let (($x416425 (= v_2_tx_time_13 (ite (>= 13 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_13))))
 (let (($x324860 (= v_2_tx_time_12 (ite (>= 12 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_12))))
 (let (($x160866 (= v_2_tx_time_11 (ite (>= 11 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_11))))
 (let (($x856490 (= v_2_tx_time_10 (ite (>= 10 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_10))))
 (let (($x112005 (= v_2_tx_time_09 (ite (>= 9 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_09))))
 (let (($x86007 (= v_2_tx_time_08 (ite (>= 8 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_08))))
 (let (($x167156 (= v_2_tx_time_07 (ite (>= 7 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_07))))
 (let (($x84052 (= v_2_tx_time_06 (ite (>= 6 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_06))))
 (let (($x720289 (= v_2_tx_time_05 (ite (>= 5 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_05))))
 (let (($x182820 (= v_2_tx_time_04 (ite (>= 4 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_04))))
 (let (($x364502 (= v_2_tx_time_03 (ite (>= 3 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_03))))
 (let (($x278199 (= v_2_tx_time_02 (ite (>= 2 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_02))))
 (let (($x298591 (= v_2_tx_time_01 (ite (>= 1 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_01))))
 (let (($x818352 (= v_2_tx_time_00 (ite (>= 0 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_00))))
 (let ((?x140472 (+ 900 (* (- 1) v_1_rtt_start_ms))))
 (let (($x158380 (not v_1_rtt_ambiguous)))
 (let ((?x312823 (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let ((?x169321 (ubv_to_int (bvadd (_ bv1001 32) (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let (($x260462 (>= ?x169321 ?x312823)))
 (let (($x251903 (and v_1_rtt_active $x260462 $x158380)))
 (let ((?x604475 (ite $x251903 ?x140472 v_1_rtt_last_ms)))
 (let ((?x335977 (to_real ?x604475)))
 (let ((?x401854 (+ v_1_srtt_ms (* (- 1.0) ?x335977))))
 (let ((?x116489 (ite $x251903 (ite (>= ?x401854 0.0) ?x401854 (+ (* (- 1.0) v_1_srtt_ms) ?x335977)) v_1_rtt_error_ms)))
 (let ((?x253334 (* (/ 3.0 4.0) v_1_rttvar_ms)))
 (let ((?x145232 (ite $x251903 (ite v_1_rtt_measured (+ ?x253334 (* (/ 1.0 4.0) ?x116489)) (* (/ 1.0 2.0) ?x335977)) v_1_rttvar_ms)))
 (let ((?x399908 (ite v_1_rtt_measured (+ (* (/ 7.0 8.0) v_1_srtt_ms) (* (/ 1.0 8.0) ?x335977)) ?x335977)))
 (let ((?x103633 (ite $x251903 ?x399908 v_1_srtt_ms)))
 (let ((?x62612 (+ (* (- 1.0) ?x103633) (* (- 1.0) (ite (<= ?x145232 (/ 1.0 4.0)) 1.0 (* 4.0 ?x145232))))))
 (let ((?x103829 (to_int ?x62612)))
 (let ((?x183592 (ite (<= ?x103829 (- 1000)) (* (- 1) ?x103829) 1000)))
 (let ((?x544520 (ite (<= 60000 ?x183592) 60000 ?x183592)))
 (let (($x123965 (= v_2_rtt_sample_was_ambiguous (and v_1_rtt_active v_1_rtt_ambiguous))))
 (let (($x230608 (not v_2_rtt_start_new)))
 (let ((?x86992 (* (- 1) ?x169321)))
 (let ((?x227001 (+ ?x312823 ?x86992)))
 (let ((?x265662 (ite (and v_1_rtt_active (not (<= v_1_rtt_remaining ?x227001))) ?x227001 v_1_rtt_remaining)))
 (let (($x138893 (and v_1_rtt_active $x260462)))
 (let (($x142596 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x94684 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let (($x87505 (= v_2_rtt_previous_measured (ite $x251903 v_1_rtt_measured v_1_rtt_previous_measured))))
 (let (($x233999 (= v_2_rtt_previous_var (ite $x251903 v_1_rttvar_ms v_1_rtt_previous_var))))
 (let (($x61490 (= v_2_rtt_previous_srtt (ite $x251903 v_1_srtt_ms v_1_rtt_previous_srtt))))
 (let (($x297271 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x431198 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x288468 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x222105 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x431315 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x324103 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x633685 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x16748 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x32175 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x89315 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x435740 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x205190 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x313817 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x35936 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x20169 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x78281 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x157199 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x61598 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x76677 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x78934 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x49039 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x246900 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x4190 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x794153 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x10991 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x224631 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x18253 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x210124 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x135320 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x405477 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x29758 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x113964 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x118492 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x285719 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x884873 (= v_2_take v_1_take)))
 (let (($x170693 (= v_2_snd_wl2 (_ bv1001 32))))
 (let (($x74379 (= v_2_snd_wl1 (_ bv9000 32))))
 (let (($x147318 (= v_2_snd_wnd 16)))
 (let (($x16517 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x51230 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x44568 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x174484 (= v_2_local_window v_1_local_window)))
 (let (($x341262 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x105463 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x72509 (= v_2_active_open v_1_active_open)))
 (let (($x170817 (= v_2_retries v_1_retries)))
 (let (($x51159 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x177464 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x267490 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x966451 (= v_2_rcv_nxt (_ bv9001 32))))
 (let (($x350158 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x181932 (= v_2_snd_una (_ bv1001 32))))
 (let (($x48747 (= v_2_irs (_ bv9000 32))))
 (let (($x341521 (= v_2_iss v_1_iss)))
 (let (($x459289 (= 4 state_2)))
 (let (($x321079 (not active_1_time_wait)))
 (let (($x325719 (or $x321079 (not (<= due_1_time_wait 900)))))
 (let (($x866309 (or (not active_1_user) (not (<= due_1_user 900)))))
 (let (($x342806 (or (not active_1_rtx) (not (<= due_1_rtx 900)))))
 (let (($x31678 (= 0 v_1_retries)))
 (let (($x70368 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x262557 (= state_1 2)))
 (and $x262557 $x70368 $x31678 $x342806 $x866309 $x325719 $x459289 $x341521 $x48747 $x181932 $x350158 $x966451 $x267490 $x177464 $x51159 (= v_2_rto_ms (ite $x251903 ?x544520 v_1_rto_ms)) $x170817 $x72509 $x105463 $x341262 $x174484 $x44568 $x51230 $x16517 $x147318 $x74379 $x170693 $x884873 $x285719 $x118492 $x113964 $x29758 $x405477 $x135320 $x210124 $x18253 $x224631 $x10991 $x794153 $x4190 $x246900 $x49039 $x78934 $x76677 $x61598 $x157199 $x78281 $x20169 $x35936 $x313817 $x205190 $x435740 $x89315 $x32175 $x16748 $x633685 $x324103 $x431315 $x222105 $x288468 $x431198 $x297271 (= v_2_srtt_ms ?x103633) (= v_2_rttvar_ms ?x145232) (= v_2_rtt_error_ms ?x116489) $x61490 $x233999 (= v_2_rtt_measured (or v_1_rtt_measured $x251903)) $x87505 (= v_2_rtt_active (and v_1_rtt_active (not $x138893))) (= v_2_rtt_ambiguous (and (not $x138893) v_1_rtt_ambiguous)) $x94684 $x142596 (= v_2_rtt_remaining (ite $x138893 0 ?x265662)) $x230608 (= v_2_rtt_sample_used $x251903) $x123965 (= v_2_rtt_last_ms ?x604475) (= v_2_rtt_samples (+ v_1_rtt_samples (ite $x251903 1 0))) (= v_2_rto_base_ms (ite $x251903 ?x544520 v_1_rto_base_ms)) $x818352 $x298591 $x278199 $x364502 $x182820 $x720289 $x84052 $x167156 $x86007 $x112005 $x856490 $x160866 $x324860 $x416425 $x72550 $x248473 $x153809 $x294490 $x275832 $x64244 $x78405 $x79223 $x87704 $x203815 $x238095 $x219624 $x853687 $x348436 $x728830 $x277192 $x30072)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
