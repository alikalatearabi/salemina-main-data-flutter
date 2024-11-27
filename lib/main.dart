import 'package:flutter/material.dart';
import 'package:main_app/screens/activity_diet_page/activity_level_page.dart';
import 'package:main_app/screens/personal_info/personal_info_confirmation.dart';

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
      home: const ActivityLevelPage(),
    );
  }
}
