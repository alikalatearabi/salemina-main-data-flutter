import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../product_page/custom_indicator_bottom_sheet.dart';

class MonthlyConsumptionChart extends StatelessWidget {
  final String title;
  final List<double> primaryValues;
  final List<double>? secondaryValues;
  final bool isComparisonMode;

  const MonthlyConsumptionChart({
    super.key,
    required this.primaryValues,
    this.secondaryValues,
    this.isComparisonMode = false, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    List<String> days = List.generate(30, (index) => '${index + 1}');
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 6, spreadRadius: 1)],
      ),
      child: Column(
        children: [
          Row(
            textDirection: TextDirection.ltr,
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.elliptical(600, 50),
                            ),
                          ),
                          builder: (BuildContext ctx) {
                            return CustomIndicatorBottomSheet(
                              title: 'عنوان شاخص مد نظر',
                              description: 'توضیحات تکمیلی درباره شاخص مورد نظر...',
                              minValue: 0,
                              maxValue: 100,
                              initialValue: 50,
                              onValueChanged: (val) {
                                debugPrint('مقدار در حال تغییر: $val');
                              },
                            );
                          },
                        );
                      },
                      icon: Icon(CupertinoIcons.info,
                        color: Colors.green,))
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(isVisible: false),
            series: <CartesianSeries<dynamic, dynamic>>[
              if (isComparisonMode) ...[
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
          ),
        ],
      ),
    );
  }
}

class ChartData {
  final String day;
  final double value;
  final Color color;

  ChartData(this.day, this.value, this.color);
}