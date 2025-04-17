import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../product_page/conditional_marquee.dart';
import '../product_page/radial_chart_widget.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0615384615),
      child: Column(
        children: [
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
                        "مشاور تغذیه ای",
                        style: TextStyle(
                          color: Color(0xFF015B05),
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.01538),
                      SvgPicture.asset(
                        'assets/icons/info-circle.svg',
                        width: 16,
                        height: 16,
                        color: Color(0xFF015B05),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: screenWidth * 0.02051),
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


}