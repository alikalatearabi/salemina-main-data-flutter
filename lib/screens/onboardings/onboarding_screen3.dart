import 'package:flutter/material.dart';
import 'package:main_app/screens/onboardings/onboarding_screen4.dart';

class OnboardingScreen3 extends StatelessWidget {
  final int currentPage;

  const OnboardingScreen3({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 50),
                child: const Text(
                  'به سالمینا خوش آمدید',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF232A34)),
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                children: [
                  Image.asset('assets/onboarding3.png'),
                  const Text(
                    'بررسی و پایش مواد دریافتی هر محصول غذایی',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'تحلیل میزان کالری، قند، نمک، چربی و … محصولات مصرفی و ارائه هشدارهای تغذیه‌ای لازم',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(
                        0xFF464E59,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Container(
                      width: index == currentPage ? 30 : 15,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color:
                            index == currentPage ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF018A08),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            const OnboardingScreen4(currentPage: 3),
                      ),
                    );
                  },
                  child: const Text(
                    'صفحه بعد',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
