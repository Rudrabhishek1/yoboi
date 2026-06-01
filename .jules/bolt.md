## 2024-05-23 - Lazy initialization for math expressions parsing
**Learning:** In Dart, using the `math_expressions` package, `Parser().parse()` is a computationally expensive operation that should not be run on every calculation. Eagerly caching it during initialization can lead to app crashes if the formula is temporarily invalid during build time.
**Action:** Use lazy initialization (e.g., `cachedExp ??= Parser().parse(expression)`) inside the calculation function to defer parsing exceptions to calculation time and prevent redundant parsing.
