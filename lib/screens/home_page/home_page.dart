import 'package:flutter/material.dart';
import 'package:main_app/screens/home_page/action_button_with_modal.dart';
import 'package:main_app/screens/home_page/custom_bottom_navigation_bar.dart';
import 'package:main_app/screens/home_page/custom_painters.dart';
import 'package:main_app/screens/home_page/health_helpers.dart';
import 'package:main_app/screens/home_page/home_header_widget.dart';
import 'package:main_app/screens/home_page/user_health_state.dart';
import 'package:main_app/screens/home_page/utils.dart';
import 'package:main_app/screens/home_page/water_tracker_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                children: [
                  HomeHeaderWidget(
                    screenHeight: MediaQuery.of(context).size.height,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
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
                                  top: 50,
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
        ),
        CustomBottomNavigationBar(
          onHomePressed: () {
            print('Home button pressed');
          },
          onSearchPressed: () {
            print('Search button pressed');
          },
          onNotificationsPressed: () {
            print('Notifications button pressed');
          },
          onProfilePressed: () {
            print('Profile button pressed');
          }, selectedPage: 'home',
        ),
      ],
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}
