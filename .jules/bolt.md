## 2024-05-17 - Flutter Canvas Rendering Optimization
**Learning:** In Flutter `CustomPainter`, calling `canvas.drawLine` repeatedly for grids (e.g., in `BlueprintBackground`) introduces significant overhead per call.
**Action:** Batch multiple lines into a single `Path` using `moveTo` and `lineTo`, and render them with a single `canvas.drawPath` call. This reduces painting time significantly (e.g., from ~845ms down to ~160ms for 10,000 grids).
