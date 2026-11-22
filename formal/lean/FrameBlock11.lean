import TCPIPFramePairs
set_option maxRecDepth 65536 in
set_option maxHeartbeats 8000000 in
theorem frameBlock11 : TCPIPFrameCatalog.blockIds 11 = (TCPIPFramePairs.data.drop 13).map TCPIPFrameCatalog.pairId := by decide +kernel
