import 'package:flutter/material.dart';
import 'custom_circular_chart.dart';

class DailyChart extends StatelessWidget {
  const DailyChart({super.key});

  @override
  Widget build(BuildContext context) {
    double consumed = 12555;
    double total = 55555;
    double recommendedConsumption = 10000;
    bool isComparisonEnabled = false;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 6, spreadRadius: 1)],
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'کالری مصرفی روزانه',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: CustomCircularChart(
              consumed: consumed,
              total: total,
              recommended: recommendedConsumption,
              isComparisonEnabled: isComparisonEnabled,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '۲۵ اردیبهشت ۱۴۰۳',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
