## 2025-06-30 - GridPainter Canvas Drawing
**Learning:** Drawing multiple independent lines using `canvas.drawLine` on a `CustomPainter` introduces unnecessary overhead, especially for repeating elements like grids.
**Action:** When drawing multiple related lines or geometric shapes, prefer building a `Path` and using a single `canvas.drawPath` operation to batch the drawing instructions.
