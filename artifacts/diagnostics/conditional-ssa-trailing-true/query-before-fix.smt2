; benchmark generated from python API
(set-info :status unknown)
(declare-fun a () Int)
(declare-fun b () Bool)
(declare-fun next () Int)
(assert
 (let ((?x14 (ite b (+ a 2) a)))
 (= next ?x14)))
(assert
 (not (= next (ite b (+ a 1) a))))
(assert
 b)
(check-sat)
