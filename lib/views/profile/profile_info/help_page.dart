import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';

class HelpAndFAQPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: CustomAppBar(titleText: 'ヘルプ・よくある質問'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
