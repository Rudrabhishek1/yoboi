## 2026-05-02 - [Formula Creation Input Validation Limits]
**Vulnerability:** Lack of input limits on custom formula creation (title, expression, variables) could lead to Denial of Service via large inputs or Regex evaluation overhead.
**Learning:** Strict input validation bounds (length, structure) are missing. Flutter UI doesn't inherently prevent massive strings unless `maxLength` is set on `TextField` or validated in logic.
**Prevention:** Apply logical constraints (max size bounds, character whitelisting) securely before processing inputs from users to prevent storage exhaustion or ReDoS attacks.
