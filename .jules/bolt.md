## 2024-05-24 - Canvas Path Batching in Flutter
**Learning:** In Flutter, executing `canvas.drawLine` repeatedly inside large loops (e.g., drawing grids) incurs significant engine overhead due to dart-to-C++ boundary crossings.
**Action:** When drawing complex grids or many disjoint lines, always create a single `Path` object with `moveTo`/`lineTo` operations and dispatch it using a single `canvas.drawPath` call. Always remember to set `paint.style = PaintingStyle.stroke` immediately before `drawPath` to avoid automated visual regression flags.
