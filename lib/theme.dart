import 'package:flutter/material.dart';

class PzzAppTheme {
  static const _brand_orange = Color(0xFFff5200);
  static const _brand_orange_variant = Color(0xFFFF844A);

  static const _brand_blue = Color(0xFF277dff);
  static const _brand_blue_variant = Color(0xFF9abef5);

  //static const _brand_blue = Colors.green;
  //static const _brand_blue_variant = Color(0xFFA5D6A7);
  static const _white_sheet = Color(0xFFF6F6F6);
  //static const _dark_sheet = Color(0xFF121212);

  static final pzzLightTheme = themeData(_pzzLightColorScheme, _textTheme);
  static final pzzDarkTheme = themeData(_pzzDarkColorScheme, _textTheme);

  static ThemeData themeData(ColorScheme colorScheme, TextTheme textTheme) {
    final bool isDark = colorScheme.brightness == Brightness.dark;
    final iconTheme = isDark ? const IconThemeData(color: Colors.white) : const IconThemeData(color: Colors.black54);
    final dividerColor = colorScheme.onSurface.withOpacity(0.20);

    final buttonsShapeStateProp = MaterialStateProperty.all(kRoundedShapeBorder);
    return ThemeData(
        textTheme: textTheme,
        primaryTextTheme: textTheme,
        accentTextTheme: textTheme,
        iconTheme: iconTheme,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        primaryColor: colorScheme.primary,
        primaryColorLight: colorScheme.primaryVariant,
        primaryColorDark: colorScheme.primaryVariant,
        errorColor: colorScheme.error,
        toggleableActiveColor: colorScheme.primary,
        accentColor: colorScheme.secondary,
        cardColor: colorScheme.surface,
        applyElevationOverlayColor: true,
        dividerColor: dividerColor,
        backgroundColor: colorScheme.background,
        dialogBackgroundColor: colorScheme.surface,
        scaffoldBackgroundColor: colorScheme.background,
        cardTheme: _buildCardTheme(dividerColor, colorScheme),
        appBarTheme: _buildAppBarTheme(textTheme, iconTheme, colorScheme),
        inputDecorationTheme: _buildInputDecorationTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            shape: buttonsShapeStateProp,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(shape: buttonsShapeStateProp),
        ),
        buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        )),
        bottomSheetTheme: BottomSheetThemeData(
          elevation: 16,
          backgroundColor: colorScheme.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
            ),
          ),
        ));
  }

  static InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      isDense: true,
    );
  }

  static AppBarTheme _buildAppBarTheme(TextTheme textTheme, IconThemeData iconTheme, ColorScheme colorScheme) {
    return AppBarTheme(
      textTheme:
          textTheme.copyWith(headline6: textTheme.headline6!.copyWith(color: colorScheme.primary, inherit: true)),
      color: colorScheme.surface,
      brightness: colorScheme.brightness,
      iconTheme: iconTheme,
      actionsIconTheme: IconThemeData(color: colorScheme.primary),
      /* color: colorScheme.surface,
      textTheme: textTheme,
      brightness: colorScheme.brightness,*/
    );
  }

  static CardTheme _buildCardTheme(Color dividerColor, ColorScheme colorScheme) {
    return CardTheme(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: dividerColor,
        ),
      ),
      color: colorScheme.surface,
      elevation: 0,
    );
  }

  static const ColorScheme _pzzLightColorScheme = ColorScheme.light(
    primary: _brand_orange,
    primaryVariant: _brand_orange_variant,
    secondary: _brand_blue,
    secondaryVariant: _brand_blue_variant,
    onSecondary: Colors.white,
    background: _white_sheet,
  );

  static const ColorScheme _pzzDarkColorScheme = ColorScheme.dark(
    primary: _brand_orange_variant,
    primaryVariant: _brand_orange_variant,
    secondary: _brand_blue_variant,
    secondaryVariant: _brand_blue,
    background: Colors.black,
  );

  static const _fontFamily = 'Malina';

  //static const _regular = FontWeight.w400;
  //static const _light = FontWeight.w300;
  //static const _medium = FontWeight.w500;
  static const _bold = FontWeight.w700;

  /// letterSpacing was taken form a [material type system](https://material.io/design/typography/the-type-system.html#type-scale)
  static const TextTheme _textTheme = TextTheme(
    headline1: TextStyle(fontSize: 96.0, fontFamily: _fontFamily),
    headline2: TextStyle(fontSize: 60.0, fontFamily: _fontFamily),
    headline3: TextStyle(fontSize: 48.0, fontFamily: _fontFamily),
    headline4: TextStyle(fontSize: 34.0, fontFamily: _fontFamily),
    headline5: TextStyle(fontSize: 24.0, fontFamily: _fontFamily),
    headline6: TextStyle(fontSize: 20.0, fontFamily: _fontFamily),
    subtitle1: TextStyle(fontSize: 16.0),
    subtitle2: TextStyle(fontSize: 14.0),
    bodyText1: TextStyle(fontSize: 16.0),
    bodyText2: TextStyle(fontSize: 14.0),
    button: TextStyle(fontSize: 14.0, fontFamily: _fontFamily, fontWeight: _bold),
    caption: TextStyle(fontSize: 12.0),
    overline: TextStyle(fontSize: 10.0),
  );
}

const kRoundedShapeBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(defaultBorderRadius),
  ),
);

const double defaultBorderRadius = 6;
