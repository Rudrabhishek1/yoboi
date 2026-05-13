## 2024-05-13 - [HIGH] Fix missing input validation on formula variables
**Vulnerability:** Missing input validation on user-defined variable names allowed special characters, which could lead to exceptions and potential Denial-of-Service crashes when `math_expressions` parser attempted to process the invalid names.
**Learning:** Even internal libraries (like `math_expressions`) can throw exceptions when supplied with un-validated input mappings, causing the UI layer to fail unsafely if not caught early enough.
**Prevention:** Always sanitize/validate input schemas strictly *before* passing user-supplied values into third-party logic parsers.
