## 2024-07-05 - CustomPainter Path Batching Edge Case
**Learning:** Automated code reviewers in this project falsely flag visual regressions (fill vs stroke) when optimizing canvas.drawLine to canvas.drawPath if the PaintingStyle.stroke assignment is hidden in cascade operators.
**Action:** Always explicitly assign paint.style = PaintingStyle.stroke immediately before the canvas.drawPath call in CustomPainter optimizations.
