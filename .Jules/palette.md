## 2024-05-24 - Flutter Accessibility Labels
**Learning:** In Flutter apps, the `tooltip` property on `IconButton` widgets serves a dual purpose: providing visual hover text and acting as an ARIA-like label for screen readers. Omitting this severely impacts accessibility for icon-only buttons.
**Action:** Always add a descriptive `tooltip` property to `IconButton` and similar icon-only interactive widgets to ensure baseline accessibility compliance.
