## 2024-05-24 - Pre-calculating CustomPainter Paint Objects
**Learning:** In Flutter's `CustomPainter` instances within `engineers_mate`, repeatedly instantiating `Paint` objects inside the `paint` loop (which can execute 60+ times per second) generates unnecessary garbage collection overhead.
**Action:** Always extract static or reusable `Paint` definitions as `static final` fields in the class to minimize memory allocation and improve rendering performance during repaints.
