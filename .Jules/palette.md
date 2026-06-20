## 2024-06-20 - Adding ARIA-equivalent accessibility labels for icon-only buttons in Flutter
**Learning:** In Flutter, icon-only buttons (`IconButton`) require explicit `tooltip` properties to serve as ARIA-equivalent accessibility labels for screen readers.
**Action:** Always verify `IconButton` widgets have a `tooltip` string defined when providing visual-only actions.
