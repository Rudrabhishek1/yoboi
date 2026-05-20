## 2024-05-20 - Caching SharedPreferences to avoid microtask overhead
**Learning:** In Flutter apps that use SharedPreferences extensively for reading and mutating state, repeatedly calling `SharedPreferences.getInstance()` inside asynchronous methods introduces significant microtask scheduling overhead. While it seems fast, a benchmark showed ~111ms of overhead for repeated calls, compared to ~0ms when caching the instance.
**Action:** Cache the `SharedPreferences` instance inside the `build()` method of Riverpod `AsyncNotifier` classes using a `late final` field. Make sure to await the initialization before mutations using `if (state is! AsyncData) await future;`.

## 2024-05-20 - Drawing Paths vs Lines
**Learning:** In Flutter `CustomPainter`, batching grid operations into a single `Path` using `moveTo` and `lineTo` can actually be *slower* than multiple individual `drawLine` calls for certain cases (measured 163ms for Path vs 33ms for individual lines in a benchmark).
**Action:** Do not blindly batch geometric primitive operations like lines into Paths assuming it's faster without measuring the specific workload.
