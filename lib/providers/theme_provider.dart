import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyTheme {
  static final darkTheme = ThemeData(
    textTheme: TextTheme(
      titleLarge: GoogleFonts.ubuntu(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: GoogleFonts.ubuntu(color: Colors.white, fontSize: 15),
      labelSmall: GoogleFonts.ubuntu(color: Colors.white54, fontSize: 13),
      titleSmall: GoogleFonts.ubuntu(color: Colors.black, fontSize: 12),
    ),
    unselectedWidgetColor: Colors.white70,
    primaryColorLight: Colors.black,
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: const Color(0xff383838),
    secondaryHeaderColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black, opacity: 0.8),
  );

  static final lightTheme = ThemeData(
    textTheme: TextTheme(
      titleLarge: GoogleFonts.ubuntu(
        color: Colors.black87,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: GoogleFonts.ubuntu(color: Colors.black, fontSize: 15),
      labelSmall: GoogleFonts.ubuntu(color: Colors.black38, fontSize: 13),
      titleSmall: GoogleFonts.ubuntu(color: Colors.black, fontSize: 12),
    ),
    unselectedWidgetColor: Colors.black,
    primaryColorLight: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: const Color(0xffA6B9C1),
    secondaryHeaderColor: Colors.black,
    iconTheme: const IconThemeData(color: Colors.white, opacity: 0.8),
  );
}
