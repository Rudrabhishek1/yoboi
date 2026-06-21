## 2025-02-23 - Insecure Deserialization of Remote Configs
**Vulnerability:** External JSON payloads were cast without type checks or safe defaults, risking a Type/Null crash (DoS).
**Learning:** In Dart, `jsonDecode` returns `dynamic`. Blindly casting elements to `Map<String, dynamic>` or blindly accessing keys as non-nullable `String` will crash if the data is tampered with or malformed.
**Prevention:** Always verify top-level structures (e.g., `is List`) and ensure list elements are `Map<String, dynamic>` before mapping. Use safe fallback operators (`?.toString() ?? ''`) and `is List` checks for sub-fields.
