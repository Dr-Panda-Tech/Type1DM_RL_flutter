import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';

Widget singleRegisterButton(
    {required VoidCallback onPressed,
      required String text,
      required IconData? icon,
      required Color color}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      fixedSize: Size(250.0, 50.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.only(left: 20, right:35, top: 10, bottom: 10),
      textStyle: const TextStyle(fontSize: 16),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center, // この行で左寄せを指定
      children: [
        Icon(
          icon,
          color: ColorConstants.buttonMaterialColor,
        ), // アイコンとテキストの間にスペースを追加
        Expanded(
          // Expandedを使用してテキストを中央に配置
          child: Text(
            text,
            style: const TextStyle(
              color: ColorConstants.buttonMaterialColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
