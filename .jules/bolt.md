
## 2024-05-18 - Batching multiple lines into a single Path in CustomPainter
**Learning:** Drawing complex grids or multiple lines using repeated `canvas.drawLine` calls introduces significant rendering overhead in Flutter's `CustomPainter`.
**Action:** Always batch grid lines or continuous drawing operations into a single `Path` object using `moveTo` and `lineTo`, and render it via `canvas.drawPath` instead of repeatedly invoking `canvas.drawLine`.
