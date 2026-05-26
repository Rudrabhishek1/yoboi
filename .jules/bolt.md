## 2024-05-26 - Expression Parsing Overhead in Custom Formulas
**Learning:** Using `math_expressions` package, `Parser().parse(expression)` takes significant time. In repetitive evaluation loops or state recalculations, parsing the same formula every time creates an unnecessary overhead (benchmark showed 734ms vs 104ms for 10000 iterations).
**Action:** Always parse `math_expressions` expressions once and cache the resulting `Expression` object for reuse instead of calling `Parser().parse()` repeatedly during evaluations.
