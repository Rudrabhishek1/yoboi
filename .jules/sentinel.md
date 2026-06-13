## 2024-05-30 - Insecure Deserialization in Remote Formulas
**Vulnerability:** The application was directly casting remote JSON payloads without type checking or structure verification, leading to potential `TypeError` crashes if the data was malformed.
**Learning:** External data should never be trusted, and explicit type checking for collections (`is List`) and safe conversion operations (`?.toString() ?? ''`) are necessary to provide fallback defaults.
**Prevention:** Always verify the top-level structure of JSON payloads and explicitly type-check list elements before mapping them to domain models.
