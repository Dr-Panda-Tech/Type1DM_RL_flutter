import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/function/profile_function.dart';

class ExternalServicePage extends StatelessWidget {
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
      ),
    );
  }
}
