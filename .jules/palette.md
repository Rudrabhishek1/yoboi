## 2024-06-26 - Add ARIA-equivalent accessibility labels to Flutter IconButtons
**Learning:** Flutter's `IconButton` widget does not automatically provide semantic labels for screen readers when only an `icon` is provided. This creates accessibility issues for users relying on assistive technologies, as they hear "Button" with no context.
**Action:** When implementing or modifying icon-only buttons in Flutter, always explicitly set the `tooltip` property on the `IconButton` widget to provide an ARIA-equivalent accessible label (e.g., `tooltip: 'Search formulas',`).
