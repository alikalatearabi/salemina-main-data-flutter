import 'package:flutter/material.dart';
import 'package:main_app/screens/activity_diet_page/diet_page.dart';
import 'package:main_app/screens/home_page/action_button_with_modal.dart';
import 'package:main_app/screens/home_page/custom_painters.dart';
import 'package:main_app/screens/home_page/health_helpers.dart';
import 'package:main_app/screens/home_page/user_health_state.dart';
import 'package:main_app/screens/home_page/utils.dart';
import 'package:main_app/screens/home_page/water_tracker_widget.dart';

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
                          buildHealthFactor('چربی', 200, 300),
                          buildHealthFactor('اسید چرب', 50, 100),
                          buildHealthFactor('قند', 80, 150),
                          buildHealthFactor('نمک', 10, 30),
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
                                    buildInfoBox(
                                      context,
                                      'رتبه بندی خوشه ها',
                                      Image.asset(
                                        'assets/icons/sorting.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                    ),
                                    buildInfoBox(
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
                                HealthStatusWidget(
                                  healthIcon: getHealthIcon(),
                                  healthText: getHealthText(),
                                  healthLevel: getHealthLevel(),
                                ),
                                WaterTrackerWidget(
                                  consumedGlasses: 2,
                                  totalGlasses: 9,
                                  onGlassTap: (glass) {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    ActionButtonWithModal(
                      label: 'مصرف وعده غذایی',
                      icon: Icons.add,
                      modalBuilder: (context) {
                        return GestureDetector(
                          onTap: () {},
                          child: buildProductOptionsModal(context),
                        );
                      },
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
}

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}
