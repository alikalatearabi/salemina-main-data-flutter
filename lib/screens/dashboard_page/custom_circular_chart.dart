import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class CustomCircularChart extends StatefulWidget {
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
  _AnimatedCircularChartState createState() => _AnimatedCircularChartState();
}

class _AnimatedCircularChartState extends State<CustomCircularChart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _consumedAnimation;
  late Animation<double> _recommendedAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _consumedAnimation = Tween<double>(begin: 0, end: widget.consumed).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _recommendedAnimation = Tween<double>(begin: 0, end: widget.recommended).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant CustomCircularChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.consumed != widget.consumed || oldWidget.recommended != widget.recommended) {
      _consumedAnimation = Tween<double>(begin: _consumedAnimation.value, end: widget.consumed).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      );
      _recommendedAnimation = Tween<double>(begin: _recommendedAnimation.value, end: widget.recommended).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      );
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(MediaQuery.of(context).size.width * 0.4, MediaQuery.of(context).size.width * 0.4),
          painter: CircularChartPainter(
            consumed: _consumedAnimation.value,
            total: widget.total,
            recommended: _recommendedAnimation.value,
            isComparisonEnabled: widget.isComparisonEnabled,
          ),
        );
      },
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
    double startAngle = 3 * pi / 4;
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
  bool shouldRepaint(covariant CircularChartPainter oldDelegate) {
    return oldDelegate.consumed != consumed ||
        oldDelegate.total != total ||
        oldDelegate.recommended != recommended ||
        oldDelegate.isComparisonEnabled != isComparisonEnabled;
  }
}