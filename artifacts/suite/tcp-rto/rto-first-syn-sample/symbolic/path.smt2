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
 (let (($x52274 (= due_1_time_wait due_0_time_wait)))
 (let (($x292670 (= due_1_user 30000)))
 (let (($x271898 (= due_1_rtx 1000)))
 (let (($x98601 (not active_1_time_wait)))
 (let (($x248946 (= v_1_rto_base_ms 1000)))
 (let (($x16637 (= v_1_rtt_samples 0)))
 (let (($x150339 (= v_1_rtt_last_ms 0)))
 (let (($x183320 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x293624 (not v_1_rtt_sample_used)))
 (let (($x141786 (= v_1_rtt_remaining 1)))
 (let (($x139304 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x401435 (= v_1_rtt_start_ms 0)))
 (let (($x30831 (not v_1_rtt_ambiguous)))
 (let (($x301792 (not v_1_rtt_previous_measured)))
 (let (($x274747 (not v_1_rtt_measured)))
 (let (($x141798 (= v_1_rtt_previous_var 0.0)))
 (let (($x10392 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x311569 (= v_1_rtt_error_ms 0.0)))
 (let (($x274393 (= v_1_rttvar_ms 0.0)))
 (let (($x92382 (= v_1_srtt_ms 0.0)))
 (let (($x69903 (not v_1_rx_fin_consumed)))
 (let (($x89668 (not v_1_rx_fin_done)))
 (let (($x11887 (= v_1_rx_fin_offset 0)))
 (let (($x19863 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x314612 (not v_1_rx_fin_pending)))
 (let (($x296146 (not v_1_fin_acknowledged)))
 (let (($x86429 (= v_1_fin_seq (_ bv0 32))))
 (let (($x27443 (not v_1_fin_sent)))
 (let (($x294285 (not v_1_fin_requested)))
 (let (($x179593 (not v_1_ack_window_update)))
 (let (($x55419 (not v_1_ack_advance)))
 (let (($x317424 (not v_1_ack_is_future)))
 (let (($x303195 (not v_1_ack_is_new)))
 (let (($x261809 (= v_1_ack_delta 0)))
 (let (($x212490 (not v_1_seg_acceptable)))
 (let (($x306726 (not v_1_rx_acceptable)))
 (let (($x196077 (= v_1_rx_advance 0)))
 (let (($x283147 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x37494 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x86642 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x41763 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x416455 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x45399 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x288546 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x300181 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x91615 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x304331 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x277994 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x303775 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x128935 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x317542 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x319359 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x243142 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x294603 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x298023 (= v_1_take 0)))
 (let (($x179873 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x314984 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x73887 (= v_1_snd_wnd 8)))
 (let (($x401428 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x290250 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x179280 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x306282 (= v_1_local_window 16)))
 (let (($x211958 (= v_1_msl_ms 60000)))
 (let (($x287067 (= v_1_user_timeout_ms 30000)))
 (let (($x197314 (= 0 v_1_retries)))
 (let (($x415576 (= 1000 v_1_rto_ms)))
 (let (($x271111 (= v_1_tx_flags "S")))
 (let (($x263617 (= v_1_tx_ack (_ bv0 32))))
 (let (($x78660 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x199017 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x266116 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x31523 (= v_1_snd_una (_ bv1000 32))))
 (let (($x386968 (= v_1_irs (_ bv0 32))))
 (let (($x248520 (= v_1_iss (_ bv1000 32))))
 (let (($x215941 (= 2 state_1)))
 (let (($x308606 (not active_0_time_wait)))
 (let (($x178416 (or $x308606 (not (<= due_0_time_wait 0)))))
 (let (($x231287 (not active_0_user)))
 (let (($x169756 (or $x231287 (not (<= due_0_user 0)))))
 (let (($x320326 (not active_0_rtx)))
 (let (($x200248 (or $x320326 (not (<= due_0_rtx 0)))))
 (let (($x294904 (= state_0 0)))
 (and $x294904 (>= 0 now_0) $x200248 $x169756 $x178416 $x215941 $x248520 $x386968 $x31523 $x266116 $x199017 $x78660 $x263617 $x271111 $x415576 $x197314 v_1_active_open $x287067 $x211958 $x306282 $x179280 $x290250 $x401428 $x73887 $x314984 $x179873 $x298023 $x294603 $x243142 $x319359 $x317542 $x128935 $x303775 $x277994 $x304331 $x91615 $x300181 $x288546 $x45399 $x416455 $x41763 $x86642 $x37494 $x283147 $x196077 $x306726 $x212490 $x261809 $x303195 $x317424 $x55419 $x179593 $x294285 $x27443 $x86429 $x296146 $x314612 $x19863 $x11887 $x89668 $x69903 $x92382 $x274393 $x311569 $x10392 $x141798 $x274747 $x301792 v_1_rtt_active $x30831 $x401435 $x139304 $x141786 v_1_rtt_start_new $x293624 $x183320 $x150339 $x16637 $x248946 active_1_rtx active_1_user $x98601 $x271898 $x292670 $x52274))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 (let (($x960 (= due_2_time_wait due_1_time_wait)))
 (let (($x243534 (= due_2_user due_1_user)))
 (let (($x401631 (= due_2_rtx due_1_rtx)))
 (let (($x76330 (= active_2_time_wait active_1_time_wait)))
 (let (($x2000 (not active_2_user)))
 (let (($x78808 (not active_2_rtx)))
 (let ((?x140943 (+ 900 (* (- 1) v_1_rtt_start_ms))))
 (let (($x30831 (not v_1_rtt_ambiguous)))
 (let ((?x418450 (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let ((?x320799 (ubv_to_int (bvadd (_ bv1001 32) (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let (($x53437 (>= ?x320799 ?x418450)))
 (let (($x306184 (and v_1_rtt_active $x53437 $x30831)))
 (let ((?x168764 (ite $x306184 ?x140943 v_1_rtt_last_ms)))
 (let ((?x64534 (to_real ?x168764)))
 (let ((?x92874 (+ v_1_srtt_ms (* (- 1.0) ?x64534))))
 (let ((?x55607 (ite $x306184 (ite (>= ?x92874 0.0) ?x92874 (+ (* (- 1.0) v_1_srtt_ms) ?x64534)) v_1_rtt_error_ms)))
 (let ((?x95946 (* (/ 3.0 4.0) v_1_rttvar_ms)))
 (let ((?x200898 (ite $x306184 (ite v_1_rtt_measured (+ ?x95946 (* (/ 1.0 4.0) ?x55607)) (* (/ 1.0 2.0) ?x64534)) v_1_rttvar_ms)))
 (let ((?x318394 (ite v_1_rtt_measured (+ (* (/ 7.0 8.0) v_1_srtt_ms) (* (/ 1.0 8.0) ?x64534)) ?x64534)))
 (let ((?x146393 (ite $x306184 ?x318394 v_1_srtt_ms)))
 (let ((?x133748 (+ (* (- 1.0) ?x146393) (* (- 1.0) (ite (<= ?x200898 (/ 1.0 4.0)) 1.0 (* 4.0 ?x200898))))))
 (let ((?x309312 (to_int ?x133748)))
 (let ((?x10499 (ite (<= ?x309312 (- 1000)) (* (- 1) ?x309312) 1000)))
 (let ((?x254607 (ite (<= 60000 ?x10499) 60000 ?x10499)))
 (let (($x1695 (= v_2_rtt_sample_was_ambiguous (and v_1_rtt_active v_1_rtt_ambiguous))))
 (let (($x80347 (not v_2_rtt_start_new)))
 (let ((?x45281 (* (- 1) ?x320799)))
 (let ((?x71267 (+ ?x418450 ?x45281)))
 (let ((?x11724 (ite (and v_1_rtt_active (not (<= v_1_rtt_remaining ?x71267))) ?x71267 v_1_rtt_remaining)))
 (let (($x18016 (and v_1_rtt_active $x53437)))
 (let (($x127801 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x12417 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let (($x71770 (= v_2_rtt_previous_measured (ite $x306184 v_1_rtt_measured v_1_rtt_previous_measured))))
 (let (($x1825 (= v_2_rtt_previous_var (ite $x306184 v_1_rttvar_ms v_1_rtt_previous_var))))
 (let (($x314024 (= v_2_rtt_previous_srtt (ite $x306184 v_1_srtt_ms v_1_rtt_previous_srtt))))
 (let (($x289955 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x152937 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x81136 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x78029 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x314093 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x199707 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x185944 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x386798 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x30103 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x158935 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x319666 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x86932 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x16266 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x275346 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x173041 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x226761 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x285461 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x266427 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x18966 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x62940 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x180140 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x169701 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x67454 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x296915 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x181291 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x86124 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x223317 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x141589 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x304722 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x256866 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x279969 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x308594 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x25631 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x277426 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x124030 (= v_2_take v_1_take)))
 (let (($x314101 (= v_2_snd_wl2 (_ bv1001 32))))
 (let (($x184730 (= v_2_snd_wl1 (_ bv9000 32))))
 (let (($x192940 (= v_2_snd_wnd 16)))
 (let (($x118077 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x175500 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x58041 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x175969 (= v_2_local_window v_1_local_window)))
 (let (($x41847 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x28327 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x286906 (= v_2_active_open v_1_active_open)))
 (let (($x277454 (= v_2_retries v_1_retries)))
 (let (($x176761 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x90249 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x320487 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x118303 (= v_2_rcv_nxt (_ bv9001 32))))
 (let (($x277720 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x178226 (= v_2_snd_una (_ bv1001 32))))
 (let (($x145713 (= v_2_irs (_ bv9000 32))))
 (let (($x45086 (= v_2_iss v_1_iss)))
 (let (($x262398 (= 4 state_2)))
 (let (($x98601 (not active_1_time_wait)))
 (let (($x303642 (or $x98601 (not (<= due_1_time_wait 900)))))
 (let (($x63466 (or (not active_1_user) (not (<= due_1_user 900)))))
 (let (($x301452 (or (not active_1_rtx) (not (<= due_1_rtx 900)))))
 (let (($x197314 (= 0 v_1_retries)))
 (let (($x266116 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x40385 (= state_1 2)))
 (and $x40385 $x266116 $x197314 $x301452 $x63466 $x303642 $x262398 $x45086 $x145713 $x178226 $x277720 $x118303 $x320487 $x90249 $x176761 (= v_2_rto_ms (ite $x306184 ?x254607 v_1_rto_ms)) $x277454 $x286906 $x28327 $x41847 $x175969 $x58041 $x175500 $x118077 $x192940 $x184730 $x314101 $x124030 $x277426 $x25631 $x308594 $x279969 $x256866 $x304722 $x141589 $x223317 $x86124 $x181291 $x296915 $x67454 $x169701 $x180140 $x62940 $x18966 $x266427 $x285461 $x226761 $x173041 $x275346 $x16266 $x86932 $x319666 $x158935 $x30103 $x386798 $x185944 $x199707 $x314093 $x78029 $x81136 $x152937 $x289955 (= v_2_srtt_ms ?x146393) (= v_2_rttvar_ms ?x200898) (= v_2_rtt_error_ms ?x55607) $x314024 $x1825 (= v_2_rtt_measured (or v_1_rtt_measured $x306184)) $x71770 (= v_2_rtt_active (and v_1_rtt_active (not $x18016))) (= v_2_rtt_ambiguous (and (not $x18016) v_1_rtt_ambiguous)) $x12417 $x127801 (= v_2_rtt_remaining (ite $x18016 0 ?x11724)) $x80347 (= v_2_rtt_sample_used $x306184) $x1695 (= v_2_rtt_last_ms ?x168764) (= v_2_rtt_samples (+ v_1_rtt_samples (ite $x306184 1 0))) (= v_2_rto_base_ms (ite $x306184 ?x254607 v_1_rto_base_ms)) $x78808 $x2000 $x76330 $x401631 $x243534 $x960)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
