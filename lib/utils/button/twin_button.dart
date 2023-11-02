import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';

Widget twinButton({
  required Future<void> Function() leftOnPressed,
  required String leftText,
  required Future<void> Function() rightOnPressed,
  required String rightText,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      ElevatedButton(
        onPressed: leftOnPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.pandaBlack,
          fixedSize: Size(150, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: Text(
          leftText,
          style: const TextStyle(
            color: ColorConstants.white,
            fontSize: 16.0,
            inherit: false,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      ElevatedButton(
        onPressed: rightOnPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.pandaBlack,
          fixedSize: Size(150, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: Text(
          rightText,
          style: const TextStyle(
            color: ColorConstants.white,
            fontSize: 16.0,
            inherit: false,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}
