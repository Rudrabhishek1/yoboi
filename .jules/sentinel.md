## 2024-06-20 - Insecure JSON Deserialization in Firebase Service
**Vulnerability:** Remote JSON payloads from Firebase Remote Config were directly cast to lists and maps without validation, leading to potential `TypeError` crashes (DoS) if malformed data was received.
**Learning:** Dart's dynamic typing during JSON decoding requires explicit `is` checks for collections and safe fallback operators (`?.toString() ?? ''`) to prevent runtime exceptions from external payloads.
**Prevention:** Always verify the top-level JSON structure (`is List`) and element types (`whereType<Map<String, dynamic>>().map(...)`) before mapping to domain models. Harden factory constructors with explicit collection type checks (`map['field'] is List`).
