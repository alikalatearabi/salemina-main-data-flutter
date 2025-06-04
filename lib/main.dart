import 'package:flutter/material.dart';
import 'package:main_app/screens/comparison_page/comparison_page.dart';
import 'package:main_app/screens/home_page/home_page.dart';
import 'package:main_app/screens/onboardings/onboarding_screen1.dart';
import 'package:main_app/screens/product_page/product_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // این خط را اضافه کنید



void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates:  [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', 'IR'), // Farsi
        Locale('en', 'US'), // English
      ],
      locale: const Locale('fa', 'IR'), // Set Farsi as default
      //home: const ChooseYourPlanPage(),
      title: 'BookIt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'yekanBakh',
      ),
      home: const ProductPage(),

    );
  }
}
