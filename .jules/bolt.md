## 2025-02-18 - Caching Parsed Expressions

**Learning:** Parsing mathematical expressions with `math_expressions` via `Parser().parse()` is computationally expensive. Eagerly parsing inside a calculation callback inside a Flutter build cycle/state update can cause significant overhead, as seen in `CustomFormulaData.toFormula()`.
**Action:** Use lazy initialization with a closure variable to cache the parsed `Expression` (`cachedExpression ??= Parser().parse(expression);`) so parsing only occurs once per formula rather than on every evaluation.
