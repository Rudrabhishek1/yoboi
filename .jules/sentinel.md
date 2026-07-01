## 2024-10-24 - Insecure Remote JSON Deserialization
**Vulnerability:** The application implicitly casted remote JSON payloads to `List<dynamic>` and mapped elements to domain models without verifying the structural integrity.
**Learning:** Dart's `jsonDecode` returns `dynamic`, which when forcibly cast without type checking, can cause `TypeError` crashes during deserialization if the remote payload is malformed or maliciously manipulated.
**Prevention:** Always use explicit `is List` and `is Map<String, dynamic>` checks on untrusted remote JSON payloads before attempting to deserialize them into domain models.
