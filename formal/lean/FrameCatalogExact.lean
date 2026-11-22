import FrameBlock0
import FrameBlock1
import FrameBlock2
import FrameBlock3
import FrameBlock4
import FrameBlock5
import FrameBlock6
import FrameBlock7
import FrameBlock8
import FrameBlock9
import FrameBlock10
import FrameBlock11
import FrameBlock12
import FrameBlock13
import FrameBlock14
import FrameBlock15
open FormalSpecAgent.GuardDiscriminators Approved TCPIPFrameCatalog
set_option maxRecDepth 16384 in
theorem frameCatalogExact : (residualPairs conflictGroup_4).map pairId = (TCPIPFramePairs.control ++ TCPIPFramePairs.data).map pairId := by
  rw [TCPIPFrameCatalog.merge_blocks, frameBlock0, frameBlock1, frameBlock2, frameBlock3, frameBlock4, frameBlock5, frameBlock6, frameBlock7, frameBlock8, frameBlock9, frameBlock10, frameBlock11, frameBlock12, frameBlock13, frameBlock14, frameBlock15]
  simp only [List.nil_append, List.append_nil, ← List.map_append, List.append_assoc, List.take_append_drop]
