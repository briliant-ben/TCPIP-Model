import TCPIPFramePairs
set_option maxRecDepth 65536 in
set_option maxHeartbeats 8000000 in
theorem frameBlock2 : TCPIPFrameCatalog.blockIds 2 = [] := by decide +kernel
