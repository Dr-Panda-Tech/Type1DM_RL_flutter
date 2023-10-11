import 'package:flutter/material.dart';

Widget buildButton(
    {required VoidCallback onPressed,
      required String text,
      required IconData icon,
      required Color color}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      fixedSize: const Size.fromWidth(250.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      textStyle: const TextStyle(fontSize: 18),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,  // この行で左寄せを指定
      children: [
        Icon(icon, color: Colors.white),// アイコンとテキストの間にスペースを追加
        Expanded(  // Expandedを使用してテキストを中央に配置
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}