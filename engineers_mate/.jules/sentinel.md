## 2024-05-27 - Secure JSON Deserialization
**Vulnerability:** Application crash (DoS) from type casting error when processing malformed remote JSON payload.
**Learning:** Dart's strong typing causes runtime exceptions if `jsonDecode` output structure isn't explicitly validated (`is List`, `whereType<Map<String, dynamic>>`) before casting.
**Prevention:** Always verify top-level structure and element types of remote JSON payloads before deserializing to domain models.
