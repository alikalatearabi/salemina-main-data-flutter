import 'package:flutter/material.dart';
import 'package:main_app/screens/activity_diet_page/activity_level_page.dart';
import 'package:main_app/screens/authentication_page/phone_number_page.dart';
import 'package:main_app/screens/home_page/home_page.dart';
import 'package:main_app/screens/personal_info/personal_info_confirmation.dart';
import 'package:main_app/screens/scanner_page/scanner_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salemina',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'yekan',
      ),
      home: const PhoneNumberPage(),
    );
  }
}
