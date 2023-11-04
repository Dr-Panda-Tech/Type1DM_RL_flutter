import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';

class LanguageSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: CustomAppBar(titleText: 'アプリの言語を選択'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
