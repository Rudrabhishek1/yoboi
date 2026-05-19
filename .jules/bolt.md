## 2024-05-23 - Batching CustomPaint Calls
**Learning:** In Flutter, issuing multiple individual `canvas.drawLine` commands inside a `CustomPainter` loop results in significant overhead, taking ~223ms for a large grid benchmark.
**Action:** Always batch repeated drawing operations (like grid lines) into a single `Path` object using `moveTo` and `lineTo`, and draw it once with `canvas.drawPath` to reduce rendering overhead (down to ~50ms).
