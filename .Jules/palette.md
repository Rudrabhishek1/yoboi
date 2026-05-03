## 2024-05-03 - Missing Tooltips on IconButtons
**Learning:** An accessibility issue pattern was identified across this app's components where `IconButton`s were consistently missing the `tooltip` property, which acts as the equivalent of an ARIA label for screen readers in Flutter.
**Action:** Always provide a descriptive `tooltip` parameter when using `IconButton` to ensure screen reader accessibility and helpful hover text for desktop/web users.
