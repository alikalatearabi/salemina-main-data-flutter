import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'consumption_details_page.dart';

class DailyContent extends StatefulWidget {
  DailyContent({super.key});

  @override
  State<DailyContent> createState() => _DailyContentState();
}

class _DailyContentState extends State<DailyContent> {
  final GlobalKey _myWidgetKey = GlobalKey();
  Size? myWidgetSize;
  List<double> initialValues = List.generate(365, (index) => index * index - 10);
  List<double> compareValues = List.generate(365, (index) => index * -1 * index * index + 1);


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = _myWidgetKey.currentContext!.findRenderObject() as RenderBox;
      setState(() {
        myWidgetSize = renderBox.size;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _myWidgetKey,
      alignment: Alignment.center,
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (myWidgetSize != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCalorieCard(context),
                _buildFattyAcidCard(context),
              ],
            ),
          if (myWidgetSize != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFatCard(context),
                _buildSaltCard(context),
              ],
            ),
          if (myWidgetSize != null)
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
        height: myWidgetSize!.height * 0.326,
        width: MediaQuery.of(context).size.width * 0.41,
        padding: EdgeInsets.all(16),
        decoration: _boxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('کالری', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('652.87 کیلوکالری',textDirection:TextDirection.rtl, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green)),
            SizedBox(height: 4),
            Text(
              'باقی مانده مصرف مجاز 1347.12 گرم',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
            ),
            SizedBox(height: 10),
            Expanded(child: _buildPieChart(Colors.green[800]!, 652.878, 2000)),
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
        height: myWidgetSize!.height * 0.326,
        width: MediaQuery.of(context).size.width * 0.41,
        padding: EdgeInsets.all(16),
        decoration: _boxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('اسید چرب', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('0.05 گرم',textDirection:TextDirection.rtl, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.purple)),
            SizedBox(height: 4),
            Text(
              'باقی مانده مصرف مجاز 0.45 گرم',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
            ),
            SizedBox(height: 10),
            Expanded(child: _buildPieChart(Colors.purple[800]!, 0.05, 0.5)),
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
        height: myWidgetSize!.height * 0.326,
        width: MediaQuery.of(context).size.width * 0.41,
        padding: EdgeInsets.all(16),
        decoration: _boxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('چربی', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('31.81 گرم', textDirection:TextDirection.rtl,style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.orange)),
            SizedBox(height: 4),
            Text(
              'باقی مانده مصرف مجاز 34.18 گرم',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
            ),
            SizedBox(height: 10),
            Expanded(child: _buildPieChart(Colors.orange[800]!, 31.811, 66)),
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
        height: myWidgetSize!.height * 0.326,
        width: MediaQuery.of(context).size.width * 0.41,
        padding: EdgeInsets.all(16),
        decoration: _boxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('نمک', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('2.56 گرم',textDirection:TextDirection.rtl, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue)),
            SizedBox(height: 4),
            Text(
              'باقی مانده مصرف مجاز 1.18 گرم',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
            ),
            SizedBox(height: 10),
            Expanded(child: _buildPieChart(Colors.blue[800]!, 2.563, 3.75)),
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
            height: myWidgetSize!.height * 0.167,
            width: sugarW,
            padding: EdgeInsets.all(16),
            decoration: _boxDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('قند', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('30.93 گرم',
                        textDirection:TextDirection.rtl,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red)),
                    SizedBox(height: 4),
                    Text(
                      'باقی مانده مصرف مجاز 5.93- گرم',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF657381)),
                    ),
                  ],
                ),
                Spacer(),
                Expanded(child: _buildPieChart(Colors.red[800]!, 30.935, 25)),
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

  Widget _buildPieChart(Color pieColor, double currentAmount, double totalAmount) {
    double percentage = (currentAmount / totalAmount) * 100;
    return Align(
      alignment: Alignment.center,
      child: SfCircularChart(
        margin: EdgeInsets.zero,
        annotations: [
          CircularChartAnnotation(
            widget: Text(
              '${percentage.toStringAsFixed(2)}%',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          )
        ],
        series: [
          RadialBarSeries<_ChartData, String>(
            dataSource: [_ChartData('Used', percentage, pieColor)],
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            pointColorMapper: (data, _) => data.color,
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
