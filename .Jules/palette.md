## 2026-05-09 - Adding Tooltips to IconButtons for Accessibility
**Learning:** In Flutter, `IconButton` widgets inherently lack accessibility labels unless explicitly provided, leaving screen reader users without context and mouse users without visual hints.
**Action:** Consistently use the `tooltip` property on all `IconButton` widgets to serve dual purposes: acting as an ARIA label equivalent for screen readers and providing a hover context for web/desktop users.
