import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData dark = new ThemeData(
    primaryColor: Colors.lightGreen,
    backgroundColor: Colors.black87,
    brightness: Brightness.dark,
    highlightColor: Colors.white12,
    accentColor: Colors.green,
  );

  static ThemeData light = new ThemeData(
    primaryColor: Colors.green,
    backgroundColor: Colors.white,
    brightness: Brightness.light,
    highlightColor: Colors.black12,
    accentColor: Colors.green,
    dividerColor: Colors.green,
  );
}
