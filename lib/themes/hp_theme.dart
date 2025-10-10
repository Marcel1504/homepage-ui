import 'package:flutter/material.dart';
import 'package:homepage_ui/configs/hp_layout.dart';

abstract class HpTheme {
  ThemeData get() {
    return ThemeData(
      fontFamily: "Lato",
      colorScheme: ColorScheme(
        brightness: brightness(),
        primary: primary(),
        onPrimary: onPrimary(),
        secondary: secondary(),
        onSecondary: onSecondary(),
        tertiary: tertiary(),
        onTertiary: onTertiary(),
        error: error(),
        onError: onError(),
        surface: surface(),
        onSurface: onSurface(),
        surfaceContainerHigh: surfaceContainerHigh(),
        surfaceContainerLow: surfaceContainerLow(),
      ),
      textTheme: TextTheme(
        titleSmall: TextStyle(fontWeight: FontWeight.w300, fontSize: 21, color: onSurface()),
        titleMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: 21, color: onSurface()),
        titleLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 21, color: onSurface()),
        headlineSmall: TextStyle(fontWeight: FontWeight.w300, fontSize: 18, color: onSurface()),
        headlineMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: 18, color: onSurface()),
        headlineLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: onSurface()),
        bodySmall: TextStyle(fontWeight: FontWeight.w300, fontSize: 16, color: onSurface()),
        bodyMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: onSurface()),
        bodyLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: onSurface()),
        displaySmall: TextStyle(fontWeight: FontWeight.w300, fontSize: 14, color: onSurface()),
        displayMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: onSurface()),
        displayLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: onSurface()),
        labelSmall: TextStyle(fontWeight: FontWeight.w300, fontSize: 12, color: onSurface()),
        labelMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: onSurface()),
        labelLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: onSurface()),
      ),
        inputDecorationTheme: const InputDecorationTheme(isDense: true),
        dialogTheme: DialogThemeData(
          backgroundColor: surface(),
          constraints: BoxConstraints(maxWidth: HpLayout.dialogMaxWidth),
        )
    );
  }

  Color primary();

  Color onPrimary();

  Color secondary();

  Color onSecondary();

  Color tertiary();

  Color onTertiary();

  Color error();

  Color onError();

  Color surface();

  Color onSurface();

  Color surfaceContainerHigh();

  Color surfaceContainerLow();

  Brightness brightness();
}
