import "package:flutter/material.dart";

class MarvelTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      backgroundColor: Colors.white24,
      colorScheme: _colorScheme(),
      scaffoldBackgroundColor: Colors.white,
    );
  }

  static ColorScheme _colorScheme() {
    return const ColorScheme(
      primary: Color(0xFFe23636),
      primaryVariant: Color(0xFF4ACBD2),
      secondary: Color(0xFFD99970),
      secondaryVariant: Color(0xFFFAFBFB),
      background: Color(0xFFFFFFFF),
      surface: Color(0xFF111111),
      onBackground: Colors.white,
      error: Colors.red,
      onError: Colors.redAccent,
      onPrimary: Colors.grey,
      onSecondary: Color(0xFF322942),
      onSurface: Color(0xFF241E30),
      brightness: Brightness.light,
    );
  }
}
