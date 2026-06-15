## 2024-06-15 - Insecure Deserialization in Remote Config
**Vulnerability:** Directly casting and mapping remote JSON without type checks causes TypeError crashes.
**Learning:** External data cannot be trusted to maintain expected structures, even in seemingly safe typed contexts.
**Prevention:** Always use explicit type checking (`is List`, `is Map<String, dynamic>`) and safe fallbacks (`?.toString()`) before deserializing.
