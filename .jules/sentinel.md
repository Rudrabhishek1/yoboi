## 2024-07-02 - Secure JSON Deserialization
**Vulnerability:** Insecure deserialization in FirebaseService causing TypeError crashes when remote payload structures differ from expected List<Map>.
**Learning:** Always validate top-level dynamic types (e.g., `is List`) and perform element type checking (`is Map<String, dynamic>`) before mapping remote data.
**Prevention:** Use defensive decoding and safe casting instead of implicit List<dynamic> assignment.
