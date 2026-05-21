## 2024-05-21 - Batch canvas line drawing
**Learning:** Drawing many individual lines via `canvas.drawLine` has significant overhead in Flutter compared to batching lines in a single `Path` object and rendering it with `canvas.drawPath`. In a micro-benchmark (10,000 iterations over a 1000x1000 grid), drawing lines took ~617ms while batching with a path took ~168ms.
**Action:** When drawing complex grids or multiple lines in a `CustomPainter`, always batch the operations into a single `Path` using `moveTo` and `lineTo`, and draw it via `canvas.drawPath`.
