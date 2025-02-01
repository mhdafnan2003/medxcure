import 'package:flutter/material.dart';

class ChatTheme {
  static const Color primaryTeal = Color(0xFF009688);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color lightText = Color(0xFFE0E0E0);

  static ThemeData darkTheme() {
    return ThemeData.dark().copyWith(
      primaryColor: primaryTeal,
      scaffoldBackgroundColor: darkBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: darkSurface,
        elevation: 0,
      ),
    );
  }
}