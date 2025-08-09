import 'package:flutter/material.dart';
import 'color_light_scheme.dart';
import 'text_theme.dart';

ThemeData buildLightTheme(BuildContext context) {
  final textTheme = buildTextTheme(context, color: Colors.black);
  return ThemeData.light().copyWith(
    platform: TargetPlatform.iOS,
    textTheme: textTheme,
    dividerTheme: DividerThemeData(
      color: lightColorScheme.primary,
      thickness: 1.0,
    ),
    primaryColor: lightColorScheme.primary,
    scaffoldBackgroundColor: lightColorScheme.surfaceVariant,
    inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        border: OutlineInputBorder(borderSide: BorderSide(color: lightColorScheme.outline),borderRadius: BorderRadius.circular(24))),
    dividerColor: lightColorScheme.outline,
    appBarTheme: AppBarTheme(
        backgroundColor: lightColorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white)),
    tabBarTheme: TabBarTheme(
      indicatorColor: lightColorScheme.secondary,
      dividerColor: Colors.transparent,
      unselectedLabelStyle: textTheme.headlineSmall?.copyWith(
          color: Colors.white.withOpacity(.7), fontWeight: FontWeight.w600),
      labelStyle: textTheme.headlineSmall?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24)))),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24)))),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    colorScheme:
        lightColorScheme.copyWith(background: lightColorScheme.background),
  );
}
