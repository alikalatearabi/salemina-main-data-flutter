import 'package:flutter/material.dart';

class WaterIntakePage extends StatefulWidget {
  const WaterIntakePage({super.key});

  @override
  WaterIntakePageState createState() => WaterIntakePageState();
}

class WaterIntakePageState extends State<WaterIntakePage> {
  int selectedGlass = 8;

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
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF018A08),
                            width: 2,
                          ),
                        ),
                        child: const Text(
                          "۱۳ از ۱۳",
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
                  const SizedBox(height: 16),
                  const Text(
                    "میزان آب",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8), 
                  const Text(
                    "میزان لیوان آب مصرفی روزانه خود را مشخص کنید.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 48),
                  Center(
                    child: SizedBox(
                      height: 200,
                      child: ListWheelScrollView.useDelegate(
                        itemExtent: 50,
                        diameterRatio: 1.5,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            selectedGlass = index + 1;
                          });
                        },
                        controller:
                            FixedExtentScrollController(initialItem: 8 - 1),
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) {
                            final isSelected = (index + 1) == selectedGlass;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF018A08)
                                      : const Color(0xFFE0E0E0),
                                  width: 2,
                                ),
                                color: isSelected
                                    ? const Color(0xFFE8F5E9)
                                    : Colors.transparent,
                              ),
                              child: Text(
                                "${index + 1} لیوان",
                                style: TextStyle(
                                  fontSize: isSelected ? 20 : 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? const Color(0xFF018A08)
                                      : const Color(0xFF232A34),
                                ),
                              ),
                            );
                          },
                          childCount: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
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

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          print("Selected Glasses: $selectedGlass");
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
