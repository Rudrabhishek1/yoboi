## 2024-05-18 - Insecure Deserialization in Firebase Remote Config
**Vulnerability:** The application blindly decoded remote JSON payloads and mapped them directly to internal models without verifying the list or map structures, risking `TypeError` crashes if the payload was malformed or malicious.
**Learning:** Dart's dynamic typing during JSON deserialization can lead to immediate UI thread crashes if the expected structure (e.g., `List` containing `Map<String, dynamic>`) is not explicitly validated before mapping to models.
**Prevention:** Always implement defensive type checking (`is List`, `whereType<Map<String, dynamic>>()`) and provide safe fallbacks (`?.toString() ?? ''`) when parsing remote or untrusted data.
