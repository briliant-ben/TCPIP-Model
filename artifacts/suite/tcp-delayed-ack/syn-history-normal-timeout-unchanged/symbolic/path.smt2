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
(declare-fun active_0_delack () Bool)
(declare-fun due_0_delack () Int)
(declare-fun due_1_delack () Int)
(declare-fun due_1_time_wait () Int)
(declare-fun due_1_user () Int)
(declare-fun due_1_rtx () Int)
(declare-fun active_1_delack () Bool)
(declare-fun active_1_time_wait () Bool)
(declare-fun active_1_user () Bool)
(declare-fun active_1_rtx () Bool)
(declare-fun v_1_ack_defer_now () Bool)
(declare-fun v_1_ack_defer_candidate () Bool)
(declare-fun v_1_ack_rmss () Int)
(declare-fun v_1_ack_delay_ms () Int)
(declare-fun v_1_ack_full_segments () Int)
(declare-fun v_1_ack_bytes () Int)
(declare-fun v_1_ack_since_ms () Int)
(declare-fun v_1_ack_pending () Bool)
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
(declare-fun due_2_delack () Int)
(declare-fun due_2_time_wait () Int)
(declare-fun due_2_user () Int)
(declare-fun due_2_rtx () Int)
(declare-fun active_2_delack () Bool)
(declare-fun active_2_time_wait () Bool)
(declare-fun active_2_user () Bool)
(declare-fun active_2_rtx () Bool)
(declare-fun v_2_ack_defer_now () Bool)
(declare-fun v_2_ack_defer_candidate () Bool)
(declare-fun v_2_ack_rmss () Int)
(declare-fun v_2_ack_delay_ms () Int)
(declare-fun v_2_ack_full_segments () Int)
(declare-fun v_2_ack_bytes () Int)
(declare-fun v_2_ack_since_ms () Int)
(declare-fun v_2_ack_pending () Bool)
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
(declare-fun v_0_ack_pending () Bool)
(declare-fun v_0_ack_since_ms () Int)
(declare-fun v_0_ack_bytes () Int)
(declare-fun v_0_ack_full_segments () Int)
(declare-fun v_0_ack_delay_ms () Int)
(declare-fun v_0_ack_rmss () Int)
(declare-fun v_0_ack_defer_candidate () Bool)
(declare-fun v_0_ack_defer_now () Bool)
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
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
 (not active_0_delack))
(assert
 (= due_0_delack 0))
(assert
 true)
(assert
 (let (($x175433 (= due_1_delack due_0_delack)))
 (let (($x705297 (= due_1_time_wait due_0_time_wait)))
 (let (($x20220 (= due_1_user 30000)))
 (let (($x601794 (= due_1_rtx 1000)))
 (let (($x193144 (not active_1_delack)))
 (let (($x604852 (not active_1_time_wait)))
 (let (($x306717 (not v_1_ack_defer_now)))
 (let (($x529699 (not v_1_ack_defer_candidate)))
 (let (($x728944 (= v_1_ack_rmss 4)))
 (let (($x46518 (= v_1_ack_delay_ms 40)))
 (let (($x31153 (= 0 v_1_ack_full_segments)))
 (let (($x10495 (= 0 v_1_ack_bytes)))
 (let (($x75366 (= 0 v_1_ack_since_ms)))
 (let (($x194881 (not v_1_ack_pending)))
 (let (($x25861 (not v_1_syn_timeout_eligible)))
 (let (($x244213 (= v_1_tx_syn_time 0)))
 (let (($x57327 (not v_1_tx_waiting)))
 (let (($x354512 (not v_1_tx_is_fin)))
 (let (($x308916 (= v_1_tx_previous_rto 1000)))
 (let (($x503521 (= v_1_tx_elapsed 0)))
 (let (($x637240 (not v_1_tx_retransmitted)))
 (let (($x648583 (= v_1_tx_max_previous 0)))
 (let (($x17550 (= v_1_tx_eligible 0)))
 (let (($x312206 (= v_1_tx_emit_count 0)))
 (let (($x747148 (= v_1_tx_fin_time 0)))
 (let (($x242693 (= v_1_tx_time_15 0)))
 (let (($x112515 (= v_1_tx_time_14 0)))
 (let (($x371715 (= v_1_tx_time_13 0)))
 (let (($x603110 (= v_1_tx_time_12 0)))
 (let (($x138716 (= v_1_tx_time_11 0)))
 (let (($x345717 (= v_1_tx_time_10 0)))
 (let (($x301390 (= v_1_tx_time_09 0)))
 (let (($x69815 (= v_1_tx_time_08 0)))
 (let (($x602209 (= v_1_tx_time_07 0)))
 (let (($x24749 (= v_1_tx_time_06 0)))
 (let (($x234829 (= v_1_tx_time_05 0)))
 (let (($x333199 (= v_1_tx_time_04 0)))
 (let (($x36856 (= v_1_tx_time_03 0)))
 (let (($x80663 (= v_1_tx_time_02 0)))
 (let (($x1511 (= v_1_tx_time_01 0)))
 (let (($x638032 (= v_1_tx_time_00 0)))
 (let (($x220723 (= v_1_rto_base_ms 1000)))
 (let (($x284004 (= v_1_rtt_samples 0)))
 (let (($x317185 (= v_1_rtt_last_ms 0)))
 (let (($x80716 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x154537 (not v_1_rtt_sample_used)))
 (let (($x75461 (= v_1_rtt_remaining 1)))
 (let (($x95459 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x605290 (= v_1_rtt_start_ms 0)))
 (let (($x66411 (= v_1_rtt_sample_at_ms 0)))
 (let (($x305043 (not v_1_rtt_ambiguous)))
 (let (($x178699 (not v_1_rtt_previous_measured)))
 (let (($x300649 (not v_1_rtt_measured)))
 (let (($x174993 (= v_1_rtt_previous_var 0.0)))
 (let (($x196451 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x828982 (= v_1_rtt_error_ms 0.0)))
 (let (($x756413 (= v_1_rttvar_ms 0.0)))
 (let (($x296039 (= v_1_srtt_ms 0.0)))
 (let (($x79614 (not v_1_rx_fin_consumed)))
 (let (($x602814 (not v_1_rx_fin_done)))
 (let (($x861741 (= v_1_rx_fin_offset 0)))
 (let (($x400880 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x158784 (not v_1_rx_fin_pending)))
 (let (($x737375 (not v_1_fin_acknowledged)))
 (let (($x374568 (= v_1_fin_seq (_ bv0 32))))
 (let (($x61400 (not v_1_fin_sent)))
 (let (($x150920 (not v_1_fin_requested)))
 (let (($x248931 (not v_1_ack_window_update)))
 (let (($x480844 (not v_1_ack_advance)))
 (let (($x369096 (not v_1_ack_is_future)))
 (let (($x140243 (not v_1_ack_is_new)))
 (let (($x47813 (= v_1_ack_delta 0)))
 (let (($x789680 (not v_1_seg_acceptable)))
 (let (($x545134 (not v_1_rx_acceptable)))
 (let (($x36319 (= v_1_rx_advance 0)))
 (let (($x61578 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x521730 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x3821 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x141634 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x12131 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x859682 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x157196 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x126080 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x283628 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x39274 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x38534 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x194491 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x351704 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x140203 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x38128 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x161622 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x240992 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x298122 (= v_1_take 0)))
 (let (($x243803 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x100791 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x86468 (= v_1_snd_wnd 8)))
 (let (($x22284 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x53502 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x768581 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x149573 (= v_1_local_window 16)))
 (let (($x473833 (= v_1_msl_ms 60000)))
 (let (($x714106 (= v_1_user_timeout_ms 30000)))
 (let (($x604984 (= 0 v_1_retries)))
 (let (($x96583 (= 1000 v_1_rto_ms)))
 (let (($x189465 (= v_1_tx_flags "S")))
 (let (($x50053 (= v_1_tx_ack (_ bv0 32))))
 (let (($x318164 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x306154 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x881552 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x139088 (= v_1_snd_una (_ bv1000 32))))
 (let (($x160825 (= v_1_irs (_ bv0 32))))
 (let (($x182128 (= v_1_iss (_ bv1000 32))))
 (let (($x495016 (= 2 state_1)))
 (let (($x352063 (not active_0_delack)))
 (let (($x86141 (or $x352063 (not (<= due_0_delack 0)))))
 (let (($x602799 (not active_0_time_wait)))
 (let (($x872956 (or $x602799 (not (<= due_0_time_wait 0)))))
 (let (($x637713 (not active_0_user)))
 (let (($x303716 (or $x637713 (not (<= due_0_user 0)))))
 (let (($x104366 (not active_0_rtx)))
 (let (($x218594 (or $x104366 (not (<= due_0_rtx 0)))))
 (let (($x278621 (= state_0 0)))
 (and $x278621 (>= 0 now_0) $x218594 $x303716 $x872956 $x86141 $x495016 $x182128 $x160825 $x139088 $x881552 $x306154 $x318164 $x50053 $x189465 $x96583 $x604984 v_1_active_open $x714106 $x473833 $x149573 $x768581 $x53502 $x22284 $x86468 $x100791 $x243803 $x298122 $x240992 $x161622 $x38128 $x140203 $x351704 $x194491 $x38534 $x39274 $x283628 $x126080 $x157196 $x859682 $x12131 $x141634 $x3821 $x521730 $x61578 $x36319 $x545134 $x789680 $x47813 $x140243 $x369096 $x480844 $x248931 $x150920 $x61400 $x374568 $x737375 $x158784 $x400880 $x861741 $x602814 $x79614 $x296039 $x756413 $x828982 $x196451 $x174993 $x300649 $x178699 v_1_rtt_active $x305043 $x66411 $x605290 $x95459 $x75461 v_1_rtt_start_new $x154537 $x80716 $x317185 $x284004 $x220723 $x638032 $x1511 $x80663 $x36856 $x333199 $x234829 $x24749 $x602209 $x69815 $x301390 $x345717 $x138716 $x603110 $x371715 $x112515 $x242693 $x747148 $x312206 $x17550 $x648583 $x637240 $x503521 $x308916 $x354512 $x57327 $x244213 v_1_tx_syn_pending $x25861 $x194881 $x75366 $x10495 $x31153 $x46518 $x728944 $x529699 $x306717 active_1_rtx active_1_user $x604852 $x193144 $x601794 $x20220 $x705297 $x175433))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x580873 (= due_2_delack due_1_delack)))
 (let (($x602275 (= due_2_time_wait due_1_time_wait)))
 (let (($x451083 (= due_2_user due_1_user)))
 (let ((?x67729 (ite (>= v_1_rto_ms 30000) 60000 (* 2 v_1_rto_ms))))
 (let ((?x637554 (+ v_1_tx_syn_time v_1_rto_ms)))
 (let (($x162373 (<= ?x637554 1000)))
 (let ((?x135675 (ite $x162373 ?x67729 v_1_rto_ms)))
 (let ((?x88833 (ite $x162373 1000 v_1_tx_syn_time)))
 (let ((?x291769 (ite $x162373 ?x67729 (+ (- 1000) ?x88833 ?x135675))))
 (let (($x193174 (not active_2_delack)))
 (let (($x652971 (= active_2_time_wait active_1_time_wait)))
 (let (($x238459 (= active_2_user active_1_user)))
 (let (($x106000 (not v_2_ack_defer_now)))
 (let (($x546993 (not v_2_ack_defer_candidate)))
 (let (($x602413 (= v_2_ack_rmss v_1_ack_rmss)))
 (let (($x602735 (= v_2_ack_delay_ms v_1_ack_delay_ms)))
 (let (($x198801 (= 0 v_2_ack_full_segments)))
 (let (($x200772 (= 0 v_2_ack_bytes)))
 (let (($x25183 (= 0 v_2_ack_since_ms)))
 (let (($x5117 (not v_2_ack_pending)))
 (let (($x369031 (= v_2_syn_timeout_eligible $x162373)))
 (let (($x766630 (= v_2_tx_syn_time ?x88833)))
 (let (($x311212 (not (= $x162373 v_2_tx_waiting))))
 (let (($x43127 (not v_2_tx_is_fin)))
 (let (($x709177 (= v_2_tx_previous_rto v_1_rto_ms)))
 (let (($x150141 (= v_2_tx_elapsed (ite $x162373 (+ 1000 (* (- 1) v_1_tx_syn_time)) 0))))
 (let (($x628204 (= v_2_tx_retransmitted $x162373)))
 (let (($x129576 (= v_2_tx_max_previous v_1_tx_syn_time)))
 (let (($x50753 (= v_2_tx_eligible v_1_tx_eligible)))
 (let (($x638129 (= v_2_tx_emit_count (ite $x162373 1 0))))
 (let ((?x313269 (ite (and v_1_fin_sent (not v_1_fin_acknowledged)) v_1_tx_fin_time 0)))
 (let (($x635880 (= v_2_tx_fin_time ?x313269)))
 (let (($x440686 (= v_2_tx_time_15 (ite (>= 15 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_15))))
 (let (($x83543 (= v_2_tx_time_14 (ite (>= 14 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_14))))
 (let (($x154025 (= v_2_tx_time_13 (ite (>= 13 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_13))))
 (let (($x277457 (= v_2_tx_time_12 (ite (>= 12 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_12))))
 (let (($x494328 (= v_2_tx_time_11 (ite (>= 11 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_11))))
 (let (($x669296 (= v_2_tx_time_10 (ite (>= 10 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_10))))
 (let (($x789231 (= v_2_tx_time_09 (ite (>= 9 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_09))))
 (let (($x160106 (= v_2_tx_time_08 (ite (>= 8 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_08))))
 (let (($x82035 (= v_2_tx_time_07 (ite (>= 7 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_07))))
 (let (($x603814 (= v_2_tx_time_06 (ite (>= 6 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_06))))
 (let (($x154549 (= v_2_tx_time_05 (ite (>= 5 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_05))))
 (let (($x135617 (= v_2_tx_time_04 (ite (>= 4 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_04))))
 (let (($x16219 (= v_2_tx_time_03 (ite (>= 3 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_03))))
 (let (($x4628 (= v_2_tx_time_02 (ite (>= 2 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_02))))
 (let (($x604533 (= v_2_tx_time_01 (ite (>= 1 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_01))))
 (let (($x738405 (= v_2_tx_time_00 (ite (>= 0 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_00))))
 (let (($x42055 (= v_2_rto_base_ms v_1_rto_base_ms)))
 (let (($x164248 (= v_2_rtt_samples v_1_rtt_samples)))
 (let (($x712 (= v_2_rtt_last_ms v_1_rtt_last_ms)))
 (let (($x178814 (not v_2_rtt_sample_was_ambiguous)))
 (let (($x299087 (not v_2_rtt_sample_used)))
 (let (($x65157 (not v_2_rtt_start_new)))
 (let (($x89601 (= v_2_rtt_remaining v_1_rtt_remaining)))
 (let (($x222286 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x181757 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let (($x601606 (= v_2_rtt_sample_at_ms v_1_rtt_sample_at_ms)))
 (let ((?x185197 (+ (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una))) (* (- 1) v_1_rtt_remaining))))
 (let (($x846666 (ite $x162373 (or (and v_1_rtt_active (<= ?x185197 0)) v_1_rtt_ambiguous) v_1_rtt_ambiguous)))
 (let (($x407857 (= v_2_rtt_ambiguous $x846666)))
 (let (($x96153 (= v_2_rtt_active v_1_rtt_active)))
 (let (($x604046 (= v_2_rtt_previous_measured v_1_rtt_previous_measured)))
 (let (($x604371 (= v_2_rtt_measured v_1_rtt_measured)))
 (let (($x127576 (= v_2_rtt_previous_var v_1_rtt_previous_var)))
 (let (($x203727 (= v_2_rtt_previous_srtt v_1_rtt_previous_srtt)))
 (let (($x367702 (= v_2_rtt_error_ms v_1_rtt_error_ms)))
 (let (($x432268 (= v_2_rttvar_ms v_1_rttvar_ms)))
 (let (($x11893 (= v_2_srtt_ms v_1_srtt_ms)))
 (let (($x314181 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x635723 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x371617 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x601521 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x400300 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x442037 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x45817 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x320655 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x219717 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x873863 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x835962 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x133299 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x217663 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x483117 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x636555 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x632542 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x35960 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x318297 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x66324 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x312348 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x320796 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x277518 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x28903 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x113158 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x819875 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x193558 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x632082 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x170129 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x60420 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x164392 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x601822 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x216630 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x826737 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x628409 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x411621 (= v_2_take v_1_take)))
 (let (($x216390 (= v_2_snd_wl2 v_1_snd_wl2)))
 (let (($x314227 (= v_2_snd_wl1 v_1_snd_wl1)))
 (let (($x287549 (= v_2_snd_wnd v_1_snd_wnd)))
 (let (($x32533 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x51344 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x168818 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x315894 (= v_2_local_window v_1_local_window)))
 (let (($x825186 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x159598 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x220004 (= v_2_active_open v_1_active_open)))
 (let (($x37323 (= v_2_retries (ite $x162373 (+ 1 v_1_retries) v_1_retries))))
 (let (($x127262 (= v_2_rto_ms ?x135675)))
 (let (($x321295 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x725049 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x515632 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x373378 (= v_2_rcv_nxt v_1_rcv_nxt)))
 (let (($x194703 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x45492 (= v_2_snd_una v_1_snd_una)))
 (let (($x309049 (= v_2_irs v_1_irs)))
 (let (($x637664 (= v_2_iss v_1_iss)))
 (let (($x200390 (= 2 state_2)))
 (let (($x36764 (= state_1 2)))
 (and $x36764 active_1_rtx (= 1000 due_1_rtx) (or (not active_1_user) (<= due_1_rtx due_1_user)) (or (not active_1_time_wait) (<= due_1_rtx due_1_time_wait)) (or (not active_1_delack) (not (<= due_1_delack due_1_rtx))) $x200390 $x637664 $x309049 $x45492 $x194703 $x373378 $x515632 $x725049 $x321295 $x127262 $x37323 $x220004 $x159598 $x825186 $x315894 $x168818 $x51344 $x32533 $x287549 $x314227 $x216390 $x411621 $x628409 $x826737 $x216630 $x601822 $x164392 $x60420 $x170129 $x632082 $x193558 $x819875 $x113158 $x28903 $x277518 $x320796 $x312348 $x66324 $x318297 $x35960 $x632542 $x636555 $x483117 $x217663 $x133299 $x835962 $x873863 $x219717 $x320655 $x45817 $x442037 $x400300 $x601521 $x371617 $x635723 $x314181 $x11893 $x432268 $x367702 $x203727 $x127576 $x604371 $x604046 $x96153 $x407857 $x601606 $x181757 $x222286 $x89601 $x65157 $x299087 $x178814 $x712 $x164248 $x42055 $x738405 $x604533 $x4628 $x16219 $x135617 $x154549 $x603814 $x82035 $x160106 $x789231 $x669296 $x494328 $x277457 $x154025 $x83543 $x440686 $x635880 $x638129 $x50753 $x129576 $x628204 $x150141 $x709177 $x43127 $x311212 $x766630 v_2_tx_syn_pending $x369031 $x5117 $x25183 $x200772 $x198801 $x602735 $x602413 $x546993 $x106000 active_2_rtx $x238459 $x652971 $x193174 (= due_2_rtx (+ 1000 ?x291769)) $x451083 $x602275 $x580873))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
 (= v_0_ack_pending false))
(assert
 (= 0 v_0_ack_since_ms))
(assert
 (= 0 v_0_ack_bytes))
(assert
 (= 0 v_0_ack_full_segments))
(assert
 (= 40 v_0_ack_delay_ms))
(assert
 (= 4 v_0_ack_rmss))
(assert
 (= v_0_ack_defer_candidate false))
(assert
 (= v_0_ack_defer_now false))
(assert
 (= 0 choice_0))
(assert
 (= 0 now_1))
(assert
 (= 27 choice_1))
(assert
 (= 1000 now_2))
(check-sat)
