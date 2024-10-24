import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_app/screens/onboardings/onboarding_screen2.dart';

class OnboardingScreen1 extends StatelessWidget {
  final int currentPage;

  const OnboardingScreen1({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
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
                  Image.asset('assets/onboarding1.png'),
                  const Text(
                    'دستیار دیجیتال انتخاب محصولات غذایی سالم تر',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'انتخاب  و آگاهانه‌تر مواد غذایی، بر اساس ملاحظات و نیازهای شما',
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
                            const OnboardingScreen2(currentPage: 1),
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
