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
  // Pre-calculate Paint objects to avoid per-frame allocation
  static final Paint _gridPaint = Paint()
    ..color = Colors.white.withValues(alpha: 0.1)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;

  static final Paint _strongPaint = Paint()
    ..color = Colors.white.withValues(alpha: 0.2)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    // ⚡ Bolt: Consolidate individual line draws into a single Path to reduce draw calls
    final path = Path();
    const double step = 20.0;

    for (double x = 0; x < size.width; x += step) {
      path.moveTo(x, 0);
      path.lineTo(x, size.height);
    }

    for (double y = 0; y < size.height; y += step) {
      path.moveTo(0, y);
      path.lineTo(size.width, y);
    }

    canvas.drawPath(path, _gridPaint);

    // Draw some random "Technical" circles/lines
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.5), 50, _strongPaint);
    canvas.drawRect(Rect.fromLTWH(20, size.height * 0.6, 60, 40), _strongPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
