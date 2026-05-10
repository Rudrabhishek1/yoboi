## 2025-02-14 - Add Input Length Limits to TextFields
**Vulnerability:** TextFields were lacking input length limitations, which poses a potential DoS vulnerability by allowing users to enter excessively large inputs, leading to high parsing overhead. Furthermore, some input controls did not restrict format string inputs, creating a risk for malformed operations.
**Learning:** Adding the standard UI components did not automatically include length constraints (`maxLength`) or format validations (`inputFormatters`). These properties must be manually enforced for every input.
**Prevention:** Incorporate maximum length enforcement and strict input formatting for user-facing `TextField` widgets uniformly to avoid arbitrary unconstrained inputs.
