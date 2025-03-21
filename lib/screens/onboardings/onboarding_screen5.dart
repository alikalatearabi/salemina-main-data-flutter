import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_app/screens/authentication_page/phone_number_page.dart';

class OnboardingScreen5 extends StatelessWidget {
  final int currentPage;

  const OnboardingScreen5({super.key, required this.currentPage});

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
                  Image.asset('assets/onboarding5.png'),
                  const Text(
                    'استفاده از دانش روز در حوزه سلامت و تغذیه',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: const Text(
                      'بررسی و به‌کارگیری شاخص‌ها و قواعد معتبر تغذیه‌ای در ارائه پیشنهادات و هشدارهای تغذیه‌ای',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(
                          0xFF464E59,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
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
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PhoneNumberPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'ورود/ثبت نام',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
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
