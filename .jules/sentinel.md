## 2024-06-29 - Insecure Deserialization in Firebase Remote Config
**Vulnerability:** Missing structural validation (is List/is Map) on remote JSON payloads before casting and mapping to domain models.
**Learning:** Dart's dynamic typing during JSON deserialization will throw unhandled TypeErrors if the structure does not exactly match assumptions, leading to application crashes (DoS).
**Prevention:** Always verify the top-level JSON structure and iterate elements with explicit `is` checks before mapping to domain objects.
