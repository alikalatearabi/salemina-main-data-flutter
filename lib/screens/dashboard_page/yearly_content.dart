import 'package:flutter/material.dart';
import '../scanner_page/dashboard_card.dart';

class YearlyDashboard extends StatelessWidget {
  const YearlyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisCount: 2,
      childAspectRatio: 0.9,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: [
        buildDashboardCard('کالری', '۱۸۰۰۰ کیلوکالری', Colors.green, Colors.green[800]!),
        buildDashboardCard('اسید چرب', '۱۴۵۰۰ گرم', Colors.purple, Colors.purple[800]!),
        buildDashboardCard('چربی', '۱۳۰۰۰ گرم', Colors.orange, Colors.orange[800]!),
        buildDashboardCard('نمک', '۹۵۰۰ گرم', Colors.blue, Colors.blue[800]!),
        buildSpecialCard(), // کارت ویژه (قند)
      ],
    );
  }
}
