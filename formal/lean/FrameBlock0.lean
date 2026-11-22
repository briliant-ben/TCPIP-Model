import TCPIPFramePairs
set_option maxRecDepth 65536 in
set_option maxHeartbeats 8000000 in
theorem frameBlock0 : TCPIPFrameCatalog.blockIds 0 = [] := by decide +kernel
