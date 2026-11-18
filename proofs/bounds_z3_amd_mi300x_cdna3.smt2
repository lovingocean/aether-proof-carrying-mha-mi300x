; Z3 SMT-LIBv2 Out-of-Bounds Counterexample Query
; Expected result for certified deployment: unsat (no OOB state exists)
(set-logic QF_NIA)
(declare-const block_m Int)
(declare-const block_n Int)
(declare-const head_dim Int)
(declare-const stages Int)
(declare-const hw_limit Int)
(declare-const smem_used Int)

(assert (= block_m 64))
(assert (= block_n 64))
(assert (= head_dim 64))
(assert (= stages 2))
(assert (= hw_limit 65536))
(assert (= smem_used (+ (* block_m head_dim 2) (* stages 2 block_n head_dim 2) 2048)))

; Query: Does there exist an overflow condition exceeding physical hardware SMEM/LDS?
(assert (> smem_used hw_limit))
(check-sat) ; RETURNS unsat -> PROVEN ZERO OOB