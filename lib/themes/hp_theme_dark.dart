import 'package:flutter/material.dart';
import 'package:homepage_ui/themes/hp_theme.dart';

class HpThemeDark extends HpTheme {
  @override
  Brightness brightness() {
    return Brightness.dark;
  }

  @override
  Color primary() {
    return const Color.fromRGBO(248, 248, 255, 1.0);
  }

  @override
  Color onPrimary() {
    return const Color.fromRGBO(28, 28, 32, 1.0);
  }

  @override
  Color secondary() {
    return const Color.fromRGBO(248, 248, 255, 1.0);
  }

  @override
  Color onSecondary() {
    return const Color.fromRGBO(28, 28, 32, 1.0);
  }

  @override
  Color tertiary() {
    return const Color.fromRGBO(248, 248, 255, 1.0);
  }

  @override
  Color onTertiary() {
    return const Color.fromRGBO(28, 28, 32, 1.0);
  }

  @override
  Color error() {
    return const Color.fromRGBO(220, 74, 74, 1.0);
  }

  @override
  Color onError() {
    return const Color.fromRGBO(248, 248, 255, 1.0);
  }

  @override
  Color surface() {
    return const Color.fromRGBO(28, 28, 32, 1.0);
  }

  @override
  Color onSurface() {
    return const Color.fromRGBO(248, 248, 255, 1.0);
  }

  @override
  Color surfaceContainerHigh() {
    return const Color.fromRGBO(40, 40, 46, 1.0);
  }

  @override
  Color surfaceContainerLow() {
    return const Color.fromRGBO(47, 47, 54, 1.0);
  }
}
