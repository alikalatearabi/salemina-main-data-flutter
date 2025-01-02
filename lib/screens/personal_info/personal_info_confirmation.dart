import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_app/screens/personal_info/name_info.dart';

class PersonalInfoConfirmationPage extends StatelessWidget {
  const PersonalInfoConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    _setStatusBarStyle();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          _buildImageSection(context),
          _buildBottomSection(context),
        ],
      ),
    );
  }

  void _setStatusBarStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 100, right: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            'assets/personal1.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipPath(
        clipper: ArcClipper(),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeaderRow(),
              const SizedBox(height: 30),
              _buildDescriptionText(),
              const SizedBox(height: 30),
              _buildStartButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: () {},
              style: _buttonStyle(Colors.grey[200]!),
              child: const Text(
                "رد کردن",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: const Text(
              "اطلاعات تکمیلی",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionText() {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Text(
        "در ادامه اطلاعاتی در مورد تغذیه و ورزش شما گرفته می‌شود.لطفا با دقت اطلاعات هر مرحله را وارد کنید تا تجربه بهتری برای شما فراهم کنیم",
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const NameInfoPage(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF018A08),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          ),
          icon: const Padding(
            padding: EdgeInsets.only(top: 3),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
          label: const Text(
            "شروع",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }

  ButtonStyle _buttonStyle(Color backgroundColor) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
