import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';

class UserGuidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: CustomAppBar(titleText: 'アプリの使い方'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16),
              Text(
                '1. 画面の左上にあるメニューアイコンをタップして、メニューを開きます。',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                '2. メニューに表示される項目から、希望のページに移動できます。',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                '3. アプリの各機能や設定は、設定ページから変更できます。',
                style: TextStyle(fontSize: 18),
              ),
              // 以下、必要に応じてガイドを追加してください。
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('戻る'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
