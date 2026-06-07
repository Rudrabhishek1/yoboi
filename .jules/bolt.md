## 2024-06-07 - Batching Canvas Rendering Operations
**Learning:** In a Flutter `CustomPainter`, multiple implicit operations like `canvas.drawLine` have non-trivial performance overhead when run continuously or in heavy grid-style backgrounds.
**Action:** Always prefer drawing a single pre-built `Path` using `canvas.drawPath` over many individual canvas operations, ensuring to specify the `style = PaintingStyle.stroke` to mimic line behavior.
