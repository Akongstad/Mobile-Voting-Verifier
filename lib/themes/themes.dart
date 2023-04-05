import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appTheme = ThemeData(
  scaffoldBackgroundColor: const Color.fromRGBO(244, 245, 247, 1),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Color.fromRGBO(151, 36, 46, 1.0),
    elevation: 0,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color.fromRGBO(151, 36, 46, 1.0),
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  textTheme: TextTheme(
    displayLarge: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.normal,
      color: Color.fromRGBO(47, 67, 80,1),
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: const Color.fromRGBO(30, 60, 87, 1),
    ),
    bodyLarge: const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.normal,
      color: Color.fromRGBO(47, 67, 80,1),
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 16,
      color: const Color.fromRGBO(133, 153, 170, 1),
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),

  ),
);
