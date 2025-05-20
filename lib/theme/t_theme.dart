import 'package:flutter/material.dart';
import 'package:race_tracker_app/theme/r_color.dart';
import 'package:race_tracker_app/theme/r_text.dart';
import 'package:race_tracker_app/theme/t_elevated_button_theme.dart';

class TTheme {
  const TTheme._();

  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    iconTheme: const IconThemeData(
      color: RColor.black,
    ),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      // color: Colors.transparent,
    ),
    primaryColor: RColor.primary,
    scaffoldBackgroundColor: RColor.white,
    elevatedButtonTheme: TElevatedButtonTheme.greenElevatedButton,
    textTheme: TTextTheme.darkTextTheme,
  );
} 
