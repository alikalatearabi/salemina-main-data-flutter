import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RadialChartWidget extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const RadialChartWidget({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: SfCircularChart(
            margin: EdgeInsets.zero,
            annotations: <CircularChartAnnotation>[
              CircularChartAnnotation(
                widget: Text(
                  '${value.toInt()}g',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
            series: <CircularSeries>[
              RadialBarSeries<ChartData, String>(
                dataSource: [ChartData(label, value, color)],
                xValueMapper: (ChartData data, _) => data.label,
                yValueMapper: (ChartData data, _) => data.value,
                maximumValue: 100,
                trackColor: Colors.grey.shade300,
                pointColorMapper: (ChartData data, _) => data.color,
                cornerStyle: CornerStyle.bothCurve,
                innerRadius: '85%',
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 48,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.label, this.value, this.color);
  final String label;
  final double value;
  final Color color;
}
