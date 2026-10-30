; benchmark generated from python API
(set-info :status unknown)
(declare-fun ac_law_521_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_c () Real)
(declare-fun ac_law_521_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_b () Real)
(declare-fun ac_law_521_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_a () Real)
(assert
 (let ((?x60800 (* ac_law_521_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_b ac_law_521_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_c)))
(let ((?x57518 (* ac_law_521_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_a ?x60800)))
(let ((?x42241 (* ac_law_521_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_a ac_law_521_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_b)))
(let ((?x54490 (* ?x42241 ac_law_521_e55fe37737b783cc821bb77a370950bb6a51dcf386ab6ee70d31808409ba412e_c)))
(not (= ?x54490 ?x57518)))))))
(check-sat)
