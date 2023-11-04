import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';

class NotificationSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: CustomAppBar(titleText: '通知の設定'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
