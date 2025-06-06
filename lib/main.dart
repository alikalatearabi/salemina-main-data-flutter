import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:main_app/screens/authentication_page/code_input_page.dart';
import 'package:main_app/screens/onboardings/splash_screen.dart';



void main() async {
  await dotenv.load(fileName: ".env");
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
        Locale('fa', 'IR'),
        Locale('en', 'US'),
      ],
      locale: const Locale('fa', 'IR'),
      title: 'BookIt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor:  Color(0xFF657380),
          selectionColor:  Color(0xFF657380).withOpacity(0.3),
          selectionHandleColor:  Color(0xFF657380),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Color(0xFF018A08),
              width: 2.0,
            ),
          ),
        ),
        primarySwatch: Colors.blue,
        fontFamily: 'yekanBakh',
      ),
      home: const CodeInputPage(phoneNumber: '9123456789', userId: 0269, nextStep: 'complete',),

    );
  }
}
