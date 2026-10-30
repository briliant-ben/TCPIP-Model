; benchmark generated from python API
(set-info :status unknown)
(declare-fun ac_law_518_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_c () Real)
(declare-fun ac_law_518_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_b () Real)
(declare-fun ac_law_518_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_a () Real)
(assert
 (let ((?x54169 (+ ac_law_518_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_b ac_law_518_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_c)))
(let ((?x42241 (+ ac_law_518_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_a ?x54169)))
(let ((?x49917 (+ ac_law_518_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_a ac_law_518_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_b)))
(let ((?x57618 (+ ?x49917 ac_law_518_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_c)))
(not (= ?x57618 ?x42241)))))))
(check-sat)
