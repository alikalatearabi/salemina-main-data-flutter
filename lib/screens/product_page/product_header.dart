import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'conditional_marquee.dart';
import 'radial_chart_widget.dart';

class ProductHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double maxHeight = maxExtent;
    final double minHeight = minExtent;
    final double currentHeight = (maxHeight - shrinkOffset).clamp(minHeight, maxHeight);

    if (shrinkOffset > 0 && shrinkOffset< MediaQuery.of(context).size.height*0.12722646310432569974554707379135) {
      return _buildIntermediateHeader(context, screenWidth, currentHeight);
    } else if (shrinkOffset>= 100) {
      return _buildCollapsedHeader(context, screenWidth, currentHeight);
    } else {
      return _buildExpandedHeader(context, screenWidth, currentHeight);
    }
  }
  Widget _buildExpandedHeader(BuildContext context, double screenWidth, double height) {
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
            child: _buildMiddleRow(context, screenWidth),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1323155216,
            child: _buildBottomRow(),
          ),
        ],
      ),
    );
  }

  Widget _buildIntermediateHeader(BuildContext context, double screenWidth, double height) {
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
            child: _buildMiddleRow(context, screenWidth),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ConditionalMarquee(
                  text: "نام خوراکی در حالت طولانی",
                  maxWidth: MediaQuery.of(context).size.width * 0.48717948717948717948717948717949,
                  textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black),
                  maxCharacters: 25,
                ),
                Text(
                  "خوشه محصول  ·  برند محصول",
                  style: TextStyle(color: Color(0xFF018A08), fontSize: 12),
                ),
              ],
            ),
            SizedBox(width: screenWidth * 0.02051),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/eges.png',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: screenWidth * 0.02564),
            SvgPicture.asset(
              'assets/icons/arrow-right.svg',
              width: 20,
              height: 20,
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
            Navigator.of(context).pop();
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

  Widget _buildMiddleRow(BuildContext context, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ConditionalMarquee(
              text: "نام خوراکی در حالت طولانی / نام خوراکی در حالت طولانی",
              maxWidth: MediaQuery.of(context).size.width * 0.63076923076923076923076923076923,
              textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
              maxCharacters: 25,
            ),
            const Text(
              "خوشه محصول  ·  برند محصول",
              style: TextStyle(color: Color(0xFF018A08), fontSize: 12),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "(555 نفر) 4.5",
                      style: TextStyle(color: Color(0xFF018A08), fontSize: 12),
                    ),
                    SizedBox(width: screenWidth * 0.01026),
                    SvgPicture.asset(
                      'assets/icons/star.svg',
                      width: 16,
                      height: 16,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(width: screenWidth * 0.04103),
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
    return const Row(
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