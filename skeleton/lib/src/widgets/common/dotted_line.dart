import 'package:flutter/material.dart';

class DottedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  DottedLinePainter({
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.gap = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    double startX = 0;
    double endX = size.width;
    double currentX = startX;

    while (currentX < endX) {
      canvas.drawLine(Offset(currentX, 0), Offset(currentX + gap, 0), paint);
      currentX += gap * 2;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
