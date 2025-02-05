import 'package:flutter/material.dart';
import 'package:main_app/screens/personal_info/weight_page.dart';
import 'package:main_app/utility/english_to_persian_number.dart';

class HeightPage extends StatefulWidget {
  const HeightPage({super.key});

  @override
  HeightPageState createState() => HeightPageState();
}

class HeightPageState extends State<HeightPage> {
  bool _isButtonEnabled = true;
  int selectedHeight = 170;

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
                    "قد خود را به سانتی‌متر مشخص کنید",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildHeightField(),
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
        onPressed: _isButtonEnabled
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WeightPage(),
                  ),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isButtonEnabled
              ? const Color(0xFF018A08)
              : const Color(0x929EABCC),
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        icon: const Padding(
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
                'قد',
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
              "۴ از ۱۲",
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

  Widget _buildHeightField() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildListWheel(
              itemCount: 201,
              initialItem: selectedHeight - 50,
              onSelectedItemChanged: (index) => setState(() {
                selectedHeight = index + 50;
              }),
              itemBuilder: (context, index) => _buildHeightItem(index + 50),
            ),
            const SizedBox(width: 10),
            Container(
              margin: const EdgeInsets.only(bottom: 18),
              child: const Text(
                "سانتی‌متر",
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
    );
  }

  Widget _buildHeightItem(int height) {
    return Text(
      toPersianNumber(height.toString()),
      style: TextStyle(
        fontSize: 23,
        color: height == selectedHeight
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
