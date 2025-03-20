import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class YearlyConsumptionChart extends StatelessWidget {
  final List<double> primaryValues;
  final List<double>? secondaryValues;
  final bool isComparisonMode;

  const YearlyConsumptionChart({
    super.key,
    required this.primaryValues,
    this.secondaryValues,
    this.isComparisonMode = false,
  });

  @override
  Widget build(BuildContext context) {
    List<String> days = List.generate(365, (index) => '${index + 1}'); // Generate days 1 to 365 for x-axis
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(
        // Optional: Adjust label placement and interval for readability on x-axis with 365 labels
        labelPlacement: LabelPlacement.betweenTicks,
        interval: 30, // Show label every 30 days (approximately monthly)
      ),
      primaryYAxis: NumericAxis(isVisible: false),
      series: <CartesianSeries<dynamic, dynamic>>[
        if (isComparisonMode) ...[
          // Series for primary values (grey)
          SplineAreaSeries<ChartData, String>(
            dataSource: List.generate(primaryValues.length, (index) {
              return ChartData(
                days[index],
                primaryValues[index],
                Colors.grey.shade400,
              );
            }),
            xValueMapper: (ChartData data, _) => data.day,
            yValueMapper: (ChartData data, _) => data.value,
            color: Colors.grey.shade200.withOpacity(0.5),
            borderColor: Colors.grey.shade600,
            borderWidth: 1,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.grey.shade200.withOpacity(0.5), Colors.grey.shade400.withOpacity(0.5)],
            ),
          ),
          // Series for secondary values (green) on top
          SplineAreaSeries<ChartData, String>(
            dataSource: List.generate(secondaryValues?.length ?? 0, (index) {
              return ChartData(
                days[index],
                secondaryValues![index],
                Colors.green,
              );
            }),
            xValueMapper: (ChartData data, _) => data.day,
            yValueMapper: (ChartData data, _) => data.value,
            color: Colors.green.shade200.withOpacity(0.5),
            borderColor: Colors.green.shade800,
            borderWidth: 2,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green.shade200.withOpacity(0.5), Colors.green.withOpacity(0.5)],
            ),
          ),
        ] else ...[
          // Series for single values (green) when comparison mode is off
          SplineAreaSeries<ChartData, String>(
            dataSource: List.generate(primaryValues.length, (index) {
              return ChartData(
                days[index],
                primaryValues[index],
                Colors.green,
              );
            }),
            xValueMapper: (ChartData data, _) => data.day,
            yValueMapper: (ChartData data, _) => data.value,
            color: Colors.green.shade200.withOpacity(0.5),
            borderColor: Colors.green.shade800,
            borderWidth: 2,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green.shade200.withOpacity(0.5), Colors.green.withOpacity(0.5)],
            ),
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