## 2024-10-24 - Harden JSON Deserialization
**Vulnerability:** External JSON payloads from Firebase Remote Config were blindly cast to `List<dynamic>` and passed to domain models without type checking or structure verification, risking `TypeError` crashes.
**Learning:** Dart's dynamic typing during JSON parsing requires explicit structure validation (e.g., `is List`, `is Map<String, dynamic>`) and safe fallback conversion operators before casting, otherwise malformed remote configs can hard-crash the client app.
**Prevention:** Always verify top-level JSON structures (`is List` or `is Map`), use safe type checks (`is List` before casting nested lists), and use safe conversion operators (`?.toString() ?? ''`) when mapping external data to typed domain models.
