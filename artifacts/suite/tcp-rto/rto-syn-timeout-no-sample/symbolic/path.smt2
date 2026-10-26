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
 (let (($x162695 (= due_1_time_wait due_0_time_wait)))
 (let (($x123429 (= due_1_user 30000)))
 (let (($x341765 (= due_1_rtx 1000)))
 (let (($x316161 (not active_1_time_wait)))
 (let (($x135030 (= v_1_rto_base_ms 1000)))
 (let (($x11217 (= v_1_rtt_samples 0)))
 (let (($x192764 (= v_1_rtt_last_ms 0)))
 (let (($x310303 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x338178 (not v_1_rtt_sample_used)))
 (let (($x53038 (= v_1_rtt_remaining 1)))
 (let (($x185822 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x87158 (= v_1_rtt_start_ms 0)))
 (let (($x171616 (not v_1_rtt_ambiguous)))
 (let (($x21835 (not v_1_rtt_previous_measured)))
 (let (($x343943 (not v_1_rtt_measured)))
 (let (($x110945 (= v_1_rtt_previous_var 0.0)))
 (let (($x121221 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x293122 (= v_1_rtt_error_ms 0.0)))
 (let (($x348105 (= v_1_rttvar_ms 0.0)))
 (let (($x305371 (= v_1_srtt_ms 0.0)))
 (let (($x284832 (not v_1_rx_fin_consumed)))
 (let (($x94183 (not v_1_rx_fin_done)))
 (let (($x418147 (= v_1_rx_fin_offset 0)))
 (let (($x22825 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x27657 (not v_1_rx_fin_pending)))
 (let (($x10675 (not v_1_fin_acknowledged)))
 (let (($x248204 (= v_1_fin_seq (_ bv0 32))))
 (let (($x12955 (not v_1_fin_sent)))
 (let (($x343238 (not v_1_fin_requested)))
 (let (($x299673 (not v_1_ack_window_update)))
 (let (($x328207 (not v_1_ack_advance)))
 (let (($x289009 (not v_1_ack_is_future)))
 (let (($x326250 (not v_1_ack_is_new)))
 (let (($x141619 (= v_1_ack_delta 0)))
 (let (($x57252 (not v_1_seg_acceptable)))
 (let (($x143003 (not v_1_rx_acceptable)))
 (let (($x301344 (= v_1_rx_advance 0)))
 (let (($x165520 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x10485 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x127420 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x329408 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x280715 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x109754 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x347404 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x247104 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x77794 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x33592 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x54293 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x92620 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x332899 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x181618 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x154293 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x167286 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x79792 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x135048 (= v_1_take 0)))
 (let (($x314575 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x337266 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x301146 (= v_1_snd_wnd 8)))
 (let (($x308213 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x41212 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x10776 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x305535 (= v_1_local_window 16)))
 (let (($x128010 (= v_1_msl_ms 60000)))
 (let (($x316700 (= v_1_user_timeout_ms 30000)))
 (let (($x294099 (= 0 v_1_retries)))
 (let (($x177299 (= 1000 v_1_rto_ms)))
 (let (($x113195 (= v_1_tx_flags "S")))
 (let (($x105221 (= v_1_tx_ack (_ bv0 32))))
 (let (($x321095 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x431791 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x35012 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x5096 (= v_1_snd_una (_ bv1000 32))))
 (let (($x156784 (= v_1_irs (_ bv0 32))))
 (let (($x117933 (= v_1_iss (_ bv1000 32))))
 (let (($x323504 (= 2 state_1)))
 (let (($x125536 (not active_0_time_wait)))
 (let (($x108977 (or $x125536 (not (<= due_0_time_wait 0)))))
 (let (($x296945 (not active_0_user)))
 (let (($x308572 (or $x296945 (not (<= due_0_user 0)))))
 (let (($x255376 (not active_0_rtx)))
 (let (($x27467 (or $x255376 (not (<= due_0_rtx 0)))))
 (let (($x76890 (= state_0 0)))
 (and $x76890 (>= 0 now_0) $x27467 $x308572 $x108977 $x323504 $x117933 $x156784 $x5096 $x35012 $x431791 $x321095 $x105221 $x113195 $x177299 $x294099 v_1_active_open $x316700 $x128010 $x305535 $x10776 $x41212 $x308213 $x301146 $x337266 $x314575 $x135048 $x79792 $x167286 $x154293 $x181618 $x332899 $x92620 $x54293 $x33592 $x77794 $x247104 $x347404 $x109754 $x280715 $x329408 $x127420 $x10485 $x165520 $x301344 $x143003 $x57252 $x141619 $x326250 $x289009 $x328207 $x299673 $x343238 $x12955 $x248204 $x10675 $x27657 $x22825 $x418147 $x94183 $x284832 $x305371 $x348105 $x293122 $x121221 $x110945 $x343943 $x21835 v_1_rtt_active $x171616 $x87158 $x185822 $x53038 v_1_rtt_start_new $x338178 $x310303 $x192764 $x11217 $x135030 active_1_rtx active_1_user $x316161 $x341765 $x123429 $x162695))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 (let (($x324672 (= due_2_time_wait due_1_time_wait)))
 (let (($x151980 (= due_2_user due_1_user)))
 (let (($x350961 (= due_2_rtx (+ 1000 (ite (>= v_1_rto_ms 30000) 60000 (* 2 v_1_rto_ms))))))
 (let (($x1043 (= active_2_time_wait active_1_time_wait)))
 (let (($x241668 (= active_2_user active_1_user)))
 (let (($x308400 (= v_2_rto_base_ms v_1_rto_base_ms)))
 (let (($x327281 (= v_2_rtt_samples v_1_rtt_samples)))
 (let (($x288535 (= v_2_rtt_last_ms v_1_rtt_last_ms)))
 (let (($x165633 (not v_2_rtt_sample_was_ambiguous)))
 (let (($x406576 (not v_2_rtt_sample_used)))
 (let (($x173217 (not v_2_rtt_start_new)))
 (let (($x298202 (= v_2_rtt_remaining v_1_rtt_remaining)))
 (let (($x82047 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x302910 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let ((?x320110 (+ (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una))) (* (- 1) v_1_rtt_remaining))))
 (let (($x338179 (= v_2_rtt_ambiguous (or v_1_rtt_ambiguous (and v_1_rtt_active (<= ?x320110 0))))))
 (let (($x42803 (= v_2_rtt_active v_1_rtt_active)))
 (let (($x27140 (= v_2_rtt_previous_measured v_1_rtt_previous_measured)))
 (let (($x290296 (= v_2_rtt_measured v_1_rtt_measured)))
 (let (($x336391 (= v_2_rtt_previous_var v_1_rtt_previous_var)))
 (let (($x297344 (= v_2_rtt_previous_srtt v_1_rtt_previous_srtt)))
 (let (($x85306 (= v_2_rtt_error_ms v_1_rtt_error_ms)))
 (let (($x289728 (= v_2_rttvar_ms v_1_rttvar_ms)))
 (let (($x65156 (= v_2_srtt_ms v_1_srtt_ms)))
 (let (($x407566 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x301156 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x153777 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x141394 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x54359 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x78208 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x86316 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x140115 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x172356 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x77480 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x103065 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x338112 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x233450 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x434716 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x233437 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x307530 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x433796 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x16104 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x326855 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x57625 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x307843 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x87997 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x85574 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x199332 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x308462 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x101782 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x333068 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x131911 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x21294 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x80964 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x187394 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x323732 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x171506 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x24973 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x301678 (= v_2_take v_1_take)))
 (let (($x346657 (= v_2_snd_wl2 v_1_snd_wl2)))
 (let (($x192761 (= v_2_snd_wl1 v_1_snd_wl1)))
 (let (($x189850 (= v_2_snd_wnd v_1_snd_wnd)))
 (let (($x175092 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x299103 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x212197 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x193984 (= v_2_local_window v_1_local_window)))
 (let (($x67171 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x334738 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x92345 (= v_2_active_open v_1_active_open)))
 (let ((?x299110 (ite (>= v_1_rto_ms 30000) 60000 (* 2 v_1_rto_ms))))
 (let (($x31864 (= v_2_rto_ms ?x299110)))
 (let (($x293940 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x342082 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x140910 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x322785 (= v_2_rcv_nxt v_1_rcv_nxt)))
 (let (($x322996 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x426980 (= v_2_snd_una v_1_snd_una)))
 (let (($x90872 (= v_2_irs v_1_irs)))
 (let (($x286882 (= v_2_iss v_1_iss)))
 (let (($x328375 (= 2 state_2)))
 (let (($x29029 (= state_1 2)))
 (and $x29029 active_1_rtx (= 1000 due_1_rtx) (or (not active_1_user) (<= due_1_rtx due_1_user)) (or (not active_1_time_wait) (<= due_1_rtx due_1_time_wait)) $x328375 $x286882 $x90872 $x426980 $x322996 $x322785 $x140910 $x342082 $x293940 $x31864 (= v_2_retries (+ 1 v_1_retries)) $x92345 $x334738 $x67171 $x193984 $x212197 $x299103 $x175092 $x189850 $x192761 $x346657 $x301678 $x24973 $x171506 $x323732 $x187394 $x80964 $x21294 $x131911 $x333068 $x101782 $x308462 $x199332 $x85574 $x87997 $x307843 $x57625 $x326855 $x16104 $x433796 $x307530 $x233437 $x434716 $x233450 $x338112 $x103065 $x77480 $x172356 $x140115 $x86316 $x78208 $x54359 $x141394 $x153777 $x301156 $x407566 $x65156 $x289728 $x85306 $x297344 $x336391 $x290296 $x27140 $x42803 $x338179 $x302910 $x82047 $x298202 $x173217 $x406576 $x165633 $x288535 $x327281 $x308400 active_2_rtx $x241668 $x1043 $x350961 $x151980 $x324672)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x289310 (= due_3_time_wait due_2_time_wait)))
 (let (($x49665 (= due_3_user due_2_user)))
 (let (($x289509 (= due_3_rtx due_2_rtx)))
 (let (($x325913 (= active_3_time_wait active_2_time_wait)))
 (let (($x332303 (not active_3_user)))
 (let (($x320269 (not active_3_rtx)))
 (let ((?x82404 (+ 1010 (* (- 1) v_2_rtt_start_ms))))
 (let (($x324815 (not v_2_rtt_ambiguous)))
 (let ((?x236284 (ubv_to_int (bvadd v_2_rtt_end (bvmul (_ bv4294967295 32) v_2_snd_una)))))
 (let ((?x341602 (ubv_to_int (bvadd (_ bv1001 32) (bvmul (_ bv4294967295 32) v_2_snd_una)))))
 (let (($x37763 (>= ?x341602 ?x236284)))
 (let (($x172268 (and v_2_rtt_active $x37763 $x324815)))
 (let ((?x301684 (ite $x172268 ?x82404 v_2_rtt_last_ms)))
 (let ((?x295679 (to_real ?x301684)))
 (let ((?x352547 (+ v_2_srtt_ms (* (- 1.0) ?x295679))))
 (let ((?x347432 (ite $x172268 (ite (>= ?x352547 0.0) ?x352547 (+ (* (- 1.0) v_2_srtt_ms) ?x295679)) v_2_rtt_error_ms)))
 (let ((?x80315 (* (/ 3.0 4.0) v_2_rttvar_ms)))
 (let ((?x320484 (ite $x172268 (ite v_2_rtt_measured (+ ?x80315 (* (/ 1.0 4.0) ?x347432)) (* (/ 1.0 2.0) ?x295679)) v_2_rttvar_ms)))
 (let ((?x198509 (ite v_2_rtt_measured (+ (* (/ 7.0 8.0) v_2_srtt_ms) (* (/ 1.0 8.0) ?x295679)) ?x295679)))
 (let ((?x317743 (ite $x172268 ?x198509 v_2_srtt_ms)))
 (let ((?x80317 (+ (* (- 1.0) ?x317743) (* (- 1.0) (ite (<= ?x320484 (/ 1.0 4.0)) 1.0 (* 4.0 ?x320484))))))
 (let ((?x308857 (to_int ?x80317)))
 (let ((?x321327 (ite (<= ?x308857 (- 1000)) (* (- 1) ?x308857) 1000)))
 (let (($x27948 (= v_3_rto_base_ms (ite $x172268 (ite (<= 60000 ?x321327) 60000 ?x321327) v_2_rto_base_ms))))
 (let (($x46266 (= v_3_rtt_sample_was_ambiguous (and v_2_rtt_active v_2_rtt_ambiguous))))
 (let (($x153926 (not v_3_rtt_start_new)))
 (let ((?x83082 (* (- 1) ?x341602)))
 (let ((?x420639 (+ ?x236284 ?x83082)))
 (let ((?x45878 (ite (and v_2_rtt_active (not (<= v_2_rtt_remaining ?x420639))) ?x420639 v_2_rtt_remaining)))
 (let (($x417688 (and v_2_rtt_active $x37763)))
 (let (($x325593 (= v_3_rtt_end v_2_rtt_end)))
 (let (($x283602 (= v_3_rtt_start_ms v_2_rtt_start_ms)))
 (let (($x16720 (= v_3_rtt_previous_measured (ite $x172268 v_2_rtt_measured v_2_rtt_previous_measured))))
 (let (($x26928 (= v_3_rtt_previous_var (ite $x172268 v_2_rttvar_ms v_2_rtt_previous_var))))
 (let (($x80008 (= v_3_rtt_previous_srtt (ite $x172268 v_2_srtt_ms v_2_rtt_previous_srtt))))
 (let (($x328832 (= v_3_rx_fin_consumed v_2_rx_fin_consumed)))
 (let (($x335062 (= v_3_rx_fin_done v_2_rx_fin_done)))
 (let (($x22374 (= v_3_rx_fin_offset v_2_rx_fin_offset)))
 (let (($x28103 (= v_3_rx_fin_seq v_2_rx_fin_seq)))
 (let (($x29647 (= v_3_rx_fin_pending v_2_rx_fin_pending)))
 (let (($x250210 (= v_3_fin_acknowledged v_2_fin_acknowledged)))
 (let (($x13376 (= v_3_fin_seq v_2_fin_seq)))
 (let (($x45083 (= v_3_fin_sent v_2_fin_sent)))
 (let (($x329022 (= v_3_fin_requested v_2_fin_requested)))
 (let (($x178604 (= v_3_ack_window_update v_2_ack_window_update)))
 (let (($x10977 (= v_3_ack_advance v_2_ack_advance)))
 (let (($x163281 (= v_3_ack_is_future v_2_ack_is_future)))
 (let (($x79898 (= v_3_ack_is_new v_2_ack_is_new)))
 (let (($x336706 (= v_3_ack_delta v_2_ack_delta)))
 (let (($x220267 (= v_3_seg_acceptable v_2_seg_acceptable)))
 (let (($x345362 (= v_3_rx_acceptable v_2_rx_acceptable)))
 (let (($x184419 (= v_3_rx_advance v_2_rx_advance)))
 (let (($x290672 (= v_3_rx_slot_15 v_2_rx_slot_15)))
 (let (($x34008 (= v_3_rx_slot_14 v_2_rx_slot_14)))
 (let (($x183472 (= v_3_rx_slot_13 v_2_rx_slot_13)))
 (let (($x209513 (= v_3_rx_slot_12 v_2_rx_slot_12)))
 (let (($x328632 (= v_3_rx_slot_11 v_2_rx_slot_11)))
 (let (($x54514 (= v_3_rx_slot_10 v_2_rx_slot_10)))
 (let (($x334750 (= v_3_rx_slot_09 v_2_rx_slot_09)))
 (let (($x345398 (= v_3_rx_slot_08 v_2_rx_slot_08)))
 (let (($x333347 (= v_3_rx_slot_07 v_2_rx_slot_07)))
 (let (($x46770 (= v_3_rx_slot_06 v_2_rx_slot_06)))
 (let (($x87734 (= v_3_rx_slot_05 v_2_rx_slot_05)))
 (let (($x248789 (= v_3_rx_slot_04 v_2_rx_slot_04)))
 (let (($x332090 (= v_3_rx_slot_03 v_2_rx_slot_03)))
 (let (($x343203 (= v_3_rx_slot_02 v_2_rx_slot_02)))
 (let (($x305663 (= v_3_rx_slot_01 v_2_rx_slot_01)))
 (let (($x190230 (= v_3_rx_slot_00 v_2_rx_slot_00)))
 (let (($x331669 (= v_3_rx_chunk v_2_rx_chunk)))
 (let (($x48747 (= v_3_take v_2_take)))
 (let (($x330687 (= v_3_snd_wl2 (_ bv1001 32))))
 (let (($x21178 (= v_3_snd_wl1 (_ bv9000 32))))
 (let (($x210810 (= v_3_snd_wnd 16)))
 (let (($x352722 (= v_3_rcv_buf v_2_rcv_buf)))
 (let (($x292607 (= v_3_rtx_buf v_2_rtx_buf)))
 (let (($x297907 (= v_3_snd_buf v_2_snd_buf)))
 (let (($x308482 (= v_3_local_window v_2_local_window)))
 (let (($x40376 (= v_3_msl_ms v_2_msl_ms)))
 (let (($x319108 (= v_3_user_timeout_ms v_2_user_timeout_ms)))
 (let (($x67094 (= v_3_active_open v_2_active_open)))
 (let (($x288974 (= v_3_retries v_2_retries)))
 (let (($x191710 (= 3000 v_3_rto_ms)))
 (let (($x203168 (= v_3_tx_flags v_2_tx_flags)))
 (let (($x308000 (= v_3_tx_ack v_2_tx_ack)))
 (let (($x62551 (= v_3_tx_seq v_2_tx_seq)))
 (let (($x330259 (= v_3_rcv_nxt (_ bv9001 32))))
 (let (($x81176 (= v_3_snd_nxt v_2_snd_nxt)))
 (let (($x141799 (= v_3_snd_una (_ bv1001 32))))
 (let (($x341860 (= v_3_irs (_ bv9000 32))))
 (let (($x101111 (= v_3_iss v_2_iss)))
 (let (($x303772 (= 4 state_3)))
 (let (($x328290 (or (not active_2_time_wait) (not (<= due_2_time_wait 1010)))))
 (let (($x321520 (or (not active_2_user) (not (<= due_2_user 1010)))))
 (let (($x131499 (or (not active_2_rtx) (not (<= due_2_rtx 1010)))))
 (let (($x317650 (= 1 v_2_retries)))
 (let (($x68387 (= v_2_snd_nxt (_ bv1001 32))))
 (let (($x97962 (= state_2 2)))
 (and $x97962 $x68387 $x317650 $x131499 $x321520 $x328290 $x303772 $x101111 $x341860 $x141799 $x81176 $x330259 $x62551 $x308000 $x203168 $x191710 $x288974 $x67094 $x319108 $x40376 $x308482 $x297907 $x292607 $x352722 $x210810 $x21178 $x330687 $x48747 $x331669 $x190230 $x305663 $x343203 $x332090 $x248789 $x87734 $x46770 $x333347 $x345398 $x334750 $x54514 $x328632 $x209513 $x183472 $x34008 $x290672 $x184419 $x345362 $x220267 $x336706 $x79898 $x163281 $x10977 $x178604 $x329022 $x45083 $x13376 $x250210 $x29647 $x28103 $x22374 $x335062 $x328832 (= v_3_srtt_ms ?x317743) (= v_3_rttvar_ms ?x320484) (= v_3_rtt_error_ms ?x347432) $x80008 $x26928 (= v_3_rtt_measured (or v_2_rtt_measured $x172268)) $x16720 (= v_3_rtt_active (and v_2_rtt_active (not $x417688))) (= v_3_rtt_ambiguous (and (not $x417688) v_2_rtt_ambiguous)) $x283602 $x325593 (= v_3_rtt_remaining (ite $x417688 0 ?x45878)) $x153926 (= v_3_rtt_sample_used $x172268) $x46266 (= v_3_rtt_last_ms ?x301684) (= v_3_rtt_samples (+ v_2_rtt_samples (ite $x172268 1 0))) $x27948 $x320269 $x332303 $x325913 $x289509 $x49665 $x289310)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
