import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_app/screens/activity_diet_page/prefered_food_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:main_app/models/user_data.dart';
import 'package:main_app/utility/env_config.dart';

class DietPage extends StatefulWidget {
  final int userId;
  
  const DietPage({super.key, required this.userId});

  @override
  DietPageState createState() => DietPageState();
}

class DietPageState extends State<DietPage> {
  String? selectedActivityId;
  List<ActivityOption> activityOptions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchActivityOptions();
  }

  Future<void> fetchActivityOptions() async {
    try {
      final response = await http.get(Uri.parse('${EnvConfig.apiBaseUrl}/auth/appetite-modes'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          activityOptions = data.map((item) => ActivityOption.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching activity options: $e');
      setState(() {
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
                top: 90,
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
                          "۹ از ۱۳",
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
                    "وضعیت اشتها",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "میزان اشتهای خود را مشخص کنید.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (isLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    ...activityOptions.map((option) => _buildActivityOption(option)),
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

  Widget _buildActivityOption(ActivityOption option) {
    final isSelected = selectedActivityId == option.id;
    return GestureDetector(
      onTap: () => setState(() {
        selectedActivityId = option.id;
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
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color:
                          isSelected ? const Color(0xFF018A08) : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
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
    final isEnabled = selectedActivityId != null;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: isEnabled
            ? () {
                // Store appetite mode ID in UserData
                UserData.getInstance(widget.userId).appetiteLevel = selectedActivityId!;

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PreferredFoodPage(userId: widget.userId),
                  ),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isEnabled ? const Color(0xFF018A08) : const Color(0xFF9E9E9E),
          padding: const EdgeInsets.symmetric(vertical: 16),
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

class ActivityOption {
  final String id;
  final String title;

  ActivityOption(this.id, this.title);

  factory ActivityOption.fromJson(Map<String, dynamic> json) {
    return ActivityOption(json['id'] as String, json['name_fa'] as String);
  }
}

class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 100);
    path.quadraticBezierTo(size.width / 2, 50, size.width, 100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
