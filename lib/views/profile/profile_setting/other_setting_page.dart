import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/function/profile_function.dart';

class OtherSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileFunc = ProfileFunction(context);
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text('テーマ設定'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // テーマ設定ページへの遷移やロジック
                    },
                  ),
                  ListTile(
                    title: Text('言語設定'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // 言語設定ページへの遷移やロジック
                    },
                  ),
                  ListTile(
                    title: Text('ヘルプ＆サポート'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // ヘルプ＆サポートページへの遷移やロジック
                    },
                  ),
                  ListTile(
                    title: Text('アプリのバージョン情報'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // アプリのバージョン情報ページへの遷移やロジック
                    },
                  ),
                  SwitchListTile(
                    title: Text('ダークモード'),
                    value: true, // これは現在のダークモードの状態を示すもので、実際のロジックに応じて変更してください。
                    onChanged: (bool value) {
                      // ダークモードの状態を変更した時のロジック
                    },
                  ),
                  // 以下、他の設定も追加可能
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}