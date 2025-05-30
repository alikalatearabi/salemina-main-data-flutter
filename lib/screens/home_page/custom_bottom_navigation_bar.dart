import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

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
      height: MediaQuery.of(context).size.height*0.09287531806615776081424936386768,
      child: Row(
        children: [
          _NavigationItem(
            iconPath: 'assets/icons/home.svg',
            label: 'خانه',
            isSelected: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _ComingSoonNavigationItem(
            iconPath: 'assets/icons/search-normal.svg',
            label: 'جستجو',
            isSelected: currentIndex == 1,
            onTap: () {},
          ),
          _MiddleNavigationItem(
            iconPath: 'assets/icons/scan.svg',
            onTap: () => onTap(2),
          ),
          _ComingSoonNavigationItem(
            iconPath: 'assets/icons/chart-square.svg',
            label: 'داشبورد',
            isSelected: currentIndex == 3,
            onTap: () {},
          ),
          _ComingSoonNavigationItem(
            iconPath: 'assets/icons/profile.svg',
            label: 'پروفایل',
            isSelected: currentIndex == 4,
            onTap: () {},
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

class _ComingSoonNavigationItem extends StatefulWidget {
  final String iconPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ComingSoonNavigationItem({
    required this.iconPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_ComingSoonNavigationItem> createState() => _ComingSoonNavigationItemState();
}

class _ComingSoonNavigationItemState extends State<_ComingSoonNavigationItem> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
    
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    
    _rotationAnimation = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          final snackBar = SnackBar(
            content: Text(
              'به زودی ویژگی ${widget.label} فعال خواهد شد!',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.orange,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            duration: const Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        onTapDown: (_) => setState(() => _isHovering = true),
        onTapUp: (_) => setState(() => _isHovering = false),
        onTapCancel: () => setState(() => _isHovering = false),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotationAnimation.value,
                      child: Opacity(
                        opacity: 0.5,
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.transparent,
                                blurRadius: 10,
                                offset: Offset.zero,
                              ),
                            ],
                          ),
                          child: SvgPicture.asset(
                            widget.iconPath,
                            width: 24,
                            height: 24,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  top: -10,
                  right: -15,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: _isHovering ? Colors.redAccent : Colors.orange,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: (_isHovering ? Colors.redAccent : Colors.orange).withOpacity(0.3),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: const Text(
                            'به زودی',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              widget.label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}