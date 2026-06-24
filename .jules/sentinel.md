## 2024-06-25 - Safe JSON Parsing
**Vulnerability:** Unsafe casting of remote JSON payloads in `firebase_service.dart` and `CustomFormulaData.fromMap` which can cause runtime `TypeError` crashes if the payload is malformed or maliciously modified.
**Learning:** `jsonDecode` can return different types (e.g., `Map` instead of `List`). Implicitly casting or assuming types (like `as List`) without checking `is List` first will crash the app.
**Prevention:** Always verify the top-level structure (e.g., `decoded is List`) and ensure elements are of the expected type (e.g., `e is Map<String, dynamic>`) before processing. Use safe conversion operators (`?.toString() ?? ''`) and explicit type checks in factory constructors to provide fallback defaults.
