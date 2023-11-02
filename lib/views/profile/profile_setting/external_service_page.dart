import 'package:flutter/material.dart';

class ExternalServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('外部サービス連携'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '外部サービスとの連携設定',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text('サービスA'),
              trailing: Switch(
                value: true, // この値は実際には状態管理を使用して動的に変更します。
                onChanged: (bool value) {},
              ),
            ),
            ListTile(
              title: Text('サービスB'),
              trailing: Switch(
                value: false,
                onChanged: (bool value) {},
              ),
            ),
            // 以下、他のサービスの連携設定も追加可能
          ],
        ),
      ),
    );
  }
}
