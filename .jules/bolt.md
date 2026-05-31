## 2024-05-30 - Caching parsed math expressions
**Learning:** `math_expressions`'s `Parser().parse()` is extremely computationally expensive. Eagerly or repeatedly parsing the same string inside high-frequency operations (like `calculate()` inside UI callbacks or tight loops) creates a severe performance bottleneck.
**Action:** Always lazily parse math expressions once (e.g., using `cachedExp ??= Parser().parse(expression);`) and reuse the cached `Expression` object by passing different `ContextModel`s to the `evaluate()` method.
