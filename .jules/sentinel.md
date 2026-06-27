## 2024-05-24 - Harden External JSON Payload Parsing
**Vulnerability:** Application crashes (DoS risk) due to missing type validation when deserializing external/remote JSON payloads in `firebase_service.dart` and `custom_formulas_provider.dart`.
**Learning:** Using `as List?` or omitting explicit type casting `whereType<Map<String, dynamic>>()` on dynamically loaded JSON causes `TypeError` crashes if the payload is malformed or maliciously modified.
**Prevention:** Always verify the top-level structure of JSON payloads (e.g., `is List`) and use safe conversion operators (`?.toString() ?? ''` and explicit `is` checks for collections) inside factory constructors.
