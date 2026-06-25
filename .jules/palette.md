## 2024-06-25 - Icon Button Tooltips
**Learning:** Flutter's `IconButton` components do not provide text descriptions by default, making them inaccessible to screen readers and confusing for users relying on keyboard navigation.
**Action:** Always explicitly add a `tooltip` property to `IconButton` widgets to ensure an ARIA-equivalent label is available for screen readers and as a visual tooltip on hover/long-press.
