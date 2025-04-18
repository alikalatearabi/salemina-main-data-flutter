import 'package:flutter/material.dart';
import 'package:main_app/screens/home_page/home_page.dart';



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
      home: HomePage(),

    );
  }
}
