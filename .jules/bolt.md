## 2024-10-24 - Canvas Operations Batching in CustomPainter
**Learning:** In Flutter's CustomPainter, repeatedly calling canvas.drawLine inside loops for dense grids creates a rendering bottleneck due to significant engine overhead per call.
**Action:** Batch repetitive line drawing operations into a single Path (using moveTo and lineTo) and render it with a single canvas.drawPath call to drastically reduce rendering time.
