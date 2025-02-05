import 'package:flutter/material.dart';

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

// Helper method to build a health factor widget
Widget buildHealthFactor(String name, int consumed, int total) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 3),
        Container(
          width: 60,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: consumed / total,
              backgroundColor: Colors.transparent,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$consumed گرم',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
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
          () {
          },
        ),
        const SizedBox(height: 16), 
        buildModalButton(
          context,
          'جست و جوی محصول',
          Icons.search, 
          () {
          },
        ),
      ],
    ),
  );
}

Widget buildModalButton(
    BuildContext context, String text, IconData icon, VoidCallback onPressed) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.7, // 70% of screen width
    child: ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: const Color(0xFF018A08), // Icon color
      ),
      label: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF018A08), // Text color
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
