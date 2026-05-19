## 2024-05-19 - Missing Input Validation
**Vulnerability:** User-defined formula variables could contain spaces or special characters causing parsing errors or potentially unhandled behaviors in math_expressions.
**Learning:** The creation screen relied solely on `math_expressions` to catch invalid inputs during a test evaluation, but variables were not explicitly validated against expected identifier formats, which is a common source of bugs or expression injection.
**Prevention:** Always explicitly validate user-defined variable names against a strict alphanumeric regex (e.g. `^[a-zA-Z][a-zA-Z0-9]*$`) before passing them to parsing engines.
