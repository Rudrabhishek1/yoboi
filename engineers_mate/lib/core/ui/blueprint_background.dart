import 'package:flutter/material.dart';

class BlueprintBackground extends StatelessWidget {
  const BlueprintBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF003366), // Deep Engineering Blue
      child: RepaintBoundary(
        child: CustomPaint(
          painter: GridPainter(),
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  // Optimization: Pre-allocate static Paint objects to prevent memory allocation
  // during every frame draw.
  static final Paint _gridPaint = Paint()
    ..color = Colors.white.withOpacity(0.1)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;

  static final Paint _strongPaint = Paint()
    ..color = Colors.white.withOpacity(0.2)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    // Optimization: Consolidating individual line drawing into a single Path
    // drastically reduces the number of separate draw calls to the GPU.
    // Note: Instance caching is removed because the CustomPainter is recreated
    // on every build, and the RepaintBoundary handles caching at the layer level.
    final Path gridPath = Path();
    final Path strongPath = Path();

    const double step = 20.0;

    for (double x = 0; x < size.width; x += step) {
      gridPath.moveTo(x, 0);
      gridPath.lineTo(x, size.height);
    }

    for (double y = 0; y < size.height; y += step) {
      gridPath.moveTo(0, y);
      gridPath.lineTo(size.width, y);
    }

    // Draw some random "Technical" circles/lines
    strongPath.addOval(Rect.fromCircle(
        center: Offset(size.width * 0.8, size.height * 0.5), radius: 50));
    strongPath.addRect(Rect.fromLTWH(20, size.height * 0.6, 60, 40));

    canvas.drawPath(gridPath, _gridPaint);
    canvas.drawPath(strongPath, _strongPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
