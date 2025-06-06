
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:main_app/screens/authentication_page/phone_number_page.dart';

import 'onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  final List<OnboardingContent> _contentList = [
    OnboardingContent(
      image: 'assets/images/onboarding_screen/onboarding1.svg',
      title: 'دستیار دیجیتال انتخاب محصولات غذایی سالم‌تر',
      description: 'انتخاب سالم‌تر و آگاهانه‌تر مواد غذایی، بر اساس ملاحظات و نیازهای شما',
    ),
    OnboardingContent(
      image: 'assets/images/onboarding_screen/onboarding2.svg',
      title: 'ارائه خدمات شخص سازی شده',
      description: 'تحلیل و ارائه هشدارهای سلامتی متناسب با نیازها و ویژگی‌های تغذیه‌های شما',
    ),
    OnboardingContent(
      image: 'assets/images/onboarding_screen/onboarding3.svg',
      title: 'بررسی و پایش مواد دریافتی هر محصول غذایی',
      description: 'تحلیل میزان کالری، قند، نمک، چربی و … محصولات مصرفی و ارائه هشدارهای تغذیه‌ای لازم',
    ),
    OnboardingContent(
      image: 'assets/images/onboarding_screen/onboarding4.svg',
      title: 'تحلیل الگوی مصرف و بهبود آن',
      description: 'تحلیل الگوی مصرف و همراهی با شما برای رسیدن به عادات تغذیه‌ای سالم‌تر با ایجاد آگاهی از محصولات سالم‌تر',
    ),
    OnboardingContent(
      image: 'assets/images/onboarding_screen/onboarding5.svg',
      title: 'استفاده از دانش روز در حوزه سلامت و تغذیه',
      description: 'بررسی و به‌کارگیری شاخص‌ها و قواعد معتبر تغذیه‌ای در ارائه پیشنهادات و هشدارهای تغذیه‌ای',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            children: [
              const Text(
                'به سالمینا خوش آمدید',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black
                ),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _contentList.length,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          _contentList[index].image,
                        width:MediaQuery.of(context).size.width*0.76,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _contentList[index].title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _contentList[index].description,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Color(0xFF464E59),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_contentList.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: index == _currentPage ? 16 : 8,
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: index == _currentPage ? Color(0xFF018A08) : Color(0xFFCBD1D6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF018A08),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_currentPage < _contentList.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const PhoneNumberPage(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    _currentPage < _contentList.length - 1
                        ? 'صفحه بعد'
                        : 'ورود/ثبت نام',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
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