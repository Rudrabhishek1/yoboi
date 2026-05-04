## 2024-05-04 - Optimize CustomPainter line draws
**Learning:** In Flutter, drawing multiple individual lines using `canvas.drawLine` within a `CustomPainter` introduces significant CPU/GPU overhead.
**Action:** Consolidate individual line draws into a single `Path` and use `canvas.drawPath` to batch operations. Also, wrap static `CustomPaint` widgets in a `RepaintBoundary` to prevent unnecessary repaints, and make `Paint` objects `static final` to avoid per-frame allocations.
