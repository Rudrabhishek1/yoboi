## 2024-05-08 - Accessible IconButton Tooltips
**Learning:** In Flutter, the `IconButton` widget lacks intrinsic accessibility labels. Using the `tooltip` property not only provides visual hover context but also acts as the ARIA label equivalent for screen readers, significantly improving accessibility for icon-only buttons.
**Action:** Always add a descriptive `tooltip` property when creating or updating `IconButton` widgets in this application to ensure both visual and screen reader accessibility.
