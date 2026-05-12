## 2024-05-12 - Missing Input Validation in Formula Variables

**Vulnerability:**
The custom formula creation feature in `FormulaCreationScreen` accepted unvalidated variable names from user input (e.g., `1a`, `a+b`). These variables were passed directly into the math expression evaluation logic (`math_expressions` parser) without validation, potentially leading to parsing errors, unexpected behavior, or logic vulnerabilities.

**Learning:**
Even if an expression evaluation library contains built-in parsing logic, all components of the input (especially variable identifiers) must be strictly validated at the application boundary to conform to expected formats (e.g., standard programming identifier rules).

**Prevention:**
Enforce strict input validation using regular expressions (e.g., `RegExp(r'^[a-zA-Z][a-zA-Z0-9]*$')`) on variable names to ensure they start with a letter and contain only alphanumeric characters *before* they are processed or evaluated by the expression engine.
