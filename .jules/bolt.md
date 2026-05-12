## 2024-05-24 - SharedPreferences Caching Optimization

**Learning:** Micro-benchmarks in 'engineers_mate' demonstrate that caching the `SharedPreferences` instance avoids asynchronous microtask overhead, reducing access time to ~0ms compared to the ~111ms overhead of repeatedly calling `SharedPreferences.getInstance()` over 10,000 iterations. Repeatedly fetching the singleton within Riverpod providers (like HistoryNotifier) creates unnecessary I/O overhead and latency in synchronous UI paths.

**Action:** When implementing Riverpod `AsyncNotifier` classes that depend on `SharedPreferences`, cache the instance as a `late final SharedPreferences _prefs;` initialized within the `build()` method. Ensure mutation methods safely await the `build` completion using `if (state is! AsyncData) await future;` before accessing the cached instance to prevent `LateInitializationError` exceptions.
