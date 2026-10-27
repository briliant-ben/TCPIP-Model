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
 (let (($x247860 (= due_1_time_wait due_0_time_wait)))
 (let (($x133510 (= due_1_user 30000)))
 (let (($x165999 (= due_1_rtx 1000)))
 (let (($x24421 (not active_1_time_wait)))
 (let (($x172707 (= v_1_rto_base_ms 1000)))
 (let (($x160050 (= v_1_rtt_samples 0)))
 (let (($x160506 (= v_1_rtt_last_ms 0)))
 (let (($x76892 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x139270 (not v_1_rtt_sample_used)))
 (let (($x138158 (= v_1_rtt_remaining 1)))
 (let (($x133344 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x33200 (= v_1_rtt_start_ms 0)))
 (let (($x164128 (= v_1_rtt_sample_at_ms 0)))
 (let (($x48174 (not v_1_rtt_ambiguous)))
 (let (($x131276 (not v_1_rtt_previous_measured)))
 (let (($x25859 (not v_1_rtt_measured)))
 (let (($x257538 (= v_1_rtt_previous_var 0.0)))
 (let (($x212378 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x151036 (= v_1_rtt_error_ms 0.0)))
 (let (($x159678 (= v_1_rttvar_ms 0.0)))
 (let (($x64004 (= v_1_srtt_ms 0.0)))
 (let (($x180550 (not v_1_rx_fin_consumed)))
 (let (($x130582 (not v_1_rx_fin_done)))
 (let (($x128980 (= v_1_rx_fin_offset 0)))
 (let (($x1350 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x43939 (not v_1_rx_fin_pending)))
 (let (($x183294 (not v_1_fin_acknowledged)))
 (let (($x313648 (= v_1_fin_seq (_ bv0 32))))
 (let (($x36638 (not v_1_fin_sent)))
 (let (($x451118 (not v_1_fin_requested)))
 (let (($x156872 (not v_1_ack_window_update)))
 (let (($x316874 (not v_1_ack_advance)))
 (let (($x66833 (not v_1_ack_is_future)))
 (let (($x53351 (not v_1_ack_is_new)))
 (let (($x35458 (= v_1_ack_delta 0)))
 (let (($x254860 (not v_1_seg_acceptable)))
 (let (($x190219 (not v_1_rx_acceptable)))
 (let (($x11519 (= v_1_rx_advance 0)))
 (let (($x339870 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x60232 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x127091 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x129940 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x161889 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x1072 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x52649 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x161256 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x56724 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x165796 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x212860 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x173313 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x162178 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x73322 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x40285 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x152100 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x37052 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x38981 (= v_1_take 0)))
 (let (($x251231 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x166262 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x34087 (= v_1_snd_wnd 8)))
 (let (($x153289 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x1251 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x27695 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x38263 (= v_1_local_window 16)))
 (let (($x34575 (= v_1_msl_ms 60000)))
 (let (($x48116 (= v_1_user_timeout_ms 30000)))
 (let (($x126008 (= 0 v_1_retries)))
 (let (($x168808 (= 1000 v_1_rto_ms)))
 (let (($x57026 (= v_1_tx_flags "S")))
 (let (($x44675 (= v_1_tx_ack (_ bv0 32))))
 (let (($x133080 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x154510 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x208246 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x132796 (= v_1_snd_una (_ bv1000 32))))
 (let (($x141260 (= v_1_irs (_ bv0 32))))
 (let (($x191162 (= v_1_iss (_ bv1000 32))))
 (let (($x67079 (= 2 state_1)))
 (let (($x172966 (not active_0_time_wait)))
 (let (($x2340 (or $x172966 (not (<= due_0_time_wait 0)))))
 (let (($x317252 (not active_0_user)))
 (let (($x42676 (or $x317252 (not (<= due_0_user 0)))))
 (let (($x74312 (not active_0_rtx)))
 (let (($x18206 (or $x74312 (not (<= due_0_rtx 0)))))
 (let (($x65367 (= state_0 0)))
 (and $x65367 (>= 0 now_0) $x18206 $x42676 $x2340 $x67079 $x191162 $x141260 $x132796 $x208246 $x154510 $x133080 $x44675 $x57026 $x168808 $x126008 v_1_active_open $x48116 $x34575 $x38263 $x27695 $x1251 $x153289 $x34087 $x166262 $x251231 $x38981 $x37052 $x152100 $x40285 $x73322 $x162178 $x173313 $x212860 $x165796 $x56724 $x161256 $x52649 $x1072 $x161889 $x129940 $x127091 $x60232 $x339870 $x11519 $x190219 $x254860 $x35458 $x53351 $x66833 $x316874 $x156872 $x451118 $x36638 $x313648 $x183294 $x43939 $x1350 $x128980 $x130582 $x180550 $x64004 $x159678 $x151036 $x212378 $x257538 $x25859 $x131276 v_1_rtt_active $x48174 $x164128 $x33200 $x133344 $x138158 v_1_rtt_start_new $x139270 $x76892 $x160506 $x160050 $x172707 active_1_rtx active_1_user $x24421 $x165999 $x133510 $x247860)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x140011 (= due_2_time_wait due_1_time_wait)))
 (let (($x132499 (= due_2_user due_1_user)))
 (let (($x154091 (= due_2_rtx due_1_rtx)))
 (let (($x128019 (= active_2_time_wait active_1_time_wait)))
 (let (($x78801 (not active_2_user)))
 (let (($x158601 (not active_2_rtx)))
 (let ((?x124832 (+ 900 (* (- 1) v_1_rtt_start_ms))))
 (let (($x48174 (not v_1_rtt_ambiguous)))
 (let ((?x6907 (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let ((?x133362 (ubv_to_int (bvadd (_ bv1001 32) (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let (($x130146 (>= ?x133362 ?x6907)))
 (let (($x138206 (and v_1_rtt_active $x130146 $x48174)))
 (let ((?x67539 (ite $x138206 ?x124832 v_1_rtt_last_ms)))
 (let ((?x129871 (to_real ?x67539)))
 (let ((?x66947 (+ v_1_srtt_ms (* (- 1.0) ?x129871))))
 (let ((?x214898 (ite $x138206 (ite (>= ?x66947 0.0) ?x66947 (+ (* (- 1.0) v_1_srtt_ms) ?x129871)) v_1_rtt_error_ms)))
 (let ((?x70139 (* (/ 3.0 4.0) v_1_rttvar_ms)))
 (let ((?x63920 (ite $x138206 (ite v_1_rtt_measured (+ ?x70139 (* (/ 1.0 4.0) ?x214898)) (* (/ 1.0 2.0) ?x129871)) v_1_rttvar_ms)))
 (let ((?x7080 (ite v_1_rtt_measured (+ (* (/ 7.0 8.0) v_1_srtt_ms) (* (/ 1.0 8.0) ?x129871)) ?x129871)))
 (let ((?x191047 (ite $x138206 ?x7080 v_1_srtt_ms)))
 (let ((?x137090 (+ (* (- 1.0) ?x191047) (* (- 1.0) (ite (<= ?x63920 (/ 1.0 4.0)) 1.0 (* 4.0 ?x63920))))))
 (let ((?x53756 (to_int ?x137090)))
 (let ((?x309023 (ite (<= ?x53756 (- 1000)) (* (- 1) ?x53756) 1000)))
 (let ((?x155524 (ite (<= 60000 ?x309023) 60000 ?x309023)))
 (let (($x259485 (= v_2_rtt_sample_was_ambiguous (and v_1_rtt_active v_1_rtt_ambiguous))))
 (let (($x39055 (not v_2_rtt_start_new)))
 (let ((?x170359 (* (- 1) ?x133362)))
 (let ((?x39145 (+ ?x6907 ?x170359)))
 (let ((?x133079 (ite (and v_1_rtt_active (not (<= v_1_rtt_remaining ?x39145))) ?x39145 v_1_rtt_remaining)))
 (let (($x135616 (and v_1_rtt_active $x130146)))
 (let (($x51771 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x431083 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let (($x43197 (= v_2_rtt_previous_measured (ite $x138206 v_1_rtt_measured v_1_rtt_previous_measured))))
 (let (($x177508 (= v_2_rtt_previous_var (ite $x138206 v_1_rttvar_ms v_1_rtt_previous_var))))
 (let (($x164959 (= v_2_rtt_previous_srtt (ite $x138206 v_1_srtt_ms v_1_rtt_previous_srtt))))
 (let (($x464061 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x25149 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x160387 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x172884 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x14306 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x57952 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x131974 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x38152 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x53571 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x42294 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x181064 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x26105 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x53779 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x180150 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x58788 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x152625 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x9068 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x14674 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x318468 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x33245 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x74640 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x6330 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x36727 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x139021 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x19707 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x173008 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x138234 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x38778 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x168811 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x191157 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x18816 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x163077 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x129528 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x2750 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x134401 (= v_2_take v_1_take)))
 (let (($x13917 (= v_2_snd_wl2 (_ bv1001 32))))
 (let (($x50363 (= v_2_snd_wl1 (_ bv9000 32))))
 (let (($x154792 (= v_2_snd_wnd 16)))
 (let (($x136334 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x330010 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x44969 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x60726 (= v_2_local_window v_1_local_window)))
 (let (($x40668 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x184181 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x156794 (= v_2_active_open v_1_active_open)))
 (let (($x48185 (= v_2_retries v_1_retries)))
 (let (($x61550 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x158032 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x131237 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x67697 (= v_2_rcv_nxt (_ bv9001 32))))
 (let (($x16649 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x132826 (= v_2_snd_una (_ bv1001 32))))
 (let (($x332748 (= v_2_irs (_ bv9000 32))))
 (let (($x35227 (= v_2_iss v_1_iss)))
 (let (($x126535 (= 4 state_2)))
 (let (($x24421 (not active_1_time_wait)))
 (let (($x44391 (or $x24421 (not (<= due_1_time_wait 900)))))
 (let (($x137842 (or (not active_1_user) (not (<= due_1_user 900)))))
 (let (($x79061 (or (not active_1_rtx) (not (<= due_1_rtx 900)))))
 (let (($x126008 (= 0 v_1_retries)))
 (let (($x208246 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x139404 (= state_1 2)))
 (and $x139404 $x208246 $x126008 $x79061 $x137842 $x44391 $x126535 $x35227 $x332748 $x132826 $x16649 $x67697 $x131237 $x158032 $x61550 (= v_2_rto_ms (ite $x138206 ?x155524 v_1_rto_ms)) $x48185 $x156794 $x184181 $x40668 $x60726 $x44969 $x330010 $x136334 $x154792 $x50363 $x13917 $x134401 $x2750 $x129528 $x163077 $x18816 $x191157 $x168811 $x38778 $x138234 $x173008 $x19707 $x139021 $x36727 $x6330 $x74640 $x33245 $x318468 $x14674 $x9068 $x152625 $x58788 $x180150 $x53779 $x26105 $x181064 $x42294 $x53571 $x38152 $x131974 $x57952 $x14306 $x172884 $x160387 $x25149 $x464061 (= v_2_srtt_ms ?x191047) (= v_2_rttvar_ms ?x63920) (= v_2_rtt_error_ms ?x214898) $x164959 $x177508 (= v_2_rtt_measured (or v_1_rtt_measured $x138206)) $x43197 (= v_2_rtt_active (and v_1_rtt_active (not $x135616))) (= v_2_rtt_ambiguous (and (not $x135616) v_1_rtt_ambiguous)) (= v_2_rtt_sample_at_ms (ite $x138206 900 v_1_rtt_sample_at_ms)) $x431083 $x51771 (= v_2_rtt_remaining (ite $x135616 0 ?x133079)) $x39055 (= v_2_rtt_sample_used $x138206) $x259485 (= v_2_rtt_last_ms ?x67539) (= v_2_rtt_samples (+ v_1_rtt_samples (ite $x138206 1 0))) (= v_2_rto_base_ms (ite $x138206 ?x155524 v_1_rto_base_ms)) $x158601 $x78801 $x128019 $x154091 $x132499 $x140011)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
