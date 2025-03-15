import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeeklyDashboard extends StatelessWidget {
  const WeeklyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('گزارش هفتگی'),
        centerTitle: true,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        childAspectRatio: 0.9,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        children: [
          _buildDashboardCard('کالری', '۳۹ کیلوکالری', Colors.green, Colors.green[800]!),
          _buildDashboardCard('اسید چرب', '۳۹ گرم', Colors.purple, Colors.purple[800]!),
          _buildDashboardCard('چربی', '۳۹ گرم', Colors.orange, Colors.orange[800]!),
          _buildDashboardCard('نمک', '۳۹ گرم', Colors.blue, Colors.blue[800]!),
          _buildSpecialCard(), // کارت آخر با طراحی متفاوت
        ],
      ),
    );
  }

  /// کارت‌های معمولی داشبورد
  Widget _buildDashboardCard(String title, String value, Color color, Color barColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 5, spreadRadius: 1),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 8),
          Text(
            'باقیمانده مصرف مجاز\n۵۵۵۵ گرم',
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(isVisible: false),
              primaryYAxis: NumericAxis(isVisible: false),
              series: <CartesianSeries<dynamic, dynamic>>[
                ColumnSeries<_ChartData, String>(
                  dataSource: _getChartData(barColor),
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  pointColorMapper: (_ChartData data, _) => data.color,
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// کارت **ویژه** (قند) که طراحی متفاوتی دارد
  Widget _buildSpecialCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 5, spreadRadius: 1),
        ],
      ),
      child: Row(
        children: [
          // اطلاعات متنی
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'قند',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '۳۹ گرم',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red),
                ),
                const SizedBox(height: 8),
                Text(
                  'باقیمانده مصرف مجاز\n۵۵۵۵ گرم',
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // نمودار در سمت راست متن‌ها
          SizedBox(
            width: 80,
            height: 80,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(isVisible: false),
              primaryYAxis: NumericAxis(isVisible: false),
              series: <CartesianSeries<dynamic, dynamic>>[
                ColumnSeries<_ChartData, String>(
                  dataSource: _getChartData(Colors.red[800]!),
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  pointColorMapper: (_ChartData data, _) => data.color,
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// داده‌های نمودار برای هر کارت
  List<_ChartData> _getChartData(Color barColor) {
    return [
      _ChartData('Day1', 1, Colors.grey),
      _ChartData('Day2', 2, Colors.grey),
      _ChartData('Day3', 3, Colors.grey),
      _ChartData('Day4', 2, barColor),
      _ChartData('Day5', 3, barColor),
      _ChartData('Day6', 4, barColor),
    ];
  }
}

/// مدل داده‌ای نمودار
class _ChartData {
  final String x;
  final double y;
  final Color color;
  _ChartData(this.x, this.y, this.color);
}
