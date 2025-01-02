import 'package:flutter/material.dart';
import 'package:main_app/screens/activity_diet_page/water_intake_page.dart';

class AllergiesPage extends StatefulWidget {
  const AllergiesPage({super.key});

  @override
  AllergiesPageState createState() => AllergiesPageState();
}

class AllergiesPageState extends State<AllergiesPage> {
  final List<AllergyCategory> allergies = [
    AllergyCategory("آجیل‌ها",
        ["بادام", "گردو", "فندق", "پسته", "فندق کاج", "سایر انواع آجیل"]),
    AllergyCategory("بادام زمینی", []),
    AllergyCategory("دانه‌های روغنی",
        ["بذر کنجد", "بذر آفتابگردان", "بذر کدو", "سایر دانه‌های روغنی"]),
    AllergyCategory("غلات حاوی گلوتن", ["گندم", "جو", "چاودار"]),
    AllergyCategory("تخم‌مرغ", []),
    AllergyCategory("شیر و لبنیات", []),
    AllergyCategory("ماهی و صدف‌های دریایی", []),
    AllergyCategory("سویا و محصولات سویا", []),
    AllergyCategory("ذرت و فرآورده های حاوی ذرت", []),
    AllergyCategory("سیب زمینی", []),
    AllergyCategory("گوجه فرنگی", []),
    AllergyCategory("بادمجان", []),
    AllergyCategory("فلفل", []),
    AllergyCategory("پیاز", []),
    AllergyCategory("کلم‌ها", ["گل‌کلم", "کلم بروکلی", "کلم پیچ"]),
    AllergyCategory("تره فرنگی", []),
    AllergyCategory("کاهو", []),
    AllergyCategory("کرفس", []),
    AllergyCategory("اسفناج", []),
  ];

  final Set<String> selectedAllergies = {};

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
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF018A08),
                            width: 2,
                          ),
                        ),
                        child: const Text(
                          "۱۳ از ۱۲",
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
                    "آلرژی‌ها",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "لطفا مواد غذایی حساسیت‌زا برای خود را مشخص کنید.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 12,
                        children: allergies
                            .expand(
                                (category) => _buildAllergyOptions(category))
                            .toList(),
                      ),
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

  List<Widget> _buildAllergyOptions(AllergyCategory category) {
    final List<Widget> widgets = [];

    widgets.addAll(category.items.map((item) => _buildAllergyChip(item)));

    if (category.items.isEmpty) {
      widgets.add(_buildAllergyChip(category.name));
    }

    return widgets;
  }

  Widget _buildAllergyChip(String allergy) {
    final bool isSelected = selectedAllergies.contains(allergy);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedAllergies.remove(allergy);
          } else {
            selectedAllergies.add(allergy);
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF018A08) : const Color(0xFFEEEEEE),
            width: 2,
          ),
          color: isSelected ? const Color(0xFFE8F5E9) : Colors.white,
        ),
        child: Text(
          allergy,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color:
                isSelected ? const Color(0xFF018A08) : const Color(0xFF232A34),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const WaterIntakePage(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF018A08),
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

class AllergyCategory {
  final String name;
  final List<String> items;

  AllergyCategory(this.name, this.items);
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
