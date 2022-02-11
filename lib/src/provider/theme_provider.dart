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
    appBarTheme: const AppBarTheme(
      color: Color(0xFFE6EDF2),
      iconTheme: IconThemeData(color: Color(0xFF0C91D6)),
      titleTextStyle: TextStyle(
        color: Color(0xFF0C91D6),
        fontSize: 23,
        fontWeight: FontWeight.bold,
      ),
    ),
    scaffoldBackgroundColor: const Color(0xFFE6EDF2),
    primaryColor: const Color(0xFFE6EDF2), // using this for MyButton color
    shadowColor: const Color.fromARGB(
        255, 180, 193, 203), // using this for MyButton shadow1 color
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
      iconTheme: IconThemeData(color: Color(0xFFFADA74)),
      titleTextStyle: TextStyle(
        color: Color(0xFFFADA74),
        fontSize: 23,
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
