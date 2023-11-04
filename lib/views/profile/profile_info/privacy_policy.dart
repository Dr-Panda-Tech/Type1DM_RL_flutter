import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/views/profile/profile_others/contact_page.dart';

class PrivacyPolicyPage extends StatelessWidget {
  void _goBackToProfilePage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/profilePage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    _goBackToProfilePage(context);// 前のページに戻る
                  },
                ),
              ),
              Text(
                'プライバシーポリシー',
                style: kHeader1TextStyle,
              ),
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
                  '当アプリは、ユーザーの同意のもと、以下の情報を収集することがあります。\n- 名前\n- 連絡先情報（メールアドレス、電話番号など）\n- 利用履歴や行動ログ'),
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
              Text(
                'プライバシーポリシーに関するお問い合わせやご意見は、お問い合わせフォームまでお願いいたします。',
                style: kHeader2TextStyle,
              ),
              SizedBox(height: 32.0),
              TextButton(
                child: Text('お問い合わせ'),
                onPressed: () {
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
            ],
          ),
        ),
      ),
    );
  }
}
