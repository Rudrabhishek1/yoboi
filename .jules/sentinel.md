## 2024-05-23 - Prevent DoS from Malformed JSON Deserialization
**Vulnerability:** The app parsed external JSON data (from Firebase Remote Config) and blindly casted fields without validation, which causes unhandled TypeError exceptions and app crashes if the JSON payload is malformed or maliciously modified.
**Learning:** Dart's strong typing means that invalid casts during deserialization throw runtime exceptions. jsonDecode returns dynamic, so explicit type checking (e.g. is List, is Map) is required before mapping to domain models to prevent Denial of Service (DoS) via crash.
**Prevention:** Always use explicit type checks for collections and safe conversion operators (?.toString() ?? '') when parsing external or untrusted JSON payloads in Dart factory constructors.
