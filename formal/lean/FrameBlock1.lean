import TCPIPFramePairs
set_option maxRecDepth 65536 in
set_option maxHeartbeats 8000000 in
theorem frameBlock1 : TCPIPFrameCatalog.blockIds 1 = [] := by decide +kernel
