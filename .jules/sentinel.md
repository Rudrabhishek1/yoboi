## 2024-06-30 - Insecure Remote JSON Deserialization
**Vulnerability:** The application parsed a remote JSON string via `jsonDecode` and immediately cast the top-level object to `List<dynamic>`, and its elements via `CustomFormulaData.fromMap`. Malformed or unexpected payload types (e.g. an Object instead of an Array) would throw a `TypeError` and crash the app.
**Learning:** Dart's `jsonDecode` returns `dynamic`. Implicit casting in a statically typed language provides a vector for DoS via remote configuration.
**Prevention:** Always verify top-level types (e.g., `if (decoded is! List)`) and validate element types explicitly (e.g., `item is Map<String, dynamic>`) before casting or mapping.
