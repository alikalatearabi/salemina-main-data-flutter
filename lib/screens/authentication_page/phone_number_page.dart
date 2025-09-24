import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:main_app/screens/authentication_page/code_input_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:main_app/screens/home_page/view/home_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:main_app/screens/personal_info/name_info.dart';
import 'package:main_app/screens/activity_diet_page/activity_level_page.dart';
import 'package:main_app/screens/activity_diet_page/diet_page.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({super.key});

  @override
  PhoneNumberPageState createState() => PhoneNumberPageState();
}

class PhoneNumberPageState extends State<PhoneNumberPage> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isButtonEnabled = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    _phoneController.addListener(() {
      setState(() {
        _isButtonEnabled =
            _validatePhoneNumber(_phoneController.text) == null &&
                _phoneController.text.isNotEmpty;
      });
    });
  }

  Future<void> _checkUserStatus() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.post(
        Uri.parse('${dotenv.env['BASE_URL']}/api/auth/signup/phone'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'phone': '+98${_phoneController.text}'}),
      );
      if (!mounted) return;
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['exists'] == true && data['signupComplete'] == true) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false);
        } else if (data['exists'] == true &&
            data['signupComplete'] == false) {
          switch (data['nextStep']) {
            case 'basic-info':
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => NameInfoPage(userId: data['userId'])),
                      (route) => false);
              break;
            case 'health-info':
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) =>
                          ActivityLevelPage(userId: data['userId'])),
                      (route) => false);
              break;
            case 'dietary-preferences':
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => DietPage(userId: data['userId'])),
                      (route) => false);
              break;
            case 'complete':
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                      (route) => false);
              break;
            default:
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CodeInputPage(
                    phoneNumber: _phoneController.text,
                    userId: data['userId'],
                    nextStep: data['nextStep'],
                  ),
                ),
              );
          }
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CodeInputPage(
                phoneNumber: _phoneController.text,
                userId: data['userId'],
                nextStep: data['nextStep'],
              ),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('خطا در ارتباط با سرور'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('خطا: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final String? errorText = _validatePhoneNumber(_phoneController.text);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight - MediaQuery.of(context).padding.top,
            child: Stack(
              children: [
                ClipPath(
                  clipper: TopArcClipper(),
                  child: Container(
                    height: screenHeight,
                    color: Colors.white,
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight * 0.06),
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: SvgPicture.asset(
                              'assets/icons/arrow-right.svg',
                              width: 20,
                              height: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        const Text(
                          'شماره موبایل',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'لطفا شماره موبایل خود را وارد کنید.',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 2.0,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Color(0xFF657380), width: 1.5),
                              ),
                              labelText: 'شماره موبایل',
                              labelStyle: const TextStyle(
                                  color: Color(0xFF232A34), fontSize: 17),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Color(0xFF232A34), width: 2.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Color(0xFFF2506E), width: 2.0),
                              ),
                              error: errorText != null
                                  ? Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  errorText,
                                  style: const TextStyle(
                                      color: Color(0xFFF2506E)),
                                ),
                              )
                                  : null,
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(left: 12.0, right: 8.0),
                                child: Text('+98',
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xFF232A34))),
                              ),
                              prefixIconConstraints:
                              const BoxConstraints(minWidth: 0, minHeight: 0),
                            ),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: (_isButtonEnabled && !_isLoading)
                                ? _checkUserStatus
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF018A08),
                              disabledBackgroundColor:
                              const Color(0xFFE5E8EB),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              padding: EdgeInsets.zero,
                            ),
                            child: _isLoading
                                ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                                : Row(
                              textDirection: TextDirection.ltr,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/arrow-left.svg',
                                  width: 24,
                                  height: 24,
                                  colorFilter: ColorFilter.mode(
                                    _isButtonEnabled
                                        ? Colors.white
                                        : const Color(0xFFA2ADB8),
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'تایید و ادامه',
                                  style: TextStyle(
                                    color: _isButtonEnabled
                                        ? Colors.white
                                        : const Color(0xFFA2ADB8),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: const Color(0xFF657381)),
                                children: [
                                  const TextSpan(
                                      text: 'تایید و ادامه به معنای پذیرش '),
                                  TextSpan(
                                    text: 'قوانین سالمینا',
                                    style: const TextStyle(
                                      color: Color(0xFF4BB4D8),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                  ),
                                  const TextSpan(text: ' می‌باشد.'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}

class TopArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.05);
    path.quadraticBezierTo(
      size.width / 2,
      size.height * 0.0,
      size.width,
      size.height * 0.05,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

String? _validatePhoneNumber(String value) {
  if (value.isEmpty) {
    return null;
  }
  if (!RegExp(r'^9[0-9]{9}$').hasMatch(value)) {
    return 'شماره موبایل معتبر نیست. مثال: 9123456789';
  }
  return null;
}