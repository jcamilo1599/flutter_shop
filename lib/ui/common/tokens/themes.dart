import 'package:flutter/material.dart';

import 'color.dart';
import 'size.dart';

class Themes {
  static final ElevatedButtonThemeData _elevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ColorToken.primary,
      foregroundColor: ColorToken.white,
      padding: const EdgeInsets.symmetric(
        vertical: SizeToken.spacingMedium,
        horizontal: SizeToken.horizontal,
      ),
      textStyle: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  static final TextButtonThemeData _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: SizeToken.spacingMedium,
        horizontal: SizeToken.horizontal,
      ),
      textStyle: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  /// Personalizaciones para el tema claro de la aplicación
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ThemeData.light().colorScheme.copyWith(
          brightness: Brightness.light,
          onSurfaceVariant: ColorToken.white,
          background: ThemeData.light().scaffoldBackgroundColor,
        ),
    appBarTheme: AppBarTheme(
      backgroundColor: ThemeData.light().scaffoldBackgroundColor,
      iconTheme: const IconThemeData(color: ColorToken.darkGray),
      actionsIconTheme: const IconThemeData(color: ColorToken.darkGray),
    ),
    elevatedButtonTheme: _elevatedButtonTheme,
    textButtonTheme: _textButtonTheme,
  );

  /// Personalizaciones para el tema obscuro de la aplicación
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ThemeData.dark().colorScheme.copyWith(
          brightness: Brightness.dark,
          onSurfaceVariant: ColorToken.white,
          background: ThemeData.dark().scaffoldBackgroundColor,
        ),
    appBarTheme: AppBarTheme(
      backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
      iconTheme: const IconThemeData(color: ColorToken.white),
      actionsIconTheme: const IconThemeData(color: ColorToken.white),
    ),
    elevatedButtonTheme: _elevatedButtonTheme,
    textButtonTheme: _textButtonTheme,
  );
}
