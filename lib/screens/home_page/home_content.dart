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

    final HealthLevel currentUserHealthLevel = HealthLevel.highRisk;
    final HealthStatusInfo statusInfo = getHealthStatusInfo(currentUserHealthLevel);

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
                      textDirection: TextDirection.ltr,
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
                      statusInfo: statusInfo,
                      onWarningPressed: () {
                        //todo
                        print('دکمه هشدار کلیک شد!');
                        _showHealthWarningsPopup(context);
                      },
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


  HealthStatusInfo getHealthStatusInfo(HealthLevel level) {
    switch (level) {
      case HealthLevel.perfect:
        return HealthStatusInfo(
          title: 'سلامت کامل',
          iconAsset: 'assets/icons/green_face.svg',
          color: const Color(0xFF25A749),
          levelValue: 5,
        );
      case HealthLevel.normal:
        return HealthStatusInfo(
          title: 'نرمال',
          iconAsset: 'assets/icons/light_green_face.svg',
          color: const Color(0xFF4BD772),
          levelValue: 4,
        );
      case HealthLevel.atRisk:
        return HealthStatusInfo(
          title: 'در معرض ابتلا',
          iconAsset: 'assets/icons/orange_face.svg',
          color:const Color(0xFFF5AE32),
          levelValue: 3,
        );
      case HealthLevel.mediumRisk:
        return HealthStatusInfo(
          title: 'ریسک متوسط',
          iconAsset: 'assets/icons/pink_face.svg',
          color: const Color(0xFFF2506E),
          levelValue: 2,
        );
      case HealthLevel.highRisk:
        return HealthStatusInfo(
          title: 'ریسک بالا',
          iconAsset: 'assets/icons/red_face.svg',
          color: const Color(0xFFD44661),
          levelValue: 1,
        );
    }
  }


  void _showHealthWarningsPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('هشدارها'),
          content: const Text('لیست هشدارها در اینجا نمایش داده می‌شود.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('بستن'),
            ),
          ],
        );
      },
    );
  }

}
