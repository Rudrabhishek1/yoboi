## 2024-07-02 - Canvas Draw Batching Optimization
**Learning:** Drawing hundreds of individual lines in a `CustomPainter` using multiple `canvas.drawLine` calls causes significant draw call overhead which can lead to frame drops and lag on low-end devices.
**Action:** Always prefer batching repetitive draw operations. For example, construct a single `Path` object using `moveTo` and `lineTo` and render it using a single `canvas.drawPath` call.
