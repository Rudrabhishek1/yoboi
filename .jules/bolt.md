
## 2024-05-06 - [Static Grid Rendering Optimization]
**Learning:** Consolidating individual line draws into a single `Path` and caching it in `CustomPainter` instances significantly reduces CPU/GPU overhead when painting grids. Additionally, wrapping the `CustomPaint` in a `RepaintBoundary` prevents unnecessary repaints during scrolling.
**Action:** Always pre-calculate and cache expensive `Path` objects and use `static final Paint` objects for high-frequency paint loops in Flutter, and use `RepaintBoundary` for static painted backgrounds.
