; benchmark generated from python API
(set-info :status unknown)
(define-funs-rec ( ( ir4_ones_sum16_checksum_instance!0
                     ((x!1 (Seq (_ BitVec 8))))
                     (_ BitVec 16)))
                 ( (let ((a!1 (concat (seq.nth x!1 0)
                                      (ite (> (seq.len x!1) 1)
                                           (seq.nth x!1 1)
                                           #x00)))
                         (a!2 (seq.extract x!1
                                           2
                                           (ite (> (seq.len x!1) 2)
                                                (- (seq.len x!1) 2)
                                                0))))
                   (let ((a!3 ((_ extract 15 0)
                                (bvadd ((_ zero_extend 1) a!1)
                                       ((_ zero_extend 1)
                                         ((_ ir4_ones_sum16_checksum_instance!0
                                             0)
                                           a!2)))))
                         (a!4 ((_ extract 16 16)
                                (bvadd ((_ zero_extend 1) a!1)
                                       ((_ zero_extend 1)
                                         ((_ ir4_ones_sum16_checksum_instance!0
                                             0)
                                           a!2))))))
                     (ite (= (seq.len x!1) 0)
                          #x0000
                          (bvadd a!3 ((_ zero_extend 15) a!4)))))))
(assert
 (let ((?x106 (seq.unit (_ bv255 8))))
(let ((?x108 (seq.++ ?x106 (seq.++ ?x106 ?x106))))
(let ((?x111 (ubv_to_int (bvnot ((_ ir4_ones_sum16_checksum_instance!0 0) ?x108)))))
(and (distinct ?x111 255) true)))))
(check-sat)
