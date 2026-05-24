## 2025-02-12 - Math Expressions Parsing Overhead
**Learning:** Using `Parser().parse()` from the `math_expressions` package inside an evaluation loop (like `calculate`) introduces massive overhead (549ms vs 27ms for 10k iterations).
**Action:** Always parse the math expression string once into an `Expression` tree and cache it. Use `cachedExp ??= Parser().parse(expression);` so that different evaluations only need to re-bind variables and call `.evaluate()`.
