import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/function/profile_function.dart';

class LanguageSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileFunc = ProfileFunction(context);
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                  top: 40, // ボタンの位置を調整するための余白を追加
                  left: 20,
                ),
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back), // 戻るボタンのアイコン
                  onPressed: () {
                    profileFunc.goBackToProfilePage(context); // 前のページに戻る
                  },
                ),
              ),
              Text(
                'アプリの言語を選択',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                title: Text('日本語'),
                trailing: Radio(
                  value: 'Japanese',
                  groupValue: 'selectedLanguage',
                  onChanged: (String? value) {},
                ),
              ),
              ListTile(
                title: Text('英語'),
                trailing: Radio(
                  value: 'English',
                  groupValue: 'selectedLanguage',
                  onChanged: (String? value) {},
                ),
              ),
              // 以下、他の言語の選択も追加可能
            ],
          ),
        ),
      ),
    );
  }
}
