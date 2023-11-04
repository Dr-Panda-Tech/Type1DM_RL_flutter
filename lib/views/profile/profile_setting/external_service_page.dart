import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';

class ExternalServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: CustomAppBar(titleText: '外部サービスとの連携設定'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
      ),
    );
  }
}
