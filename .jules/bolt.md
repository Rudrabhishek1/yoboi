## 2024-05-13 - Batch Canvas Operations in Flutter
**Learning:** Flutter's `Canvas.drawLine` adds significant rendering overhead when drawing complex grids (e.g., thousands of lines). A benchmark showed `drawLine` taking ~1,003,093us while batched operations took ~237,887us.
**Action:** Always batch multiple line drawing operations into a single `Path` object using `moveTo`/`lineTo` and call `canvas.drawPath` instead of repeatedly calling `canvas.drawLine` in performance-critical `CustomPainter` objects.
