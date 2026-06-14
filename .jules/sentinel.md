## 2024-06-14 - Insecure Deserialization in CustomFormulaData
**Vulnerability:** The application was directly casting JSON payloads from Firebase Remote Config into expected types (e.g., `List<String>.from(map['inputLabels'])`), which would cause a runtime `TypeError` crash if malformed data was injected.
**Learning:** Dart's strong typing will throw unhandled exceptions during factory constructor mapping if external data does not exactly match expected types, leading to denial of service.
**Prevention:** Always validate external JSON structures (e.g., `is List`) and use safe conversion operators (`?.toString() ?? ''`) with explicit type checks for collections in data model factory constructors.
