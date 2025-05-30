import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_app/screens/activity_diet_page/disease_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:main_app/models/user_data.dart';
import 'package:main_app/utility/env_config.dart';

class ActivityLevel {
  final int id;
  final String name;
  final String nameFa;
  final String description;
  final String descriptionFa;

  ActivityLevel({
    required this.id,
    required this.name,
    required this.nameFa,
    required this.description,
    required this.descriptionFa,
  });

  factory ActivityLevel.fromJson(Map<String, dynamic> json) {
    return ActivityLevel(
      id: json['id'],
      name: json['name'],
      nameFa: json['name_fa'],
      description: json['description'],
      descriptionFa: json['description_fa'],
    );
  }
}

class ActivityLevelPage extends StatefulWidget {
  final int userId;
  
  const ActivityLevelPage({super.key, required this.userId});

  @override
  ActivityLevelPageState createState() => ActivityLevelPageState();
}

class ActivityLevelPageState extends State<ActivityLevelPage> {
  String? selectedActivity;
  int? selectedActivityId;
  List<ActivityLevel> activityLevels = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchActivityLevels();
  }

  Future<void> fetchActivityLevels() async {
    try {
      final response = await http.get(
        Uri.parse('${EnvConfig.apiBaseUrl}/auth/activity-levels'),
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          activityLevels = data.map((item) => ActivityLevel.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'خطا در دریافت اطلاعات: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'خطا در ارتباط با سرور: $e';
        isLoading = false;
      });
    }
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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            ClipPath(
              clipper: TopCurveClipper(),
              child: Container(
                color: const Color.fromARGB(35, 202, 202, 200),
                height: MediaQuery.of(context).size.height,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 80,
                left: 25,
                right: 25,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF018A08),
                            width: 2,
                          ),
                        ),
                        child: const Text(
                          "۷ از ۱۲",
                          style: TextStyle(
                            color: Color(0xFF018A08),
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, color: Colors.black),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "میزان فعالیت",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "میزان فعالیت خود را مشخص کنید.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildActivityList(),
                  const Spacer(),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityList() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF018A08),
        ),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          children: [
            Text(
              errorMessage!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                  errorMessage = null;
                });
                fetchActivityLevels();
              },
              child: const Text('تلاش مجدد'),
            ),
          ],
        ),
      );
    }

    if (activityLevels.isEmpty) {
      return const Center(
        child: Text('هیچ داده‌ای یافت نشد'),
      );
    }

    return Column(
      children: activityLevels.map((level) => _buildActivityOption(level)).toList(),
    );
  }

  Widget _buildActivityOption(ActivityLevel level) {
    final isSelected = selectedActivity == level.nameFa;
    return GestureDetector(
      onTap: () => setState(() {
        selectedActivity = level.nameFa;
        selectedActivityId = level.id;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF018A08)
                : const Color.fromARGB(255, 197, 203, 209),
            width: isSelected ? 2 : 1,
          ),
          color: isSelected ? const Color(0xFFE8F5E9) : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      level.nameFa,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color:
                            isSelected ? const Color(0xFF018A08) : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      level.descriptionFa,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: isSelected ? const Color(0xFF018A08) : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    final isEnabled = selectedActivity != null;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: isEnabled
            ? () async {
                // Store activity level in UserData singleton
                UserData userData = UserData.getInstance(widget.userId);
                userData.activityLevelId = selectedActivityId;

                // Navigate to disease page to continue data collection
                // The API call will be made after collecting all data
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DiseasePage(
                      userId: widget.userId,
                      activityLevelId: selectedActivityId!,
                    ),
                  ),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isEnabled ? const Color(0xFF018A08) : const Color(0xFF9E9E9E),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        label: const Text(
          "تایید و ادامه",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 80);
    path.quadraticBezierTo(size.width / 2, 50, size.width, 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
