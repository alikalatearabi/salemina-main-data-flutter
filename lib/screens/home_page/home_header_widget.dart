import 'dart:math';
import 'package:flutter/material.dart';
import 'package:main_app/screens/home_page/utils.dart';

import 'custom_painters.dart';

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
                        consumedCalories: 555,
                        totalCalories: 2000,
                      ),
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height:45),
                        Text(
                          '555',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'از ۲۰۰۰ کیلو کالری',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
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
                  buildHealthFactor(context,'چربی', 200, 300),
                  buildHealthFactor(context,'اسید چرب', 50, 100),
                  buildHealthFactor(context,'قند', 80, 150),
                  buildHealthFactor(context,'نمک', 10, 30),
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
