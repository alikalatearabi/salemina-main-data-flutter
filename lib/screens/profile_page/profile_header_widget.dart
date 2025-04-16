import 'dart:math';
import 'package:flutter/material.dart';
import 'package:main_app/screens/home_page/utils.dart';


class ProfileHeaderWidget extends StatelessWidget {
  final double screenHeight;

  const ProfileHeaderWidget({
    super.key,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomArcClipper(),
      child: Container(
        height: screenHeight * 0.22,
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.center,
            image: AssetImage('assets/home_back.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'پروفایل',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        side: const BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'خرید اشتراک',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
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

class BottomArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(
      size.width / 2, size.height - 60,
      size.width, size.height - 20,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
