import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';

Widget buildButton(
    {required VoidCallback onPressed,
    required String text,
    required IconData? icon,
    required Color color}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      fixedSize: Size(330.0, 50.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      textStyle: const TextStyle(fontSize: 20),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start, // この行で左寄せを指定
      children: [
        Icon(
          icon,
          color: ColorConstants.buttonMaterialColor,
        ), // アイコンとテキストの間にスペースを追加
        SizedBox(width: 90.0),
        Expanded(
          // Expandedを使用してテキストを中央に配置
          child: Text(
            text,
            style: const TextStyle(
              color: ColorConstants.buttonMaterialColor,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    ),
  );
}
