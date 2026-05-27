## 2024-05-27 - Cached SharedPreferences vs getInstance
**Learning:** In Flutter, `SharedPreferences.getInstance()` repeatedly creates microtask overhead. Caching the `SharedPreferences` instance inside Riverpod providers avoids this microtask overhead, reducing the time to read preferences dramatically (from ~111ms down to ~0ms over 10,000 iterations). Wait, checking `engineers_mate`'s `HistoryProvider` (AsyncNotifier) we see it calls `await SharedPreferences.getInstance()` inside `_loadHistory`, `addToHistory`, and `clearHistory`.
**Action:** Optimize SharedPreferences usage in AsyncNotifiers by caching the `SharedPreferences` instance. Wait, `AsyncNotifier`'s `state` is only rebuilt if `build()` is called, but let's just do the `SharedPreferences` caching.

## 2024-05-27 - Flutter Canvas batching
**Learning:** Calling `canvas.drawLine` repeatedly inside a loop in a CustomPainter creates significant overhead for the GPU and engine. Batching the operations into a `Path` object using `moveTo` and `lineTo` and executing a single `drawPath` call reduces rendering time substantially (from 620ms down to 7ms for 10000 iterations).
**Action:** When drawing complex grids or multiple lines, always batch into a single `Path` and use `drawPath`.
