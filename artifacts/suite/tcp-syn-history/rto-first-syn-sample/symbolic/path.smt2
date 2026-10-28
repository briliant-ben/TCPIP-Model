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
 (let (($x263960 (= due_1_time_wait due_0_time_wait)))
 (let (($x148732 (= due_1_user 30000)))
 (let (($x128584 (= due_1_rtx 1000)))
 (let (($x355341 (not active_1_time_wait)))
 (let (($x116962 (not v_1_syn_timeout_eligible)))
 (let (($x219298 (= v_1_tx_syn_time 0)))
 (let (($x172287 (not v_1_tx_waiting)))
 (let (($x376269 (not v_1_tx_is_fin)))
 (let (($x38585 (= v_1_tx_previous_rto 1000)))
 (let (($x451053 (= v_1_tx_elapsed 0)))
 (let (($x292758 (not v_1_tx_retransmitted)))
 (let (($x42391 (= v_1_tx_max_previous 0)))
 (let (($x315815 (= v_1_tx_eligible 0)))
 (let (($x213705 (= v_1_tx_emit_count 0)))
 (let (($x151065 (= v_1_tx_fin_time 0)))
 (let (($x89522 (= v_1_tx_time_15 0)))
 (let (($x93988 (= v_1_tx_time_14 0)))
 (let (($x167488 (= v_1_tx_time_13 0)))
 (let (($x197233 (= v_1_tx_time_12 0)))
 (let (($x425175 (= v_1_tx_time_11 0)))
 (let (($x113871 (= v_1_tx_time_10 0)))
 (let (($x142156 (= v_1_tx_time_09 0)))
 (let (($x553328 (= v_1_tx_time_08 0)))
 (let (($x56094 (= v_1_tx_time_07 0)))
 (let (($x52904 (= v_1_tx_time_06 0)))
 (let (($x345115 (= v_1_tx_time_05 0)))
 (let (($x175944 (= v_1_tx_time_04 0)))
 (let (($x322489 (= v_1_tx_time_03 0)))
 (let (($x160209 (= v_1_tx_time_02 0)))
 (let (($x300026 (= v_1_tx_time_01 0)))
 (let (($x135503 (= v_1_tx_time_00 0)))
 (let (($x16912 (= v_1_rto_base_ms 1000)))
 (let (($x309266 (= v_1_rtt_samples 0)))
 (let (($x388688 (= v_1_rtt_last_ms 0)))
 (let (($x23593 (not v_1_rtt_sample_was_ambiguous)))
 (let (($x148910 (not v_1_rtt_sample_used)))
 (let (($x272849 (= v_1_rtt_remaining 1)))
 (let (($x12011 (= v_1_rtt_end (_ bv1001 32))))
 (let (($x50725 (= v_1_rtt_start_ms 0)))
 (let (($x62161 (= v_1_rtt_sample_at_ms 0)))
 (let (($x291870 (not v_1_rtt_ambiguous)))
 (let (($x210239 (not v_1_rtt_previous_measured)))
 (let (($x64525 (not v_1_rtt_measured)))
 (let (($x243915 (= v_1_rtt_previous_var 0.0)))
 (let (($x170433 (= v_1_rtt_previous_srtt 0.0)))
 (let (($x26370 (= v_1_rtt_error_ms 0.0)))
 (let (($x390084 (= v_1_rttvar_ms 0.0)))
 (let (($x325469 (= v_1_srtt_ms 0.0)))
 (let (($x163450 (not v_1_rx_fin_consumed)))
 (let (($x167504 (not v_1_rx_fin_done)))
 (let (($x160582 (= v_1_rx_fin_offset 0)))
 (let (($x20732 (= v_1_rx_fin_seq (_ bv0 32))))
 (let (($x15588 (not v_1_rx_fin_pending)))
 (let (($x31004 (not v_1_fin_acknowledged)))
 (let (($x25589 (= v_1_fin_seq (_ bv0 32))))
 (let (($x320037 (not v_1_fin_sent)))
 (let (($x192635 (not v_1_fin_requested)))
 (let (($x153054 (not v_1_ack_window_update)))
 (let (($x5376 (not v_1_ack_advance)))
 (let (($x274991 (not v_1_ack_is_future)))
 (let (($x137582 (not v_1_ack_is_new)))
 (let (($x102313 (= v_1_ack_delta 0)))
 (let (($x354873 (not v_1_seg_acceptable)))
 (let (($x230245 (not v_1_rx_acceptable)))
 (let (($x249528 (= v_1_rx_advance 0)))
 (let (($x114651 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_15)))
 (let (($x8579 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_14)))
 (let (($x150964 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_13)))
 (let (($x196846 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_12)))
 (let (($x68707 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_11)))
 (let (($x155699 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_10)))
 (let (($x840849 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_09)))
 (let (($x36331 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_08)))
 (let (($x342065 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_07)))
 (let (($x319596 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_06)))
 (let (($x423298 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_05)))
 (let (($x364147 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_04)))
 (let (($x267260 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_03)))
 (let (($x352107 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_02)))
 (let (($x149095 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_01)))
 (let (($x45001 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_slot_00)))
 (let (($x71231 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rx_chunk)))
 (let (($x303142 (= v_1_take 0)))
 (let (($x156994 (= v_1_snd_wl2 (_ bv0 32))))
 (let (($x182237 (= v_1_snd_wl1 (_ bv0 32))))
 (let (($x181621 (= v_1_snd_wnd 8)))
 (let (($x308172 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rcv_buf)))
 (let (($x5240 (= (as seq.empty (Seq (_ BitVec 8))) v_1_rtx_buf)))
 (let (($x2527 (= (as seq.empty (Seq (_ BitVec 8))) v_1_snd_buf)))
 (let (($x395482 (= v_1_local_window 16)))
 (let (($x532142 (= v_1_msl_ms 60000)))
 (let (($x94269 (= v_1_user_timeout_ms 30000)))
 (let (($x391753 (= 0 v_1_retries)))
 (let (($x127571 (= 1000 v_1_rto_ms)))
 (let (($x58663 (= v_1_tx_flags "S")))
 (let (($x173895 (= v_1_tx_ack (_ bv0 32))))
 (let (($x143100 (= v_1_tx_seq (_ bv1000 32))))
 (let (($x19781 (= v_1_rcv_nxt (_ bv0 32))))
 (let (($x110601 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x45153 (= v_1_snd_una (_ bv1000 32))))
 (let (($x68881 (= v_1_irs (_ bv0 32))))
 (let (($x115258 (= v_1_iss (_ bv1000 32))))
 (let (($x208599 (= 2 state_1)))
 (let (($x268424 (not active_0_time_wait)))
 (let (($x390404 (or $x268424 (not (<= due_0_time_wait 0)))))
 (let (($x173208 (not active_0_user)))
 (let (($x194363 (or $x173208 (not (<= due_0_user 0)))))
 (let (($x118122 (not active_0_rtx)))
 (let (($x189187 (or $x118122 (not (<= due_0_rtx 0)))))
 (let (($x22039 (= state_0 0)))
 (and $x22039 (>= 0 now_0) $x189187 $x194363 $x390404 $x208599 $x115258 $x68881 $x45153 $x110601 $x19781 $x143100 $x173895 $x58663 $x127571 $x391753 v_1_active_open $x94269 $x532142 $x395482 $x2527 $x5240 $x308172 $x181621 $x182237 $x156994 $x303142 $x71231 $x45001 $x149095 $x352107 $x267260 $x364147 $x423298 $x319596 $x342065 $x36331 $x840849 $x155699 $x68707 $x196846 $x150964 $x8579 $x114651 $x249528 $x230245 $x354873 $x102313 $x137582 $x274991 $x5376 $x153054 $x192635 $x320037 $x25589 $x31004 $x15588 $x20732 $x160582 $x167504 $x163450 $x325469 $x390084 $x26370 $x170433 $x243915 $x64525 $x210239 v_1_rtt_active $x291870 $x62161 $x50725 $x12011 $x272849 v_1_rtt_start_new $x148910 $x23593 $x388688 $x309266 $x16912 $x135503 $x300026 $x160209 $x322489 $x175944 $x345115 $x52904 $x56094 $x553328 $x142156 $x113871 $x425175 $x197233 $x167488 $x93988 $x89522 $x151065 $x213705 $x315815 $x42391 $x292758 $x451053 $x38585 $x376269 $x172287 $x219298 v_1_tx_syn_pending $x116962 active_1_rtx active_1_user $x355341 $x128584 $x148732 $x263960))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 (let (($x51958 (= due_2_time_wait due_1_time_wait)))
 (let (($x30313 (= due_2_user due_1_user)))
 (let (($x345130 (= due_2_rtx due_1_rtx)))
 (let (($x173218 (= active_2_time_wait active_1_time_wait)))
 (let (($x124608 (not active_2_user)))
 (let (($x1169 (not active_2_rtx)))
 (let (($x310870 (not v_2_syn_timeout_eligible)))
 (let (($x230527 (not v_2_tx_syn_pending)))
 (let (($x376880 (= v_2_tx_syn_time 0)))
 (let (($x27008 (not v_2_tx_waiting)))
 (let (($x843167 (= v_2_tx_is_fin v_1_tx_is_fin)))
 (let (($x80165 (= v_2_tx_previous_rto v_1_tx_previous_rto)))
 (let (($x170551 (= v_2_tx_elapsed v_1_tx_elapsed)))
 (let (($x173262 (not v_2_tx_retransmitted)))
 (let (($x36526 (= v_2_tx_max_previous v_1_tx_max_previous)))
 (let (($x307425 (= v_2_tx_eligible v_1_tx_eligible)))
 (let (($x85855 (= v_2_tx_emit_count v_1_tx_emit_count)))
 (let ((?x192389 (ite (and v_1_fin_sent (not v_1_fin_acknowledged)) v_1_tx_fin_time 0)))
 (let (($x303345 (= v_2_tx_fin_time ?x192389)))
 (let (($x305010 (= v_2_tx_time_15 (ite (>= 15 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_15))))
 (let (($x240732 (= v_2_tx_time_14 (ite (>= 14 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_14))))
 (let (($x221927 (= v_2_tx_time_13 (ite (>= 13 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_13))))
 (let (($x59488 (= v_2_tx_time_12 (ite (>= 12 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_12))))
 (let (($x411955 (= v_2_tx_time_11 (ite (>= 11 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_11))))
 (let (($x113668 (= v_2_tx_time_10 (ite (>= 10 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_10))))
 (let (($x146405 (= v_2_tx_time_09 (ite (>= 9 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_09))))
 (let (($x3682 (= v_2_tx_time_08 (ite (>= 8 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_08))))
 (let (($x309282 (= v_2_tx_time_07 (ite (>= 7 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_07))))
 (let (($x158524 (= v_2_tx_time_06 (ite (>= 6 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_06))))
 (let (($x157978 (= v_2_tx_time_05 (ite (>= 5 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_05))))
 (let (($x351752 (= v_2_tx_time_04 (ite (>= 4 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_04))))
 (let (($x208020 (= v_2_tx_time_03 (ite (>= 3 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_03))))
 (let (($x150184 (= v_2_tx_time_02 (ite (>= 2 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_02))))
 (let (($x298393 (= v_2_tx_time_01 (ite (>= 1 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_01))))
 (let (($x8384 (= v_2_tx_time_00 (ite (>= 0 (seq.len v_1_rtx_buf)) 0 v_1_tx_time_00))))
 (let ((?x159109 (+ 900 (* (- 1) v_1_rtt_start_ms))))
 (let (($x291870 (not v_1_rtt_ambiguous)))
 (let ((?x142662 (ubv_to_int (bvadd v_1_rtt_end (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let ((?x355541 (ubv_to_int (bvadd (_ bv1001 32) (bvmul (_ bv4294967295 32) v_1_snd_una)))))
 (let (($x133762 (>= ?x355541 ?x142662)))
 (let (($x139813 (and v_1_rtt_active $x133762 $x291870)))
 (let ((?x210873 (ite $x139813 ?x159109 v_1_rtt_last_ms)))
 (let ((?x95001 (to_real ?x210873)))
 (let ((?x85096 (+ v_1_srtt_ms (* (- 1.0) ?x95001))))
 (let ((?x168598 (ite $x139813 (ite (>= ?x85096 0.0) ?x85096 (+ (* (- 1.0) v_1_srtt_ms) ?x95001)) v_1_rtt_error_ms)))
 (let ((?x12068 (* (/ 3.0 4.0) v_1_rttvar_ms)))
 (let ((?x182845 (ite $x139813 (ite v_1_rtt_measured (+ ?x12068 (* (/ 1.0 4.0) ?x168598)) (* (/ 1.0 2.0) ?x95001)) v_1_rttvar_ms)))
 (let ((?x291981 (ite v_1_rtt_measured (+ (* (/ 7.0 8.0) v_1_srtt_ms) (* (/ 1.0 8.0) ?x95001)) ?x95001)))
 (let ((?x302119 (ite $x139813 ?x291981 v_1_srtt_ms)))
 (let ((?x306215 (+ (* (- 1.0) ?x302119) (* (- 1.0) (ite (<= ?x182845 (/ 1.0 4.0)) 1.0 (* 4.0 ?x182845))))))
 (let ((?x310374 (to_int ?x306215)))
 (let ((?x147283 (ite (<= ?x310374 (- 1000)) (* (- 1) ?x310374) 1000)))
 (let ((?x143376 (ite (<= 60000 ?x147283) 60000 ?x147283)))
 (let (($x37908 (= v_2_rtt_sample_was_ambiguous (and v_1_rtt_active v_1_rtt_ambiguous))))
 (let (($x78191 (not v_2_rtt_start_new)))
 (let ((?x100908 (* (- 1) ?x355541)))
 (let ((?x9187 (+ ?x142662 ?x100908)))
 (let ((?x94024 (ite (and v_1_rtt_active (not (<= v_1_rtt_remaining ?x9187))) ?x9187 v_1_rtt_remaining)))
 (let (($x198281 (and v_1_rtt_active $x133762)))
 (let (($x166505 (= v_2_rtt_end v_1_rtt_end)))
 (let (($x145186 (= v_2_rtt_start_ms v_1_rtt_start_ms)))
 (let (($x94109 (= v_2_rtt_previous_measured (ite $x139813 v_1_rtt_measured v_1_rtt_previous_measured))))
 (let (($x149817 (= v_2_rtt_previous_var (ite $x139813 v_1_rttvar_ms v_1_rtt_previous_var))))
 (let (($x288092 (= v_2_rtt_previous_srtt (ite $x139813 v_1_srtt_ms v_1_rtt_previous_srtt))))
 (let (($x18503 (= v_2_rx_fin_consumed v_1_rx_fin_consumed)))
 (let (($x255959 (= v_2_rx_fin_done v_1_rx_fin_done)))
 (let (($x49071 (= v_2_rx_fin_offset v_1_rx_fin_offset)))
 (let (($x15554 (= v_2_rx_fin_seq v_1_rx_fin_seq)))
 (let (($x44406 (= v_2_rx_fin_pending v_1_rx_fin_pending)))
 (let (($x260250 (= v_2_fin_acknowledged v_1_fin_acknowledged)))
 (let (($x310647 (= v_2_fin_seq v_1_fin_seq)))
 (let (($x222070 (= v_2_fin_sent v_1_fin_sent)))
 (let (($x80103 (= v_2_fin_requested v_1_fin_requested)))
 (let (($x305076 (= v_2_ack_window_update v_1_ack_window_update)))
 (let (($x170611 (= v_2_ack_advance v_1_ack_advance)))
 (let (($x233660 (= v_2_ack_is_future v_1_ack_is_future)))
 (let (($x47120 (= v_2_ack_is_new v_1_ack_is_new)))
 (let (($x302620 (= v_2_ack_delta v_1_ack_delta)))
 (let (($x90137 (= v_2_seg_acceptable v_1_seg_acceptable)))
 (let (($x346225 (= v_2_rx_acceptable v_1_rx_acceptable)))
 (let (($x141147 (= v_2_rx_advance v_1_rx_advance)))
 (let (($x270364 (= v_2_rx_slot_15 v_1_rx_slot_15)))
 (let (($x489210 (= v_2_rx_slot_14 v_1_rx_slot_14)))
 (let (($x42565 (= v_2_rx_slot_13 v_1_rx_slot_13)))
 (let (($x254043 (= v_2_rx_slot_12 v_1_rx_slot_12)))
 (let (($x41984 (= v_2_rx_slot_11 v_1_rx_slot_11)))
 (let (($x200979 (= v_2_rx_slot_10 v_1_rx_slot_10)))
 (let (($x304146 (= v_2_rx_slot_09 v_1_rx_slot_09)))
 (let (($x113641 (= v_2_rx_slot_08 v_1_rx_slot_08)))
 (let (($x74075 (= v_2_rx_slot_07 v_1_rx_slot_07)))
 (let (($x35643 (= v_2_rx_slot_06 v_1_rx_slot_06)))
 (let (($x326936 (= v_2_rx_slot_05 v_1_rx_slot_05)))
 (let (($x182308 (= v_2_rx_slot_04 v_1_rx_slot_04)))
 (let (($x258776 (= v_2_rx_slot_03 v_1_rx_slot_03)))
 (let (($x48985 (= v_2_rx_slot_02 v_1_rx_slot_02)))
 (let (($x344212 (= v_2_rx_slot_01 v_1_rx_slot_01)))
 (let (($x233188 (= v_2_rx_slot_00 v_1_rx_slot_00)))
 (let (($x52220 (= v_2_rx_chunk v_1_rx_chunk)))
 (let (($x181105 (= v_2_take v_1_take)))
 (let (($x292972 (= v_2_snd_wl2 (_ bv1001 32))))
 (let (($x481884 (= v_2_snd_wl1 (_ bv9000 32))))
 (let (($x270876 (= v_2_snd_wnd 16)))
 (let (($x232842 (= v_2_rcv_buf v_1_rcv_buf)))
 (let (($x127095 (= v_2_rtx_buf v_1_rtx_buf)))
 (let (($x13987 (= v_2_snd_buf v_1_snd_buf)))
 (let (($x188609 (= v_2_local_window v_1_local_window)))
 (let (($x279173 (= v_2_msl_ms v_1_msl_ms)))
 (let (($x49738 (= v_2_user_timeout_ms v_1_user_timeout_ms)))
 (let (($x313261 (= v_2_active_open v_1_active_open)))
 (let (($x28571 (= v_2_retries v_1_retries)))
 (let (($x137928 (= v_2_tx_flags v_1_tx_flags)))
 (let (($x149658 (= v_2_tx_ack v_1_tx_ack)))
 (let (($x302793 (= v_2_tx_seq v_1_tx_seq)))
 (let (($x209953 (= v_2_rcv_nxt (_ bv9001 32))))
 (let (($x130138 (= v_2_snd_nxt v_1_snd_nxt)))
 (let (($x307896 (= v_2_snd_una (_ bv1001 32))))
 (let (($x390118 (= v_2_irs (_ bv9000 32))))
 (let (($x113703 (= v_2_iss v_1_iss)))
 (let (($x383951 (= 4 state_2)))
 (let (($x355341 (not active_1_time_wait)))
 (let (($x9778 (or $x355341 (not (<= due_1_time_wait 900)))))
 (let (($x126843 (or (not active_1_user) (not (<= due_1_user 900)))))
 (let (($x204888 (or (not active_1_rtx) (not (<= due_1_rtx 900)))))
 (let (($x391753 (= 0 v_1_retries)))
 (let (($x110601 (= v_1_snd_nxt (_ bv1001 32))))
 (let (($x143682 (= state_1 2)))
 (and $x143682 $x110601 $x391753 $x204888 $x126843 $x9778 $x383951 $x113703 $x390118 $x307896 $x130138 $x209953 $x302793 $x149658 $x137928 (= v_2_rto_ms (ite $x139813 ?x143376 v_1_rto_ms)) $x28571 $x313261 $x49738 $x279173 $x188609 $x13987 $x127095 $x232842 $x270876 $x481884 $x292972 $x181105 $x52220 $x233188 $x344212 $x48985 $x258776 $x182308 $x326936 $x35643 $x74075 $x113641 $x304146 $x200979 $x41984 $x254043 $x42565 $x489210 $x270364 $x141147 $x346225 $x90137 $x302620 $x47120 $x233660 $x170611 $x305076 $x80103 $x222070 $x310647 $x260250 $x44406 $x15554 $x49071 $x255959 $x18503 (= v_2_srtt_ms ?x302119) (= v_2_rttvar_ms ?x182845) (= v_2_rtt_error_ms ?x168598) $x288092 $x149817 (= v_2_rtt_measured (or v_1_rtt_measured $x139813)) $x94109 (= v_2_rtt_active (and v_1_rtt_active (not $x198281))) (= v_2_rtt_ambiguous (and (not $x198281) v_1_rtt_ambiguous)) (= v_2_rtt_sample_at_ms (ite $x139813 900 v_1_rtt_sample_at_ms)) $x145186 $x166505 (= v_2_rtt_remaining (ite $x198281 0 ?x94024)) $x78191 (= v_2_rtt_sample_used $x139813) $x37908 (= v_2_rtt_last_ms ?x210873) (= v_2_rtt_samples (+ v_1_rtt_samples (ite $x139813 1 0))) (= v_2_rto_base_ms (ite $x139813 ?x143376 v_1_rto_base_ms)) $x8384 $x298393 $x150184 $x208020 $x351752 $x157978 $x158524 $x309282 $x3682 $x146405 $x113668 $x411955 $x59488 $x221927 $x240732 $x305010 $x303345 $x85855 $x307425 $x36526 $x173262 $x170551 $x80165 $x843167 $x27008 $x376880 $x230527 $x310870 $x1169 $x124608 $x173218 $x345130 $x30313 $x51958))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
(assert
 true)
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
