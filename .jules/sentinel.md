## 2024-06-08 - Secure JSON Deserialization
**Vulnerability:** Insecure deserialization of remote JSON payloads causing unhandled TypeError crashes (DoS).
**Learning:** Dart's implicit downcasting and `List.from` throw runtime exceptions on malformed JSON, crashing the app if not properly validated.
**Prevention:** Always verify top-level structure (`is List`) and use safe conversion (`?.toString() ?? ''`) with explicit type checking (`is List`) for collections in factory constructors.
