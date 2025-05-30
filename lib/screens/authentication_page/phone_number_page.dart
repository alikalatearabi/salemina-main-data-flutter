import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_app/screens/authentication_page/code_input_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:main_app/screens/home_page/home_page.dart';
import 'package:main_app/utility/env_config.dart';

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
        _isButtonEnabled = _phoneController.text.isNotEmpty;
      });
    });
  }

  Future<void> _checkUserStatus() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('${EnvConfig.apiBaseUrl}/auth/signup/phone'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phone': '+98${_phoneController.text}',
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = json.decode(response.body);
        
        // Store current user ID globally
        EnvConfig.currentUserId = data['userId'];
        
        if (data['exists'] == true && (data['signupComplete'] == true || data['nextStep'] == 'complete')) {
          // Navigate to HomePage if user exists and signup is complete or next step is complete
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (route) => false,
          );
        } else {
          // Navigate to CodeInputPage for new users or incomplete signup
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
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('خطا در ارتباط با سرور'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Show error message for exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('خطا: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Stack(
          children: [
            ClipPath(
              clipper: TopArcClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 80,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            decoration: const BoxDecoration(
                            color: Color(0xFF018A08),
                            shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              iconSize: 25,
                              icon: const Icon(Icons.arrow_forward_ios),
                              color: Colors.white,
                              onPressed: () {
                              Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        const Text(
                          'شماره موبایل',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF232A34),
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'لطفا شماره موبایل خود را وارد کنید.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF232A34),
                          ),
                          textAlign: TextAlign.right,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: const BorderSide(
                                  color: Color(0xFF657381),
                                  width: 2.0,
                                ),
                              ),
                              labelText: 'شماره موبایل',
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(255, 32, 50, 68),
                                  fontSize: 17),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Color(0xFF232A34),
                                  width: 2.0,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Color(0xFFF2506E),
                                  width: 2.0,
                                ),
                              ),
                              errorText:
                                  _validatePhoneNumber(_phoneController.text),
                              errorStyle: const TextStyle(
                                color: Color(0xFFF2506E),
                              ),
                            ),
                            style: const TextStyle(
                              color: Color(0xFF232A34),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Icon(
                                Icons.arrow_back,
                                color: _isButtonEnabled ? Colors.white : Colors.grey,
                              ),
                        label: Text(
                          'تایید و ادامه',
                          style: TextStyle(
                            color:
                                _isButtonEnabled ? Colors.white : Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: (_isButtonEnabled && !_isLoading)
                            ? _checkUserStatus
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF018A08),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'تایید و ادامه به معنای پذیرش ',
                        style: const TextStyle(
                          color: Color(0xFF657381),
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: 'قوانین سالمینا',
                            style: const TextStyle(
                              color: Color(0xFF4BB4D8),
                              decoration: TextDecoration.none,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                              },
                          ),
                          const TextSpan(text: ' می‌باشد.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
  } else if (!RegExp(r'^[0-9]{10,}$').hasMatch(value)) {
    return 'شماره موبایل وارد شده صحیح نیست.';
  }
  return null;
}
