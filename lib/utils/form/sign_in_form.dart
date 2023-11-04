import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:type1dm_rl_flutter/utils/button/main_button.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool isShowLoading = false;
  bool isShowConfetti = false;

  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  late SMITrigger confetti;

  StateMachineController _getRiveController(Artboard artboard) {
    StateMachineController? controller =
    StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

  void signIn(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isShowLoading = true;
        isShowConfetti = true;
      });
      try {
        final email = emailController.text;
        final password = passwordController.text;
        await _auth.signInWithEmailAndPassword(email: email, password: password);

        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            isShowLoading = false;
          });
          check.fire();
          confetti.fire();
          Navigator.pushReplacementNamed(context, '/rootPage');
        });
      } catch (e) {
        setState(() {
          isShowLoading = true;
        });

        if (e is FirebaseAuthException &&
            (e.code == 'user-not-found' || e.code == 'wrong-password')) {
          Fluttertoast.showToast(
            msg: "Incorrect email or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }

        error.fire();

        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            isShowLoading = false;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final authFunction = AuthFunction(context);
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Email",
                style: TextStyle(
                  color: ColorConstants.pandaBlack,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty && passwordController.text.isEmpty) {
                      return "Please enter your email and password";
                    } else if (value.isEmpty) {
                      return "Please enter your email";
                    }
                    return null;
                  },
                  onSaved: (email) {},
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.email),
                      )),
                ),
              ),
              const Text(
                "Password",
                style: TextStyle(
                  color: ColorConstants.pandaBlack,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                child: TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty && emailController.text.isEmpty) {
                      return "Please enter your email and password";
                    } else if (value.isEmpty) {
                      return "Please enter your password";
                    }
                    return null;
                  },
                  onSaved: (password) {},
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(Icons.password),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 24),
                child: buildButton(
                  onPressed: () => signIn(context),
                  text: 'Sign in',
                  icon: Icons.login,
                  color: ColorConstants.pandaBlack,
                ),
              )
            ],
          ),
        ),
        isShowLoading
            ? CustomPositioned(
            child: RiveAnimation.asset(
              "assets/RiveAssets/check.riv",
              onInit: (artboard) {
                StateMachineController controller =
                _getRiveController(artboard);
                check = controller.findSMI("Check") as SMITrigger;
                error = controller.findSMI("Error") as SMITrigger;
                reset = controller.findSMI("Reset") as SMITrigger;
              },
            ))
            : const SizedBox(),
        isShowConfetti
            ? CustomPositioned(
            child: Transform.scale(
              scale: 6,
              child: RiveAnimation.asset(
                "assets/RiveAssets/confetti.riv",
                onInit: (artboard) {
                  StateMachineController controller =
                  _getRiveController(artboard);
                  confetti =
                  controller.findSMI("Trigger explosion") as SMITrigger;
                },
              ),
            ))
            : const SizedBox()
      ],
    );
  }
}

class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, required this.child, this.size = 100});
  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          Spacer(),
          SizedBox(
            height: size,
            width: size,
            child: child,
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
