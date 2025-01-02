import 'package:flutter/material.dart';
import 'package:main_app/screens/activity_diet_page/allergies_page.dart';

class PreferredFoodPage extends StatefulWidget {
  const PreferredFoodPage({super.key});

  @override
  PreferredFoodPageState createState() => PreferredFoodPageState();
}

class PreferredFoodPageState extends State<PreferredFoodPage> {
  String? selectedPreference;

  final List<FoodPreference> preferences = [
    FoodPreference("همه چیز خوار", ""),
    FoodPreference(
      "گیاه‌خواری (Vegetarianism)",
      "ترجیح مصرف غذاهای گیاهی مانند سبزیجات، میوه‌ها، غلات و حبوبات و پرهیز از خوردن گوشت و محصولات حیوانی.",
    ),
    FoodPreference(
      "Lacto-vegetarianism",
      "گیاهی‌خواری با مصرف محصولات لبنی مجاز.",
    ),
    FoodPreference(
      "Lacto-ovo-vegetarianism",
      "گیاهی‌خواری با مصرف محصولات لبنی و تخم‌مرغ مجاز.",
    ),
    FoodPreference(
      "Pescatarianism",
      "گیاهی‌خواری با مصرف ماهی و غذاهای دریایی مجاز.",
    ),
    FoodPreference(
      "Ketogenic",
      "رژیم غذایی کم‌کربوهیدرات و پرچربی برای تحریک فرآیند کتوز.",
    ),
    FoodPreference(
      "رژیم غذایی مبتنی بر حساسیت‌های غذایی",
      "اجتناب از مصرف خاص مواد غذایی که باعث واکنش‌های منفی می‌شوند، مانند گلوتن، لاکتوز یا آجیل.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            ClipPath(
              clipper: TopCurveClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: const Color.fromARGB(35, 202, 202, 200),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 120,
                left: 25,
                right: 25,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          "۱۲ از ۱۳",
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
                    "ترجیحات غذایی",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "ترجیح برنامه غذایی خود را انتخاب کنید.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: preferences.length,
                      itemBuilder: (context, index) {
                        final preference = preferences[index];
                        return _buildPreferenceOption(preference);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferenceOption(FoodPreference preference) {
    final isSelected = selectedPreference == preference.title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPreference = isSelected ? null : preference.title;
        });
      },
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      preference.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: isSelected
                            ? const Color(0xFF018A08)
                            : const Color(0xFF232A34),
                      ),
                    ),
                    if (preference.description.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        preference.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
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
    final isEnabled = selectedPreference != null;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: isEnabled
            ? () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AllergiesPage(),
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

class FoodPreference {
  final String title;
  final String description;

  FoodPreference(this.title, this.description);
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
