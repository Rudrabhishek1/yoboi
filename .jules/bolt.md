## 2026-05-01 - Prevented Unintended File Changes
**Learning:** Running flutter test or flutter analyze might inadvertently modify pubspec.lock depending on the local environment channel.
**Action:** Always verify git status after running test or analysis commands and ensure that pubspec.lock is reverted if it's not the intended modification.
