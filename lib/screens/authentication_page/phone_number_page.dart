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
                height: MediaQuery.of(context).size.height * 0.98,
                color: Colors.white,
              ),
            ),
            // Main content
            Column(
              children: [
                const SizedBox(height: 80), // Spacing for status bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back Arrow Icon
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context)
                              .pop(); // Go back to the previous page
                        },
                      ),
                      const SizedBox(height: 20), // Spacing below the icon
                      // Bold Text: "شماره موبایل"
                      const Text(
                        'شماره موبایل',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(height: 10), // Spacing between texts
                      // Regular Text: "لطفا شماره موبایل خود را وارد کنید."
                      Text(
                        'لطفا شماره موبایل خود را وارد کنید.',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(height: 20), // Spacing for the input
                      // Phone Number Input
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'شماره موبایل', // Placeholder text
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                // Button: "تایید و ادامه"
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.8, // 80% width of the page
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.arrow_forward), // Right arrow icon
                      label: Text('تایید و ادامه'),
                      onPressed: _isButtonEnabled
                          ? () {
                              // Handle the next action
                            }
                          : null, // Disable button if no phone number
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF018A08), // Green background
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15), // Border radius for button
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
    path.moveTo(0, size.height * 0.05); // Start point slightly lower
    path.quadraticBezierTo(
      size.width / 2, size.height * 0.0, // Control point at the top
      size.width, size.height * 0.05, // End point slightly lower
    );
    path.lineTo(size.width, size.height); // Line to the bottom right
    path.lineTo(0, size.height); // Line to the bottom left
    path.close(); // Complete the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
