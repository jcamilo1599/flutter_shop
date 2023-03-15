import 'package:flutter/material.dart';

import 'color.dart';
import 'size.dart';

class Themes {
  /// Personalizaciones para el tema claro de la aplicación
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: ColorToken.primary,
    dividerTheme: const DividerThemeData(
      thickness: .3,
      space: SizeToken.spacingBig,
    ),
  );

  /// Personalizaciones para el tema obscuro de la aplicación
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: ColorToken.primary,
    dividerTheme: const DividerThemeData(
      thickness: .3,
      space: SizeToken.spacingBig,
    ),
  );
}
