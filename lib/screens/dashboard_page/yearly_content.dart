import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class YearlyContent extends StatelessWidget {
  const YearlyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding:  EdgeInsets.all(MediaQuery.of(context).size.height*0.03053435114503816793893129770992),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCalorieCard(context),
                SizedBox(width: 8,),
                _buildFattyAcidCard(context),
              ],
            ),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      height:MediaQuery.of(context).size.height * 0.26,
      width: MediaQuery.of(context).size.width *0.41,
      padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.041),
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
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
          ),
          Spacer(),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.33589743589743589743589743589744,
              height: MediaQuery.of(context).size.height * 0.10178117048346055979643765903308,
              child: _buildAreaChart(Colors.green[800]!)
          ),
        ],
      ),
    );
  }

  Widget _buildFattyAcidCard(BuildContext context) {
    return Container(

      height:MediaQuery.of(context).size.height * 0.26,
      width: MediaQuery.of(context).size.width *0.41,
      padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.041),
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
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
          ),
          Spacer(),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.33589743589743589743589743589744,
              height: MediaQuery.of(context).size.height * 0.10178117048346055979643765903308,
              child: _buildAreaChart(Colors.purple[800]!)
          ),
        ],
      ),
    );
  }

  Widget _buildFatCard(BuildContext context) {
    return Container(

      height:MediaQuery.of(context).size.height * 0.26,
      width: MediaQuery.of(context).size.width *0.41,
      padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.041),
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
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
          ),
          Spacer(),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.33589743589743589743589743589744,
              height: MediaQuery.of(context).size.height * 0.10178117048346055979643765903308,
              child: _buildAreaChart(Colors.orange[800]!)
          ),
        ],
      ),
    );
  }

  Widget _buildSaltCard(BuildContext context) {
    return Container(

      height:MediaQuery.of(context).size.height * 0.26,
      width: MediaQuery.of(context).size.width *0.41,
      padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.041),
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
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
          ),
          Spacer(),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.33589743589743589743589743589744,
              height: MediaQuery.of(context).size.height * 0.10178117048346055979643765903308,
              child: _buildAreaChart(Colors.blue[800]!)
          ),
        ],
      ),
    );
  }

  Widget _buildSugarCard(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height * 0.13,
      padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.03),
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
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
              ),
            ],
          ),
          const SizedBox(width: 8),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.33589743589743589743589743589744,
              height: MediaQuery.of(context).size.height * 0.10178117048346055979643765903308,
              child: _buildAreaChart(Colors.red[800]!)
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

  Widget _buildAreaChart(Color color) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(isVisible: false),
      primaryYAxis: NumericAxis(isVisible: false),
      series: <CartesianSeries<dynamic, dynamic>>[
        SplineAreaSeries<_ChartData, String>(
          dataSource: _getMonthlyData(),
          xValueMapper: (_ChartData data, _) => data.x,
          yValueMapper: (_ChartData data, _) => data.y,
          color: color.withOpacity(0.3), // Background shade
          borderColor: color, // Line color
          borderWidth: 0.5,
        ),
      ],
    );
  }

  List<_ChartData> _getMonthlyData() {
    final random = Random();
    return List.generate(365, (index) {
      return _ChartData('Day${index + 1}', random.nextDouble() * 10);
    });
  }
}

class _ChartData {
  final String x;
  final double y;
  _ChartData(this.x, this.y);
}
