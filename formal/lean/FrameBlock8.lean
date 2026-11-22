import TCPIPFramePairs
set_option maxRecDepth 65536 in
set_option maxHeartbeats 8000000 in
theorem frameBlock8 : TCPIPFrameCatalog.blockIds 8 = [] := by decide +kernel
