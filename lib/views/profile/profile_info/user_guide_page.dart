import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/function/profile_function.dart';

class UserGuidePage extends StatelessWidget {
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
                    profileFunc.goBackToProfilePage(context);// 前のページに戻る
                  },
                ),
              ),
              Text(
                'アプリの使い方',
                style: kHeader1TextStyle,
              ),
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
