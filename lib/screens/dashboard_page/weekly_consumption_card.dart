import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeeklyConsumptionCard extends StatelessWidget {
  final List<double> primaryValues;
  final List<double>? secondaryValues;
  final int highlightedIndex;
  final bool isComparisonMode;

  const WeeklyConsumptionCard({
    super.key,
    required this.primaryValues,
    this.secondaryValues,
    required this.highlightedIndex,
    this.isComparisonMode = false,
  });

  @override
  Widget build(BuildContext context) {
    List<String> days = ['جمعه', 'شنبه۵', '۴شنبه', 'شنبه۳', "شنبه۲", 'شنبه۱', 'شنبه'];
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(isVisible: false),
      series: <CartesianSeries<dynamic, dynamic>>[
        if (isComparisonMode) ...[
          ColumnSeries<ChartData, String>(
            dataSource: List.generate(primaryValues.length, (index) {
              return ChartData(
                days[index],
                primaryValues[index],
                Colors.grey.shade400,
              );
            }),
            xValueMapper: (ChartData data, _) => data.day,
            yValueMapper: (ChartData data, _) => data.value,
            pointColorMapper: (ChartData data, _) => data.color,
            borderRadius: BorderRadius.circular(4),
          ),
          ColumnSeries<ChartData, String>(
            dataSource: List.generate(secondaryValues?.length ?? 0, (index) {
              return ChartData(
                days[index],
                secondaryValues![index],
                index == highlightedIndex ? Colors.green : Colors.green.shade200,
              );
            }),
            xValueMapper: (ChartData data, _) => data.day,
            yValueMapper: (ChartData data, _) => data.value,
            pointColorMapper: (ChartData data, _) => data.color,
            borderRadius: BorderRadius.circular(4),
          ),
        ] else ...[
          ColumnSeries<ChartData, String>(
            dataSource: List.generate(primaryValues.length, (index) {
              return ChartData(
                days[index],
                primaryValues[index],
                index == highlightedIndex ? Colors.green : Colors.green.shade200, // Original green color logic
              );
            }),
            xValueMapper: (ChartData data, _) => data.day,
            yValueMapper: (ChartData data, _) => data.value,
            pointColorMapper: (ChartData data, _) => data.color,
            borderRadius: BorderRadius.circular(4),
          ),
        ]
      ],
    );
  }
}

class ChartData {
  final String day;
  final double value;
  final Color color;

  ChartData(this.day, this.value, this.color);
}