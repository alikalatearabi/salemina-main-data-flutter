import 'package:flutter/material.dart';
import 'package:main_app/screens/personal_info/gender_page.dart';

class NameInfoPage extends StatefulWidget {
  const NameInfoPage({super.key});

  @override
  NameInfoPageState createState() => NameInfoPageState();
}

class NameInfoPageState extends State<NameInfoPage> {
  final TextEditingController _nameController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_onNameChanged);
  }

  void _onNameChanged() {
    setState(() {
      _isButtonEnabled = _nameController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: Container(
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
                    "نام و نام‌خانوادگی خود را وارد کنید.",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 20),
                  _buildNameInput(),
                  const Spacer(),
                  _buildSubmitButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "نام و نام‌خانوادگی",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
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
            "۱ از ۱۲",
            style: TextStyle(
              color: Color(0xFF018A08),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget  _buildNameInput() {
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(
        hintText: "نام و نام‌خانوادگی",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color(0xFF657381),
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color(0xFF232A34),
            width: 2,
          ),
        ),
      ),
      style: const TextStyle(
        color: Color(0xFF232A34),
        fontSize: 20,
      ),
    );
  }

Widget _buildSubmitButton(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: _isButtonEnabled
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GenderPage(), 
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
