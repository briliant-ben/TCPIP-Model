; benchmark generated from python API
(set-info :status unknown)
(declare-fun ac_law_518_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_c () Real)
(declare-fun ac_law_518_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_b () Real)
(declare-fun ac_law_518_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_a () Real)
(assert
 (let ((?x39067 (+ ac_law_518_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_b ac_law_518_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_c)))
(let ((?x37293 (+ ac_law_518_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_a ?x39067)))
(let ((?x38964 (+ ac_law_518_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_a ac_law_518_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_b)))
(let ((?x53422 (+ ?x38964 ac_law_518_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_c)))
(not (= ?x53422 ?x37293)))))))
(check-sat)
