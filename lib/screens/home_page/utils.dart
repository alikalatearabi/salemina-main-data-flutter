import 'package:flutter/material.dart';
import 'package:main_app/screens/home_page/barcode_scanner_screen.dart';
import 'dart:math';

// Utility function to convert English digits to Persian digits
String toPersianNumber(String number) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'];
  const persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹', '٫'];
  
  for (int i = 0; i < english.length; i++) {
    number = number.replaceAll(english[i], persian[i]);
  }
  return number;
}

Widget buildInfoBox(BuildContext context, String text, Widget icon) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.42,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        const SizedBox(height: 10),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFF018A08),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

class ComingSoonInfoBox extends StatefulWidget {
  final String text;
  final Widget icon;
  final String comingSoonText;
  final Color badgeColor;

  const ComingSoonInfoBox({
    required this.text,
    required this.icon,
    this.comingSoonText = 'به زودی',
    this.badgeColor = Colors.orange,
  });

  @override
  State<ComingSoonInfoBox> createState() => _ComingSoonInfoBoxState();
}

class _ComingSoonInfoBoxState extends State<ComingSoonInfoBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final snackBar = SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.access_time_filled, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'بخش ${widget.text} در حال توسعه است',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: widget.badgeColor is MaterialColor 
              ? (widget.badgeColor as MaterialColor).shade700
              : widget.badgeColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.42,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isPressed 
                    ? widget.badgeColor 
                    : Colors.grey.withOpacity(0.2),
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isPressed 
                      ? widget.badgeColor.withOpacity(0.3)
                      : Colors.black.withOpacity(0.1),
                  blurRadius: _isPressed ? 6 : 2,
                  offset: _isPressed 
                      ? const Offset(0, 2)
                      : const Offset(0, 1),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Main box content with reduced opacity
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.grey.shade400,
                        BlendMode.srcATop,
                      ),
                      child: widget.icon,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.text,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                // Sleek, professional "Coming Soon" overlay
                Positioned.fill(
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.32,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            widget.badgeColor.withOpacity(0.85),
                            widget.badgeColor.withOpacity(0.95),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: widget.badgeColor.withOpacity(0.3 + 0.2 * _pulseAnimation.value),
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.white,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            widget.comingSoonText,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Helper method to build a health factor widget
Widget buildHealthFactor(BuildContext context, String title, double current, double max) {
  // Calculate percentage (clamped between 0-150 for visualization)
  final percentage = ((current / max) * 100).clamp(0.0, 150.0);
  
  // Format current as integer if it's a whole number, otherwise show one decimal place
  String currentStr = current.toStringAsFixed(current.toInt() == current ? 0 : 1);
  
  return Container(
    width: MediaQuery.of(context).size.width * 0.18, // Reduce width to avoid overlap
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.2),
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10), // Reduce padding
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          currentStr, // Remove 'g' suffix to save space
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12, // Reduce font size
          ),
          textAlign: TextAlign.center,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 3), // Reduce margin
          width: double.infinity,
          height: 4, // Make bar thinner
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(2),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerRight,
            widthFactor: percentage > 100 ? 1.0 : percentage / 100, // Cap at 100% width
            child: Container(
              decoration: BoxDecoration(
                color: percentage > 100 ? Colors.red : Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10, // Reduce font size
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis, // Prevent text overflow
        ),
      ],
    ),
  );
}

Widget buildProductOptionsModal(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildModalButton(
          context,
          'اسکن محصول',
          Icons.qr_code_scanner,
          () async {
            final scannedCode = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BarcodeScannerScreen(),
              ),
            );

            if (scannedCode != null) {
              print('Scanned Code: $scannedCode');
            }
          },
        ),
        const SizedBox(height: 16),
        buildModalButton(
          context,
          'جست و جوی محصول',
          Icons.search,
          () {},
        ),
      ],
    ),
  );
}

Widget buildModalButton(
    BuildContext context, String text, IconData icon, VoidCallback onPressed) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.7,
    child: ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: const Color(0xFF018A08),
      ),
      label: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF018A08),
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(
          color: Color(0xFF018A08),
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
      ),
    ),
  );
}
