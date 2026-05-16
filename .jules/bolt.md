## 2024-05-24 - Batching Canvas Drawing Commands
**Learning:** In Flutter's `CustomPainter`, calling `canvas.drawLine` hundreds of times per frame in a loop incurs significant overhead due to repeated boundary crossings to the native graphics engine.
**Action:** When drawing complex grids or large numbers of connected lines, batch the operations by building a single `Path` object using `path.moveTo` and `path.lineTo`, and render it all at once with `canvas.drawPath`.
