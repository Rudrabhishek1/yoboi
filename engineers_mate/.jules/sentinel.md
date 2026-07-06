## 2024-07-06 - Insecure JSON Deserialization of Remote Config
**Vulnerability:** The application blindly cast remote JSON payloads to `List<dynamic>` and mapped elements directly to domain models, leading to a potential DoS via `TypeError` crashes.
**Learning:** Dart's strong typing makes unchecked deserialization from external sources (like Firebase Remote Config) a significant stability and security risk.
**Prevention:** Always verify top-level structure (e.g., `is List`) and use `.whereType<Map<String, dynamic>>()` or explicit `is` checks before parsing list elements into objects.
