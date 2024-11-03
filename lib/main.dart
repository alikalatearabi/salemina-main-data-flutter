import 'package:flutter/material.dart';
import 'package:main_app/screens/personal_info/personal_info_confirmation.dart';
import 'widgets/splash_screen.dart';

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
      ),
      home: const PersonalInfoConfirmationPage(),
    );
  }
}
