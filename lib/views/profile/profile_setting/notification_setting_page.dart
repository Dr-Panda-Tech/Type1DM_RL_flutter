import 'package:flutter/material.dart';

class NotificationSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '通知の設定',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text('メール通知'),
              trailing: Switch(
                value: true,
                onChanged: (bool value) {},
              ),
            ),
            ListTile(
              title: Text('プッシュ通知'),
              trailing: Switch(
                value: false,
                onChanged: (bool value) {},
              ),
            ),
            // 以下、他の通知設定も追加可能
          ],
        ),
      ),
    );
  }
}
