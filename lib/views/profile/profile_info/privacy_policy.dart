import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: CustomAppBar(titleText: 'プライバシーポリシー'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 1. 個人情報の収集
              Text(
                '1. 個人情報の収集',
                style: kHeader2TextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                '当アプリは、ユーザーの同意のもと、アプリ運用にあたり必要な以下の個人情報を収集する場合があります。',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                '・名前\n・連絡先情報（メールアドレス）\n・医療機関情報（かかりつけ医療機関）\n・糖尿病発症日\n・血糖値\n・服用するインスリンの種類と投与量\n・食事内容や運動量\n・その他ユーザーが入力する情報',
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(height: 20),

              // 2. 個人情報の利用目的
              Text(
                '2. 個人情報の利用目的',
                style: kHeader2TextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                '収集した個人情報は以下の目的で利用します。\n・インスリンの調整のサポート\n・サービスの提供、維持、改善のため\n・ユーザーからの問い合わせやサポートの対応\n・新しいサービスや機能のお知らせのため',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),

              // 3. 個人情報の第三者への提供
              Text(
                '3. 個人情報の第三者への提供',
                style: kHeader2TextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                '当アプリは、以下の場合を除き、ユーザーの個人情報を第三者に提供しません。\n・ユーザーの同意がある場合\n・法的な要請がある場合\n・当アプリの権利や財産を守る必要があると判断された場合',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),

              // 4. 個人情報の保護
              Text(
                '4. 個人情報の保護',
                style: kHeader2TextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                '当アプリは、ユーザーの個人情報を適切に管理し、不正アクセス、紛失、破壊、改ざん、漏洩などのリスクから保護するための措置を講じています。',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),

              // 5. アクセスと修正
              Text(
                '5. アクセスと修正',
                style: kHeader2TextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'ユーザーは、自分の情報にアクセスし、必要に応じて修正することができます。',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),

              // 6. ポリシーの変更
              Text(
                '6. ポリシーの変更',
                style: kHeader2TextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                '本ポリシーの内容は、法令などの変更、またはサービス内容の変更に伴い、予告なく変更されることがあります。プライバシーポリシーに変更があった場合、当アプリは適切な方法でユーザーに通知します。変更後のポリシーは、本アプリ内で公開されたものとします。',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),

              // 7. お問い合わせ
              Text(
                '7. お問い合わせ',
                style: kHeader2TextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'プライバシーポリシーに関するお問い合わせやご意見は、',
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


