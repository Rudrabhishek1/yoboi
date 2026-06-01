## 2024-06-01 - Type Casting Vulnerability in JSON Processing
**Vulnerability:** External JSON payloads parsed without explicit type checks (e.g. `as List?`) can cause runtime `TypeError` crashes if the malformed input structure does not match expected types.
**Learning:** Dart's dynamic type system with external JSON requires strict validation. An unvalidated structure can easily take down the app via untrapped runtime errors during the deserialization phase.
**Prevention:** Always verify top-level structures (`is List`) and ensure elements are typed explicitly (e.g. `map['field'] is List`) before casting. Use fallback operators (`?.toString() ?? ''`) to prevent cascading failures.
