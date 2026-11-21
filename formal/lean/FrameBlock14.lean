import TCPIPFramePairs
set_option maxRecDepth 65536 in
set_option maxHeartbeats 8000000 in
theorem frameBlock14 : TCPIPFrameCatalog.blockIds 14 = [] := by decide +kernel
