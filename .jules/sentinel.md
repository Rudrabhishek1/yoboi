## 2024-06-26 - Harden JSON parsing against malformed data
**Vulnerability:** Application crashes with TypeError when parsing malformed external JSON payloads, leading to potential DoS.
**Learning:** Dart's strong typing causes runtime exceptions if dynamic map accesses return null or unexpected types (e.g., trying to iterate a non-List or casting null to String).
**Prevention:** Always validate top-level structures with `is List` and `is Map`, and harden factory constructors with explicit type checks (`is List`) and safe conversion operators (`?.toString() ?? ''`).
