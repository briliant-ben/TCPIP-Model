; benchmark generated from python API
(set-info :status unknown)
(declare-fun ac_law_261_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_c () Bool)
(declare-fun ac_law_261_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_b () Bool)
(declare-fun ac_law_261_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_a () Bool)
(assert
 (let (($x57535 (and ac_law_261_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_b ac_law_261_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_c)))
(let (($x57325 (and ac_law_261_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_a $x57535)))
(let (($x57536 (and ac_law_261_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_a ac_law_261_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_b)))
(let (($x57537 (and $x57536 ac_law_261_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_c)))
(not (= $x57537 $x57325)))))))
(check-sat)
