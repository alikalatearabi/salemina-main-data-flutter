import 'package:flutter/material.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({super.key});

  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      setState(() {
        _isButtonEnabled = _phoneController.text.isNotEmpty;
      });
    });
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
            // Main content
            Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 80,
                    ),
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
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Color(0xFF232A34),
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
                                // Handle the next action
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
    path.moveTo(0, size.height * 0.03);
    path.quadraticBezierTo(
      size.width / 2,
      size.height * 0.0,
      size.width,
      size.height * 0.03,
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
