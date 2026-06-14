
## 2024-06-15 - Batch GridPainter canvas operations
**Learning:** In Flutter, repeatedly calling `canvas.drawLine` in loops incurs overhead crossing the Dart-to-C++ boundary multiple times.
**Action:** When drawing multiple primitive shapes like lines in a grid, batch them into a single `Path` object and render using `canvas.drawPath` to reduce canvas API overhead. Also ensure the Paint style is explicitly set to `PaintingStyle.stroke` as `drawPath` defaults to fill.
