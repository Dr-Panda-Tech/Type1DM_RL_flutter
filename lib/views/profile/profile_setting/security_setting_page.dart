import 'package:flutter/material.dart';

class SecuritySettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('セキュリティとプライバシー'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'セキュリティ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
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
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
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
    );
  }
}
