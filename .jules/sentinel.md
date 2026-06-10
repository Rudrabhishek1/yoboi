## 2024-05-24 - Insecure JSON Deserialization Crashes
**Vulnerability:** Remote Config JSON payloads were decoded and mapped directly to domain models without structure or type verification, leading to `TypeError` crashes on malformed data.
**Learning:** Dart's dynamic typing during JSON parsing allows implicit casts that fail at runtime (e.g., casting a String to a List, or null to a non-nullable String) if the remote payload doesn't strictly match expectations.
**Prevention:** Always verify the top-level structure of parsed JSON using explicit `is` checks (e.g., `is List`) and use safe conversion operators (e.g., `?.toString() ?? ''`) inside factory constructors.
