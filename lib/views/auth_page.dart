import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/services/auth_service.dart';
import 'package:type1dm_rl_flutter/utils/auth_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final AuthService _authService = AuthService();

  void _handleSignup() {
    Navigator.pushNamed(context, '/signUpPage');
  }

  void _handleLogin() async {
    Navigator.pushNamed(context, '/loginPage');
  }

  void _handleGoogleLogin() async {
    // Googleログイン処理...
    var user = await _authService.signInWithGoogle();
    if (user != null) {
      if (mounted) {
        // ウィジェットがまだマウントされているかを確認
        Navigator.pushReplacementNamed(context, '/homePage');
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('ログインに失敗しました。')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.appImageColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '1型糖尿病のあなたに届ける\nインスリン調整アプリ', // '\n'を追加して改行
                style: TextStyle(
                  fontSize: 20, // フォントサイズを20に変更
                  fontWeight: FontWeight.bold, // フォントを太く
                ),
                textAlign: TextAlign.center, // テキストをセンター揃えに
              ),
              const SizedBox(height: 15),
              const Text(
                'NovoSelf',
                style: TextStyle(
                  fontSize: 60, // フォントサイズを20に変更
                  fontWeight: FontWeight.w900, // フォントを太く
                  fontFamily: 'Sacramento',
                ),
                textAlign: TextAlign.center, // テキストをセンター揃えに
              ),
              const SizedBox(height: 20),
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/app_icon_green.png'),
                backgroundColor: Color(0xFFBADCAD),
                radius: 90.0, // アイコンのサイズを調整するための半径
              ),
              const SizedBox(height: 40),
              buildButton(
                onPressed: _handleSignup,
                text: '新規登録',
                icon: Icons.person_add,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 20),
              buildButton(
                onPressed: _handleLogin,
                text: 'ログイン',
                icon: Icons.login,
                color: ColorConstants.accentColor,
              ),
              const SizedBox(height: 20),
              buildButton(
                onPressed: _handleGoogleLogin,
                text: 'Googleでログイン',
                icon: Icons.lock_outline,
                color: Colors.grey[700]!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
