import TCPIPFramePairs
set_option maxRecDepth 65536 in
set_option maxHeartbeats 8000000 in
theorem frameBlock3 : TCPIPFrameCatalog.blockIds 3 = [] := by decide +kernel
