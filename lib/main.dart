import 'package:days_21/Screen/Auth/auth_screen.dart';
import 'package:days_21/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const defualtTextStyle = TextStyle(
        fontFamily: 'iranYekan', color: LightThemeColor.praimaryTextColor);
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: .9),
          child: child!,
        );
      },
      title: '21 days',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
            primary: Colors.black,
            secondary: LightThemeColor.secendaryColor,
            surface: LightThemeColor.surfaceColor,
            onSecondary: Colors.black),
        textTheme: TextTheme(
          titleMedium:
              defualtTextStyle.apply(color: LightThemeColor.secendaryTextColor),
          bodyMedium: defualtTextStyle.copyWith(fontSize: 18),
          bodySmall: defualtTextStyle.copyWith(fontSize: 15),
          labelLarge: defualtTextStyle,
          titleLarge: defualtTextStyle.copyWith(
              fontSize: 20, fontWeight: FontWeight.w500),
        ),
        hintColor: LightThemeColor.praimaryTextColor,
        inputDecorationTheme: const InputDecorationTheme(
            contentPadding: EdgeInsets.symmetric(vertical: 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(32),
              ),
              borderSide:
                  BorderSide(color: Color.fromARGB(255, 255, 0, 0), width: 8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(32),
              ),
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(32),
              ),
              borderSide: BorderSide(
                color: Colors.black,
              ),
            )),
      ),
      home: const AuthScreen(),
    );
  }
}
