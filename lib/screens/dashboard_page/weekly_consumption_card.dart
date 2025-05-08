import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../product_page/custom_indicator_bottom_sheet.dart';

class WeeklyConsumptionCard extends StatelessWidget {
  final String title;
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
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    List<String> days = ['جمعه', 'شنبه۵', '۴شنبه', 'شنبه۳', "شنبه۲", 'شنبه۱', 'شنبه'];
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
                      index == highlightedIndex ? Colors.green : Colors.green.shade200,
                    );
                  }),
                  xValueMapper: (ChartData data, _) => data.day,
                  yValueMapper: (ChartData data, _) => data.value,
                  pointColorMapper: (ChartData data, _) => data.color,
                  borderRadius: BorderRadius.circular(4),
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