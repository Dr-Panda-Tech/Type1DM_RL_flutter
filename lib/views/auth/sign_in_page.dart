import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/function/auth_function.dart';
import 'package:type1dm_rl_flutter/utils/form/sign_in_form.dart';

Future<Object?> customSignInDialog(BuildContext context,
    {required ValueChanged onClosed}) {
  final authFunction = AuthFunction(context);
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: "Sign In",
    context: context,
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      Tween<Offset> tween = Tween(begin: Offset(0, -1), end: Offset.zero);
      return SlideTransition(
          position: tween.animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: child);
    },
    pageBuilder: (context, _, __) => Center(
      child: Container(
        height: 620,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: const BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset:
              false, // avoid overflow error when keyboard shows up
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Sign In",
                  style: TextStyle(fontSize: 34, fontFamily: "NotoSansJP"),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "登録済みのメールアドレスとパスワードを入力",
                    textAlign: TextAlign.center,
                  ),
                ),
                const SignInForm(),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "OR",
                        style: TextStyle(color: ColorConstants.pandaBlack),
                      ),
                    ),
                    Expanded(
                      child: Divider(),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Sign in with Google or Apple",
                    style: TextStyle(color: ColorConstants.pandaBlack),
                  ),
                ),
                SignInButton(
                  Buttons.Google,
                  text: "Sign in with Google",
                  onPressed: () async {
                    await authFunction.signInWithGoogle();
                  },
                ),
                SizedBox(height: 5.0),
                SignInButton(
                  Buttons.Apple,
                  text: "Sign in with Apple",
                  onPressed: () async {
                    await authFunction.signInWithApple();
                  },
                ),
                SizedBox(height: 10.0), // 必要に応じてこの値を調整
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    highlightColor: Colors.transparent, // ハイライトカラーを透明に設定
                    splashColor: Colors.transparent, // スプラッシュカラーを透明に設定
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child:
                          Icon(Icons.close, color: ColorConstants.pandaBlack),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
