import 'dart:io';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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
    await uploadUserImage(context, pickedFile);
    return pickedFile;
  }
  return null;
}

Future<void> uploadUserImage(BuildContext context, XFile file) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final filePath = file.path;
  final extension = Path.extension(filePath).toLowerCase();

  // ファイル形式の確認
  if (!['.png', '.jpg', '.jpeg', '.JPEG', '.hex'].contains(extension)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('不正なファイル形式です。')),
    );
    return;
  }

  File originalFile = File(filePath);

  // 画像を圧縮
  File? compressedImage;
  try {
    compressedImage = (
      await FlutterImageCompress.compressAndGetFile(
        originalFile.absolute.path,
        originalFile.absolute.path,
        quality: 65, // 圧縮率
      ),
    ) as File?;
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('画像の圧縮に失敗しました。'),
      ),
    );
    return;
  }

  if (compressedImage != null) {
    try {
      // 圧縮された画像をアップロード
      await FirebaseStorage.instance
          .ref('userImages/$uid$extension')
          .putFile(compressedImage);

      // 成功した場合の処理
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('画像がアップロードされました。'),
        ),
      );
    } catch (e) {
      // エラーを処理
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('画像のアップロードに失敗しました。'),
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('画像の圧縮に失敗しました。'),
      ),
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
