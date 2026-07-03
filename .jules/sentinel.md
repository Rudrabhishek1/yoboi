## 2024-07-03 - Insecure JSON Deserialization Crash
**Vulnerability:** Unverified remote JSON payload structure leading to TypeError crashes.
**Learning:** `jsonDecode` returns `dynamic` which was blindly cast to `List<dynamic>` and mapped. Malicious or malformed remote config could trigger app-wide DoS.
**Prevention:** Always verify top-level structure (`is List`) and use `.whereType<Map<String, dynamic>>()` for element-level validation before mapping to models.
