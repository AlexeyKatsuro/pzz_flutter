import 'package:flutter/material.dart';

final pzzTheme = _buildPzzThemeData();

ThemeData _buildPzzThemeData() {
  final colorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.deepOrange,
    accentColor: Color(0xFF277dff),
    backgroundColor: Color(0xFFFAFAFA),
  );
//  final colorScheme = ColorScheme.light(
//    primary: Colors.deepOrange,
//    background: Color(0xFFFAFAFA),
//  );
  final base = ThemeData.from(colorScheme: colorScheme);
  final textTheme = _buildTextTheme(base);
  return base.copyWith(
    cardTheme: _buildCardTheme(base, colorScheme),
    textTheme: _buildTextTheme(base),
    accentTextTheme: _buildAccentTextTheme(textTheme, colorScheme),
//    appBarTheme: AppBarTheme(
//      color: colorScheme.onPrimary,
//      textTheme: base.primaryTextTheme.apply(bodyColor: colorScheme.primary),
//    ),
  );
}

TextTheme _buildTextTheme(ThemeData base) {
  final defaultTextColor = base.brightness == Brightness.dark ? Colors.white : Colors.black;
  final fontFamily = 'Malina';
  final textTheme = base.textTheme;
  return textTheme.copyWith(
    headline5: textTheme.headline5.apply(fontFamily: fontFamily),
    headline6: textTheme.headline6.apply(fontFamily: fontFamily),
    bodyText2: textTheme.bodyText2.apply(color: defaultTextColor.withOpacity(0.5)),
    button: textTheme.button.apply(fontFamily: fontFamily),
  );
}

TextTheme _buildAccentTextTheme(TextTheme baseTextTheme, ColorScheme colorScheme) {
  final accentBrightness = ThemeData.estimateBrightnessForColor(colorScheme.secondary);
  final isDark = accentBrightness == Brightness.dark;
  return baseTextTheme.apply(
    displayColor: isDark ? Colors.white : Colors.black,
    bodyColor: isDark ? Colors.white : Colors.black,
  );
}

CardTheme _buildCardTheme(ThemeData base, ColorScheme colorScheme) {
  return CardTheme(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(
        color: base.dividerColor,
      ),
    ),
    color: colorScheme.surface,
    elevation: 0,
  );
}