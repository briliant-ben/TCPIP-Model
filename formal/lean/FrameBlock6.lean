import TCPIPFramePairs
set_option maxRecDepth 65536 in
set_option maxHeartbeats 8000000 in
theorem frameBlock6 : TCPIPFrameCatalog.blockIds 6 = (TCPIPFramePairs.control.drop 3).map TCPIPFrameCatalog.pairId := by decide +kernel
