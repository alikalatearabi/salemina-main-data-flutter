import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'consumption_details_page.dart';
class YearlyContent extends StatefulWidget {
  const YearlyContent({super.key});

  @override
  State<YearlyContent> createState() => _YearlyContentState();
}

class _YearlyContentState extends State<YearlyContent> {
  final GlobalKey _rootKey = GlobalKey();
  Size? _rootSize;
  List<double> initialValues = List.generate(365, (index) => index * index - 10);
  List<double> compareValues = List.generate(365, (index) => index * -1 * index * index + 1);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = _rootKey.currentContext!.findRenderObject() as RenderBox;
      setState(() => _rootSize = box.size);
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

  Widget _buildCalorieCard(BuildContext ctx) {
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
        width: MediaQuery.of(ctx).size.width * 0.41,
        padding: const EdgeInsets.all(16),
        decoration: _boxDecoration(),
        child: Column(
          textDirection: TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('کالری', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('۳۹ کیلوکالری', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green[800])),
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

  Widget _buildFattyAcidCard(BuildContext ctx) {
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
        width: MediaQuery.of(ctx).size.width * 0.41,
        padding: const EdgeInsets.all(16),
        decoration: _boxDecoration(),
        child: Column(
          textDirection: TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('اسید چرب', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('۳۹ گرم', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.purple[800])),
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

  Widget _buildFatCard(BuildContext ctx) {
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
        width: MediaQuery.of(ctx).size.width * 0.41,
        padding: const EdgeInsets.all(16),
        decoration: _boxDecoration(),
        child: Column(
          textDirection: TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('چربی', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('۳۹ گرم', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.orange[800])),
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

  Widget _buildSaltCard(BuildContext ctx) {
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
        width: MediaQuery.of(ctx).size.width * 0.41,
        padding: const EdgeInsets.all(16),
        decoration: _boxDecoration(),
        child: Column(
          textDirection: TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('نمک', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('۳۹ گرم', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[800])),
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
        builder: (ctx, constraints) {
          final totalW = constraints.maxWidth;
          final screenW = MediaQuery.of(ctx).size.width;
          final cardW = screenW * 0.41;
          final gap = (totalW - 2 * cardW) / 3;
          final sugarW = 2 * cardW + gap;

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
                const SizedBox(width: 16),
                Expanded(child: _buildAreaChart(Colors.red[800]!)),
              ],
            ),
          );
        },
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5, spreadRadius: 1)],
    );
  }

  Widget _buildAreaChart(Color color) {
    final data = List.generate(
      365,
          (i) => _ChartData('Day${i + 1}', Random().nextDouble() * 10),
    );
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(isVisible: false),
      primaryYAxis: NumericAxis(isVisible: false),
      series: <CartesianSeries>[
        SplineAreaSeries<_ChartData, String>(
          dataSource: data,
          xValueMapper: (d, _) => d.x,
          yValueMapper: (d, _) => d.y,
          color: color.withOpacity(0.3),
          borderColor: color,
          borderWidth: 0.5,
        ),
      ],
    );
  }
}

class _ChartData {
  final String x;
  final double y;
  _ChartData(this.x, this.y);
}
