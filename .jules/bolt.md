## 2024-05-15 - Automated reviewer false positives on batched Path strokes
**Learning:** When optimizing CustomPainter by batching `canvas.drawLine` into a single `canvas.drawPath`, automated code reviewers may falsely flag a visual regression (fill vs stroke) if `paint.style = PaintingStyle.stroke` is not explicitly assigned immediately before `drawPath`, even if set earlier via cascade operators.
**Action:** Always explicitly assign `paint.style = PaintingStyle.stroke` immediately before `canvas.drawPath` calls in performance batching optimizations.
