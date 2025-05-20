import 'package:flutter/material.dart';
import 'package:race_tracker_app/theme/r_color.dart';

class TTextTheme {
  const TTextTheme();

  static TextTheme darkTextTheme =  TextTheme(
    headlineLarge:  const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: RColor.black,fontFamily: 'Poppins'),   
    headlineMedium: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: RColor.black,fontFamily: 'Poppins'),
    headlineSmall: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: RColor.black,fontFamily: 'Poppins'),

    titleLarge: const TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: RColor.black,fontFamily: 'Poppins'),
    titleMedium: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: RColor.black,fontFamily: 'Poppins'),
    titleSmall: const TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: RColor.black,fontFamily: 'Poppins'),

    bodyLarge: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: RColor.black,fontFamily: 'Poppins'),
    bodyMedium: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: RColor.black,fontFamily: 'Poppins'),
    bodySmall: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color:  RColor.black.withOpacity(0.5),fontFamily: 'Poppins'),
    
    labelLarge: const TextStyle(fontSize: 12,fontWeight: FontWeight.normal,color: RColor.black,fontFamily: 'Poppins'),
    labelMedium: TextStyle(fontSize: 10,fontWeight: FontWeight.normal,color:  RColor.black.withOpacity(0.5),fontFamily: 'Poppins'),
       
  );
}
