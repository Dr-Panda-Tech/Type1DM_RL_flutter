import 'package:flutter/material.dart';

class ColorConstants {
  static Color appBarColor = const Color(0xFF4A67AD);
  static Color backgroundColor = const Color(0xFFF2F2F7);
  static Color appImageColor = const Color(0xFFBADCAD);
  static Color accentColor = const Color(0xFF396122);
  static Color settingsListBackground = const Color(0xFFF2F2F7);
  static Color settingsSectionBackground = Colors.white;
  static Color yellow = Colors.yellow;
  static Color lightBlue = Colors.lightBlue;
  static Color blue = Colors.blue;
  static Color grey = Colors.grey;
  static Color black = Colors.black;
  static Color white = Colors.white;
  static Color red = Colors.red;
}

final elevatedButtonStyle = ElevatedButton.styleFrom(
  fixedSize: const Size.fromWidth(200.0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  ),
  foregroundColor: Colors.white,
  backgroundColor: ColorConstants.accentColor,
);

ThemeData pandaTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    color: Color(0xFF222222),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 25.0,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white, backgroundColor: ColorConstants.accentColor,
    ),
  ),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  primaryColor: const Color(0xFF222222),
  hintColor: const Color(0xFF396122),
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      color: Color(0xFF222222),
    ),
  ),
);

const kLabelTextStyle = TextStyle(
  fontSize: 18.0,
  color: Color(0xFF222222),
);

const kNumberTextStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.w900,
);

const kLargeButtonTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

const kTitleTextStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.bold,
);

const kResultTextStyle = TextStyle(
  color: Color(0xFF24D876),
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
);

const kBodyTextStyle = TextStyle(
  fontSize: 22.0,
);
