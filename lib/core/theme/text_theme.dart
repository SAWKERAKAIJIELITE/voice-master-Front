import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme buildTextTheme(BuildContext context, {Color? color}) {
  final textTheme = TextTheme(
      bodyLarge: TextStyle(fontSize: 12, color: color),
      bodyMedium: TextStyle(fontSize: 11, color: color),
      bodySmall: TextStyle(fontSize: 10, color: color),
      displayLarge:
          TextStyle(fontSize: 22, color: color, fontWeight: FontWeight.w700),
      displayMedium: TextStyle(fontSize: 20, color: color),
      displaySmall:
          TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.w500),
      headlineMedium: TextStyle(fontSize: 14, color: color),
      headlineSmall: TextStyle(fontSize: 13, color: color),
      titleLarge: TextStyle(fontSize: 15, color: color),
      titleMedium: TextStyle(fontSize: 12, color: color),
      titleSmall: TextStyle(fontSize: 10, color: color),
      labelSmall: TextStyle(fontSize: 8, color: color),
      labelMedium: TextStyle(fontSize: 9, color: color));
  if (context.locale.languageCode == 'ar') {
    return GoogleFonts.notoKufiArabicTextTheme(textTheme);
  }
  return textTheme;
}
