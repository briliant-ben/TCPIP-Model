import TCPIPFramePairs
set_option maxRecDepth 65536 in
set_option maxHeartbeats 8000000 in
theorem frameBlock4 : TCPIPFrameCatalog.blockIds 4 = [] := by decide +kernel
