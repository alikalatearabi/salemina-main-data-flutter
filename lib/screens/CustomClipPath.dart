import 'package:flutter/material.dart';

class TopArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.05);  // Start point slightly lower to match the image
    path.quadraticBezierTo(
      size.width / 2, size.height * 0.0,  // Control point at the top
      size.width, size.height * 0.05,  // End point also slightly lower
    );
    path.lineTo(size.width, size.height);  // Line to the bottom right
    path.lineTo(0, size.height);  // Line to the bottom left
    path.close();  // Complete the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}