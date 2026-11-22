import TCPIPFramePairs
set_option maxRecDepth 65536 in
set_option maxHeartbeats 8000000 in
theorem frameBlock7 : TCPIPFrameCatalog.blockIds 7 = [] := by decide +kernel
