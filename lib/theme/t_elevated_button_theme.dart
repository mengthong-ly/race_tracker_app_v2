import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final ElevatedButtonThemeData greenElevatedButton =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      iconColor: Colors.white,
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xff03624C), // Green
      textStyle: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 14.0,
      ),
      shadowColor: Colors.transparent,
    ),
  );

  static final ElevatedButtonThemeData redElevatedButton =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      iconColor: Colors.white,
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xffFD2942), // Red
      textStyle: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 14.0,
      ),
      shadowColor: Colors.transparent,
    ),
  );
}
