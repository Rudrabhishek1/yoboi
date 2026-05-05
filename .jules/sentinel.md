## 2025-01-20 - [Add Input Length Limits]
**Vulnerability:** TextFields without input length limits can be exploited to cause a Denial of Service (DoS). An attacker or careless user pasting a string of millions of characters could overwhelm the app's memory, causing UI freezes or crashes.
**Learning:** Even internal or non-networked text inputs require constraints. The absence of `maxLength` allows unbounded memory allocation for string holding and rendering in Flutter applications.
**Prevention:** Consistently apply a `maxLength` property to all `TextField` and `TextFormField` widgets, tailored to the expected input size (e.g., 50 for numbers, 255 for standard expressions). Suppress the character count UI with `counterText: ""` if it disrupts the design.
