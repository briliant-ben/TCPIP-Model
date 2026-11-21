import TCPIPFramePairs
set_option maxRecDepth 65536 in
set_option maxHeartbeats 8000000 in
theorem frameBlock13 : TCPIPFrameCatalog.blockIds 13 = [] := by decide +kernel
