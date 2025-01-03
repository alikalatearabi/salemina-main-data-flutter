import 'package:flutter/material.dart';
import 'package:main_app/screens/activity_diet_page/diet_page.dart';
import 'package:main_app/screens/home_page/utils.dart';
import 'custom_painters.dart'; // Import your custom painters

class HomeHeaderWidget extends StatelessWidget {
  final double screenHeight;

  const HomeHeaderWidget({
    super.key,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.51,
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
                buildHealthFactor('چربی', 200, 300),
                buildHealthFactor('اسید چرب', 50, 100),
                buildHealthFactor('قند', 80, 150),
                buildHealthFactor('نمک', 10, 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
