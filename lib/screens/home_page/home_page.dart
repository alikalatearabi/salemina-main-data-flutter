import 'package:flutter/material.dart';
import 'package:main_app/screens/home_page/action_button_with_modal.dart';
import 'package:main_app/screens/home_page/health_helpers.dart';
import 'package:main_app/screens/home_page/home_header_widget.dart';
import 'package:main_app/screens/home_page/user_health_state.dart';
import 'package:main_app/screens/home_page/utils.dart';
import 'package:main_app/screens/home_page/water_tracker_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            color: const Color(0xFFF3F5F7),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        HomeHeaderWidget(
                          screenHeight: MediaQuery.of(context).size.height,
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.51 - 60,
                          left: MediaQuery.of(context).size.width * 0.2,
                          right: MediaQuery.of(context).size.width * 0.2,
                          child: ActionButtonWithModal(
                            label: 'مصرف وعده غذایی',
                            icon: Icons.add,
                            modalBuilder: (context) {
                              return GestureDetector(
                                onTap: () {},
                                child: buildProductOptionsModal(context),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Container(
                        width: double.infinity,
                        color: const Color(0xFFF3F5F7),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 20,
                            right: 20,
                          ),
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
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_outline_rounded,
                        size: 30,
                        color: Color(0xFF232A34),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'پروفایل',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF657381),
                          fontFamily: "yekanBakh",
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        size: 30,
                        color: Color(0xFF232A34),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'جست و جو',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF657381),
                          fontFamily: "yekanBakh",
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Color(0xFF018A08),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.qr_code_scanner,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.dashboard_outlined,
                        size: 30,
                        color: Color(0xFF232A34),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'داشبورد',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF657381),
                          fontFamily: "yekanBakh",
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home_outlined,
                        size: 30,
                        color: Color(0xFF232A34),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'خانه',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF657381),
                          fontFamily: "yekanBakh",
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
