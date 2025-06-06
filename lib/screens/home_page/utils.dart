import 'package:flutter/material.dart';
import 'package:main_app/screens/home_page/barcode_scanner_screen.dart';

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

// Helper method to build a health factor widget
Widget buildHealthFactor(BuildContext context,String name, int consumed, int total) {
  // Calculate percentage
  final int percentage = (consumed / total * 100).round();
  final bool isOverLimit = percentage > 100;
  
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 3),
        Container(
          width: MediaQuery.of(context).size.width*0.18846153846153846153846153846154,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: isOverLimit ? 1 : consumed / total,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(
                isOverLimit ? Colors.red : Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
        Text(
              '${toPersianNumber(consumed.toString())} گرم',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
            ),
            const SizedBox(width: 4),
            Text(
              '(${toPersianNumber(percentage.toString())}%)',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isOverLimit ? Colors.red : Colors.white,
              ),
            ),
          ],
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
