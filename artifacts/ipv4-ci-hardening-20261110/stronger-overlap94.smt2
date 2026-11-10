; benchmark generated from python API
(set-info :status unknown)
(declare-fun input_0_L.net.frame_frame () (Seq (_ BitVec 8)))
(assert
 (let ((?x217 (seq.unit (_ bv8 8))))
 (let ((?x269 (seq.++ ?x217 (seq.++ (seq.unit (_ bv0 8)) (seq.++ (seq.unit (_ bv6 8)) (seq.unit (_ bv4 8)))))))
 (let ((?x172 (seq.unit (_ bv1 8))))
 (let ((?x34 (seq.unit (_ bv0 8))))
 (let ((?x264 (seq.unit (_ bv6 8))))
 (= (seq.extract input_0_L.net.frame_frame 12 8) (seq.++ ?x217 (seq.++ ?x264 (seq.++ ?x34 (seq.++ ?x172 ?x269)))))))))))
(assert
 (let ((?x34 (seq.unit (_ bv0 8))))
(let ((?x221 (seq.++ ?x34 (seq.++ ?x34 (seq.++ (seq.unit (_ bv2 8)) (seq.++ (seq.unit (_ bv8 8)) ?x34))))))
(let ((?x174 (seq.unit (_ bv2 8))))
(let ((?x172 (seq.unit (_ bv1 8))))
(let ((?x226 (seq.++ ?x34 (seq.++ ?x172 (seq.++ ?x174 (seq.++ ?x34 (seq.++ ?x34 ?x221)))))))
(let ((?x231 (seq.extract input_0_L.net.frame_frame 0 14)))
(= ?x231 (seq.++ ?x174 (seq.++ ?x34 (seq.++ ?x34 (seq.++ ?x34 ?x226))))))))))))
(check-sat)
