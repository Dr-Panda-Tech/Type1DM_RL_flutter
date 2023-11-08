import 'dart:io';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

Future<XFile?> pickImage(BuildContext context, ImageSource source) async {
  final ImagePicker _picker = ImagePicker();
  final pickedFile = await _picker.pickImage(
    source: source,
    preferredCameraDevice: CameraDevice.front,
  );

  if (pickedFile != null) {
    // Firebase Storageにアップロード
    await uploadFile(context, pickedFile);
    return pickedFile;
  }
  return null;
}

Future<void> uploadFile(BuildContext context, XFile file) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final filePath = file.path;
  final extension = Path.extension(filePath).toLowerCase();

  if (!['.png', '.jpg', '.jpeg', '.JPEG', '.hex'].contains(extension)) {
    // 不正なファイル形式のエラーを表示
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('不正なファイル形式です。')),
    );
    return;
  }

  File fileToUpload = File(filePath);
  try {
    await FirebaseStorage.instance
        .ref('userImages/$uid$extension')
        .putFile(fileToUpload);
    // 成功した場合の処理
  } catch (e) {
    // エラーを処理
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('画像のアップロードに失敗しました。')),
    );
  }
}

void showImageSourceActionSheet(
    BuildContext context, Function(ImageSource) onImageSelected) {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text(
            'カメラで撮影',
            style: kColorTextStyle,
          ),
          onPressed: () {
            Navigator.pop(context);
            onImageSelected(ImageSource.camera);
          },
        ),
        CupertinoActionSheetAction(
          child: Text(
            'ライブラリから選択',
            style: kColorTextStyle,
          ),
          onPressed: () {
            Navigator.pop(context);
            onImageSelected(ImageSource.gallery);
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          'キャンセル',
          style: kColorTextStyle,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
  );
}
