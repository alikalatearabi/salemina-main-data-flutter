import 'dart:math';

import 'package:flutter/material.dart';
import 'package:main_app/screens/activity_diet_page/diet_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.50,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/home_back.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 50,
                          right: 20,
                          left: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'خانه',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const DietPage(),
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                side: const BorderSide(color: Colors.white),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Text(
                                'خرید اشتراک',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 210,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          margin: const EdgeInsets.only(bottom: 80),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 200,
                                height: 200,
                                child: CustomPaint(
                                  painter: HalfCirclePainter(),
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                height: 200,
                                child: CustomPaint(
                                  painter: HalfCircleFilledPainter(
                                    consumedCalories: 500,
                                    totalCalories: 2000,
                                  ),
                                ),
                              ),
                              Center(
                                child: Transform.translate(
                                  offset: const Offset(0, 50),
                                  child: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '۵۰۰',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'از ۲۰۰۰ کالری',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Health factors section
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 0,
                        left: 20,
                        right: 20,
                        bottom: 70,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildHealthFactor('چربی', 200, 300),
                          _buildHealthFactor('اسید چرب', 50, 100),
                          _buildHealthFactor('قند', 80, 150),
                          _buildHealthFactor('نمک', 10, 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Transform.translate(
                      offset: const Offset(0, -35),
                      child: ClipPath(
                        clipper: TopArcClipper(),
                        child: Container(
                          width: double.infinity,
                          color: const Color(0xFFF3F5F7),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 50, left: 20, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildInfoBox(
                                      context,
                                      'رتبه بندی خوشه ها',
                                      Image.asset(
                                        'assets/icons/sorting.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                    ),
                                    _buildInfoBox(
                                      context,
                                      'مقایسه محصولات',
                                      Image.asset(
                                        'assets/icons/compare.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                    ),
                                  ],
                                ),
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 2,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/icons/${getHealthIcon()}.png',
                                          width: 60,
                                          height: 60,
                                        ),
                                        const SizedBox(width: 16),
                                        SizedBox(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                getHealthText(),
                                                style: const TextStyle(
                                                  color: Color(0xFF018A08),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children:
                                                    List.generate(6, (index) {
                                                  return SizedBox(
                                                    child: Container(
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 2),
                                                      height: 8,
                                                      decoration: BoxDecoration(
                                                        color: index <
                                                                getHealthLevel()
                                                            ? Colors.green
                                                            : Colors.grey[300],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 2,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'آب',
                                              style: TextStyle(
                                                color: Color(0xFF013C04),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 14,
                                                      vertical: 8),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    146, 228, 226, 226),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Text(
                                                '۲ از ۹ لیوان',
                                                style: TextStyle(
                                                  color: Color(0xFF232A34),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: List.generate(9, (index) {
                                            return GestureDetector(
                                              onTap: () {
                                                // Handle glass tap
                                              },
                                              child: Icon(
                                                Icons.water_drop,
                                                color: index < 2
                                                    ? Colors.blue
                                                    : Colors.grey,
                                                size: 30,
                                              ),
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -55,
                      left: 90,
                      right: 90,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return GestureDetector(
                                onTap: () {},
                                child: _buildProductOptionsModal(context),
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Color(0xFF018A08),
                        ),
                        label: const Text(
                          'مصرف وعده غذایی',
                          style: TextStyle(
                            color: Color(0xFF018A08),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 4,
                          side: const BorderSide(
                            color: Color(0xFF82C786),
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getHealthIcon() {
    return 'green_face';
  }

  String getHealthText() {
    return 'سلامت کامل';
  }

  int getHealthLevel() {
    return 6;
  }

  Widget _buildInfoBox(BuildContext context, String text, Widget icon) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF018A08),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Helper method to build a health factor widget
  Widget _buildHealthFactor(String name, int consumed, int total) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 3),
          Container(
            width: 60,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: consumed / total,
                backgroundColor: Colors.transparent,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$consumed گرم',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for the half circle background
class HalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height),
      radius: size.width / 2,
    );

    canvas.drawArc(rect, -pi, pi * 1.2, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for the filled half circle
class HalfCircleFilledPainter extends CustomPainter {
  final int consumedCalories;
  final int totalCalories;

  HalfCircleFilledPainter(
      {required this.consumedCalories, required this.totalCalories});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height),
      radius: size.width / 2,
    );

    final sweepAngle = (pi * consumedCalories) / totalCalories;

    canvas.drawArc(rect, -pi * 1.19, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TopArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, 20); // Move to start of the arc
    path.quadraticBezierTo(
      size.width / 2, // Control point at the middle of the width
      -20, // Control point height (negative for upward curve)
      size.width, // End of the arc
      20, // Back to the bottom
    );
    path.lineTo(size.width, size.height); // Down the right edge
    path.lineTo(0, size.height); // Across the bottom
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

Widget _buildProductOptionsModal(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min, // Center content in the modal
      children: [
        _buildModalButton(
          context,
          'اسکن محصول',
          Icons.qr_code_scanner, // Icon for scanning
          () {
            // Action for اسکن محصول
          },
        ),
        const SizedBox(height: 16), // Space between buttons
        _buildModalButton(
          context,
          'جست و جوی محصول',
          Icons.search, // Icon for search
          () {
            // Action for جست و جوی محصول
          },
        ),
      ],
    ),
  );
}

Widget _buildModalButton(
    BuildContext context, String text, IconData icon, VoidCallback onPressed) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.7, // 70% of screen width
    child: ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: const Color(0xFF018A08), // Icon color
      ),
      label: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF018A08), // Text color
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(
          color: Color(0xFF018A08),
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
      ),
    ),
  );
}

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}
