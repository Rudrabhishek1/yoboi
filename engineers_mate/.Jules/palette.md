## 2024-05-01 - IconButton Tooltips as ARIA labels
**Learning:** In Flutter web applications, `IconButton` widgets without a `tooltip` property lack accessible labels for screen readers, effectively acting as icon-only buttons without ARIA labels. Adding the `tooltip` property provides both visual hover context and an ARIA-equivalent label for accessibility.
**Action:** Always ensure `IconButton` widgets have a clear, descriptive `tooltip` property set, treating it as a mandatory ARIA label requirement.
