## 2025-02-12 - Insecure Deserialization in Remote Formulas
**Vulnerability:** Remote JSON payloads in `FirebaseService` were deserialized and cast without validating top-level structure or element types, and `CustomFormulaData.fromMap` lacked type checking for collections, risking app crashes (DoS) from type errors.
**Learning:** In Dart, casting dynamic elements implicitly or using `as List?` without checks throws `TypeError` on invalid data. External data sources cannot be trusted to maintain expected schemas.
**Prevention:** Always verify top-level structures (`is List`) and ensure list elements match expected types (`is Map<String, dynamic>`) before mapping. Harden factory constructors with safe conversion operators (`?.toString() ?? ''`) and collection type checks (`is List`).
