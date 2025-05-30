import 'dart:math';
import 'package:flutter/material.dart';
import 'package:main_app/screens/home_page/utils.dart';
import 'package:main_app/services/nutrition_service.dart';
import 'dart:ui' as ui;

import 'custom_painters.dart';

// Utility function to convert English digits to Persian digits
String toPersianNumber(String number) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'];
  const persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹', '٫'];
  
  for (int i = 0; i < english.length; i++) {
    number = number.replaceAll(english[i], persian[i]);
  }
  return number;
}

class HomeHeaderWidget extends StatefulWidget {
  final double screenHeight;

  const HomeHeaderWidget({
    super.key,
    required this.screenHeight,
  });

  @override
  State<HomeHeaderWidget> createState() => _HomeHeaderWidgetState();
}

class _HomeHeaderWidgetState extends State<HomeHeaderWidget> {
  bool _isLoading = true;
  Map<String, dynamic> _nutritionData = {
    'nutritionTotals': {
      'calorie': 0,
      'fat': 0,
      'transfattyAcids': 0,
      'sugar': 0,
      'salt': 0,
    },
    'recommendedIntake': {
      'calorie': 2000,
      'fat': 70,
      'transfattyAcids': 2,
      'sugar': 30,
      'salt': 5,
    },
    'nutritionPercentage': {
      'calorie': 0,
      'fat': 0,
      'transfattyAcids': 0,
      'sugar': 0,
      'salt': 0,
    }
  };

  @override
  void initState() {
    super.initState();
    _fetchNutritionData();
  }

  Future<void> _fetchNutritionData() async {
    try {
      final data = await NutritionService.fetchHomeNutrition();
      if (mounted) {
        setState(() {
          _nutritionData = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching nutrition data: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Extract values from nutrition data
    final consumedCalories = _nutritionData['nutritionTotals']['calorie'] ?? 0;
    final totalCalories = _nutritionData['recommendedIntake']['calorie'] ?? 2000;
    final caloriePercentage = _nutritionData['nutritionPercentage']['calorie'] ?? 0;
    
    final fatTotal = _nutritionData['nutritionTotals']['fat'] ?? 0;
    final fatRecommended = _nutritionData['recommendedIntake']['fat'] ?? 70;
    
    final transfattyTotal = _nutritionData['nutritionTotals']['transfattyAcids'] ?? 0;
    final transfattyRecommended = _nutritionData['recommendedIntake']['transfattyAcids'] ?? 2;
    
    final sugarTotal = _nutritionData['nutritionTotals']['sugar'] ?? 0;
    final sugarRecommended = _nutritionData['recommendedIntake']['sugar'] ?? 30;
    
    final saltTotal = _nutritionData['nutritionTotals']['salt'] ?? 0;
    final saltRecommended = _nutritionData['recommendedIntake']['salt'] ?? 5;

    return ClipPath(
      clipper: BottomArcClipper(),
      child: Container(
        height: widget.screenHeight * 0.5,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/home_back.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Column(
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
                            'خانه',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          _ComingSoonSubscriptionButton(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: const Size(150, 150),
                            painter: HalfCirclePainter(),
                          ),
                          CustomPaint(
                            size: const Size(150, 150),
                            painter: HalfCircleFilledPainter(
                              consumedCalories: consumedCalories.toInt(),
                              totalCalories: totalCalories,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 45),
                              Text(
                                toPersianNumber(consumedCalories.toStringAsFixed(0)),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'از ${toPersianNumber(totalCalories.toString())} کیلو کالری',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '(${toPersianNumber(caloriePercentage.toStringAsFixed(0))}%)',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildHealthFactor(
                          context,
                          'چربی',
                          (fatTotal as num).toDouble(),
                          (fatRecommended as num).toDouble(),
                        ),
                        buildHealthFactor(
                          context,
                          'اسید چرب',
                          (transfattyTotal as num).toDouble(),
                          (transfattyRecommended as num).toDouble(),
                        ),
                        buildHealthFactor(
                          context,
                          'قند',
                          (sugarTotal as num).toDouble(),
                          (sugarRecommended as num).toDouble(),
                        ),
                        buildHealthFactor(
                          context,
                          'نمک',
                          (saltTotal as num).toDouble(),
                          (saltRecommended as num).toDouble(),
                        ),
                      ],
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

class _ComingSoonSubscriptionButton extends StatefulWidget {
  @override
  _ComingSoonSubscriptionButtonState createState() => _ComingSoonSubscriptionButtonState();
}

class _ComingSoonSubscriptionButtonState extends State<_ComingSoonSubscriptionButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _glowAnimation;
  bool _isPressed = false;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    
    _glowAnimation = Tween<double>(begin: 0.0, end: 5.0).animate(
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
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // The main button with shimmer effect
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return GestureDetector(
              onTap: () {
                final snackBar = SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.access_time, color: Colors.white),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'سیستم اشتراک به زودی راه اندازی می‌شود!',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.deepPurple,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  duration: const Duration(seconds: 2),
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  width: 280,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              onTapDown: (_) => setState(() => _isPressed = true),
              onTapUp: (_) => setState(() => _isPressed = false),
              onTapCancel: () => setState(() => _isPressed = false),
              child: CustomPaint(
                foregroundPainter: GlowingBorderPainter(
                  glowAmount: _glowAnimation.value,
                  glowColor: Colors.white.withOpacity(0.6),
                  borderColor: Colors.white,
                  borderWidth: 1.0,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: _isPressed 
                        ? Colors.white.withOpacity(0.3) 
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.workspace_premium,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'خرید اشتراک',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        
        // The "coming soon" badge
        Positioned(
          top: -15,
          right: -15,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              // Slightly rotate the badge with animation
              return Transform.rotate(
                angle: sin(_animationController.value * pi) * 0.1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.purple.shade700,
                        Colors.deepPurple.shade800,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.5),
                        blurRadius: 4 + 2 * _animationController.value,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: const Text(
                    'به زودی',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class GlowingBorderPainter extends CustomPainter {
  final double glowAmount;
  final Color glowColor;
  final Color borderColor;
  final double borderWidth;

  GlowingBorderPainter({
    required this.glowAmount,
    required this.glowColor,
    required this.borderColor,
    required this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(8));

    // Draw glow
    final Paint glowPaint = Paint()
      ..color = glowColor
      ..maskFilter = ui.MaskFilter.blur(ui.BlurStyle.normal, glowAmount);
    canvas.drawRRect(rrect, glowPaint);
  }

  @override
  bool shouldRepaint(covariant GlowingBorderPainter oldDelegate) {
    return oldDelegate.glowAmount != glowAmount ||
        oldDelegate.glowColor != glowColor ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.borderWidth != borderWidth;
  }
}
