## 2024-05-18 - Batching Canvas Draw Calls with Path
**Learning:** In Flutter's `CustomPainter`, making individual `canvas.drawLine()` calls in loops (like drawing a grid) creates significant overhead because each call is a separate GPU instruction.
**Action:** Use a single `Path` object and batch lines together with `path.moveTo()` and `path.lineTo()`, then call `canvas.drawPath(path, paint)` once. Remember to explicitly set `paint.style = PaintingStyle.stroke` otherwise the path defaults to a fill, which will break visual expectations.
