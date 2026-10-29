; benchmark generated from python API
(set-info :status unknown)
(declare-fun ac_law_262_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_c () Bool)
(declare-fun ac_law_262_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_b () Bool)
(declare-fun ac_law_262_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_a () Bool)
(assert
 (let (($x53346 (or ac_law_262_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_b ac_law_262_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_c)))
(let (($x53344 (or ac_law_262_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_a $x53346)))
(let (($x53176 (or ac_law_262_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_a ac_law_262_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_b)))
(let (($x52982 (or $x53176 ac_law_262_49f411f0a1a7f7194924426f72b9f9d73f9e5b3dead2d2bb95c8614c9f923e6c_c)))
(not (= $x52982 $x53344)))))))
(check-sat)
