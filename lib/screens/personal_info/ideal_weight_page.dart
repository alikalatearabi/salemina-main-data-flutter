import 'package:flutter/material.dart';
import 'package:main_app/screens/activity_diet_page/activity_level_page.dart';
import 'package:main_app/utility/english_to_persian_number.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class IdealWeightPage extends StatefulWidget {
  final int userId;
  final double weight;
  final int height;
  
  const IdealWeightPage({
    super.key, 
    required this.userId,
    required this.weight,
    required this.height,
  });

  @override
  IdealWeightPageState createState() => IdealWeightPageState();
}

class IdealWeightPageState extends State<IdealWeightPage> {
  bool _isButtonEnabled = true;
  bool _isLoading = false;
  int selectedWeight = 75;
  int selectedDecimal = 0;

  // Populate initial weight from parent widget
  @override
  void initState() {
    super.initState();
    // Initialize with ideal weight as current weight (user can change)
    selectedWeight = widget.weight.floor();
    selectedDecimal = ((widget.weight - widget.weight.floor()) * 10).round();
  }

  // Submit physical attributes to the API
  Future<void> _submitPhysicalAttributes() async {
    setState(() {
      _isLoading = true;
      _isButtonEnabled = false;
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/auth/signup/physical-attributes'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId': widget.userId,
          'height': widget.height,
          'weight': widget.weight,
          'idealWeight': selectedWeight + (selectedDecimal * 0.1),
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success - navigate to next page
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ActivityLevelPage(userId: widget.userId),
            ),
          );
        }
      } else {
        // Show error
        if (mounted) {
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطا: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isButtonEnabled = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: ClipPath(
          clipper: ArcClipper(),
          child: Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 60,
              bottom: 30,
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  const Text(
                    "لطفا وزن ایده‌آل خود را به کیلوگرم وارد کنید",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildWeightField(),
                  const Spacer(),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _isButtonEnabled ? _submitPhysicalAttributes : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isButtonEnabled
              ? const Color(0xFF018A08)
              : const Color(0x929EABCC),
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        icon: _isLoading 
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Padding(
                padding: EdgeInsets.only(top: 3),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
        label: const Text(
          "تایید و ادامه",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(
            children: [
              Text(
                "وزن ایده‌آل",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFF018A08),
                width: 2.0,
              ),
            ),
            child: const Text(
              "۶ از ۱۲",
              style: TextStyle(
                color: Color(0xFF018A08),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightField() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildListWheel(
                  itemCount: 10,
                  initialItem: selectedDecimal,
                  onSelectedItemChanged: (index) => setState(() {
                    selectedDecimal = index;
                  }),
                  itemBuilder: (context, index) => _buildWeightItem(index),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: const Text(
                    ".",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildListWheel(
                  itemCount: 200,
                  initialItem: selectedWeight,
                  onSelectedItemChanged: (index) => setState(() {
                    selectedWeight = index;
                  }),
                  itemBuilder: (context, index) => _buildWeightItem(index),
                ),
                const SizedBox(width: 10),
                Container(
                  margin: const EdgeInsets.only(bottom: 18),
                  child: const Text(
                    "کیلوگرم",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF657381),
                    ),
                  ),
                ),
              ],
            ),
            IgnorePointer(
              child: Container(
                margin: const EdgeInsets.only(bottom: 18),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF018A08), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "محدوده سلامت BMI شما طبق محاسبات سالمینا مطابق محدوده سبز مشخص شده پایین می‌باشد.\nلطفا وزن هدف خود را در محدوده ایده‌آل سبز رنگ مشخص کنید.",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF657381),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeightItem(int value) {
    return Text(
      toPersianNumber(value.toString()),
      style: TextStyle(
        fontSize:
            (value == selectedWeight || value == selectedDecimal) ? 27 : 22,
        color: (value == selectedWeight || value == selectedDecimal)
            ? const Color(0xFF232A34)
            : const Color(0xFF657381),
      ),
    );
  }

  Widget _buildListWheel({
    required int itemCount,
    required int initialItem,
    required ValueChanged<int> onSelectedItemChanged,
    required IndexedWidgetBuilder itemBuilder,
  }) {
    return SizedBox(
      width: 80,
      height: 150,
      child: ListWheelScrollView.useDelegate(
        itemExtent: 50,
        diameterRatio: 1.5,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: onSelectedItemChanged,
        controller: FixedExtentScrollController(initialItem: initialItem),
        childDelegate: ListWheelChildBuilderDelegate(
          builder: itemBuilder,
          childCount: itemCount,
        ),
      ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 30);
    path.quadraticBezierTo(size.width / 2, 0, size.width, 30);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
