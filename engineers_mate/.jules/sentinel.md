## 2025-02-15 - Add input length limits to TextFields
**Vulnerability:** Multiple `TextField` widgets accepting mathematical/numeric expressions (e.g. Universal Solver, Converter, Creation Screen) lacked input length limits.
**Learning:** This exposes the application to a medium-severity Denial of Service (DoS) risk, where passing an excessively large string into parsing functions (or even just rendering them) can exhaust system memory or block the main isolate, causing the app to freeze or crash.
**Prevention:** Consistently apply `maxLength` properties to user-facing input forms, particularly for fields bound to math evaluation or conversion logic. Also use `inputFormatters` like `FilteringTextInputFormatter` to sanitize inputs to only valid characters.
