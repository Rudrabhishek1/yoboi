## 2024-07-05 - Insecure Remote JSON Deserialization
**Vulnerability:** Remote config JSON payload was cast directly to `List<dynamic>` without validation.
**Learning:** Casting `dynamic` to expected types without `is` checks in Dart can cause runtime `TypeError` crashes, exposing the app to DoS from malformed remote data.
**Prevention:** Always verify top-level structure (e.g., `is List`) and use `.whereType<Map<String, dynamic>>()` for list elements before mapping to domain models.
