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
(declare-fun v_1_syn_timeout_eligible () Bool)
(declare-fun v_1_tx_syn_pending () Bool)
(declare-fun v_1_tx_syn_time () Int)
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
(declare-fun v_2_syn_timeout_eligible () Bool)
(declare-fun v_2_tx_syn_pending () Bool)
(declare-fun v_2_tx_syn_time () Int)
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
(declare-fun v_0_tx_syn_time () Int)
(declare-fun v_0_tx_syn_pending () Bool)
(declare-fun v_0_syn_timeout_eligible () Bool)
(declare-fun choice_0 () Int)
(declare-fun now_1 () Int)
(declare-fun choice_1 () Int)
(declare-fun now_2 () Int)
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
 (let (($x581771 (= due_1_time_wait due_0_time_wait)))
 (let (($x206787 (= due_1_user 30000)))
 (let (($x52624 (= due_1_rtx 1000)))
 (let (($x52788 (not active_1_time_wait)))
 (let (($x352645 (not v_1_syn_timeout_eligible)))
 (let (($x58854 (= v_1_tx_syn_time 0)))
 (let (($x134397 (not v_1_tx_waiting)))
 (let (($x260662 (not v_1_tx_is_fin)))
 (let (($x92450 (= v_1_tx_previous_rto 1000)))
 (let (($x61043 (= v_1_tx_elapsed 0)))
 (let (($x134322 (not v_1_tx_retransmitted)))
 (let (($x193292 (= v_1_tx_max_previous 0)))
 (let (($x145908 (= v_1_tx_eligible 0)))
 (let (($x297554 (= v_1_tx_emit_count 0)))
 (let (($x114913 (= v_1_tx_fin_time 0)))
 (let (($x108800 (= v_1_tx_time_15 0)))
 (let (($x3644 (= v_1_tx_time_14 0)))
 (let (($x61228 (= v_1_tx_time_13 0)))
 (let (($x165342 (= v_1_tx_time_12 0)))
 (let (($x313784 (= v_1_tx_time_11 0)))
 (let (($x11751 (= v_1_tx_time_10 0)))
 (let (($x62739 (= v_1_tx_time_09 0)))
 (let (($x25177 (= v_1_tx_time_08 0)))
 (let (($x423499 (= v_1_tx_time_07 0)))
 (let (($x136823 (= v_1_tx_time_06 0)))
 (let (($x222111 (= v_1_tx_time_05 0)))
 (let (($x296618 (= v_1_tx_time_04 0)))
 (let (($x130626 (= v_1_tx_time_03 0)))
 (let (($x35778 (= v_1_tx_time_02 0)))
 (let (($x11819 (= v_1_tx_time_01 0)))
 (let (($x314928 (= v_1_tx_time_00 0)))
 (let (($x218324 (= v_1_rto_base_ms 1000)))
 (let (($x109737 (= v_1_rtt_samples 0)))
 (let (($x28426 (= v_1_rtt_last_ms 0)))
 (let (($x42153 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x52718 (not v_1_rtt_sample_used)))
 (let (($x271912 (= v_1_rtt_remaining 1)))
 (let (($x154021 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x18904 (= v_1_rtt_start_ms 0)))
 (let (($x308572 (= v_1_rtt_sample_at_ms 0)))
 (let (($x302499 (not v_1_rtt_ambiguous)))
 (let (($x322432 (not v_1_rtt_previous_measured)))
 (let (($x130979 (not v_1_rtt_measured)))
 (let (($x389124 (= v_1_rtt_previous_var 0.0)))
 (let (($x117254 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x246568 (= v_1_rtt_error_ms 0.0)))
 (let (($x920 (= v_1_rttvar_ms 0.0)))
 (let (($x60667 (= v_1_srtt_ms 0.0)))
 (let (($x202527 (not v_1_rx_fin_consumed)))
 (let (($x119188 (not v_1_rx_fin_done)))
 (let (($x127793 (= v_1_rx_fin_offset 0)))
 (let (($x396150 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x300613 (not v_1_rx_fin_pending)))
 (let (($x320268 (not v_1_fin_acknowledged)))
 (let (($x309488 (= v_1_fin_seq (_ bv0 32))))
 (let (($x307592 (not v_1_fin_sent)))
 (let (($x172671 (not v_1_fin_requested)))
 (let (($x36130 (not v_1_ack_window_update)))
 (let (($x146671 (not v_1_ack_advance)))
 (let (($x155945 (not v_1_ack_is_future)))
 (let (($x192788 (not v_1_ack_is_new)))
 (let (($x100978 (= v_1_ack_delta 0)))
 (let (($x196794 (not v_1_seg_acceptable)))
 (let (($x74162 (not v_1_rx_acceptable)))
 (let (($x215929 (= v_1_rx_advance 0)))
 (let (($x128762 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x297141 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x179732 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x1389 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x110548 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x322192 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x313394 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x14983 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x59603 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x260218 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x191660 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x59036 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x327886 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x1697 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x24589 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x47840 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x52506 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x2736 (= v_1_take 0)))
 (let (($x6903 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x203650 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x388833 (= v_1_snd_wnd 8)))
 (let (($x166223 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x232701 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x82798 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x839711 (= v_1_local_window 16)))
 (let (($x137935 (= v_1_msl_ms 60000)))
 (let (($x305185 (= v_1_user_timeout_ms 30000)))
 (let (($x140066 (= 0 v_1_retries)))
 (let (($x133446 (= 1000 v_1_rto_ms)))
 (let (($x6399 (= v_1_tx_flags "S")))
 (let (($x233035 (= v_1_tx_ack (_ bv0 32))))
 (let (($x738292 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x152787 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x11799 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x321939 (= v_1_snd_una (_ bv1000 32))))
 (let (($x68561 (= v_1_irs (_ bv0 32))))
 (let (($x271532 (= v_1_iss (_ bv1000 32))))
 (let (($x317253 (= 2 state_1)))
 (let (($x415646 (not active_0_time_wait)))
 (let (($x176932 (or $x415646 (not (<= due_0_time_wait 0)))))
 (let (($x137512 (not active_0_user)))
 (let (($x187624 (or $x137512 (not (<= due_0_user 0)))))
 (let (($x272540 (not active_0_rtx)))
 (let (($x106006 (or $x272540 (not (<= due_0_rtx 0)))))
 (let (($x356169 (= state_0 0)))
 (and $x356169 (>= 0 now_0) $x106006 $x187624 $x176932 $x317253 $x271532 $x68561 $x321939 $x11799 $x152787 $x738292 $x233035 $x6399 $x133446 $x140066 v_1_active_open $x305185 $x137935 $x839711 $x82798 $x232701 $x166223 $x388833 $x203650 $x6903 $x2736 $x52506 $x47840 $x24589 $x1697 $x327886 $x59036 $x191660 $x260218 $x59603 $x14983 $x313394 $x322192 $x110548 $x1389 $x179732 $x297141 $x128762 $x215929 $x74162 $x196794 $x100978 $x192788 $x155945 $x146671 $x36130 $x172671 $x307592 $x309488 $x320268 $x300613 $x396150 $x127793 $x119188 $x202527 $x60667 $x920 $x246568 $x117254 $x389124 $x130979 $x322432 v_1_rtt_active $x302499 $x308572 $x18904 $x154021 $x271912 v_1_rtt_start_new $x52718 $x42153 $x28426 $x109737 $x218324 $x314928 $x11819 $x35778 $x130626 $x296618 $x222111 $x136823 $x423499 $x25177 $x62739 $x11751 $x313784 $x165342 $x61228 $x3644 $x108800 $x114913 $x297554 $x145908 $x193292 $x134322 $x61043 $x92450 $x260662 $x134397 $x58854 v_1_tx_syn_pending $x352645 active_1_rtx active_1_user $x52788 $x52624 $x206787 $x581771))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x166674 (= due_2_time_wait due_1_time_wait)))
 (let (($x215749 (= due_2_user due_1_user)))
 (let ((?x2537 (ite (>= v_1_rto_ms 30000) 60000 (* 2 v_1_rto_ms))))
 (let ((?x372348 (+ v_1_tx_syn_time v_1_rto_ms)))
 (let (($x287279 (<= ?x372348 1000)))
 (let ((?x44191 (ite $x287279 ?x2537 v_1_rto_ms)))
 (let ((?x63829 (ite $x287279 1000 v_1_tx_syn_time)))
 (let (($x191473 (= active_2_time_wait active_1_time_wait)))
 (let (($x182853 (= active_2_user active_1_user)))
 (let (($x276045 (= v_2_syn_timeout_eligible $x287279)))
 (let (($x315298 (= v_2_tx_syn_time ?x63829)))
 (let (($x391566 (not (= $x287279 v_2_tx_waiting))))
 (let (($x7478 (not v_2_tx_is_fin)))
 (let (($x154814 (= v_2_tx_previous_rto v_1_rto_ms)))
 (let (($x114190 (= v_2_tx_elapsed (ite $x287279 (+ 1000 (* (- 1) v_1_tx_syn_time)) 0))))
 (let (($x131163 (= v_2_tx_retransmitted $x287279)))
 (let (($x391121 (= v_2_tx_max_previous v_1_tx_syn_time)))
 (let (($x160223 (= v_2_tx_eligible v_1_tx_eligible)))
 (let (($x11959 (= v_2_tx_emit_count (ite $x287279 1 0))))
 (let ((?x72279 (ite (and v_1_fin_sent (not v_1_fin_acknowledged)) v_1_tx_fin_time 0)))
 (let (($x36102 (= v_2_tx_fin_time ?x72279)))
 (let (($x447696 (= v_2_tx_time_15 (ite (>= 15 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_15))))
 (let (($x129426 (= v_2_tx_time_14 (ite (>= 14 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_14))))
 (let (($x156639 (= v_2_tx_time_13 (ite (>= 13 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_13))))
 (let (($x283843 (= v_2_tx_time_12 (ite (>= 12 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_12))))
 (let (($x327884 (= v_2_tx_time_11 (ite (>= 11 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_11))))
 (let (($x278530 (= v_2_tx_time_10 (ite (>= 10 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_10))))
 (let (($x466180 (= v_2_tx_time_09 (ite (>= 9 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_09))))
 (let (($x135188 (= v_2_tx_time_08 (ite (>= 8 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_08))))
 (let (($x75104 (= v_2_tx_time_07 (ite (>= 7 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_07))))
 (let (($x308741 (= v_2_tx_time_06 (ite (>= 6 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_06))))
 (let (($x44745 (= v_2_tx_time_05 (ite (>= 5 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_05))))
 (let (($x159778 (= v_2_tx_time_04 (ite (>= 4 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_04))))
 (let (($x249668 (= v_2_tx_time_03 (ite (>= 3 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_03))))
 (let (($x244300 (= v_2_tx_time_02 (ite (>= 2 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_02))))
 (let (($x145038 (= v_2_tx_time_01 (ite (>= 1 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_01))))
 (let (($x302595 (= v_2_tx_time_00 (ite (>= 0 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_00))))
 (let (($x173268 (= v_2_rto_base_ms v_1_rto_base_ms)))
 (let (($x298704 (= v_2_rtt_samples v_1_rtt_samples)))
 (let (($x260592 (= v_2_rtt_last_ms v_1_rtt_last_ms)))
 (let (($x12827 (not v_2_rtt_sample_was_ambiguous)))
 (let (($x164969 (not v_2_rtt_sample_used)))
 (let (($x283969 (not v_2_rtt_start_new)))
 (let (($x128483 (= v_2_rtt_remaining v_1_rtt_remaining)))
 (let (($x37686 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x318128 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let (($x232138 (= v_2_rtt_sample_at_ms v_1_rtt_sample_at_ms)))
 (let ((?x193809 (+ (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una))) (* (- 1) v_1_rtt_remaining))))
 (let (($x169958 (ite $x287279 (or v_1_rtt_ambiguous (and v_1_rtt_active (<= ?x193809 0))) v_1_rtt_ambiguous)))
 (let (($x96470 (= v_2_rtt_active v_1_rtt_active)))
 (let (($x280676 (= v_2_rtt_previous_measured v_1_rtt_previous_measured)))
 (let (($x277328 (= v_2_rtt_measured v_1_rtt_measured)))
 (let (($x52603 (= v_2_rtt_previous_var v_1_rtt_previous_var)))
 (let (($x279075 (= v_2_rtt_previous_srtt v_1_rtt_previous_srtt)))
 (let (($x134340 (= v_2_rtt_error_ms v_1_rtt_error_ms)))
 (let (($x303142 (= v_2_rttvar_ms v_1_rttvar_ms)))
 (let (($x85565 (= v_2_srtt_ms v_1_srtt_ms)))
 (let (($x308015 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x215025 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x190340 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x280069 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x168271 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x151177 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x244511 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x140220 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x153235 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x102294 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x354360 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x108310 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x177397 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x145412 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x13360 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x298500 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x150076 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x300849 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x547526 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x92579 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x274114 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x94877 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x314005 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x191850 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x211742 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x34994 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x313137 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x353692 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x39465 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x58778 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x69813 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x135693 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x118383 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x174246 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x147024 (= v_2_take v_1_take)))
 (let (($x97577 (= v_2_snd_wl2 v_1_snd_wl2)))
 (let (($x110781 (= v_2_snd_wl1 v_1_snd_wl1)))
 (let (($x88180 (= v_2_snd_wnd v_1_snd_wnd)))
 (let (($x128631 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x177993 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x327962 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x160802 (= v_2_local_window v_1_local_window)))
 (let (($x70856 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x2480 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x145049 (= v_2_active_open v_1_active_open)))
 (let (($x309368 (= v_2_retries (ite $x287279 (+ 1 v_1_retries) v_1_retries))))
 (let (($x301587 (= v_2_rto_ms ?x44191)))
 (let (($x50619 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x131206 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x304029 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x306782 (= v_2_rcv_nxt v_1_rcv_nxt)))
 (let (($x311167 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x300496 (= v_2_snd_una v_1_snd_una)))
 (let (($x52111 (= v_2_irs v_1_irs)))
 (let (($x267763 (= v_2_iss v_1_iss)))
 (let (($x167597 (= 2 state_2)))
 (let (($x151769 (= state_1 2)))
 (and $x151769 active_1_rtx (= 1000 due_1_rtx) (or (not active_1_user) (<= due_1_rtx due_1_user)) (or (not active_1_time_wait) (<= due_1_rtx due_1_time_wait)) $x167597 $x267763 $x52111 $x300496 $x311167 $x306782 $x304029 $x131206 $x50619 $x301587 $x309368 $x145049 $x2480 $x70856 $x160802 $x327962 $x177993 $x128631 $x88180 $x110781 $x97577 $x147024 $x174246 $x118383 $x135693 $x69813 $x58778 $x39465 $x353692 $x313137 $x34994 $x211742 $x191850 $x314005 $x94877 $x274114 $x92579 $x547526 $x300849 $x150076 $x298500 $x13360 $x145412 $x177397 $x108310 $x354360 $x102294 $x153235 $x140220 $x244511 $x151177 $x168271 $x280069 $x190340 $x215025 $x308015 $x85565 $x303142 $x134340 $x279075 $x52603 $x277328 $x280676 $x96470 (= v_2_rtt_ambiguous $x169958) $x232138 $x318128 $x37686 $x128483 $x283969 $x164969 $x12827 $x260592 $x298704 $x173268 $x302595 $x145038 $x244300 $x249668 $x159778 $x44745 $x308741 $x75104 $x135188 $x466180 $x278530 $x327884 $x283843 $x156639 $x129426 $x447696 $x36102 $x11959 $x160223 $x391121 $x131163 $x114190 $x154814 $x7478 $x391566 $x315298 v_2_tx_syn_pending $x276045 active_2_rtx $x182853 $x191473 (= due_2_rtx (+ 1000 (ite $x287279 ?x2537 (+ (- 1000) ?x63829 ?x44191)))) $x215749 $x166674))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
 (= 0 v_0_tx_syn_time))
(assert
 (= v_0_tx_syn_pending false))
(assert
 (= v_0_syn_timeout_eligible false))
(assert
 (= 0 choice_0))
(assert
 (= 0 now_1))
(assert
 (= 27 choice_1))
(assert
 (= 1000 now_2))
(check-sat)
