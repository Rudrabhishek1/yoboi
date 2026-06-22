## 2024-05-24 - Math Expressions Parsing Overhead
**Learning:** Parsing mathematical expressions using `Parser().parse()` from the `math_expressions` package is computationally expensive. Doing this repeatedly inside the `calculate` closure of a generated `Formula` model re-parses the same string on every calculation update.
**Action:** Cache the parsed `Expression` object using lazy initialization (e.g., `cachedExp ??= Parser().parse(expression);`) inside the calculation function to avoid repeated parsing overhead while deferring initialization errors.
