## 2024-05-24 - Insecure Deserialization Causes App Crashes
**Vulnerability:** Remote JSON payloads (Firebase Remote Config) were mapped to domain models without validating the top-level structure or collection field types, leading to potential `TypeError` app crashes if data was malformed.
**Learning:** In Dart, dynamic type casting (like `as List?` or mapping without `is` checks) on remote payloads throws fatal TypeErrors if the external input differs from expected schema.
**Prevention:** Always verify top-level payload structures (`is List`), ensure list elements are `Map<String, dynamic>`, and harden factory constructors with type checks (`is List`) and safe string conversions (`?.toString() ?? ''`).
