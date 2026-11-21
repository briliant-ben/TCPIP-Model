import TCPIPFramePairs
set_option maxRecDepth 65536 in
set_option maxHeartbeats 8000000 in
theorem frameBlock15 : TCPIPFrameCatalog.blockIds 15 = [] := by decide +kernel
