import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
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
              Text(
                '1. 利用開始の手続',
                style: kHeader2TextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                '本アプリの利用を開始する際には、本利用規約に同意した上で、所定の手続きを完了してください。',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),

              Text(
                '2. 禁止事項',
                style: kHeader2TextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'ユーザーは、以下の行為を禁止します。\n・法令または公序良俗に反する行為\n・犯罪的行為\n・当アプリのサーバーやネットワークの機能を破壊、妨害する行為\n・当アプリのサービスの運営を妨害するおそれのある行為\n・他のユーザーへの迷惑や不利益、損害を与える行為\n・他のユーザーの情報の収集\n・当アプリのセキュリティの脆弱性を利用する行為\n・当アプリに関連する情報を改ざんする行為\n・その他、運営者が不適切と判断する行為',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),

              Text(
                '3. 利用の制限または登録の取り消し',
                style: kHeader2TextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                '以下の場合、ユーザーに事前に通知することなく、ユーザーの本アプリの利用を一時的に制限するか、ユーザーとしての登録を取り消すことができます。\n・本利用規約のいずれかの条項に違反した場合\n・登録情報に虚偽の事実があることが判明した場合\n・その他、運営者が本アプリの利用を適当でないと判断した場合',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),

              Text(
                '4. 免責事項',
                style: kHeader2TextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                '当アプリの利用により直接または間接的にユーザーに発生した損害に対して、運営者は一切の責任を負わないものとします。',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),

              Text(
                '5. 利用規約の変更',
                style: kHeader2TextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                '運営者は、必要と判断した場合には、ユーザーに通知することなく本利用規約を変更することができるものとします。',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),

              Text(
                '6. お問い合わせや苦情',
                style: kHeader2TextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '利用規約に関するお問い合わせや苦情は、',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    TextSpan(
                      text: 'お問い合わせフォーム',
                      style: TextStyle(color: Colors.blue, fontSize: 18, decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/contactPage');
                        },
                    ),
                    TextSpan(
                      text: 'までお願いいたします。',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }
}
