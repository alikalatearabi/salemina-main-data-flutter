import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

class MacroCircularPercentWidget extends StatelessWidget {
  final String title;
  final double percent;
  final String percentText;

  const MacroCircularPercentWidget({
    super.key,
    required this.title,
    required this.percent,
    required this.percentText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 50.0,
          lineWidth: 8.0,
          percent: percent,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(percentText, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black87)),
              Text(title, style: subtitleTextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Colors.black87,
          backgroundColor: lightGrayColor,
        ),
      ],
    );
  }
}