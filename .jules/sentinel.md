## 2024-05-16 - Missing Input Validation on Custom Formula Variables
**Vulnerability:** User-defined formula variables in FormulaCreationScreen lack validation, allowing arbitrary characters (e.g., spaces, operators) which can break mathematical parsing and cause app crashes or bad state errors in `math_expressions`.
**Learning:** `math_expressions` package expects variables to be properly formatted identifiers. When inputs are not validated, it can lead to unhandled exceptions when binding variables or parsing expressions.
**Prevention:** Always validate user-provided variable names using `RegExp(r'^[a-zA-Z][a-zA-Z0-9]*$')` to ensure they start with a letter and contain only alphanumeric characters before being parsed.
