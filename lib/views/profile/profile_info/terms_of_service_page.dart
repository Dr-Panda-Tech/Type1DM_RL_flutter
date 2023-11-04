import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';

class TermsOfServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: CustomAppBar(titleText: '利用規約'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16),
              Text(
                '1. 利用登録',
                style: kHeader2TextStyle,
              ),
              SizedBox(height: 8),
              Text(
                '利用登録は、登録希望者の申し込みに対して、当サービスが承認することで、完了します。',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '2. ユーザーIDおよびパスワードの管理',
                style: kHeader2TextStyle,
              ),
              SizedBox(height: 8),
              Text(
                'ユーザーIDおよびパスワードの管理は、ユーザーが自己責任で行うものとします。',
                style: TextStyle(fontSize: 16),
              ),
              // ... 他のセクションも同様に追加してください
            ],
          ),
        ),
      ),
    );
  }
}
