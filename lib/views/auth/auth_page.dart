import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/button/main_button.dart';
import 'package:type1dm_rl_flutter/views/auth/sign_in_page.dart';
import 'package:type1dm_rl_flutter/views/auth/sign_up_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  void _handleSignup() {
    customSignUpDialog(context, onClosed: (value) {
      // Handle any actions when the dialog is closed, if needed
    });
  }

  void _handleSignIn() async {
    customSignInDialog(context, onClosed: (value) {
      // Handle any actions when the dialog is closed, if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstants.backgroundColor,
      body: Container(
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, 0.05),
              child: Image.asset(
                'assets/images/dalle_robot3.png',
                fit: BoxFit.contain,
                width: 580.0,  // こちらを追加
                height: 580.0, // こちらを追加
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  20.0, 100.0, 20.0, 20.0), // この行を変更: 上部の余白を50.0に設定
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      '強化学習型インスリン調整アプリ', // '\n'を追加して改行
                      style: KHeadTextStyle,
                      textAlign: TextAlign.center, // テキストをセンター揃えに
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'NovoSelf',
                      style: KLogoTextStyle,
                      textAlign: TextAlign.center, // テキストをセンター揃えに
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 65), // 下部の余白を調整
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Columnのサイズを最小限にする
                  children: [
                    buildButton(
                      onPressed: _handleSignIn,
                      text: 'Sign in',
                      icon: Icons.login,
                      color: ColorConstants.pandaBlack,
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "OR",
                            style: kColorTextStyle,
                          ),
                        ),
                        Expanded(
                          child: Divider(),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: _handleSignup,
                      child: Text(
                        'Sign up？',
                        style: kUnderTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
