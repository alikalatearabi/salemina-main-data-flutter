import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_circular_chart.dart';

class DailyConsumptionCard extends StatelessWidget {
  final double consumed;
  final double total;
  final double recommendedConsumption;
  final bool isComparisonEnabled;

  const DailyConsumptionCard({
    super.key,
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
          const Row(
            children: [
               Align(
                alignment: Alignment.centerRight,
                child: Icon(CupertinoIcons.info,
                color: Colors.green,)
              ),
               Spacer(),
               Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'کالری',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildCircularChart(),
          const SizedBox(height: 8),
          const Text(
            '۲۵ اردیبهشت ۱۴۰۳',
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