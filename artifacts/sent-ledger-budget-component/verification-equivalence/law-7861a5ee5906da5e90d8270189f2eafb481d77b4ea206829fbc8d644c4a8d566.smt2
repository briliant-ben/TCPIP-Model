; benchmark generated from python API
(set-info :status unknown)
(declare-fun ac_law_262_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_c () Bool)
(declare-fun ac_law_262_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_b () Bool)
(declare-fun ac_law_262_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_a () Bool)
(assert
 (let (($x54613 (or ac_law_262_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_b ac_law_262_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_c)))
(let (($x54599 (or ac_law_262_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_a $x54613)))
(let (($x53884 (or ac_law_262_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_a ac_law_262_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_b)))
(let (($x54405 (or $x53884 ac_law_262_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_c)))
(not (= $x54405 $x54599)))))))
(check-sat)
