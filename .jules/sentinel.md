## 2024-05-24 - Fix insecure deserialization in remote formulas
**Vulnerability:** Insecure deserialization and type casting from external JSON payloads.
**Learning:** Remote configurations can contain malformed or missing data, causing runtime TypeError crashes and DoS when parsing.
**Prevention:** Always verify top-level structures and use safe conversion operators with fallback defaults when parsing external JSON.
