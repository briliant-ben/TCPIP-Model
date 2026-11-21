import TCPIPFramePairs
set_option maxRecDepth 65536 in
set_option maxHeartbeats 8000000 in
theorem frameBlock5 : TCPIPFrameCatalog.blockIds 5 = (TCPIPFramePairs.control.take 3).map TCPIPFrameCatalog.pairId := by decide +kernel
