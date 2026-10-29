"""Operand certificates reject lost constraints, multiplicity and order faults."""
import unittest
import z3
from formal.ac_normalization import normalize, verify_certificate, law_queries


class ACNormalizationTests(unittest.TestCase):
    def test_nested_boolean_arithmetic_and_equality_permutations(self):
        a, b, c = z3.Bools('ac_test_a ac_test_b ac_test_c')
        x, y, w = z3.Ints('ac_test_x ac_test_y ac_test_w')
        for left, right in [(z3.And(a, z3.And(b, c)), z3.And(c, a, b)),
                            (z3.Or(a, z3.Or(b, c)), z3.Or(c, a, b)),
                            ((x + y) + w, w + (y + x)),
                            ((x * y) * w, w * (y * x)), (x == y, y == x)]:
            one, first = normalize(left); two, second = normalize(right)
            laws = verify_certificate(left, first) + verify_certificate(right, second)
            self.assertTrue(z3.eq(one, two))
            solver = z3.Solver(); solver.add(left != one); self.assertEqual(solver.check(), z3.unsat)
            for kind, sort in laws:
                for _, query in law_queries(kind, sort):
                    solver = z3.Solver(); solver.add(query); self.assertEqual(solver.check(), z3.unsat)

    def test_duplicate_operands_are_never_dropped(self):
        x, y = z3.Ints('ac_duplicate_x ac_duplicate_y'); source = x + x + y
        normalized, mapping = normalize(source); verify_certificate(source, mapping)
        solver = z3.Solver(); solver.add(normalized != 2 * x + y); self.assertEqual(solver.check(), z3.unsat)
        mapping[source.get_id()] = x + y
        with self.assertRaisesRegex(ValueError, 'multiplicity'): verify_certificate(source, mapping)

    def test_ordered_subtraction_and_leaves_cannot_be_swapped(self):
        x, y = z3.Ints('ac_order_x ac_order_y'); source = x - y
        _, mapping = normalize(source); mapping[source.get_id()] = y - x
        with self.assertRaisesRegex(ValueError, 'ordered children'): verify_certificate(source, mapping)
        _, mapping = normalize(source); mapping[x.get_id()] = y
        with self.assertRaisesRegex(ValueError, 'leaf'): verify_certificate(source, mapping)

    def test_boolean_operator_change_and_missing_node_rejected(self):
        a, b = z3.Bools('ac_fault_a ac_fault_b'); source = z3.And(a, b)
        _, mapping = normalize(source); mapping[source.get_id()] = z3.Or(a, b)
        with self.assertRaisesRegex(ValueError, 'operator'): verify_certificate(source, mapping)
        _, mapping = normalize(source); del mapping[a.get_id()]
        with self.assertRaisesRegex(ValueError, 'Missing'): verify_certificate(source, mapping)


if __name__ == '__main__': unittest.main(verbosity=2)
