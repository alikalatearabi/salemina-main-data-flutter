import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:main_app/screens/home_page/user_health_state.dart';
import 'package:main_app/screens/home_page/utils.dart';
import 'package:main_app/screens/home_page/water_tracker_widget.dart';

import '../search_page/cluster_ranking_page.dart';
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
                  top: MediaQuery.of(context).size.height * 0.51 - 70,
                  left: MediaQuery.of(context).size.width * 0.25,
                  right: MediaQuery.of(context).size.width * 0.25,
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
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap:(){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ClusterRankingPage()),
                            );
        
                          },
                          child: buildInfoBox(context, 'رتبه بندی خوشه ها',
                            SvgPicture.asset(
                              'assets/icons/category.svg',
                              width: 56,
                              height: 56,
                            ),
                          ),
                        ),
                        buildInfoBox(context, 'مقایسه محصولات',
                          SvgPicture.asset(
                            'assets/icons/compare.svg',
                            width: 56,
                            height: 56,
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
                    SizedBox(height: 6,)
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
