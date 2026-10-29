; benchmark generated from python API
(set-info :status unknown)
(declare-fun ac_law_521_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_c () Real)
(declare-fun ac_law_521_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_b () Real)
(declare-fun ac_law_521_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_a () Real)
(assert
 (let ((?x38165 (* ac_law_521_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_b ac_law_521_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_c)))
(let ((?x50301 (* ac_law_521_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_a ?x38165)))
(let ((?x37293 (* ac_law_521_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_a ac_law_521_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_b)))
(let ((?x48754 (* ?x37293 ac_law_521_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_c)))
(not (= ?x48754 ?x50301)))))))
(check-sat)
