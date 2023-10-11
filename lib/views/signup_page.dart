import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新規登録'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // 一つ前のページに戻る
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'メールアドレス'),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'パスワード'),
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              style: elevatedButtonStyle,
              onPressed: () async {
                final email = emailController.text;
                final password = passwordController.text;
                final user = await _authService.signUpWithEmailAndPassword(
                    email, password);
                if (user != null) {
                  Navigator.pushReplacementNamed(
                      context, '/registrationDetailPage');
                } else {
                  // 何らかのエラーメッセージを表示
                  print('エラーが発生しました');
                }
              },
              child: const Text('次へ進む'),
            ),
          ],
        ),
      ),
    );
  }
}
