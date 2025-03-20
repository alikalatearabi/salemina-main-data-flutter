import 'package:flutter/material.dart';
import 'package:main_app/screens/home_page/user_health_state.dart';
import 'package:main_app/screens/home_page/utils.dart';
import 'package:main_app/screens/home_page/water_tracker_widget.dart';

import 'action_button_with_modal.dart';
import 'health_helpers.dart';
import 'home_header_widget.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                HomeHeaderWidget(screenHeight: MediaQuery.of(context).size.height),
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
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildInfoBox(context, 'رتبه بندی خوشه ها', Image.asset('assets/icons/sorting.png', width: 80, height: 80)),
                        buildInfoBox(context, 'مقایسه محصولات', Image.asset('assets/icons/compare.png', width: 80, height: 80)),
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
          ],
        ),
      ),
    );
  }
}
