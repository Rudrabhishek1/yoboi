## 2026-05-15 - Missing validation on mathematical variable names
**Vulnerability:** User-defined mathematical formula variables were used directly in `Variable(v)` bindings without validation, opening up potential expression injection vulnerabilities or parser crashes in `math_expressions` package.
**Learning:** External or user-provided variables used in mathematical evaluations must be strictly validated to ensure they only contain safe, alphanumeric characters before passing them to the math parser context model.
**Prevention:** Always validate user-defined variable names against `RegExp(r'^[a-zA-Z][a-zA-Z0-9]*$')` before using them in math expressions bindings or evaluations.
