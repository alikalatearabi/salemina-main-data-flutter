import 'package:flutter/material.dart';
import 'package:main_app/screens/onboardings/onboarding_screen1.dart';



void main() {
  runApp( const MyApp());
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
        fontFamily: 'yekanBakh',
      ),
      home: const OnboardingScreen1(currentPage: 0),

    );
  }
}
