## 2024-05-24 - Canvas Path Batching
**Learning:** In Flutter, calling `canvas.drawLine` repeatedly in a large grid is less efficient than creating a single `Path` object with `moveTo`/`lineTo` and drawing it once via `canvas.drawPath`.
**Action:** Always batch repeated canvas drawing operations into a `Path` where applicable, and remember to explicitly set `paint.style = PaintingStyle.stroke` before drawing the path to avoid fill regressions.
