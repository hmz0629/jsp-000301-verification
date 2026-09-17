/-
SPDX-License-Identifier: MIT

Supplementary formal verification of the classical counterexample in JSP-000301.
The witness is already recorded by The Justin Sun Prize contributors and in
earlier submissions, including awards issues #63 and #64. No mathematical
discovery, priority, or award entitlement is claimed here.

This file uses a finite prime-factor certificate, connected to the unbounded
definition below by Mathlib's Nat.mem_primeFactors theorem.
-/
import Mathlib

namespace JSP000301

/-- A positive integer is powerful when every prime divisor has its square
as a divisor. This quantifies over all natural-number primes. -/
def Powerful (n : ℕ) : Prop :=
  0 < n ∧ ∀ p : ℕ, Nat.Prime p → p ∣ n → p ^ 2 ∣ n

theorem powerful_of_certificate {n : ℕ} (hn : 0 < n)
    (cert : ∀ p ∈ n.primeFactors, p ^ 2 ∣ n) : Powerful n := by
  refine ⟨hn, ?_⟩
  intro p hp hpn
  exact cert p (Nat.mem_primeFactors.mpr ⟨hp, hpn, Nat.ne_of_gt hn⟩)

theorem powerful_12167 : Powerful 12167 := by
  apply powerful_of_certificate (by decide)
  have hf : (12167 : ℕ).primeFactors = {23} := by simp [Nat.primeFactors]
  rw [hf]
  decide

theorem powerful_12168 : Powerful 12168 := by
  apply powerful_of_certificate (by decide)
  have hf : (12168 : ℕ).primeFactors = {2, 3, 13} := by simp [Nat.primeFactors]
  rw [hf]
  decide

theorem factorizations :
    (12167 : ℕ) = 23 ^ 3 ∧ 12168 = 2 ^ 3 * 3 ^ 2 * 13 ^ 2 := by
  decide

theorem neither_square :
    ¬ IsSquare (12167 : ℕ) ∧ ¬ IsSquare (12168 : ℕ) := by
  norm_num

/-- Exact negative answer to the catalog's yes/no question. -/
theorem counterexample :
    ∃ n : ℕ, 0 < n ∧ Powerful n ∧ Powerful (n + 1) ∧
      ¬ IsSquare n ∧ ¬ IsSquare (n + 1) := by
  exact ⟨12167, by decide, powerful_12167, powerful_12168,
    neither_square.1, neither_square.2⟩

theorem conjecture_false :
    ¬ (∀ n : ℕ, 0 < n → Powerful n → Powerful (n + 1) →
      IsSquare n ∨ IsSquare (n + 1)) := by
  intro h
  rcases h 12167 (by decide) powerful_12167 powerful_12168 with h1 | h2
  · exact neither_square.1 h1
  · exact neither_square.2 h2

end JSP000301

#print axioms JSP000301.counterexample
#print axioms JSP000301.conjecture_false
#eval Lean.versionString
#eval "CHECK_COMPLETE"
