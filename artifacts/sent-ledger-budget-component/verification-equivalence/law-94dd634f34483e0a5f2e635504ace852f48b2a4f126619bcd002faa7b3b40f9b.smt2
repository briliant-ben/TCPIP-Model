; benchmark generated from python API
(set-info :status unknown)
(declare-fun ac_law_261_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_c () Bool)
(declare-fun ac_law_261_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_b () Bool)
(declare-fun ac_law_261_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_a () Bool)
(assert
 (let (($x54404 (and ac_law_261_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_b ac_law_261_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_c)))
(let (($x53884 (and ac_law_261_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_a $x54404)))
(let (($x54585 (and ac_law_261_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_a ac_law_261_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_b)))
(let (($x54612 (and $x54585 ac_law_261_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_c)))
(not (= $x54612 $x53884)))))))
(check-sat)
