## 2024-05-24 - Flutter Test Lockfile Modification
**Learning:** Running `flutter test` in this offline-constrained environment can inadvertently modify `pubspec.lock`, bumping dependency versions and SDK constraints.
**Action:** Always verify `git status` after running Flutter commands (like `test` or `pub get`) and explicitly revert any unstaged or staged modifications to `pubspec.lock` (e.g., `git restore pubspec.lock` and `git restore --staged pubspec.lock`) before committing to avoid breaking CI/CD or other developers' builds.
