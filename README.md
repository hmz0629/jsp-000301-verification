# JSP-000301: a verified classical counterexample

## Result and scope

The answer to the catalog's question is **no**. Set

\[
n=12167=23^3,\qquad n+1=12168=2^3\cdot3^2\cdot13^2.
\]

A positive integer is powerful if every prime divisor has its square as a divisor.
The displayed prime factorizations show that both integers are powerful. Also,

\[
110^2=12100<12167<12168<12321=111^2.
\]

Consequently neither integer is a square. This is a complete counterexample to
the catalog's yes/no assertion. It does not address the separate asymptotic
counting question in Erdős problem #365.

## Attribution and submission status

The counterexample is already recorded in the
[Justin Sun Prize catalog](https://github.com/TheJustinSunPrize/awards/blob/main/problems/catalog-0301-0400.md#JSP-000301).
That catalog cites classical literature, including Golomb (1970), Walker (1976),
and Guy (2004); this package does not independently establish first discovery
or which historical source first contained this exact pair.

Existing public submissions include
[correction #63](https://github.com/TheJustinSunPrize/awards/issues/63) and
[formalization nomination #64](https://github.com/TheJustinSunPrize/awards/issues/64).
This package is AI-assisted supplementary verification. It claims neither
mathematical novelty, first formalization, an independently reviewed award
nomination, nor entitlement to payment. The existing formalization was consulted
as public context; this file uses a finite prime-factor certificate proof route.

The supplementary comment is intended for existing correction issue #63,
avoiding a duplicate issue. Actual publication is established by the public
discussion and, once posted, `submission-receipt.json`.
`submission-comment.md` contains the English submission text and proof source.

## Formal statement

`JSP000301.Powerful n` is explicitly defined as

```lean
0 < n ∧ ∀ p : ℕ, Nat.Prime p → p ∣ n → p ^ 2 ∣ n
```

The statement quantifies over **all** natural-number primes. The finite
prime-factor certificate is connected to that unbounded statement using
Mathlib's `Nat.mem_primeFactors` equivalence. It is not a bounded substitute
for the problem.

`JSP000301.counterexample` states the existence of consecutive positive
powerful nonsquares. `JSP000301.conjecture_false` explicitly negates the universal
assertion. Squarehood uses Mathlib's `IsSquare`.

## Reproduce locally

Install Lean/Elan from the official Lean distribution, then in this directory run:

```sh
lake update
lake exe cache get
lake build
lake env lean Proof.lean
python verify_arithmetic.py
```

The toolchain is pinned to Lean 4.34.0. The Mathlib source is pinned to commit
`5ed2965256430c3649e86755f9576b54eca72435` in `lakefile.lean`.

## Verification actually performed

On 2026-09-17, the exact `Proof.lean` in this package was sent via the standard
Lean language-server protocol to the official
[Lean playground](https://live.lean-lang.org/), project `mathlib-stable`.
The final diagnostics contain no errors or warnings. Both main theorems report
exactly these axiom dependencies:

```text
[propext, Classical.choice, Quot.sound]
```

No `sorryAx`, custom proof axiom, `native_decide`, or native computation axiom is
used. The source uses `simp`, `decide`, and `norm_num` to construct checked proofs.
The source file includes axiom-audit commands and a completion marker.

`Proof.remote-log.json` is the actual language-server response log.
`verification.json` records the source SHA-256, checker version, and result.
`environment/` stores the toolchain and manifest returned by that service.
`arithmetic-check.json` is a separate exact-integer Python check.

This was a remote Lean elaboration/check, **not a local `lake build`**. The local
runtime download timed out, so no successful local build is claimed. The remote
log is not a signed attestation or independent human review, and Mathlib's
imported library was not rebuilt or independently kernel-rechecked here.

## License

The newly written code is MIT-licensed; see `LICENSE`.
The newly written explanatory prose is offered under CC BY 4.0.
The problem statement and classical witness are attributed to The Justin Sun
Prize contributors' catalog, accessed 2026-09-17. Their documentation/data
license is [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
No authorship claim is made over the classical mathematical result.
