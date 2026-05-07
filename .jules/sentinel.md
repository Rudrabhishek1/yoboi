## 2024-05-15 - Unbounded Input Leading to Potential DoS
**Vulnerability:** TextFields without length constraints can cause performance degradation or application crashes (Denial of Service) when excessively large strings are pasted into them.
**Learning:** This codebase lacked `maxLength` constraints on numerical input fields, search inputs, and formula creation text inputs, exposing the UI to freezing if massive inputs were processed.
**Prevention:** Always define reasonable `maxLength` limits for any `TextField`, particularly those tied to numeric parsers or heavy processing logic. Hide the counter in the UI using `counterText: ""` if it disrupts the design. Additionally, use `FilteringTextInputFormatter` for numeric inputs.
