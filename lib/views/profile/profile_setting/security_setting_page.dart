import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/function/profile_function.dart';

class SecuritySettingPage extends StatelessWidget {
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
                'セキュリティ',
                style: kHeader1TextStyle,
              ),
              ListTile(
                title: Text('パスワード変更'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // パスワード変更ロジック
                },
              ),
              // 以下、他のセキュリティ設定も追加可能
              SizedBox(height: 20), // セクション間のスペース
              Text(
                'プライバシー',
                style: kHeader1TextStyle,
              ),
              SwitchListTile(
                title: Text('アプリの使用状況を共有する'),
                value: true,
                onChanged: (bool value) {
                  // スイッチの状態を変更した時のロジック
                },
              ),
              SwitchListTile(
                title: Text('位置情報を共有する'),
                value: false,
                onChanged: (bool value) {
                  // スイッチの状態を変更した時のロジック
                },
              ),
              // 以下、他のプライバシー設定も追加可能
            ],
          ),
        ),
      ),
    );
  }
}