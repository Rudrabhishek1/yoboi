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
  static final Paint _gridPaint = Paint()
    ..color = Colors.white.withOpacity(0.1)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;

  static final Paint _strongPaint = Paint()
    ..color = Colors.white.withOpacity(0.2)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  Path? _cachedPath;
  Size? _cachedSize;

  @override
  void paint(Canvas canvas, Size size) {
    if (_cachedPath == null || _cachedSize != size) {
      _cachedPath = Path();
      _cachedSize = size;
      const double step = 20.0;

      for (double x = 0; x < size.width; x += step) {
        _cachedPath!.moveTo(x, 0);
        _cachedPath!.lineTo(x, size.height);
      }

      for (double y = 0; y < size.height; y += step) {
        _cachedPath!.moveTo(0, y);
        _cachedPath!.lineTo(size.width, y);
      }
    }

    canvas.drawPath(_cachedPath!, _gridPaint);

    // Draw some random "Technical" circles/lines
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.5), 50, _strongPaint);
    canvas.drawRect(Rect.fromLTWH(20, size.height * 0.6, 60, 40), _strongPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
