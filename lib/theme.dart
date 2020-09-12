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
    accentTextTheme: _buildColorTextTheme(textTheme, colorScheme.secondary),
    primaryTextTheme: _buildColorTextTheme(textTheme, colorScheme.primary),
    appBarTheme: _buildAppBarTheme(textTheme, colorScheme),
    inputDecorationTheme: _buildInputDecorationTheme(),
    buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    )),
  );
}

InputDecorationTheme _buildInputDecorationTheme() {
  return InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    isDense: true,
  );
}

AppBarTheme _buildAppBarTheme(TextTheme textTheme, ColorScheme colorScheme) {
  return AppBarTheme(
    textTheme: textTheme.apply(bodyColor: colorScheme.primary),
    color: colorScheme.surface,
    iconTheme: IconThemeData(color: colorScheme.primary),
    brightness: colorScheme.brightness,
  );
}

TextTheme _buildTextTheme(ThemeData base) {
  final defaultTextColor = base.brightness == Brightness.dark ? Colors.white : Colors.black;
  final fontFamily = 'Malina';
  final textTheme = base.textTheme;
  return textTheme.copyWith(
    headline5: textTheme.headline5.apply(fontFamily: fontFamily),
    headline6: textTheme.headline6.apply(fontFamily: fontFamily).copyWith(fontSize: 20),
    bodyText2: textTheme.bodyText2.apply(color: defaultTextColor.withOpacity(0.5)),
    button: textTheme.button.apply(fontFamily: fontFamily),
  );
}

TextTheme _buildColorTextTheme(TextTheme baseTextTheme, Color color) {
  final accentBrightness = ThemeData.estimateBrightnessForColor(color);
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
