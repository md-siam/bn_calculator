import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyTheme {
  static final lightTheme = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
      color: Colors.grey[300],
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    scaffoldBackgroundColor: Colors.grey[300],
    primaryColor: Colors.grey[300], // using this for MyButton color
    shadowColor: Colors.grey[500]!, // using this for MyButton shadow1 color
    splashColor: Colors.white, // using this for MyButton shadow2 color
    iconTheme: const IconThemeData(color: Color(0xFF0C91D6)),
    textTheme: const TextTheme(
      headline5: TextStyle(color: Colors.black87),
      caption: TextStyle(color: Colors.blueAccent),
      subtitle1: TextStyle(color: Colors.black),
      bodyText2: TextStyle(color: Color(0xFF0C91D6)),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: Colors.blueAccent),
    ),
  );
  static final darkTheme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      color: Color(0xFF253341),
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    scaffoldBackgroundColor: const Color(0xFF15202B),
    primaryColor: const Color(0xFF15202B), // using this for MyButton color
    shadowColor: Colors.black, // using this for MyButton shadow1 color
    splashColor: Colors.white12, // using this for MyButton shadow2 color
    iconTheme: const IconThemeData(color: Color(0xFFFADA74)),
    textTheme: const TextTheme(
      bodyText2: TextStyle(color: Color(0xFFFADA74)),
    ),
    dialogBackgroundColor: const Color(0xFF253341),
    cardColor: const Color(0xFF15202B),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: const Color(0xFFFADA74)),
    ),
  );
}
