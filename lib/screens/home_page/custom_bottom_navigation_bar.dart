import 'package:flutter/material.dart';

import '../dashboard_page/dashboard_page.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final void Function()? onHomePressed;
  final void Function()? onDashboardPressed ;
  final void Function()? onSearchPressed;
  final void Function()? onProfilePressed;
  final void Function()? onScanPressed;
  final String selectedPage; // Added to track selected page

  const CustomBottomNavigationBar({
    super.key,
    this.onHomePressed,
    this.onDashboardPressed,
    this.onSearchPressed,
    this.onProfilePressed,
    this.onScanPressed,
    required this.selectedPage, required Null Function() onNotificationsPressed, // Required selected page parameter
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: const EdgeInsets.all(16),
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                assetPath: 'assets/icons/home.png',
                label: 'خانه',
                onPressed: onHomePressed,
                isSelected: selectedPage == 'home',
              ),
              _buildNavItem(
                assetPath: 'assets/icons/dashboard.png',
                label: 'داشبورد',
                onPressed: () {
                  print("object");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardPage()),
                  );
                },
                isSelected: selectedPage == 'dashboard',
              ),
              _buildScanButton(onPressed: onScanPressed),
              _buildNavItem(
                assetPath: 'assets/icons/search.png',
                label: 'جستجو',
                onPressed: onSearchPressed,
                isSelected: selectedPage == 'search',
              ),
              _buildNavItem(
                assetPath: 'assets/icons/profile.png',
                label: 'پروفایل',
                onPressed: onProfilePressed,
                isSelected: selectedPage == 'profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String assetPath,
    required String label,
    required void Function()? onPressed,
    required bool isSelected, // Added to determine selection
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              
              Image.asset(
                assetPath,
                width: 24,
                height: 24,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? const Color(0xFF018A08) : const Color(0xFF657381),
              decoration: TextDecoration.none,
              fontFamily: 'Yekan',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanButton({required void Function()? onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFF018A08),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF018A08).withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Icon(
          Icons.qr_code_scanner,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }
}
