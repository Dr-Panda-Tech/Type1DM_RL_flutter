import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';

class HelpAndFAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        title: Text('ヘルプ・よくある質問'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
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
    );
  }
}
