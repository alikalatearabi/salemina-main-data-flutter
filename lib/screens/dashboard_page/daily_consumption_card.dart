import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../product_page/custom_indicator_bottom_sheet.dart';
import 'custom_circular_chart.dart';

class DailyConsumptionCard extends StatelessWidget {
  final String title;
  final double consumed;
  final double total;
  final double recommendedConsumption;
  final bool isComparisonEnabled;

  const DailyConsumptionCard({
    super.key,
    required this.title,
    required this.consumed,
    required this.total,
    required this.recommendedConsumption,
    required this.isComparisonEnabled,
  });

  @override
  Widget build(BuildContext context) {
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
          _buildCircularChart(),
          const SizedBox(height: 8),
          const Text(
            '۲۵ اردیبهشت ۱۴۰۳',
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularChart() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 200,
          child: CustomCircularChart(
            consumed: consumed,
            total: total,
            recommended: recommendedConsumption,
            isComparisonEnabled: isComparisonEnabled,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${consumed.toInt()}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'از ${total.toInt()} کیلوکالری',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}