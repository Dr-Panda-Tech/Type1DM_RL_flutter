import 'package:flutter/material.dart';

class ColorConstants {
  static const Color appBarColor = Color(0xFF3E3E3E);
  static const Color backgroundColor = Color(0xFFE7E6DD);
  static const Color pandaGreen = Color(0xFFBADCAD);
  static const Color pandaBlack = Color(0xFF3E3E3E);
  static const Color accentColor = Color(0xFF396122);
  static const Color fieldGrey =  Color(0xFFE1E1E2);
  static const Color buttonMaterialColor = Color(0xFFF2F2F7);
  static const Color settingsListBackground = Color(0xFFF2F2F7);
  static const Color settingsSectionBackground = Colors.white;
  static const Color yellow = Colors.yellow;
  static const Color lightBlue = Colors.lightBlue;
  static const Color blue = Colors.blue;
  static const Color grey = Colors.grey;
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color red = Colors.red;
}

ThemeData pandaTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    color: ColorConstants.backgroundColor,
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

final elevatedButtonStyle = ElevatedButton.styleFrom(
  fixedSize: const Size.fromWidth(300.0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  ),
  foregroundColor: Colors.white,
  backgroundColor: ColorConstants.pandaBlack,
);


const KLogoTextStyle = TextStyle(
  fontSize: 60, // フォントサイズを20に変更
  fontWeight: FontWeight.w900, // フォントを太く
  fontFamily: 'Sacramento',
  color: ColorConstants.pandaBlack,
);

const KHeadTextStyle = TextStyle(
  fontSize: 18, // フォントサイズを20に変更
  fontWeight: FontWeight.bold, // フォントを太く
  fontFamily: 'NotoSansJP',
  color: ColorConstants.pandaBlack,
);

const kLabelTextStyle = TextStyle(
  fontSize: 18.0,
  color: Color(0xFF222222),
);

const kTableLabelTextStyle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.bold, // フォントを太く
  color: ColorConstants.pandaBlack,
);

const kUnderTextStyle = TextStyle(
  fontSize: 18.0,
  color: Color(0xFF3E3E3E),
  decoration: TextDecoration.underline, // 下線を引く
  fontStyle: FontStyle.italic,
);

const kNumberTextStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.w900,
);

const kLargeButtonTextStyle = TextStyle(
  fontSize:16.0,
  fontWeight: FontWeight.bold,
);

const kMiniCardTextStyle = TextStyle(
  fontSize:12.0,
);

const kMediumCardTextStyle = TextStyle(
  fontSize:14.0,
);

const kSettingListTextStyle = TextStyle(
    fontSize: 14,
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

const kColorTextStyle = TextStyle(
    color: ColorConstants.pandaBlack,
);

const kFormColorTextStyle = TextStyle(
  color: ColorConstants.grey,
);

const kSendFormTextStyle = TextStyle(
  fontSize: 15.0,
  color: ColorConstants.pandaBlack,
  fontWeight: FontWeight.bold,
);

const kHeader1TextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: ColorConstants.pandaBlack,
);

const kHeader2TextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: ColorConstants.pandaBlack,
);

const kFormLabelTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: ColorConstants.pandaBlack,
);

const kSelectTextStyle = TextStyle(
  fontSize: 18,
  color: ColorConstants.pandaBlack,
);

const kDateTextStyle = TextStyle(
  fontSize: 16,
  color: ColorConstants.pandaBlack,
);

const kKeyboardDoneTextStyle = TextStyle(
  color: ColorConstants.blue,
);

const kAppBarTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: ColorConstants.pandaBlack,
);

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;

  CustomAppBar({required this.titleText});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.backgroundColor,
      elevation: 1.0,
      centerTitle: true,
      title: Text(
        titleText,
        style: kHeader1TextStyle.copyWith(fontSize: 18.0),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Divider(
          height: 1,
          color: Colors.grey,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 1.0);
}