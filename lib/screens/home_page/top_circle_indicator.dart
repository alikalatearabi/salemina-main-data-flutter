import 'package:flutter/material.dart';


class TopCircleIndicator extends StatelessWidget {
  final double progress; // Progress value (0.0 to 1.0)
  final String calorieText;
  final String totalText;

  const TopCircleIndicator({
    required this.progress,
    required this.calorieText,
    required this.totalText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 100), // Adjust the size based on design
      painter: SemiCirclePainter(progress),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              calorieText,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              totalText,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SemiCirclePainter extends CustomPainter {
  final double progress;

  SemiCirclePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint progressPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double radius = size.width / 2;

    // Draw background arc
    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      3.14, // Start angle (180 degrees)
      3.14, // Sweep angle (180 degrees)
      false,
      backgroundPaint,
    );

    // Draw progress arc
    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      3.14, // Start angle (180 degrees)
      3.14 * progress, // Sweep angle based on progress
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
