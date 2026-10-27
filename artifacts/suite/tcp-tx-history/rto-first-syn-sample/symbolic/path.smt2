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
 (let (($x138874 (= due_1_time_wait due_0_time_wait)))
 (let (($x89306 (= due_1_user 30000)))
 (let (($x395320 (= due_1_rtx 1000)))
 (let (($x161768 (not active_1_time_wait)))
 (let (($x106174 (not v_1_tx_waiting)))
 (let (($x101782 (not v_1_tx_is_fin)))
 (let (($x306617 (= v_1_tx_previous_rto 1000)))
 (let (($x318666 (= v_1_tx_elapsed 0)))
 (let (($x6577 (not v_1_tx_retransmitted)))
 (let (($x300634 (= v_1_tx_max_previous 0)))
 (let (($x326391 (= v_1_tx_eligible 0)))
 (let (($x8686 (= v_1_tx_emit_count 0)))
 (let (($x314638 (= v_1_tx_fin_time 0)))
 (let (($x159652 (= v_1_tx_time_15 0)))
 (let (($x78473 (= v_1_tx_time_14 0)))
 (let (($x395854 (= v_1_tx_time_13 0)))
 (let (($x34378 (= v_1_tx_time_12 0)))
 (let (($x114737 (= v_1_tx_time_11 0)))
 (let (($x64321 (= v_1_tx_time_10 0)))
 (let (($x262954 (= v_1_tx_time_09 0)))
 (let (($x394491 (= v_1_tx_time_08 0)))
 (let (($x163215 (= v_1_tx_time_07 0)))
 (let (($x286722 (= v_1_tx_time_06 0)))
 (let (($x16783 (= v_1_tx_time_05 0)))
 (let (($x52265 (= v_1_tx_time_04 0)))
 (let (($x125370 (= v_1_tx_time_03 0)))
 (let (($x536293 (= v_1_tx_time_02 0)))
 (let (($x20451 (= v_1_tx_time_01 0)))
 (let (($x25499 (= v_1_tx_time_00 0)))
 (let (($x128828 (= v_1_rto_base_ms 1000)))
 (let (($x17434 (= v_1_rtt_samples 0)))
 (let (($x2980 (= v_1_rtt_last_ms 0)))
 (let (($x159968 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x211835 (not v_1_rtt_sample_used)))
 (let (($x46414 (= v_1_rtt_remaining 1)))
 (let (($x198152 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x287193 (= v_1_rtt_start_ms 0)))
 (let (($x64261 (= v_1_rtt_sample_at_ms 0)))
 (let (($x18409 (not v_1_rtt_ambiguous)))
 (let (($x316438 (not v_1_rtt_previous_measured)))
 (let (($x300552 (not v_1_rtt_measured)))
 (let (($x303360 (= v_1_rtt_previous_var 0.0)))
 (let (($x138493 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x82538 (= v_1_rtt_error_ms 0.0)))
 (let (($x182031 (= v_1_rttvar_ms 0.0)))
 (let (($x54096 (= v_1_srtt_ms 0.0)))
 (let (($x94346 (not v_1_rx_fin_consumed)))
 (let (($x7049 (not v_1_rx_fin_done)))
 (let (($x151025 (= v_1_rx_fin_offset 0)))
 (let (($x138480 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x70376 (not v_1_rx_fin_pending)))
 (let (($x147270 (not v_1_fin_acknowledged)))
 (let (($x234838 (= v_1_fin_seq (_ bv0 32))))
 (let (($x152544 (not v_1_fin_sent)))
 (let (($x288203 (not v_1_fin_requested)))
 (let (($x157543 (not v_1_ack_window_update)))
 (let (($x320954 (not v_1_ack_advance)))
 (let (($x158907 (not v_1_ack_is_future)))
 (let (($x298412 (not v_1_ack_is_new)))
 (let (($x176202 (= v_1_ack_delta 0)))
 (let (($x158101 (not v_1_seg_acceptable)))
 (let (($x168173 (not v_1_rx_acceptable)))
 (let (($x161522 (= v_1_rx_advance 0)))
 (let (($x316336 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x12986 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x18614 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x9016 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x30991 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x57445 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x168911 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x96738 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x77295 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x67645 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x147114 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x327451 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x226285 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x70335 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x307350 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x342248 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x21545 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x318045 (= v_1_take 0)))
 (let (($x42683 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x288872 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x134389 (= v_1_snd_wnd 8)))
 (let (($x299085 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x33173 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x31115 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x319241 (= v_1_local_window 16)))
 (let (($x285707 (= v_1_msl_ms 60000)))
 (let (($x197442 (= v_1_user_timeout_ms 30000)))
 (let (($x7692 (= 0 v_1_retries)))
 (let (($x81110 (= 1000 v_1_rto_ms)))
 (let (($x298499 (= v_1_tx_flags "S")))
 (let (($x191347 (= v_1_tx_ack (_ bv0 32))))
 (let (($x99635 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x1361 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x296570 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x77905 (= v_1_snd_una (_ bv1000 32))))
 (let (($x159521 (= v_1_irs (_ bv0 32))))
 (let (($x119921 (= v_1_iss (_ bv1000 32))))
 (let (($x12999 (= 2 state_1)))
 (let (($x314344 (not active_0_time_wait)))
 (let (($x86571 (or $x314344 (not (<= due_0_time_wait 0)))))
 (let (($x8142 (not active_0_user)))
 (let (($x50237 (or $x8142 (not (<= due_0_user 0)))))
 (let (($x302780 (not active_0_rtx)))
 (let (($x197031 (or $x302780 (not (<= due_0_rtx 0)))))
 (let (($x146524 (= state_0 0)))
 (and $x146524 (>= 0 now_0) $x197031 $x50237 $x86571 $x12999 $x119921 $x159521 $x77905 $x296570 $x1361 $x99635 $x191347 $x298499 $x81110 $x7692 v_1_active_open $x197442 $x285707 $x319241 $x31115 $x33173 $x299085 $x134389 $x288872 $x42683 $x318045 $x21545 $x342248 $x307350 $x70335 $x226285 $x327451 $x147114 $x67645 $x77295 $x96738 $x168911 $x57445 $x30991 $x9016 $x18614 $x12986 $x316336 $x161522 $x168173 $x158101 $x176202 $x298412 $x158907 $x320954 $x157543 $x288203 $x152544 $x234838 $x147270 $x70376 $x138480 $x151025 $x7049 $x94346 $x54096 $x182031 $x82538 $x138493 $x303360 $x300552 $x316438 v_1_rtt_active $x18409 $x64261 $x287193 $x198152 $x46414 v_1_rtt_start_new $x211835 $x159968 $x2980 $x17434 $x128828 $x25499 $x20451 $x536293 $x125370 $x52265 $x16783 $x286722 $x163215 $x394491 $x262954 $x64321 $x114737 $x34378 $x395854 $x78473 $x159652 $x314638 $x8686 $x326391 $x300634 $x6577 $x318666 $x306617 $x101782 $x106174 active_1_rtx active_1_user $x161768 $x395320 $x89306 $x138874))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x57402 (= due_2_time_wait due_1_time_wait)))
 (let (($x308244 (= due_2_user due_1_user)))
 (let (($x159693 (= due_2_rtx due_1_rtx)))
 (let (($x308460 (= active_2_time_wait active_1_time_wait)))
 (let (($x316793 (not active_2_user)))
 (let (($x204378 (not active_2_rtx)))
 (let (($x293370 (not v_2_tx_waiting)))
 (let (($x82688 (= v_2_tx_is_fin v_1_tx_is_fin)))
 (let (($x22151 (= v_2_tx_previous_rto v_1_tx_previous_rto)))
 (let (($x41987 (= v_2_tx_elapsed v_1_tx_elapsed)))
 (let (($x53533 (not v_2_tx_retransmitted)))
 (let (($x13735 (= v_2_tx_max_previous v_1_tx_max_previous)))
 (let (($x412906 (= v_2_tx_eligible v_1_tx_eligible)))
 (let (($x159792 (= v_2_tx_emit_count v_1_tx_emit_count)))
 (let ((?x299776 (ite (and v_1_fin_sent (not v_1_fin_acknowledged)) v_1_tx_fin_time 0)))
 (let (($x171487 (= v_2_tx_fin_time ?x299776)))
 (let (($x303983 (= v_2_tx_time_15 (ite (>= 15 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_15))))
 (let (($x184708 (= v_2_tx_time_14 (ite (>= 14 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_14))))
 (let (($x145083 (= v_2_tx_time_13 (ite (>= 13 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_13))))
 (let (($x5925 (= v_2_tx_time_12 (ite (>= 12 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_12))))
 (let (($x308954 (= v_2_tx_time_11 (ite (>= 11 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_11))))
 (let (($x157103 (= v_2_tx_time_10 (ite (>= 10 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_10))))
 (let (($x138282 (= v_2_tx_time_09 (ite (>= 9 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_09))))
 (let (($x308192 (= v_2_tx_time_08 (ite (>= 8 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_08))))
 (let (($x87534 (= v_2_tx_time_07 (ite (>= 7 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_07))))
 (let (($x85921 (= v_2_tx_time_06 (ite (>= 6 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_06))))
 (let (($x306084 (= v_2_tx_time_05 (ite (>= 5 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_05))))
 (let (($x311133 (= v_2_tx_time_04 (ite (>= 4 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_04))))
 (let (($x89874 (= v_2_tx_time_03 (ite (>= 3 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_03))))
 (let (($x157569 (= v_2_tx_time_02 (ite (>= 2 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_02))))
 (let (($x87032 (= v_2_tx_time_01 (ite (>= 1 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_01))))
 (let (($x154643 (= v_2_tx_time_00 (ite (>= 0 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_00))))
 (let ((?x302253 (+ 900 (* (- 1) v_1_rtt_start_ms))))
 (let (($x18409 (not v_1_rtt_ambiguous)))
 (let ((?x301124 (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let ((?x308046 (ubv_to_int (bvadd (_ bv1001 32) (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let (($x221223 (>= ?x308046 ?x301124)))
 (let (($x182453 (and v_1_rtt_active $x221223 $x18409)))
 (let ((?x265469 (ite $x182453 ?x302253 v_1_rtt_last_ms)))
 (let ((?x300363 (to_real ?x265469)))
 (let ((?x60760 (+ v_1_srtt_ms (* (- 1.0) ?x300363))))
 (let ((?x18653 (ite $x182453 (ite (>= ?x60760 0.0) ?x60760 (+ (* (- 1.0) v_1_srtt_ms) ?x300363)) v_1_rtt_error_ms)))
 (let ((?x49246 (* (/ 3.0 4.0) v_1_rttvar_ms)))
 (let ((?x137017 (ite $x182453 (ite v_1_rtt_measured (+ ?x49246 (* (/ 1.0 4.0) ?x18653)) (* (/ 1.0 2.0) ?x300363)) v_1_rttvar_ms)))
 (let ((?x134990 (ite v_1_rtt_measured (+ (* (/ 7.0 8.0) v_1_srtt_ms) (* (/ 1.0 8.0) ?x300363)) ?x300363)))
 (let ((?x304100 (ite $x182453 ?x134990 v_1_srtt_ms)))
 (let ((?x301164 (+ (* (- 1.0) ?x304100) (* (- 1.0) (ite (<= ?x137017 (/ 1.0 4.0)) 1.0 (* 4.0 ?x137017))))))
 (let ((?x101558 (to_int ?x301164)))
 (let ((?x141082 (ite (<= ?x101558 (- 1000)) (* (- 1) ?x101558) 1000)))
 (let ((?x307791 (ite (<= 60000 ?x141082) 60000 ?x141082)))
 (let (($x322198 (= v_2_rtt_sample_was_ambiguous (and v_1_rtt_active v_1_rtt_ambiguous))))
 (let (($x160385 (not v_2_rtt_start_new)))
 (let ((?x6365 (+ ?x301124 (* (- 1) ?x308046))))
 (let ((?x70548 (ite (and v_1_rtt_active (not (<= v_1_rtt_remaining ?x6365))) ?x6365 v_1_rtt_remaining)))
 (let (($x21549 (and v_1_rtt_active $x221223)))
 (let (($x308123 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x12126 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let (($x166988 (= v_2_rtt_previous_measured (ite $x182453 v_1_rtt_measured v_1_rtt_previous_measured))))
 (let (($x443078 (= v_2_rtt_previous_var (ite $x182453 v_1_rttvar_ms v_1_rtt_previous_var))))
 (let (($x81283 (= v_2_rtt_previous_srtt (ite $x182453 v_1_srtt_ms v_1_rtt_previous_srtt))))
 (let (($x153179 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x12496 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x309147 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x300286 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x14138 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x59816 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x136317 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x30608 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x314899 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x16095 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x311813 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x58884 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x202389 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x60369 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x83856 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x297159 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x52973 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x154466 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x45475 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x81554 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x87381 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x291244 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x320155 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x18248 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x27821 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x309112 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x187696 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x150429 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x43022 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x26492 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x55575 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x20323 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x309228 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x137072 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x83443 (= v_2_take v_1_take)))
 (let (($x18611 (= v_2_snd_wl2 (_ bv1001 32))))
 (let (($x193516 (= v_2_snd_wl1 (_ bv9000 32))))
 (let (($x94522 (= v_2_snd_wnd 16)))
 (let (($x295248 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x320637 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x198911 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x4089 (= v_2_local_window v_1_local_window)))
 (let (($x56432 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x63953 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x170513 (= v_2_active_open v_1_active_open)))
 (let (($x151900 (= v_2_retries v_1_retries)))
 (let (($x66576 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x83330 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x16493 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x63961 (= v_2_rcv_nxt (_ bv9001 32))))
 (let (($x118530 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x34062 (= v_2_snd_una (_ bv1001 32))))
 (let (($x315827 (= v_2_irs (_ bv9000 32))))
 (let (($x74372 (= v_2_iss v_1_iss)))
 (let (($x161400 (= 4 state_2)))
 (let (($x161768 (not active_1_time_wait)))
 (let (($x388982 (or $x161768 (not (<= due_1_time_wait 900)))))
 (let (($x35063 (or (not active_1_user) (not (<= due_1_user 900)))))
 (let (($x197906 (or (not active_1_rtx) (not (<= due_1_rtx 900)))))
 (let (($x7692 (= 0 v_1_retries)))
 (let (($x296570 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x314646 (= state_1 2)))
 (and $x314646 $x296570 $x7692 $x197906 $x35063 $x388982 $x161400 $x74372 $x315827 $x34062 $x118530 $x63961 $x16493 $x83330 $x66576 (= v_2_rto_ms (ite $x182453 ?x307791 v_1_rto_ms)) $x151900 $x170513 $x63953 $x56432 $x4089 $x198911 $x320637 $x295248 $x94522 $x193516 $x18611 $x83443 $x137072 $x309228 $x20323 $x55575 $x26492 $x43022 $x150429 $x187696 $x309112 $x27821 $x18248 $x320155 $x291244 $x87381 $x81554 $x45475 $x154466 $x52973 $x297159 $x83856 $x60369 $x202389 $x58884 $x311813 $x16095 $x314899 $x30608 $x136317 $x59816 $x14138 $x300286 $x309147 $x12496 $x153179 (= v_2_srtt_ms ?x304100) (= v_2_rttvar_ms ?x137017) (= v_2_rtt_error_ms ?x18653) $x81283 $x443078 (= v_2_rtt_measured (or v_1_rtt_measured $x182453)) $x166988 (= v_2_rtt_active (and v_1_rtt_active (not $x21549))) (= v_2_rtt_ambiguous (and (not $x21549) v_1_rtt_ambiguous)) (= v_2_rtt_sample_at_ms (ite $x182453 900 v_1_rtt_sample_at_ms)) $x12126 $x308123 (= v_2_rtt_remaining (ite $x21549 0 ?x70548)) $x160385 (= v_2_rtt_sample_used $x182453) $x322198 (= v_2_rtt_last_ms ?x265469) (= v_2_rtt_samples (+ v_1_rtt_samples (ite $x182453 1 0))) (= v_2_rto_base_ms (ite $x182453 ?x307791 v_1_rto_base_ms)) $x154643 $x87032 $x157569 $x89874 $x311133 $x306084 $x85921 $x87534 $x308192 $x138282 $x157103 $x308954 $x5925 $x145083 $x184708 $x303983 $x171487 $x159792 $x412906 $x13735 $x53533 $x41987 $x22151 $x82688 $x293370 $x204378 $x316793 $x308460 $x159693 $x308244 $x57402))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
