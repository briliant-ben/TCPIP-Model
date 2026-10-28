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
(declare-fun due_3_time_wait () Int)
(declare-fun due_3_user () Int)
(declare-fun due_3_rtx () Int)
(declare-fun active_3_time_wait () Bool)
(declare-fun active_3_user () Bool)
(declare-fun active_3_rtx () Bool)
(declare-fun v_3_rto_base_ms () Int)
(declare-fun v_3_rtt_samples () Int)
(declare-fun v_3_rtt_last_ms () Int)
(declare-fun v_3_rtt_sample_was_ambiguous () Bool)
(declare-fun v_3_rtt_sample_used () Bool)
(declare-fun v_3_rtt_start_new () Bool)
(declare-fun v_3_rtt_remaining () Int)
(declare-fun v_3_rtt_end () (_ BitVec 32))
(declare-fun v_3_rtt_start_ms () Int)
(declare-fun v_3_rtt_sample_at_ms () Int)
(declare-fun v_3_rtt_ambiguous () Bool)
(declare-fun v_3_rtt_active () Bool)
(declare-fun v_3_rtt_previous_measured () Bool)
(declare-fun v_3_rtt_measured () Bool)
(declare-fun v_3_rtt_previous_var () Real)
(declare-fun v_3_rtt_previous_srtt () Real)
(declare-fun v_3_rtt_error_ms () Real)
(declare-fun v_3_rttvar_ms () Real)
(declare-fun v_3_srtt_ms () Real)
(declare-fun v_3_rx_fin_consumed () Bool)
(declare-fun v_3_rx_fin_done () Bool)
(declare-fun v_3_rx_fin_offset () Int)
(declare-fun v_3_rx_fin_seq () (_ BitVec 32))
(declare-fun v_3_rx_fin_pending () Bool)
(declare-fun v_3_fin_acknowledged () Bool)
(declare-fun v_3_fin_seq () (_ BitVec 32))
(declare-fun v_3_fin_sent () Bool)
(declare-fun v_3_fin_requested () Bool)
(declare-fun v_3_ack_window_update () Bool)
(declare-fun v_3_ack_advance () Bool)
(declare-fun v_3_ack_is_future () Bool)
(declare-fun v_3_ack_is_new () Bool)
(declare-fun v_3_ack_delta () Int)
(declare-fun v_3_seg_acceptable () Bool)
(declare-fun v_3_rx_acceptable () Bool)
(declare-fun v_3_rx_advance () Int)
(declare-fun v_3_rx_slot_15 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_14 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_13 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_12 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_11 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_10 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_09 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_08 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_07 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_06 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_05 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_04 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_03 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_02 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_01 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_slot_00 () (Seq (_ BitVec 8)))
(declare-fun v_3_rx_chunk () (Seq (_ BitVec 8)))
(declare-fun v_3_take () Int)
(declare-fun v_3_snd_wl2 () (_ BitVec 32))
(declare-fun v_3_snd_wl1 () (_ BitVec 32))
(declare-fun v_3_snd_wnd () Int)
(declare-fun v_3_rcv_buf () (Seq (_ BitVec 8)))
(declare-fun v_3_rtx_buf () (Seq (_ BitVec 8)))
(declare-fun v_3_snd_buf () (Seq (_ BitVec 8)))
(declare-fun v_3_local_window () Int)
(declare-fun v_3_msl_ms () Int)
(declare-fun v_3_user_timeout_ms () Int)
(declare-fun v_3_active_open () Bool)
(declare-fun v_3_retries () Int)
(declare-fun v_3_rto_ms () Int)
(declare-fun v_3_tx_flags () String)
(declare-fun v_3_tx_ack () (_ BitVec 32))
(declare-fun v_3_tx_seq () (_ BitVec 32))
(declare-fun v_3_rcv_nxt () (_ BitVec 32))
(declare-fun v_3_snd_nxt () (_ BitVec 32))
(declare-fun v_3_snd_una () (_ BitVec 32))
(declare-fun v_3_irs () (_ BitVec 32))
(declare-fun v_3_iss () (_ BitVec 32))
(declare-fun state_3 () Int)
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
(declare-fun choice_0 () Int)
(declare-fun now_1 () Int)
(declare-fun choice_1 () Int)
(declare-fun now_2 () Int)
(declare-fun choice_2 () Int)
(declare-fun now_3 () Int)
(declare-fun input_2_net.synack_seq () (_ BitVec 32))
(declare-fun input_2_net.synack_ack () (_ BitVec 32))
(declare-fun input_2_net.synack_window () Int)
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
 (let (($x8092 (= due_1_time_wait due_0_time_wait)))
 (let (($x74390 (= due_1_user 30000)))
 (let (($x44100 (= due_1_rtx 1000)))
 (let (($x168858 (not active_1_time_wait)))
 (let (($x74287 (= v_1_rto_base_ms 1000)))
 (let (($x151547 (= v_1_rtt_samples 0)))
 (let (($x296267 (= v_1_rtt_last_ms 0)))
 (let (($x64164 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x136666 (not v_1_rtt_sample_used)))
 (let (($x150841 (= v_1_rtt_remaining 1)))
 (let (($x169665 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x159416 (= v_1_rtt_start_ms 0)))
 (let (($x163262 (= v_1_rtt_sample_at_ms 0)))
 (let (($x130538 (not v_1_rtt_ambiguous)))
 (let (($x158260 (not v_1_rtt_previous_measured)))
 (let (($x296758 (not v_1_rtt_measured)))
 (let (($x165014 (= v_1_rtt_previous_var 0.0)))
 (let (($x158262 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x160012 (= v_1_rtt_error_ms 0.0)))
 (let (($x206104 (= v_1_rttvar_ms 0.0)))
 (let (($x179287 (= v_1_srtt_ms 0.0)))
 (let (($x157722 (not v_1_rx_fin_consumed)))
 (let (($x14035 (not v_1_rx_fin_done)))
 (let (($x19454 (= v_1_rx_fin_offset 0)))
 (let (($x65863 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x69518 (not v_1_rx_fin_pending)))
 (let (($x30842 (not v_1_fin_acknowledged)))
 (let (($x68509 (= v_1_fin_seq (_ bv0 32))))
 (let (($x151658 (not v_1_fin_sent)))
 (let (($x18768 (not v_1_fin_requested)))
 (let (($x157701 (not v_1_ack_window_update)))
 (let (($x163208 (not v_1_ack_advance)))
 (let (($x71203 (not v_1_ack_is_future)))
 (let (($x137888 (not v_1_ack_is_new)))
 (let (($x15731 (= v_1_ack_delta 0)))
 (let (($x34006 (not v_1_seg_acceptable)))
 (let (($x61526 (not v_1_rx_acceptable)))
 (let (($x159467 (= v_1_rx_advance 0)))
 (let (($x6165 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x22435 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x148785 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x95161 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x16771 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x50182 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x1783 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x155191 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x167142 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x171977 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x146316 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x161868 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x70912 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x138781 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x12617 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x93683 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x13350 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x167300 (= v_1_take 0)))
 (let (($x153346 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x303123 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x303080 (= v_1_snd_wnd 8)))
 (let (($x23757 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x27051 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x6331 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x53791 (= v_1_local_window 16)))
 (let (($x156491 (= v_1_msl_ms 60000)))
 (let (($x67884 (= v_1_user_timeout_ms 30000)))
 (let (($x39584 (= 0 v_1_retries)))
 (let (($x139638 (= 1000 v_1_rto_ms)))
 (let (($x19283 (= v_1_tx_flags "S")))
 (let (($x81958 (= v_1_tx_ack (_ bv0 32))))
 (let (($x45215 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x39333 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x46919 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x159670 (= v_1_snd_una (_ bv1000 32))))
 (let (($x161112 (= v_1_irs (_ bv0 32))))
 (let (($x287274 (= v_1_iss (_ bv1000 32))))
 (let (($x52775 (= 2 state_1)))
 (let (($x55001 (not active_0_time_wait)))
 (let (($x43314 (or $x55001 (not (<= due_0_time_wait 0)))))
 (let (($x157356 (not active_0_user)))
 (let (($x145847 (or $x157356 (not (<= due_0_user 0)))))
 (let (($x72762 (not active_0_rtx)))
 (let (($x162085 (or $x72762 (not (<= due_0_rtx 0)))))
 (let (($x28562 (= state_0 0)))
 (and $x28562 (>= 0 now_0) $x162085 $x145847 $x43314 $x52775 $x287274 $x161112 $x159670 $x46919 $x39333 $x45215 $x81958 $x19283 $x139638 $x39584 v_1_active_open $x67884 $x156491 $x53791 $x6331 $x27051 $x23757 $x303080 $x303123 $x153346 $x167300 $x13350 $x93683 $x12617 $x138781 $x70912 $x161868 $x146316 $x171977 $x167142 $x155191 $x1783 $x50182 $x16771 $x95161 $x148785 $x22435 $x6165 $x159467 $x61526 $x34006 $x15731 $x137888 $x71203 $x163208 $x157701 $x18768 $x151658 $x68509 $x30842 $x69518 $x65863 $x19454 $x14035 $x157722 $x179287 $x206104 $x160012 $x158262 $x165014 $x296758 $x158260 v_1_rtt_active $x130538 $x163262 $x159416 $x169665 $x150841 v_1_rtt_start_new $x136666 $x64164 $x296267 $x151547 $x74287 active_1_rtx active_1_user $x168858 $x44100 $x74390 $x8092)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x15419 (= due_2_time_wait due_1_time_wait)))
 (let (($x11175 (= due_2_user due_1_user)))
 (let (($x54698 (= due_2_rtx (+ 1000 (ite (>= v_1_rto_ms 30000) 60000 (* 2 v_1_rto_ms))))))
 (let (($x137284 (= active_2_time_wait active_1_time_wait)))
 (let (($x158571 (= active_2_user active_1_user)))
 (let (($x161848 (= v_2_rto_base_ms v_1_rto_base_ms)))
 (let (($x30651 (= v_2_rtt_samples v_1_rtt_samples)))
 (let (($x163728 (= v_2_rtt_last_ms v_1_rtt_last_ms)))
 (let (($x42829 (not v_2_rtt_sample_was_ambiguous)))
 (let (($x154345 (not v_2_rtt_sample_used)))
 (let (($x44712 (not v_2_rtt_start_new)))
 (let (($x19995 (= v_2_rtt_remaining v_1_rtt_remaining)))
 (let (($x13885 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x48751 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let (($x71385 (= v_2_rtt_sample_at_ms v_1_rtt_sample_at_ms)))
 (let ((?x150712 (+ (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una))) (* (- 1) v_1_rtt_remaining))))
 (let (($x16668 (= v_2_rtt_ambiguous (or (and v_1_rtt_active (<= ?x150712 0)) v_1_rtt_ambiguous))))
 (let (($x43305 (= v_2_rtt_active v_1_rtt_active)))
 (let (($x62569 (= v_2_rtt_previous_measured v_1_rtt_previous_measured)))
 (let (($x25213 (= v_2_rtt_measured v_1_rtt_measured)))
 (let (($x49278 (= v_2_rtt_previous_var v_1_rtt_previous_var)))
 (let (($x164420 (= v_2_rtt_previous_srtt v_1_rtt_previous_srtt)))
 (let (($x71399 (= v_2_rtt_error_ms v_1_rtt_error_ms)))
 (let (($x83519 (= v_2_rttvar_ms v_1_rttvar_ms)))
 (let (($x55112 (= v_2_srtt_ms v_1_srtt_ms)))
 (let (($x25492 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x34516 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x167628 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x30153 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x9867 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x159192 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x167643 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x12218 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x96053 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x139458 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x148760 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x39450 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x147327 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x51626 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x6927 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x158585 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x138396 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x280553 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x161058 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x16790 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x146805 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x25041 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x67809 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x160446 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x62564 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x138377 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x147334 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x52863 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x19907 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x44838 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x158636 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x48593 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x35531 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x63095 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x134614 (= v_2_take v_1_take)))
 (let (($x300030 (= v_2_snd_wl2 v_1_snd_wl2)))
 (let (($x65635 (= v_2_snd_wl1 v_1_snd_wl1)))
 (let (($x395668 (= v_2_snd_wnd v_1_snd_wnd)))
 (let (($x61286 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x47224 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x151599 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x22482 (= v_2_local_window v_1_local_window)))
 (let (($x150567 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x138669 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x729 (= v_2_active_open v_1_active_open)))
 (let ((?x7141 (ite (>= v_1_rto_ms 30000) 60000 (* 2 v_1_rto_ms))))
 (let (($x73664 (= v_2_rto_ms ?x7141)))
 (let (($x153270 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x146942 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x153721 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x135535 (= v_2_rcv_nxt v_1_rcv_nxt)))
 (let (($x5102 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x13426 (= v_2_snd_una v_1_snd_una)))
 (let (($x74701 (= v_2_irs v_1_irs)))
 (let (($x286645 (= v_2_iss v_1_iss)))
 (let (($x39119 (= 2 state_2)))
 (let (($x152480 (= state_1 2)))
 (and $x152480 active_1_rtx (= 1000 due_1_rtx) (or (not active_1_user) (<= due_1_rtx due_1_user)) (or (not active_1_time_wait) (<= due_1_rtx due_1_time_wait)) $x39119 $x286645 $x74701 $x13426 $x5102 $x135535 $x153721 $x146942 $x153270 $x73664 (= v_2_retries (+ 1 v_1_retries)) $x729 $x138669 $x150567 $x22482 $x151599 $x47224 $x61286 $x395668 $x65635 $x300030 $x134614 $x63095 $x35531 $x48593 $x158636 $x44838 $x19907 $x52863 $x147334 $x138377 $x62564 $x160446 $x67809 $x25041 $x146805 $x16790 $x161058 $x280553 $x138396 $x158585 $x6927 $x51626 $x147327 $x39450 $x148760 $x139458 $x96053 $x12218 $x167643 $x159192 $x9867 $x30153 $x167628 $x34516 $x25492 $x55112 $x83519 $x71399 $x164420 $x49278 $x25213 $x62569 $x43305 $x16668 $x71385 $x48751 $x13885 $x19995 $x44712 $x154345 $x42829 $x163728 $x30651 $x161848 active_2_rtx $x158571 $x137284 $x54698 $x11175 $x15419))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 (let (($x32655 (= due_3_time_wait due_2_time_wait)))
 (let (($x34193 (= due_3_user due_2_user)))
 (let (($x41989 (= due_3_rtx due_2_rtx)))
 (let (($x3952 (= active_3_time_wait active_2_time_wait)))
 (let (($x69210 (not active_3_user)))
 (let (($x67587 (not active_3_rtx)))
 (let ((?x49233 (+ 1010 (* (- 1) v_2_rtt_start_ms))))
 (let (($x150053 (not v_2_rtt_ambiguous)))
 (let ((?x72374 (ubv_to_int (bvadd v_2_rtt_end (bvmul (_ bv4294967295 32) v_2_snd_una)))))
 (let ((?x50407 (ubv_to_int (bvadd (_ bv1001 32) (bvmul (_ bv4294967295 32) v_2_snd_una)))))
 (let (($x67094 (>= ?x50407 ?x72374)))
 (let (($x14235 (and v_2_rtt_active $x67094 $x150053)))
 (let ((?x70086 (ite $x14235 ?x49233 v_2_rtt_last_ms)))
 (let ((?x49135 (to_real ?x70086)))
 (let ((?x172266 (+ v_2_srtt_ms (* (- 1.0) ?x49135))))
 (let ((?x29746 (ite $x14235 (ite (>= ?x172266 0.0) ?x172266 (+ (* (- 1.0) v_2_srtt_ms) ?x49135)) v_2_rtt_error_ms)))
 (let ((?x40716 (* (/ 3.0 4.0) v_2_rttvar_ms)))
 (let ((?x32895 (ite $x14235 (ite v_2_rtt_measured (+ ?x40716 (* (/ 1.0 4.0) ?x29746)) (* (/ 1.0 2.0) ?x49135)) v_2_rttvar_ms)))
 (let ((?x37705 (ite v_2_rtt_measured (+ (* (/ 7.0 8.0) v_2_srtt_ms) (* (/ 1.0 8.0) ?x49135)) ?x49135)))
 (let ((?x16958 (ite $x14235 ?x37705 v_2_srtt_ms)))
 (let ((?x19324 (+ (* (- 1.0) ?x16958) (* (- 1.0) (ite (<= ?x32895 (/ 1.0 4.0)) 1.0 (* 4.0 ?x32895))))))
 (let ((?x170014 (to_int ?x19324)))
 (let ((?x25301 (ite (<= ?x170014 (- 1000)) (* (- 1) ?x170014) 1000)))
 (let (($x47863 (= v_3_rto_base_ms (ite $x14235 (ite (<= 60000 ?x25301) 60000 ?x25301) v_2_rto_base_ms))))
 (let (($x3599 (= v_3_rtt_sample_was_ambiguous (and v_2_rtt_active v_2_rtt_ambiguous))))
 (let (($x6615 (not v_3_rtt_start_new)))
 (let ((?x45920 (* (- 1) ?x50407)))
 (let ((?x158052 (+ ?x72374 ?x45920)))
 (let ((?x52074 (ite (and v_2_rtt_active (not (<= v_2_rtt_remaining ?x158052))) ?x158052 v_2_rtt_remaining)))
 (let (($x111450 (and v_2_rtt_active $x67094)))
 (let (($x58856 (= v_3_rtt_end v_2_rtt_end)))
 (let (($x181014 (= v_3_rtt_start_ms v_2_rtt_start_ms)))
 (let (($x171887 (= v_3_rtt_previous_measured (ite $x14235 v_2_rtt_measured v_2_rtt_previous_measured))))
 (let (($x26645 (= v_3_rtt_previous_var (ite $x14235 v_2_rttvar_ms v_2_rtt_previous_var))))
 (let (($x175432 (= v_3_rtt_previous_srtt (ite $x14235 v_2_srtt_ms v_2_rtt_previous_srtt))))
 (let (($x36887 (= v_3_rx_fin_consumed v_2_rx_fin_consumed)))
 (let (($x58367 (= v_3_rx_fin_done v_2_rx_fin_done)))
 (let (($x159214 (= v_3_rx_fin_offset v_2_rx_fin_offset)))
 (let (($x95357 (= v_3_rx_fin_seq v_2_rx_fin_seq)))
 (let (($x148449 (= v_3_rx_fin_pending v_2_rx_fin_pending)))
 (let (($x149649 (= v_3_fin_acknowledged v_2_fin_acknowledged)))
 (let (($x299485 (= v_3_fin_seq v_2_fin_seq)))
 (let (($x28601 (= v_3_fin_sent v_2_fin_sent)))
 (let (($x64106 (= v_3_fin_requested v_2_fin_requested)))
 (let (($x42347 (= v_3_ack_window_update v_2_ack_window_update)))
 (let (($x154075 (= v_3_ack_advance v_2_ack_advance)))
 (let (($x53473 (= v_3_ack_is_future v_2_ack_is_future)))
 (let (($x16036 (= v_3_ack_is_new v_2_ack_is_new)))
 (let (($x55509 (= v_3_ack_delta v_2_ack_delta)))
 (let (($x31191 (= v_3_seg_acceptable v_2_seg_acceptable)))
 (let (($x6382 (= v_3_rx_acceptable v_2_rx_acceptable)))
 (let (($x172141 (= v_3_rx_advance v_2_rx_advance)))
 (let (($x153262 (= v_3_rx_slot_15 v_2_rx_slot_15)))
 (let (($x163695 (= v_3_rx_slot_14 v_2_rx_slot_14)))
 (let (($x172305 (= v_3_rx_slot_13 v_2_rx_slot_13)))
 (let (($x22706 (= v_3_rx_slot_12 v_2_rx_slot_12)))
 (let (($x256826 (= v_3_rx_slot_11 v_2_rx_slot_11)))
 (let (($x169485 (= v_3_rx_slot_10 v_2_rx_slot_10)))
 (let (($x284669 (= v_3_rx_slot_09 v_2_rx_slot_09)))
 (let (($x148183 (= v_3_rx_slot_08 v_2_rx_slot_08)))
 (let (($x89189 (= v_3_rx_slot_07 v_2_rx_slot_07)))
 (let (($x158161 (= v_3_rx_slot_06 v_2_rx_slot_06)))
 (let (($x88395 (= v_3_rx_slot_05 v_2_rx_slot_05)))
 (let (($x163241 (= v_3_rx_slot_04 v_2_rx_slot_04)))
 (let (($x54039 (= v_3_rx_slot_03 v_2_rx_slot_03)))
 (let (($x64525 (= v_3_rx_slot_02 v_2_rx_slot_02)))
 (let (($x155429 (= v_3_rx_slot_01 v_2_rx_slot_01)))
 (let (($x22603 (= v_3_rx_slot_00 v_2_rx_slot_00)))
 (let (($x163213 (= v_3_rx_chunk v_2_rx_chunk)))
 (let (($x151272 (= v_3_take v_2_take)))
 (let (($x5035 (= v_3_snd_wl2 (_ bv1001 32))))
 (let (($x13604 (= v_3_snd_wl1 (_ bv9000 32))))
 (let (($x153034 (= v_3_snd_wnd 16)))
 (let (($x168493 (= v_3_rcv_buf v_2_rcv_buf)))
 (let (($x47507 (= v_3_rtx_buf v_2_rtx_buf)))
 (let (($x85505 (= v_3_snd_buf v_2_snd_buf)))
 (let (($x21750 (= v_3_local_window v_2_local_window)))
 (let (($x2941 (= v_3_msl_ms v_2_msl_ms)))
 (let (($x36554 (= v_3_user_timeout_ms v_2_user_timeout_ms)))
 (let (($x154128 (= v_3_active_open v_2_active_open)))
 (let (($x28766 (= v_3_retries v_2_retries)))
 (let (($x39938 (= 3000 v_3_rto_ms)))
 (let (($x160843 (= v_3_tx_flags v_2_tx_flags)))
 (let (($x146857 (= v_3_tx_ack v_2_tx_ack)))
 (let (($x55152 (= v_3_tx_seq v_2_tx_seq)))
 (let (($x46777 (= v_3_rcv_nxt (_ bv9001 32))))
 (let (($x81992 (= v_3_snd_nxt v_2_snd_nxt)))
 (let (($x28608 (= v_3_snd_una (_ bv1001 32))))
 (let (($x139575 (= v_3_irs (_ bv9000 32))))
 (let (($x39607 (= v_3_iss v_2_iss)))
 (let (($x9433 (= 4 state_3)))
 (let (($x292881 (or (not active_2_time_wait) (not (<= due_2_time_wait 1010)))))
 (let (($x71627 (or (not active_2_user) (not (<= due_2_user 1010)))))
 (let (($x139023 (or (not active_2_rtx) (not (<= due_2_rtx 1010)))))
 (let (($x97519 (= 1 v_2_retries)))
 (let (($x161668 (= v_2_snd_nxt (_ bv1001 32))))
 (let (($x26399 (= state_2 2)))
 (and $x26399 $x161668 $x97519 $x139023 $x71627 $x292881 $x9433 $x39607 $x139575 $x28608 $x81992 $x46777 $x55152 $x146857 $x160843 $x39938 $x28766 $x154128 $x36554 $x2941 $x21750 $x85505 $x47507 $x168493 $x153034 $x13604 $x5035 $x151272 $x163213 $x22603 $x155429 $x64525 $x54039 $x163241 $x88395 $x158161 $x89189 $x148183 $x284669 $x169485 $x256826 $x22706 $x172305 $x163695 $x153262 $x172141 $x6382 $x31191 $x55509 $x16036 $x53473 $x154075 $x42347 $x64106 $x28601 $x299485 $x149649 $x148449 $x95357 $x159214 $x58367 $x36887 (= v_3_srtt_ms ?x16958) (= v_3_rttvar_ms ?x32895) (= v_3_rtt_error_ms ?x29746) $x175432 $x26645 (= v_3_rtt_measured (or v_2_rtt_measured $x14235)) $x171887 (= v_3_rtt_active (and v_2_rtt_active (not $x111450))) (= v_3_rtt_ambiguous (and (not $x111450) v_2_rtt_ambiguous)) (= v_3_rtt_sample_at_ms (ite $x14235 1010 v_2_rtt_sample_at_ms)) $x181014 $x58856 (= v_3_rtt_remaining (ite $x111450 0 ?x52074)) $x6615 (= v_3_rtt_sample_used $x14235) $x3599 (= v_3_rtt_last_ms ?x70086) (= v_3_rtt_samples (+ v_2_rtt_samples (ite $x14235 1 0))) $x47863 $x67587 $x69210 $x3952 $x41989 $x34193 $x32655)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
 (= 0 choice_0))
(assert
 (= 0 now_1))
(assert
 (= 27 choice_1))
(assert
 (= 1000 now_2))
(assert
 (= 7 choice_2))
(assert
 (= 1010 now_3))
(assert
 (= (_ bv9000 32) input_2_net.synack_seq))
(assert
 (= (_ bv1001 32) input_2_net.synack_ack))
(assert
 (= 16 input_2_net.synack_window))
(check-sat)
