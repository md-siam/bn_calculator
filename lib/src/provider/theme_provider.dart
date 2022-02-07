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
    textTheme: const TextTheme(
      headline5: TextStyle(color: Colors.black87),
      caption: TextStyle(color: Colors.blue),
      subtitle1: TextStyle(color: Colors.black),
      bodyText2: TextStyle(color: Colors.grey),
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
    textTheme: const TextTheme(
      bodyText2: TextStyle(color: Color(0xFFFADA74)),
    ),
    dialogBackgroundColor: const Color(0xFF253341),
    cardColor: const Color(0xFF15202B),
  );
}
