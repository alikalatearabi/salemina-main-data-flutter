import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MonthlyConsumptionChart extends StatelessWidget {
  final List<double> primaryValues;
  final List<double>? secondaryValues;
  final bool isComparisonMode;

  const MonthlyConsumptionChart({
    super.key,
    required this.primaryValues,
    this.secondaryValues,
    this.isComparisonMode = false,
  });

  @override
  Widget build(BuildContext context) {
    List<String> days = List.generate(30, (index) => '${index + 1}'); // Generate days 1 to 30 for x-axis
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(isVisible: false),
      series: <CartesianSeries<dynamic, dynamic>>[
        if (isComparisonMode) ...[
          // Series for primary values (grey)
          SplineAreaSeries<ChartData, String>(
            dataSource: List.generate(primaryValues.length, (index) {
              return ChartData(
                days[index],
                primaryValues[index],
                Colors.grey.shade400, // Grey color (not used directly for series color anymore)
              );
            }),
            xValueMapper: (ChartData data, _) => data.day,
            yValueMapper: (ChartData data, _) => data.value,
            color: Colors.grey.shade200.withOpacity(0.5), // Set series fill color here
            borderColor: Colors.grey.shade600, // Set border color here
            borderWidth: 1,
            gradient: LinearGradient( // Optional: Grey gradient fill like in the image
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
                Colors.green, // Green color (not used directly for series color anymore)
              );
            }),
            xValueMapper: (ChartData data, _) => data.day,
            yValueMapper: (ChartData data, _) => data.value,
            color: Colors.green.shade200.withOpacity(0.5), // Set series fill color here
            borderColor: Colors.green.shade800, // Set border color here
            borderWidth: 2,
            gradient: LinearGradient( // Optional: Green gradient fill like in the image
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
                Colors.green, // Green color (not used directly for series color anymore)
              );
            }),
            xValueMapper: (ChartData data, _) => data.day,
            yValueMapper: (ChartData data, _) => data.value,
            color: Colors.green.shade200.withOpacity(0.5), // Set series fill color here
            borderColor: Colors.green.shade800, // Set border color here
            borderWidth: 2,
            gradient: LinearGradient( // Optional: Green gradient fill like in the image
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
  final Color color; // Color is still kept in ChartData but not used for pointColorMapper

  ChartData(this.day, this.value, this.color);
}