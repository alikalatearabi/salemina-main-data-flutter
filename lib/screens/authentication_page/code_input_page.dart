import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:main_app/screens/authentication_page/phone_number_page.dart';
import 'package:main_app/screens/personal_info/personal_info_confirmation.dart';
import 'package:main_app/screens/personal_info/name_info.dart';
import 'package:main_app/services/to_farsi_numbers.dart';

class CodeInputPage extends StatefulWidget {
  final String phoneNumber;
  final int userId;
  final String nextStep;

  const CodeInputPage({
    super.key, 
    required this.phoneNumber,
    required this.userId,
    required this.nextStep,
  });

  @override
  CodeInputPageState createState() => CodeInputPageState();
}

class CodeInputPageState extends State<CodeInputPage> {
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(
    5,
    (_) => TextEditingController(),
  );
  int _secondsRemaining = 60;
  late Timer _timer;

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    _focusNodes[0].requestFocus();
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onInputChange(String value, int index) {
    if (value.isNotEmpty && index < 4) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  void _checkCodeLength() {
    String code = _controllers.map((controller) => controller.text).join();
    setState(() {
      _isButtonEnabled = code.length == 5; // Enable button if 5 digits entered
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
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
                padding: const EdgeInsets.all(24.0),
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
                    SizedBox(height: 16),
                    const Text(
                      'کد فعال‌سازی',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'کد فعال‌سازی ارسال شده به شماره ${toFarsiNumber(widget.phoneNumber)} را وارد کنید.',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(146, 158, 170, 0.16),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'ویرایش شماره موبایل',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        textDirection: TextDirection.ltr,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: SizedBox(
                                height: 60,
                                child: TextFormField(
                                  controller: _controllers[index],
                                  focusNode: _focusNodes[index],
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),
                                    counterText: '',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: _focusNodes[index].hasFocus
                                            ? const Color(0xFF232A34)
                                            : const Color(0xFF657381),
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF232A34),
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    _checkCodeLength();
                                    _onInputChange(value, index);
                                  },
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: const EdgeInsets.only(top: 20),
                      child: _secondsRemaining > 0
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'ارسال مجدد کد تا ${_formatTime(_secondsRemaining)} دیگر',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xFF657380),
                                ),
                              ),
                            )
                          : Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    _secondsRemaining = 60;
                                    _startTimer();
                                  });
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(1, 138, 8, 0.16),
                                  textStyle: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'ارسال مجدد کد',
                                  style: TextStyle(
                                    color: Color.fromRGBO(1, 91, 5, 1),
                                  ),
                                ),
                              ),
                            ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _isButtonEnabled
                            ? () {
                          // Determine next screen based on nextStep from API
                          Widget nextScreen;

                          switch (widget.nextStep) {
                            case 'basic-info':
                              nextScreen = NameInfoPage(userId: widget.userId);
                              break;
                            default:
                              nextScreen = PersonalInfoConfirmationPage(userId: widget.userId);
                              break;
                          }
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => nextScreen,
                            ),
                          );
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF018A08),
                          disabledBackgroundColor:
                          const Color(0xFFE5E8EB),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.zero,
                        ),
                        child:Row(
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
