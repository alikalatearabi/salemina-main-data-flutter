import 'package:flutter/material.dart';
import 'package:main_app/utility/english_to_persian_number.dart';

class IdealWeightPage extends StatefulWidget {
  const IdealWeightPage({super.key});

  @override
  IdealWeightPageState createState() => IdealWeightPageState();
}

class IdealWeightPageState extends State<IdealWeightPage> {
  bool _isButtonEnabled = true;
  int selectedWeight = 75;
  int selectedDecimal = 0;

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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                      fontWeight: FontWeight.bold,
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
        onPressed: _isButtonEnabled
            ? () {
                print("Selected Weight: $selectedWeight.${selectedDecimal} kg");
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isButtonEnabled
              ? const Color(0xFF018A08)
              : const Color(0x929EABCC),
          padding: const EdgeInsets.symmetric(vertical: 15),
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
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
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
