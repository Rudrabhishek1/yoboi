## 2024-07-07 - Secure Remote JSON Deserialization
**Vulnerability:** Insecure deserialization in `FirebaseService.fetchRemoteFormulas` where `jsonDecode` output was blindly assumed to be a `List<dynamic>` of `Map<String, dynamic>`.
**Learning:** Dart's dynamic typing allows malicious or malformed remote configurations to crash the application at runtime with TypeErrors if types are not strictly validated before mapping.
**Prevention:** Always verify the top-level structure (e.g., `is List`) and ensure elements are the correct type (e.g., `whereType<Map<String, dynamic>>()`) before mapping remote JSON to domain models.
