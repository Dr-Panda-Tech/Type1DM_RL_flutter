import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/views/profile/profile_others/contact_page.dart';

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
              SizedBox(height: 16),
              Text(
                '1. 個人情報の収集',
                style: kHeader2TextStyle,
              ),
              SizedBox(height: 8),
              Text(
                '当アプリは、ユーザー登録時に名前、メールアドレスなどの個人情報を収集する場合があります。',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                  '当アプリは、ユーザーの同意のもと、以下の情報を収集することがあります。\n・ 名前\n・ 連絡先情報（メールアドレス、電話番号など）\n・ 利用履歴や行動ログ'),
              SizedBox(height: 16.0),
              Text(
                '2. 個人情報の利用目的',
                style: kHeader2TextStyle,
              ),
              SizedBox(height: 8),
              Text(
                  '収集した個人情報は以下の目的で利用します。\n- サービスの提供、維持、改善のため\n- ユーザーサポートのため\n- 新しいサービスや機能のお知らせのため'),
              SizedBox(height: 16.0),
              Text(
                '3. 個人情報の第三者への提供',
                style: kHeader2TextStyle,
              ),
              SizedBox(height: 8),
              Text(
                  '当アプリは、以下の場合を除き、ユーザーの個人情報を第三者に提供しません。\n- ユーザーの同意がある場合\n- 法的な要請がある場合'),
              SizedBox(height: 16.0),
              Text(
                '4. 個人情報の保護',
                style: kHeader2TextStyle,
              ),
              SizedBox(height: 8),
              Text(
                  '当アプリは、ユーザーの個人情報を適切に管理し、不正アクセス、紛失、破壊、改ざん、漏洩などのリスクから保護するための措置を講じています。'),
              SizedBox(height: 16.0),
              Text(
                '5. ポリシーの変更',
                style: kHeader2TextStyle,
              ),
              SizedBox(height: 8),
              Text(
                  '本ポリシーの内容は、法令などの変更、またはサービス内容の変更に伴い、予告なく変更されることがあります。変更後のポリシーは、本アプリ内で公開されたものとします。'),
              SizedBox(height: 16.0),
              Text(
                '6. お問い合わせ',
                style: kHeader2TextStyle,
              ),
              SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'プライバシーポリシーに関するお問い合わせやご意見は、',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    TextSpan(
                      text: 'お問い合わせフォーム',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // お問い合わせフォームページへの遷移ロジック
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => ContactPage(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(opacity: animation, child: child);
                              },
                            ),
                          );
                        },
                    ),
                    TextSpan(
                      text: 'までお願いいたします。',
                      style: TextStyle(color: Colors.black, fontSize: 16),
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

