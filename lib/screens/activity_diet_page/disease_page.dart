import 'package:flutter/material.dart';
import 'package:main_app/screens/activity_diet_page/diet_page.dart';
import 'package:main_app/services/api_service.dart';
import 'package:main_app/models/user_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DiseasePage extends StatefulWidget {
  final int userId;
  final int activityLevelId;
  
  const DiseasePage({
    super.key, 
    required this.userId,
    required this.activityLevelId,
  });

  @override
  DiseasePageState createState() => DiseasePageState();
}

class DiseasePageState extends State<DiseasePage> {
  final Map<String, String> selectedConditions = {};
  Map<String, int> diseaseIdMap = {}; // Remove final keyword
  List<Disease> diseases = [];
  bool isLoading = true;
  bool isSubmitting = false;
  String? errorMessage;
  final ApiService _apiService = ApiService();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchDiseases();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _submitHealthInfo() async {
    setState(() {
      isSubmitting = true;
    });

    try {
      // Prepare illnesses data
      final List<Map<String, dynamic>> illnesses = [];
      
      selectedConditions.forEach((diseaseName, level) {
        if (diseaseIdMap.containsKey(diseaseName)) {
          final int diseaseId = diseaseIdMap[diseaseName]!;
          
          // Convert level to standard format (e.g., "بالا" -> "HIGH")
          String standardLevel = "MEDIUM"; // Default
          
          // This mapping should be adjusted based on your actual level names
          if (level.contains("بالا") || level == "دارم") {
            standardLevel = "HIGH";
          } else if (level.contains("پایین") || level.contains("کم")) {
            standardLevel = "LOW";
          } else if (level.contains("نرمال") || level == "ندارم") {
            standardLevel = "NORMAL";
          }
          
          illnesses.add({
            "id": diseaseId,
            "level": standardLevel
          });
        }
      });

      // Get activity level string
      String activityLevel = "MODERATE"; // Default
      
      // Map activity level ID to string value
      // This should be adjusted based on your actual data
      switch (widget.activityLevelId) {
        case 1:
          activityLevel = "LOW";
          break;
        case 2:
          activityLevel = "MODERATE";
          break;
        case 3:
          activityLevel = "HIGH";
          break;
        case 4:
          activityLevel = "VERY_HIGH";
          break;
      }

      // Submit data to API
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/auth/signup/health-info'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId': widget.userId,
          'activityLevel': activityLevel,
          'illnesses': illnesses,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success - store in user data and navigate to next page
        final userData = UserData.getInstance(widget.userId);
        userData.selectedIllnesses = illnesses;
        
        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DietPage(userId: widget.userId),
            ),
          );
        }
      } else {
        // Show error
        if (mounted) {
          setState(() {
            errorMessage = 'خطا: ${response.body}';
            isSubmitting = false;
          });
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('خطا: ${response.body}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        setState(() {
          errorMessage = 'خطا: ${e.toString()}';
          isSubmitting = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطا: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _fetchDiseases() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final response = await _apiService.fetchIllnessesWithLevels();
      
      // Extract disease IDs from API response
      final Map<String, int> idMap = {};
      for (final illness in response.illnesses) {
        idMap[illness.persianName] = illness.id;
      }
      
      setState(() {
        diseaseIdMap = idMap;
      });
      
      final mappedDiseases = _apiService.mapApiIllnessesToDiseases<Disease>(
        response, 
        (name, options) => Disease(name, options)
      );
      
      setState(() {
        diseases = mappedDiseases;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'خطا در دریافت اطلاعات: $e';
        // Fallback to hardcoded diseases in case of error
        diseases = [
          Disease("تیروئید", ["کم کاری", "پر کاری", "نرمال", "نامشخص"]),
          Disease("فشار خون", ["پایین", "نرمال", "بالا", "نامشخص"]),
          Disease("دیابت", ["سالم", "پیش دیابت", "دیابت"]),
          Disease("بیماری قلبی عروقی", ["دارم", "ندارم"]),
          Disease("کبد چرب", ["دارم", "ندارم"]),
          Disease("سندرم تخمدان پلی کیستیک", ["دارم", "ندارم"]),
          Disease("چاقی شکمی", ["دارم", "ندارم"]),
          Disease("تری گلیسیرید", ["نرمال", "بالا", "نامشخص"]),
          Disease("کلسترول", ["نرمال", "بالا", "نامشخص"]),
          Disease("اسید اوریک", ["نرمال", "بالا", "نامشخص"]),
          Disease("کراتینین", ["نرمال", "بالا", "نامشخص"]),
          Disease("وضعیت اشتها", ["کم", "معمولی", "زیاد"]),
          Disease("ریفلاکس معده", ["دارم", "ندارم"]),
          Disease("سوزش معده", ["دارم", "ندارم"]),
          Disease("کم خونی", ["دارم", "ندارم"]),
        ];
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
                          "۸ از ۱۲",
                          style: TextStyle(
                            color: Color(0xFF018A08),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, color: Colors.black),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "بیماری‌ها",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "در صورتی که هرکدام از بیماری‌های زیر را دارید مشخص کنید.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: _buildContent(),
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

  Widget _buildContent() {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorMessage!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchDiseases,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF018A08),
              ),
              child: const Text(
                "تلاش مجدد",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }

    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: true,
      thickness: 6,
      radius: const Radius.circular(8),
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.only(left: 12),
        itemCount: diseases.length,
        itemBuilder: (context, index) {
          final disease = diseases[index];
          final selectedCondition = selectedConditions[disease.name];
          return _buildDiseaseItem(disease, selectedCondition);
        },
      ),
    );
  }

  Widget _buildDiseaseItem(Disease disease, String? selectedCondition) {
    final isSelected = selectedCondition != null;
    return GestureDetector(
      onTap: () => _showConditionDialog(disease),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? const Color(0xFFF0F4F8) : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  isSelected
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: isSelected ? const Color(0xFF018A08) : Colors.grey,
                ),
                const SizedBox(width: 16),
                Text(
                  disease.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF232A34),
                  ),
                ),
              ],
            ),
            if (isSelected)
              Row(
                children: [
                  Text(
                    selectedCondition,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Color(0xFF018A08),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Image.asset(
                    'assets/icons/edit.png',
                    width: 22, 
                    height: 22, 
                    color: Colors.black, 
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogHeader(Disease disease) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "وضعیت ${disease.name}",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF000000),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: Colors.grey),
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
        ),
      ],
    );
  }

  void _showConditionDialog(Disease disease) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ClipPath(
          clipper: TopCurveClipperDialog(),
          child: StatefulBuilder(
            builder: (dialogContext, dialogSetState) {
              return Container(
                color: Colors.white,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDialogHeader(disease),
                        const SizedBox(height: 16),
                        Text(
                          "لطفا وضعیت ${disease.name} خود را مشخص کنید.",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...disease.options.map((option) {
                          final isSelected =
                              selectedConditions[disease.name] == option;

                          return GestureDetector(
                            onTap: () {
                              dialogSetState(() {
                                if (isSelected) {
                                  // Deselect the item
                                  selectedConditions.remove(disease.name);
                                } else {
                                  // Select the item
                                  selectedConditions[disease.name] = option;
                                }
                              });

                              setState(() {
                                if (isSelected) {
                                  // Deselect the item
                                  selectedConditions.remove(disease.name);
                                } else {
                                  // Select the item
                                  selectedConditions[disease.name] = option;
                                }
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF018A08)
                                      : const Color.fromARGB(
                                          255, 238, 238, 238),
                                  width: 2,
                                ),
                                color: isSelected
                                    ? const Color(0xFFE8F5E9)
                                    : Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    option,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: isSelected
                                          ? const Color(0xFF018A08)
                                          : Colors.black,
                                    ),
                                  ),
                                  Icon(
                                    isSelected
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_off,
                                    color: isSelected
                                        ? const Color(0xFF018A08)
                                        : Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: const Color(0xFF018A08),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              "تایید و ذخیره",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: isSubmitting ? null : _submitHealthInfo,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSubmitting 
              ? const Color(0xFF9E9E9E) 
              : const Color(0xFF018A08),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: isSubmitting 
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Icon(Icons.arrow_back_ios, color: Colors.white),
        label: const Text(
          "تایید و ادامه",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class Disease {
  final String name;
  final List<String> options;

  Disease(this.name, this.options);
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

class TopCurveClipperDialog extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 30); // Height of the curve
    path.quadraticBezierTo(size.width / 2, 0, size.width, 30);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
