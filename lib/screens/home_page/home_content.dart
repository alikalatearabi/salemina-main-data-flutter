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

class HomeContent extends StatefulWidget {
  final UserData userData;
  final Future<void> Function(int glass)? onWaterTap;

  const HomeContent({super.key, required this.userData, this.onWaterTap});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late int _consumedGlasses;
  bool _isUpdatingWater = false;

  @override
  void initState() {
    super.initState();
    _consumedGlasses = widget.userData.waterConsumed.toInt();
  }

  @override
  void didUpdateWidget(covariant HomeContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.userData.waterConsumed != widget.userData.waterConsumed &&
        !_isUpdatingWater) {
      _consumedGlasses = widget.userData.waterConsumed.toInt();
    }
  }

  Future<void> _handleWaterTap(int glass) async {
    if (_isUpdatingWater) return;
    final previous = _consumedGlasses;
    setState(() {
      _consumedGlasses = glass;
      _isUpdatingWater = true;
    });

    try {
      await widget.onWaterTap?.call(glass);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _consumedGlasses = previous;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('خطا در ذخیره مصرف آب: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isUpdatingWater = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine screen size for responsive layouts
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // TODO: The health level logic should be mapped from userData.healthStatus
    final HealthLevel currentUserHealthLevel =
        _mapHealthStatus(widget.userData.healthStatus);
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
                  calories: widget.userData.calories,
                  nutrients: widget.userData.nutrients,
                  subscriptionType: widget.userData.subscriptionType,
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
                    consumedGlasses: _consumedGlasses,
                    totalGlasses: widget.userData.waterGoal.toInt(),
                    onGlassTap: _handleWaterTap,
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