import 'package:flutter/material.dart';

class BlueprintBackground extends StatelessWidget {
  const BlueprintBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF003366), // Deep Engineering Blue
      // ⚡ Bolt: Wrapped in RepaintBoundary to prevent unnecessary repaints of static background
      child: RepaintBoundary(
        child: CustomPaint(
          painter: GridPainter(),
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  // ⚡ Bolt: Cached Paint objects to avoid reallocation on every paint
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
    const double step = 20.0;
    // ⚡ Bolt: Consolidated individual line draws into a single Path for reduced overhead
    final Path gridPath = Path();

    for (double x = 0; x < size.width; x += step) {
      gridPath.moveTo(x, 0);
      gridPath.lineTo(x, size.height);
    }

    for (double y = 0; y < size.height; y += step) {
      gridPath.moveTo(0, y);
      gridPath.lineTo(size.width, y);
    }

    canvas.drawPath(gridPath, _gridPaint);

    // Draw some random "Technical" circles/lines
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.5), 50, _strongPaint);
    canvas.drawRect(Rect.fromLTWH(20, size.height * 0.6, 60, 40), _strongPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
