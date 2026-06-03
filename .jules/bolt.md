## 2024-05-24 - math_expressions Parser.parse bottleneck
**Learning:** The `Parser().parse()` method in Dart's `math_expressions` package is extremely computationally expensive. In benchmarking, parsing took over 30x longer than evaluation. Re-parsing expressions inside reactive computation closures (like `calculate()` for formulas) can cause significant thread overhead.
**Action:** Always parse the string expression once during object initialization or lazily, cache the resulting `Expression` AST object, and reuse it across multiple evaluations by only varying the `ContextModel`.
