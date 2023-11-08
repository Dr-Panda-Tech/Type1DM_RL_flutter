import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/button/twin_button.dart';
import 'package:type1dm_rl_flutter/utils/function/image_handler_function.dart';

class UserImageSettingPage extends StatefulWidget {
  UserImageSettingPage({super.key});

  @override
  _UserImageSettingPageState createState() => _UserImageSettingPageState();
}

class _UserImageSettingPageState extends State<UserImageSettingPage> {
  XFile? _image;
  void _handleImageSelection(ImageSource source) async {
    final pickedImage = await pickImage(context, source);
    setState(() {
      _image = pickedImage;
    });
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
                onTap: () => showImageSourceActionSheet(context, _handleImageSelection),
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
