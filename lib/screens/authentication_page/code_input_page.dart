import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_app/screens/authentication_page/phone_number_page.dart';
import 'package:main_app/screens/personal_info/personal_info_confirmation.dart';
import 'package:main_app/services/to_farsi_numbers.dart';

class CodeInputPage extends StatefulWidget {
  final String phoneNumber;

  const CodeInputPage({super.key, required this.phoneNumber});

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
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 80, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            iconSize: 30,
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        const Text(
                          'کد فعال‌سازی',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF232A34),
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'کد فعال‌سازی ارسال شده به شماره ${toFarsiNumber(widget.phoneNumber)} را وارد کنید.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF000000)),
                        ),
                      ],
                    ),
                  ),
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
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'ویرایش شماره موبایل',
                          style: TextStyle(
                            color: Color(0xFF232A34),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
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
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.16,
                            height: 60,
                            child: TextFormField(
                              controller: _controllers[index],
                              focusNode: _focusNodes[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              style: const TextStyle(fontSize: 24),
                              decoration: InputDecoration(
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
                                fontSize: 16,
                                color: Color(0xFF657381),
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
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: Icon(
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
                        onPressed: _isButtonEnabled
                            ? () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PersonalInfoConfirmationPage(),
                                  ),
                                );
                              }
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
