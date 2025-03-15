import 'dart:math';
import 'package:flutter/material.dart';

class CustomCircularChart extends StatelessWidget {
  final double consumed;
  final double total;
  final double recommended;
  final bool isComparisonEnabled;

  const CustomCircularChart({
    super.key,
    required this.consumed,
    required this.total,
    required this.recommended,
    required this.isComparisonEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width* 0.46153846153846153846153846153846, MediaQuery.of(context).size.width* 0.46153846153846153846153846153846),
      painter: CircularChartPainter(
        consumed: consumed,
        total: total,
        recommended: recommended,
        isComparisonEnabled: isComparisonEnabled,
      ),
    );
  }
}

class CircularChartPainter extends CustomPainter {
  final double consumed;
  final double total;
  final double recommended;
  final bool isComparisonEnabled;

  CircularChartPainter({
    required this.consumed,
    required this.total,
    required this.recommended,
    required this.isComparisonEnabled,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 18;
    double radius = size.width * 0.8 - strokeWidth;
    Offset center = Offset(size.width / 2, size.height / 2);
    double startAngle = 3*pi / 4;
    double fullSweepAngle = 3 * pi / 2;

    double consumedAngle = fullSweepAngle * (consumed / total);
    double recommendedAngle = fullSweepAngle * (recommended / total);

    Paint backgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      fullSweepAngle,
      false,
      backgroundPaint,
    );

    Paint consumedPaint = Paint()
      ..color = isComparisonEnabled ? Colors.grey.shade400 : Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      consumedAngle,
      false,
      consumedPaint,
    );

    if (isComparisonEnabled) {
      Paint recommendedPaint = Paint()
        ..color = Colors.green
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        recommendedAngle,
        false,
        recommendedPaint,
      );
    }

    int numberOfDots = 7;
    for (int i = 0; i <= numberOfDots; i++) {
      double angle = startAngle + fullSweepAngle * (i / numberOfDots);
      double x = center.dx + radius * cos(angle);
      double y = center.dy + radius * sin(angle);

      Paint dotPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), 6, dotPaint);
      canvas.drawCircle(Offset(x, y), 2, Paint()..color = Colors.green);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
