## 2024-05-22 - Optimizing CustomPainter Grids
**Learning:** Drawing many individual lines using `canvas.drawLine` creates significant overhead because each call is a separate drawing command.
**Action:** Always use `Path` to batch multiple lines (using `moveTo` and `lineTo`) and draw them with a single `canvas.drawPath` call. This reduced paint time from ~722ms to ~214ms for 10k iterations.
