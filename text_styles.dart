import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

/// خط 'Aref Ruqaa' للعناوين والأسماء (نفس خط الموكاب)
/// خط 'IBM Plex Sans Arabic' لباقي النصوص
class AppText {
  static TextStyle display({double size = 24, Color? color}) =>
      GoogleFonts.arefRuqaa(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: color ?? AppColors.ink,
      );

  static TextStyle title({double size = 15, FontWeight weight = FontWeight.w600, Color? color}) =>
      GoogleFonts.ibmPlexSansArabic(
        fontSize: size,
        fontWeight: weight,
        color: color ?? AppColors.ink,
      );

  static TextStyle body({double size = 13, Color? color, double height = 1.7}) =>
      GoogleFonts.ibmPlexSansArabic(
        fontSize: size,
        color: color ?? AppColors.ink,
        height: height,
      );

  static TextStyle soft({double size = 11.5, Color? color}) =>
      GoogleFonts.ibmPlexSansArabic(
        fontSize: size,
        color: color ?? AppColors.inkSoft,
      );
}
