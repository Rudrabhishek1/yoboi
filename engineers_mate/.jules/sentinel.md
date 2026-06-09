
## 2024-06-09 - Insecure Deserialization of Remote Config
**Vulnerability:** The application blindly casted JSON data from Firebase Remote Config into strongly typed objects without structural validation. Malformed JSON payloads (e.g., non-list root, missing fields, incorrect types) would cause unhandled `TypeError` exceptions, crashing the app (DoS).
**Learning:** Dart's dynamic JSON deserialization combined with aggressive type casting (`as List`, implicit map access) creates brittle endpoints. Remote configuration must be treated as untrusted user input.
**Prevention:** Always verify the top-level structure of JSON payloads (`is List`, `is Map`), filter collection items using type checks (`is Map<String, dynamic>`), and harden factory constructors with safe fallbacks (`?.toString() ?? ''`) to handle missing or incorrectly typed fields safely.
