import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(3, 0),
          ),
        ],
      ),
      height: 70,
      child: Row(
        children: [
          _NavigationItem(
            iconPath: 'assets/icons/home.svg',
            label: 'خانه',
            isSelected: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _NavigationItem(
            iconPath: 'assets/icons/search-normal.svg',
            label: 'جستجو',
            isSelected: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          _MiddleNavigationItem(
            iconPath: 'assets/icons/scan.svg',
            onTap: () => onTap(2),
          ),
          _NavigationItem(
            iconPath: 'assets/icons/chart-square.svg',
            label: 'داشبورد',
            isSelected: currentIndex == 3,
            onTap: () => onTap(3),
          ),
          _NavigationItem(
            iconPath: 'assets/icons/profile.svg',
            label: 'پروفایل',
            isSelected: currentIndex == 4,
            onTap: () => onTap(4),
          ),
        ],
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavigationItem({
    required this.iconPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: isSelected ? const Color(0xFFEF6EB) : Colors.transparent,
                    blurRadius: 10,
                    offset: Offset.zero,
                  ),
                ],
              ),
              child: SvgPicture.asset(
                iconPath,
                width: 24,
                height: 24,
                color: isSelected ? const Color(0xFF018A08) : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFF018A08) : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiddleNavigationItem extends StatelessWidget {
  final String iconPath;
  final VoidCallback onTap;

  const _MiddleNavigationItem({
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF018A08),
                shape: BoxShape.circle,
              ),
              height: 50,
              width: 50,
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}