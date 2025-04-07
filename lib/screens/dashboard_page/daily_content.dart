import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'consumption_details_page.dart';

class DailyContent extends StatelessWidget {
  const DailyContent({super.key});

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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFatCard(context),
              SizedBox(width: 8,),
              _buildSaltCard( context),
            ],
          ),

          _buildSugarCard(context),
        ],
      ),
    );
  }

  Widget _buildCalorieCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ConsumptionDetailsPage(),
          ),
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.26,
        width: MediaQuery.of(context).size.width * 0.41,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: MediaQuery.of(context).size.width * 0.20,
                    child: _buildPieChart(Colors.green[800]!, 100, 555)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFattyAcidCard(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.26,
      width: MediaQuery.of(context).size.width * 0.41,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.041),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: MediaQuery.of(context).size.width * 0.20,
                  child: _buildPieChart(Colors.purple[800]!, 350, 555)
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFatCard(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.26,
      width: MediaQuery.of(context).size.width * 0.41,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.041),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: MediaQuery.of(context).size.width * 0.20,
                  child: _buildPieChart(Colors.orange[800]!, 200, 555)
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSaltCard(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.26,
      width: MediaQuery.of(context).size.width * 0.41,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.041),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: MediaQuery.of(context).size.width * 0.20,
                  child: _buildPieChart(Colors.blue[800]!, 400, 555)
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSugarCard(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.14,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.041),
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
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381,)),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.20512820512820512820512820512821,
                height: MediaQuery.of(context).size.width * 0.20512820512820512820512820512821,
                child: _buildPieChart(Colors.red[800]!, 339, 555)
            ),
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

  Widget _buildPieChart(Color pieColor, double currentAmount, double totalAmount) {
    double percentage = (currentAmount / totalAmount) * 100;
    return Align(
      alignment: Alignment.center,
      child: SfCircularChart(
        margin: EdgeInsets.zero,
        annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
            widget: Text(
              '${percentage.toStringAsFixed(2)}%',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
        series: <CircularSeries>[
          RadialBarSeries<_ChartData, String>(
            dataSource: [
              _ChartData('Used', percentage, pieColor),
            ],
            xValueMapper: (_ChartData data, _) => data.x,
            yValueMapper: (_ChartData data, _) => data.y,
            pointColorMapper: (_ChartData data, _) => data.color,
            maximumValue: 100,
            trackColor: Colors.grey.shade300,
            cornerStyle: CornerStyle.bothCurve,
            innerRadius: '85%',
            radius: '80%',
          ),
        ],
      ),
    );
  }
}

class _ChartData {
  final String x;
  final double y;
  final Color color;
  _ChartData(this.x, this.y, this.color);
}
