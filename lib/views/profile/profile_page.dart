import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/widget/list_tile.dart';
import 'package:type1dm_rl_flutter/utils/function/profile_function.dart';
import 'package:type1dm_rl_flutter/utils/card/profile_user_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    final profileFunc = ProfileFunction(context);
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // データの取得中に表示するウィジェット
          }
          return ListView(
            key: PageStorageKey<String>('profileListView'),  // これを追加
            children: [
              UserProfileCard(),
              ListTile(
                title: const Text(
                  '設定',
                  style: kSettingListTextStyle,
                ),
              ),
              Divider(indent: 16, endIndent: 16), // 区切り線の両端のマージンを追加, // 境
              customListTile(
                leadingIcon: Icons.info,
                titleText: '基本情報の変更',
                onTapAction: () {
                  Navigator.pushNamed(context, '/profileEditPage');
                },
              ),
              Divider(indent: 16, endIndent: 16), // 区切り線の両端のマージンを追加, // 境
              customListTile(
                leadingIcon: Icons.language,
                titleText: '言語設定',
                onTapAction: () {
                  Navigator.pushNamed(context, '/languageSettingPage');
                },
              ),
              Divider(indent: 16, endIndent: 16), // 区切り線の両端のマージンを追加, // 境
              customListTile(
                leadingIcon: Icons.notification_add,
                titleText: '通知設定',
                onTapAction: () {
                  Navigator.pushNamed(context, '/notificationSettingPage');
                },
              ),
              Divider(indent: 16, endIndent: 16), // 区切り線の両端のマージンを追加, // 境
              customListTile(
                leadingIcon: Icons.security,
                titleText: 'セキュリティとプライバシー',
                onTapAction: () {
                  Navigator.pushNamed(context, '/securitySettingPage');
                },
              ),
              Divider(indent: 16, endIndent: 16), // 区切り線の両端のマージンを追加, // 境
              customListTile(
                leadingIcon: Icons.connected_tv,
                titleText: '外部サービス連携',
                onTapAction: () {
                  Navigator.pushNamed(context, '/externalServicePage');
                },
              ),
              Divider(indent: 16, endIndent: 16), // 区切り線の両端のマージンを追加, // 境
              customListTile(
                leadingIcon: Icons.settings,
                titleText: 'その他設定',
                onTapAction: () {
                  Navigator.pushNamed(context, '/otherSettingPage');
                },
              ),
              Divider(indent: 16, endIndent: 16), // 区切り線の両端のマージンを追加, // 境
              ListTile(
                title: const Text(
                  '情報',
                  style: kSettingListTextStyle,
                ),
              ),
              Divider(indent: 16, endIndent: 16), // 区切り線の両端のマージンを追加, // 境
              customListTile(
                leadingIcon: Icons.lightbulb,
                titleText: '使い方ガイド',
                onTapAction: () {
                  Navigator.pushNamed(context, '/userGuidePage');
                },
              ),
              Divider(indent: 16, endIndent: 16), // 区切り線の両端のマージンを追加, // 境
              customListTile(
                leadingIcon: Icons.help_outline,
                titleText: 'ヘルプ・よくある質問',
                onTapAction: () {
                  Navigator.pushNamed(context, '/helpPage');
                },
              ),
              Divider(indent: 16, endIndent: 16), // 区切り線の両端のマージンを追加, // 境
              customListTile(
                leadingIcon: Icons.privacy_tip,
                titleText: 'プライバシーポリシー',
                onTapAction: () {
                  Navigator.pushNamed(context, '/privacyPolicyPage');
                },
              ),
              Divider(indent: 16, endIndent: 16), // 区切り線の両端のマージンを追加, // 境
              customListTile(
                leadingIcon: Icons.rule,
                titleText: '利用規約',
                onTapAction: () {
                  Navigator.pushNamed(context, '/termsOfServicePage');
                },
              ),
              Divider(indent: 16, endIndent: 16), // 区切り線の両端のマージンを追加, // 境
              ListTile(
                title: const Text(
                  'その他',
                  style: kSettingListTextStyle,
                ),
              ),
              Divider(indent: 16, endIndent: 16), // 区切り線の両端のマージンを追加, // 境
              customListTile(
                leadingIcon: Icons.question_answer,
                titleText: 'お問い合わせ・要望',
                onTapAction: () {
                  Navigator.pushNamed(context, '/contactPage');
                },
              ),
              Divider(indent: 16, endIndent: 16), // 区切り線の両端のマージンを追加, // 境
              customListTile(
                leadingIcon: Icons.logout,
                titleText: 'ログアウト',
                onTapAction: profileFunc.logout,
              ),
              Divider(indent: 16, endIndent: 16), // 区切り線の両端のマージンを追加, // 境
              customListTile(
                leadingIcon: Icons.door_back_door,
                titleText: '退会',
                onTapAction: () {
                  Navigator.pushNamed(context, '/withdrawalPage');
                }
              ),
              Divider(indent: 16, endIndent: 16), // 区切り線の両端のマージンを追加, // 境
            ],
          );
        },
      ),
    );
  }
}
