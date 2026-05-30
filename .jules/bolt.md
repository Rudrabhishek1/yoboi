## 2024-05-30 - Batching CustomPainter Canvas Operations
**Learning:** Repeatedly calling `canvas.drawLine` creates significant rendering overhead in Flutter for complex grids due to numerous native bindings calls.
**Action:** Batch multiple drawing operations into a single `Path` object using `moveTo` and `lineTo`, and render it once with `canvas.drawPath` for improved frame times. Ensure `Paint` explicitly sets `style = PaintingStyle.stroke` as `drawPath` defaults to fill.
