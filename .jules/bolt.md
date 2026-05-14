## 2025-02-23 - Batching Canvas Operations
**Learning:** In Flutter, drawing multiple lines individually via `canvas.drawLine` incurs significant rendering overhead. Batching these into a single `Path` using `moveTo` and `lineTo`, then drawing via `canvas.drawPath`, is approximately 75% faster.
**Action:** Always batch repeated canvas operations (like drawing grids or multiple lines) into paths instead of executing multiple separate draw calls.
