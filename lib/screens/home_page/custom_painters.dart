// Custom painter for the half circle background
import 'dart:math';

import 'package:flutter/material.dart';

class HalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height),
      radius: size.width / 2,
    );

    canvas.drawArc(rect, -pi, pi * 1.2, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for the filled half circle
class HalfCircleFilledPainter extends CustomPainter {
  final int consumedCalories;
  final int totalCalories;

  HalfCircleFilledPainter(
      {required this.consumedCalories, required this.totalCalories});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height),
      radius: size.width / 2,
    );

    final sweepAngle = (pi * consumedCalories) / totalCalories;

    canvas.drawArc(rect, -pi * 1.19, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TopArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, 20); // Move to start of the arc
    path.quadraticBezierTo(
      size.width / 2, // Control point at the middle of the width
      -20, // Control point height (negative for upward curve)
      size.width, // End of the arc
      20, // Back to the bottom
    );
    path.lineTo(size.width, size.height); // Down the right edge
    path.lineTo(0, size.height); // Across the bottom
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}