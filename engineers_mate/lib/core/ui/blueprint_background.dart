import 'package:flutter/material.dart';

class BlueprintBackground extends StatelessWidget {
  const BlueprintBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF003366), // Deep Engineering Blue
      child: CustomPaint(painter: GridPainter()),
    );
  }
}

class GridPainter extends CustomPainter {
  // ⚡ Bolt: Cache Paint objects to minimize allocations within the high-frequency paint loop
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

    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), _gridPaint);
    }

    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), _gridPaint);
    }

    // Draw some random "Technical" circles/lines
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.5),
      50,
      _strongPaint,
    );
    canvas.drawRect(Rect.fromLTWH(20, size.height * 0.6, 60, 40), _strongPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
