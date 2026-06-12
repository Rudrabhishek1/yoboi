## 2024-06-12 - Insecure Deserialization of Remote JSON
**Vulnerability:** Insecure deserialization in `FirebaseService.fetchRemoteFormulas` and `CustomFormulaData.fromMap` where external JSON payloads were implicitly cast and parsed without type checking, leading to runtime `TypeError` crashes.
**Learning:** Dart's dynamic typing during JSON decoding can cause silent type errors that crash the app when external payloads are malformed. Direct map access and implicit casts are unsafe.
**Prevention:** Always verify the top-level structure (`is List`), ensure list elements are explicitly typed (`is Map<String, dynamic>`), and harden factory constructors using explicit type checking and safe conversion operators (`?.toString() ?? ''`).
