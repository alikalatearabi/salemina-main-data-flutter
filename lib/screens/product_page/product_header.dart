import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:main_app/screens/home_page/home_page.dart';
import 'conditional_marquee.dart';
import 'radial_chart_widget.dart';

// Utility function to convert English digits to Persian digits
String toPersianNumber(String number) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'];
  const persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹', '٫'];
  
  for (int i = 0; i < english.length; i++) {
    number = number.replaceAll(english[i], persian[i]);
  }
  return number;
}

class ProductHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double productRate;
  final int rateCount;
  final String productBrand;
  final String productName;
  final String productCluster;

  ProductHeaderDelegate({required this.productBrand,
    required this.productName,
    required this.productCluster,
    required this.productRate,
    required this.rateCount});

  final GlobalKey _radialChartWidgetKey = GlobalKey();
  double _radialChartWidgetHeight = 0;

  void _measureWidget() {
    if (_radialChartWidgetKey.currentContext == null) return;

    final RenderBox renderBox = _radialChartWidgetKey.currentContext!.findRenderObject() as RenderBox;
    _radialChartWidgetHeight = renderBox.size.height;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _measureWidget());
    final double screenWidth = MediaQuery.of(context).size.width;
    final double maxHeight = maxExtent;
    final double minHeight = minExtent;
    final double currentHeight = (maxHeight - shrinkOffset).clamp(minHeight, maxHeight);

    if (shrinkOffset > 0 && shrinkOffset< _radialChartWidgetHeight) {
      return _buildIntermediateHeader(context, screenWidth, currentHeight,productRate);
    } else if (shrinkOffset > _radialChartWidgetHeight) {
      return _buildCollapsedHeader(context, screenWidth, currentHeight);
    } else {
      return _buildExpandedHeader(context, screenWidth, currentHeight,productRate);
    }
  }
  Widget _buildExpandedHeader(BuildContext context, double screenWidth, double height,double productRate) {
    return Container(
      color: Colors.white,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0615384615),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0814249364,
            child: _buildTopRow(context, screenWidth),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1221374046,
            child: _buildMiddleRow(context, screenWidth,productRate),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1323155216,
            child: _buildBottomRow(),
          ),
        ],
      ),
    );
  }

  Widget _buildIntermediateHeader(BuildContext context, double screenWidth, double height,starIndex) {
    return Container(
      color: Colors.white,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0615384615),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0814249364,
            child: _buildTopRow(context, screenWidth),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1221374046,
            child: _buildMiddleRow(context, screenWidth,starIndex),
          ),
        ],
      ),
    );
  }

  Widget _buildCollapsedHeader(BuildContext context, double screenWidth, double height) {
    return Container(
      color: Colors.white,
      height: height,
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0615384615),
            child: _buildExpandedHeaderContent(context, screenWidth),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedHeaderContent(BuildContext context, double screenWidth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(width: screenWidth * 0.01795),
            InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/icons/compare2.svg',
                width: 18,
                height: 18,
              ),
            ),
            SizedBox(width: screenWidth * 0.05641),
            InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/icons/info-circle.svg',
                width: 18,
                height: 18,
              ),
            ),
            const Spacer(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ConditionalMarquee(
                    text: productName,
                    maxWidth: MediaQuery.of(context).size.width * 0.4,
                    textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black),
                    maxCharacters: 25,
                  ),
                  Text(
                    "${productCluster}  ·  ${productBrand}",
                    style: TextStyle(color: Color(0xFF018A08), fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: screenWidth * 0.02051),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/biscuit.jpg',
                width: MediaQuery.of(context).size.width*0.08,
                height: MediaQuery.of(context).size.width*0.08,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: screenWidth * 0.02564),
            InkWell(
              onTap: (){
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false,
                );
              },
              child: SvgPicture.asset(
                'assets/icons/arrow-right.svg',
                width: 20,
                height: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTopRow(BuildContext context, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          child: Row(
            children: [
              const Text(
                "مقایسه",
                style: TextStyle(color: Color(0xFF018A08), fontWeight: FontWeight.bold, fontSize: 12),
              ),
              SizedBox(width: screenWidth * 0.02051),
              SvgPicture.asset(
                'assets/icons/compare2.svg',
                width: 18,
                height: 18,
              ),
            ],
          ),
        ),
        SizedBox(width: screenWidth * 0.05641),
        InkWell(
          child: Row(
            children: [
              const Text(
                "راهنما",
                style: TextStyle(color: Color(0xFF018A08), fontWeight: FontWeight.bold, fontSize: 12),
              ),
              SizedBox(width: screenWidth * 0.02051),
              SvgPicture.asset(
                'assets/icons/info-circle.svg',
                width: 18,
                height: 18,
              ),
            ],
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false,
            );
          },
          child: SvgPicture.asset(
            'assets/icons/arrow-right.svg',
            width: 20,
            height: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildMiddleRow(BuildContext context, double screenWidth,double productRate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ConditionalMarquee(
                text: productName,
                maxWidth: MediaQuery.of(context).size.width * 0.6,
                textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
                maxCharacters: 25,
              ),
              Text(
                textDirection: TextDirection.rtl,
                "${productCluster} · ${productBrand}",
                style: TextStyle(color: Color(0xFF018A08), fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      //todo
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF018A08).withOpacity(0.16),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      minimumSize: Size(
                        screenWidth * 0.22308,
                        MediaQuery.of(context).size.height * 0.03053,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "ثبت امتیاز",
                          style: TextStyle(
                            color: Color(0xFF015B05),
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.01538),
                          SvgPicture.asset(
                          'assets/icons/star_linear.svg',
                          width: 16,
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02051),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        textDirection: TextDirection.rtl,
                        "(${toPersianNumber(rateCount.toString())} نفر)" ,
                        style: TextStyle(color: Color(0xFF657380), fontSize: 12),
                      ),
                      SizedBox(width: 4),
                      if (productRate<2)
                        Text(
                          toPersianNumber(productRate.toStringAsFixed(2)),
                          style: TextStyle(color: Color(0xFFF2506E), fontSize: 14),
                        ),
                      if (productRate>=2 && productRate<3)
                        Text(
                          toPersianNumber(productRate.toStringAsFixed(2)),
                          style: TextStyle(color: Color(0xFFF5AE32), fontSize: 14),
                        ),
                      if (productRate>=3 && productRate<4)
                        Text(
                          toPersianNumber(productRate.toStringAsFixed(2)),
                          style: TextStyle(color: Color(0xFF464E59), fontSize: 14),
                        ),
                      if (productRate>4)
                        Text(
                          toPersianNumber(productRate.toStringAsFixed(2)),
                          style: TextStyle(color: Color(0xFF018A08), fontSize: 14),
                        ),
                      SizedBox(width: 4),
                      if (productRate<2)
                      SvgPicture.asset(
                        'assets/icons/star.svg',
                        width: 16,
                        height: 16,
                        color: Color(0xFFF2506E),
                      ),
                      if (productRate>=2 && productRate<3)
                        SvgPicture.asset(
                          'assets/icons/star.svg',
                          width: 16,
                          height: 16,
                          color: Color(0xFFF5AE32),
                        ),
                      if (productRate>=3 && productRate<4)
                        SvgPicture.asset(
                          'assets/icons/star.svg',
                          width: 16,
                          height: 16,
                          color: Color(0xFF464E59),
                        ),
                      if (productRate>4)
                        SvgPicture.asset(
                          'assets/icons/star.svg',
                          width: 16,
                          height: 16,
                          color: Color(0xFF018A08),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: screenWidth * 0.02),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/eges.png',
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomRow() {
    return Row(
      key: _radialChartWidgetKey,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RadialChartWidget(label: 'نمک', value: 100, color: Color(0xFF4BB4D8)),
        RadialChartWidget(label: 'قند', value: 70, color: Color(0xFFF2506E)),
        RadialChartWidget(label: 'اسید چرب', value: 55, color: Color(0xFF8348F9)),
        RadialChartWidget(label: 'چربی', value: 40, color: Color(0xFFF5AE32)),
        RadialChartWidget(label: 'کالری', value: 20, color: Colors.black),
      ],
    );
  }

  @override
  double get maxExtent => 0.335877863 * MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;

  @override
  double get minExtent => 0.0814249364 * MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}