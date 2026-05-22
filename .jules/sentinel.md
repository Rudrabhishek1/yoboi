## 2025-02-28 - Insecure Deserialization in Remote Config
**Vulnerability:** Insecure deserialization in `FirebaseService.fetchRemoteFormulas` and `CustomFormulaData.fromMap` where remote JSON is mapped to domain objects without validating the top-level structure (e.g., `is List`) or ensuring elements are of the correct type (`Map<String, dynamic>`).
**Learning:** This missing validation causes a direct `TypeError` runtime crash (Denial of Service) when an improperly structured payload is received.
**Prevention:** Always verify the structure of remote JSON payloads before attempting to iterate or map them. Ensure mapping logic handles missing keys gracefully by falling back to safe defaults (e.g., `?.toString() ?? ''`).
