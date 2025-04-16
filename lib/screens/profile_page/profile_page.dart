import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:main_app/screens/home_page/water_tracker_widget.dart';
import 'package:main_app/screens/profile_page/profile_header_widget.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ProfileHeaderWidget(screenHeight: MediaQuery.of(context).size.height),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.51 - 320,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF018A08),
                              width: 3,
                            ),
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/gender_man_active.png'),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 26,
                            height: 26,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF018A08),
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/edit_profile.svg',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "شهاب الدین عسگری",
                        style: TextStyle(
                          color: Color(0xFF013C04),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "09123456789",
                        style: TextStyle(
                          color: Color(0xFF018A08),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildInfoBox(context, 'امتیاز کاربری',200
                      ),
                      buildInfoBox(context, 'محصولات اسکن شده',200
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width ,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFEBF6EB),
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: FittedBox(
                                    child: SvgPicture.asset(
                                      'assets/icons/user.svg',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            const Text(
                              "اطلاعات کاربری",
                              style: TextStyle(
                                color: Color(0xFF013C04),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFEBF6EB),
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: FittedBox(
                                    child: SvgPicture.asset(
                                      'assets/icons/info-circle.svg',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            const Text(
                              "راهنمای استفاده",
                              style: TextStyle(
                                color: Color(0xFF013C04),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFEBF6EB),
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: FittedBox(
                                    child: SvgPicture.asset(
                                      'assets/icons/message-question.svg',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            const Text(
                              "درباره سالمینا",
                              style: TextStyle(
                                color: Color(0xFF013C04),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFFEF1F3),
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: FittedBox(
                                    child: SvgPicture.asset(
                                      'assets/icons/logout.svg',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            const Text(
                              "خروج از حساب کاربری",
                              style: TextStyle(
                                color: Color(0xFF013C04),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),


                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width ,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      textDirection: TextDirection.rtl,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "بدون اشتراک",
                          style: TextStyle(
                            color: Color(0xFFF2506E),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10,),
                        Row(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "برای استفاده از تمام امکانات اشتراک تهیه کنید.",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: Color(0xFF013C04),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SvgPicture.asset(
                              'assets/icons/close.svg',
                              width: 24,
                              height: 24,
                            ),

                          ],
                        ),



                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoBox(BuildContext context, String text, int value) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF013C04),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            value.toString(),
            style: const TextStyle(
              color: Color(0xFF018A08),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),


        ],
      ),
    );
  }
}
