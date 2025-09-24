import 'package:flutter/material.dart';
import 'constants.dart'; // برای دسترسی به رنگ‌ها

// --- Navigation Helper ---
// این تابع برای ناوبری به صفحه پروفایل استفاده می‌شود.
// مطمئن شوید که روت '/profile' در main.dart شما تعریف شده است.
void navigateToProfilePage(BuildContext context) {
  if (Navigator.of(context).canPop()) { // اگر مودالی باز است
    Navigator.of(context).popUntil((route) => route is! ModalRoute);
  }
  // برای جلوگیری از بازگشت به مودال‌ها، پشته را پاک می‌کنیم
  Navigator.pushNamedAndRemoveUntil(context, '/profile', (route) => false);
}

// --- Helper Widgets ---
Widget buildPrimaryButton(String text, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(text, style: TextStyle(fontSize: 16, color: Colors.white)),
    style: ElevatedButton.styleFrom(
      backgroundColor: salminaGreen,
      minimumSize: Size(double.infinity, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}

Widget buildTextButton(String text, VoidCallback onPressed, {Color color = salminaGreen}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(text, style: TextStyle(fontSize: 15, color: color)),
  );
}

Widget buildBenefitItem(String number, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: salminaLightGreyBorder,
          child: Text(number, style: TextStyle(fontSize: 12, color: Colors.black87)),
        ),
        SizedBox(width: 10),
        Expanded(child: Text(text, style: TextStyle(fontSize: 15))),
      ],
    ),
  );
}

Widget buildChecklistItem(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        Icon(Icons.check_circle, color: salminaGreen, size: 18),
        SizedBox(width: 8),
        Expanded(child: Text(text, style: TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis)),
      ],
    ),
  );
}