import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/button/twin_button.dart';

class UserImageSettingPage extends StatefulWidget {
  UserImageSettingPage({super.key});

  @override
  _UserImageSettingPageState createState() => _UserImageSettingPageState();
}

class _UserImageSettingPageState extends State<UserImageSettingPage> {
  XFile? _image;
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    // 画像をピック
    final pickedFile = await _picker.pickImage(
      source: source,
      preferredCameraDevice: CameraDevice.front,
    );

    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
      // Firebase Storageにアップロード
      _uploadFile(pickedFile);
    }
  }

  Future<void> _uploadFile(XFile file) async {
    final filePath = file.path;
    // 拡張子をチェック
    final extension = Path.extension(filePath).toLowerCase();
    if (!['.png', '.jpg', '.jpeg', '.JPEG', '.hex'].contains(extension)) {
      // 不正なファイル形式のエラーを表示
      return;
    }

    File fileToUpload = File(filePath); // Create a File instance from the path
    try {
      // Use fileToUpload to upload the file
      await FirebaseStorage.instance
          .ref(
              'userImages/$uid$extension') // Use the UID and the file extension
          .putFile(fileToUpload); // Use the File instance here
      // 成功した場合の処理
    } catch (e) {
      // エラーを処理
    }
  }

  void _showImageSourceActionSheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text('カメラで撮影'),
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
          CupertinoActionSheetAction(
            child: Text('ライブラリから選択'),
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text('キャンセル'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Align(
              alignment: Alignment.center,
              child: Text(
                '次にユーザーイメージを設定します',
                style: kHeader2TextStyle,
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: GestureDetector(
                onTap: _showImageSourceActionSheet,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: _image != null
                          ? FileImage(File(_image!.path))
                          : AssetImage('assets/images/dummy_user.png')
                              as ImageProvider,
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: Icon(Icons.camera_alt,
                          color: ColorConstants.pandaBlack, size: 30.0),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            twinButton(
              leftOnPressed: () async {
                Navigator.pop(context);
              },
              leftText: '戻る',
              rightOnPressed: () async {
                Navigator.pushNamed(context, '/insulinSettingsPage');
              },
              rightText: '次へ',
            ),
          ],
        ),
      ),
    );
  }
}
