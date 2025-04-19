import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeeklyContent extends StatelessWidget {
  const WeeklyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
        padding:  EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCalorieCard(context),
              _buildFattyAcidCard(context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFatCard(context),
              _buildSaltCard( context),
            ],
          ),
          _buildSugarCard(context),
      ],
      )
    );
  }

  Widget _buildCalorieCard(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height * 0.26,
      width: MediaQuery.of(context).size.width *0.41,
      padding:  EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text('کالری', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text(
            '۳۹ کیلوکالری',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 4),
          const Text(
            'باقی مانده مصرف مجاز 555 گرم',
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
          ),
          Expanded(
              child: _buildChart(Colors.green[800]!)
          ),
        ],
      ),
    );
  }

  Widget _buildFattyAcidCard(BuildContext context) {
    return Container(

      height:MediaQuery.of(context).size.height * 0.26,
      width: MediaQuery.of(context).size.width *0.41,
      padding:  EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text('اسید چرب', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text(
            '۳۹ گرم',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.purple),
          ),
          const SizedBox(height: 4),
          const Text(
            'باقی مانده مصرف مجاز 555 گرم',
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
          ),
          Expanded(
              child: _buildChart(Colors.purple[800]!)
          ),
        ],
      ),
    );
  }

  Widget _buildFatCard(BuildContext context) {
    return Container(

      height:MediaQuery.of(context).size.height * 0.26 ,
      width: MediaQuery.of(context).size.width *0.41,
      padding:  EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text('چربی', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text(
            '۳۹ گرم',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.orange),
          ),
          const SizedBox(height: 4),
          const Text(
            'باقی مانده مصرف مجاز 555 گرم',
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
          ),
          Expanded(child: _buildChart(Colors.orange[800]!))
        ],
      ),
    );
  }

  Widget _buildSaltCard(BuildContext context) {
    return Container(

      height:MediaQuery.of(context).size.height * 0.26 ,
      width: MediaQuery.of(context).size.width *0.41,
      padding:  EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text('نمک', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text(
            '۳۹ گرم',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(height: 4),
          const Text(
            'باقی مانده مصرف مجاز 555 گرم',
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
          ),
          Expanded(child: _buildChart(Colors.blue[800]!))
        ],
      ),
    );
  }

  Widget _buildSugarCard(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height * 0.16,
      width: MediaQuery.of(context).size.width * 0.88,
      padding:  EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textDirection: TextDirection.rtl,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('قند', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(
                '۳۹ گرم',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red),
              ),
              SizedBox(height: 4),
              Text(
                'باقی مانده مصرف مجاز 555 گرم',
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
              ),
            ],
          ),
          Spacer(),
          Expanded(child: _buildChart(Colors.red[800]!))
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.grey.shade200, blurRadius: 5, spreadRadius: 1),
      ],
    );
  }

  Widget _buildChart(Color barColor) {
    return SfCartesianChart(
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
    );
  }

  List<_ChartData> _getChartData(Color barColor) {
    return [
      _ChartData('Day1', 1, Colors.grey),
      _ChartData('Day2', 2, Colors.grey),
      _ChartData('Day3', 3, Colors.grey),
      _ChartData('Day4', 2, barColor),
      _ChartData('Day5', 3, barColor),
      _ChartData('Day6', 4, barColor),
      _ChartData('Day7', 5, barColor),
    ];
  }
}

class _ChartData {
  final String x;
  final double y;
  final Color color;
  _ChartData(this.x, this.y, this.color);
}
