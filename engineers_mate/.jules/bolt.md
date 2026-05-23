
## $(date +%Y-%m-%d) - Optimize HistoryNotifier SharedPreferences caching
**Learning:** In Riverpod `AsyncNotifier`s that rely on `SharedPreferences`, calling `await SharedPreferences.getInstance()` in every mutation method adds unnecessary asynchronous microtask overhead. Riverpod initializes a new instance of the notifier on every build, so it's safe to cache dependencies at build time.
**Action:** Declare a `late final SharedPreferences _prefs` field, initialize it within the `build()` method, and reuse it across action methods. Ensure mutation methods include `if (state is! AsyncData) await future;` to guarantee initialization has completed before access.
