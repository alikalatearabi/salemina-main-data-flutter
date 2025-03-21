import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeeklyContent extends StatelessWidget {
  const WeeklyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCalorieCard(context),
              SizedBox(width: 8,),
              _buildFattyAcidCard(context),
            ],
          ),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFatCard(context),
              SizedBox(width: 8,),
              _buildSaltCard( context),
            ],
          ),
          SizedBox(height: 8,),
          _buildSugarCard(context),
      ],
      )
    );
  }

  Widget _buildCalorieCard(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height * 0.27,
      width: MediaQuery.of(context).size.width *0.41,
      padding: const EdgeInsets.all(12),
      decoration: _boxDecoration(),
      child: Column(
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
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
          ),
          Spacer(),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.33589743589743589743589743589744,
              height: MediaQuery.of(context).size.height * 0.10178117048346055979643765903308,
              child: _buildChart(Colors.green[800]!)
          ),
        ],
      ),
    );
  }

  Widget _buildFattyAcidCard(BuildContext context) {
    return Container(

      height:MediaQuery.of(context).size.height * 0.27,
      width: MediaQuery.of(context).size.width *0.41,
      padding: const EdgeInsets.all(12),
      decoration: _boxDecoration(),
      child: Column(
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
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
          ),
          Spacer(),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.33589743589743589743589743589744,
              height: MediaQuery.of(context).size.height * 0.10178117048346055979643765903308,
              child: _buildChart(Colors.purple[800]!)
          ),
        ],
      ),
    );
  }

  Widget _buildFatCard(BuildContext context) {
    return Container(

      height:MediaQuery.of(context).size.height * 0.27 ,
      width: MediaQuery.of(context).size.width *0.41,
      padding: const EdgeInsets.all(12),
      decoration: _boxDecoration(),
      child: Column(
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
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
          ),
          Spacer(),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.33589743589743589743589743589744,
              height: MediaQuery.of(context).size.height * 0.10178117048346055979643765903308,
              child: _buildChart(Colors.orange[800]!)
          ),
        ],
      ),
    );
  }

  Widget _buildSaltCard(BuildContext context) {
    return Container(

      height:MediaQuery.of(context).size.height * 0.27 ,
      width: MediaQuery.of(context).size.width *0.41,
      padding: const EdgeInsets.all(12),
      decoration: _boxDecoration(),
      child: Column(
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
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
          ),
          Spacer(),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.33589743589743589743589743589744,
              height: MediaQuery.of(context).size.height * 0.10178117048346055979643765903308,
              child: _buildChart(Colors.blue[800]!)
          ),
        ],
      ),
    );
  }

  Widget _buildSugarCard(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width *0.84,
      padding: const EdgeInsets.all(12),
      decoration: _boxDecoration(),
      child: Row(
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
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
              ),
            ],
          ),
          const SizedBox(width: 8),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.33589743589743589743589743589744,
              height: MediaQuery.of(context).size.height * 0.10178117048346055979643765903308,
              child: _buildChart(Colors.red[800]!)
          ),
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
