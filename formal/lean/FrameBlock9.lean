import TCPIPFramePairs
set_option maxRecDepth 65536 in
set_option maxHeartbeats 8000000 in
theorem frameBlock9 : TCPIPFrameCatalog.blockIds 9 = [] := by decide +kernel
