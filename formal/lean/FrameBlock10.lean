import TCPIPFramePairs
set_option maxRecDepth 65536 in
set_option maxHeartbeats 8000000 in
theorem frameBlock10 : TCPIPFrameCatalog.blockIds 10 = (TCPIPFramePairs.data.take 13).map TCPIPFrameCatalog.pairId := by decide +kernel
