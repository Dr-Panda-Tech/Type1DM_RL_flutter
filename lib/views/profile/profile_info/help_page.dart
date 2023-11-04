import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';

class HelpAndFAQPage extends StatelessWidget {
  void _goBackToProfilePage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/profilePage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    _goBackToProfilePage(context); // 前のページに戻る
                  },
                ),
              ),
              Text(
                'プライバシーポリシー',
                style: kHeader1TextStyle,
              ),
              ListTile(
                title: Text('質問1: 〜〜〜〜〜〜'),
                subtitle: Text('回答: 〜〜〜〜〜〜〜〜〜〜〜〜〜〜'),
              ),
              Divider(),
              ListTile(
                title: Text('質問2: 〜〜〜〜〜〜'),
                subtitle: Text('回答: 〜〜〜〜〜〜〜〜〜〜〜〜〜〜'),
              ),
              // ... その他の質問と回答 ...
            ],
          ),
        ),
      ),
    );
  }
}
