import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:main_app/screens/comparison_page/comparison_page.dart';
import 'package:main_app/screens/home_page/action_button_with_modal.dart';
import 'package:main_app/screens/home_page/health_helpers.dart';
import 'package:main_app/screens/home_page/health_warnings_page.dart';
import 'package:main_app/screens/home_page/user_health_state.dart';
import 'package:main_app/screens/home_page/utils.dart';
import '../search_page/cluster_ranking_page.dart' show ClusterRankingPage;
import 'home_header_widget.dart';
import 'models/user_data_model.dart';
import 'water_tracker_widget.dart';
class HomeContent extends StatelessWidget {
  final UserData userData;

  const HomeContent({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    // Determine screen size for responsive layouts
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // TODO: The health level logic should be mapped from userData.healthStatus
    final HealthLevel currentUserHealthLevel = _mapHealthStatus(userData.healthStatus);
    final HealthStatusInfo statusInfo = getHealthStatusInfo(currentUserHealthLevel);

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                HomeHeaderWidget(
                  calories: userData.calories,
                  nutrients: userData.nutrients,
                  subscriptionType: userData.subscriptionType,
                ),
                Positioned(
                  // Use responsive positioning
                  top: screenHeight * 0.405,
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 0),
              child: Column(
                children: [
                  // Use LayoutBuilder for more complex responsive scenarios if needed
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClusterRankingPage(),
                            ),
                          );
                        },
                        child: Flexible(
                          child: buildInfoBox(
                            context,
                            'رتبه بندی خوشه ها',
                            SvgPicture.asset(
                              'assets/icons/category.svg',
                              width: 56,
                              height: 56,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ComparisonScreen()));
                        },
                        child: Flexible(
                          child: buildInfoBox(
                            context,
                            'مقایسه محصولات',
                            SvgPicture.asset(
                              'assets/icons/compare.svg',
                              width: 56,
                              height: 56,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 0),
                  HealthStatusWidget(
                    statusInfo: statusInfo,
                    onWarningPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HealthWarningsPage(statusInfo: statusInfo),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 0),
                  WaterTrackerWidget(
                    consumedGlasses: userData.waterConsumed.toInt(),
                    totalGlasses: userData.waterGoal.toInt(),
                    onGlassTap: (glass) {
                      // TODO: Implement logic to update water consumption
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to map string status from backend to enum
  HealthLevel _mapHealthStatus(String status) {
    switch (status) {
      case 'perfect':
        return HealthLevel.perfect;
      case 'normal':
        return HealthLevel.normal;
      case 'atRisk':
        return HealthLevel.atRisk;
      case 'mediumRisk':
        return HealthLevel.mediumRisk;
      case 'highRisk':
        return HealthLevel.highRisk;
      default:
        return HealthLevel.normal;
    }
  }
}