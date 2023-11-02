import 'package:flutter/material.dart';

Widget customListTile({
  required IconData leadingIcon,
  required String titleText,
  required VoidCallback onTapAction,
}) {
  return Container(
    alignment: Alignment.center,
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Icon(leadingIcon),
      title: Text(
        titleText,
        style: const TextStyle(fontSize: 14),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTapAction,
    ),
  );
}
