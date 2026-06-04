## 2024-05-18 - Missing Tooltips on Icon-Only Buttons
**Learning:** Found multiple instances of `IconButton` widgets missing the `tooltip` property, which acts as the ARIA-equivalent accessibility label in Flutter. Without it, screen readers only announce "button" with no context.
**Action:** Always add the `tooltip` property to `IconButton` widgets, especially in app bars where they are common.
