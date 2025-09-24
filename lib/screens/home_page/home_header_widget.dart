import 'package:flutter/material.dart';
import 'package:main_app/screens/buy_subscription/buy_subscription_manager.dart';
import 'package:main_app/screens/profile_page/profile_header_widget.dart';
import 'custom_painters.dart';
import 'models/user_data_model.dart';
import 'utils.dart'; // Assuming utils file for helpers

class HomeHeaderWidget extends StatelessWidget {
  final CalorieData calories;
  final NutrientData nutrients;
  final String subscriptionType;

  const HomeHeaderWidget({
    super.key,
    required this.calories,
    required this.nutrients,
    required this.subscriptionType,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ClipPath(
      clipper: BottomArcClipper(),
      child: Container(
        height: screenHeight * 0.48,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/home_back.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    // TODO: The visibility and action of this button should depend on userData.subscriptionType
                    if (subscriptionType == 'free')
                      OutlinedButton(
                        onPressed: () {
                          showSalminaPurchaseModals(context);
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
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    if (subscriptionType != 'free')
                      OutlinedButton(
                        onPressed: () {
                          // TODO: Navigate to subscription page
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          side: const BorderSide(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'پرمیوم',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              //const Spacer(flex: 1),
              SizedBox(
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
                        consumedCalories: calories.consumed,
                        totalCalories: calories.total,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          toPersianNumber(calories.consumed.toString()),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'از ${toPersianNumber(calories.total.toString())} کیلو کالری',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              //const Spacer(flex: 2),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildHealthFactor(context, 'چربی', nutrients.fat.consumed, nutrients.fat.total),
                    buildHealthFactor(context, 'اسید چرب', nutrients.fattyAcid.consumed, nutrients.fattyAcid.total),
                    buildHealthFactor(context, 'قند', nutrients.sugar.consumed, nutrients.sugar.total),
                    buildHealthFactor(context, 'نمک', nutrients.salt.consumed, nutrients.salt.total),
                  ],
                ),
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}