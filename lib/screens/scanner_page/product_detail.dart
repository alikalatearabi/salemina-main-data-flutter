import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../product_page/conditional_marquee.dart';
import '../product_page/radial_chart_widget.dart';

class ProductDetail extends StatelessWidget {
  final Map<String, dynamic>? productData;
  
  const ProductDetail({
    super.key,
    this.productData,
  });

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
    // Calculate image size based on screen width (about 20% of screen width but capped between 60-80px)
    final imageSize = (screenWidth * 0.2).clamp(60.0, 80.0);
    
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ConditionalMarquee(
                  text: productData != null ? productData!['productName'] ?? "نام محصول" : "نام خوراکی در حالت طولانی / نام خوراکی در حالت طولانی",
                  maxWidth: screenWidth * 0.6,
                  textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
                  maxCharacters: 25,
                ),
                Text(
                  productData != null 
                    ? "${productData!['cluster'] ?? 'خوشه محصول'}  ·  ${productData!['brand'] ?? 'برند محصول'}"
                    : "خوشه محصول  ·  برند محصول",
                  style: const TextStyle(color: Color(0xFF018A08), fontSize: 12),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF018A08).withOpacity(0.16),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        minimumSize: Size(
                          screenWidth * 0.2,
                          MediaQuery.of(context).size.height * 0.03,
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
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.01),
                          SvgPicture.asset(
                            'assets/icons/info-circle.svg',
                            width: 14,
                            height: 14,
                            color: Color(0xFF015B05),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.015),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF018A08).withOpacity(0.16),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        minimumSize: Size(
                          screenWidth * 0.2,
                          MediaQuery.of(context).size.height * 0.03,
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
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.01),
                          SvgPicture.asset(
                            'assets/icons/star_linear.svg',
                            width: 14,
                            height: 14,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: productData != null && productData!['pictureOld'] != null && productData!['pictureOld'].isNotEmpty
              ? Image.network(
                  productData!['pictureOld'],
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildAdorableNotFoundPlaceholder(imageSize, imageSize);
                  },
                )
              : _buildAdorableNotFoundPlaceholder(imageSize, imageSize),
          ),
        ],
      ),
    );
  }

  Widget _buildAdorableNotFoundPlaceholder(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned.fill(
            child: CustomPaint(
              painter: DottedPatternPainter(
                dotColor: const Color(0xFFE0E0E0),
                dotSize: 4,
                spacing: 12,
              ),
            ),
          ),
          // Cute face
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: width * 0.5,
                  height: width * 0.5,
                  decoration: const BoxDecoration(
                    color: Color(0xFF018A08),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.local_dining_outlined,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: width * 0.7,
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFF018A08).withOpacity(0.7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomRow() {
    if (productData == null) {
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RadialChartWidget(
          label: 'نمک', 
          value: double.tryParse(productData!['salt']?.toString() ?? '0') ?? 0.0, 
          color: Color(0xFF4BB4D8)
        ),
        RadialChartWidget(
          label: 'قند', 
          value: double.tryParse(productData!['sugar']?.toString() ?? '0') ?? 0.0, 
          color: Color(0xFFF2506E)
        ),
        RadialChartWidget(
          label: 'اسید چرب', 
          value: double.tryParse(productData!['transfattyAcids']?.toString() ?? '0') ?? 0.0, 
          color: Color(0xFF8348F9)
        ),
        RadialChartWidget(
          label: 'چربی', 
          value: double.tryParse(productData!['fat']?.toString() ?? '0') ?? 0.0, 
          color: Color(0xFFF5AE32)
        ),
        RadialChartWidget(
          label: 'کالری', 
          value: double.tryParse(productData!['calorie']?.toString() ?? '0') ?? 0.0, 
          color: Colors.black
        ),
      ],
    );
  }
}

class DottedPatternPainter extends CustomPainter {
  final Color dotColor;
  final double dotSize;
  final double spacing;

  DottedPatternPainter({
    required this.dotColor,
    required this.dotSize,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = dotColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = dotSize;

    final rows = (size.height / spacing).floor();
    final cols = (size.width / spacing).floor();

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        // Create a staggered pattern by offsetting every other row
        final offset = i % 2 == 0 ? 0.0 : spacing / 2;
        final x = j * spacing + offset;
        final y = i * spacing;
        
        if (x < size.width && y < size.height) {
          canvas.drawCircle(Offset(x, y), dotSize / 2, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}