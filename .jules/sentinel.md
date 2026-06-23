## 2024-06-23 - Hardened JSON Deserialization
**Vulnerability:** Unsafe JSON deserialization from remote sources mapping directly to `CustomFormulaData.fromMap` without explicit type checking for collections and strings, causing `TypeError` crashes.
**Learning:** Using `as List?` or `List<String>.from` directly on dynamic JSON map values fails insecurely when malformed external payloads are processed.
**Prevention:** Always verify top-level structures (`is List`) and use explicit type checking (e.g., `map['field'] is List`, safe conversion `?.toString() ?? ''`) before casting collections from untrusted sources.
