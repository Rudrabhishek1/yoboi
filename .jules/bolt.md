## 2024-06-04 - Canvas Render Optimization Error
**Learning:** In Dart/Flutter, a `PictureRecorder` can only be associated with a single `Canvas`. When benchmarking or executing multiple isolated drawing operations, always instantiate a new `PictureRecorder` for each new `Canvas` to prevent 'Invalid argument(s): recorder must not already be associated with another Canvas' errors.
**Action:** Always create a fresh `PictureRecorder` alongside any new `Canvas` object in testing and benchmark scripts.
