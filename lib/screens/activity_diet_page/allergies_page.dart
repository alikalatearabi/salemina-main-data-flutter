import 'package:flutter/material.dart';
import 'package:main_app/screens/activity_diet_page/water_intake_page.dart';
import 'package:main_app/models/user_data.dart';
import 'package:main_app/services/allergies_service.dart';

class AllergiesPage extends StatefulWidget {
  final int userId;
  
  const AllergiesPage({super.key, required this.userId});

  @override
  AllergiesPageState createState() => AllergiesPageState();
}

class AllergiesPageState extends State<AllergiesPage> {
  List<AllergyCategory> allergies = [];
  bool isLoading = true;
  Set<int> selectedAllergyIds = {};

  @override
  void initState() {
    super.initState();
    fetchAllergies();
  }

  Future<void> fetchAllergies() async {
    try {
      final allergyCategories = await AllergiesService.getAllergies();
      setState(() {
        allergies = allergyCategories;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching allergies: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

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
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SingleChildScrollView(
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

    // Add all allergy items from this category
    for (var item in category.items) {
      widgets.add(_buildAllergyChip(item));
    }

    if (category.items.isEmpty) {
      widgets.add(_buildAllergyChip(AllergyItem(category.id, category.name)));
    }

    return widgets;
  }

  Widget _buildAllergyChip(AllergyItem allergy) {
    final bool isSelected = selectedAllergyIds.contains(allergy.id);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedAllergyIds.remove(allergy.id);
          } else {
            selectedAllergyIds.add(allergy.id);
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
          allergy.name,
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
        onPressed: () async {
          try {
            // Store allergies in UserData
            final userData = UserData.getInstance(widget.userId);
            userData.allergies = selectedAllergyIds.map((id) => id.toString()).toList();
            
            // Submit allergies using the service
            await AllergiesService.submitAllergies(
              userId: widget.userId,
              allergyIds: selectedAllergyIds.toList(),
            );

            // Navigate to next page on success
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => WaterIntakePage(userId: widget.userId),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('خطا: $e'), backgroundColor: Colors.red),
            );
          }
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
