## 2024-05-24 - Prevent Insecure Deserialization Crashes
**Vulnerability:** App crashes due to `TypeError` when processing malformed JSON payloads from Firebase Remote Config.
**Learning:** Implicit casts (e.g. `as List<dynamic>`) and unsafe map lookups (e.g. `List.from(map['field'])`) without `is` checks cause unhandled exceptions during parsing.
**Prevention:** Always verify top-level JSON structures (`is List`) and use safe type conversions (`?.toString() ?? ''` and explicit `is` checks for collections) in factory constructors.
