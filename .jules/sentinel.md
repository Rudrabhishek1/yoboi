## 2024-05-24 - DoS Prevention via TextField Limits
**Vulnerability:** Unbounded TextFields allowed excessively large string inputs, potentially leading to performance degradation or UI freezes (Denial of Service).
**Learning:** In Flutter, `TextField` without a `maxLength` property doesn't inherently block large inputs. For mathematical operations and rendering, these extremely large strings (like pasting a gigabyte text) can freeze the app. The UI counters can be hidden via `counterText: ""` to maintain design fidelity while adding limits.
**Prevention:** Always enforce a reasonable `maxLength` on user input fields, and pair with `inputFormatters` when the expected data type is strict (like numeric values), to sanitize and protect parsing logic.
