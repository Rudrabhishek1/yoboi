## 2024-05-15 - Insecure Deserialization in Remote Config
**Vulnerability:** Un-trusted remote configuration JSON was mapped directly to domain models (`CustomFormulaData.fromMap`) without validating the top-level structure or explicitly type-checking elements.
**Learning:** Dart's dynamic typing combined with `jsonDecode` can lead to runtime `TypeError` and Application DoS when malformed data is forced into expected structures, bypassing compile-time safety.
**Prevention:** Always verify the top-level structure (e.g., `is List`) and ensure elements match expected types (e.g., `is Map<String, dynamic>`) before mapping. Harden factory constructors with safe conversion operators (e.g., `?.toString() ?? ''`) and explicit type checking for collection fields.
