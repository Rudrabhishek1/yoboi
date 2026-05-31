
## 2024-05-20 - Prevent Insecure Deserialization Crashes in Flutter
**Vulnerability:** The application deserialized untrusted external JSON payloads without validating types or structure, directly casting fields using `as List` and passing `dynamic` types.
**Learning:** In Dart, casting dynamic map fields incorrectly throws a runtime `TypeError`, which crashes the app. External data MUST be strictly typed and checked before conversion.
**Prevention:** Always verify the top-level structure (e.g., `is List`) and use safe conversion operators (`?.toString() ?? ''`) and collection type checking (`is List`) in model factory methods when dealing with external API or Remote Config payloads.
