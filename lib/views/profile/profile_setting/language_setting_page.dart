import 'package:flutter/material.dart';

class LanguageSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('言語設定'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
    );
  }
}
