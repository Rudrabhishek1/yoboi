## 2024-05-24 - Insecure Deserialization in Dart
**Vulnerability:** Insecure deserialization of remote JSON payloads in `FirebaseService` and `CustomFormulaData.fromMap` could lead to DoS via `TypeError` crashes.
**Learning:** Dart's strict type system will throw a runtime `TypeError` when dynamically casting malformed JSON.
**Prevention:** Always verify top-level structures and list elements using explicit `is` checks. Harden factory constructors by explicitly verifying collection types and using safe conversions.
