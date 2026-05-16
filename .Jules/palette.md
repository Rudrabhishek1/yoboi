## 2024-05-24 - Missing tooltips on IconButtons
**Learning:** Found multiple instances of icon-only `IconButton` widgets lacking `tooltip` properties in the app. This creates an accessibility gap for screen readers which rely on `tooltip` to announce the button's action, and removes visual hover context for non-touch users.
**Action:** Always add explicit `tooltip` properties to all `IconButton` widgets in Flutter to ensure they act as ARIA-equivalent accessibility labels.
