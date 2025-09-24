import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'consumption_details_page.dart';

class MonthlyContent extends StatefulWidget {
  const MonthlyContent({super.key});

  @override
  State<MonthlyContent> createState() => _MonthlyContentState();
}

class _MonthlyContentState extends State<MonthlyContent> {
  final GlobalKey _rootKey = GlobalKey();
  Size? _rootSize;
  List<double> initialValues = List.generate(365, (index) => index * index - 10);
  List<double> compareValues = List.generate(365, (index) => index * -1 * index * index + 1);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox = _rootKey.currentContext!.findRenderObject() as RenderBox;
      setState(() => _rootSize = renderBox.size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _rootKey,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: _rootSize == null
          ? const SizedBox.shrink()
          : Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCalorieCard(context),
              _buildFattyAcidCard(context),
            ],
          ),
          Row(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFatCard(context),
              _buildSaltCard(context),
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
            builder: (context) => ConsumptionDetailsPage(title: 'کالری', primaryValues: initialValues, recommendedValues: compareValues,),
          ),
        );
      },
      child: Container(
        height: _rootSize!.height * 0.326,
        width: MediaQuery.of(context).size.width * 0.41,
        padding: const EdgeInsets.all(16),
        decoration: _boxDecoration(),
        child: Column(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('کالری', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('۳۹ کیلوکالری', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green)),
            const SizedBox(height: 4),
            const Text(
              'باقی مانده مصرف مجاز 555 گرم',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
            ),
            Expanded(child: _buildAreaChart(Colors.green[800]!)),
          ],
        ),
      ),
    );
  }

  Widget _buildFattyAcidCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ConsumptionDetailsPage(title: 'اسید چرب', primaryValues: initialValues, recommendedValues: compareValues,),
          ),
        );
      },
      child: Container(
        height: _rootSize!.height * 0.326,
        width: MediaQuery.of(context).size.width * 0.41,
        padding: const EdgeInsets.all(16),
        decoration: _boxDecoration(),
        child: Column(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('اسید چرب', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('۳۹ گرم', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.purple)),
            const SizedBox(height: 4),
            const Text(
              'باقی مانده مصرف مجاز 555 گرم',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
            ),
            Expanded(child: _buildAreaChart(Colors.purple[800]!)),
          ],
        ),
      ),
    );
  }

  Widget _buildFatCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ConsumptionDetailsPage(title: 'چربی', primaryValues: initialValues, recommendedValues: compareValues,),
          ),
        );
      },
      child: Container(
        height: _rootSize!.height * 0.326,
        width: MediaQuery.of(context).size.width * 0.41,
        padding: const EdgeInsets.all(16),
        decoration: _boxDecoration(),
        child: Column(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('چربی', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('۳۹ گرم', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.orange)),
            const SizedBox(height: 4),
            const Text(
              'باقی مانده مصرف مجاز 555 گرم',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
            ),
            Expanded(child: _buildAreaChart(Colors.orange[800]!)),
          ],
        ),
      ),
    );
  }

  Widget _buildSaltCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ConsumptionDetailsPage(title: 'نمک', primaryValues: initialValues, recommendedValues: compareValues,),
          ),
        );
      },
      child: Container(
        height: _rootSize!.height * 0.326,
        width: MediaQuery.of(context).size.width * 0.41,
        padding: const EdgeInsets.all(16),
        decoration: _boxDecoration(),
        child: Column(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('نمک', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('۳۹ گرم', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue)),
            const SizedBox(height: 4),
            const Text(
              'باقی مانده مصرف مجاز 555 گرم',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
            ),
            Expanded(child: _buildAreaChart(Colors.blue[800]!)),
          ],
        ),
      ),
    );
  }

  Widget _buildSugarCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ConsumptionDetailsPage(title: 'قند', primaryValues: initialValues, recommendedValues: compareValues,),
          ),
        );
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final totalW = constraints.maxWidth;
          final screenW = MediaQuery.of(context).size.width;
          final cardW = screenW * 0.41;
          final eachSpace = (totalW - 2 * cardW) / 3;
          final sugarW = 2 * cardW + eachSpace;
          return Container(

            height: _rootSize!.height * 0.2,
            width: sugarW,
            padding: const EdgeInsets.all(16),
            decoration: _boxDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: [
                const Column(
                  textDirection: TextDirection.ltr,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('قند', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('۳۹ گرم', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red)),
                    SizedBox(height: 4),
                    Text(
                      'باقی مانده مصرف مجاز 555 گرم',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
                    ),
                  ],
                ),
                SizedBox(width: 16,),
                Expanded(child: _buildAreaChart(Colors.red[800]!)),
              ],
            ),
          );
        },
      ),
    );
  }

  BoxDecoration _boxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5, spreadRadius: 1)],
  );

  Widget _buildAreaChart(Color color) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(isVisible: false),
      primaryYAxis: NumericAxis(isVisible: false),
      series: <CartesianSeries<dynamic, dynamic>>[
        SplineAreaSeries<_ChartData, String>(
          dataSource: _getMonthlyData(),
          xValueMapper: (_ChartData data, _) => data.x,
          yValueMapper: (_ChartData data, _) => data.y,
          color: color.withOpacity(0.3),
          borderColor: color,
          borderWidth: 0.5,
        ),
      ],
    );
  }

  List<_ChartData> _getMonthlyData() {
    final random = Random();
    return List.generate(30, (index) => _ChartData('Day${index + 1}', random.nextDouble() * 10));
  }
}

class _ChartData {
  final String x;
  final double y;
  _ChartData(this.x, this.y);
}