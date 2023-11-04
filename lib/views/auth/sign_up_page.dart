import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:type1dm_rl_flutter/utils/function/auth_function.dart';
import 'package:type1dm_rl_flutter/utils/form/sign_up_form.dart';
import 'package:type1dm_rl_flutter/constants.dart';

Future<Object?> customSignUpDialog(BuildContext context,
    {required ValueChanged onClosed}) {
  final authFunction = AuthFunction(context);
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: "Sign up",
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
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
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
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 34, fontFamily: "NotoSansJP"),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "登録するメールアドレスとパスワードを入力",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SignUpForm(),
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
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      "Continue with Google or Apple",
                      style: TextStyle(color: ColorConstants.pandaBlack),
                    ),
                  ),
                  SignInButton(
                    Buttons.Google,
                    text: "Continue with Google",
                    onPressed: () async {
                      await authFunction.signInWithGoogle();
                    },
                  ),
                  SizedBox(height: 5.0),
                  SignInButton(
                    Buttons.Apple,
                    text: "Continue with Apple",
                    onPressed: () async {
                      await authFunction.signInWithApple();
                    },
                  ),

                ],
              ),
              const Positioned(
                left: 0,
                right: 0,
                bottom: -48,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.close, color: ColorConstants.pandaBlack),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ).then(onClosed);
}
