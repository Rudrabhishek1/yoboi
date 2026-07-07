## 2024-07-07 - Batching Canvas Operations in Flutter
**Learning:** In Flutter's CustomPainter, making numerous separate `canvas.drawLine()` calls is significantly slower than batching them into a single `Path` and calling `canvas.drawPath()` once.
**Action:** When drawing grids, meshes, or multiple connected lines, always build a `Path` and draw it instead of looping over `canvas.drawLine()`.
