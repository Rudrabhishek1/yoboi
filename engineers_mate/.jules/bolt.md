
## 2024-05-12 - Eliminate Async Overhead in Riverpod AsyncNotifier
**Learning:** Calling `SharedPreferences.getInstance()` inside asynchronous methods adds non-trivial microtask overhead (~111ms for 10k iterations). Within Riverpod `AsyncNotifier` classes, caching the `SharedPreferences` instance inside a `late final` variable initialized during `build()` completely eliminates this overhead (bringing it down to ~0ms).
**Action:** When implementing new `AsyncNotifier` classes that depend on `SharedPreferences`, declare a `late final SharedPreferences _prefs;` instance variable, initialize it in the `build()` method, and protect synchronous references inside mutation methods with `if (state is! AsyncData) await future;` to avoid `LateInitializationError` during race conditions.
