import 'package:flutter/material.dart';

class ThemeConstant {
  const ThemeConstant._();

  // Todo(ymkwon): select theme color
  static const primaryColor = Colors.indigo;
  static const secondaryColor = Colors.amber;
  static const tertiaryColor = Colors.red;
}

class AppTheme {
  const AppTheme._();

  static final light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: ThemeConstant.primaryColor,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: ThemeConstant.primaryColor,
  );
}
