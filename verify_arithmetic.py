"""Exact integer sanity check, separate from the Lean proof. Python 3.10+."""
from math import isqrt, prod
import json

def factor(n):
    remaining, p, result = n, 2, {}
    while p * p <= remaining:
        exponent = 0
        while remaining % p == 0:
            remaining //= p
            exponent += 1
        if exponent:
            result[p] = exponent
        p += 1
    if remaining > 1:
        result[remaining] = 1
    assert prod(p ** e for p, e in result.items()) == n
    return result

report = []
for n in (12167, 12168):
    factors = factor(n)
    root = isqrt(n)
    powerful = all(e >= 2 for e in factors.values())
    nonsquare = root * root < n < (root + 1) ** 2
    assert n > 0 and powerful and nonsquare
    report.append(dict(n=n, factors=factors, powerful=powerful,
                       nonsquare=nonsquare, lower_square=root * root,
                       upper_square=(root + 1) ** 2))
assert 12167 + 1 == 12168
assert 12167 == 23 ** 3
assert 12168 == 2 ** 3 * 3 ** 2 * 13 ** 2
print(json.dumps({'result': 'PASS', 'consecutive': True, 'witnesses': report}, indent=2))
