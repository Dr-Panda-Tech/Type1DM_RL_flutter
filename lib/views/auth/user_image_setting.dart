import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/button/twin_button.dart';
import 'package:type1dm_rl_flutter/utils/function/image_handler_function.dart'; // 必要に応じてパスを調整してください

class UserImageSettingPage extends StatefulWidget {
  @override
  _UserImageSettingPageState createState() => _UserImageSettingPageState();
}

class _UserImageSettingPageState extends State<UserImageSettingPage> {
  late ImageHandler imageHandler;  // lateキーワードを使用して、後で初期化することを明示します

  @override
  void initState() {
    super.initState();
    imageHandler = ImageHandler(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'ユーザーのイメージ画像を設定してください',
                        style: kHeader2TextStyle,
                      ),
                    ),
                    const SizedBox(height: 40),
                    if (imageHandler.imageFile != null)
                      Image.file(imageHandler.imageFile!)
                    else
                      Text('No image selected'),
                    ElevatedButton(
                      onPressed: imageHandler.pickAndSetImage,
                      child: Text('Pick Image'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: twinButton(
              leftOnPressed: () async {
                Navigator.pop(context);
              },
              leftText: '戻る',
              rightOnPressed: () async {
                if (imageHandler.imageFile != null) {
                  await imageHandler.uploadCurrentImage();
                  Navigator.pushNamed(context, '/insulinSettingsPage');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('画像を選択してください。'),
                    ),
                  );
                }
              },
              rightText: '次へ',
            ),
          )
        ],
      ),
    );
  }
}
