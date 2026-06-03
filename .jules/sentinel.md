## 2024-06-03 - Insecure Deserialization of External JSON Payloads
**Vulnerability:** External JSON payloads from Firebase Remote Config were implicitly cast to `List<dynamic>` and mapped without type checking.
**Learning:** In Dart, assuming JSON structure without explicit `is` checks causes runtime `TypeError` crashes if the payload is malformed (e.g., returning a Map instead of a List), leading to application DoS.
**Prevention:** Always verify top-level structure with `is List`, filter valid elements using `whereType<Map<String, dynamic>>()`, and use safe conversion operators (`?.toString() ?? ''`) and explicit type checks in factory constructors (e.g., `map['field'] is List`).
