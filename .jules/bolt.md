
## 2024-06-12 - Batch Canvas Drawing Operations
**Learning:** In Flutter, issuing multiple individual drawing commands (like `canvas.drawLine` in a loop) inside a `CustomPainter` incurs significant engine overhead due to repeated boundary crossing and individual object processing by Skia/Impeller.
**Action:** When drawing multiple similar paths or lines, batch them into a single `Path` object using `moveTo` and `lineTo`, and render it with a single `canvas.drawPath` call. This drastically reduces the number of operations and improves render performance.
