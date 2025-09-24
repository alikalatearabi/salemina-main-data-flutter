import 'dart:math';
import 'package:flutter/material.dart';
import 'package:main_app/screens/home_page/utils.dart';

import 'custom_painters.dart';

// Utility function to convert English digits to Persian digits
String toPersianNumber(String number) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'];
  const persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹', '٫'];
  
  for (int i = 0; i < english.length; i++) {
    number = number.replaceAll(english[i], persian[i]);
  }
  return number;
}

class HomeHeaderWidget extends StatelessWidget {
  final double screenHeight;

  const HomeHeaderWidget({
    super.key,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomArcClipper(),
      child: Container(
        height: screenHeight * 0.5,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/home_back.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'خانه',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {

                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        side: const BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'خرید اشتراک',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: 150,
                height: 150,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size(150, 150),
                      painter: HalfCirclePainter(),
                    ),
                    CustomPaint(
                      size: const Size(150, 150),
                      painter: HalfCircleFilledPainter(
                        consumedCalories: 625,
                        totalCalories: 2000,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height:45),
                        Text(
                          toPersianNumber('625'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'از ${toPersianNumber('2000')} کیلو کالری',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            // const SizedBox(width: 4),
                            // Text(
                            //   '(${toPersianNumber('32')}%)',
                            //   style: const TextStyle(
                            //     color: Colors.white,
                            //     fontSize: 12,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildHealthFactor(context, 'چربی', 66, 138), // 48%
                  buildHealthFactor(context, 'اسید چرب', 5, 50), // 10%
                  buildHealthFactor(context, 'قند', 25, 20), // 123%
                  buildHealthFactor(context, 'نمک', 38, 56), // 68%
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}

class BottomArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(
      size.width / 2, size.height - 60,
      size.width, size.height - 20,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
