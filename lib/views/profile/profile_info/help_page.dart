import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/function/profile_function.dart';

class HelpAndFAQPage extends StatelessWidget {

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
