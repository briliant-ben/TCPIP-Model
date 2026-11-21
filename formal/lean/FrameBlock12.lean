import TCPIPFramePairs
set_option maxRecDepth 65536 in
set_option maxHeartbeats 8000000 in
theorem frameBlock12 : TCPIPFrameCatalog.blockIds 12 = [] := by decide +kernel
